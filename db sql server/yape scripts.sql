USE [master]
GO
/****** Object:  Database [yape]    Script Date: 11/3/2023 10:03:59 PM ******/
CREATE DATABASE [yape]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tpdelivery', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\yape2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'tpdelivery_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\yape2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [yape] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [yape].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [yape] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [yape] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [yape] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [yape] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [yape] SET ARITHABORT OFF 
GO
ALTER DATABASE [yape] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [yape] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [yape] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [yape] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [yape] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [yape] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [yape] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [yape] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [yape] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [yape] SET  DISABLE_BROKER 
GO
ALTER DATABASE [yape] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [yape] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [yape] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [yape] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [yape] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [yape] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [yape] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [yape] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [yape] SET  MULTI_USER 
GO
ALTER DATABASE [yape] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [yape] SET DB_CHAINING OFF 
GO
ALTER DATABASE [yape] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [yape] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [yape] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [yape] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [yape] SET QUERY_STORE = OFF
GO
USE [yape]
GO
/****** Object:  User [uSerDelivery]    Script Date: 11/3/2023 10:03:59 PM ******/
CREATE USER [uSerDelivery] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [user]    Script Date: 11/3/2023 10:03:59 PM ******/
CREATE USER [user] FOR LOGIN [user] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [uSerDelivery]
GO
ALTER ROLE [db_owner] ADD MEMBER [user]
GO
/****** Object:  Table [dbo].[rol]    Script Date: 11/3/2023 10:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rol](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stateTransaction]    Script Date: 11/3/2023 10:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stateTransaction](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transactions]    Script Date: 11/3/2023 10:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transactions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[accountExternalIdDebit] [varchar](255) NOT NULL,
	[accountExternalIdCredit] [varchar](255) NOT NULL,
	[tranferTypeId] [int] NULL,
	[valuetranfer] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 11/3/2023 10:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[firstname] [nvarchar](50) NOT NULL,
	[lastname] [nvarchar](50) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[pass] [nvarchar](255) NOT NULL,
	[id_rol] [int] NULL,
	[created_at] [datetime] NULL,
	[tel] [varchar](255) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[transactions] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
/****** Object:  StoredProcedure [dbo].[login]    Script Date: 11/3/2023 10:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[login] 
	-- Add the parameters for the stored procedure here
	@email nvarchar(255), 
	@pass nvarchar(255)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
      a.[firstname]
      ,a.[lastname]
      ,a.[email]
      ,a.[status]
      ,a.[id_rol]
	  ,a.[tel]
	  ,b.name
	FROM [dbo].[users] a 
	JOIN [dbo].[rol] b
	ON a.id_rol = b.id
	WHERE a.email = @email and a.pass = @pass
	and a.status = 'active'
END
GO
/****** Object:  StoredProcedure [dbo].[put_transaction]    Script Date: 11/3/2023 10:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[put_transaction]
	-- Add the parameters for the stored procedure here
	@accountExternalIdDebit varchar(255), 
	@accountExternalIdCredit varchar(255), 
	@cash int,
	@state int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[transactions]
           ([accountExternalIdDebit]
           ,[accountExternalIdCredit]
           ,[tranferTypeId]
           ,[valuetranfer])
     VALUES
           (@accountExternalIdDebit
           ,@accountExternalIdCredit
           ,@state
           ,@cash)
END
GO
/****** Object:  StoredProcedure [dbo].[retrieveTransaction]    Script Date: 11/3/2023 10:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[retrieveTransaction] 
	-- Add the parameters for the stored procedure here
	@accountExternalIdDebit varchar(255), 
	@accountExternalIdCredit varchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 a.[id]
      ,a.[accountExternalIdDebit]
      ,a.[accountExternalIdCredit]
      ,a.[tranferTypeId]
      ,a.[valuetranfer]
      ,a.[created_at]
	  ,name
	FROM [yape].[dbo].[transactions] a
	INNER JOIN  [stateTransaction] b ON a.tranferTypeId = b.id
	WHERE a.accountExternalIdDebit = @accountExternalIdDebit AND a.accountExternalIdCredit = @accountExternalIdCredit
	ORDER BY a.[id] DESC
END
GO
/****** Object:  StoredProcedure [dbo].[update_transaction]    Script Date: 11/3/2023 10:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[update_transaction]
	-- Add the parameters for the stored procedure here
	@id int, 
	@statePending int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[transactions]
   SET [tranferTypeId] = @statePending
	WHERE id = @id
END
GO
USE [master]
GO
ALTER DATABASE [yape] SET  READ_WRITE 
GO
