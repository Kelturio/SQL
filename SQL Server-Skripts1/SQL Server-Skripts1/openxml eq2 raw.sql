use [ACT];
go

declare @idoc int;
declare @xml nvarchar(max);
select top 1 @xml = xml
  from dbo.Results
 where datatype = 'eq2'
       and description = 'eq2';
select @xml = right(@xml, (len(@xml) - 38));
print @xml;
select @xml;

exec sp_xml_preparedocument 
     @idoc output, @xml;

with cte_datatype
     as (select *
              , 0 sort
           from openxml(@idoc, '/datatype_list/datatype', 1) 
		 with(name    nvarchar(max) '@name'
		    , count   nvarchar(max) '@count'
		    , hidden  nvarchar(max) '@hidden'
		    , resolve nvarchar(max) './resolve_list/resolve[1]/text()')),
     
	cte_resolve
     as (select *
              , row_number() over(order by cast(getdate() as timestamp)) sort
           from openxml(@idoc, '/datatype_list/datatype/resolve_list/resolve', 1) 
		 with(name    nvarchar(max) '../../@name'
		    , count   nvarchar(max) '../../@count'
		    , hidden  nvarchar(max) '../../@hidden'
		    , resolve nvarchar(max) 'text()')),

     cte_union
     as (
     select *
       from cte_datatype
     union
     select *
       from cte_resolve),
     
	cte_partition
     as (select *
              , row_number() over(partition by name
                                             , count
                                             , hidden
                                             , resolve order by sort) PN
           from cte_union)

     select row_number() over(order by cast(getdate() as timestamp)) RN
	     , name
          , count
          , hidden
          , resolve
       from cte_partition
      where PN = 1
     order by name
            , sort;
		



     

exec sp_xml_removedocument 
     @idoc;




