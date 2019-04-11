USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[Get_CC_Report]    Script Date: 15/06/2017 11:55:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*

CC_Get_groups 

*/

ALTER PROCEDURE [dbo].[CC_Get_groups] 
as
--Logging Start---------------------------
	declare @SQLLog_CTR bigint 
	insert into SQLLog (SQLID) values ('CC_Get_groups')
	SELECT @SQLLog_CTR = SCOPE_IDENTITY()
	
--Logging End---------------------------


select G.legalname, g.grouptype, g.phonenumber, g.emailaddress, g.facebook, g.website, U.username
from CC_GroupDetails G
inner join CC_Users U on U.CC_Users_CTR = G.cc_users_ctr
order by G.legalname

/*
grant execute on CC_Get_groups to onlineservices
*/

