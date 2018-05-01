USE PAIS;

GO

IF EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].tblAuthenticationAttempts')
	AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
	BEGIN
		DROP TABLE tblAuthenticationAttempts;
	END;

GO

CREATE TABLE dbo.tblAuthenticationAttempts
(
	  intAttemptID		    BIGINT		IDENTITY(1,1)	NOT NULL
	, vcHttpHost            VARCHAR(2048)               NOT NULL
	, vcUsername		    VARCHAR(200)				NOT NULL
    , btWasSuccessful       BIT                     	NOT NULL
	, intAccountID			INTEGER						NOT NULL
    , dtAttemptedOn	        DATETIME					NOT NULL
	, vcAttemptedIP	        VARCHAR(50)					NOT NULL
	, vcUserAgent	        VARCHAR(2000)   			NOT NULL



CONSTRAINT PK_tblAuthenticationAttempts PRIMARY KEY CLUSTERED
(
	  intAttemptID
)
) ON [PRIMARY]

GO