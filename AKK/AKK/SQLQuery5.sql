SELECT     TOP (100) PERCENT [type.class], [ascension.active.name], COUNT(*) AS total
FROM         dbo.[character.thurgadin]
WHERE     ([type.class] = N'Dirge') AND ([ascension.active.name] IS NOT NULL)
GROUP BY [ascension.active.name], [type.class]
ORDER BY total DESC

go

SELECT     TOP (1000) dba.vbEncounterView.Name, dba.vbEncounterView.Duration, dba.vbEncounterView.Damage, dba.vbEncounterView.Damage_, 
                      dba.vbEncounterView.DamagePerc, dba.vbEncounterView.PowerReplenish, dba.vbEncounterView.DPS_, dba.vbEncounterView.EncDPS, 
                      dba.vbEncounterView.EncDPS_, dba.vbEncounterView.CritHits, dba.vbEncounterView.Blocked, dba.vbEncounterView.Misses, dba.vbEncounterView.Swings, 
                      dba.vbEncounterView.HealsTaken, dba.vbEncounterView.DamageTaken, dba.vbEncounterView.DamageTaken_, dba.vbEncounterView.MaxHit_s, 
                      dba.vbEncounterView.MaxHit_l, dba.vbEncounterView.DPS, dbo.[character.thurgadin].bio, dbo.[character.thurgadin].displayname, dbo.[character.thurgadin].playedtime, 
                      dbo.[character.thurgadin].id, dbo.[character.thurgadin].[ascension.active.name], dbo.[character.thurgadin].[type.deity], dbo.[character.thurgadin].[type.class], 
                      dbo.[character.thurgadin].[name.prefix], dbo.[character.thurgadin].[name.first], dbo.[character.thurgadin].[name.last], dbo.[character.thurgadin].[name.suffix], 
                      dbo.[character.thurgadin].[account.age], dbo.[character.thurgadin].[guild.name]
FROM         dba.vbEncounterView INNER JOIN
                      dbo.[character.thurgadin] ON dba.vbEncounterView.Name = dbo.[character.thurgadin].[name.first]
WHERE     (dba.vbEncounterView.EncID =
                          (SELECT     TOP (1) EncID
                            FROM          dbo.encounter_table
                            ORDER BY ID DESC))
ORDER BY dba.vbEncounterView.DamagePerc DESC

GO




































