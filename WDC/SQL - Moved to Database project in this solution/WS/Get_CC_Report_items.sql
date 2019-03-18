USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[Get_CC_Report_items]    Script Date: 19/06/2017 1:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

[Get_CC_Report_items] 2

*/

ALTER PROCEDURE [dbo].[Get_CC_Report_items] (
     @CC_ReportRequirements_CTR INT
)
as
--Logging Start---------------------------
	declare @SQLLog_CTR bigint 
	insert into SQLLog (SQLID) values ('Get_CC_Report')
	SELECT @SQLLog_CTR = SCOPE_IDENTITY()
	
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'CC_ReportRequirements_CTR', 'Number', 'int', @CC_ReportRequirements_CTR)

--Logging End---------------------------

	select RG.Prompt as GroupPrompt, RG.Help as GroupHelp, RI.CC_Report_Item_CTR, RI.Prompt, RI.Response, RI.[TYPE], RI.[Parameters], RI.Help
	from CC_Report_Item RI
	inner join CC_ReportGroup RG on RG.CC_ReportGroup_CTR = RI.CC_ReportGroup_CTR
	where RI.CC_ReportRequirements_CTR = @CC_ReportRequirements_CTR 
	order by RG.Sequence, RG.Prompt, RI.Sequence, RI.Prompt
