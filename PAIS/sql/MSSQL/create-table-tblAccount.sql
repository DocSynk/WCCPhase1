USE PAIS;

GO

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].tblAccount')
	AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	BEGIN
		DROP TABLE tblAccount;
	END;

GO

CREATE TABLE dbo.tblAccount
(
	  intAccountID				INTEGER	IDENTITY(1,1)	NOT NULL
    , intPatientID				INTEGER					NOT NULL
	, intPracticeID				INTEGER					NOT NULL
	, vcMRN						VARCHAR(100)			NOT NULL
	, vcFirstName				VARCHAR(250)			NOT NULL
	, vcLastName				VARCHAR(250)			NOT NULL
	, vcCellPhone				VARCHAR(25)				NOT NULL
	, dtDOB						DATETIME				NOT NULL
	, vcGender					VARCHAR(100)			NOT NULL
	, vcInsuranceProvider		VARCHAR(250)			NOT NULL
	, dtLastLoggedInOn			DATETIME				NOT NULL
	
	
CONSTRAINT PK_tblAccount PRIMARY KEY CLUSTERED
(
	  intAccountID
)
) ON [PRIMARY]

GO


--dummy data

INSERT INTO
	tblAccount (
		intPatientID
	  , intPracticeID
	  , vcMRN
	  , vcFirstName
	  , vcLastName
	  , vcCellPhone
	  , dtDOB
	  , vcGender
	  , vcInsuranceProvider
	  , dtLastLoggedInOn
) VALUES (
	1
  , 1
  , 'M12345'
  , 'Greg'
  , 'House'
  , '9012345678'
  , '1950-01-01'
  , 'M'
  , 'Aetna'
  , '1970-01-01'
)