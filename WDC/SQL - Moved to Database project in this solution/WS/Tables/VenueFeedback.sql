USE [OnlineApplications]
GO

/****** Object:  Table [dbo].[VenueFeedback]    Script Date: 4/04/2017 9:53:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VenueFeedback](
	[VenueFeedback_CTR] [bigint] IDENTITY(1,1) NOT NULL,
	[Reference] [varchar](50) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[xml] [xml] NULL,
 CONSTRAINT [PK_VenueFeedback] PRIMARY KEY CLUSTERED 
(
	[VenueFeedback_CTR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[VenueFeedback] ADD  CONSTRAINT [DF_VenueFeedback_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [dbo].[VenueFeedback] ADD  CONSTRAINT [DF_VenueFeedback_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO


