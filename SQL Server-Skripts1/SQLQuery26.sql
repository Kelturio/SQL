use [ACT];
go

declare @name nvarchar(max);
declare @xml nvarchar(max);
declare @uri nvarchar(max);

set @name = 'EQ2 Characters with over 6,500 quests completed';
set @uri =
'http://census.daybreakgames.com/xml/get/eq2/character/?quests.complete=]6500&c:show=displayname,quests&c:limit=50'
;
set @xml = dbo.fn_get_webrequest(@uri, default, default);

insert into [dbo].[Results]
                           ([name]
                          , [uri]
                          , [xml]
                           )
values(@name, @uri, @xml);
go


