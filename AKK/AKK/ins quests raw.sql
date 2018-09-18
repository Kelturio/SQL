use [ACT];
go

declare @datatype varchar(128);
declare @description varchar(128);
declare @xml nvarchar(max);
declare @uri nvarchar(max);



set @datatype = 'quest';
set @description = '' + (SELECT     MAX(CAST(description AS int)) AS Expr1
FROM         dbo.Results
WHERE     (datatype = 'quest')) + 100;
set @uri = 'http://census.daybreakgames.com/s:dragonsarmory/xml/get/eq2/quest/?c:limit=100&c:start=' + @description;
PRINT @uri
set @xml = dbo.fn_get_webrequest(@uri, default, default);

insert into [dbo].[Results]
                           ([datatype]
				      , [description]
                          , [uri]
                          , [xml]
                           )
values(@datatype, @description, @uri, @xml);
go
SELECT TOP (1) [ID]
      ,[datatype]
      ,[description]
      ,[uri]
	 ,len(xml) len
      ,[xml]
  FROM [ACT].[dbo].[Results]
  ORDER BY id desc

