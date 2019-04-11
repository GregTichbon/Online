USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[SQLLogQuery]    Script Date: 7/08/2017 12:37:01 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*

SQLLogQuery null,'NZPostAddressSearch'

*/

ALTER PROCEDURE [dbo].[SQLLogQuery]
	@sqllog_ctr bigint = null,
	@sqlID varchar(100) = null,
	@fromdate varchar(11) = null,
	@todate varchar(11) = null
as

	select 'Params:  sqllog_ctr (int), sqlid (varchar), fromdate, todate' as 'Help'

	declare @sql as varchar(2000)
	
	if isnull(@fromdate ,'') = '' 
		set @fromdate = cast(getdate() as varchar(11))
		
	if isnull(@todate ,'') = '' 
		set @todate = cast(getdate() as varchar(11))

	
	set @sql = 
	
		'select L.SQLLog_ctr, L.SQLID, L.DateTime, L.ErrorMessage, L.Information, P.ParamName, P.ParamDefinition, 
		case when p.ParamType = ''Text'' then p.TextVal when p.ParamType = ''Number'' then cast(p.NumberVal as varchar(1000)) else ''Invalid Type'' end,
		case when p.ParamType = ''Text'' then len(p.TextVal) else ''0'' end as ''Length''
		 from SQLLog L
		left outer join SQLLogParam P on P.SQLLog_CTR = L.SQLLog_CTR
		where datetime between ''' + @fromdate + ''' and ''' + @todate + '  23:59:59'''
	
	if isnull(@sqlID ,'') <> ''
		set @sql = @sql + ' and L.SQLID = ''' + @sqlID + ''''
		
	if isnull(@sqllog_ctr ,0) <> 0
		set @sql = @sql + ' and L.sqllog_ctr = ' + cast(@sqllog_ctr as varchar(20))
		
	set @sql = @sql + ' order by L.SQLLog_CTR, P.SQLLogParam_CTR'

	--select @sql
	
	exec (@sql)
