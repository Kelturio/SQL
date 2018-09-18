use ACT;
go

declare @count_all float;
declare @count_lvl110 float; 

select @count_all = count(*)
  from dbo.[character.thurgadin];

select @count_lvl110 = count(*)
  from dbo.[character.thurgadin]
 where([type.level] = 110);

print @count_lvl110;

with cte_1
     as (select [type.class] as                          Class
              , count(*) as                              C
              , round(count(*) / @count_all * 100, 2) as [C%]
           from dbo.[character.thurgadin]
          group by [type.class]),
     cte_2
     as (select [type.class] as                             Class
              , count(*) as                                 C110
              , round(count(*) / @count_lvl110 * 100, 2) as [C110%]
           from dbo.[character.thurgadin]
          where([type.level] = 110)
          group by [type.class])
     select c1.Class
          , c1.C
          , rank() over(order by c1.C desc) as CR
          , c1.[C%]
          , c2.C110
		, rank() over(order by c2.[C110] desc) as C110R
          , c2.[C110%]
          , c2.[C110%] - c1.[C%] as            [?%]
		, rank() over(order by c1.C desc) - rank() over(order by c2.[C110] desc) [?R]
       from cte_1 as c1
            inner join cte_2 as c2
       on c1.Class = c2.Class
     order by rank() over(order by c1.C desc) - rank() over(order by c2.[C110] desc) desc


