USE [ShackBattles]
GO
/****** Object:  Table [dbo].[Battles]    Script Date: 12/17/2015 9:39:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Battles](
	[BattleKey] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](100) NOT NULL,
	[Details] [varchar](max) NOT NULL,
	[BattleDate] [datetime] NOT NULL,
	[GameKey] [int] NOT NULL,
	[CreatorKey] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateUpdated] [datetime] NULL,
	[BattleGUID] [varchar](50) NOT NULL,
	[Deleted] [bit] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK__Battles__0CE8C7B846376AD1] PRIMARY KEY CLUSTERED 
(
	[BattleKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Games]    Script Date: 12/17/2015 9:39:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Games](
	[GameKey] [int] IDENTITY(1,1) NOT NULL,
	[GameSystemKey] [int] NOT NULL,
	[GameName] [varchar](75) NOT NULL,
	[ReleaseDate] [datetime] NULL,
	[CoverImage] [varchar](100) NULL,
	[OverView] [varchar](max) NULL,
	[GamesDbId] [int] NULL,
 CONSTRAINT [PK_Games] PRIMARY KEY CLUSTERED 
(
	[GameKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GameSystems]    Script Date: 12/17/2015 9:39:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GameSystems](
	[GameSystemKey] [int] IDENTITY(1,1) NOT NULL,
	[GameSystemName] [varchar](75) NOT NULL,
	[GameDBPlatformID] [varchar](50) NULL,
 CONSTRAINT [PK_GameSystems] PRIMARY KEY CLUSTERED 
(
	[GameSystemKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserBattles]    Script Date: 12/17/2015 9:39:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserBattles](
	[UserBattlesKey] [int] IDENTITY(1,1) NOT NULL,
	[UsersKey] [int] NOT NULL,
	[BattleKey] [int] NOT NULL,
 CONSTRAINT [PK_UserBattles] PRIMARY KEY CLUSTERED 
(
	[UserBattlesKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserFollows]    Script Date: 12/17/2015 9:39:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserFollows](
	[UsersFollowsKey] [int] IDENTITY(1,1) NOT NULL,
	[UserKey] [int] NOT NULL,
	[GameKey] [int] NOT NULL,
	[Following] [bit] NOT NULL,
 CONSTRAINT [PK_UserFollows] PRIMARY KEY CLUSTERED 
(
	[UsersFollowsKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/17/2015 9:39:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserKey] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](75) NOT NULL,
	[LastLogin] [datetime] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[GamerTag] [varchar](20) NULL,
	[PSNID] [varchar](20) NULL,
	[BattleNet] [varchar](50) NULL,
	[SteamAccount] [varchar](50) NULL,
	[OriginAccount] [varchar](50) NULL,
	[Bio] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Battles]  WITH CHECK ADD  CONSTRAINT [FK_Battles_Games] FOREIGN KEY([GameKey])
REFERENCES [dbo].[Games] ([GameKey])
GO
ALTER TABLE [dbo].[Battles] CHECK CONSTRAINT [FK_Battles_Games]
GO
ALTER TABLE [dbo].[Battles]  WITH CHECK ADD  CONSTRAINT [FK_Battles_Users] FOREIGN KEY([CreatorKey])
REFERENCES [dbo].[Users] ([UserKey])
GO
ALTER TABLE [dbo].[Battles] CHECK CONSTRAINT [FK_Battles_Users]
GO
ALTER TABLE [dbo].[Games]  WITH CHECK ADD  CONSTRAINT [FK_Games_GameSystems] FOREIGN KEY([GameSystemKey])
REFERENCES [dbo].[GameSystems] ([GameSystemKey])
GO
ALTER TABLE [dbo].[Games] CHECK CONSTRAINT [FK_Games_GameSystems]
GO
ALTER TABLE [dbo].[UserBattles]  WITH CHECK ADD  CONSTRAINT [FK_UserBattles_Battles] FOREIGN KEY([BattleKey])
REFERENCES [dbo].[Battles] ([BattleKey])
GO
ALTER TABLE [dbo].[UserBattles] CHECK CONSTRAINT [FK_UserBattles_Battles]
GO
ALTER TABLE [dbo].[UserBattles]  WITH CHECK ADD  CONSTRAINT [FK_UserBattles_Users] FOREIGN KEY([UsersKey])
REFERENCES [dbo].[Users] ([UserKey])
GO
ALTER TABLE [dbo].[UserBattles] CHECK CONSTRAINT [FK_UserBattles_Users]
GO
ALTER TABLE [dbo].[UserFollows]  WITH CHECK ADD  CONSTRAINT [FK_UserFollows_Games] FOREIGN KEY([GameKey])
REFERENCES [dbo].[Games] ([GameKey])
GO
ALTER TABLE [dbo].[UserFollows] CHECK CONSTRAINT [FK_UserFollows_Games]
GO
ALTER TABLE [dbo].[UserFollows]  WITH CHECK ADD  CONSTRAINT [FK_UserFollows_Users] FOREIGN KEY([UserKey])
REFERENCES [dbo].[Users] ([UserKey])
GO
ALTER TABLE [dbo].[UserFollows] CHECK CONSTRAINT [FK_UserFollows_Users]
GO
/****** Object:  StoredProcedure [dbo].[GetGameUpcomingBattles]    Script Date: 12/17/2015 9:39:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetGameUpcomingBattles] 
	@GameKey int,
	@UserKey int
AS
BEGIN
	SELECT u.Username, b.BattleDate, b.Title,b.BattleGUID,
	(SELECT count(*) from UserBattles ub where  ub.BattleKey = b.BattleKey and ub.UsersKey = @UserKey ) as Joined,
	(SELECT COUNT(BattleKey) FROM UserBattles where BattleKey = b.BattleKey) as Registered
	FROM Battles b
	JOIN Users u on b.CreatorKey = u.UserKey
	WHERE DATEADD(HOUR, 4, b.BattleDate) >= GETUTCDATE()
	AND GameKey = @GameKey and b.Deleted = 0
	ORDER BY b.BattleDate asc
END
GO
/****** Object:  StoredProcedure [dbo].[GetUpcomingBattles]    Script Date: 12/17/2015 9:39:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetUpcomingBattles]
	@UserKey int
AS
	
 SELECT TOP 15 b.Title, b.BattleGUID , b.BattleKey, u.Username as CreatorName, g.GameName, gs.GameSystemName,g.GameKey,b.BattleDate, 
 b.CreatorKey,
(SELECT COUNT(BattleKey) FROM UserBattles where BattleKey = b.BattleKey ) as Registered,
(SELECT count(*) from UserBattles ub where  ub.BattleKey = b.BattleKey and ub.UsersKey = @UserKey ) as Joined
FROM Battles b
INNER JOIN Users u on b.CreatorKey = u.UserKey
INNER JOIN Games g on b.GameKey = g.GameKey
INNER JOIN GameSystems gs on g.GameSystemKey = gs.GameSystemKey
WHERE DATEADD(HOUR, 4, b.BattleDate) >= GETUTCDATE()
AND b.Deleted = 0
ORDER BY BattleDate asc
GO
/****** Object:  StoredProcedure [dbo].[GetUpcomingBattlesAllUsers]    Script Date: 12/17/2015 9:39:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUpcomingBattlesAllUsers]

AS
	
 SELECT TOP 15 b.Title, b.BattleGUID , b.BattleKey, u.Username as CreatorName, g.GameName, gs.GameSystemName,g.GameKey,b.BattleDate, 
 b.CreatorKey, b.Details,
(SELECT COUNT(BattleKey) FROM UserBattles where BattleKey = b.BattleKey ) as Registered
FROM Battles b
INNER JOIN Users u on b.CreatorKey = u.UserKey
INNER JOIN Games g on b.GameKey = g.GameKey
INNER JOIN GameSystems gs on g.GameSystemKey = gs.GameSystemKey
WHERE DATEADD(HOUR, 4, b.BattleDate) >= GETUTCDATE()
  AND b.Deleted = 0
ORDER BY BattleDate asc
GO
/****** Object:  StoredProcedure [dbo].[GetUpcomingUserBattles]    Script Date: 12/17/2015 9:39:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUpcomingUserBattles]
	@UserKey int
AS

	SELECT  b.BattleKey, Title, Details, BattleDate, g.GameKey, CreatorKey, 
			b.DateCreated, DateUpdated, BattleGUID,g.GameName, gs.GameSystemName, 
			u.UserName as CreatorName,
			(SELECT COUNT(BattleKey) FROM UserBattles where BattleKey = b.BattleKey) as Registered,
			(SELECT count(*) from UserBattles ub where  ub.BattleKey = b.BattleKey and ub.UsersKey = @UserKey ) as Joined 
	FROM Battles b
	INNER JOIN UserBattles ub on ub.BattleKey = b.BattleKey
	INNER JOIN Games g on g.GameKey = b.GameKey
	INNER JOIN GameSystems gs on g.GameSystemKey = gs.GameSystemKey
	INNER JOIN Users u on u.UserKey = b.CreatorKey
	WHERE DATEADD(HOUR, 4, b.BattleDate) >= GETUTCDATE()
	AND ub.UsersKey = @UserKey
	AND b.Deleted = 0
	ORDER BY BattleDate asc
GO
/****** Object:  StoredProcedure [dbo].[GetUserUpcomingFollowedBattles]    Script Date: 12/17/2015 9:39:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserUpcomingFollowedBattles]
	@UserKey int
AS

SELECT b.*,
	(SELECT count(*) from UserBattles ub where  ub.BattleKey = b.BattleKey and ub.UsersKey = @UserKey ) as Joined,
	(SELECT COUNT(BattleKey) FROM UserBattles where BattleKey = b.BattleKey) as Registered, 
	u.Username as CreatorName, g.GameName,gs.GameSystemName
FROM Battles b
INNER JOIN UserFollows uf on b.GameKey = uf.GameKey AND uf.UserKey = @UserKey
INNER JOIN Users u on b.CreatorKey = u.UserKey
INNER JOIN Games g on g.GameKey = uf.GameKey
INNER JOin GameSystems gs on g.GameSystemKey = gs.GameSystemKey
AND b.BattleDate >= GETUTCDATE()
and uf.Following = 1
and b.Deleted = 0
ORDER BY BattleDate asc
GO
