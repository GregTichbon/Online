USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[Update_WMC_BookingEnquiry]    Script Date: 05/05/2017 08:56:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Update_WMC_BookingEnquiry] (
	@booking_ctr bigint,
	@entity_ctr bigint = 0,
	@reference varchar(50),
 
	@applicant varchar(100),
	@organisation varchar(100),
	@charityregistration varchar(20),
	@emailaddress varchar(100),
	@postaladdress varchar(500),
	@invoiceaddress varchar(500),
	@mobilephone varchar(20),
	@homephone varchar(20),
	@workphone varchar(20),
	@datefrom varchar(20),
	@dateto varchar(20),
	@eventtype varchar(50),
	@description varchar(500),
	@overallnumbers varchar(100),
	@fullcomplex varchar(3),
	@main varchar(3),
	@pioneer varchar(3),
	@concert varchar(3),
	@kitchen varchar(3),
	@otherinformation varchar(500) 


)
as
--Logging Start---------------------------

	declare @SQLLog_CTR bigint 
	insert into SQLLog (SQLID) values ('Update_WMC_Booking')
	SELECT @SQLLog_CTR = SCOPE_IDENTITY()
	
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'booking_ctr', 'Number', 'bigint', @booking_ctr)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'Entity_CTR', 'Number', 'bigint', @Entity_CTR)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'Reference', 'Text', 'varchar(50)', @Reference)

	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'applicant', 'Text', 'varchar(100)', @applicant)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'organisation', 'Text', 'varchar(100)', @organisation)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'charityregistration', 'Text', 'varchar(20)', @charityregistration)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'emailaddress', 'Text', 'varchar(100)', @emailaddress)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'postaladdress', 'Text', 'varchar(500)', @postaladdress)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'invoiceaddress', 'Text', 'varchar(500)', @invoiceaddress)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'mobilephone', 'Text', 'varchar(20)', @mobilephone)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'homephone', 'Text', 'varchar(20)', @homephone)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'workphone', 'Text', 'varchar(20)', @workphone)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'datefrom', 'Text', 'varchar(20)', @datefrom)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'dateto', 'Text', 'varchar(20)', @dateto)	
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'eventtype', 'Text', 'varchar(50)', @eventtype)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'description', 'Text', 'varchar(500)', @description)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'overallnumbers', 'Text', 'varchar(100)', @overallnumbers)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'fullcomplex', 'Text', 'varchar(3)', @fullcomplex)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'main', 'Text', 'varchar(3)', @main)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'pioneer', 'Text', 'varchar(3)', @pioneer)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'concert', 'Text', 'varchar(3)', @concert)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'kitchen', 'Text', 'varchar(3)', @kitchen)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'otherinformation', 'Text', 'varchar(500)', @otherinformation)


--Logging End---------------------------
     declare @ctr bigint  
     
     if @booking_ctr = 0
     begin
          insert into WMC_Bookings (
			entity_ctr,
			reference,
			applicant,
			organisation,
			charityregistration,
			emailaddress,
			postaladdress,
			invoiceaddress,
			mobilephone,
			homephone,
			workphone,
			eventtype,
			description,
			overallnumbers,
			fullcomplex,
			main,
			pioneer,
			concert,
			kitchen,
			datefrom,
			dateto,
			otherinformation
   		 ) values (
			@entity_ctr,
			@reference,
			@applicant,
			@organisation,
			@charityregistration,
			@emailaddress,
			@postaladdress,
			@invoiceaddress,
			@mobilephone,
			@homephone,
			@workphone,
			@eventtype,
			@description,
			@overallnumbers,
			@fullcomplex,
			@main,
			@pioneer,
			@concert,
			@kitchen,
			@datefrom,
			@dateto,			
			@otherinformation
          )
          SELECT @ctr = SCOPE_IDENTITY()
     end
     else
     begin
         update WMC_Bookings set
				entity_ctr = @entity_ctr,
				reference = @reference,
				applicant = @applicant,
				organisation = @organisation,
				charityregistration = @charityregistration,
				emailaddress = @emailaddress,
				postaladdress = @postaladdress,
				invoiceaddress = @invoiceaddress,
				mobilephone = @mobilephone,
				homephone = @homephone,
				workphone = @workphone,
				datefrom = @datefrom,
				dateto = @dateto,
				eventtype = @eventtype,
				description = @description,
				overallnumbers = @overallnumbers,
				fullcomplex = @fullcomplex,
				main = @main,
				pioneer = @pioneer,
				concert = @concert,
				kitchen = @kitchen,
				otherinformation = @otherinformation,
                ModifiedDate = GETDATE()
         where booking_ctr = @booking_ctr
         SELECT @ctr = @booking_ctr
     end
     select @ctr, 'validation' = '', 'validationinternal' = ''