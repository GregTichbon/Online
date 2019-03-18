USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[Update_CC_Report]    Script Date: 23/06/2017 11:01:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_CC_Report_Item] (
     @cc_Report_item_ctr bigint,
	 @response nvarchar(max)
)
as

--Logging Start---------------------------
	declare @SQLLog_CTR bigint 
	insert into SQLLog (SQLID) values ('Update_CC_Report_Item')
	SELECT @SQLLog_CTR = SCOPE_IDENTITY()
	
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'cc_Report_item_ctr', 'Number', 'bigint', @cc_Report_item_ctr)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'response', 'Text', 'nvarchar(max)', @response)

--Logging End---------------------------

	update CC_Report_Item
	set response = @response
	where CC_Report_Item_CTR = @cc_Report_item_ctr

    select'validation' = '', 'validationinternal' = ''


/*
grant execute on [Update_CC_Report_Item] to onlineservices
*/	
