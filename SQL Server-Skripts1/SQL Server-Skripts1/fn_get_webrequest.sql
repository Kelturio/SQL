CREATE FUNCTION dbo.fn_get_webrequest(
     @uri        nvarchar(max),
     @user       nvarchar(255)=NULL,
     @passwd     nvarchar(255)=NULL
)
RETURNS nvarchar(max)
AS EXTERNAL NAME [SQLCLRTEST].[Functions].[GET];

GO

CREATE FUNCTION dbo.fn_post_webrequest(
     @uri         nvarchar(max),
     @postdata    nvarchar(max),
     @user        nvarchar(255)=NULL,
     @passwd      nvarchar(255)=NULL
)
RETURNS nvarchar(max)
AS EXTERNAL NAME [SQLCLRTEST].[Functions].[POST];

GO