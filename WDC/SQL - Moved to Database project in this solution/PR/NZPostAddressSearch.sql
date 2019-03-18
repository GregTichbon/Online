USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[NZPostAddressSearch]    Script Date: 31/08/2017 1:09:46 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/*

NZPostAddressSearch '30 totara wanganui'

*/

CREATE PROCEDURE [dbo].[NZPostAddressSearch]
	@search varchar(200) = ''
as

--Logging Start---------------------------
	declare @SQLLog_CTR bigint 
	insert into SQLLog (SQLID) values ('NZPostAddressSearch')
	SELECT @SQLLog_CTR = SCOPE_IDENTITY()
	
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'search', 'Text', 'varchar(200)', @search) 
--Logging End---------------------------

	declare @searchcriteria as varchar(500)
	declare @delim as varchar(5)
	declare @word as varchar(20)
	declare @sql as varchar(2000)
	
	
	set @searchcriteria = ''
	set @delim = ''

	set @search = dbo.funTidyDelimiters(@search,' ')
	set @search = REPLACE(@search,'''','''''')
	
	
	declare words insensitive cursor for	
		SELECT Data
		FROM dbo.funSplit(@search, ' ')
	open words
	
	fetch next from words into @word					
	while (@@fetch_status <> -1) 
	begin
		set @searchcriteria = @searchcriteria + @delim + ' '' '' + search_line like ''% ' + @word + '%'''
		set @delim = ' and '
		fetch next from words into @word					
	end
	close words
	deallocate words	
	
	set @sql = 
	
	'select top 20 
		search_line
		from postalCodes.dbo.Delivery_Addresses 
		where '
		+ @searchcriteria 
		+ ' order by case TOWN_CITY_MAILTOWN when ''Wanganui'' then 0 when ''Whanganui'' then 0 else 1 end, SEARCH_LINE'
		
		--select @sql
	
	exec (@sql)
	/*
	Grant EXECUTE on NZPostAddressSearch to onlineservices
	USE [postalCodes]
	grant SELECT on Delivery_Addresses to onlineservices
	*/
