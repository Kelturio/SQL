USE ACT
GO

SELECT     TOP (10000) [type.class] AS category, COUNT(*) AS [column-1]
FROM         dbo.[character.thurgadin]
GROUP BY [type.class]
ORDER BY [column-1] DESC

GO

SELECT     TOP (10000) [type.class],(SELECT     TOP (10000) COUNT(*) AS count
FROM         dbo.[character.thurgadin]
WHERE     ([type.level] = 110)
ORDER BY count DESC), COUNT(*) AS count
FROM         dbo.[character.thurgadin]
WHERE     ([type.level] = 110)
GROUP BY [type.class]
ORDER BY count DESC

GO

SELECT     COUNT(DISTINCT PK) AS PK, COUNT(DISTINCT dbid) AS dbid, COUNT(DISTINCT displayname) AS displayname, COUNT(DISTINCT crc) AS crc, COUNT(DISTINCT id) 
                      AS id, COUNT(DISTINCT [type.birthdate_utc]) AS [type.birthdate_utc], COUNT(DISTINCT [account.link_id]) AS [account.link_id]
FROM         dbo.[character.thurgadin]

GO
SELECT     TOP (1000) dba.vbEncounterView.ID, dba.vbEncounterView.EncID, dba.vaZoneView.Zone, dba.vbEncounterView.Ally, dba.vbEncounterView.EncDPS_, 
                      dba.vbEncounterView.Name, dba.vbEncounterView.Damage_, dba.vbEncounterView.DamagePerc, dba.vbEncounterView.Healed_, dba.vbEncounterView.HealedPerc, 
                      dba.vbEncounterView.Duration, dba.vbEncounterView.Duration_, dba.vbEncounterView.DPS_, dba.vbEncounterView.EncHPS_, dba.vbEncounterView.MaxHit_s, 
                      dba.vbEncounterView.MaxHit_l
FROM         dba.vbEncounterView INNER JOIN
                      dba.vaZoneView ON dba.vbEncounterView.EncID = dba.vaZoneView.EncID
WHERE     (dba.vbEncounterView.Ally = 'T') AND (dba.vaZoneView.Zone = 'Plane of Disease: Infested Mesa [Duo]')
ORDER BY dba.vbEncounterView.Name, dba.vbEncounterView.ID

GO

SELECT     TOP (100) PERCENT [type.level], [type.class], [type.deity], COUNT(*) AS Expr1
FROM         dbo.[character.thurgadin]
WHERE     ([type.class] = N'Dirge') AND ([type.level] = 110)
GROUP BY [type.level], [type.class], [type.deity]
ORDER BY Expr1 DESC

GO

