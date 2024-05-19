USE [master]
GO
/****** Object:  Database [dbBooksGL]    Script Date: 5/7/2024 7:11:01 AM ******/
CREATE DATABASE [dbBooksGL]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbBooksGL', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\dbBooksGL.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbBooksGL_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\dbBooksGL_log.ldf' , SIZE = 335872KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [dbBooksGL] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbBooksGL].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbBooksGL] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbBooksGL] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbBooksGL] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbBooksGL] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbBooksGL] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbBooksGL] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbBooksGL] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbBooksGL] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbBooksGL] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbBooksGL] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbBooksGL] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbBooksGL] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbBooksGL] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbBooksGL] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbBooksGL] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dbBooksGL] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbBooksGL] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbBooksGL] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbBooksGL] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbBooksGL] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbBooksGL] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbBooksGL] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbBooksGL] SET RECOVERY FULL 
GO
ALTER DATABASE [dbBooksGL] SET  MULTI_USER 
GO
ALTER DATABASE [dbBooksGL] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbBooksGL] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbBooksGL] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbBooksGL] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbBooksGL] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbBooksGL] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'dbBooksGL', N'ON'
GO
ALTER DATABASE [dbBooksGL] SET QUERY_STORE = ON
GO
ALTER DATABASE [dbBooksGL] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [dbBooksGL]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[AuthorId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[AuthorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuthorBook]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuthorBook](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AuthorId] [int] NOT NULL,
	[BookId] [int] NOT NULL,
	[NumberInList] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_AuthorBook] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[BookId] [int] IDENTITY(1,1) NOT NULL,
	[BookTypeId] [int] NOT NULL,
	[PublisherId] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[PublishYear] [int] NOT NULL,
	[Stock] [int] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookPublisher]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookPublisher](
	[PublisherId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Address] [varchar](max) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_BookPublisher] PRIMARY KEY CLUSTERED 
