--   P&R

USE [proTest]
GO
CREATE USER [onlineservices] FOR LOGIN [OnlineServices] WITH DEFAULT_SCHEMA=[dbo]
GO

Grant EXECUTE on usrEventOperationExecute_One to onlineservices
Grant EXECUTE on sysPreserveID to onlineservices
Grant EXECUTE on sysUserContextSet to onlineservices
Grant INSERT on RAMAPPLICATIONPROCESS to onlineservices
Grant INSERT on RAMPROCESSCATEGORY to onlineservices
Grant INSERT on TBATT_ATTCHMTS_CTL to onlineservices
Grant SELECT on NUCASSOCIATIONCONTROL to onlineservices
Grant SELECT on NUCEVENTPROCESS to onlineservices
Grant SELECT on RAMCATEGORY to onlineservices
Grant SELECT on TBATT_ATTCHMTS_CTL to onlineservices
grant EXECUTE on sysRetrieveID to onlineservices
grant SELECT on RAMGROUPTOASSOC to onlineservices
Grant INSERT on TBATT_ATTCHMTS_DTL to onlineservices
grant insert on nucassociation to onlineservices
Grant SELECT on TBATT_ATTCHMTS_DTL to onlineservices
Grant SELECT on NUCEVENTCONTROL to onlineservices
Grant insert on NUCEVENT to onlineservices
grant execute on ramClock to onlineservices
Grant SELECT on RAMAPPLICATIONPROCESS to onlineservices
Grant SELECT on RAMCATEGORYCONTROL to onlineservices	
Grant SELECT on NUCCHARGE to onlineservices	
Grant SELECT on NUCCHARGECONTROLAMOUNT to onlineservices	
Grant SELECT on NUCCHARGECONTROL to onlineservices	
Grant SELECT on NUCNAME to onlineservices
Grant SELECT on NUCADDRESS to onlineservices
Grant SELECT on NUCASSOCIATION to onlineservices
Grant SELECT on NUCSTREET to onlineservices
grant execute on nucPropLegalDesc to onlineservices
Grant SELECT on NUCPROPERTY to onlineservices
grant execute on ratPropertyValues to onlineservices
grant execute on usrnucPropRateableLandArea to onlineservices
grant execute on nucScratchPad_GetID to onlineservices
grant select on NUCSCRATCHPAD to onlineservices
grant delete on NUCSCRATCHPAD to onlineservices
grant select on nucdescriptor to onlineservices




--Application / Registrations etc

grant execute on Update_HealthPremiseRegistrationXML to onlineservices



--Community Contracts    WS


grant execute on cc_login to onlineservices
grant execute on get_cc_groupdetails to onlineservices
grant execute on get_cc_application to onlineservices
grant execute on get_cc_allapplications to onlineservices
grant execute on update_cc_application to onlineservices 
grant execute on update_cc_groupdetails to onlineservices 
grant execute on validate_cc_groupreference to onlineservices 
grant execute on cc_username_check to onlineservices
grant execute on Update_CC_Users to onlineservices
grant execute on CC_loginAssistance to onlineservices
grant execute on CC_ApplicationList to onlineservices
grant execute on cc_emailaddress_check to onlineservices
grant execute on CC_ApplicationReview to onlineservices
grant execute on get_CC_Report to onlineservices
grant execute on update_CC_Report to onlineservices
grant execute on update_CC_Report to onlineservices
grant execute on CC_Get_groups to onlineservices


--War Memorial Centre   WS
grant execute on Get_WMC_Venues to onlineservices
grant execute on Update_WMC_BookingEnquiry to onlineservices
grant execute on Update_WMC_Booking to onlineservices
grant execute on Update_WMC_Feedback to onlineservices

--Facilities WS
grant execute on Update_VenueFeedbackXML to onlineservices

--Entity   WS
grant execute on update_entity to onlineserviceschek
grant execute on login to onlineservices
grant execute on loginAssistance to onlineservices
grant execute on get_entity to onlineservices
--grant execute on emailaddress_check to onlineservices
--grant execute on username_check to onlineservices
grant execute on usernameemailaddress_check to onlineservices
grant execute on Add_Entity_Log to onlineservices
 
--   Other

grant execute on get_definitions to onlineservices
grant execute on clear_bank_branch to onlineservices
grant execute on add_bank_branch to onlineservices
grant execute on Get_Response_Items to onlineservices
