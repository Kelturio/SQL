declare @idoc int;
declare @xml nvarchar(max);

declare db_cursor cursor
for select top 1000 xml
      from dbo.Results
     where datatype = 'quest';

open db_cursor;  
fetch next from db_cursor into @xml;

while @@FETCH_STATUS = 0
begin
    print @xml;
    select @xml = right(@xml, (len(@xml) - 38));
	 --print @xml;
	 --select @xml;

    exec sp_xml_preparedocument 
         @idoc output, @xml;

    with cte_quest
         as (select *
                  , row_number() over(order by cast(getdate() as timestamp)) as sort
               from openxml(@idoc, '/quest_list/quest', 1) 
			with(category nvarchar(max) '@category'
			   , name nvarchar(max) '@name'
			   , level nvarchar(max) '@level'
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
			   , repeatable nvarchar(max) '@repeatable', id nvarchar(max) '@id'
			   ))

         insert into [dbo].[quest]
                                  ([category]
                                 , [name]
                                 , [level]
                                 , [scales_with_level]
                                 , [is_tradeskill]
                                 , [ts]
                                 , [last_update]
                                 , [crc]
                                 , [completion_text]
                                 , [shareable]
                                 , [starter_text]
                                 , [complete_shareable]
                                 , [tier]
                                 , [repeatable]
                                 , [id]
                                 , [sort]
                                 , [RN]
                                  )
         select *
              , row_number() over(order by cast(getdate() as timestamp)) as RN
           from cte_quest;

    exec sp_xml_removedocument 
         @idoc;

    fetch next from db_cursor into @xml;
end; 

close db_cursor;  
deallocate db_cursor; 