--PR
USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[UpDate_Entity]    Script Date: 18/04/2017 12:20:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UpDate_Entity] (
	@Entity_CTR bigint = 0,
	@Reference varchar(50),
	@UserName nvarchar(50),
	@LastName varchar(50),
	@FirstName varchar(50),
	@OtherNames varchar(100),
	@KnownAs varchar(50),
	@EmailAddress varchar(100),
	@ResidentialAddress varchar(500),
	@PostalAddress varchar(500),
	@MobilePhone varchar(20),
	@HomePhone varchar(20),
	@WorkPhone varchar(20),
	@Gender varchar(10),
	@DateofBirth varchar(11), --date,
	@Password varchar(50)

)


as
--Logging Start---------------------------
	declare @SQLLog_CTR bigint 
	insert into SQLLog (SQLID) values ('UpDate_Entity')
	SELECT @SQLLog_CTR = SCOPE_IDENTITY()
	
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'Entity_CTR', 'Text', 'bigint', @Entity_CTR)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'Reference', 'Text', 'varchar(50)', @Reference)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'UserName', 'Text', 'nvarchar(50)', @UserName)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'LastName', 'Text', 'varchar(50)', @LastName)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'OtherNames', 'Text', 'varchar(100)', @OtherNames)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'KnownAs', 'Text', 'varchar(50)', @KnownAs)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'EmailAddress', 'Text', 'varchar(100)', @EmailAddress)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'ResidentialAddress', 'Text', 'varchar(500)', @ResidentialAddress)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'PostalAddress', 'Text', 'varchar(500)', @PostalAddress)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'MobilePhone', 'Text', 'varchar(20)', @MobilePhone)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'HomePhone', 'Text', 'varchar(20)', @HomePhone)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'WorkPhone', 'Text', 'varchar(20)', @WorkPhone)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'Gender', 'Text', 'varchar(10)', @Gender)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'DateofBirth', 'Text', 'varchar(11)', @DateofBirth)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'password', 'Text', 'varchar(50)', '')

--Logging End---------------------------



	declare @ctr bigint
	DECLARE @salt UNIQUEIDENTIFIER=NEWID()

	if @Entity_CTR = 0 
	begin
	
		insert into Entity (
			Reference,
			UserName,
			LastName,
			FirstName,
			OtherNames,
			KnownAs,
			EmailAddress,
			ResidentialAddress,
			PostalAddress,
			MobilePhone,
			HomePhone,
			WorkPhone,
			Gender,
			DateofBirth,		
			PasswordHash,
            salt
			
		) values (
			@Reference,
			@UserName,
			@LastName,
			@FirstName,
			@OtherNames,
			@KnownAs,
			@EmailAddress,
			@ResidentialAddress,
			@PostalAddress,
			@MobilePhone,
			@HomePhone,
			@WorkPhone,
			@Gender,
			CONVERT(date, @DateofBirth),
           HASHBYTES('SHA1', @password + CAST(@salt AS NVARCHAR(36))),
           @salt	
           	)
		
		SELECT @ctr = SCOPE_IDENTITY()
		
	end
	else
	begin
		update Entity set 
			UserName = @UserName,
			LastName = @LastName,
			FirstName= @FirstName,
			OtherNames= @OtherNames,
			KnownAs = @KnownAs,
			EmailAddress = @EmailAddress,
			ResidentialAddress = @ResidentialAddress,
			PostalAddress = @PostalAddress,
			MobilePhone = @MobilePhone,
			HomePhone = @HomePhone,
			WorkPhone = @WorkPhone,
			Gender = @Gender,
			DateofBirth = CONVERT(date, @DateofBirth),
			ModifiedDate = GETDATE()
			where Entity_CTR = @Entity_CTR

		if isnull(@password,'') <> '' 
		begin
			update Entity set 
 
			PasswordHash = HASHBYTES('SHA1', @password + CAST(@salt AS NVARCHAR(36))),
			salt = @salt
			where Entity_CTR = @Entity_CTR	
		end		

	
	
		SELECT @ctr = @Entity_CTR
	end
	
	select @ctr 
	
	/*
grant execute on Update_Entity to onlineservices
*/
	

