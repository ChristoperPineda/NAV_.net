USE [NavIntegrationDB]
GO
/****** Object:  UserDefinedFunction [dbo].[IsCompanyInEmailSignedConfirmation]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsCompanyInEmailSignedConfirmation]
(
	@CompanyID int
)
RETURNS bit 
AS
BEGIN
	DECLARE @exists bit
	if exists(select * from NavIntegrationDB.dbo.Switch_EmailSignedConfirmation where CompanyID=@CompanyID)
		begin
			set @exists = 1;
		end
	else
		begin
			set @exists = 0;
		end
		
	return @exists

END
GO
/****** Object:  StoredProcedure [dbo].[CurrencyConvert]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CurrencyConvert]
	-- Add the parameters for the stored procedure here
	 @param_strClientID nvarchar(50)
	,@param_fValueToConvert float
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT  @param_fValueToConvert / Currency.ExchangeRate AS ConvertedValue
	FROM NavGlobalDBwwwGUID.dbo.Client
	INNER JOIN NavGlobalDBwwwGUID.dbo.Currency ON Client.Currency=Currency.Currency 
	WHERE Client.ClientID = @param_strClientID
END
GO
/****** Object:  StoredProcedure [dbo].[Switch_CurrencyMultiplier]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Switch_CurrencyMultiplier]
	-- Add the parameters for the stored procedure here
	 @param_strClientID nvarchar(50)
	,@param_strFundCurrency nchar(3)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT  (SELECT ExchangeRate/(SELECT ExchangeRate FROM NavGlobalDBwwwGUID.dbo.Currency WHERE Currency = (SELECT Currency FROM NavGlobalDBwwwGUID.dbo.Client where ClientID = @param_strClientID)) AS RelativeExch FROM NavGlobalDBwwwGUID.dbo.Currency WHERE Currency = @param_strFundCurrency)  AS CurrencyMultiplier
	FROM NavGlobalDBwwwGUID.dbo.Client
	INNER JOIN NavGlobalDBwwwGUID.dbo.Currency ON Client.Currency=Currency.Currency 
	WHERE Client.ClientID = @param_strClientID
END
GO
/****** Object:  StoredProcedure [dbo].[Switch_CurrencyConvert]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Switch_CurrencyConvert]
	-- Add the parameters for the stored procedure here
	 @param_strClientID nvarchar(50)
	,@param_fValueToConvert float
	,@param_strFundCurrency nchar(3)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT  @param_fValueToConvert * (SELECT ExchangeRate/(SELECT ExchangeRate FROM NavGlobalDBwwwGUID.dbo.Currency WHERE Currency = (SELECT Currency FROM NavGlobalDBwwwGUID.dbo.Client where ClientID = @param_strClientID)) AS RelativeExch FROM NavGlobalDBwwwGUID.dbo.Currency WHERE Currency = @param_strFundCurrency)  AS ConvertedValue
	FROM NavGlobalDBwwwGUID.dbo.Client
	INNER JOIN NavGlobalDBwwwGUID.dbo.Currency ON Client.Currency=Currency.Currency 
	WHERE Client.ClientID = @param_strClientID
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_ClientGetAllByIFA]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_ClientGetAllByIFA]

@param_IFA_ID	NVARCHAR(50)

AS
BEGIN

	SELECT 
		 C.ClientID
		,CWD.Surname
		,CWD.Forenames
		,C.Salesperson
		,C.ServicingOffice
		,C.Country
		,C.ValuationFrequency
		,C.ClientNumber
		,C.Category
		,C.Currency
		,C.HTML
		,C.Code
		,C.IFA_ID
		,C.OLDeleted
		,C.ManagerID
		,C.RegionID
		,C.AgentID
		,C.CreatedBy
		,C.AdministratorID
		,C.CoordinatorID
		,C.Language
		--,CONVERT(VARCHAR(10),C.IFAUpdatedDate,101) AS IFAUpdatedDate
		,C.IFAUpdatedDate
		,C.IFAUpdatedBy
	FROM NavGlobalDBwwwGUID.dbo.Client C
	INNER JOIN NavGlobalDBwwwGUID.dbo.ClientWebDetails CWD on CWD.ClientID = C.ClientID
	WHERE C.IFA_ID = @param_IFA_ID

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_ClientGet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_ClientGet]

@param_ClientID	NVARCHAR(50)

AS
BEGIN

	SELECT 
		 C.ClientID
		,CWD.Surname
		,CWD.Forenames
		,C.Salesperson
		,C.ServicingOffice
		,C.Country
		,C.ValuationFrequency
		,C.ClientNumber
		,C.Category
		,C.Currency
		,C.HTML
		,C.Code
		,C.IFA_ID
		,C.OLDeleted
		,C.ManagerID
		,C.RegionID
		,C.AgentID
		,C.CreatedBy
		,C.AdministratorID
		,C.CoordinatorID
		,C.Language
		--,CONVERT(VARCHAR(10),C.IFAUpdatedDate,101) AS IFAUpdatedDate
		,C.IFAUpdatedDate
		,C.IFAUpdatedBy
		,CWD.WorkEmail
		,CWD.PersonalEmail
	FROM NavGlobalDBwwwGUID.dbo.Client C
	INNER JOIN NavGlobalDBwwwGUID.dbo.ClientWebDetails CWD on CWD.ClientID = C.ClientID
	WHERE C.ClientID = @param_ClientID

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_CheckSecurityCodeValid]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_CheckSecurityCodeValid]

	 @param_Code			NVARCHAR(16)
	,@param_ClientID		NVARCHAR(10)
	,@param_PortfolioID		NVARCHAR(10)
	,@param_SwitchID		INT

AS
	DECLARE 
		 @return_Message	NVARCHAR(MAX)
		,@Attempt			int = 0
BEGIN
	IF EXISTS (SELECT * FROM NavIntegrationDB.dbo.SwitchClientSecurityCode WHERE Code = @param_Code AND SwitchID = @param_SwitchID)
		BEGIN
			IF ((SELECT IsConsumed FROM NavIntegrationDB.dbo.SwitchClientSecurityCode WHERE Code = @param_Code AND SwitchID = @param_SwitchID) = 0)
				BEGIN
					UPDATE NavIntegrationDB.dbo.SwitchClientSecurityCode SET IsConsumed = 1 WHERE Code = @param_Code AND SwitchID = @param_SwitchID AND IsConsumed = 0
					UPDATE NavIntegrationDB.dbo.SwitchHeader  SET Status = 6 WHERE SwitchID = @param_SwitchID
					SET @return_Message = 'Thank you, the proposed changes will be made to your portfolio.'
				END
			ELSE
				BEGIN
					SET @return_Message = 'The security code you have entered is already used'
				END
		END
	ELSE
		BEGIN
			SET @Attempt = (SELECT SecurityCodeAttempt FROM NavIntegrationDB.dbo.SwitchHeader WHERE SwitchID = @param_SwitchID)
			IF (@Attempt < 3)
				BEGIN
					SET @Attempt = @Attempt + 1
					UPDATE NavIntegrationDB.dbo.SwitchHeader SET SecurityCodeAttempt =  @Attempt WHERE SwitchID = @param_SwitchID
					IF (@Attempt > 2)
						BEGIN
							--SET @return_Message = CONVERT(CHAR(1), @Attempt)
							SET @return_Message = 'Sorry, you have entered the security code incorrectly three times. Please contact your IFA to have the security code reset.'
							UPDATE NavIntegrationDB.dbo.SwitchHeader SET Status = 7 WHERE SwitchID = @param_SwitchID
						END
					ELSE
						BEGIN
							SET @return_Message = 'Sorry, the security code you have entered is incorrect, please re-enter the security code. You have ' + CONVERT(CHAR(1),3 - @Attempt) + ' more attempts.'
						END
				END
			ELSE
				BEGIN
					UPDATE NavIntegrationDB.dbo.SwitchHeader SET Status = 7 WHERE SwitchID = @param_SwitchID
					SET @return_Message = 'Sorry, you have entered the security code incorrectly three times. Please contact your IFA to have the security code reset.'
				END
		END
END

SELECT ISNULL(@return_Message,'')
GO
/****** Object:  StoredProcedure [dbo].[SWITCHSchemeclient_HeaderUpdate]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHSchemeclient_HeaderUpdate]

	@param_intSwitchID		INT
	,@param_intStatus		SMALLINT
	,@param_strDescription	NVARCHAR(MAX) = null
AS
BEGIN

SET NOCOUNT ON;

	UPDATE dbo.SwitchSchemeHeader
	SET [Amend_Status] = @param_intStatus,
		[Amend_Description] = @param_strDescription
	WHERE [SwitchID] = @param_intSwitchID;

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHScheme_SchemeContributionsGet]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHScheme_SchemeContributionsGet] 

@param_SchemeID	nvarchar(50)

AS
BEGIN

	SET NOCOUNT ON;

SELECT [ClientID]
      ,[SchemeID]
      ,[ContributionID]
      ,[StartDate]
      ,[EndDate]
      ,[ContributionAmount]
      ,[ValuationFrequency]
      ,[SchemeContributionsUpdatedDate]
      ,[SchemeContributionsUpdatedBy]
      ,[OLDeleted]
      ,[IFAUpdatedDate]
      ,[IFAUpdatedBy]
FROM [NavGlobalDBwwwGUID].[dbo].[SchemeContributions]

WHERE SchemeID = @param_SchemeID and OLDeleted = 0 

ORDER BY ContributionID 

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHScheme_HeaderInsert]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHScheme_HeaderInsert]

	 @param_strSchemeID		NVARCHAR(50)
	,@param_strClientID		NVARCHAR(50)
	,@param_intStatus		SMALLINT
	,@param_strCreated_By	NVARCHAR(50)
	,@param_intSwitchID		INT				= NULL
	,@param_strDescription	NVARCHAR(MAX)
	
AS
BEGIN

SET NOCOUNT ON;

IF NOT EXISTS (SELECT SchemeID FROM [NavIntegrationDB].[dbo].[SwitchSchemeHeader] WHERE [SwitchID] = @param_intSwitchID)
BEGIN
	
	INSERT INTO [NavIntegrationDB].[dbo].[SwitchSchemeHeader]
		   ([SchemeID]
		   ,[ClientID]
		   ,[Status]
		   ,[Date_Created]
		   ,[Created_By]
		   ,[Description] 
		   )
	 VALUES
		   (@param_strSchemeID
		   ,@param_strClientID
		   ,@param_intStatus
		   ,CURRENT_TIMESTAMP
		   ,@param_strCreated_By
		   ,@param_strDescription
		   );
		   
	SELECT @@IDENTITY 
END
ELSE
BEGIN
	IF(LEN(@param_strDescription) = 0)
		BEGIN
			UPDATE [NavIntegrationDB].[dbo].[SwitchSchemeHeader]
			SET [Status] = @param_intStatus, [SecurityCodeAttempt] = 0
			WHERE [SwitchID] = @param_intSwitchID;		
		END
	ELSE
		BEGIN
			UPDATE [NavIntegrationDB].[dbo].[SwitchSchemeHeader]
			SET [Status] = @param_intStatus, [SecurityCodeAttempt] = 0, [Description] = @param_strDescription
			WHERE [SwitchID] = @param_intSwitchID;
		END
	
	SELECT @param_intSwitchID

END
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHScheme_HeaderGetOriginal]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHScheme_HeaderGetOriginal]

@param_strClientID nvarchar(50),
@param_strSchemeID nvarchar(50)


AS
BEGIN

	SET NOCOUNT ON;

SELECT [AccountNumber]
      ,[CompanyID]
      ,[ClientGenerated]
      ,[Company]
      ,[PortfolioType]
      ,[PortfolioTypeID]
      ,[SchemeID]
      ,[ClientID]
      ,[SchemeCurrency]
      ,[ContributionTotal]
      ,[ExcludeFromReports]
      ,[StartDate]
      ,[MaturityDate]
      ,[SumAssured]
      ,[PlanStatus]
      ,[Liquidity]
      ,[RiskProfile]
      ,[RetentionTerm]
      ,[MFPercent]
	  ,(select sum(CurrentValueScheme) as SC_TotalValue from [NavGlobalDBwwwGUID].[dbo].[SchemeDetails3] where	ClientID = @param_strClientID and SchemeID = @param_strSchemeID) as SC_TotalValue
	  ,(select WithdrawalTotal from [NavGlobalDBwwwGUID].[dbo].[vwSchemeTotalWithdrawalsToDate] where SchemeID = @param_strSchemeID) as WithdrawalTotal
	  ,(select sum(CurrentValueClient) as SumOfSumOfCurrentValueClient from [NavGlobalDBwwwGUID].[dbo].SchemeDetails3 where ClientID = @param_strClientID and SchemeID = @param_strSchemeID ) as CC_TotalValue
	  ,(select SwitchIFAPermit from NavGlobalDBwwwGUID.dbo.[Scheme] where ClientID = @param_strClientID and SchemeID = @param_strSchemeID and OLDeleted = 0) as SwitchIFAPermit

FROM [NavGlobalDBwwwGUID].[dbo].[SchemeGeneralDetailsTest]

where	ClientID = @param_strClientID
		and SchemeID = @param_strSchemeID

END

--select ((select sum(CurrentValueScheme) as SC_TotalValue from [NavGlobalDBwwwGUID].[dbo].[SchemeDetails3] where	ClientID = '409003-1' and SchemeID = '106151-1') - 
--(select WithdrawalTotal from [NavGlobalDBwwwGUID].[dbo].[vwSchemeTotalWithdrawalsToDate] where SchemeID = '106151-1'))
--
--SWITCHScheme_HeaderGet '409003-1', '92051-1' 106151-1
GO
/****** Object:  StoredProcedure [dbo].[SWITCHScheme_HeaderGet]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHScheme_HeaderGet] 

@param_strSchemeID	nvarchar(50) = NULL,
@param_strClientID		nvarchar(50) = NULL,
@param_intSwitchID		INT = NULL

AS
BEGIN

	SET NOCOUNT ON;

IF EXISTS (SELECT SwitchID FROM [NavIntegrationDB].[dbo].[SwitchSchemeHeader] WHERE SwitchID = @param_intSwitchID)	
	BEGIN

	SELECT	[SchemeID]
			,[ClientID]
			,[SwitchID]
			,[Status]
			,[Date_Created]
			,[Created_By]
			,[SecurityCodeAttempt]
			,[Description]
			,[Amend_Status]
			,[Amend_Description]
	FROM	[NavIntegrationDB].[dbo].[SwitchSchemeHeader]
	WHERE	[SwitchID] = @param_intSwitchID

	END
ELSE
	BEGIN

	SELECT	[SchemeID]
			,[ClientID]
			,[SwitchID]
			,[Status]
			,[Date_Created]
			,[Created_By]
			,[SecurityCodeAttempt]
			,[Description]
			,[Amend_Status]
			,[Amend_Description]
	FROM	[NavIntegrationDB].[dbo].[SwitchSchemeHeader]
	WHERE	SchemeID = @param_strSchemeID
			AND ClientID = @param_strClientID
			--and status is not complete
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHScheme_GenerateCodeInsert]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHScheme_GenerateCodeInsert]

	  @param_Code			NVARCHAR(16)
	 ,@param_SwitchID		INT 
	 ,@param_ClientID		NVARCHAR(20)
	 ,@param_SchemeID		NVARCHAR(50)
AS
BEGIN
	DECLARE @return_Valid int

SET NOCOUNT ON;
IF NOT EXISTS (SELECT [Code]  FROM [NavIntegrationDB].[dbo].[SwitchGenerateCode] WHERE [Code] = @param_Code)
 BEGIN
	INSERT INTO [NavIntegrationDB].[dbo].[SwitchGenerateCode]
		([Code])
	 VALUES
		(@param_Code);
		
	 IF ((SELECT COUNT(*) FROM  [NavIntegrationDB].[dbo].[SwitchSchemeClientSecurityCode] WHERE SwitchID = @param_SwitchID and ClientID = @param_ClientID and SchemeID = @param_SchemeID) > 0)
		BEGIN
			DELETE FROM [NavIntegrationDB].[dbo].[SwitchGenerateCode] WHERE Code = 
				(SELECT Code FROM [NavIntegrationDB].[dbo].[SwitchSchemeClientSecurityCode] WHERE SwitchID = @param_SwitchID and ClientID = @param_ClientID and SchemeID = @param_SchemeID)
			UPDATE [NavIntegrationDB].[dbo].[SwitchSchemeClientSecurityCode]
				SET Code = @param_Code, IsConsumed = 0 
			WHERE SwitchID = @param_SwitchID and ClientID = @param_ClientID and SchemeID = @param_SchemeID
		END
	  ELSE 
		BEGIN
			INSERT INTO [NavIntegrationDB].[dbo].[SwitchSchemeClientSecurityCode]
				(Code, SwitchID, ClientID, SchemeID)
			VALUES
				(@param_Code, @param_SwitchID, @param_ClientID, @param_SchemeID)
		END


		SET @return_Valid = 1
	END

ELSE IF EXISTS (SELECT [Code] FROM [NavIntegrationDB].[dbo].[SwitchGenerateCode] WHERE DATEDIFF(dd,DateCreated,GETDATE())  > 30 AND [Code] = @param_Code)
	BEGIN
		UPDATE [NavIntegrationDB].[dbo].[SwitchGenerateCode]
			SET DateCreated = GETDATE()
			WHERE Code = @param_Code
		IF ((SELECT COUNT(*) FROM  [NavIntegrationDB].[dbo].[SwitchSchemeClientSecurityCode] WHERE SwitchID = @param_SwitchID and ClientID = @param_ClientID and SchemeID = @param_SchemeID) > 0)
		BEGIN
			DELETE FROM [NavIntegrationDB].[dbo].[SwitchSchemeClientSecurityCode] WHERE Code = 
				(SELECT Code FROM [NavIntegrationDB].[dbo].[SwitchSchemeClientSecurityCode] WHERE SwitchID = @param_SwitchID and ClientID = @param_ClientID and SchemeID = @param_SchemeID)
			UPDATE [NavIntegrationDB].[dbo].[SwitchSchemeClientSecurityCode]
				SET Code = @param_Code, IsConsumed = 0
			WHERE SwitchID = @param_SwitchID and ClientID = @param_ClientID and SchemeID = @param_SchemeID
		END
	  ELSE 
		BEGIN
			INSERT INTO [NavIntegrationDB].[dbo].[SwitchSchemeClientSecurityCode]
				(Code, SwitchID, ClientID, SchemeID)
			VALUES
				(@param_Code, @param_SwitchID, @param_ClientID, @param_SchemeID)
		END

		SET @return_Valid = 1
	END
SELECT ISNULL(@return_Valid,0)
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHScheme_DetailsInsert]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHScheme_DetailsInsert]
	
	  @param_intSwitchID			INT
     ,@param_intFundID				INT
     ,@param_fAllocation			FLOAT
     ,@param_strCreated_By			NVARCHAR(50)
     ,@param_strUpdated_By			NVARCHAR(50)
     ,@param_intSwitchDetailsID		INT = NULL
	 ,@param_sintIsDeletable		SMALLINT
	 ,@param_sintIsContribution		SMALLINT
     
AS
BEGIN
	
	SET NOCOUNT ON;
IF EXISTS (SELECT SwitchDetailsID,SwitchID  FROM [NavIntegrationDB].[dbo].[SwitchSchemeDetails] WHERE SwitchDetailsID = @param_intSwitchDetailsID AND SwitchID = @param_intSwitchID AND isContribution = @param_sintIsContribution)
	BEGIN
		UPDATE NavIntegrationDB.dbo.SwitchSchemeDetails
			SET	[FundID] = @param_intFundID
			   ,[Allocation] = @param_fAllocation
			   ,[Created_By] = @param_strCreated_By
			   ,[Date_LastUpdate] = CURRENT_TIMESTAMP
			   ,[Updated_By] = @param_strUpdated_By
			   ,[isDeletable] = @param_sintIsDeletable
		WHERE	SwitchDetailsID = @param_intSwitchDetailsID AND SwitchID = @param_intSwitchID 
				And isContribution = @param_sintIsContribution
	END
ELSE
	BEGIN
		INSERT INTO [NavIntegrationDB].[dbo].[SwitchSchemeDetails]
			   ([SwitchID]
			   ,[FundID]
			   ,[Allocation]
			   ,[Created_By]
			   ,[Date_Created]
			   ,[Date_LastUpdate]
			   ,[Updated_By]
			   ,[isDeletable]
			   ,[isContribution])
		 VALUES
			   (@param_intSwitchID
			   ,@param_intFundID
			   ,@param_fAllocation
			   ,@param_strCreated_By
			   ,CURRENT_TIMESTAMP
			   ,CURRENT_TIMESTAMP
			   ,@param_strUpdated_By
			   ,@param_sintIsDeletable
			   ,@param_sintIsContribution)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHScheme_DetailsGetOriginal]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHScheme_DetailsGetOriginal] 

@param_strClientID nvarchar(50),
@param_strSchemeID nvarchar(50)


AS
BEGIN

	SET NOCOUNT ON;
	
SELECT		[ClientID]
			,[SchemeID]
			,[FundName]
			,[NumberOfUnits]
			,[Price]
			,[Value]
			,[CurrentValueClient]
			,[CurrentValueScheme]
			,[ClientCurrency]
			,[FundExchangeRate]
			,[DatePriceUpdated]
			,[FundNameID]
			,[SEDOL]
			,[FundCurrency]
			,[SectorID]
			,[FundChoicePercentage]
			,[ContributionTotal]
			,[SchemeCurrency]
			,[ExchangeRate]
			,[SchemeStartDate]
			,[FundID]
			,[OLDeleted]
			,[TYPECODE]
			,[fundcode]
			,[Type]

FROM		[NavGlobalDBwwwGUID].[dbo].[SchemeDetails3]

WHERE		ClientID = @param_strClientID 
			and SchemeID = @param_strSchemeID 
			and OLDeleted = 0 

ORDER BY	FundName 

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHScheme_DetailsGet]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHScheme_DetailsGet] 

@param_intSwitchID		int
,@param_isContribution	smallint

AS
BEGIN

	SET NOCOUNT ON;
	
SELECT	[SwitchDetailsID]
		,[SwitchID]
		,[FundID]
		,[Allocation]
		,[Date_Created]
		,[Created_By]
		,[Date_LastUpdate]
		,[Updated_By]
		,[isDeletable]

FROM	[NavIntegrationDB].[dbo].[SwitchSchemeDetails]

WHERE	[SwitchID] = @param_intSwitchID
		And [isContribution] = @param_isContribution

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHScheme_DetailsDeleteAll]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHScheme_DetailsDeleteAll] 

@param_SwitchID int

AS
BEGIN

	DELETE 
	FROM dbo.SwitchSchemeDetails
	WHERE SwitchID = @param_SwitchID;


END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHScheme_DetailsDelete]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHScheme_DetailsDelete]
	@param_intSwitchDetailsID	INT
     
AS
BEGIN
	
SET NOCOUNT ON;

DELETE FROM dbo.SwitchSchemeDetails
WHERE SwitchDetailsID = @param_intSwitchDetailsID
	
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHScheme_Delete]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHScheme_Delete] 

@param_SwitchID int

AS
BEGIN

	DELETE 
	FROM dbo.SwitchSchemeDetails
	WHERE SwitchID = @param_SwitchID;
	
	DELETE
	FROM dbo.SwitchSchemeHeader
	WHERE SwitchID = @param_SwitchID;

	DELETE
	FROM dbo.SwitchSchemeDetails_Client
	WHERE SwitchID = @param_SwitchID;

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHScheme_CheckSecurityCodeValid]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHScheme_CheckSecurityCodeValid]

	 @param_Code			NVARCHAR(16)
	,@param_ClientID		NVARCHAR(10)
	,@param_SchemeID		NVARCHAR(50)
	,@param_SwitchID		INT

AS
	DECLARE 
		 @return_Message	NVARCHAR(MAX)
		,@Attempt			int
BEGIN 
	IF EXISTS (SELECT * FROM NavIntegrationDB.dbo.SwitchSchemeClientSecurityCode WHERE Code = @param_Code AND SwitchID = @param_SwitchID)
		BEGIN
			IF ((SELECT IsConsumed FROM NavIntegrationDB.dbo.SwitchSchemeClientSecurityCode WHERE Code = @param_Code AND SwitchID = @param_SwitchID) = 0)
				BEGIN
					UPDATE NavIntegrationDB.dbo.SwitchSchemeClientSecurityCode SET IsConsumed = 1 WHERE Code = @param_Code AND SwitchID = @param_SwitchID AND IsConsumed = 0
					UPDATE NavIntegrationDB.dbo.SwitchSchemeHeader  SET Status = 6 WHERE SwitchID = @param_SwitchID
					SET @return_Message = 'Thank you, the proposed changes will be made to your portfolio.'
				END
			ELSE
				BEGIN
					SET @return_Message = 'The security code you have entered is already used'
				END
		END
	ELSE
		BEGIN
			SET @Attempt = (SELECT SecurityCodeAttempt FROM NavIntegrationDB.dbo.SwitchSchemeHeader WHERE SwitchID = @param_SwitchID)
			IF (@Attempt < 3)
				BEGIN
					SET @Attempt = @Attempt + 1
					UPDATE NavIntegrationDB.dbo.SwitchSchemeHeader SET SecurityCodeAttempt =  @Attempt WHERE SwitchID = @param_SwitchID
					IF (@Attempt > 2)
						BEGIN
							--SET @return_Message = CONVERT(CHAR(1), @Attempt)
							SET @return_Message = 'Sorry, you have entered the security code incorrectly three times. Please contact your IFA to have the security code reset.'
							UPDATE NavIntegrationDB.dbo.SwitchSchemeHeader SET Status = 7 WHERE SwitchID = @param_SwitchID
						END
					ELSE
						BEGIN
							SET @return_Message = 'Sorry, the security code you have entered is incorrect, please re-enter the security code. You have ' + CONVERT(CHAR(1),3 - @Attempt) + ' more attempts.'
						END
				END
			ELSE
				BEGIN
					UPDATE NavIntegrationDB.dbo.SwitchSchemeHeader SET Status = 7 WHERE SwitchID = @param_SwitchID
					SET @return_Message = 'Sorry, you have entered the security code incorrectly three times. Please contact your IFA to have the security code reset.'
				END
		END
END

SELECT ISNULL(@return_Message,'')
GO
/****** Object:  StoredProcedure [dbo].[SWITCHSchemeHistory_MessageInsert]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHSchemeHistory_MessageInsert]

	@param_HistoryID		int
	,@param_Message		nvarchar(max)
	
AS
BEGIN

SET NOCOUNT ON;

INSERT INTO [NavIntegrationDB].[dbo].[SwitchSchemeHistoryMessages]
           ([HistoryID],[Message])
     VALUES
           (@param_HistoryID, @param_Message);
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHSchemeHistory_MessageGet]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHSchemeHistory_MessageGet] 

	@param_intHistoryID		int	

AS
BEGIN

	SET NOCOUNT ON;

	SELECT [MessageID]
		  ,[HistoryID]
		  ,[Message]
	FROM [NavIntegrationDB].[dbo].[SwitchSchemeHistoryMessages]
	Where [HistoryID] = @param_intHistoryID

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHSchemeHistory_HeaderInsert]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHSchemeHistory_HeaderInsert]

	@param_SwitchID		int
	,@param_SchemeID	nvarchar(50)
	,@param_Status		smallint
	
AS
BEGIN

SET NOCOUNT ON;

INSERT INTO [NavIntegrationDB].[dbo].[SwitchSchemeHistoryHeader]
           ([SchemeID],[SwitchID],[Action_Date],[Status])
     VALUES
           (@param_SchemeID, @param_SwitchID, CURRENT_TIMESTAMP, @param_Status);

SELECT @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHSchemeHistory_HeaderGet]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHSchemeHistory_HeaderGet] 

	@param_strSchemeID		nvarchar(50)
	,@param_intSwitchID		int	

AS
BEGIN

	SET NOCOUNT ON;

	SELECT	[HistoryID]
			,[SchemeID]
			,[SwitchID]
			,[Action_Date]
			,[Status]
	FROM	[NavIntegrationDB].[dbo].[SwitchSchemeHistoryHeader]
	WHERE	[SchemeID] = @param_strSchemeID
			AND [SwitchID] = @param_intSwitchID
	ORDER BY [HistoryID] desc

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHSchemeHistory_DetailsInsert]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHSchemeHistory_DetailsInsert]

      @param_HistoryID			int
      ,@param_SwitchDetailsID	int
      ,@param_FundID			int
      ,@param_Allocation		float
      ,@param_Created_By		nvarchar(50)
	  ,@param_isContribution	smallint
     
AS
BEGIN
	
	SET NOCOUNT ON;
INSERT INTO [NavIntegrationDB].[dbo].[SwitchSchemeHistoryDetails]
           ([HistoryID]
           ,[SwitchDetailsID]
           ,[FundID]
           ,[Allocation]
           ,[Date_Created]
           ,[Created_By]
		   ,[isContribution])
     VALUES
           (@param_HistoryID
           ,@param_SwitchDetailsID
           ,@param_FundID
           ,@param_Allocation
           ,Current_TimeStamp
           ,@param_Created_By
		   ,@param_isContribution)
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHSchemeHistory_DetailsGet]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHSchemeHistory_DetailsGet] 

	@param_intHistoryID	int
	,@param_isContribution	smallint

AS
BEGIN

	SET NOCOUNT ON;

	SELECT	[HistoryDetailsID]
			,[HistoryID]
			,[SwitchDetailsID]
			,[FundID]
			,[Allocation]
			,[Date_Created]
			,[Created_By]
			,[isContribution]
	FROM	[NavIntegrationDB].[dbo].[SwitchSchemeHistoryDetails]
	WHERE	[HistoryID] = @param_intHistoryID
			And [isContribution] = @param_isContribution

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHSchemeClient_DetailsInsert]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHSchemeClient_DetailsInsert]
	
	  @param_intSwitchID			INT
     ,@param_intFundID				INT
     ,@param_fAllocation			FLOAT
     ,@param_strCreated_By			NVARCHAR(50)
     ,@param_strUpdated_By			NVARCHAR(50)
     ,@param_intSwitchDetailsID		INT = NULL
	 ,@param_sintIsDeletable		SMALLINT
	 ,@param_sintIsContribution		SMALLINT
     
AS
BEGIN
	
	SET NOCOUNT ON;
IF EXISTS (SELECT SwitchDetailsID,SwitchID  FROM [NavIntegrationDB].[dbo].[SwitchSchemeDetails_Client] WHERE SwitchDetailsID = @param_intSwitchDetailsID AND SwitchID = @param_intSwitchID AND isContribution = @param_sintIsContribution)
	BEGIN
		UPDATE NavIntegrationDB.dbo.SwitchSchemeDetails_Client
			SET	[FundID] = @param_intFundID
			   ,[Allocation] = @param_fAllocation
			   ,[Created_By] = @param_strCreated_By
			   ,[Date_LastUpdate] = CURRENT_TIMESTAMP
			   ,[Updated_By] = @param_strUpdated_By
			   ,[isDeletable] = @param_sintIsDeletable
		WHERE	SwitchDetailsID = @param_intSwitchDetailsID AND SwitchID = @param_intSwitchID 
				And isContribution = @param_sintIsContribution
	END
ELSE
	BEGIN
		INSERT INTO [NavIntegrationDB].[dbo].[SwitchSchemeDetails_Client]
			   ([SwitchID]
			   ,[FundID]
			   ,[Allocation]
			   ,[Created_By]
			   ,[Date_Created]
			   ,[Date_LastUpdate]
			   ,[Updated_By]
			   ,[isDeletable]
			   ,[isContribution])
		 VALUES
			   (@param_intSwitchID
			   ,@param_intFundID
			   ,@param_fAllocation
			   ,@param_strCreated_By
			   ,CURRENT_TIMESTAMP
			   ,CURRENT_TIMESTAMP
			   ,@param_strUpdated_By
			   ,@param_sintIsDeletable
			   ,@param_sintIsContribution)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHSchemeClient_DetailsGet]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHSchemeClient_DetailsGet] 

@param_intSwitchID int
,@param_isContribution	smallint

AS
BEGIN

	SET NOCOUNT ON;
	
SELECT [SwitchDetailsID]
      ,[SwitchID]
      ,[FundID]
      ,[Allocation]
      ,[Date_Created]
      ,[Created_By]
      ,[Date_LastUpdate]
      ,[Updated_By]
      ,[isDeletable]
      ,[isContribution]
  FROM [NavIntegrationDB].[dbo].[SwitchSchemeDetails_Client]
  WHERE SwitchID = @param_intSwitchID
		And [isContribution] = @param_isContribution

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHSchemeClient_DetailsDeleteAll]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHSchemeClient_DetailsDeleteAll] 

@param_SwitchID int

AS
BEGIN

	DELETE
	FROM dbo.SwitchSchemeDetails_Client
	WHERE SwitchID = @param_SwitchID;


END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHSchemeClient_Delete]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHSchemeClient_Delete] 

@param_SwitchID int

AS
BEGIN

	DELETE 
	FROM dbo.SwitchSchemeDetails_Client
	WHERE SwitchID = @param_SwitchID;
	
	UPDATE dbo.SwitchSchemeHeader
	SET [Amend_Status] = null,
		[Amend_Description] = null
	WHERE [SwitchID] = @param_SwitchID;

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHSchemeClient_Decline]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHSchemeClient_Decline] 

@param_SwitchID int

AS
BEGIN

	UPDATE dbo.SwitchSchemeHeader
	SET [Status] = 5
	WHERE [SwitchID] = @param_SwitchID

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHSCheme_HeaderUpdate]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHSCheme_HeaderUpdate] 

@param_intSwitchID int,
@param_Status smallint,
@param_Description nvarchar(max) = null

AS
BEGIN

	SET NOCOUNT ON;
	
	IF @param_Description = null Begin

		UPDATE dbo.SwitchSchemeHeader
		SET [Status] = @param_Status
		WHERE [SwitchID] = @param_intSwitchID

	END
	ELSE Begin
		UPDATE dbo.SwitchSchemeHeader
		SET [Status] = @param_Status, Description = @param_Description
		WHERE [SwitchID] = @param_intSwitchID
	END 
	
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHHistory_MessageInsert]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHHistory_MessageInsert]

	@param_HistoryID		int
	,@param_Message		nvarchar(max)
	
AS
BEGIN

SET NOCOUNT ON;

INSERT INTO [NavIntegrationDB].[dbo].[SwitchHistoryMessages]
           ([HistoryID],[Message])
     VALUES
           (@param_HistoryID, @param_Message);
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHHistory_MessageGet]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHHistory_MessageGet] 

	@param_intHistoryID		int	

AS
BEGIN

	SET NOCOUNT ON;

	SELECT [MessageID]
		  ,[HistoryID]
		  ,[Message]
	FROM [NavIntegrationDB].[dbo].[SwitchHistoryMessages]
	Where [HistoryID] = @param_intHistoryID

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHHistory_HeaderInsert]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHHistory_HeaderInsert]

	@param_SwitchID		int
	,@param_PortfolioID	nvarchar(50)
	,@param_Status		smallint
	
AS
BEGIN

SET NOCOUNT ON;

INSERT INTO [NavIntegrationDB].[dbo].[SwitchHistoryHeader]
           ([PortfolioID],[SwitchID],[Action_Date],[Status])
     VALUES
           (@param_PortfolioID, @param_SwitchID, CURRENT_TIMESTAMP, @param_Status);

SELECT @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHHistory_HeaderGet]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHHistory_HeaderGet] 

	@param_strPortfolioID	nvarchar(50)
	,@param_intSwitchID		int	

AS
BEGIN

	SET NOCOUNT ON;

	SELECT	[HistoryID]
			,[PortfolioID]
			,[SwitchID]
			,[Action_Date]
			,[Status]
	FROM	[NavIntegrationDB].[dbo].[SwitchHistoryHeader]
	WHERE	[PortfolioID] = @param_strPortfolioID
			AND [SwitchID] = @param_intSwitchID
	ORDER BY [HistoryID] desc

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHHistory_DetailsInsert]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHHistory_DetailsInsert]

      @param_HistoryID			int
      ,@param_SwitchDetailsID	int
      ,@param_FundID			int
      ,@param_Allocation		float
      ,@param_Created_By		nvarchar(50)
     
AS
BEGIN
	
	SET NOCOUNT ON;
INSERT INTO [NavIntegrationDB].[dbo].[SwitchHistoryDetails]
           ([HistoryID]
           ,[SwitchDetailsID]
           ,[FundID]
           ,[Allocation]
           ,[Date_Created]
           ,[Created_By])
     VALUES
           (@param_HistoryID
           ,@param_SwitchDetailsID
           ,@param_FundID
           ,@param_Allocation
           ,Current_TimeStamp
           ,@param_Created_By)
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHHistory_DetailsGet]    Script Date: 02/07/2012 11:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHHistory_DetailsGet] 

	@param_intHistoryID	int

AS
BEGIN

	SET NOCOUNT ON;

	SELECT	[HistoryDetailsID]
			,[HistoryID]
			,[SwitchDetailsID]
			,[FundID]
			,[Allocation]
			,[Date_Created]
			,[Created_By]
	FROM	[NavIntegrationDB].[dbo].[SwitchHistoryDetails]
	WHERE	[HistoryID] = @param_intHistoryID

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_SMSTemplateUpdate]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_SMSTemplateUpdate] 

@param_sintSMSTemplateID	smallint,
@param_strTemplateName		nvarchar(50),
@param_strTemplateFor		nvarchar(50),
@param_strMessage			nvarchar(160)

AS
BEGIN

	SET NOCOUNT ON;

	BEGIN
		UPDATE [NavIntegrationDB].[dbo].[Switch_SMSTemplate]
		SET TemplateName = @param_strTemplateName, 
			TemplateFor = @param_strTemplateFor,
			[Message] = @param_strMessage
		WHERE SMSTemplateID = @param_sintSMSTemplateID
	END

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_SMSTemplateInsert]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_SMSTemplateInsert] 
	@param_TemplateName nvarchar(50),
	@param_TemplateFor	nvarchar(50),
	@param_Message		nvarchar(160)

AS
BEGIN

	SET NOCOUNT ON;
	IF NOT EXISTS (SELECT SMSTemplateID, TemplateName, TemplateFor, [Message] FROM [NavIntegrationDB].[dbo].[Switch_SMSTemplate] WHERE TemplateName = @param_TemplateName)
		BEGIN
			INSERT INTO [NavIntegrationDB].[dbo].[Switch_SMSTemplate]
			(TemplateName, TemplateFor, [Message])
			VALUES
			(@param_TemplateName, @param_TemplateFor, @param_Message)
		END	
	ELSE
		BEGIN
			RAISERROR('Template name already exists.', 16, 1)		
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_SMSTemplateGetAll]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_SMSTemplateGetAll] 

AS
BEGIN

	SET NOCOUNT ON;

		SELECT	SMSTemplateID, TemplateName, TemplateFor, [Message]
		FROM	[NavIntegrationDB].[dbo].[Switch_SMSTemplate]		
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_SMSTemplateGet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_SMSTemplateGet] 

@param_sintSMSTemplateID	smallint = null,
@param_TemplateName			nvarchar(50) = null

AS
BEGIN

	SET NOCOUNT ON;

SELECT	SMSTemplateID, TemplateName, TemplateFor, [Message]
		FROM	[NavIntegrationDB].[dbo].[Switch_SMSTemplate] 
		WHERE	(SMSTemplateID = @param_sintSMSTemplateID 
				OR TemplateName = @param_TemplateName)

--IF EXISTS (SELECT SMSTemplateID FROM [NavIntegrationDB].[dbo].[Switch_SMSTemplate] WHERE SMSTemplateID = @param_sintSMSTemplateID AND TemplateName = @param_TemplateName)
--	BEGIN
--		SELECT	SMSTemplateID, TemplateName, TemplateFor, [Message]
--		FROM	[NavIntegrationDB].[dbo].[Switch_SMSTemplate] 
--		WHERE	SMSTemplateID = @param_sintSMSTemplateID 
--				AND TemplateName = @param_TemplateName
--	END
--ELSE
--	BEGIN
--		SELECT	SMSTemplateID, TemplateName, TemplateFor, [Message]
--		FROM	[NavIntegrationDB].[dbo].[Switch_SMSTemplate] 
--		WHERE	SMSTemplateID = @param_sintSMSTemplateID
--	END

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_SMSTemplateDelete]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_SMSTemplateDelete] 

@param_sintSMSTemplateID	smallint

AS
BEGIN

	SET NOCOUNT ON;

	DELETE FROM [NavIntegrationDB].[dbo].[Switch_SMSTemplate] WHERE SMSTemplateID = @param_sintSMSTemplateID

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_PortfolioHeaderGet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_PortfolioHeaderGet] 

@param_strClientID nvarchar(50),
@param_strPortfolioID nvarchar(50)


AS
BEGIN

	SET NOCOUNT ON;

	select	AccountNumber, CompanyID, Company, PortfolioCurrency, 
			PortfolioType, PortfolioID, ClientID, PortfolioTypeID, 
			PortfolioStartDate, PlanStatus, Liquidity, RiskProfile, 
			RetentionTerm, MFPercent, ExcludeFromReports, ClientGenerated 
	from NavGlobalDBwwwGUID.dbo.PortfolioGeneralDetails 
	where ClientID = @param_strClientID and PortfolioID = @param_strPortfolioID 
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_PortfolioDetailsGet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_PortfolioDetailsGet] 

@param_strClientID nvarchar(50),
@param_strPortfolioID nvarchar(50)


AS
BEGIN

	SET NOCOUNT ON;
	
	select         
			ClientID, 
			PortfolioID, 
			PortfolioStartDate, 
			Company, 
			FundManagerWeb,                       
			CompanyID, 
			NameOfFund, 
			FundNameID, 
			Sector, 
			SectorID, 
			DataDate,                 
			ClientCurrency, 
			PortfolioCurrency, 
			NumberOfUnits, 
			Price, 
			SEDOL,         
			PurchaseCostFund, 
			FundCurrency, 
			PurchaseCostPortfolio,                 
			CurrentValuePortfolio,                 
			CurrentValueClient,         
			AllocationPercent,
			GainOrLossPercent,                       
            GainOrLossPortfolio, 
            PortfolioType, 
            PortfolioTypeID, 
            AccountNumber, 
            DatePriceUpdated,                       
			ClientGenerated, 
			FundID, 
			ExcludeFromReports, 
			OLDeleted, 
			PlanStatus, 
			fundcode, 
			[Type], 
			TYPECODE, 
			PortfolioDataCreatedDate, 
			ModelWeightingPercentage, 
			Liquidity, 
			RiskProfile, 
			RetentionTerm, 
			MFPercent,			
			(select SUM(CurrentValueClient)
				from NavGlobalDBwwwGUID.dbo.PortfolioDetailsTest2 
				where	ClientID = @param_strClientID 
				and PortfolioID = @param_strPortfolioID 
				and OLDeleted = 0) as TotalCurrentValueClient,
			(select NavGlobalDBwwwGUID.dbo.Portfolio.SwitchIFAPermit
				from NavGlobalDBwwwGUID.dbo.Portfolio
				where	ClientID = @param_strClientID 
						and PortfolioID = @param_strPortfolioID 
						and OLDeleted = 0) as SwitchIFAPermit
         
	from NavGlobalDBwwwGUID.dbo.PortfolioDetailsTest2 
	where	ClientID = @param_strClientID 
			and PortfolioID = @param_strPortfolioID 
			and OLDeleted = 0 
	order by NameOfFund, DataDate desc

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_Output_Log]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SWITCH_Output_Log]
	-- Add the parameters for the stored procedure here
	@SwitchType varchar(50),
	@SwitchID int,
	@Filename varchar(255),
	@OutputType varchar(50)
AS
BEGIN
	insert into [NavIntegrationDB].[dbo].[Switch_Output](
			[SwitchType]
		  ,[SwitchID]
		  ,[DateCreated]
		  ,[FileName]
		  ,[OutputType])
	values(
		@SwitchType,
		@SwitchID,
		CURRENT_TIMESTAMP,
		@Filename,
		@OutputType
		)
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_IFAGet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_IFAGet] 

@param_intIFA_ID int

AS
BEGIN

	SET NOCOUNT ON;
	
SELECT [IFA_ID]
      ,[IFA_Code]
      ,[IFA_Name]
      ,[IFA_Currency]
      ,[IFAUpdatedDate]
      ,[IFAAdd1]
      ,[IFAAdd2]
      ,[IFAAdd3]
      ,[IFACountry]
      ,[IFAPrincipal]
      ,[IFATel]
      ,[IFAFax]
      ,[IFAEmail]
      ,[IFAWebsiteContact]
      ,[IFATechContact]
      ,[IFADataEntryEmail]
      ,[IFAShowOnWeb]
      ,[SuperIFAID]
      ,[IncludeInBilling]
      ,[IFAODEEmail]
      ,[IFAPaymentReceived]
      ,[ContributionsOnWeb]
      ,[ClientNamesOnWeb]
      ,[ClientDetailsOnWeb]

FROM [NavGlobalDBwwwGUID].[dbo].[IFA]
WHERE ([IFA_ID] = @param_intIFA_ID OR @param_intIFA_ID = '')
	

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_HeaderUpdate]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_HeaderUpdate] 

@param_intSwitchID int,
@param_Status smallint,
@param_Description nvarchar(max) = null

AS
BEGIN

	SET NOCOUNT ON;
	
	IF @param_Description = null Begin

		UPDATE SwitchHeader
		SET [Status] = @param_Status
		WHERE [SwitchID] = @param_intSwitchID

	END
	ELSE Begin
		UPDATE SwitchHeader
		SET [Status] = @param_Status, Description = @param_Description
		WHERE [SwitchID] = @param_intSwitchID
	END 
	
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_HeaderInsert]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_HeaderInsert]

	 @param_strPortfolioID	NVARCHAR(50)
	,@param_strClientID		NVARCHAR(50)
	,@param_intStatus		SMALLINT
	,@param_strCreated_By	NVARCHAR(50)
	,@param_intSwitchID		INT				= NULL
	,@param_strDescription	NVARCHAR(MAX)
	
AS
BEGIN

SET NOCOUNT ON;



--IF NOT EXISTS (SELECT PortfolioID FROM [NavIntegrationDB].[dbo].[SwitchHeader] WHERE PortfolioID=@param_strPortfolioID AND [Status] = 0)
--IF @param_intSwitchID = NULL
IF NOT EXISTS (SELECT PortfolioID FROM [NavIntegrationDB].[dbo].[SwitchHeader] WHERE [SwitchID] = @param_intSwitchID)
BEGIN
	--RAISERROR('Switch details already exists!', 16, 1) 
	INSERT INTO [NavIntegrationDB].[dbo].[SwitchHeader]
		   ([PortfolioID]
		   ,[ClientID]
		   ,[Status]
		   ,[Date_Created]
		   ,[Created_By]
		   ,[Description] 
		   )
	 VALUES
		   (@param_strPortfolioID
		   ,@param_strClientID
		   ,@param_intStatus
		   ,CURRENT_TIMESTAMP
		   ,@param_strCreated_By
		   ,@param_strDescription
		   );
		   
	SELECT @@IDENTITY 
END
ELSE
BEGIN
	IF(LEN(@param_strDescription) = 0)
		BEGIN
			UPDATE [NavIntegrationDB].[dbo].[SwitchHeader]
			SET [Status] = @param_intStatus, [SecurityCodeAttempt] = 0
			WHERE [SwitchID] = @param_intSwitchID;		
		END
	ELSE
		BEGIN
			UPDATE [NavIntegrationDB].[dbo].[SwitchHeader]
			SET [Status] = @param_intStatus, [SecurityCodeAttempt] = 0, [Description] = @param_strDescription
			WHERE [SwitchID] = @param_intSwitchID;
		END
	
	SELECT @param_intSwitchID

END
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_HeaderGetAllByIFA]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_HeaderGetAllByIFA]

@param_IFA_ID		NVARCHAR(50),
@param_ClientName	NVARCHAR(50),
@param_Company		NVARCHAR(50),
@param_Status		INT,
@param_StartDate	NVARCHAR(10),
@param_EndDate		NVARCHAR(10)

AS
BEGIN
	SELECT 
		 SH.SwitchID
		,SH.PortfolioID
		,SH.ClientID 
		,SH.Status 
		,SH.Date_Created
		,SH.Created_By
		,SH.SecurityCodeAttempt
		,SH.Description
	FROM NavIntegrationDB.dbo.SwitchHeader SH 
	INNER JOIN NavGlobalDBwwwGUID.dbo.Portfolio P on P.ClientID = SH.ClientID AND P.PortfolioID = SH.PortfolioID
	INNER JOIN NavGlobalDBwwwGUID.dbo.Client C ON C.ClientID = SH.ClientID
	INNER JOIN NavGlobalDBwwwGUID.dbo.ClientWebDetails CWD ON CWD.ClientID = SH.ClientID
	INNER JOIN NavGlobalDBwwwGUID.dbo.Company CO ON CO.CompanyID = P.Company
	
	WHERE C.IFA_ID = @param_IFA_ID
	AND (UPPER(CWD.Forenames) + ' ' +UPPER(CWD.Surname) LIKE '%' + UPPER(@param_ClientName) + '%' OR @param_ClientName = '')
	AND (UPPER(CO.Company) LIKE '%' + UPPER(@param_Company) + '%' OR @param_Company = '')
	AND (SH.Status = @param_Status OR @param_Status = '0')
	AND (CONVERT(VARCHAR(10),SH.Date_Created,105) >= @param_StartDate OR @param_StartDate = '')
	AND (CONVERT(VARCHAR(10),SH.Date_Created,105) <= @param_EndDate OR @param_EndDate = '' )
	AND SH.Status > 0
	ORDER BY SH.Date_Created DESC

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_HeaderGet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_HeaderGet] 

@param_strPortfolioID	nvarchar(50) = NULL,
@param_strClientID		nvarchar(50) = NULL,
@param_intSwitchID		INT = NULL

AS
BEGIN

	SET NOCOUNT ON;
IF EXISTS (SELECT SwitchID FROM [NavIntegrationDB].[dbo].[SwitchHeader] WHERE SwitchID = @param_intSwitchID)	
	BEGIN
		SELECT	PortfolioID
				,ClientID
				,SwitchID
				,[Status]
				,Date_Created
				,Created_By
				,SecurityCodeAttempt
				,[Description]
				,Amend_Status
				,Amend_Description				
		FROM [NavIntegrationDB].[dbo].[SwitchHeader]
		WHERE SwitchID = @param_intSwitchID
	END
ELSE
	BEGIN
		SELECT	PortfolioID
				,ClientID
				,SwitchID
				,[Status]
				,Date_Created
				,Created_By
				,SecurityCodeAttempt
				,[Description]
				,Amend_Status
				,Amend_Description				
		FROM [NavIntegrationDB].[dbo].[SwitchHeader]
		WHERE PortfolioID = @param_strPortfolioID
			AND ClientID = @param_strClientID
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_GenerateCodeInsert]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_GenerateCodeInsert]

	  @param_Code			NVARCHAR(16)
	 ,@param_SwitchID		INT 
	 ,@param_ClientID		NVARCHAR(20)
	 ,@param_PortfolioID	NVARCHAR(20)
AS
BEGIN
	DECLARE @return_Valid int

SET NOCOUNT ON;
IF NOT EXISTS (SELECT [Code]  FROM [NavIntegrationDB].[dbo].[SwitchGenerateCode] WHERE [Code] = @param_Code)
 BEGIN
	INSERT INTO [NavIntegrationDB].[dbo].[SwitchGenerateCode]
		([Code])
	 VALUES
		(@param_Code);
		
	 IF ((SELECT COUNT(*) FROM  [NavIntegrationDB].[dbo].[SwitchClientSecurityCode] WHERE SwitchID = @param_SwitchID and ClientID = @param_ClientID and PortfolioID = @param_PortfolioID) > 0)
		BEGIN
			DELETE FROM [NavIntegrationDB].[dbo].[SwitchGenerateCode] WHERE Code = 
				(SELECT Code FROM [NavIntegrationDB].[dbo].[SwitchClientSecurityCode] WHERE SwitchID = @param_SwitchID and ClientID = @param_ClientID and PortfolioID = @param_PortfolioID)
			UPDATE [NavIntegrationDB].[dbo].[SwitchClientSecurityCode]
				SET Code = @param_Code, IsConsumed = 0
			WHERE SwitchID = @param_SwitchID and ClientID = @param_ClientID and PortfolioID = @param_PortfolioID
		END
	  ELSE 
		BEGIN
			INSERT INTO [NavIntegrationDB].[dbo].[SwitchClientSecurityCode]
				(Code, SwitchID, ClientID, PortfolioID)
			VALUES
				(@param_Code, @param_SwitchID, @param_ClientID, @param_PortfolioID)
		END


		SET @return_Valid = 1
	END

ELSE IF EXISTS (SELECT [Code]  FROM [NavIntegrationDB].[dbo].[SwitchGenerateCode] WHERE DATEDIFF(dd,DateCreated,GETDATE())  > 30 AND [Code] = @param_Code)
	BEGIN
		UPDATE [NavIntegrationDB].[dbo].[SwitchGenerateCode]
			SET DateCreated = GETDATE()
			WHERE Code = @param_Code
		IF ((SELECT COUNT(*) FROM  [NavIntegrationDB].[dbo].[SwitchClientSecurityCode] WHERE SwitchID = @param_SwitchID and ClientID = @param_ClientID and PortfolioID = @param_PortfolioID) > 0)
		BEGIN
			DELETE FROM [NavIntegrationDB].[dbo].[SwitchGenerateCode] WHERE Code = 
				(SELECT Code FROM [NavIntegrationDB].[dbo].[SwitchClientSecurityCode] WHERE SwitchID = @param_SwitchID and ClientID = @param_ClientID and PortfolioID = @param_PortfolioID)
			UPDATE [NavIntegrationDB].[dbo].[SwitchClientSecurityCode]
				SET Code = @param_Code, IsConsumed = 0
			WHERE SwitchID = @param_SwitchID and ClientID = @param_ClientID and PortfolioID = @param_PortfolioID
		END
	  ELSE 
		BEGIN
			INSERT INTO [NavIntegrationDB].[dbo].[SwitchClientSecurityCode]
				(Code, SwitchID, ClientID, PortfolioID)
			VALUES
				(@param_Code, @param_SwitchID, @param_ClientID, @param_PortfolioID)
		END

		SET @return_Valid = 1
	END
SELECT ISNULL(@return_Valid,0)
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_FundGetAll]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_FundGetAll]

	@param_strFundName		NVARCHAR(50) = NULL

AS
BEGIN

	SET NOCOUNT ON;
	
	IF @param_strFundName is null BEGIN
		SELECT	FundNameID
				,FundName
				,FundManager
				,Sector
				,SubSector
				,Currency
				,Price
				,DatePriceUpdated
				,Renewalsperannum
				,SEDOL
				,FundCreatedDate
				,FundUpdatedDate
				,FundUpdatedBy
				,CompanyID
				,FeedSource
				,FeedListID
				,FundStatus
				,ParentFundNameID
				,ExpiryDate
				,CITICODE
				,ISINCODE
				,TYPECODE
				,FundTypeID
				,SecurityTypeID
				,Checked
		FROM NavGlobalDBwwwGUID.dbo.Fund
		ORDER BY FundName
	END
	ELSE BEGIN
		SELECT	FundNameID
				,FundName
				,FundManager
				,Sector
				,SubSector
				,Currency
				,Price
				,DatePriceUpdated
				,Renewalsperannum
				,SEDOL
				,FundCreatedDate
				,FundUpdatedDate
				,FundUpdatedBy
				,CompanyID
				,FeedSource
				,FeedListID
				,FundStatus
				,ParentFundNameID
				,ExpiryDate
				,CITICODE
				,ISINCODE
				,TYPECODE
				,FundTypeID
				,SecurityTypeID
				,Checked
		FROM NavGlobalDBwwwGUID.dbo.Fund
		WHERE Upper(FundName) LIKE '%' + Upper(@param_strFundName) + '%'
		ORDER BY FundName
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_FundGet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_FundGet] 

@param_intFundNameID int

AS
BEGIN

	SET NOCOUNT ON;
	
	select  FundNameID
      ,FundName
      ,FundManager
      ,Sector
      ,SubSector
      ,Currency
      ,Price
      ,DatePriceUpdated
      ,Renewalsperannum
      ,SEDOL
      ,FundCreatedDate
      ,FundUpdatedDate
      ,FundUpdatedBy
      ,CompanyID
      ,FeedSource
      ,FeedListID
      ,FundStatus
      ,ParentFundNameID
      ,ExpiryDate
      ,CITICODE
      ,ISINCODE
      ,TYPECODE
      ,FundTypeID
      ,SecurityTypeID
      ,Checked
      
  FROM NavGlobalDBwwwGUID.dbo.Fund
  WHERE FundNameID = @param_intFundNameID

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_FeeSave]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_FeeSave]

@param_intIFA_ID		INT,
@param_IFA_Username		NVARCHAR(50),
@param_Annual_Fee		DECIMAL(18,2),
@param_Per_Switch_Fee	DECIMAL(18,2),
@param_Created_By		NVARCHAR(50),
@param_Updated_By		NVARCHAR(50),
@param_Access_Denied	BIT

AS
BEGIN
	IF EXISTS(SELECT IFA_ID FROM [NavIntegrationDB].[dbo].[SwitchFee] WHERE IFA_ID = @param_intIFA_ID)
		BEGIN
			IF((SELECT [Per_Switch_Fee] FROM [NavIntegrationDB].[dbo].[SwitchFee] WHERE IFA_ID = @param_intIFA_ID) <> @param_Per_Switch_Fee)
				BEGIN
					INSERT INTO [NavIntegrationDB].[dbo].[SwitchFeeHistory]
						(IFA_ID
						,IFA_Username
						,Annual_Fee
						,Per_Switch_Fee
						,Date_Created
						,Date_Effectivity
						,History_Created_By)
					SELECT 
							 IFA_ID
							,IFA_Username
							,Annual_Fee
							,Per_Switch_Fee
							,GETDATE()
							,Date_Updated
							,Updated_By
					FROM [NavIntegrationDB].[dbo].[SwitchFee]
					WHERE IFA_ID = @param_intIFA_ID
				END
			UPDATE [NavIntegrationDB].[dbo].[SwitchFee]
				SET [Annual_Fee] = @param_Annual_Fee,
					[Per_Switch_Fee] = @param_Per_Switch_Fee,
					[Date_Updated] = GETDATE(),
					[Updated_By] = @param_Updated_By,
					[Access_Denied] = @param_Access_Denied 
				WHERE 
					IFA_ID = @param_intIFA_ID
			
			
		END
	ELSE
		BEGIN
			INSERT INTO [NavIntegrationDB].[dbo].[SwitchFee]
			   ([IFA_ID]
			   ,[IFA_Username]
			   ,[Annual_Fee]
			   ,[Per_Switch_Fee]
			   ,[Date_Created]
			   ,[Created_By]
			   ,[Access_Denied])
			VALUES
			   (@param_intIFA_ID
			   ,@param_IFA_Username
			   ,@param_Annual_Fee
			   ,@param_Per_Switch_Fee
			   ,GETDATE()
			   ,@param_Created_By
			   ,@param_Access_Denied)
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_FeeReportGet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_FeeReportGet]

@param_intIFA_ID	INT,
@param_StartDate	NVARCHAR(10),
@param_EndDate		NVARCHAR(10)

AS
BEGIN
	SELECT 
	--Create Open XML to Select all SwitchID belongs to Per Switch Fee
	stuff((SELECT ',' + CONVERT(VARCHAR(3),a.SwitchID) FROM NavIntegrationDB.dbo.SwitchHeader a 
		INNER JOIN NavGlobalDBwwwGUID.dbo.Client AS C ON C.ClientID=a.ClientID
		INNER JOIN NavGlobalDBwwwGUID.dbo.IFA AS I ON I.IFA_ID=C.IFA_ID
		INNER JOIN (
		SELECT 
			a.IFA_ID,
			a.Annual_Fee,
			a.Per_Switch_Fee,
			CONVERT(VARCHAR(19),a.Date_Effectivity,121) AS Start_Date_Effective,
			CONVERT(VARCHAR(19),(DATEADD(SECOND,-1,
													(ISNULL((SELECT TOP 1 b.Date_Effectivity FROM
																							(SELECT IFA_ID, Annual_Fee, Per_Switch_Fee, Date_Updated AS Date_Effectivity FROM NavIntegrationDB.dbo.SwitchFee
																							UNION
																							SELECT IFA_ID, Annual_Fee, Per_Switch_Fee, Date_Effectivity FROM NavIntegrationDB.dbo.SwitchFeeHistory) AS b 
															WHERE b.IFA_ID = a.IFA_ID and b.Date_Effectivity > a.Date_Effectivity ORDER BY b.Date_Effectivity ASC), 
													GETDATE())))),
			121) AS End_Date_Effective
		FROM
			(
			SELECT IFA_ID, Annual_Fee, Per_Switch_Fee, Date_Updated AS Date_Effectivity FROM NavIntegrationDB.dbo.SwitchFee
			UNION
			SELECT IFA_ID, Annual_Fee, Per_Switch_Fee, Date_Effectivity FROM NavIntegrationDB.dbo.SwitchFeeHistory
			) AS a ) y ON	--ISNULL(a.Date_Updated, a.Date_Created) 
							a.Date_Created
							BETWEEN y.Start_Date_Effective AND y.End_Date_Effective AND y.IFA_ID=I.IFA_ID AND y.Per_Switch_Fee=TBLFEE.Per_Switch_Fee 
							WHERE a.Status = 6 AND (CONVERT(VARCHAR(10),a.Date_Created,105) >= @param_StartDate OR @param_StartDate = '') AND (CONVERT(VARCHAR(10),a.Date_Created,105) <= @param_EndDate OR @param_EndDate = '' )
									 ORDER BY SwitchID
									   FOR XML PATH('')
									),1,1,'')  as [Switches],
	-----------------------------------------------------------------------------------------------
		 I.IFA_ID
		,I.IFA_Name
		,TBLFEE.Per_Switch_Fee
		,COUNT(SH.SwitchID) AS Quantity
		,(SELECT MIN(Date_Created) AS StartDate FROM NavIntegrationDB.dbo.SwitchHeader a INNER JOIN NavGlobalDBwwwGUID.dbo.Client b ON a.ClientID=b.ClientID WHERE b.IFA_ID = C.IFA_ID) AS StartDate
		,(SELECT MAX(Date_Created) AS StartDate FROM NavIntegrationDB.dbo.SwitchHeader a INNER JOIN NavGlobalDBwwwGUID.dbo.Client b ON a.ClientID=b.ClientID WHERE b.IFA_ID = C.IFA_ID) AS EndDate
		--,(SELECT MIN(ISNULL(Date_Updated, Date_Created)) AS StartDate FROM NavIntegrationDB.dbo.SwitchHeader a INNER JOIN NavGlobalDBwwwGUID.dbo.Client b ON a.ClientID=b.ClientID WHERE b.IFA_ID = C.IFA_ID) AS StartDate
		--,(SELECT MAX(ISNULL(Date_Updated, Date_Created)) AS StartDate FROM NavIntegrationDB.dbo.SwitchHeader a INNER JOIN NavGlobalDBwwwGUID.dbo.Client b ON a.ClientID=b.ClientID WHERE b.IFA_ID = C.IFA_ID) AS EndDate
		,SH.Status
		
	FROM NavIntegrationDB.dbo.SwitchHeader SH
	INNER JOIN NavGlobalDBwwwGUID.dbo.Client AS C ON C.ClientID=SH.ClientID
	INNER JOIN NavGlobalDBwwwGUID.dbo.IFA AS I ON I.IFA_ID=C.IFA_ID
	INNER JOIN (
	SELECT 
		a.IFA_ID,
		a.Annual_Fee,
		a.Per_Switch_Fee,
		CONVERT(VARCHAR(19),a.Date_Effectivity,121) AS Start_Date_Effective,
		CONVERT(VARCHAR(19),(DATEADD(SECOND,-1,
												(ISNULL((SELECT TOP 1 b.Date_Effectivity FROM
																						(SELECT IFA_ID, Annual_Fee, Per_Switch_Fee, Date_Updated AS Date_Effectivity FROM NavIntegrationDB.dbo.SwitchFee
																						UNION
																						SELECT IFA_ID, Annual_Fee, Per_Switch_Fee, Date_Effectivity FROM NavIntegrationDB.dbo.SwitchFeeHistory) AS b 
														WHERE b.IFA_ID = a.IFA_ID and b.Date_Effectivity > a.Date_Effectivity ORDER BY b.Date_Effectivity ASC), 
												GETDATE())))),
		121) AS End_Date_Effective
	FROM
		(
		SELECT IFA_ID, Annual_Fee, Per_Switch_Fee, Date_Updated AS Date_Effectivity FROM NavIntegrationDB.dbo.SwitchFee
		UNION
		SELECT IFA_ID, Annual_Fee, Per_Switch_Fee, Date_Effectivity FROM NavIntegrationDB.dbo.SwitchFeeHistory
		) AS a ) TBLFEE ON TBLFEE.IFA_ID = I.IFA_ID
	WHERE 
		SH.Status = 6
	AND 
		--ISNULL(SH.Date_Updated, SH.Date_Created)
		SH.Date_Created
		BETWEEN TBLFEE.Start_Date_Effective AND TBLFEE.End_Date_Effective
	AND (CONVERT(VARCHAR(10),SH.Date_Created,105) >= @param_StartDate OR @param_StartDate = '')
	AND (CONVERT(VARCHAR(10),SH.Date_Created,105) <= @param_EndDate OR @param_EndDate = '' )
	AND C.IFA_ID = @param_intIFA_ID
	GROUP BY  I.IFA_ID, I.IFA_Name, TBLFEE.Per_Switch_Fee, SH.Status, C.IFA_ID
	--SELECT 
	--	 Switches
	--	,IFA_ID
	--	,IFA_Name
	--	,Per_Switch_Fee 
	--	,Quantity
	--	,StartDate 
	--	,EndDate 
	--	,Status 
	--FROM [NavIntegrationDB].[dbo].[PerSwitchFeeReport]
	--WHERE (IFA_ID = @param_intIFA_ID OR @param_intIFA_ID = 0)
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_FeeGet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_FeeGet]

@param_intIFA_ID		INT

AS
BEGIN
	SELECT [IFA_ID]
      ,[IFA_Username]
      ,[Annual_Fee]
      ,[Per_Switch_Fee]
      ,[Date_Created]
      ,[Created_By]
      ,[Access_Denied]
	FROM [NavIntegrationDB].[dbo].[SwitchFee]
	WHERE (IFA_ID = @param_intIFA_ID OR @param_intIFA_ID = 0)
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_FeeDelete]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_FeeDelete]

@param_intIFA_ID		INT

AS

BEGIN
	DELETE 
	FROM [NavIntegrationDB].[dbo].[SwitchFee] 
	WHERE IFA_ID = @param_intIFA_ID
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_EmailTemplateUpdate]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_EmailTemplateUpdate] 

	@param_intEmailTemplateID	int,
	@param_strTemplateName		nvarchar(100),
	@param_strDescription		nvarchar(100),
	@param_strBody				nvarchar(max)

AS
BEGIN

	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT EmailTemplateID FROM dbo.Switch_EmailTemplate WHERE TemplateName = @param_strTemplateName AND EmailTemplateID <> @param_intEmailTemplateID)
	BEGIN
		UPDATE dbo.Switch_EmailTemplate
		SET Description = @param_strDescription,
			Body = @param_strBody
		WHERE EmailTemplateID = @param_intEmailTemplateID
	END
	ELSE
		BEGIN
			RAISERROR('Template name already exists.', 16, 1)		
		END

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_EmailTemplateInsert]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_EmailTemplateInsert] 
	@param_strTemplateName nvarchar(100),
	@param_strDescription	nvarchar(100),
	@param_strBody		nvarchar(max)

AS
BEGIN

	SET NOCOUNT ON;
	IF NOT EXISTS (SELECT EmailTemplateID, TemplateName, Description, Body FROM dbo.Switch_EmailTemplate WHERE TemplateName = @param_strTemplateName)
		BEGIN
			INSERT INTO dbo.Switch_EmailTemplate
			(TemplateName, Description, Body)
			VALUES
			(@param_strTemplateName, @param_strDescription, @param_strBody)
		END	
	ELSE
		BEGIN
			RAISERROR('Template name already exists.', 16, 1)		
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_EmailTemplateGetAll]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_EmailTemplateGetAll] 

AS
BEGIN

	SET NOCOUNT ON;

		SELECT	EmailTemplateID, TemplateName, Description, Body
		FROM dbo.Switch_EmailTemplate
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_EmailTemplateGet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_EmailTemplateGet] 

@param_intEmailTemplateID	int = null,
@param_strTemplateName		nvarchar(100) = null

AS
BEGIN

	SET NOCOUNT ON;

IF EXISTS (SELECT EmailTemplateID FROM dbo.Switch_EmailTemplate WHERE EmailTemplateID = @param_intEmailTemplateID AND TemplateName = @param_strTemplateName)
	BEGIN
		SELECT	EmailTemplateID, TemplateName, Description, Body
		FROM	dbo.Switch_EmailTemplate
		WHERE	EmailTemplateID = @param_intEmailTemplateID 
				AND TemplateName = @param_strTemplateName
	END
ELSE IF EXISTS (SELECT EmailTemplateID FROM dbo.Switch_EmailTemplate WHERE TemplateName = @param_strTemplateName)
	BEGIN
		SELECT	EmailTemplateID, TemplateName, Description, Body
		FROM	dbo.Switch_EmailTemplate 
		WHERE	TemplateName = @param_strTemplateName
	END
ELSE
	BEGIN
		SELECT	EmailTemplateID, TemplateName, Description, Body
		FROM	dbo.Switch_EmailTemplate 
		WHERE	EmailTemplateID = @param_intEmailTemplateID
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_EmailTemplateDelete]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_EmailTemplateDelete] 

@param_intEmailTemplateID	int

AS
BEGIN

	SET NOCOUNT ON;

	DELETE FROM dbo.Switch_EmailTemplate WHERE EmailTemplateID = @param_intEmailTemplateID;

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_EmailLogInsert]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_EmailLogInsert]

	@param_intSwitchID		int
	,@param_strRecipient	nvarchar(255)
	,@param_strClientID		nvarchar(50)
	,@param_strMessage		nvarchar(max)
	,@param_strPurpose		nvarchar(100)

AS
BEGIN

SET NOCOUNT ON;


INSERT INTO [NavIntegrationDB].[dbo].[SwitchEmail_Logs]
           ([SwitchID]
           ,[Recipient]
           ,[ClientID]
           ,[Message]
           ,[DateSent]
		   ,Purpose)
     VALUES
           (@param_intSwitchID
           ,@param_strRecipient
           ,@param_strClientID
           ,@param_strMessage
           ,CURRENT_TIMESTAMP
		   ,@param_strPurpose)
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_DetailsInsert]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_DetailsInsert]
	
	  @param_intSwitchID			INT
     ,@param_intFundID				INT
     ,@param_fAllocation			FLOAT
     ,@param_strCreated_By			NVARCHAR(50)
     ,@param_strUpdated_By			NVARCHAR(50)
     ,@param_intSwitchDetailsID		INT = NULL
	 ,@param_sintIsDeletable		SMALLINT
     
AS
BEGIN
	
	SET NOCOUNT ON;
IF EXISTS (SELECT SwitchDetailsID,SwitchID  FROM [NavIntegrationDB].[dbo].[SwitchDetails] WHERE SwitchDetailsID = @param_intSwitchDetailsID AND SwitchID = @param_intSwitchID)
	BEGIN
		UPDATE NavIntegrationDB.dbo.SwitchDetails
			SET	[FundID] = @param_intFundID
			   ,[Allocation] = @param_fAllocation
			   ,[Created_By] = @param_strCreated_By
			   ,[Date_LastUpdate] = CURRENT_TIMESTAMP
			   ,[Updated_By] = @param_strUpdated_By
			   ,[isDeletable] = @param_sintIsDeletable
		WHERE SwitchDetailsID = @param_intSwitchDetailsID AND SwitchID = @param_intSwitchID 
	END
ELSE
	BEGIN
		INSERT INTO [NavIntegrationDB].[dbo].[SwitchDetails]
			   ([SwitchID]
			   ,[FundID]
			   ,[Allocation]
			   ,[Created_By]
			   ,[Date_Created]
			   ,[Date_LastUpdate]
			   ,[Updated_By]
			   ,[isDeletable])
		 VALUES
			   (@param_intSwitchID
			   ,@param_intFundID
			   ,@param_fAllocation
			   ,@param_strCreated_By
			   ,CURRENT_TIMESTAMP
			   ,CURRENT_TIMESTAMP
			   ,@param_strUpdated_By
			   ,@param_sintIsDeletable)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_DetailsGet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_DetailsGet] 

@param_intSwitchID int

AS
BEGIN

	SET NOCOUNT ON;
	
	select  SwitchDetailsID
      ,SwitchID
      ,FundID
      ,Allocation
      ,Date_Created
      ,Created_By
      ,Date_LastUpdate
      ,Updated_By
	  ,isDeletable
  FROM SwitchDetails
  WHERE SwitchID = @param_intSwitchID

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_DetailsDelete]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_DetailsDelete]
	@param_intSwitchDetailsID	INT
     
AS
BEGIN
	
SET NOCOUNT ON;

DELETE FROM dbo.SwitchDetails
WHERE SwitchDetailsID = @param_intSwitchDetailsID
	
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_Delete]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_Delete] 

@param_SwitchID int

AS
BEGIN

	DELETE 
	FROM SwitchDetails
	WHERE SwitchID = @param_SwitchID;
	
	DELETE
	FROM SwitchHeader
	WHERE SwitchID = @param_SwitchID;

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHclient_HeaderUpdate]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHclient_HeaderUpdate]

	@param_intSwitchID		INT
	,@param_intStatus		SMALLINT
	,@param_strDescription	NVARCHAR(MAX) = null
AS
BEGIN

SET NOCOUNT ON;

	UPDATE [NavIntegrationDB].[dbo].[SwitchHeader]
	SET [Amend_Status] = @param_intStatus,
		[Amend_Description] = @param_strDescription
	WHERE [SwitchID] = @param_intSwitchID;

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHclient_DetailsInsert]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHclient_DetailsInsert]
	
	  @param_intSwitchID			INT
     ,@param_intFundID				INT
     ,@param_fAllocation			FLOAT
     ,@param_strCreated_By			NVARCHAR(50)
     ,@param_strUpdated_By			NVARCHAR(50)
     ,@param_intSwitchDetailsID		INT = NULL
	 ,@param_sintIsDeletable		SMALLINT
     
AS
BEGIN
	
	SET NOCOUNT ON;
IF EXISTS (SELECT SwitchDetailsID,SwitchID  FROM [NavIntegrationDB].[dbo].[SwitchDetails_Client] WHERE SwitchDetailsID = @param_intSwitchDetailsID AND SwitchID = @param_intSwitchID)
	BEGIN
		UPDATE NavIntegrationDB.dbo.SwitchDetails_Client
			SET	[FundID] = @param_intFundID
			   ,[Allocation] = @param_fAllocation
			   ,[Created_By] = @param_strCreated_By
			   ,[Date_LastUpdate] = CURRENT_TIMESTAMP
			   ,[Updated_By] = @param_strUpdated_By
			   ,[isDeletable] = @param_sintIsDeletable
		WHERE SwitchDetailsID = @param_intSwitchDetailsID AND SwitchID = @param_intSwitchID 
	END
ELSE
	BEGIN
		INSERT INTO [NavIntegrationDB].[dbo].[SwitchDetails_Client]
			   ([SwitchID]
			   ,[FundID]
			   ,[Allocation]
			   ,[Created_By]
			   ,[Date_Created]
			   ,[Date_LastUpdate]
			   ,[Updated_By]
			   ,[isDeletable])
		 VALUES
			   (@param_intSwitchID
			   ,@param_intFundID
			   ,@param_fAllocation
			   ,@param_strCreated_By
			   ,CURRENT_TIMESTAMP
			   ,CURRENT_TIMESTAMP
			   ,@param_strUpdated_By
			   ,@param_sintIsDeletable)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHclient_DetailsGet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHclient_DetailsGet] 

@param_intSwitchID int

AS
BEGIN

	SET NOCOUNT ON;
	
	select SwitchDetailsID
      ,SwitchID
      ,FundID
      ,Allocation
      ,Date_Created
      ,Created_By
      ,Date_LastUpdate
      ,Updated_By
	  ,isDeletable
  FROM dbo.SwitchDetails_Client
  WHERE SwitchID = @param_intSwitchID

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHclient_DetailsDelete]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHclient_DetailsDelete]
	@param_intSwitchDetailsID	INT
     
AS
BEGIN
	
SET NOCOUNT ON;

DELETE FROM dbo.SwitchDetails_Client
WHERE SwitchDetailsID = @param_intSwitchDetailsID
	
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHclient_Delete]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHclient_Delete] 

@param_SwitchID int

AS
BEGIN

	DELETE 
	FROM dbo.SwitchDetails_Client
	WHERE SwitchID = @param_SwitchID;
	
	UPDATE [NavIntegrationDB].[dbo].[SwitchHeader]
	SET [Amend_Status] = null,
		[Amend_Description] = null
	WHERE [SwitchID] = @param_SwitchID;

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCHclient_Decline]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCHclient_Decline] 

@param_SwitchID int

AS
BEGIN

	UPDATE dbo.SwitchHeader
	SET [Status] = 5
	WHERE [SwitchID] = @param_SwitchID

END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_SignedConfirmationSet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_SignedConfirmationSet]

 @CompanyID int,
 @status bit
AS
BEGIN
 SET NOCOUNT ON;

    if @status = 1
  begin
   if not exists(select * from Switch_EmailSignedConfirmation where CompanyID = @CompanyID)
   begin
    insert into Switch_EmailSignedConfirmation(CompanyID) values(@CompanyID)
   end
  end
    else
  begin
   delete from Switch_EmailSignedConfirmation where CompanyID = @CompanyID
  end
 
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_SignedConfirmationGetAll]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_SignedConfirmationGetAll]

AS
BEGIN

 SET NOCOUNT ON;

   
 SELECT C.CompanyID, C.Company, NavIntegrationDB.dbo.IsCompanyInEmailSignedConfirmation(C.CompanyID) as 'IsRequired'
 FROM NavGlobalDBwwwGUID.dbo.Company C
 --WHERE UPPER(C.CompanyType) like 'INSURANCE%'
END
GO
/****** Object:  StoredProcedure [dbo].[SWITCH_CompanyGet]    Script Date: 02/07/2012 11:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SWITCH_CompanyGet] 

 @param_intCompanyID int

AS
BEGIN

 SET NOCOUNT ON;

 SELECT [CompanyID]
    ,[Company]
    ,[CompanyAdd1]
    ,[CompanyAdd2]
    ,[CompanyAdd3]
    ,[CompanyCountry]
    ,[CompanyTel]
    ,[CompanyFax]
    ,[CompanyEmail]
    ,[CompanyWebSite]
    ,[CompanyType]
    ,[FeedListID],
    dbo.IsCompanyInEmailSignedConfirmation(CompanyID) as IsRequiredSignedConfirmation
 FROM [NavGlobalDBwwwGUID].[dbo].[Company]

 WHERE CompanyID = @param_intCompanyID 

END
GO
