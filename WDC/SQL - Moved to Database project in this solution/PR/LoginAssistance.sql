USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[loginAssistance]    Script Date: 25/05/2017 10:30:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

loginAssistance 'Password Reset Request'

*/

ALTER PROCEDURE [dbo].[loginAssistance] (
     @mode varchar(50),
     @actionreference varchar(50),
     @username varchar(50) = '',
     @emailaddress varchar(100) = '',
     @reference varchar(50),
     @entity_ctr int,
     @password varchar(50)

)
as
--Logging Start---------------------------
	declare @SQLLog_CTR bigint 
	insert into SQLLog (SQLID) values ('loginAssistance')
	SELECT @SQLLog_CTR = SCOPE_IDENTITY()
	
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'mode', 'Text', 'varchar(50)', @mode)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'actionreference', 'Text', 'varchar(50)', @actionreference)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'username', 'Text', 'varchar(50)', @username)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'emailaddress', 'Text', 'varchar(50)', @emailaddress)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'reference', 'Text', 'varchar(50)', @reference)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'entity_ctr', 'Number', 'int', @entity_ctr)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'password', 'Text', 'varchar(50)', 'Not Recorded')

--Logging End---------------------------

	if @mode = 'Get User Details' 
	begin
	
		select Entity_CTR, LastName, FirstName, UserName  from entity
		where passwordreset = @actionreference
		return 
	end
	

	if @mode = 'Update Password' 
	begin
	
		DECLARE @salt UNIQUEIDENTIFIER=NEWID()

		update Entity 
		set passwordreset = null, PasswordHash = HASHBYTES('SHA1', @password + CAST(@salt AS NVARCHAR(36))), salt = @salt 
		where entity_CTR = @entity_ctr
		select 'error' = '', 'message' = ''

		return 
	end
	
	if @mode = 'Password Reset Request' 
	begin
	
		update Entity set passwordreset = @actionreference 
		where Username = isnull(Nullif(@username,''),Username) and EmailAddress = isnull(Nullif(@emailaddress,''),emailaddress)
			
		select emailaddress, username, 'error' = '', 'message' = '' from Entity 
		where Username = isnull(Nullif(@username,''),Username) and EmailAddress = isnull(Nullif(@emailaddress,''),emailaddress)
		
		return 
	end
	
	if @mode = 'Send username' 
	begin
	

		

		
		
		return 
	end

	/*
	grant execute on loginAssistance to onlineservices
	*/