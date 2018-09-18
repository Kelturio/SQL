use [ACT];
go

declare @idoc int;
declare @xml nvarchar(max);
select top 1 @xml = xml
  from dbo.Results
 where datatype = 'quest'
       and description = '0';
select @xml = right(@xml, (len(@xml) - 38));
print @xml;
select @xml;

exec sp_xml_preparedocument 
     @idoc output, @xml;

with cte_quest
     as (select *
              , row_number() over(order by cast(getdate() as timestamp)) sort
           from openxml(@idoc, '/quest_list/quest', 1) 
		 with(category    nvarchar(max) '@category'
		    , name   nvarchar(max) '@name'
		    , level  nvarchar(max) '@level'
		    , scales_with_level nvarchar(max) '@scales_with_level'
		    , is_tradeskill nvarchar(max) '@is_tradeskill'
		    , ts nvarchar(max) '@ts'
		    , last_update nvarchar(max) '@last_update'
		    , crc nvarchar(max) '@crc'
		    , completion_text nvarchar(max) '@completion_text'
		    , shareable nvarchar(max) '@shareable'
		    , starter_text nvarchar(max) '@starter_text'
		    , complete_shareable nvarchar(max) '@complete_shareable'
		    , tier nvarchar(max) '@tier'
		    , repeatable nvarchar(max) '@repeatable'
		    , id nvarchar(max) '@id'
		    ))

     select *
	     , row_number() over(order by cast(getdate() as timestamp)) RN
       from cte_quest
     -- where PN = 1
     --order by name
     --       , sort;
		
exec sp_xml_removedocument 
     @idoc;




