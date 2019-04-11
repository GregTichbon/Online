USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[SQLLogRebuidSP]    Script Date: 09/29/2016 10:42:02 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/*

SQLLogRebuidSP 149

*/

ALTER PROCEDURE [dbo].[SQLLogRebuidSP]
	@sqllog_ctr bigint
as

	declare @sqlid as varchar(100)
	declare @sql as varchar(2000) = char(10)
	declare @ParamName varchar(50)
	declare @ParamType varchar(50) 
	declare @ParamDefinition varchar(50)
	declare @TextVal varchar(8000) 
	declare @NumberVal decimal(18,4)
	declare @XMLVal	xml
	declare @var varchar(8000)
	declare @delim varchar(2) = ''
	
	select @sqlid = sqlid from SQLLog where SQLLog_CTR = @sqllog_ctr 
	
	declare params insensitive cursor for	
		select ParamName, ParamType, ParamDefinition, TextVal, NumberVal, XMLVal from SQLLogParam
		where SQLLog_CTR = @sqllog_ctr 
		order by SQLLogParam_CTR 

	open params
	
	fetch next from params into @ParamName, @ParamType, @ParamDefinition, @TextVal, @NumberVal, @XMLVal			
	while (@@fetch_status <> -1) 
	begin
		if @ParamType = 'Text' 
		begin
			if @textval is null
				set @var = 'NULL'
			else
				set @var = '''' + @textval + ''''
		end
		else if @ParamType = 'XML'
		begin
			if @xmlval is null
				set @var = 'NULL'
			else
				set @var = '''' + CAST(@XMLVal AS VARCHAR(max)) + ''''		
		end
		else if @ParamType = 'Number'
		begin
			if @NumberVal is null
				set @var = 'NULL'
			else		
				if @ParamDefinition = 'int'
					set @var = cast(@NumberVal as int)	
				else if @ParamDefinition = 'bigint'			
					set @var = cast(@NumberVal as int)	
		end
		else
			set @var = 'Unknown: ' + @ParamType
			
		set @sql = @sql + @delim + @var
		set @delim = ', '

		fetch next from params into @ParamName, @ParamType, @ParamDefinition, @TextVal, @NumberVal, @XMLVal					
	end
	close params
	deallocate params	
	
	set @sql = @sqlid + ' ' + @sql
	
	select @sql




