USE [NavIntegrationDB]
GO
/****** Object:  User [BUILTIN\Users]    Script Date: 02/07/2012 11:49:43 ******/
CREATE USER [BUILTIN\Users] FOR LOGIN [BUILTIN\Users]
GO
/****** Object:  Table [dbo].[Switch_SMSTemplate]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Switch_SMSTemplate](
	[SMSTemplateID] [smallint] IDENTITY(1,1) NOT NULL,
	[TemplateName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TemplateFor] [nchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Message] [nvarchar](160) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Switch_SMSTemplate] PRIMARY KEY CLUSTERED 
(
	[SMSTemplateID] ASC,
	[TemplateName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Switch_SMSTemplate] ON
INSERT [dbo].[Switch_SMSTemplate] ([SMSTemplateID], [TemplateName], [TemplateFor], [Message]) VALUES (1, N'ProposeSwitch', N'IFA proposing Switch to client                    ', N'Your IFA has proposed a change to the holdings in your {%PortfolioName%} portfolio. Please log into the NAV website to see the proposed change.')
INSERT [dbo].[Switch_SMSTemplate] ([SMSTemplateID], [TemplateName], [TemplateFor], [Message]) VALUES (2, N'SecurityCode', N'Sending security code to client                   ', N'Thank you for approving the change to your portfolio. Your security code is {%SecurityCode%}.')
INSERT [dbo].[Switch_SMSTemplate] ([SMSTemplateID], [TemplateName], [TemplateFor], [Message]) VALUES (3, N'Reset', N'Resetting the switch attempt                      ', N'The security code for your {%PortfolioName%} portfolio has been reset. Please log into the NAV website to confirm the proposed change.')
INSERT [dbo].[Switch_SMSTemplate] ([SMSTemplateID], [TemplateName], [TemplateFor], [Message]) VALUES (8, N'ProposeSchemeSwitch', N'*Official do not Delete!                          ', N'Your IFA has proposed a change to the holdings in your {%param_SchemeName%} Regular Savings. Please log into the NAV website to see the proposed change.')
INSERT [dbo].[Switch_SMSTemplate] ([SMSTemplateID], [TemplateName], [TemplateFor], [Message]) VALUES (9, N'SecurityCodeScheme', N'Sending scurity code to client (scheme switch)    ', N'Thank you for approving the change to your portfolio. Your security code is {%SecurityCode%}')
SET IDENTITY_INSERT [dbo].[Switch_SMSTemplate] OFF
/****** Object:  Table [dbo].[Switch_Output]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Switch_Output](
	[OutputID] [int] IDENTITY(1,1) NOT NULL,
	[SwitchType] [varchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[SwitchID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[FileName] [varchar](255) COLLATE Latin1_General_BIN NOT NULL,
	[OutputType] [varchar](50) COLLATE Latin1_General_BIN NOT NULL,
 CONSTRAINT [PK_SWITCH_Output] PRIMARY KEY CLUSTERED 
(
	[OutputID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'File name of the output document' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Switch_Output', @level2type=N'COLUMN',@level2name=N'FileName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Type of document e.g.:Excel, PDF, XML, and the like' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Switch_Output', @level2type=N'COLUMN',@level2name=N'OutputType'
GO
/****** Object:  Table [dbo].[Switch_EmailTemplate]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Switch_EmailTemplate](
	[EmailTemplateID] [int] IDENTITY(1,1) NOT NULL,
	[TemplateName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Description] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Body] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Switch_EmailTemplate] PRIMARY KEY CLUSTERED 
(
	[EmailTemplateID] ASC,
	[TemplateName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Switch_EmailTemplate] ON
INSERT [dbo].[Switch_EmailTemplate] ([EmailTemplateID], [TemplateName], [Description], [Body]) VALUES (1, N'ClientRequestContact', N'Template use by client requesting contact to IFA for further Switch instructions', N'<table> <tr><td align=''left''>Dear {%param_IFAName%} </td></tr> <tr><td align=''left''>The following client has requested contact from you about the proposed switch to their portfolio.</td></tr> <tr><td align=''left''><b>Client:</b> {%param_ClientName%} </td></tr> <tr><td align=''left''><b>Portfolio:</b> {%param_PortfolioName%} </td></tr> <tr><td align=''left''><b>Telephone Number:</b> {%param_ContactNo%} </td></tr> <tr><td align=''left''><b>Message:</b> {%param_Comment%} </td></tr> <tr><td align=''left''>Thank you.</td></tr> </table>')
INSERT [dbo].[Switch_EmailTemplate] ([EmailTemplateID], [TemplateName], [Description], [Body]) VALUES (2, N'ClientAmendmentNotification', N'Email IFA that a client amended the proposed Switch', N'Your client ({%param_ClientName%}) had made some amendments to the proposed switch and is requesting your approval.')
INSERT [dbo].[Switch_EmailTemplate] ([EmailTemplateID], [TemplateName], [Description], [Body]) VALUES (3, N'ClientDeclineNotification', N'Notify IFA that client declined the proposed Switch', N'<table> <tr><td align=''left''>Dear {%param_IFAName%} </td></tr> <tr><td align=''left''>Your client declined this switch proposal.</td></tr> <tr><td align=''left''><b>Client:</b> {%param_ClientName%} </td></tr> <tr><td align=''left''><b>Portfolio:</b> {%param_PortfolioName%} </td></tr> <tr><td align=''left''><b>Reason:</b> {%param_Comment%} </td></tr> <tr><td align=''left''>Thank you.</td></tr> </table>')
INSERT [dbo].[Switch_EmailTemplate] ([EmailTemplateID], [TemplateName], [Description], [Body]) VALUES (4, N'SchemeClientAmendmentNotification', N'Email IFA that a client amended the proposed Scheme Switch', N'Your client ({%param_ClientName%}) had made some amendments to the proposed scheme switch and is requesting your approval.')
INSERT [dbo].[Switch_EmailTemplate] ([EmailTemplateID], [TemplateName], [Description], [Body]) VALUES (5, N'NotifyApprovedEmail', N'Email Template for Sending Switch Instructions that does not requires Client approval.', N'<p>Please find attached the switch instructions for switch number {%SwitchID%}. These instructions should be sent to {%Company%} for processing.</p><p>Thanks</p><p style=''font-weight:bolder;''>NAV</p>')
INSERT [dbo].[Switch_EmailTemplate] ([EmailTemplateID], [TemplateName], [Description], [Body]) VALUES (6, N'NotifyApprovedEmailReqSign', N'Email Template for Sending Switch Instructions that requires', N'<p>Please find attached the switch instructions for switch number {%SwitchID%}.</p><p>Please note that you will need to receive a signed copy of these instructions from your client which will then need to be sent to {%Company%} for processing.</p><p>Thanks</p><p style=''font-weight:bolder;''>NAV</p>')
INSERT [dbo].[Switch_EmailTemplate] ([EmailTemplateID], [TemplateName], [Description], [Body]) VALUES (7, N'NotifyClientApprovedEmail', N'Email Template for Sending Switch Instructions to Client that does not requires Client approval.', N'<p>Please find attached details of the switch instructions for your {%param_PortfolioName%} portfolio.</p> 
<p>These instructions will be sent to {%Company%} for processing by your IFA.</p>
<p>Thanks</p>
<p>NAV</p>')
INSERT [dbo].[Switch_EmailTemplate] ([EmailTemplateID], [TemplateName], [Description], [Body]) VALUES (8, N'NotifyClientApprovedEmailReqSign', N'Email Template for Sending Switch Instructions to Client that requires Client approval.', N'<p>Please find attached details of the switch instructions for your {%param_PortfolioName%} portfolio.</p> 
<p>Please print and sign a copy of these instructions and return this to your IFA so that the confirmed instructions can be sent to {%Company%} for processing.</p>
<p>Thanks</p>
<p>NAV</p>')
SET IDENTITY_INSERT [dbo].[Switch_EmailTemplate] OFF
/****** Object:  Table [dbo].[Switch_EmailSignedConfirmation]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Switch_EmailSignedConfirmation](
	[CompanyID] [int] NOT NULL,
 CONSTRAINT [PK_SWITCH_EmailSignedConfirmation] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchSchemeHistoryMessages]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchSchemeHistoryMessages](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[HistoryID] [int] NOT NULL,
	[Message] [nvarchar](max) COLLATE Latin1_General_BIN NULL,
 CONSTRAINT [PK_SwitchSchemeHistoryMessages] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchSchemeHistoryHeader]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchSchemeHistoryHeader](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[SchemeID] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[SwitchID] [int] NOT NULL,
	[Action_Date] [datetime] NOT NULL,
	[Status] [smallint] NOT NULL,
 CONSTRAINT [PK_SwitchSchemeHistoryHeader] PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchSchemeHistoryDetails]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchSchemeHistoryDetails](
	[HistoryDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[HistoryID] [int] NOT NULL,
	[SwitchDetailsID] [int] NOT NULL,
	[FundID] [int] NOT NULL,
	[Allocation] [float] NOT NULL,
	[Date_Created] [datetime] NOT NULL,
	[Created_By] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[isContribution] [smallint] NOT NULL,
 CONSTRAINT [PK_SwitchSchemeHistoryDetails] PRIMARY KEY CLUSTERED 
(
	[HistoryDetailsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchSchemeHeader]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchSchemeHeader](
	[SchemeID] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[ClientID] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[SwitchID] [int] IDENTITY(1,1) NOT NULL,
	[Status] [smallint] NOT NULL,
	[Date_Created] [datetime] NOT NULL,
	[Created_By] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[SecurityCodeAttempt] [int] NOT NULL,
	[Description] [nvarchar](max) COLLATE Latin1_General_BIN NULL,
	[Amend_Status] [smallint] NULL,
	[Amend_Description] [nvarchar](max) COLLATE Latin1_General_BIN NULL,
 CONSTRAINT [PK_SwitchSchemeHeader] PRIMARY KEY CLUSTERED 
(
	[SwitchID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchSchemeDetails_Client]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchSchemeDetails_Client](
	[SwitchDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[SwitchID] [int] NOT NULL,
	[FundID] [int] NOT NULL,
	[Allocation] [float] NOT NULL,
	[Date_Created] [datetime] NOT NULL,
	[Created_By] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[Date_LastUpdate] [datetime] NULL,
	[Updated_By] [nvarchar](50) COLLATE Latin1_General_BIN NULL,
	[isDeletable] [smallint] NOT NULL,
	[isContribution] [smallint] NOT NULL,
 CONSTRAINT [PK_SwitchSchemeDetails_Client] PRIMARY KEY CLUSTERED 
(
	[SwitchDetailsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchSchemeDetails]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchSchemeDetails](
	[SwitchDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[SwitchID] [int] NOT NULL,
	[FundID] [int] NOT NULL,
	[Allocation] [float] NOT NULL,
	[Date_Created] [datetime] NOT NULL,
	[Created_By] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[Date_LastUpdate] [datetime] NULL,
	[Updated_By] [nvarchar](50) COLLATE Latin1_General_BIN NULL,
	[isDeletable] [smallint] NOT NULL,
	[isContribution] [smallint] NOT NULL,
 CONSTRAINT [PK_SwitchSchemeDetails] PRIMARY KEY CLUSTERED 
(
	[SwitchDetailsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchSchemeClientSecurityCode]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchSchemeClientSecurityCode](
	[CodeID] [int] IDENTITY(1,1) NOT NULL,
	[SwitchID] [int] NOT NULL,
	[Code] [nvarchar](20) COLLATE Latin1_General_BIN NOT NULL,
	[ClientID] [nvarchar](10) COLLATE Latin1_General_BIN NOT NULL,
	[SchemeID] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[IsConsumed] [nchar](1) COLLATE Latin1_General_BIN NOT NULL,
 CONSTRAINT [PK_SwitchSchemeClientSecurityCode] PRIMARY KEY CLUSTERED 
(
	[CodeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchSMSMessage]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchSMSMessage](
	[SMS_ID] [int] NOT NULL,
	[SMS_Type] [nvarchar](20) COLLATE Latin1_General_BIN NULL,
	[SMS_Message] [nvarchar](max) COLLATE Latin1_General_BIN NULL,
 CONSTRAINT [PK_SwitchSMSMessage] PRIMARY KEY CLUSTERED 
(
	[SMS_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[SwitchSMSMessage] ([SMS_ID], [SMS_Type], [SMS_Message]) VALUES (1, N'Notification', N'Your IFA has proposed a change to the holdings in your {0} portfolio. Please log into the NAV website to see the proposed change.')
INSERT [dbo].[SwitchSMSMessage] ([SMS_ID], [SMS_Type], [SMS_Message]) VALUES (2, N'SecurityCode', N'Thank you for approving the change to your portfolio. Your security code is {0}.')
INSERT [dbo].[SwitchSMSMessage] ([SMS_ID], [SMS_Type], [SMS_Message]) VALUES (3, N'CorrectCode', N'Thank you, the proposed changes will be made to your portfolio.')
INSERT [dbo].[SwitchSMSMessage] ([SMS_ID], [SMS_Type], [SMS_Message]) VALUES (4, N'IncorrectCode', N'Sorry, the security code you have entered is incorrect, please re-enter the security code. You have {0} more attempts.')
INSERT [dbo].[SwitchSMSMessage] ([SMS_ID], [SMS_Type], [SMS_Message]) VALUES (5, N'Locked', N'Sorry, you have entered the security code incorrectly three times. Please contact your IFA to have the security code reset.')
INSERT [dbo].[SwitchSMSMessage] ([SMS_ID], [SMS_Type], [SMS_Message]) VALUES (6, N'Reset', N'The security code for your {0} portfolio has been reset. Please log into the NAV website to confirm the proposed change.')
/****** Object:  Table [dbo].[SwitchHistoryMessages]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchHistoryMessages](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[HistoryID] [int] NOT NULL,
	[Message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_SwitchHistoryMessages_1] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchHistoryHeader]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchHistoryHeader](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[PortfolioID] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SwitchID] [int] NOT NULL,
	[Action_Date] [datetime] NOT NULL,
	[Status] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchHistoryDetails]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchHistoryDetails](
	[HistoryDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[HistoryID] [int] NOT NULL,
	[SwitchDetailsID] [int] NOT NULL,
	[FundID] [int] NOT NULL,
	[Allocation] [float] NOT NULL,
	[Date_Created] [datetime] NOT NULL,
	[Created_By] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_SwitchHistoryDetails] PRIMARY KEY CLUSTERED 
(
	[HistoryDetailsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchHeader]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchHeader](
	[PortfolioID] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[ClientID] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[SwitchID] [int] IDENTITY(1,1) NOT NULL,
	[Status] [smallint] NOT NULL,
	[Date_Created] [datetime] NOT NULL,
	[Created_By] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[SecurityCodeAttempt] [int] NOT NULL,
	[Description] [nvarchar](max) COLLATE Latin1_General_BIN NULL,
	[Amend_Status] [smallint] NULL,
	[Amend_Description] [nvarchar](max) COLLATE Latin1_General_BIN NULL,
 CONSTRAINT [PK_SwitchHeader] PRIMARY KEY CLUSTERED 
(
	[SwitchID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchGenerateCode]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchGenerateCode](
	[Code] [nvarchar](16) COLLATE Latin1_General_BIN NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateValidUntil]  AS (dateadd(day,(30),[DateCreated])),
 CONSTRAINT [PK_SwitchGenerateCode_1] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchFeeHistory]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchFeeHistory](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[IFA_ID] [int] NOT NULL,
	[IFA_Username] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[Annual_Fee] [decimal](18, 2) NOT NULL,
	[Per_Switch_Fee] [decimal](18, 2) NOT NULL,
	[Date_Created] [datetime] NOT NULL,
	[Date_Effectivity] [datetime] NOT NULL,
	[History_Created_By] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
 CONSTRAINT [PK_SwitchFeeHistory] PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchFee]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchFee](
	[IFA_ID] [int] NOT NULL,
	[IFA_Username] [nvarchar](50) COLLATE Latin1_General_BIN NULL,
	[Annual_Fee] [decimal](18, 2) NOT NULL,
	[Per_Switch_Fee] [decimal](18, 2) NOT NULL,
	[Date_Created] [datetime] NOT NULL,
	[Created_By] [nvarchar](50) COLLATE Latin1_General_BIN NULL,
	[Date_Updated] [datetime] NULL,
	[Updated_By] [nvarchar](50) COLLATE Latin1_General_BIN NULL,
	[Access_Denied] [bit] NOT NULL,
 CONSTRAINT [PK_SwitchFee] PRIMARY KEY CLUSTERED 
(
	[IFA_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchEmail_Logs]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchEmail_Logs](
	[EmailID] [int] IDENTITY(1,1) NOT NULL,
	[SwitchID] [int] NOT NULL,
	[Recipient] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ClientID] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DateSent] [datetime] NOT NULL,
	[Purpose] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_SwitchEmail_Logs] PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchEmail_ClientAmendReq]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchEmail_ClientAmendReq](
	[EmailID] [int] IDENTITY(1,1) NOT NULL,
	[SwitchID] [int] NOT NULL,
	[Recipient] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ClientID] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DateSent] [datetime] NOT NULL,
 CONSTRAINT [PK_SwitchEmail_ClientAmendReq] PRIMARY KEY CLUSTERED 
(
	[EmailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchDetails_Client]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchDetails_Client](
	[SwitchDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[SwitchID] [int] NOT NULL,
	[FundID] [int] NOT NULL,
	[Allocation] [float] NOT NULL,
	[Date_Created] [datetime] NOT NULL,
	[Created_By] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Date_LastUpdate] [datetime] NULL,
	[Updated_By] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[isDeletable] [smallint] NOT NULL,
 CONSTRAINT [PK_SwitchDetails_Client] PRIMARY KEY CLUSTERED 
(
	[SwitchDetailsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchDetails]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchDetails](
	[SwitchDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[SwitchID] [int] NOT NULL,
	[FundID] [int] NOT NULL,
	[Allocation] [float] NOT NULL,
	[Date_Created] [datetime] NOT NULL,
	[Created_By] [nvarchar](50) COLLATE Latin1_General_BIN NOT NULL,
	[Date_LastUpdate] [datetime] NULL,
	[Updated_By] [nvarchar](50) COLLATE Latin1_General_BIN NULL,
	[isDeletable] [smallint] NOT NULL,
 CONSTRAINT [PK_SwitchDetails] PRIMARY KEY CLUSTERED 
(
	[SwitchDetailsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SwitchClientSecurityCode]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwitchClientSecurityCode](
	[CodeID] [int] IDENTITY(1,1) NOT NULL,
	[SwitchID] [int] NOT NULL,
	[Code] [nvarchar](20) COLLATE Latin1_General_BIN NOT NULL,
	[ClientID] [nvarchar](10) COLLATE Latin1_General_BIN NOT NULL,
	[PortfolioID] [nvarchar](10) COLLATE Latin1_General_BIN NOT NULL,
	[Attempt] [int] NOT NULL,
	[IsConsumed] [nchar](1) COLLATE Latin1_General_BIN NOT NULL,
 CONSTRAINT [PK_SwitchClientSecurityCode] PRIMARY KEY CLUSTERED 
(
	[CodeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SessionState]    Script Date: 02/07/2012 11:49:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SessionState](
	[GUID] [char](38) COLLATE Latin1_General_BIN NOT NULL,
	[Session] [varchar](max) COLLATE Latin1_General_BIN NOT NULL,
	[Destination] [varchar](max) COLLATE Latin1_General_BIN NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_SessionState] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[SessionState] ([GUID], [Session], [Destination], [DateCreated]) VALUES (N'{B31DCFB5-D1A4-4379-81DF-A76430074364}', N'arr+++++ 1 2 3 4 5 10 14 15 19 20 22 23 28 32 33 35 37 38 40 42 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 72 73 148 149 150 152 155 158 159 160 161 162 163 164 166 167 168 170 171 172 173 174 175 176 177 178 179 181 182 183 184 185 186 187 188 189 190 191 193 194 195 196 201 202 203 205 206 214 217 218 219 220 221 222 223 224 225 226 227 229 230 231 232 233 234 235 236 237 239 240 241 243 244 245 246 ^^^^^ifaid+++++97^^^^^Country+++++^^^^^IFA+++++NAV^^^^^Advisor+++++^^^^^User+++++NAVIFA01^^^^^level+++++superuser^^^^^showname+++++yes^^^^^lang+++++1^^^^^clientID+++++409003-1^^^^^superuser+++++yes^^^^^salespersonid+++++^^^^^requestclientid+++++409003-1^^^^^entryid+++++^^^^^entryflag+++++^^^^^ClientDetails+++++yes^^^^^ifaofid+++++^^^^^MatrixSummary+++++^^^^^TotalNumber+++++^^^^^NameRequest+++++^^^^^surname+++++Accuratus^^^^^Forenames+++++John^^^^^added+++++^^^^^deleted+++++^^^^^updated+++++^^^^^referenceID+++++^^^^^code+++++NAV409003^^^^^clientcode+++++NAV409003^^^^^policyid+++++^^^^^XMLCode+++++^^^^^tempportfolioid+++++32611-1^^^^^', N'Portfolio/Switch.aspx', CAST(0x00009FF000B64E44 AS DateTime))
/****** Object:  Default [DF_SessionState_DateCreated]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SessionState] ADD  CONSTRAINT [DF_SessionState_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_SwitchClientSecurityCode_Attempt]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchClientSecurityCode] ADD  CONSTRAINT [DF_SwitchClientSecurityCode_Attempt]  DEFAULT ((0)) FOR [Attempt]
GO
/****** Object:  Default [DF_SwitchClientCode_IsConsumed]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchClientSecurityCode] ADD  CONSTRAINT [DF_SwitchClientCode_IsConsumed]  DEFAULT ((0)) FOR [IsConsumed]
GO
/****** Object:  Default [DF_SwitchDetails_isDeletable]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchDetails] ADD  CONSTRAINT [DF_SwitchDetails_isDeletable]  DEFAULT ((0)) FOR [isDeletable]
GO
/****** Object:  Default [DF_SwitchDetails_Client_isDeletable]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchDetails_Client] ADD  CONSTRAINT [DF_SwitchDetails_Client_isDeletable]  DEFAULT ((0)) FOR [isDeletable]
GO
/****** Object:  Default [DF_SwitchFee_Annual_Fee]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchFee] ADD  CONSTRAINT [DF_SwitchFee_Annual_Fee]  DEFAULT ((0)) FOR [Annual_Fee]
GO
/****** Object:  Default [DF_SwitchFee_Per_Switch_Fee]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchFee] ADD  CONSTRAINT [DF_SwitchFee_Per_Switch_Fee]  DEFAULT ((0)) FOR [Per_Switch_Fee]
GO
/****** Object:  Default [DF_SwitchFee_Date_Created]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchFee] ADD  CONSTRAINT [DF_SwitchFee_Date_Created]  DEFAULT (getdate()) FOR [Date_Created]
GO
/****** Object:  Default [DF_SwitchFee_Switch_Access]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchFee] ADD  CONSTRAINT [DF_SwitchFee_Switch_Access]  DEFAULT ((0)) FOR [Access_Denied]
GO
/****** Object:  Default [DF_SwitchFeeHistory_Annual_Fee]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchFeeHistory] ADD  CONSTRAINT [DF_SwitchFeeHistory_Annual_Fee]  DEFAULT ((0)) FOR [Annual_Fee]
GO
/****** Object:  Default [DF_SwitchFeeHistory_Per_Switch_Fee]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchFeeHistory] ADD  CONSTRAINT [DF_SwitchFeeHistory_Per_Switch_Fee]  DEFAULT ((0)) FOR [Per_Switch_Fee]
GO
/****** Object:  Default [DF_SwitchFeeHistory_Date_Created]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchFeeHistory] ADD  CONSTRAINT [DF_SwitchFeeHistory_Date_Created]  DEFAULT (getdate()) FOR [Date_Created]
GO
/****** Object:  Default [DF_Table_1_Date_Created]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchFeeHistory] ADD  CONSTRAINT [DF_Table_1_Date_Created]  DEFAULT (getdate()) FOR [Date_Effectivity]
GO
/****** Object:  Default [DF_SwitchGenerateCode_DateCreated]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchGenerateCode] ADD  CONSTRAINT [DF_SwitchGenerateCode_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF_SwitchHeader_Date_Created]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchHeader] ADD  CONSTRAINT [DF_SwitchHeader_Date_Created]  DEFAULT (getdate()) FOR [Date_Created]
GO
/****** Object:  Default [DF_SwitchHeader_SecurityCodeAttempt]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchHeader] ADD  CONSTRAINT [DF_SwitchHeader_SecurityCodeAttempt]  DEFAULT ((0)) FOR [SecurityCodeAttempt]
GO
/****** Object:  Default [DF_SwitchSchemeClientCode_IsConsumed]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchSchemeClientSecurityCode] ADD  CONSTRAINT [DF_SwitchSchemeClientCode_IsConsumed]  DEFAULT ((0)) FOR [IsConsumed]
GO
/****** Object:  Default [DF_SwitchSchemeDetails_isDeletable]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchSchemeDetails] ADD  CONSTRAINT [DF_SwitchSchemeDetails_isDeletable]  DEFAULT ((0)) FOR [isDeletable]
GO
/****** Object:  Default [DF_SwitchSchemeDetails_isContribution]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchSchemeDetails] ADD  CONSTRAINT [DF_SwitchSchemeDetails_isContribution]  DEFAULT ((0)) FOR [isContribution]
GO
/****** Object:  Default [DF_SwitchSchemeDetails_Client_isDeletable]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchSchemeDetails_Client] ADD  CONSTRAINT [DF_SwitchSchemeDetails_Client_isDeletable]  DEFAULT ((0)) FOR [isDeletable]
GO
/****** Object:  Default [DF_SwitchSchemeDetails_Client_isContribution]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchSchemeDetails_Client] ADD  CONSTRAINT [DF_SwitchSchemeDetails_Client_isContribution]  DEFAULT ((0)) FOR [isContribution]
GO
/****** Object:  Default [DF_SwitchSchemeHeader_SecurityCodeAttempt]    Script Date: 02/07/2012 11:49:43 ******/
ALTER TABLE [dbo].[SwitchSchemeHeader] ADD  CONSTRAINT [DF_SwitchSchemeHeader_SecurityCodeAttempt]  DEFAULT ((0)) FOR [SecurityCodeAttempt]
GO
