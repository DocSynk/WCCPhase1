USE PAIS;

GO

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].tblDashboardLogin')
	AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	BEGIN
		DROP TABLE tblDashboardLogin;
	END;

GO

CREATE TABLE dbo.tblDashboardLogin
(
	  intDashboardLoginID		INTEGER	IDENTITY(1,1)	NOT NULL
	, vcFirstName				VARCHAR(250)			NOT NULL
	, vcLastName				VARCHAR(250)			NOT NULL
	, vcEmail					VARCHAR(2048)			NOT NULL
	, vcPassword				VARCHAR(512)			NOT NULL
	, isLoginCapable			BIT				  		NOT NULL
    , dtPasswordLastSetOn       DATETIME            	NOT NULL
    , intPasswordLastSetBy      INT                 	NOT NULL
    , vcPasswordLastSetByIP     VARCHAR(50)         	NOT NULL
	, dtLastLoggedInOn			DATETIME				NOT NULL
	
	
CONSTRAINT PK_tblDashboardLogin PRIMARY KEY CLUSTERED
(
	  intDashboardLoginID
)
) ON [PRIMARY]

GO
