USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[Get_Entity]    Script Date: 18/04/2017 11:54:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

Get_Entity null, 1

*/

ALTER PROCEDURE [dbo].[Get_Entity] (
	@reference varchar(50) = null,
	@entity_ctr int = null
)
as
	if @reference is not null
	begin
		select top 1 entity_ctr, reference, Username, LastName, FirstName, othernames, KnownAs, EmailAddress, ResidentialAddress, PostalAddress, MobilePhone, HomePhone, WorkPhone, Gender, convert(varchar(20),dateofbirth,106) as [dateofbirth] from entity where reference = @reference 
	end else
	begin
		select top 1 entity_ctr, reference, Username, LastName, FirstName, othernames, KnownAs, EmailAddress, ResidentialAddress, PostalAddress, MobilePhone, HomePhone, WorkPhone, Gender, convert(varchar(20),dateofbirth,106) as [dateofbirth] from entity where entity_ctr = @entity_ctr 
	end


/*
grant execute on Get_Entity to onlineservices
*/


