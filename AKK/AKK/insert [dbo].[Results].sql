use [ACT];
go

declare @datatype varchar(128);
declare @description varchar(128);
declare @xml nvarchar(max);
declare @uri nvarchar(max);

set @datatype = 'character.all';
set @description = '0';
set @uri =
'http://census.daybreakgames.com/s:dragonsarmory/xml/get/eq2/character/?c:show=visible,dbid,ts,last_update,version,bio,displayname,crc,playedtime,id,ascension_list,type,tradeskills,locationdata.world,locationdata.worldid,name,account,guild&c:limit=4000&c:start=0'
;
set @xml = dbo.fn_get_webrequest(@uri, default, default);

insert into [dbo].[Results]
                           ([datatype]
				      , [description]
                          , [uri]
                          , [xml]
                           )
values(@datatype, @description, @uri, @xml);
go


