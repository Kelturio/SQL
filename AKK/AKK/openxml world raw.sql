use [ACT];
GO

declare @idoc int;
declare @xml nvarchar(max);
set @xml = (select top(1) [xml] from [ACT].[dbo].[Results] where [datatype] = 'world' and [description] = 'world');
select @xml = right(@xml, (len(@xml) - 38));
print @xml;
select @xml;

exec sp_xml_preparedocument @idoc output, @xml;

select *
  from openxml(@idoc, '/world_list/world', 1)
  with(status varchar(128) '@status'
     , name varchar(128) '@name'
	, language varchar(128) '@language'
	, ts varchar(128) '@ts'
	, last_update varchar(128) '@last_update'
	, name_lower varchar(128) '@name_lower'
	, id varchar(128) '@id')

exec sp_xml_removedocument @idoc;




