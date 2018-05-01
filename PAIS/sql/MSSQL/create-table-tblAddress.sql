USE PAIS;

GO

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].tblAddress')
	AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	BEGIN
		DROP TABLE tblAddress;
	END;

GO

CREATE TABLE dbo.tblAddress
(
	  intAddressID				INTEGER	IDENTITY(1,1)	NOT NULL
    , intAccountID				INTEGER					NOT NULL
	, vcAddressType				VARCHAR(250)			NOT NULL
	, vcAddress1				VARCHAR(250)			NOT NULL
	, vcAddress2				VARCHAR(250)			NOT NULL
	, vcCity					VARCHAR(250)			NOT NULL
	, vcState					VARCHAR(100)			NOT NULL
	, vcPostalCode				VARCHAR(10)				NOT NULL
	, vcCountry					VARCHAR(250)			NOT NULL
	, dtCreatedOn				DATETIME				NOT NULL
	, intCreatedBy				INTEGER					NOT NULL
	, dtModifiedOn				DATETIME				NOT NULL
	, intModifiedBy				INTEGER					NOT NULL
	
CONSTRAINT PK_tblAddress PRIMARY KEY CLUSTERED
(
	  intAddressID
)
) ON [PRIMARY]

GO

--dummy data
INSERT INTO
	dbo.tblAddress (
		intAccountID
	  , vcAddressType
	  , vcAddress1
	  , vcAddress2
	  , vcCity
	  , vcState
	  , vcPostalCode
	  , vcCountry
	  , dtCreatedOn
	  , intCreatedBy
	  , dtModifiedOn
	  , intModifiedBy
	) VALUES (
		1
	  , 'HOME'
	  , '123 Fake St.'
	  , ''
	  , 'Memphis'
	  , 'TN'
	  , '12345'
	  , 'US'
	  , GETDATE()
	  , 1
	  , '1970-01-01 00:00:00.000'
	  , 0
	)