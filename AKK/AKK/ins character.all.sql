use [ACT];
go

declare @datatype    varchar(128),
	   @description varchar(128),
        @xml         nvarchar(max),
        @uri         nvarchar(max),
	   @limit       nvarchar(max),
        @limit_i     int = 100,
	   @start       nvarchar(max),
	   @start_i     int = 0,
	   @show        nvarchar(max)

set @datatype = 'character.all';
SET @limit_i = 1000;
SET @start_i = (SELECT isnull(MAX(CAST(description AS int)) + @limit_i, 0) FROM dbo.Results WHERE (datatype = @datatype) AND (ID > 10));
set @description = concat('', @start_i);
SET @limit = concat('?c:limit=', @limit_i);
SET @start = concat('&c:start=', @start_i);
SET @show = concat('&c:show=', 'visible,dbid,ts,last_update,version,bio,displayname,crc,playedtime,id'
                 , ',ascension_list,type,tradeskills,locationdata.world,locationdata.worldid,name,account,guild');
--set @uri = 'http://census.daybreakgames.com/s:dragonsarmory/xml/get/eq2/character/?c:show=visible,dbid,ts,last_update,version,bio,displayname,crc,playedtime,id,stats,collections,resists,ascension_list,type,tradeskills,statistics,locationdata,name,account,guild&c:limit=100&c:start=' + @description;
set @uri = concat('http://census.daybreakgames.com', --'/s:dragonsarmory',
			   '/xml/get/eq2/character/', @limit, @start, @show);
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
      ,left([xml], 1024) xml
  FROM [ACT].[dbo].[Results]
  ORDER BY id desc

