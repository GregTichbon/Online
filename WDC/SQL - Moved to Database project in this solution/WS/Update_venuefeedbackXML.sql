--WS
USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[Update_VenueFeedbackXML]    Script Date: 4/04/2017 9:28:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Update_VenueFeedbackXML 'Reference'
*/

ALTER PROCEDURE [dbo].[Update_VenueFeedbackXML] (
	@Module_CTR bigint = 0,
	@Reference varchar(50),
	@xml xml
) as

--Logging Start---------------------------
declare @SQLLog_CTR bigint
insert into SQLLog (SQLID) values ('Update_VenueFeedbackXML')
SELECT @SQLLog_CTR = SCOPE_IDENTITY()
insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'Module_CTR', 'Number', 'bigint', @Module_CTR)
insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'Reference', 'Text', 'varchar(50)', @Reference)
--insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'xml', 'Text', 'xml', @xml)
--Logging End---------------------------
declare @ctr bigint

if @Module_ctr = 0
begin
	insert into VenueFeedback (
	Reference,
	[xml]
	) values (
@Reference,
@xml
)	
SELECT @ctr = SCOPE_IDENTITY()
end
else
begin
update VenueFeedback set
Reference = @Reference,
ModifiedDate = GETDATE()
where VenueFeedback_CTR = @Module_ctr
SELECT @ctr = @Module_ctr
end
	
	


	select 'ctr' = @ctr

ExitSP:	
/*

grant execute on Update_VenueFeedbackXML to onlineservices

*/
	
	



