USE PAIS;

GO

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].tblMissedAppointmentType')
	AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	BEGIN
		DROP TABLE tblMissedAppointmentType;
	END;

GO

CREATE TABLE dbo.tblMissedAppointmentType
(
	  intMissedAppointmentTypeID	INTEGER	IDENTITY(1,1)	NOT NULL
	, vcReason						VARCHAR(200)			NOT NULL
	, dtCreatedOn					DATETIME				NOT NULL
	, intCreatedBy					INTEGER					NOT NULL
	, dtModifiedOn					DATETIME				NOT NULL
	, intModifiedBy					INTEGER					NOT NULL
	
	
CONSTRAINT PK_tblMissedAppointmentType PRIMARY KEY CLUSTERED
(
	  intMissedAppointmentTypeID	
)
) ON [PRIMARY]

GO

--initial setup

INSERT INTO
	dbo.tblMissedAppointmentType (
		vcReason
	  , dtCreatedOn
	  , intCreatedBy
	  , dtModifiedOn
	  , intModifiedBy
	) VALUES (
		'Cancelled'
	  , GETDATE()
	  , 0
	  , '1970-01-01 00:00:00.000'
	  , 0
	), (
		'Patient Availability'
	  , GETDATE()
	  , 0
	  , '1970-01-01 00:00:00.000'
	  , 0
	), (
		'No Show'
	  , GETDATE()
	  , 0
	  , '1970-01-01 00:00:00.000'
	  , 0
	), (
		'Transportation'
	  , GETDATE()
	  , 0
	  , '1970-01-01 00:00:00.000'
	  , 0
	), (
		'Same Day Cancelled'
	  , GETDATE()
	  , 0
	  , '1970-01-01 00:00:00.000'
	  , 0
	), (
		'Loss of Income'
	  , GETDATE()
	  , 0
	  , '1970-01-01 00:00:00.000'
	  , 0
	), (
		'Patient Decision'
	  , GETDATE()
	  , 0
	  , '1970-01-01 00:00:00.000'
	  , 0
	), (
		'Missing'
	  , GETDATE()
	  , 0
	  , '1970-01-01 00:00:00.000'
	  , 0
	), (
		'Unknown'
	  , GETDATE()
	  , 0
	  , '1970-01-01 00:00:00.000'
	  , 0
	), (
		'Other'
	  , GETDATE()
	  , 0
	  , '1970-01-01 00:00:00.000'
	  , 0
	);

GO
	
