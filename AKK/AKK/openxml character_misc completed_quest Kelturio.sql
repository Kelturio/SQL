use [ACT];
GO

declare @idoc int;
declare @xml nvarchar(max);
set @xml = (SELECT top(1) [xml] from [ACT].[dbo].[Results] where datatype = 'character_misc' AND description = 'Kelturio');
select @xml = right(@xml, (len(@xml) - 38));
print @xml;
select @xml;

exec sp_xml_preparedocument @idoc output, @xml;

select *
    --INTO dbo.completed_quest
  from openxml(@idoc, '/character_misc_list/character_misc/completed_quest_list/completed_quest', 1)
  with(crc bigint '@crc'
     , completion_date varchar(50) '@completion_date')

exec sp_xml_removedocument @idoc;





