declare @idoc int;
declare @xml nvarchar(max);

declare db_cursor cursor
for select top 1000 xml
      from dbo.Results
     where datatype = 'character.thurgadin';

open db_cursor;  
fetch next from db_cursor into @xml;

while @@FETCH_STATUS = 0
begin
    select @xml = right(@xml, (len(@xml) - 38));
    print left(@xml, 512);
	 --select @xml;

    exec sp_xml_preparedocument 
         @idoc output, @xml;

    with cte_character
         as (select *
                  , row_number() over(order by cast(getdate() as timestamp)) as sort
               from openxml(@idoc, '/character_list/character ', 1) 
			with(
				visible nvarchar(max) '@visible'
			,	dbid nvarchar(max) '@dbid'
			,	ts nvarchar(max) '@ts'
			,	last_update nvarchar(max) '@last_update'
			,	version nvarchar(max) '@version'
			,	bio nvarchar(max) '@bio'
			,	displayname nvarchar(max) '@displayname'
			,	crc nvarchar(max) '@crc'
			,	playedtime nvarchar(max) '@playedtime'
			,	id nvarchar(max) '@id'
			,	ascension_list nvarchar(max) 'ascension_list'
			,	[ascension.active.name] nvarchar(max) 'ascension_list/ascension[@active=1]/@name'
			,	[ascension.elementalist.active] nvarchar(max) 'ascension_list/ascension[@name=''elementalist'']/@active'
			,	[ascension.elementalist.xpfornextlevel] nvarchar(max) 'ascension_list/ascension[@name=''elementalist'']/@xpfornextlevel'
			,	[ascension.elementalist.name] nvarchar(max) 'ascension_list/ascension[@name=''elementalist'']/@name'
			,	[ascension.elementalist.currentxp] nvarchar(max) 'ascension_list/ascension[@name=''elementalist'']/@currentxp'
			,	[ascension.elementalist.level] nvarchar(max) 'ascension_list/ascension[@name=''elementalist'']/@level'
			,	[ascension.etherealist.active] nvarchar(max) 'ascension_list/ascension[@name=''etherealist'']/@active'
			,	[ascension.etherealist.xpfornextlevel] nvarchar(max) 'ascension_list/ascension[@name=''etherealist'']/@xpfornextlevel'
			,	[ascension.etherealist.name] nvarchar(max) 'ascension_list/ascension[@name=''etherealist'']/@name'
			,	[ascension.etherealist.currentxp] nvarchar(max) 'ascension_list/ascension[@name=''etherealist'']/@currentxp'
			,	[ascension.etherealist.level] nvarchar(max) 'ascension_list/ascension[@name=''etherealist'']/@level'
			,	[ascension.geomancer.active] nvarchar(max) 'ascension_list/ascension[@name=''geomancer'']/@active'
			,	[ascension.geomancer.xpfornextlevel] nvarchar(max) 'ascension_list/ascension[@name=''geomancer'']/@xpfornextlevel'
			,	[ascension.geomancer.name] nvarchar(max) 'ascension_list/ascension[@name=''geomancer'']/@name'
			,	[ascension.geomancer.currentxp] nvarchar(max) 'ascension_list/ascension[@name=''geomancer'']/@currentxp'
			,	[ascension.geomancer.level] nvarchar(max) 'ascension_list/ascension[@name=''geomancer'']/@level'
			,	[ascension.thaumaturgist.active] nvarchar(max) 'ascension_list/ascension[@name=''thaumaturgist'']/@active'
			,	[ascension.thaumaturgist.xpfornextlevel] nvarchar(max) 'ascension_list/ascension[@name=''thaumaturgist'']/@xpfornextlevel'
			,	[ascension.thaumaturgist.name] nvarchar(max) 'ascension_list/ascension[@name=''thaumaturgist'']/@name'
			,	[ascension.thaumaturgist.currentxp] nvarchar(max) 'ascension_list/ascension[@name=''thaumaturgist'']/@currentxp'
			,	[ascension.thaumaturgist.level] nvarchar(max) 'ascension_list/ascension[@name=''thaumaturgist'']/@level'
			,	[type.classid] nvarchar(max) 'type/@classid'
			,	[type.aa_level] nvarchar(max) 'type/@aa_level'
			,	[type.ts_level] nvarchar(max) 'type/@ts_level'
			,	[type.raceid] nvarchar(max) 'type/@raceid'
			,	[type.level] nvarchar(max) 'type/@level'
			,	[type.gender] nvarchar(max) 'type/@gender'
			,	[type.ts_class] nvarchar(max) 'type/@ts_class'
			,	[type.birthdate_utc] nvarchar(max) 'type/@birthdate_utc'
			,	[type.race] nvarchar(max) 'type/@race'
			,	[type.deity] nvarchar(max) 'type/@deity'
			,	[type.class] nvarchar(max) 'type/@class'
			,	[type.alignment] nvarchar(max) 'type/@alignment'
			,	[tradeskills.*.level] nvarchar(max) 'tradeskills[1]/*/@level'
			,	[locationdata.worldid] nvarchar(max) 'locationdata/@worldid'
			,	[locationdata.world] nvarchar(max) 'locationdata/@world'
			,	[name.prefix] nvarchar(max) 'name/@prefix'
			,	[name.first_lower] nvarchar(max) 'name/@first_lower'
			,	[name.last] nvarchar(max) 'name/@last'
			,	[name.suffix] nvarchar(max) 'name/@suffix'
			,	[name.first] nvarchar(max) 'name/@first'
			,	[account.age] nvarchar(max) 'account/@age'
			,	[account.link_id] nvarchar(max) 'account/@link_id'
			,	[guild.status] nvarchar(max) 'guild/@status'
			,	[guild.name] nvarchar(max) 'guild/@name'
			,	[guild.level] nvarchar(max) 'guild/@level'
			,	[guild.joined] nvarchar(max) 'guild/@joined'
			,	[guild.rank] nvarchar(max) 'guild/@rank'
			,	[guild.guildid] nvarchar(max) 'guild/@guildid'
			,	[guild.id] nvarchar(max) 'guild/@id'
				))

         INSERT INTO [dbo].[character.thurgadin]
           ([visible]
           ,[dbid]
           ,[ts]
           ,[last_update]
           ,[version]
           ,[bio]
           ,[displayname]
           ,[crc]
           ,[playedtime]
           ,[id]
           ,[ascension_list]
           ,[ascension.active.name]
           ,[ascension.elementalist.active]
           ,[ascension.elementalist.xpfornextlevel]
           ,[ascension.elementalist.name]
           ,[ascension.elementalist.currentxp]
           ,[ascension.elementalist.level]
           ,[ascension.etherealist.active]
           ,[ascension.etherealist.xpfornextlevel]
           ,[ascension.etherealist.name]
           ,[ascension.etherealist.currentxp]
           ,[ascension.etherealist.level]
           ,[ascension.geomancer.active]
           ,[ascension.geomancer.xpfornextlevel]
           ,[ascension.geomancer.name]
           ,[ascension.geomancer.currentxp]
           ,[ascension.geomancer.level]
           ,[ascension.thaumaturgist.active]
           ,[ascension.thaumaturgist.xpfornextlevel]
           ,[ascension.thaumaturgist.name]
           ,[ascension.thaumaturgist.currentxp]
           ,[ascension.thaumaturgist.level]
           ,[type.classid]
           ,[type.aa_level]
           ,[type.ts_level]
           ,[type.raceid]
           ,[type.level]
           ,[type.gender]
           ,[type.ts_class]
           ,[type.birthdate_utc]
           ,[type.race]
           ,[type.deity]
           ,[type.class]
           ,[type.alignment]
           ,[tradeskills.*.level]
           ,[locationdata.worldid]
           ,[locationdata.world]
           ,[name.prefix]
           ,[name.first_lower]
           ,[name.last]
           ,[name.suffix]
           ,[name.first]
           ,[account.age]
           ,[account.link_id]
           ,[guild.status]
           ,[guild.name]
           ,[guild.level]
           ,[guild.joined]
           ,[guild.rank]
           ,[guild.guildid]
           ,[guild.id]
           ,[sort]
           ,[RN]
		 )
         select *
              , row_number() over(order by cast(getdate() as timestamp)) as RN
		    --INTO dbo.[character.thurgadin]
           from cte_character;

    exec sp_xml_removedocument 
         @idoc;

    fetch next from db_cursor into @xml;
end; 

close db_cursor;  
deallocate db_cursor; 