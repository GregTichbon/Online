USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[Update_CC_Report]    Script Date: 20/06/2017 10:45:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Update_CC_Report] (
     @cc_report_ctr bigint = 0,
	 @CC_ReportRequirements_CTR bigint, 
	 @Highlights nvarchar(max) = null,
	 @Issues nvarchar(max) = null,
	 @links varchar(2000) = null,
     @finalised varchar(3) = null
)
as
--Logging Start---------------------------
	declare @SQLLog_CTR bigint 
	insert into SQLLog (SQLID) values ('Update_CC_Report')
	SELECT @SQLLog_CTR = SCOPE_IDENTITY()
	
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'cc_report_ctr', 'Number', 'bigint', @cc_report_ctr)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'CC_ReportRequirements_CTR', 'Number', 'bigint', @CC_ReportRequirements_CTR)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'Highlights', 'Text', 'nvarchar(max)', @Highlights)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'Issues', 'Text', 'nvarchar(max)', @Issues)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'links', 'Text', 'varchar(2000)', @links)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'finalised', 'Text', 'varchar(3)', @finalised)

--Logging End---------------------------

     declare @ctr bigint 
	   
     if @cc_report_ctr = 0
     begin
          insert into CC_Report (
               CC_ReportRequirements_CTR,
               Highlights,
               Issues,
			   links,
               finalised
   		 ) values (
               @CC_ReportRequirements_CTR,
               @Highlights,
               @Issues,
			   @Links,
               @finalised
          )
		  SELECT @ctr = SCOPE_IDENTITY()
     end
     else
     begin
         update CC_Report set
               Highlights = @Highlights,
               Issues = @Issues,
			   Links = @links,
               finalised = @finalised,
               ModifiedDate = GETDATE()
         where cc_report_ctr = @cc_report_ctr
         SELECT @ctr = @cc_report_ctr
     end
     select 'cc_report_ctr' = @ctr, 'validation' = '', 'validationinternal' = ''