(
	[PublisherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookType]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookType](
	[BookTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_BookType] PRIMARY KEY CLUSTERED 
(
	[BookTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserBook]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserBook](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[BookId] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[ReturnDate] [date] NOT NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_UserBook] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Author] ADD  CONSTRAINT [DF_Author_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[AuthorBook] ADD  CONSTRAINT [DF_AuthorBook_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF_Book_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[BookPublisher] ADD  CONSTRAINT [DF_BookPublisher_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[BookType] ADD  CONSTRAINT [DF_BookType_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[UserBook] ADD  CONSTRAINT [DF_UserBook_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[AuthorBook]  WITH CHECK ADD  CONSTRAINT [FK_AuthorBook_Author] FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Author] ([AuthorId])
GO
ALTER TABLE [dbo].[AuthorBook] CHECK CONSTRAINT [FK_AuthorBook_Author]
GO
ALTER TABLE [dbo].[AuthorBook]  WITH CHECK ADD  CONSTRAINT [FK_AuthorBook_Book] FOREIGN KEY([BookId])
REFERENCES [dbo].[Book] ([BookId])
GO
ALTER TABLE [dbo].[AuthorBook] CHECK CONSTRAINT [FK_AuthorBook_Book]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_BookPublisher] FOREIGN KEY([PublisherId])
REFERENCES [dbo].[BookPublisher] ([PublisherId])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_BookPublisher]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_BookType] FOREIGN KEY([BookTypeId])
REFERENCES [dbo].[BookType] ([BookTypeId])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_BookType]
GO
ALTER TABLE [dbo].[UserBook]  WITH CHECK ADD  CONSTRAINT [FK_UserBook_Book] FOREIGN KEY([BookId])
REFERENCES [dbo].[Book] ([BookId])
GO
ALTER TABLE [dbo].[UserBook] CHECK CONSTRAINT [FK_UserBook_Book]
GO
ALTER TABLE [dbo].[UserBook]  WITH CHECK ADD  CONSTRAINT [FK_UserBook_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[UserBook] CHECK CONSTRAINT [FK_UserBook_User]
GO
/****** Object:  StoredProcedure [dbo].[spAllActiveAuthorBookSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAllActiveAuthorBookSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (1000) [Id]
	,[AuthorId]
	,[BookId]
	,[NumberInList]
	,[Active]
	FROM [dbo].[AuthorBook]
	WHERE [Active] = 1
END
GO
/****** Object:  StoredProcedure [dbo].[spAllActiveAuthorsSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAllActiveAuthorsSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (1000) [AuthorId]
	,[FirstName]
	,[LastName]
	,[BirthDate]
	,[Active]
	FROM [dbo].[Author]
	WHERE [Active] = 1
END
GO
/****** Object:  StoredProcedure [dbo].[spAllActiveBooksSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAllActiveBooksSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (1000) [BookId]
	,[Title]
	,[BookTypeId]
	,[PublisherId]
	,[Stock]
	,[PublishYear]
	,[Active]
	FROM [dbo].[Book]
	WHERE [Active] = 1
END
GO
/****** Object:  StoredProcedure [dbo].[spAllActiveBookTypeSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAllActiveBookTypeSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (1000) [BookTypeId]
	,[Name]
	,[Active]
	FROM [dbo].[BookType]
	WHERE [Active] = 1
END
GO
/****** Object:  StoredProcedure [dbo].[spAllActivePublishersSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAllActivePublishersSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (1000) [PublisherId]
	,[Name]
	,[Address]
	,[Active]
	FROM [dbo].[BookPublisher]
	WHERE [Active] = 1
END
GO
/****** Object:  StoredProcedure [dbo].[spAllActiveUsersSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAllActiveUsersSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (1000) [UserId]
	,[FirstName]
	,[LastName]
	,[Email]
	,[Phone]
	,[Active]
	FROM [dbo].[User]
	WHERE [Active] = 1
END
GO
/****** Object:  StoredProcedure [dbo].[spAllAuthorBookSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAllAuthorBookSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (1000) [Id]
	,[AuthorId]
	,[BookId]
	,[NumberInList]
	,[Active]
	FROM [dbo].[AuthorBook]
END
GO
/****** Object:  StoredProcedure [dbo].[spAllAuthorsSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAllAuthorsSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (1000) [AuthorId]
	,[FirstName]
	,[LastName]
	,[BirthDate]
	,[Active]
	FROM [dbo].[Author]
END
GO
/****** Object:  StoredProcedure [dbo].[spAllBooksSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAllBooksSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (1000) [BookId]
	,[Title]
	,[BookTypeId]
	,[PublisherId]
	,[Stock]
	,[PublishYear]
	,[Active]
	FROM [dbo].[Book]
END
GO
/****** Object:  StoredProcedure [dbo].[spAllBookTypeSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAllBookTypeSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (1000) [BookTypeId]
	,[Name]
	,[Active]
	FROM [dbo].[BookType]
END
GO
/****** Object:  StoredProcedure [dbo].[spAllPublishersSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAllPublishersSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (1000) [PublisherId]
	,[Name]
	,[Address]
	,[Active]
	FROM [dbo].[BookPublisher]
END
GO
/****** Object:  StoredProcedure [dbo].[spAllUsersSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAllUsersSelect]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP (1000) [UserId]
	,[FirstName]
	,[LastName]
	,[Email]
	,[Phone]
	,[Active]
	FROM [dbo].[User]
END
GO
/****** Object:  StoredProcedure [dbo].[spAuthorBookInsert]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAuthorBookInsert]
	-- Add the parameters for the stored procedure here
	@AuthorId INT,
	@BookId INT,
	@NumberInList INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [AuthorBook] ([AuthorId], [BookId], [NumberInList])
	VALUES (@AuthorId, @BookId, @NumberInList);
END
GO
/****** Object:  StoredProcedure [dbo].[spAuthorDelete]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAuthorDelete]
	-- Add the parameters for the stored procedure here
	@AuthorId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Author] SET 
	[Active] = 0
	WHERE [AuthorId] = @AuthorId
END
GO
/****** Object:  StoredProcedure [dbo].[spAuthorInsert]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAuthorInsert]
	-- Add the parameters for the stored procedure here
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@BirthDate DATE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [Author] ([FirstName], [LastName], [BirthDate])
	VALUES (@FirstName, @LastName, @BirthDate);
END
GO
/****** Object:  StoredProcedure [dbo].[spAuthorSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAuthorSelect]
	-- Add the parameters for the stored procedure here
	@AuthorId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [AuthorId]
	,[FirstName]
	,[LastName]
	,[BirthDate]
	,[Active] 
	FROM [Author]
	WHERE [AuthorId] = @AuthorId
END
GO
/****** Object:  StoredProcedure [dbo].[spAuthorUpdate]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spAuthorUpdate]
	-- Add the parameters for the stored procedure here
	@AuthorId INT,
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@BirthDate DATE,
	@Active BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Author] SET 
	[FirstName] = @FirstName,
	[LastName] = @LastName,
	[BirthDate] = @BirthDate,
	[Active] = @Active
	WHERE [AuthorId] = @AuthorId
END
GO
/****** Object:  StoredProcedure [dbo].[spBookAuthorSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBookAuthorSelect]
	-- Add the parameters for the stored procedure here
	@BookId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Author].AuthorId, [Author].FirstName, [Author].LastName, [Author].BirthDate, [Author].Active
	FROM [Author]
	INNER JOIN [AuthorBook] ON [Author].AuthorId = [AuthorBook].AuthorId
	WHERE [AuthorBook].BookId = @BookId
END
GO
/****** Object:  StoredProcedure [dbo].[spBookDelete]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBookDelete]
	-- Add the parameters for the stored procedure here
	@BookId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Book] SET 
	[Active] = 0
	WHERE [BookId] = @BookId
END
GO
/****** Object:  StoredProcedure [dbo].[spBookInsert]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBookInsert]
	-- Add the parameters for the stored procedure here
	@Title NVARCHAR(50),
	@BookTypeId INT,
	@PublisherId INT,
	@Stock INT,
	@PublishYear INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [Book] (
	[Title], 
	[BookTypeId], 
	[PublisherId], 
	[Stock], 
	[PublishYear])
	VALUES (@Title, @BookTypeId, @PublisherId, @Stock, @PublishYear);

	SELECT SCOPE_IDENTITY() AS BookId;
END
GO
/****** Object:  StoredProcedure [dbo].[spBookTypeDelete]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBookTypeDelete]
	-- Add the parameters for the stored procedure here
	@BookTypeId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [BookType] SET 
	[Active] = 0
	WHERE [BookTypeId] = @BookTypeId
END
GO
/****** Object:  StoredProcedure [dbo].[spBookTypeInsert]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBookTypeInsert]
	-- Add the parameters for the stored procedure here
	@Name NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [BookType] ([Name])
	VALUES (@Name);
END
GO
/****** Object:  StoredProcedure [dbo].[spBookTypeSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBookTypeSelect]
	-- Add the parameters for the stored procedure here
	@BookTypeId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [BookTypeId]
	,[Name]
	,[Active] 
	FROM [BookType]
	WHERE [BookTypeId] = @BookTypeId
END
GO
/****** Object:  StoredProcedure [dbo].[spBookTypeUpdate]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBookTypeUpdate]
	-- Add the parameters for the stored procedure here
	@BookTypeId INT,
	@Name NVARCHAR(50),
	@Active BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [BookType] SET 
	[Name] = @Name,
	[Active] = @Active
	WHERE [BookTypeId] = @BookTypeId
END
GO
/****** Object:  StoredProcedure [dbo].[spBookUpdate]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spBookUpdate]
	-- Add the parameters for the stored procedure here
	@BookId INT,
	@BookTypeId INT,
	@PublisherId INT,
	@Title NVARCHAR(50),
	@PublishYear INT,
	@Stock INT,
	@Active BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [Book] SET 
	[BookTypeId] = @BookTypeId,
	[PublisherId] = @PublisherId,
	[Title] = @Title,
	[PublishYear] = @PublishYear,
	[Stock] = @Stock,
	[Active] = @Active
	WHERE [BookId] = @BookId;
END
GO
/****** Object:  StoredProcedure [dbo].[spPublisherDelete]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spPublisherDelete]
	-- Add the parameters for the stored procedure here
	@PublisherId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [BookPublisher] SET 
	[Active] = 0
	WHERE [PublisherId] = @PublisherId
END
GO
/****** Object:  StoredProcedure [dbo].[spPublisherInsert]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spPublisherInsert]
	-- Add the parameters for the stored procedure here
	@Name NVARCHAR(50),
	@Address VARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [BookPublisher] ([Name], [Address])
	VALUES (@Name, @Address);
END
GO
/****** Object:  StoredProcedure [dbo].[spPublisherSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spPublisherSelect]
	-- Add the parameters for the stored procedure here
	@PublisherId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [PublisherId]
	,[Name]
	,[Address]
	,[Active] 
	FROM [BookPublisher]
	WHERE [PublisherId] = @PublisherId
END
GO
/****** Object:  StoredProcedure [dbo].[spPublisherUpdate]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spPublisherUpdate]
	-- Add the parameters for the stored procedure here
	@PublisherId INT,
	@Name NVARCHAR(50),
	@Address VARCHAR(MAX),
	@Active BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [BookPublisher] SET 
	[Name] = @Name,
	[Address] = @Address,
	[Active] = @Active
	WHERE [PublisherId] = @PublisherId
END
GO
/****** Object:  StoredProcedure [dbo].[spUserDelete]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUserDelete]
	-- Add the parameters for the stored procedure here
	@UserId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [User] SET 
	[Active] = 0
	WHERE [UserId] = @UserId
END
GO
/****** Object:  StoredProcedure [dbo].[spUserInsert]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUserInsert]
	-- Add the parameters for the stored procedure here
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Email NVARCHAR(50),
	@Phone NVARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [User] ([FirstName], [LastName], [Email], [Phone])
	VALUES (@FirstName, @LastName, @Email, @Phone);
END
GO
/****** Object:  StoredProcedure [dbo].[spUserSelect]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUserSelect]
	-- Add the parameters for the stored procedure here
	@UserId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [UserId]
	,[FirstName]
	,[LastName]
	,[Email]
	,[Phone]
	,[Active] 
	FROM [User]
	WHERE [UserId] = @UserId
END
GO
/****** Object:  StoredProcedure [dbo].[spUserUpdate]    Script Date: 5/7/2024 7:11:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spUserUpdate]
	-- Add the parameters for the stored procedure here
	@UserId INT,
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Email NVARCHAR(50),
	@Phone NVARCHAR(50),
	@Active BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [User] SET 
	[FirstName] = @FirstName,
	[LastName] = @LastName,
	[Email] = @Email,
	[Phone] = @Phone,
	[Active] = @Active
	WHERE [UserId] = @UserId
END
GO
USE [master]
GO
ALTER DATABASE [dbBooksGL] SET  READ_WRITE 
GO
