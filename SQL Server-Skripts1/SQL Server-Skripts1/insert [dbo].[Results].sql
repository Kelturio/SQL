use [ACT];
go

declare @datatype varchar(128);
declare @description varchar(128);
declare @xml nvarchar(max);
declare @uri nvarchar(max);

set @datatype = 'quest';
set @description = 'raw';
set @uri =
'http://census.daybreakgames.com/s:dragonsarmory/xml/get/eq2/quest/?c:limit=1000'
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


