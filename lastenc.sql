DECLARE @lastencid CHAR(8)
SET @lastencid = (SELECT TOP (1) encid FROM [ACT].[dbo].[encounter_table] order by id desc)
PRINT @lastencid
SELECT TOP (1000) * FROM [ACT].[dbo].[encounter_table] where encid = @lastencid
SELECT TOP (1000) * FROM [ACT].[dbo].[combatant_table] where encid = @lastencid
SELECT TOP (1000) * FROM [ACT].[dbo].[damagetype_table] where encid = @lastencid
SELECT TOP (1000) * FROM [ACT].[dbo].[attacktype_table] where encid = @lastencid
SELECT TOP (1000) * FROM [ACT].[dbo].[swing_table] where encid = @lastencid


