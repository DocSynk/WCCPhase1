USE PAIS;

GO

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].tblAppointment')
	AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	BEGIN
		DROP TABLE tblAppointment;
	END;

GO

CREATE TABLE dbo.tblAppointment
(
	  intAppointmentID			INTEGER	IDENTITY(1,1)			NOT NULL
	, intAccountID				INTEGER							NOT NULL
	, intPracticeID				INTEGER							NOT NULL
	, dtApptDate				DATETIME						NOT NULL
	, dtApptTime				TIME							NOT NULL
	, btIsAvailable				BIT								NOT NULL DEFAULT(0)
	, intPatientID				INTEGER							NOT NULL DEFAULT(0)
	, vcFNameDoctor				VARCHAR(250)					NOT NULL
	, vcLNameDoctor				VARCHAR(250)					NOT NULL
	, dtModifiedOn				DATETIME						NOT NULL
	, intModifiedBy				INTEGER							NOT NULL
	
	
CONSTRAINT PK_tblAppointment PRIMARY KEY CLUSTERED
(
	  intAppointmentID
)
) ON [PRIMARY]

GO

IF EXISTS ( SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].tblAppointment') AND name = N'tblAppointment_IDX0')
	BEGIN
		DROP INDEX tblAppointment_IDX0 ON tblAppointment;
	END

	CREATE NONCLUSTERED INDEX tblAppointment_IDX0 ON tblAppointment
	(
		intAccountID
	)
	INCLUDE
	(
		intAppointmentID
	)

GO

--dummy data
INSERT INTO tblAppointment
(
	  intAccountID
	, intPracticeID
	, dtApptDate
	, dtApptTime
	, btIsAvailable
	, intPatientID
	, vcFNameDoctor
	, vcLNameDoctor
	, dtModifiedOn
	, intModifiedBy
)
VALUES
(
	  2
	, 1
	, CONVERT(DateTime, DATEDIFF(DAY, 0, GETDATE() + 1))
	, '12:00:00.000'
	, 0
	, 1
	, 'Michaela'
	, 'Quinn'
	, GETDATE()
	, 1
)