USE PAIS;

GO

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].tblAuditLog')
	AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	BEGIN
		DROP TABLE tblAuditLog;
	END;

GO

CREATE TABLE dbo.tblAuditLog
(
	  intAuditLogID					INTEGER	IDENTITY(1,1)	NOT NULL
	, dtTS							DATETIME				NOT NULL
	, vcAction						VARCHAR(250)			NOT NULL
	, vcCategory					VARCHAR(250)			NOT NULL
	, vcSubcategory					VARCHAR(250)			NOT NULL
	, vcData						VARCHAR(MAX)			NOT NULL
	, vcIPAddress					VARCHAR(50)				NOT NULL
	, vcUserAgent					VARCHAR(2000)			NOT NULL
	, vcLatitude					VARCHAR(100)			NOT NULL
	, vcLongitude					VARCHAR(100)			NOT NULL
	, intAppointmentID				INTEGER					NOT NULL
	, intAccountID					INTEGER					NOT NULL
	, intAddressID					INTEGER					NOT NULL
	, intMissedAppointmentTypeID	INTEGER					NOT NULL
	, btTransportArranged			BIT						NOT NULL
	, dtCreatedOn					DATETIME				NOT NULL
	, intCreatedBy					INTEGER					NOT NULL
	
	
CONSTRAINT PK_tblAuditLog PRIMARY KEY CLUSTERED
(
	  intAuditLogID	
)
) ON [PRIMARY]

GO


--update for dashboard login

ALTER TABLE
	dbo.tblAuditLog
ADD 
	intDashboardLoginID		INTEGER		NOT NULL DEFAULT(0)

GO