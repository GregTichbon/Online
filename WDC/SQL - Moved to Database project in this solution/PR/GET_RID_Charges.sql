USE [OnlineApplications]
GO
/****** Object:  StoredProcedure [dbo].[GET_RID_Charges]    Script Date: 28/04/2017 9:22:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/*

EXEC [GET_RID_Charges] 66780, 1, '01-July-2016'
EXEC [GET_RID_Charges] 66780, 1, '01-July-2017', 50

EXEC [GET_RID_Charges] 2710, null 

EXEC [GET_RID_Charges] 2710, 0

EXEC [GET_RID_Charges] 2710, 1

*/

ALTER PROCEDURE [dbo].[GET_RID_Charges]
	@prop_no as int,
	@showamounts as int = 1,
	@year as varchar(20),
	@run_ctr as int = 0

AS
BEGIN
	SET NOCOUNT ON;

--Logging Start---------------------------
	declare @SQLLog_CTR bigint 
	insert into SQLLog (SQLID) values ('GET_RID_Charges')
	SELECT @SQLLog_CTR = SCOPE_IDENTITY()
	
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'prop_no', 'Number', 'int', @prop_no)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'showamounts', 'Number', 'int', @showamounts)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, TextVal) values (@SQLLog_CTR, 'year', 'Text', 'varchar(20)', @year)
	insert into SQLLogParam (SQLLog_CTR, ParamName, ParamType, ParamDefinition, NumberVal) values (@SQLLog_CTR, 'run_ctr', 'Number', 'int', @run_ctr)

--Logging End---------------------------

	declare @duedateplan varchar(10)
	
	declare @scratchid int

