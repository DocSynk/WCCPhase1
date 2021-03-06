USE [PAIS]
GO
/****** Object:  StoredProcedure [dbo].[dashboard_add_user]    Script Date: 4/4/2017 12:44:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[dashboard_add_user]
	@firstName varchar(50),
	@lastName varchar(50),
	@emailId varchar(50),
	@password varchar(200)
AS
BEGIN
	
	DECLARE @userCount int
	DECLARE @result int

	SET @result = 0

	SELECT @userCount = COUNT(*) FROM tblDashboardLogin
	WHERE vcEmail = @emailId

	IF (@userCount = 0) 
	 BEGIN
			SET @result = 1
	 		INSERT INTO PAIS.dbo.tblDashboardLogin
				   ([vcFirstName]
				   ,[vcLastName]
				   ,[vcEmail]
				   ,[vcPassword]
				   ,[isLoginCapable]
				   ,[dtPasswordLastSetOn]
				   ,[intPasswordLastSetBy]
				   ,[vcPasswordLastSetByIP]
				   ,[dtLastLoggedInOn])
			 VALUES
				   (@firstName,
				   @lastName,
				   @emailId,
				   @password,
				   1,
				   GETDATE(),
				   0,
				   '',
				   GETDATE())
	 END
	
	 SELECT @result
END




GO
/****** Object:  StoredProcedure [dbo].[dashboard_get_activity_history]    Script Date: 4/4/2017 12:44:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[dashboard_get_activity_history]
	 @fromDate DateTime,
	 @toDate DateTime,
	 @patientId int = NULL
AS
BEGIN
	SET NOCOUNT ON;

	;WITH dateRange AS
	(
	  SELECT dt = DATEADD(dd, 1, DATEADD(dd, -1, @fromDate))
	  WHERE DATEADD(dd, 1, @fromDate) <= @toDate
	  UNION ALL
	  SELECT DATEADD(dd, 1, dt)
	  FROM dateRange
	  WHERE DATEADD(dd, 1, dt) <= @toDate
	)

	SELECT 
		CAST(dtr.dt AS DATE) AS CreatedOn,
		ISNULL(al.TotalOpen, 0) AS TotalOpen,
		ISNULL(al.TotalSent, 0) AS TotalSent
	FROM dateRange dtr
	LEFT OUTER JOIN
	(
		SELECT 
			CAST(alog.dtCreatedOn AS DATE) AS CreatedOn,
			SUM(case alog.vcAction when 'LOGIN' then 1 else 0 end) AS TotalOpen, 
			SUM(case alog.vcAction when 'MESSAGE' then 1 else 0 end)  AS TotalSent
		FROM PAIS.dbo.tblAuditLog alog
		WHERE
			alog.dtCreatedOn BETWEEN @fromDate AND @toDate
			AND alog.intAccountID = ISNULL(@patientId, alog.intAccountID)
			AND
			( (alog.vcAction = 'LOGIN' AND alog.vcCategory = 'SUCCESS') OR
			(alog.vcAction = 'MESSAGE' AND alog.vcCategory = 'APPOINTMENT'))
		GROUP BY CAST(alog.dtCreatedOn AS DATE)
	)al
	ON dtr.dt = al.CreatedOn
END




GO
/****** Object:  StoredProcedure [dbo].[dashboard_get_appointment_delays]    Script Date: 4/4/2017 12:44:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[dashboard_get_appointment_delays]
	 @fromDate DateTime,
	 @toDate DateTime,
	 @delayType nvarchar(50) = NULL,
	 @patientId int = NULL
AS
BEGIN
	declare @tmp_AppTimes 
		table(
		mrn nvarchar(max),
		startdate datetime,
		enddate datetime,
		days_delay int,
		all_status nvarchar(max))

	
	DECLARE @mrn nvarchar(200) = NULL

	IF(@patientId IS NOT NULL) 
	BEGIN
		SELECT @mrn = vcMrn  FROM PAIS.dbo.tblAccount WHERE intAccountID = @patientId
	END

	insert into @tmp_AppTimes(mrn, startdate,enddate, days_delay)
	select t.MRN, 
	min(t.startdate) startdate, t.EndDate, DATEDIFF(day, min(t.startdate), t.enddate) as [delay]
	from
	(select w.MRN, cast(w.app_datetime as datetime) startdate, e.app_Datetime as enddate
	from WestSchedule.dbo.wc_hum_schedules_30days w
	outer apply(select top 1 mrn, app_Datetime from WestSchedule.dbo.wc_hum_schedules_30days e 
	where e.mrn=w.mrn and e.app_datetime > w.app_datetime and e.status_abrv in ('E', ' C', 'F', 'FC', 'SC')
	order by e.app_datetime) e
	where w.status_abrv not in ('E', ' C', 'F', 'FC', 'SC')
	and w.app_datetime between @fromDate AND @toDate
	and w.mrn = ISNULL(@mrn, w.mrn)
	) t
	where t.EndDate is not null
	group by t.mrn, t.EndDate



	update t set
	t.all_status=STUFF(
	(SELECT  distinct ', ' + sch.status_abrv from WestSchedule.dbo.wc_hum_schedules_30days sch
	where t.mrn = sch.mrn and sch.status_abrv is not null
	and sch.app_datetime between t.startDate and	t.enddate
	FOR XML PATH ('')), 1, 2, '') 
	from @tmp_AppTimes t

	
	;WITH dateRange AS
	(
	  SELECT dt = DATEADD(dd, 1, DATEADD(dd, -1, @fromDate))
	  WHERE DATEADD(dd, 1, @fromDate) <= @toDate
	  UNION ALL
	  SELECT DATEADD(dd, 1, dt)
	  FROM dateRange
	  WHERE DATEADD(dd, 1, dt) <= @toDate
	)	
	SELECT 
		dtr.dt AS CreatedOn,
		ISNULL(aptdel.[Count], 0) as TotalDelays
	FROM dateRange dtr
	LEFT OUTER JOIN
	(
		select cast(StartDate as date) [Date], count(mrn) [Count]
		from @tmp_AppTimes
		where days_delay > 0 and all_status like isnull(@delayType, all_status) 
		group by cast(StartDate as date)
	)aptdel
	ON dtr.dt = aptdel.[Date]
END



GO
/****** Object:  StoredProcedure [dbo].[dashboard_get_appt_cancel_and_noshows]    Script Date: 4/4/2017 12:44:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================
-- Author:		<Author,,Name>
-- Create date: 24-Feb-2017
-- Description:	Get Appointment Cancellations and NoShows
-- ======================================================
CREATE PROCEDURE [dbo].[dashboard_get_appt_cancel_and_noshows] 
	 @fromDate DateTime,
	 @toDate DateTime,
	 @patientId int = NULL
AS
BEGIN
	
	SET NOCOUNT ON;

	;WITH dateRange AS
	(
	  SELECT dt = DATEADD(dd, 1, DATEADD(dd, -1, @fromDate))
	  WHERE DATEADD(dd, 1, @fromDate) <= @toDate
	  UNION ALL
	  SELECT DATEADD(dd, 1, dt)
	  FROM dateRange
	  WHERE DATEADD(dd, 1, dt) <= @toDate
	)

	SELECT 
		CAST(dtr.dt AS DATE) AS CreatedOn,
		ISNULL(al.NoShows, 0) AS NoShows,
		ISNULL(al.Cancelled, 0) AS Cancelled
	FROM dateRange dtr
	LEFT OUTER JOIN
	(
		SELECT 
			CAST(sch.app_datetime AS DATE) AS CreatedOn,
			COUNT(case when sch.status_abrv = 'N'  then 1 end) As NoShows,
			COUNT(case when sch.status_abrv = 'X'  then 1 end) As Cancelled
		FROM WestSchedule.dbo.wc_hum_schedules_30days sch INNER JOIN PAIS.dbo.tblAccount acct
		ON sch.mrn = acct.vcMRN
		WHERE
			CAST(sch.app_datetime AS DATE) BETWEEN @fromDate AND @toDate
			AND (sch.status_abrv IN ('N','X')) 
			AND acct.intAccountID = ISNULL(@patientId, acct.intAccountID)
		GROUP BY CAST(sch.app_datetime AS DATE)
	)al
	ON dtr.dt = al.CreatedOn
END




GO
/****** Object:  StoredProcedure [dbo].[dashboard_get_cab_requests]    Script Date: 4/4/2017 12:44:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: 03-march-2017
-- Description:	Get Cab Requests
-- =============================================
CREATE PROCEDURE [dbo].[dashboard_get_cab_requests]
	 @fromDate DateTime,
	 @toDate DateTime,
	 @patientId int = NULL
AS
BEGIN
	
    SET NOCOUNT ON;

	;WITH dateRange AS
	(
	  SELECT dt = DATEADD(dd, 1, DATEADD(dd, -1, @fromDate))
	  WHERE DATEADD(dd, 1, @fromDate) <= @toDate
	  UNION ALL
	  SELECT DATEADD(dd, 1, dt)
	  FROM dateRange
	  WHERE DATEADD(dd, 1, dt) <= @toDate
	)

		
	SELECT 
		dtr.dt AS CreatedOn,
		ISNULL(al.TotalRequests, 0) as TotalRequests
	FROM dateRange dtr
	LEFT OUTER JOIN
	(
		SELECT 
			CAST(alog.dtCreatedOn AS DATE) AS CreatedOn,
			SUM(CASE alog.btTransportArranged WHEN 0 THEN 0 ELSE 1 END) AS TotalRequests
		FROM PAIS.dbo.tblAuditLog alog 
		WHERE
			alog.dtCreatedOn BETWEEN  @fromDate AND  @toDate
			AND alog.intAccountID = ISNULL(@patientId, alog.intAccountID)
			AND btTransportArranged = 1
		GROUP BY CAST(alog.dtCreatedOn AS DATE), alog.btTransportArranged
	)al
	ON dtr.dt = al.CreatedOn
  
END




GO
/****** Object:  StoredProcedure [dbo].[dashboard_get_location_history]    Script Date: 4/4/2017 12:44:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[dashboard_get_location_history]
	@patientId int = NULL
AS
BEGIN
	SET NOCOUNT ON;

	
	SELECT	addr.vcAddressType AS LocationType,
		SUM(case when alog.vcAction = 'LOGIN' AND alog.vcCategory = 'SUCCESS' THEN 1 ELSE 0 END) AS TotalOpen, 
		SUM(case when alog.vcAction = 'MESSAGE' AND alog.vcCategory = 'APPOINTMENT' THEN 1 ELSE 0 END)  AS TotalSent  
	FROM
	(
		SELECT intAddressID, vcAddressType 
		FROM PAIS.dbo.tblAddress
		UNION 
		SELECT CAST(0 AS int), 'Other' 
    
	) addr
	LEFT OUTER JOIN (
								SELECT * 
								FROM PAIS.dbo.tblAuditLog alog  
								WHERE 
									--alog.dtCreatedOn BETWEEN @fromDate AND @toDate 
									--AND 
									alog.intAccountID = ISNULL(NULL, alog.intAccountID)
					)alog
	ON addr.intAddressID = alog.intAddressID
	GROUP BY addr.vcAddressType
END




GO
/****** Object:  StoredProcedure [dbo].[dashboard_get_patients]    Script Date: 4/4/2017 12:44:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[dashboard_get_patients]
AS
BEGIN
	SET NOCOUNT ON;

	-- GET All patients participating in the Study
    SELECT * FROM PAIS.dbo.tblAccount

END

GO
/****** Object:  StoredProcedure [dbo].[dashboard_get_user_details]    Script Date: 4/4/2017 12:44:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[dashboard_get_user_details]
	@email varchar(50),
	@password varchar(200)
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT * FROM PAIS.dbo.tblDashboardLogin 
	WHERE 
		vcEmail = @email AND vcPassword = @password
	AND
		isLoginCapable = 1


END




GO
