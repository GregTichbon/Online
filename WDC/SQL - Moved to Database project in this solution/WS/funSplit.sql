USE [OnlineApplications]
GO
/****** Object:  UserDefinedFunction [dbo].[funSplit]    Script Date: 26/06/2017 10:28:51 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[funSplit]
(
	@RowData nvarchar(2000),
	@SplitOn nvarchar(5)
)  
RETURNS @RtnValue table 
(
	ID int identity(1,1),
	Data nvarchar(2000)
) 
AS  
/*
--===============================================================================================
--#~~ PROGRAM REGISTER INFORMATION
--    ============================
--#~~ PRECIS
--    ------
--#~~
--#~~ Splits a string and returns a table
--#~~
--#~~ CHANGE REGISTER
--    ---------------
--#~~ Date        Who               Ver            AR             REASON
--    -------------------------------------------------------------------------------------------
--#~~ |xx/xx/xxxx |xxxxxxxxxxxxxxx  |xxxxxxxxxx |xxxxxxxxxx | xxxxxxxxxxxxxxxxxxxx
--#~~ |01/08/2007 |CraigA			|002        | 113407    | Initial Version
--===============================================================================================
*/
BEGIN 
	--Declare @Cnt int = 1
	Declare @len int = len(@SplitOn)
	--declare @x int
	--declare @y varchar(100)

	--set @x = Charindex(@SplitOn,@RowData)

	While (Charindex(@SplitOn,@RowData)>0)
	Begin
		--set @x = Charindex(@SplitOn,@RowData)
		--set @y = Substring(@RowData,1,Charindex(@SplitOn,@RowData)-1)
		Insert Into @RtnValue (data)
		Select 
			Data = ltrim(rtrim(Substring(@RowData,1,Charindex(@SplitOn,@RowData)-1)))

		Set @RowData = Substring(@RowData,Charindex(@SplitOn,@RowData)+@len,len(@RowData))
		--set @x = Charindex(@SplitOn,@RowData)

		--Set @Cnt = @Cnt + 1
	End
	
	Insert Into @RtnValue (data)
	Select Data = ltrim(rtrim(@RowData))

	Return
END

/*
declare @prompt varchar(2000) = '||Number||; being ||Percentage||% of girls involved in mentoring identify that the Te Pihi Ora programme has been helpful to their specific needs.'
--declare @prompt varchar(2000) = 'A@@B@@C'
select * from dbo.funSplit(@prompt,'||')
*/