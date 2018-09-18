USE [ACT]
GO

SELECT [ID]
      ,[datatype]
      ,[description]
      ,[uri]
	 ,left(xml, 512)
      --,[xml]
      --,[DBInsDate]
      --,[DBUpdDate]
      --,[TS]
      --,[GRID]
  FROM [dbo].[Results]
  where id > 159
  ORDER BY id DESC
GO

--delete from [dbo].[Results] where id >= 390


