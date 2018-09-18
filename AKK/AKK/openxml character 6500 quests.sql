use [ACT];
GO

declare @idoc int;
declare @xml nvarchar(max);
set @xml = (select TOP(1) [xml] from [ACT].[dbo].[Results] where datatype = 'character' AND [description] = 'Chars with over 6,500 quests completed');
select @xml = right(@xml, (len(@xml) - 38));
print @xml;
select @xml;

exec sp_xml_preparedocument @idoc output, @xml;

select *
  from openxml(@idoc, '/character_list/character', 1)
  with(id bigint '@id'
     , displayname varchar(50) '@displayname'
	, active int './quests/@active'
	, complete int './quests/@complete')
ORDER BY complete desc;

exec sp_xml_removedocument @idoc;




