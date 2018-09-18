DECLARE @lastencid CHAR(8)
SET @lastencid = (SELECT TOP (1) encid FROM [ACT].[dbo].[encounter_table] order by id desc)
PRINT @lastencid
DELETE FROM [ACT].[dbo].[encounter_table] where encid = @lastencid
DELETE FROM [ACT].[dbo].[combatant_table] where encid = @lastencid
DELETE FROM [ACT].[dbo].[damagetype_table] where encid = @lastencid
DELETE FROM [ACT].[dbo].[attacktype_table] where encid = @lastencid
DELETE FROM [ACT].[dbo].[swing_table] where encid = @lastencid