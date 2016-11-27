USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[Get_Food_Gradings]    Script Date: 03/16/2016 12:24:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO	
/*
Get_WMC_Calendar 'xxxx', 'zzzz'

*/
ALTER PROCEDURE [dbo].[Get_WMC_Calendar]
	@start as varchar(50),
	@end as varchar(50),
	@mode as varchar(20) = null
as 
SET NOCOUNT ON


	select 'title' = 'My Test', 'start' = '2016-01-01', 'end' = ''
	
	