/*
	declare @valbasedate datetime
	declare @attval1 float
	declare @attval2 float
	declare @attval3 float
	declare @attval4 float
	declare @attval5 float
	declare @attval6 float
	declare @attval7 float
	declare @attval8 float
	declare @attval9 float
	declare @attval10 float

	declare @nextvaldate datetime
	declare @nextvalbasedate datetime
	declare @nextattval1 float
	declare @nextattval3 float
	declare @newvaluation varchar(255)
*/
	declare @chrg varchar(10)
	declare @valdate datetime
	declare @val float		

	declare @nocharges bit
	declare @yearhead varchar(500)
	declare @nextyearhead varchar(500)
	declare @nextyearflag bit

	declare @charge_type varchar(10)
	declare @charge_description varchar(100)
	declare @method varchar(20) 
	declare @units int
	declare @rate varchar(20)
	declare @amount money
	--declare @date varchar(11)
	declare @sortorder int


	declare @charges table (
		charge_type varchar(10), 
		charge_description varchar(100),
		method varchar(20), 
		units int, 
		rate varchar(20), 
		amount money,
		sortorder int
	)

	--set @date = cast(@year as datetime)
	/*
	if @nextyear = 1
	begin
		select @date = pdate from OnlineApplications.dbo.parameter (Nolock) where pname = 'RID_NextYear'
		select @run_ctr = pint from OnlineApplications.dbo.parameter (Nolock) where pname = 'RID_NextYearRun_ctr'		
		select @showamounts = pint from OnlineApplications.dbo.parameter (Nolock) where pname = 'RID_NextYearShowAmounts'
	end else
	begin
		select @date = pdate from OnlineApplications.dbo.parameter (Nolock) where pname = 'RID_Year'
		select @run_ctr = pint from OnlineApplications.dbo.parameter (Nolock) where pname = 'RID_Run_ctr'		
		select @showamounts = pint from OnlineApplications.dbo.parameter (Nolock) where pname = 'RID_ShowAmounts'
	end			
	*/
	exec proprod.dbo.nucScratchPad_GetID @scratchid output, 0

	/*
	exec proprod.dbo.ratPropertyValues @prop_no, @date, @valbasedate output, @valdate output,
	@attval1 output, @attval2 output, @attval3 output, @attval4 output, @attval5 output,
	@attval6 output, @attval7 output, @attval8 output, @attval9 output, @attval10 output
	
	exec proprod.dbo.ratPropertyValues @prop_no, '31-December-2099', @nextvalbasedate output, @nextvaldate output,
	@nextattval1 output, @attval2 output, @nextattval3 output, @attval4 output, @attval5 output,
	@attval6 output, @attval7 output, @attval8 output, @attval9 output, @attval10 output
*/	
/*
	if @nextyear is not null
	begin 
		set @nextyearhead = 'The Rating Information Database contains a record of all information required for setting and assessing rates and allows for the calculation of rates liability for each rating unit.//nThe information below contains valuation changes since ' + convert(varchar(11),@nextvalbasedate,106) + '. If the property has had major development or subdivision resulting in a revaluation, that information will also be shown.'
	end else
	begin
		set @yearhead = 'The information below contains valuation changes since ' + convert(varchar(11),@valbasedate,106) + '. If the property has had major development or subdivision resulting in a revaluation, that information will also be shown.'
	end
			
	
	if @nextvaldate > isnull(@valdate,'1-Jan-1900')
		set @newvaluation = 'Revaluation of Wanganui District.//nThe revised rating values are as at ' + convert(varchar(11),@nextvalbasedate,106) + '. The effective date for rating purposes is ' + convert(varchar(11),@nextvaldate,106) + '.'
	else 
		set @newvaluation = ''
*/
	
	if ISNULL(@run_ctr,0) <> 0
	begin
		insert into @charges
			select C.CHARGE_TYPE, CC.DESCRIPTION, D1.DESCRIPTION, C.QUANTITY, C.CHARGE_COMMENT, C.AMOUNT,  D2.value1
			from proprod.dbo.nucChargeRun C
			inner join proprod.dbo.NUCCHARGECONTROL CC on CC.CHARGE_TYPE = C.CHARGE_TYPE and CC.APPLICATION_DESC = 'Rates'
			inner join proprod.dbo.NUCCHARGECONTROLAMOUNT CCA on CCA.CHARGE_TYPE = C.CHARGE_TYPE and CCA.APPLICATION_DESC = 'Rates' and CCA.START_DATE = @year 
			inner join proprod.dbo.NUCDESCRIPTOR D1 on D1.DESCRIPTOR_VALUE = C.CHARGE_TYPE and D1.DESCRIPTOR_TYPE = '#RNCG' and D1.ACTIVE_FLAG = 'Y'
			inner join proprod.dbo.NUCDESCRIPTOR D2 on D2.DESCRIPTOR_VALUE = CC.ANALYSIS_DESC and D2.DESCRIPTOR_TYPE = '#chrganal' and D1.ACTIVE_FLAG = 'Y'
			where c.PROPERTY_NO = @prop_no
			and	C.HEADER_CTR = @run_ctr  
			order by D2.value1
			
			
	end else
	begin
		if isnull(@duedateplan ,'') = ''
		begin

			set @nocharges = 0
			EXEC proprod.dbo.usrChargeRunCalc 'rates',@year,@prop_no,@scratchid
			declare charge insensitive cursor for
				--select text2, text4, text5, VALUE2, TEXT3, value3 from proprod.dbo.nucscratchpad where scratchpad_id = @scratchid

				select SP.text2, SP.text4, SP.text5, SP.VALUE2, SP.TEXT3, SP.value3,D2.VALUE1 from proprod.dbo.nucscratchpad SP
				inner join proprod.dbo.NUCCHARGECONTROL CC on CC.CHARGE_TYPE = SP.Text2 and CC.APPLICATION_DESC = 'Rates'
				inner join proprod.dbo.NUCDESCRIPTOR D1 on D1.DESCRIPTOR_VALUE = SP.Text2 and D1.DESCRIPTOR_TYPE = '#RNCG' and D1.ACTIVE_FLAG = 'Y'
				inner join proprod.dbo.NUCDESCRIPTOR D2 on D2.DESCRIPTOR_VALUE = CC.ANALYSIS_DESC and D2.DESCRIPTOR_TYPE = '#chrganal' and D1.ACTIVE_FLAG = 'Y'
				where scratchpad_id = @scratchid

			
			open charge
			fetch next from charge into @charge_type, @charge_description, @method, @units, @rate, @amount, @sortorder
			while @@fetch_status <> -1
			begin
				if @chrg = 'UAGC' and @val = 0
					select @val = 1
				
				insert @charges
					(charge_type, charge_description, method, units, rate, amount, sortorder)
					values
					(@charge_type, @charge_description, @method, @units, @rate, @amount, @sortorder)
		
				set @nocharges = @nocharges + 1
				fetch next from charge into @charge_type, @charge_description, @method, @units, @rate, @amount, @sortorder
		
			end
			close charge
			deallocate charge
			delete proprod.dbo.nucscratchpad where scratchpad_id = @scratchid
		end else
		begin
			insert into @charges
				select C.CHARGE_TYPE, CC.DESCRIPTION, D1.DESCRIPTION, C.QUANTITY, C.CHARGE_COMMENT, C.AMOUNT, D2.VALUE1
				from	proprod.dbo.nucCharge C
				inner join proprod.dbo.NUCCHARGECONTROL CC on CC.CHARGE_TYPE = C.CHARGE_TYPE and CC.APPLICATION_DESC = 'Rates'
				inner join proprod.dbo.NUCCHARGECONTROLAMOUNT CCA on CCA.CHARGE_TYPE = C.CHARGE_TYPE and CCA.APPLICATION_DESC = 'Rates' and CCA.START_DATE = @year 
				inner join proprod.dbo.NUCDESCRIPTOR D1 on D1.DESCRIPTOR_VALUE = C.CHARGE_TYPE and D1.DESCRIPTOR_TYPE = '#RNCG' and D1.ACTIVE_FLAG = 'Y'
				inner join proprod.dbo.NUCDESCRIPTOR D2 on D2.DESCRIPTOR_VALUE = CC.ANALYSIS_DESC and D2.DESCRIPTOR_TYPE = '#chrganal' and D1.ACTIVE_FLAG = 'Y'
				where c.PROPERTY_NO = @prop_no
				and C.application_desc = 'Rates'
				and	C.duedate_plan = @duedateplan  
				order by D2.value1
		
		end
	end		

	if @showamounts = 0
		update @charges set rate = '', amount = null

	
	select * from @charges order by sortorder
		


END

/*
grant execute on GET_RID_Charges to onlineservices
*/