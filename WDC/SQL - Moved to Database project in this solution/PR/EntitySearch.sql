	--PR
	USE [OnlineApplications]
	GO
	/****** Object:  StoredProcedure [dbo].[loginAssistance]    Script Date: 04/07/2017 11:58:59 ******/
	SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
	/*

	EntitySearch 'name', 'Greg Tich'

	*/

	ALTER PROCEDURE [dbo].[EntitySearch] (
		 @mode varchar(50),
		 @search varchar(100)
	)
	as
	--Logging Start---------------------------
		declare @SQLLog_CTR bigint 
		insert into SQLLog (SQLID) values ('EntitySearch')
		SELECT @SQLLog_CTR = SCOPE_IDENTITY()
	
		insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'mode', 'Text', 'varchar(50)', @mode)
		insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'search', 'Text', 'varchar(100)', @search)

	--Logging End---------------------------
	

		if @mode = 'name' 
		begin

			declare @criteria varchar(2000) = ''
			declare @delim varchar(5) = ''
			declare @word as varchar(20)

			set @search = dbo.funTidyDelimiters(@search,' ')
			set @search = REPLACE(@search,'''','''''')

			declare words insensitive cursor for	
				SELECT Data
				FROM dbo.funSplit(@search, ' ')
			open words
	
			fetch next from words into @word					
			while (@@fetch_status <> -1) 
			begin
				set @criteria = @criteria + @delim + '(lastname like ''%' + @word + '%'' or firstname like ''%' + @word + '%'' or othernames like ''%' + @word + '%'' or knownas like ''%' + @word + '%'')'
				set @delim = ' and '
				fetch next from words into @word					
			end
			close words
			deallocate words	

	
			set @criteria = 'select firstname
			+ CASE WHEN isnull(othernames,'''') != '''' THEN '' '' + othernames else '''' END
			+ CASE WHEN isnull(knownas,'''') != '''' THEN '' ('' + knownas + '')'' else '''' END
			+ '' '' + lastname as [Name],
			Entity_CTR, Reference, ResidentialAddress, knownas, othernames
			from entity where ' + @criteria

			--select @criteria
			exec(@criteria)
		
			return 
		end

	/*	
		select firstname    
		+ CASE WHEN isnull(othernames,'') != '' THEN ' ' + othernames else '' END    
		+ CASE WHEN isnull(knownas,'') != '' THEN ' (' + knownas + ')' else '' END    
		+ ' ' + lastname as [Name],    Entity_CTR, Reference, ResidentialAddress, knownas, othernames    
		from entity where (
			lastname like '%Greg%' or firstname like '%Greg%' or othernames like '%Greg%' or knownas like '%Greg%'
		) and 
		(
			lastname like '%Tich%' or firstname like '%Tich%' or othernames like '%Tich%' or knownas like '%Tich%'
		)
	*/

	/*
	grant execute on EntitySearch to onlineservices
	*/
