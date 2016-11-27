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


	select
		'type' = 'event', 
		'start' = '2016-03-11', 
		'end' = '2016-03-12',
		'allday' = 'False',
        'status' = 'status',
		'expires' = 'expires',
		'title' = 'My Test 2', 
		'description' = 'description',
		'notes' = 'notes',
        'publicdescription' = 'publicdescription',
		'url' = 'http://www.google.com'

		union

	select
		'type' = 'day', 
		'start' = '2016-03-13', 
		'end' = '2016-03-14',
		'allday' = 'True',
        'status' = 'Unavailable',
		'expires' = 'expires',
		'title' = '', 
		'description' = 'description',
		'notes' = 'notes',
        'publicdescription' = 'publicdescription',
		'url' = 'http://www.google.com'	
	
