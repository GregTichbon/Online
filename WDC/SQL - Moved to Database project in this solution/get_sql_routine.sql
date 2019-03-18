USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[get_sql_routine]    Script Date: 05/25/2017 13:32:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

get_sql_routine 'get_sql_routine'

*/

ALTER PROCEDURE [dbo].[get_sql_routine] (
     @routinename varchar(50)
)
as
	declare @sql varchar(200) = 'SELECT OBJECT_DEFINITION (OBJECT_ID(N''OnlineApplications.dbo.' + @routinename + '''))'
	exec (@sql)
	


