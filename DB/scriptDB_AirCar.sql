USE [master]
GO
/****** Object:  Database [AirCar]    Script Date: 25-08-18 08:10:18 ******/
CREATE DATABASE [AirCar]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AirCar', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AirCar.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AirCar_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AirCar_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [AirCar] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AirCar].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AirCar] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AirCar] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AirCar] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AirCar] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AirCar] SET ARITHABORT OFF 
GO
ALTER DATABASE [AirCar] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [AirCar] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AirCar] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AirCar] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AirCar] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AirCar] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AirCar] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AirCar] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AirCar] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AirCar] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AirCar] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AirCar] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AirCar] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AirCar] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AirCar] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AirCar] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AirCar] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AirCar] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AirCar] SET  MULTI_USER 
GO
ALTER DATABASE [AirCar] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AirCar] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AirCar] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AirCar] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AirCar] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AirCar] SET QUERY_STORE = OFF
GO
USE [AirCar]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [AirCar]
GO
/****** Object:  User [clientAC]    Script Date: 25-08-18 08:10:18 ******/
CREATE USER [clientAC] FOR LOGIN [clientAC] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [AcEmployee]    Script Date: 25-08-18 08:10:18 ******/
CREATE USER [AcEmployee] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[SchEmployee]
GO
/****** Object:  User [AcCustomer]    Script Date: 25-08-18 08:10:18 ******/
CREATE USER [AcCustomer] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[SchCustomer]
GO
/****** Object:  DatabaseRole [Employee]    Script Date: 25-08-18 08:10:18 ******/
CREATE ROLE [Employee]
GO
/****** Object:  DatabaseRole [Customer]    Script Date: 25-08-18 08:10:18 ******/
CREATE ROLE [Customer]
GO
ALTER ROLE [Customer] ADD MEMBER [clientAC]
GO
ALTER ROLE [Employee] ADD MEMBER [AcEmployee]
GO
ALTER ROLE [Customer] ADD MEMBER [AcCustomer]
GO
/****** Object:  Schema [SchCommon]    Script Date: 25-08-18 08:10:18 ******/
CREATE SCHEMA [SchCommon]
GO
/****** Object:  Schema [SchCustomer]    Script Date: 25-08-18 08:10:18 ******/
CREATE SCHEMA [SchCustomer]
GO
/****** Object:  Schema [SchEmployee]    Script Date: 25-08-18 08:10:18 ******/
CREATE SCHEMA [SchEmployee]
GO
/****** Object:  Table [dbo].[Reservation]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Vehicle_Id] [int] NOT NULL,
	[Customer_Id] [nvarchar](128) NOT NULL,
	[ReservationDate] [datetime] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[PickupDate] [date] NULL,
	[ReturnDate] [date] NULL,
	[ToPay] [decimal](9, 2) NULL,
	[Paid] [decimal](9, 2) NULL,
	[Employee_Id] [nvarchar](128) NULL,
	[IsClosed] [bit] NULL,
 CONSTRAINT [PK_Reservation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchEmployee].[vReservation]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchEmployee].[vReservation]
AS
SELECT        Id, Vehicle_Id, Customer_Id, ReservationDate, StartDate, EndDate, ToPay, PickupDate, ReturnDate, Paid, Employee_Id, IsClosed
FROM            dbo.Reservation
GO
/****** Object:  Table [dbo].[Fuel]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fuel](
	[Name] [varchar](25) NOT NULL,
 CONSTRAINT [PK_Fuel] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCommon].[vFuel]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vFuel]
AS
SELECT        Name
FROM            dbo.Fuel
GO
/****** Object:  View [SchCustomer].[vReservation]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCustomer].[vReservation]
AS
SELECT        Id, Vehicle_Id, Customer_Id, ReservationDate, StartDate, EndDate, ToPay, IsClosed, PickupDate, ReturnDate
FROM            dbo.Reservation
GO
/****** Object:  Table [dbo].[PromotionModel]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PromotionModel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Office_Name] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[PercentReduc] [tinyint] NULL,
	[FixedReduc] [decimal](9, 2) NULL,
 CONSTRAINT [PK_PromotionModel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promo_VehicleType]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promo_VehicleType](
	[PromotionModel_Id] [int] NOT NULL,
	[VehicleType_Id] [int] NOT NULL,
 CONSTRAINT [PK_Promo_Reservation] PRIMARY KEY CLUSTERED 
(
	[PromotionModel_Id] ASC,
	[VehicleType_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PromoTarget]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PromoTarget](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PromoModel_Id] [int] NOT NULL,
	[Make_Name] [varchar](50) NULL,
	[Model_Name] [varchar](50) NULL,
	[Fuel_Name] [varchar](25) NULL,
	[CC_Name] [varchar](25) NULL,
	[Doors_Count] [tinyint] NULL,
 CONSTRAINT [PK_PromoTarget] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCommon].[vPromo]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCommon].[vPromo]
AS
SELECT        dbo.Promo_VehicleType.PromotionModel_Id, dbo.Promo_VehicleType.VehicleType_Id, dbo.PromotionModel.Office_Name, dbo.PromotionModel.Name, dbo.PromotionModel.StartDate, dbo.PromotionModel.EndDate, 
                         dbo.PromotionModel.PercentReduc, dbo.PromotionModel.FixedReduc
FROM            dbo.Promo_VehicleType INNER JOIN
                         dbo.PromotionModel ON dbo.Promo_VehicleType.PromotionModel_Id = dbo.PromotionModel.Id INNER JOIN
                         dbo.PromoTarget ON dbo.PromotionModel.Id = dbo.PromoTarget.PromoModel_Id
GO
/****** Object:  Table [dbo].[Make]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Make](
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Make] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCommon].[vMake]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vMake]
AS
SELECT        Name
FROM            dbo.Make
GO
/****** Object:  View [SchCommon].[vReservation]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCommon].[vReservation]
AS
SELECT        Id, Vehicle_Id, Customer_Id, ReservationDate, StartDate, EndDate, ToPay, IsClosed, PickupDate, ReturnDate, Paid, Employee_Id
FROM            dbo.Reservation
GO
/****** Object:  Table [dbo].[Model]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Model](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Make_name] [varchar](50) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Model] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCommon].[vModel]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vModel]
AS
SELECT        dbo.Model.Id, dbo.Model.Make_name, dbo.Model.Name
FROM            dbo.Make INNER JOIN
                         dbo.Model ON dbo.Make.Name = dbo.Model.Make_name
GO
/****** Object:  Table [dbo].[VehicleType]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VehicleType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Model_Id] [int] NOT NULL,
	[Fuel_Name] [varchar](25) NOT NULL,
	[CC_Name] [varchar](25) NOT NULL,
	[Doors_Count] [tinyint] NOT NULL,
 CONSTRAINT [PK_VehicleType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCommon].[vVehicleType]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCommon].[vVehicleType]
AS
SELECT        dbo.VehicleType.Id, dbo.VehicleType.Model_Id, dbo.Model.Make_name, dbo.Model.Name AS Model_Name, dbo.VehicleType.Fuel_Name, dbo.VehicleType.CC_Name, dbo.VehicleType.Doors_Count
FROM            dbo.VehicleType INNER JOIN
                         dbo.Model ON dbo.VehicleType.Model_Id = dbo.Model.Id
GO
/****** Object:  Table [dbo].[Office]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Office](
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Office] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCommon].[vOffice]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vOffice]
AS
SELECT        Name
FROM            dbo.Office
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 25-08-18 08:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Birthday] [date] NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[User_Id] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCommon].[vCustomer]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCommon].[vCustomer]
AS
SELECT        dbo.AspNetUsers.Id, dbo.AspNetUsers.UserName, dbo.AspNetUsers.Email, dbo.AspNetUsers.PhoneNumber, dbo.AspNetUsers.FirstName, dbo.AspNetUsers.LastName, dbo.AspNetUsers.Birthday
FROM            dbo.AspNetUsers INNER JOIN
                         dbo.Customer ON dbo.AspNetUsers.Id = dbo.Customer.User_Id
GO
/****** Object:  Table [dbo].[CC]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CC](
	[Name] [varchar](25) NOT NULL,
 CONSTRAINT [PK_CC] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCommon].[vCC]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vCC]
AS
SELECT        Name
FROM            dbo.CC
GO
/****** Object:  Table [dbo].[Person]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[AspNetUsers_Id] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[User_ID] [nvarchar](128) NOT NULL,
	[Office_Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchEmployee].[vEmployee]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchEmployee].[vEmployee]
AS
SELECT        dbo.Person.Id, dbo.Employee.Office_Name, dbo.Person.Name, dbo.Person.Surname, dbo.Person.BirthDate, dbo.Person.Email, dbo.Person.Phone
FROM            dbo.Person INNER JOIN
                         dbo.Employee ON dbo.Person.Id = dbo.Employee.Pers_ID
GO
/****** Object:  Table [dbo].[Picture]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Picture](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Model_Id] [int] NOT NULL,
	[Label] [varchar](50) NULL,
	[IsLarge] [bit] NULL,
	[Path] [varchar](255) NULL,
 CONSTRAINT [PK_Picture] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCommon].[vPicture]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCommon].[vPicture]
AS
SELECT        Id, Model_Id AS VehicleType_Id, Label, IsLarge, Path
FROM            dbo.Picture
GO
/****** Object:  Table [dbo].[Vehicle]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Office_Name] [varchar](50) NOT NULL,
	[VehicleType_Id] [int] NOT NULL,
 CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BaseTarif]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaseTarif](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Office_name] [varchar](50) NOT NULL,
	[VehicleType_Id] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[DailyPrice] [decimal](9, 2) NOT NULL,
 CONSTRAINT [PK_BaseTarif] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCommon].[vVehicle]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCommon].[vVehicle]
AS
SELECT        dbo.Vehicle.Id, dbo.Vehicle.Office_Name, dbo.Vehicle.VehicleType_Id, dbo.BaseTarif.Name AS TarifName, dbo.BaseTarif.DailyPrice, dbo.Model.Make_name, dbo.Model.Name AS Model_Name, dbo.VehicleType.Fuel_Name, 
                         dbo.VehicleType.CC_Name, dbo.VehicleType.Doors_Count, dbo.VehicleType.Id AS TypeId
FROM            dbo.Vehicle INNER JOIN
                         dbo.VehicleType ON dbo.Vehicle.VehicleType_Id = dbo.VehicleType.Id INNER JOIN
                         dbo.BaseTarif ON dbo.VehicleType.Id = dbo.BaseTarif.VehicleType_Id INNER JOIN
                         dbo.Model ON dbo.VehicleType.Model_Id = dbo.Model.Id
GO
/****** Object:  Table [dbo].[Doors]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doors](
	[Count] [tinyint] NOT NULL,
 CONSTRAINT [PK_Doors] PRIMARY KEY CLUSTERED 
(
	[Count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCommon].[vDoors]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vDoors]
AS
SELECT        Count
FROM            dbo.Doors
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201808231510153_InitialCreate', N'WebApplication1.Models.ApplicationDbContext', 0x1F8B0800000000000400DD5CDB6EDC36107D2FD07F10F4D416CECA9726488DDD04EEDA6E8DC617649DB46F0157E2AE85489422518E8DA25FD6877E527FA14389BAF1A2CBAEBCBB2E02042B727866381C92C3E1D0FFFEFDCFF8ED83EF19F7388ADD804CCC83D1BE696062078E4B961333A18B17AFCDB76FBEFD667CE6F80FC6C79CEE88D1414B124FCC3B4AC363CB8AED3BECA378E4BB7614C4C1828EECC0B790135887FBFB3F59070716060813B00C63FC3E21D4F571FA019FD380D838A409F22E03077B312F879A598A6A5C211FC721B2F1C4FC1DCF4FC2D0736D4441948351D6C2344E3C17813433EC2D4C031112D094E0F8438C67340AC872164201F26E1F430C740BE4C598F7E1B824EFDA9DFD43D61DAB6C9843D9494C03BF27E0C111D78F25365F49CB66A13FD0E019689A3EB25EA75A9C98170E4E8BDE071E284064783CF522463C312F0B1627717885E9286F38CA20CF2380FB1A449F4755C43DA373BBBDC29E0E47FBECDF9E314D3C9A447842704223E4ED1937C91C86FA37FC781B7CC6647274305F1CBD7EF90A3947AF7EC4472FAB3D85BE025DAD008A6EA220C411C8861745FF4DC3AAB7B3C48645B34A9B4C2B604B30354CE3123DBCC36449EF60D21CBE368D73F7013B790937AE0FC48599048D6894C0E755E27968EEE1A2DE6AE4C9FE6FE07AF8F2D5205CAFD0BDBB4C875EE00F13278279F51E7B696D7CE786D9F4AA8DF7274E761E053EFBAEDB5756FB69162491CD3A1368496E51B4C4B42EDDD82A8DB7934933A8E1CD3A47DD7DD36692CAE6AD24651D5A6526E42C363D1B72799F966F678BAB6C414C234D06A7DEB04602C29E21D0952674D0D5840874EDFFBC229EF9C8F50658123B70018F64E1463E2E7AF973000688486F996F501CC38AE0FC8AE2BB06D1E1E700A2CFB09D4460A8338AFCF0C9B9DDDC05045F25FE9CD9FFE6780D3634B75F837364D3203A23ACD5DA78EF02FB7390D033E29C228A3F503B07649FB7AEDF1D6010714E6C1BC7F139183376A60138DC39E005A14787BDE1D822B56D9764EA21D757FB24C272FA29272DFD123585E49B68C854FE4993A8EF82A54BBA899A93EA45CD285A45E5647D456560DD24E5947A415382563933AAC13CBE74848677F952D8DDF7F9D6DBBC756B41458D335821F12F98E0089631E706518A23528E409775631BCE423A7C8CE993EF4D29A78FC84B8666B5D26C481781E167430ABBFBB32115138AEF5D8779251D0E423931C077A2579FB1DAE79C20D9A6A743AD9B9B66BE993540375D4EE238B0DD74162842603C8051971F7C38A33D9A91F5468C8840C7C0D05DB6E54109F4CD148DEA9A9C620F536C9CD85988708A621B39B21AA1434E0FC1F21D5521581919A90BF783C4132C1D47AC116287A01866AA4BA83C2D5C62BB21F25AB524B4ECB885B1BE173CC49A531C62C218B66AA20B737520840950F01106A54D4363AB6271CD86A8F15A7563DEE6C296E32EC5273662932DBEB3C62EB9FFF62486D9ACB10D1867B34ABA08A00DEA6DC340F959A5AB018807975D3350E1C4A43150EE526DC440EB1ADB8281D655F2EC0C343BA2761D7FE1BCBA6BE6593F286F7E5B6F54D7166CB3A68F1D33CDCCF78436145AE04836CFD339ABC40F5471380339F9F92CE6AEAE68220C7C86693D6453FABB4A3FD46A06118DA809B034B416507E1D28014913AA8770792CAF513AEE45F480CDE36E8DB07CED17602B36206357AF452B84FACB53D1383B9D3E8A9E15D6201979A7C34205476110E2E255EF7807A5E8E2B2B262BAF8C27DBCE14AC7F8603428A8C573D52829EFCCE05ACA4DB35D4B2A87AC8F4BB6969604F749A3A5BC33836B89DB68BB92144E410FB7602D15D5B7F081265B1EE928769BA26E6C651953BC606C6952ABC697280C5DB2ACA45AF1126396E5594D5FCCFA271FF9198665C78A1CA442DA82130D22B4C4422DB00649CFDD28A6A788A23962719EA9E34B64CABD55B3FCE72CABDBA73C88F93E9053B3DF590BCD257E6DBF951D128E730EBDF499579386D21536A06E6EB0F437E4A14811BD9F065EE213BD93A56F9DDDE155DB672532C2D812E4979C28496392AB5B577FA7C19127C6800355F831AB0F961E42A7F2DC0BAD2A5DE799EA51F24055154517BCDADAE0E91C9ADE0326FA8BFDC7AB15E169E6174F52A902F0A29E18953C0709AC52D71DB59E8A52C5ACD7744714F24DAA9042550F29AB59253521AB152BE16934AAA6E8CE41CE23A9A2CBB5DD91151925556845F50AD80A99C5BAEEA88AA4932AB0A2BA3B769981222EA43BBC83694F316B6D61D96177BD3D4C83F134ABE2305B60E54EBF0A5429EE89C56FED25305EBE9316A53DF1AD6551599C633D8BD260E857A0DA8D787D016ABCC6D763D6AEB96B8B7CD335BF1EAF9FDD3EA97548873E91A4E05E1CFE8443DE981FB8DA1FD94827B08CC4347235C206FF1853EC8F18C168F6C59B7A2E66CB794E708988BBC031CD523BCCC3FD8343E18DCEEEBC97B1E2D8F1140756DDA399FA986D204B8BDCA3C8BE43919C33B1C69B9212540A475F10073F4CCC3FD356C7696483FD4A8BF78C8BF80371BF2450711B25D8F84BCE011D26C7BEF9C0B5A32F22BA6BF5E28F4F59D33DE33A8219736CEC0BBA5C6584EBEF247A4993355D439A955F4F3CDF09557B92A0441526C4EA2F10E62E1DE4F5412EE5773E7AF8BEAF68CA17066B212A5E110C8537880A75AF0456C1D2BE1070E093A62F04FA7556FD626015D1B4AF055CD21F4C7C2BD07D19CA5B6E71AB519C8B36B124A57A6ECDB55E2BF172DB7B939492BDD64497D3AE7BC0AD915ABD82653CB3ACE4C1764745D2F160D8DB34ED27CF34DE95E4E232ED63BB39C59B4C236EB822FA5F650FEF40BE9B227F67FB39C29BB6355D2C77C7132DFB6502EF98B1F1ACAEEDE7FB6EDAD87461DE1D37B65E59BD3B666BDBDA3FB76C699DB7D0ADE7E8CAE9469A3B19552CB82D07370B9CC3097F1E8011641E65F674529DF4D594B0DAC2B024D133D5679B898CA58923F195289AD9F6EB2BDFF01B3BCB699AD96A72349B78F3F5BF9137A769E6ADC97CDC46F6B032F75095D1DDB28E3525443DA76CE15A4F5A92D3DB7CD6C60BF6E7941C3C88526AB3477347FC7C72810751C99053A747EEAF7CDD0B7B67E52F2FC2FE1DBBCB1282FD1D4682EDDAAE59D05C9045906FDE8244398910A1B9C41439B0A59E44D45D209B42358B31A76FBFD3B81DBBE99863E7825C27344C287419FB73AF16F0624E4013FF34C1B92EF3F83A645FF1105D00315D169BBF263F27AEE714729F2B62421A08E65DF0882E1B4BCA22BBCBC702E92A201D81B8FA0AA7E816FBA10760F13599A17BBC8A6C607EEFF012D98F65045007D23E1075B58F4F5DB48C901F738CB23D7C820D3BFEC39BFF000B618BF780540000, N'6.1.3-40302')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'2', N'Customer')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'1', N'Employee')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [FirstName], [LastName], [Birthday]) VALUES (N'13de3727-ce6e-467a-9d5d-0546f4905295', N'client1@gmail.com', 0, N'ADAX6XOAjhkPTMGrrwPbqAvjrOjLYObojOxjfLqPHhMdwAoOo1NeChz/4NX8DWarPA==', N'38cd597c-6b6b-4799-a0d4-5cea6778d89a', NULL, 0, 0, NULL, 1, 0, N'client1@gmail.com', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [FirstName], [LastName], [Birthday]) VALUES (N'31e5b0ee-65a6-4a3b-8375-6ad2ce9ada41', N'client2@gmail.com', 0, N'ADRAl6KCVcL0jO73VD30rkNtM10BIkdeQUhsiriNjxW3s1Y8is52UGdY4dTnDeG7qA==', N'6387a705-87bc-4209-b992-c30913afdd1b', NULL, 0, 0, NULL, 1, 0, N'Kéké', NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName], [FirstName], [LastName], [Birthday]) VALUES (N'cc6f1e2e-cc2e-41a3-8db2-bb5ef8b47e01', N'h.lasalle@gmail.com', 0, N'AKVFbXola1PnTFCoj5+lnMMB+zzW9iVFwHvEedXCw6px+43Th/XnRZ6A0AeCnN5XGQ==', N'8fa6daba-be3c-4c3e-a471-e5215d173325', NULL, 0, 0, NULL, 1, 0, N'Henri Lasalle', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[BaseTarif] ON 

INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (1, N'AirCar Belgium', 1, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (2, N'AirCar Belgium', 2, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (3, N'AirCar Belgium', 3, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (4, N'AirCar Belgium', 4, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (5, N'AirCar Belgium', 5, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (6, N'AirCar Belgium', 6, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (7, N'AirCar Belgium', 7, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (8, N'AirCar Belgium', 8, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (9, N'AirCar Belgium', 9, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (10, N'AirCar Belgium', 10, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (11, N'AirCar Belgium', 11, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (12, N'AirCar Belgium', 12, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (13, N'AirCar Belgium', 13, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (14, N'AirCar Belgium', 14, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (15, N'AirCar Belgium', 15, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (16, N'AirCar Belgium', 16, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (17, N'AirCar Belgium', 17, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (18, N'AirCar Belgium', 18, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (19, N'AirCar Belgium', 19, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (20, N'AirCar Belgium', 20, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (21, N'AirCar Belgium', 21, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (22, N'AirCar Belgium', 22, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (23, N'AirCar Belgium', 23, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (24, N'AirCar Belgium', 24, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (25, N'AirCar Belgium', 25, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (26, N'AirCar Belgium', 26, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (27, N'AirCar Belgium', 27, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (28, N'AirCar Belgium', 28, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (29, N'AirCar Belgium', 29, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (30, N'AirCar Belgium', 30, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (31, N'AirCar Belgium', 31, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (32, N'AirCar Belgium', 32, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (33, N'AirCar Belgium', 33, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (34, N'AirCar Belgium', 34, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (35, N'AirCar Belgium', 35, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (36, N'AirCar Belgium', 36, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (37, N'AirCar Belgium', 38, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (38, N'AirCar Belgium', 39, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (39, N'AirCar Belgium', 40, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (40, N'AirCar Belgium', 41, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (41, N'AirCar Belgium', 42, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (42, N'AirCar Belgium', 43, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (43, N'AirCar Belgium', 44, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (44, N'Anvers', 1, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (45, N'Anvers', 2, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (46, N'Anvers', 3, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (47, N'Anvers', 4, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (48, N'Anvers', 5, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (49, N'Anvers', 6, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (50, N'Anvers', 7, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (51, N'Anvers', 8, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (52, N'Anvers', 9, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (53, N'Anvers', 10, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (54, N'Anvers', 11, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (55, N'Anvers', 12, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (56, N'Anvers', 13, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (57, N'Anvers', 14, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (58, N'Anvers', 15, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (59, N'Anvers', 16, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (60, N'Anvers', 17, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (61, N'Anvers', 18, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (62, N'Anvers', 19, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (63, N'Anvers', 20, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (64, N'Anvers', 21, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (65, N'Anvers', 22, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (66, N'Anvers', 23, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (67, N'Anvers', 24, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (68, N'Anvers', 25, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (69, N'Anvers', 26, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (70, N'Anvers', 27, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (71, N'Anvers', 28, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (72, N'Anvers', 29, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (73, N'Anvers', 30, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (74, N'Anvers', 31, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (75, N'Anvers', 32, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (76, N'Anvers', 33, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (77, N'Anvers', 34, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (78, N'Anvers', 35, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (79, N'Anvers', 36, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (80, N'Anvers', 38, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (81, N'Anvers', 39, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (82, N'Anvers', 40, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (83, N'Anvers', 41, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (84, N'Anvers', 42, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (85, N'Anvers', 43, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (86, N'Anvers', 44, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (87, N'Bruxelles National', 1, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (88, N'Bruxelles National', 2, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (89, N'Bruxelles National', 3, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (90, N'Bruxelles National', 4, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (91, N'Bruxelles National', 5, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (92, N'Bruxelles National', 6, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (93, N'Bruxelles National', 7, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (94, N'Bruxelles National', 8, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (95, N'Bruxelles National', 9, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (96, N'Bruxelles National', 10, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (97, N'Bruxelles National', 11, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (98, N'Bruxelles National', 12, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (99, N'Bruxelles National', 13, N'Standard', CAST(49.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (100, N'Bruxelles National', 14, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (101, N'Bruxelles National', 15, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (102, N'Bruxelles National', 16, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (103, N'Bruxelles National', 17, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (104, N'Bruxelles National', 18, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (105, N'Bruxelles National', 19, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (106, N'Bruxelles National', 20, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (107, N'Bruxelles National', 21, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (108, N'Bruxelles National', 22, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (109, N'Bruxelles National', 23, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (110, N'Bruxelles National', 24, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (111, N'Bruxelles National', 25, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (112, N'Bruxelles National', 26, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (113, N'Bruxelles National', 27, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (114, N'Bruxelles National', 28, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (115, N'Bruxelles National', 29, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (116, N'Bruxelles National', 30, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (117, N'Bruxelles National', 31, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (118, N'Bruxelles National', 32, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (119, N'Bruxelles National', 33, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (120, N'Bruxelles National', 34, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (121, N'Bruxelles National', 35, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (122, N'Bruxelles National', 36, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (123, N'Bruxelles National', 38, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (124, N'Bruxelles National', 39, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (125, N'Bruxelles National', 40, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (126, N'Bruxelles National', 41, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (127, N'Bruxelles National', 42, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (128, N'Bruxelles National', 43, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (129, N'Bruxelles National', 44, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (130, N'Liège', 1, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (131, N'Liège', 2, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (132, N'Liège', 3, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (133, N'Liège', 4, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (134, N'Liège', 5, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (135, N'Liège', 6, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (136, N'Liège', 7, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (137, N'Liège', 8, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (138, N'Liège', 9, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (139, N'Liège', 10, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (140, N'Liège', 11, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (141, N'Liège', 12, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (142, N'Liège', 13, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (143, N'Liège', 14, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (144, N'Liège', 15, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (145, N'Liège', 16, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (146, N'Liège', 17, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (147, N'Liège', 18, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (148, N'Liège', 19, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (149, N'Liège', 20, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (150, N'Liège', 21, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (151, N'Liège', 22, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (152, N'Liège', 23, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (153, N'Liège', 24, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (154, N'Liège', 25, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (155, N'Liège', 26, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (156, N'Liège', 27, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (157, N'Liège', 28, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (158, N'Liège', 29, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (159, N'Liège', 30, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (160, N'Liège', 31, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (161, N'Liège', 32, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (162, N'Liège', 33, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (163, N'Liège', 34, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (164, N'Liège', 35, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (165, N'Liège', 36, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (166, N'Liège', 38, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (167, N'Liège', 39, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (168, N'Liège', 40, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (169, N'Liège', 41, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (170, N'Liège', 42, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (171, N'Liège', 43, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (172, N'Liège', 44, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (173, N'Steenokkerzeel', 1, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (174, N'Steenokkerzeel', 2, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (175, N'Steenokkerzeel', 3, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (176, N'Steenokkerzeel', 4, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (177, N'Steenokkerzeel', 5, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (178, N'Steenokkerzeel', 6, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (179, N'Steenokkerzeel', 7, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (180, N'Steenokkerzeel', 8, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (181, N'Steenokkerzeel', 9, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (182, N'Steenokkerzeel', 10, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (183, N'Steenokkerzeel', 11, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (184, N'Steenokkerzeel', 12, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (185, N'Steenokkerzeel', 13, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (186, N'Steenokkerzeel', 14, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (187, N'Steenokkerzeel', 15, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (188, N'Steenokkerzeel', 16, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (189, N'Steenokkerzeel', 17, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (190, N'Steenokkerzeel', 18, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (191, N'Steenokkerzeel', 19, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (192, N'Steenokkerzeel', 20, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (193, N'Steenokkerzeel', 21, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (194, N'Steenokkerzeel', 22, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (195, N'Steenokkerzeel', 23, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (196, N'Steenokkerzeel', 24, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (197, N'Steenokkerzeel', 25, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (198, N'Steenokkerzeel', 26, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (199, N'Steenokkerzeel', 27, N'Standard', CAST(49.00 AS Decimal(9, 2)))
GO
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (200, N'Steenokkerzeel', 28, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (201, N'Steenokkerzeel', 29, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (202, N'Steenokkerzeel', 30, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (203, N'Steenokkerzeel', 31, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (204, N'Steenokkerzeel', 32, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (205, N'Steenokkerzeel', 33, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (206, N'Steenokkerzeel', 34, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (207, N'Steenokkerzeel', 35, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (208, N'Steenokkerzeel', 36, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (209, N'Steenokkerzeel', 38, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (210, N'Steenokkerzeel', 39, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (211, N'Steenokkerzeel', 40, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (212, N'Steenokkerzeel', 41, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (213, N'Steenokkerzeel', 42, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (214, N'Steenokkerzeel', 43, N'Standard', CAST(49.00 AS Decimal(9, 2)))
INSERT [dbo].[BaseTarif] ([Id], [Office_name], [VehicleType_Id], [Name], [DailyPrice]) VALUES (215, N'Steenokkerzeel', 44, N'Standard', CAST(49.00 AS Decimal(9, 2)))
SET IDENTITY_INSERT [dbo].[BaseTarif] OFF
INSERT [dbo].[CC] ([Name]) VALUES (N'1.2L')
INSERT [dbo].[CC] ([Name]) VALUES (N'1.4L')
INSERT [dbo].[CC] ([Name]) VALUES (N'1.6L')
INSERT [dbo].[CC] ([Name]) VALUES (N'2L')
INSERT [dbo].[Customer] ([User_Id]) VALUES (N'13de3727-ce6e-467a-9d5d-0546f4905295')
INSERT [dbo].[Customer] ([User_Id]) VALUES (N'cc6f1e2e-cc2e-41a3-8db2-bb5ef8b47e01')
INSERT [dbo].[Doors] ([Count]) VALUES (3)
INSERT [dbo].[Doors] ([Count]) VALUES (5)
INSERT [dbo].[Fuel] ([Name]) VALUES (N'Diesel')
INSERT [dbo].[Fuel] ([Name]) VALUES (N'Gas')
INSERT [dbo].[Fuel] ([Name]) VALUES (N'Hybrid')
INSERT [dbo].[Make] ([Name]) VALUES (N'Ford')
INSERT [dbo].[Make] ([Name]) VALUES (N'Volkswagen')
SET IDENTITY_INSERT [dbo].[Model] ON 

INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (1, N'Ford', N'Fiesta')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (2, N'Ford', N'Focus RS')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (3, N'Ford', N'Focus ST')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (4, N'Ford', N'Focus')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (5, N'Ford', N'Galaxy')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (6, N'Ford', N'Ka')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (7, N'Ford', N'Mondeo')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (8, N'Ford', N'Mustang')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (10, N'Ford', N'S-Max')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (11, N'Ford', N'Tourneo Custom')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (12, N'Ford', N'Tourneo')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (13, N'Volkswagen', N'Touran')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (14, N'Volkswagen', N'Golf Sportsvan')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (15, N'Volkswagen', N'Multivan')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (16, N'Volkswagen', N'Polo')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (17, N'Volkswagen', N'Touareg')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (18, N'Volkswagen', N'Golf')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (19, N'Volkswagen', N'Golf Variant')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (20, N'Volkswagen', N'Up')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (21, N'Volkswagen', N'Tiguan')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (22, N'Volkswagen', N'Passat Variant')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (23, N'Volkswagen', N'Passat')
INSERT [dbo].[Model] ([Id], [Make_name], [Name]) VALUES (24, N'Volkswagen', N'Beetle')
SET IDENTITY_INSERT [dbo].[Model] OFF
INSERT [dbo].[Office] ([Name]) VALUES (N'AirCar Belgium')
INSERT [dbo].[Office] ([Name]) VALUES (N'Anvers')
INSERT [dbo].[Office] ([Name]) VALUES (N'Bruxelles National')
INSERT [dbo].[Office] ([Name]) VALUES (N'Liège')
INSERT [dbo].[Office] ([Name]) VALUES (N'Steenokkerzeel')
SET IDENTITY_INSERT [dbo].[Picture] ON 

INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (3, 1, N'Fiesta', 0, N'~\Content\Images\Fiesta.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (4, 2, N'Focus RS', 0, N'~\Content\Images\Focus RS.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (5, 3, N'Focus ST', 0, N'~\Content\Images\Focus ST.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (6, 4, N'Focus', 0, N'~\Content\Images\Focus.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (7, 5, N'Galaxy', 0, N'~\Content\Images\Galaxy.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (8, 6, N'Ka', 0, N'~\Content\Images\Ka.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (9, 7, N'Mondeo', 0, N'~\Content\Images\Mondeo.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (10, 8, N'Mustang', 0, N'~\Content\Images\Mustang.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (11, 10, N'S-Max', 0, N'~\Content\Images\S-Max.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (12, 11, N'Tourneo Custom', 0, N'~\Content\Images\Tourneo Custom.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (13, 12, N'Tourneo', 0, N'~\Content\Images\Tourneo.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (14, 13, N'Touran', 0, N'~\Content\Images\Touran_L.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (15, 14, N'Golf Sportsvan', 0, N'~\Content\Images\Golf Sportsvan.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (16, 15, N'Multivan', 0, N'~\Content\Images\Multivan_L.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (17, 16, N'Polo', 0, N'~\Content\Images\Polo.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (18, 17, N'Touareg', 0, N'~\Content\Images\Touareg_L.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (19, 18, N'Golf', 0, N'~\Content\Images\Golf.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (20, 19, N'Golf Variant', 0, N'~\Content\Images\Golf Variant.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (21, 20, N'Up', 0, N'~\Content\Images\Up.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (22, 21, N'Tiguan', 0, N'~\Content\Images\Tiguan_L.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (23, 22, N'Passat Variant', 0, N'~\Content\Images\Passat Variant_L.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (24, 23, N'Passat', 0, N'~\Content\Images\Passat.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (25, 24, N'Beetle', 0, N'~\Content\Images\Beetle.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (28, 18, N'Golf_L', 1, N'~\Content\Images\Golf_L.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (29, 19, N'Golf Variant_L', 1, N'~\Content\Images\Golf Variant_L.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (30, 23, N'Passat_L', 1, N'~\Content\Images\Passat_L.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (31, 16, N'Polo_L', 1, N'~\Content\Images\Polo_L.png')
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (32, 20, N'Up_L', 1, N'~\Content\Images\Up_L.png')
SET IDENTITY_INSERT [dbo].[Picture] OFF
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 1)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 2)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 3)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 4)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 5)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 6)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 7)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 8)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 9)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 10)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 11)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 12)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 13)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 14)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 15)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 16)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 17)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 18)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 19)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 20)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 21)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 22)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 23)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 24)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 25)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 26)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 27)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 28)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 29)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 30)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 31)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 32)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 33)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 34)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 35)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 36)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 38)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 39)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 40)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 41)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 42)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 43)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (1, 44)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 1)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 2)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 3)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 4)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 5)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 6)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 7)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 8)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 9)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 10)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 11)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 12)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 13)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 14)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 15)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 16)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 17)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 18)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 19)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 20)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 21)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 22)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 23)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 24)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 25)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 26)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 27)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 28)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 29)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 30)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 31)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 32)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 33)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 34)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 35)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 36)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 38)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 39)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 40)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 41)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 42)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 43)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (4, 44)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 1)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 2)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 3)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 4)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 5)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 6)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 7)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 8)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 9)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 10)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 11)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 12)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 13)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 14)
GO
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 15)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 16)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 17)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 18)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 19)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 20)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 21)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 22)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 23)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 24)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 25)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 26)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 27)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 28)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 29)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 30)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 31)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 32)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 33)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 34)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 35)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 36)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 38)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 39)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 40)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 41)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 42)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 43)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (5, 44)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 1)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 2)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 3)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 4)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 5)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 6)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 7)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 8)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 9)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 10)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 11)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 12)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 13)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 14)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 15)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 16)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 17)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 18)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 19)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 20)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 21)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 22)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 23)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 24)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 25)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 26)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 27)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 28)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 29)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 30)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 31)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 32)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 33)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 34)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 35)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 36)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 38)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 39)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 40)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 41)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 42)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 43)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (9, 44)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 1)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 2)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 3)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 4)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 5)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 6)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 7)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 8)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 9)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 10)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 11)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 12)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 13)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 14)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 15)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 16)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 17)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 18)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 19)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 20)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 21)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 22)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 23)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 24)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 25)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 26)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 27)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 28)
GO
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 29)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 30)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 31)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 32)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 33)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 34)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 35)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 36)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 38)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 39)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 40)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 41)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 42)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 43)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (10, 44)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 1)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 2)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 3)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 4)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 5)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 6)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 7)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 8)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 9)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 10)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 11)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 12)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 13)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 14)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 15)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 16)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 17)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 18)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 19)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 20)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 21)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 22)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 23)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 24)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 25)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 26)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 27)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 28)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 29)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 30)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 31)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 32)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 33)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 34)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 35)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 36)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 38)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 39)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 40)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 41)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 42)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 43)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (11, 44)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 1)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 2)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 3)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 4)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 5)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 6)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 7)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 8)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 9)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 10)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 11)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 12)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 13)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 14)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 15)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 16)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 17)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 18)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 19)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 20)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 21)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 22)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 23)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 24)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 25)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 26)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 27)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 28)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 29)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 30)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 31)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 32)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 33)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 34)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 35)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 36)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 38)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 39)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 40)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 41)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 42)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 43)
GO
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (12, 44)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 1)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 2)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 3)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 4)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 5)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 6)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 7)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 8)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 9)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 10)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 11)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 12)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 13)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 14)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 15)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 16)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 17)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 18)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 19)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 20)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 21)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 22)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 23)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 24)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 25)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 26)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 27)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 28)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 29)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 30)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 31)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 32)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 33)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 34)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 35)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 36)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 38)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 39)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 40)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 41)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 42)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 43)
INSERT [dbo].[Promo_VehicleType] ([PromotionModel_Id], [VehicleType_Id]) VALUES (13, 44)
SET IDENTITY_INSERT [dbo].[PromoTarget] ON 

INSERT [dbo].[PromoTarget] ([Id], [PromoModel_Id], [Make_Name], [Model_Name], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (7, 13, N'Ford', NULL, NULL, NULL, NULL)
INSERT [dbo].[PromoTarget] ([Id], [PromoModel_Id], [Make_Name], [Model_Name], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (8, 13, N'Volkswagen', NULL, NULL, NULL, NULL)
INSERT [dbo].[PromoTarget] ([Id], [PromoModel_Id], [Make_Name], [Model_Name], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (9, 1, NULL, NULL, N'Gas', NULL, NULL)
INSERT [dbo].[PromoTarget] ([Id], [PromoModel_Id], [Make_Name], [Model_Name], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (10, 4, NULL, N'Golf', NULL, NULL, NULL)
INSERT [dbo].[PromoTarget] ([Id], [PromoModel_Id], [Make_Name], [Model_Name], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (11, 5, NULL, NULL, NULL, NULL, 3)
INSERT [dbo].[PromoTarget] ([Id], [PromoModel_Id], [Make_Name], [Model_Name], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (13, 9, N'Ford', NULL, NULL, NULL, NULL)
INSERT [dbo].[PromoTarget] ([Id], [PromoModel_Id], [Make_Name], [Model_Name], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (14, 11, NULL, NULL, N'Diesel', NULL, NULL)
INSERT [dbo].[PromoTarget] ([Id], [PromoModel_Id], [Make_Name], [Model_Name], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (15, 10, NULL, NULL, NULL, N'1.4L', 5)
INSERT [dbo].[PromoTarget] ([Id], [PromoModel_Id], [Make_Name], [Model_Name], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (16, 12, NULL, NULL, N'Gas', NULL, NULL)
SET IDENTITY_INSERT [dbo].[PromoTarget] OFF
SET IDENTITY_INSERT [dbo].[PromotionModel] ON 

INSERT [dbo].[PromotionModel] ([Id], [Office_Name], [Name], [StartDate], [EndDate], [PercentReduc], [FixedReduc]) VALUES (1, N'Anvers', N'Promo Annuelle', CAST(N'2018-01-01' AS Date), CAST(N'2018-12-31' AS Date), 5, NULL)
INSERT [dbo].[PromotionModel] ([Id], [Office_Name], [Name], [StartDate], [EndDate], [PercentReduc], [FixedReduc]) VALUES (4, N'Anvers', N'Promo Annuelle 2', CAST(N'2018-01-01' AS Date), CAST(N'2018-12-31' AS Date), 1, CAST(15.00 AS Decimal(9, 2)))
INSERT [dbo].[PromotionModel] ([Id], [Office_Name], [Name], [StartDate], [EndDate], [PercentReduc], [FixedReduc]) VALUES (5, N'Anvers', N'Promo Annuelle 3', CAST(N'2018-01-01' AS Date), CAST(N'2018-12-31' AS Date), 0, CAST(25.00 AS Decimal(9, 2)))
INSERT [dbo].[PromotionModel] ([Id], [Office_Name], [Name], [StartDate], [EndDate], [PercentReduc], [FixedReduc]) VALUES (9, N'Liège', N'Promo Annuelle 3', CAST(N'2018-01-01' AS Date), CAST(N'2018-12-31' AS Date), 0, CAST(25.00 AS Decimal(9, 2)))
INSERT [dbo].[PromotionModel] ([Id], [Office_Name], [Name], [StartDate], [EndDate], [PercentReduc], [FixedReduc]) VALUES (10, N'Bruxelles National', N'Promo Annuelle 3', CAST(N'2018-01-01' AS Date), CAST(N'2018-12-31' AS Date), 0, CAST(25.00 AS Decimal(9, 2)))
INSERT [dbo].[PromotionModel] ([Id], [Office_Name], [Name], [StartDate], [EndDate], [PercentReduc], [FixedReduc]) VALUES (11, N'Liège', N'Promo Annuelle', CAST(N'2018-01-01' AS Date), CAST(N'2018-12-31' AS Date), 5, NULL)
INSERT [dbo].[PromotionModel] ([Id], [Office_Name], [Name], [StartDate], [EndDate], [PercentReduc], [FixedReduc]) VALUES (12, N'Bruxelles National', N'Promo Annuelle', CAST(N'2018-01-01' AS Date), CAST(N'2018-12-31' AS Date), 5, NULL)
INSERT [dbo].[PromotionModel] ([Id], [Office_Name], [Name], [StartDate], [EndDate], [PercentReduc], [FixedReduc]) VALUES (13, N'AirCar Belgium', N'Promo Globale', CAST(N'2018-01-01' AS Date), CAST(N'2018-12-31' AS Date), 2, NULL)
SET IDENTITY_INSERT [dbo].[PromotionModel] OFF
SET IDENTITY_INSERT [dbo].[Reservation] ON 

INSERT [dbo].[Reservation] ([Id], [Vehicle_Id], [Customer_Id], [ReservationDate], [StartDate], [EndDate], [PickupDate], [ReturnDate], [ToPay], [Paid], [Employee_Id], [IsClosed]) VALUES (3, 45, N'13de3727-ce6e-467a-9d5d-0546f4905295', CAST(N'2018-10-05T00:00:00.000' AS DateTime), CAST(N'2018-10-07' AS Date), CAST(N'2018-10-12' AS Date), NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[Reservation] ([Id], [Vehicle_Id], [Customer_Id], [ReservationDate], [StartDate], [EndDate], [PickupDate], [ReturnDate], [ToPay], [Paid], [Employee_Id], [IsClosed]) VALUES (8, 20, N'cc6f1e2e-cc2e-41a3-8db2-bb5ef8b47e01', CAST(N'2018-09-02T00:00:00.000' AS DateTime), CAST(N'2018-09-03' AS Date), CAST(N'2018-09-05' AS Date), NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[Reservation] ([Id], [Vehicle_Id], [Customer_Id], [ReservationDate], [StartDate], [EndDate], [PickupDate], [ReturnDate], [ToPay], [Paid], [Employee_Id], [IsClosed]) VALUES (9, 30, N'cc6f1e2e-cc2e-41a3-8db2-bb5ef8b47e01', CAST(N'2018-09-10T00:00:00.000' AS DateTime), CAST(N'2018-09-10' AS Date), CAST(N'2018-09-18' AS Date), NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[Reservation] ([Id], [Vehicle_Id], [Customer_Id], [ReservationDate], [StartDate], [EndDate], [PickupDate], [ReturnDate], [ToPay], [Paid], [Employee_Id], [IsClosed]) VALUES (12, 28, N'13de3727-ce6e-467a-9d5d-0546f4905295', CAST(N'2018-08-29T00:00:00.000' AS DateTime), CAST(N'2018-09-03' AS Date), CAST(N'2018-09-15' AS Date), NULL, NULL, NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Reservation] OFF
SET IDENTITY_INSERT [dbo].[Vehicle] ON 

INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (11, N'Anvers', 1)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (13, N'Anvers', 3)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (14, N'Anvers', 3)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (15, N'Anvers', 4)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (16, N'Anvers', 4)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (17, N'Anvers', 5)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (18, N'Anvers', 5)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (19, N'Anvers', 2)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (20, N'Anvers', 2)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (21, N'Anvers', 6)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (22, N'Anvers', 6)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (23, N'Anvers', 7)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (25, N'Anvers', 1)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (27, N'Liège', 1)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (28, N'Steenokkerzeel', 1)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (30, N'Anvers', 1)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (32, N'Liège', 1)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (33, N'Steenokkerzeel', 1)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (35, N'Anvers', 1)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (37, N'Liège', 1)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (38, N'Steenokkerzeel', 1)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (40, N'Anvers', 1)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (43, N'Steenokkerzeel', 1)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (45, N'Anvers', 2)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (46, N'Bruxelles National', 2)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (48, N'Steenokkerzeel', 2)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (50, N'Anvers', 3)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (51, N'Bruxelles National', 3)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (52, N'Liège', 3)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (55, N'Anvers', 4)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (56, N'Bruxelles National', 4)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (58, N'Steenokkerzeel', 4)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (60, N'Anvers', 4)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (61, N'Bruxelles National', 4)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (63, N'Steenokkerzeel', 4)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (65, N'Anvers', 4)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (66, N'Bruxelles National', 4)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (68, N'Steenokkerzeel', 4)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (70, N'Anvers', 5)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (71, N'Bruxelles National', 5)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (72, N'Liège', 5)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (75, N'Anvers', 5)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (76, N'Bruxelles National', 5)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (77, N'Liège', 5)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (80, N'Anvers', 6)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (81, N'Bruxelles National', 6)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (82, N'Liège', 6)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (83, N'Steenokkerzeel', 6)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (86, N'Bruxelles National', 7)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (87, N'Liège', 7)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (88, N'Steenokkerzeel', 7)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (91, N'Bruxelles National', 7)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (92, N'Liège', 7)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (93, N'Steenokkerzeel', 7)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (96, N'Bruxelles National', 7)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (97, N'Liège', 7)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (98, N'Steenokkerzeel', 7)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (101, N'Bruxelles National', 8)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (102, N'Liège', 8)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (103, N'Steenokkerzeel', 8)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (105, N'Anvers', 8)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (106, N'Bruxelles National', 8)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (108, N'Steenokkerzeel', 8)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (110, N'Anvers', 8)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (111, N'Bruxelles National', 8)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (113, N'Steenokkerzeel', 8)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (115, N'Anvers', 10)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (116, N'Bruxelles National', 10)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (117, N'Liège', 10)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (120, N'Anvers', 10)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (121, N'Bruxelles National', 10)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (122, N'Liège', 10)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (125, N'Anvers', 11)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (126, N'Bruxelles National', 11)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (127, N'Liège', 11)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (128, N'Steenokkerzeel', 11)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (130, N'Anvers', 12)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (132, N'Liège', 12)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (133, N'Steenokkerzeel', 12)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (135, N'Anvers', 12)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (137, N'Liège', 12)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (138, N'Steenokkerzeel', 12)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (141, N'Bruxelles National', 13)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (142, N'Liège', 13)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (143, N'Steenokkerzeel', 13)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (145, N'Anvers', 14)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (146, N'Bruxelles National', 14)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (147, N'Liège', 14)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (148, N'Steenokkerzeel', 14)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (151, N'Bruxelles National', 15)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (152, N'Liège', 15)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (153, N'Steenokkerzeel', 15)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (156, N'Bruxelles National', 15)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (157, N'Liège', 15)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (158, N'Steenokkerzeel', 15)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (160, N'Anvers', 16)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (162, N'Liège', 16)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (163, N'Steenokkerzeel', 16)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (165, N'Anvers', 17)
GO
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (166, N'Bruxelles National', 17)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (168, N'Steenokkerzeel', 17)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (170, N'Anvers', 17)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (171, N'Bruxelles National', 17)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (173, N'Steenokkerzeel', 17)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (175, N'Anvers', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (176, N'Bruxelles National', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (177, N'Liège', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (178, N'Steenokkerzeel', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (181, N'Bruxelles National', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (183, N'Steenokkerzeel', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (185, N'Anvers', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (186, N'Bruxelles National', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (188, N'Steenokkerzeel', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (190, N'Anvers', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (191, N'Bruxelles National', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (192, N'Liège', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (193, N'Steenokkerzeel', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (195, N'Anvers', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (196, N'Bruxelles National', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (197, N'Liège', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (198, N'Steenokkerzeel', 18)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (200, N'Anvers', 19)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (201, N'Bruxelles National', 19)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (202, N'Liège', 19)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (203, N'Steenokkerzeel', 19)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (205, N'Anvers', 20)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (206, N'Bruxelles National', 20)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (207, N'Liège', 20)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (208, N'Steenokkerzeel', 20)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (211, N'Bruxelles National', 21)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (212, N'Liège', 21)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (213, N'Steenokkerzeel', 21)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (216, N'Bruxelles National', 21)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (217, N'Liège', 21)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (220, N'Anvers', 22)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (221, N'Bruxelles National', 22)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (222, N'Liège', 22)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (223, N'Steenokkerzeel', 22)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (225, N'Anvers', 23)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (227, N'Liège', 23)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (238, N'Steenokkerzeel', 23)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (239, N'Anvers', 34)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (242, N'Anvers', 35)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (243, N'Anvers', 30)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (244, N'Bruxelles National', 31)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (245, N'Bruxelles National', 29)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (246, N'Bruxelles National', 28)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (247, N'Liège', 30)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (248, N'Liège', 27)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (249, N'Liège', 25)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (250, N'Liège', 36)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (251, N'Liège', 41)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (252, N'Bruxelles National', 42)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (253, N'Bruxelles National', 43)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (254, N'Steenokkerzeel', 42)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (255, N'Steenokkerzeel', 38)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (256, N'Steenokkerzeel', 34)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (257, N'Steenokkerzeel', 44)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (258, N'Steenokkerzeel', 29)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (259, N'Anvers', 42)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (260, N'Anvers', 44)
INSERT [dbo].[Vehicle] ([Id], [Office_Name], [VehicleType_Id]) VALUES (261, N'Bruxelles National', 40)
SET IDENTITY_INSERT [dbo].[Vehicle] OFF
SET IDENTITY_INSERT [dbo].[VehicleType] ON 

INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (3, 1, N'DIESEL', N'1.4L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (4, 1, N'DIESEL', N'1.6L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (1, 1, N'gas', N'1.2L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (2, 1, N'GAS', N'1.4L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (5, 2, N'GAS', N'1.6L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (6, 3, N'GAS', N'1.6L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (8, 4, N'DIESEL', N'1.4L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (7, 4, N'GAS', N'1.4L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (38, 4, N'HYBRID', N'1.4L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (10, 5, N'DIESEL', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (9, 5, N'GAS', N'1.4L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (11, 6, N'GAS', N'1.2L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (13, 7, N'DIESEL', N'1.4L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (14, 7, N'DIESEL', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (12, 7, N'GAS', N'1.4L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (15, 8, N'GAS', N'1.6L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (16, 8, N'GAS', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (17, 8, N'GAS', N'2L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (19, 10, N'DIESEL', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (18, 10, N'GAS', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (20, 11, N'DIESEL', N'2L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (21, 12, N'DIESEL', N'1.4L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (22, 12, N'DIESEL', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (23, 13, N'DIESEL', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (24, 14, N'GAS', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (25, 15, N'DIESEL', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (26, 15, N'GAS', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (27, 16, N'GAS', N'1.2L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (29, 17, N'DIESEL', N'2L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (28, 17, N'GAS', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (30, 18, N'DIESEL', N'1.4L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (31, 18, N'DIESEL', N'1.6L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (32, 18, N'GAS', N'1.2L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (33, 18, N'GAS', N'1.4L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (34, 18, N'GAS', N'1.4L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (35, 19, N'DIESEL', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (36, 20, N'GAS', N'1.2L', 3)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (40, 21, N'DIESEL', N'2L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (39, 21, N'GAS', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (41, 22, N'DIESEL', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (42, 23, N'DIESEL', N'1.6L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (43, 23, N'GAS', N'1.4L', 5)
INSERT [dbo].[VehicleType] ([Id], [Model_Id], [Fuel_Name], [CC_Name], [Doors_Count]) VALUES (44, 23, N'HYBRID', N'1.6L', 5)
SET IDENTITY_INSERT [dbo].[VehicleType] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 25-08-18 08:10:19 ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RoleId]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 25-08-18 08:10:19 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_EmployeeOffice]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_EmployeeOffice] ON [dbo].[Employee]
(
	[Office_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UN_Name]    Script Date: 25-08-18 08:10:19 ******/
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [UN_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ModelMake]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_ModelMake] ON [dbo].[Model]
(
	[Make_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Picture]    Script Date: 25-08-18 08:10:19 ******/
ALTER TABLE [dbo].[Picture] ADD  CONSTRAINT [IX_Picture] UNIQUE NONCLUSTERED 
(
	[Model_Id] ASC,
	[Label] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Promo_Reservation]    Script Date: 25-08-18 08:10:19 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Promo_Reservation] ON [dbo].[Promo_VehicleType]
(
	[PromotionModel_Id] ASC,
	[VehicleType_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PromoTargetCC]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_PromoTargetCC] ON [dbo].[PromoTarget]
(
	[CC_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PromoTargetDoors]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_PromoTargetDoors] ON [dbo].[PromoTarget]
(
	[Doors_Count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PromoTargetFuel]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_PromoTargetFuel] ON [dbo].[PromoTarget]
(
	[Fuel_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PromoTargetMake]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_PromoTargetMake] ON [dbo].[PromoTarget]
(
	[Make_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PromoTargetModel]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_PromoTargetModel] ON [dbo].[PromoTarget]
(
	[Model_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PromoTargetPromo]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_PromoTargetPromo] ON [dbo].[PromoTarget]
(
	[PromoModel_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UN_PromotionModel]    Script Date: 25-08-18 08:10:19 ******/
ALTER TABLE [dbo].[PromotionModel] ADD  CONSTRAINT [UN_PromotionModel] UNIQUE NONCLUSTERED 
(
	[Office_Name] ASC,
	[Name] ASC,
	[StartDate] ASC,
	[EndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PromotionModelOffice]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_PromotionModelOffice] ON [dbo].[PromotionModel]
(
	[Office_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ReservationCstmr]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_ReservationCstmr] ON [dbo].[Reservation]
(
	[Customer_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ReservationEmployee]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_ReservationEmployee] ON [dbo].[Reservation]
(
	[Employee_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ReservationVehicle]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_ReservationVehicle] ON [dbo].[Reservation]
(
	[Vehicle_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_VehicleTarif]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_VehicleTarif] ON [dbo].[Vehicle]
(
	[Office_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_VehicleType]    Script Date: 25-08-18 08:10:19 ******/
CREATE NONCLUSTERED INDEX [IX_VehicleType] ON [dbo].[Vehicle]
(
	[VehicleType_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_VehicleType_Unique]    Script Date: 25-08-18 08:10:19 ******/
ALTER TABLE [dbo].[VehicleType] ADD  CONSTRAINT [IX_VehicleType_Unique] UNIQUE NONCLUSTERED 
(
	[Model_Id] ASC,
	[Fuel_Name] ASC,
	[CC_Name] ASC,
	[Doors_Count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Picture] ADD  CONSTRAINT [DF_Picture_IsLarge]  DEFAULT ((0)) FOR [IsLarge]
GO
ALTER TABLE [dbo].[Reservation] ADD  CONSTRAINT [DF_Reservation_ReservationDate]  DEFAULT (getdate()) FOR [ReservationDate]
GO
ALTER TABLE [dbo].[Reservation] ADD  CONSTRAINT [DF_Reservation_IsClosed]  DEFAULT ((0)) FOR [IsClosed]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[BaseTarif]  WITH CHECK ADD  CONSTRAINT [FK_BaseTarif_Office] FOREIGN KEY([Office_name])
REFERENCES [dbo].[Office] ([Name])
GO
ALTER TABLE [dbo].[BaseTarif] CHECK CONSTRAINT [FK_BaseTarif_Office]
GO
ALTER TABLE [dbo].[BaseTarif]  WITH CHECK ADD  CONSTRAINT [FK_BaseTarif_VehicleType] FOREIGN KEY([VehicleType_Id])
REFERENCES [dbo].[VehicleType] ([Id])
GO
ALTER TABLE [dbo].[BaseTarif] CHECK CONSTRAINT [FK_BaseTarif_VehicleType]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Person] FOREIGN KEY([User_Id])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Person]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Office] FOREIGN KEY([Office_Name])
REFERENCES [dbo].[Office] ([Name])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Office]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Person] FOREIGN KEY([User_ID])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Person]
GO
ALTER TABLE [dbo].[Model]  WITH CHECK ADD  CONSTRAINT [FK_Model_Make] FOREIGN KEY([Make_name])
REFERENCES [dbo].[Make] ([Name])
GO
ALTER TABLE [dbo].[Model] CHECK CONSTRAINT [FK_Model_Make]
GO
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_AspNetUsers] FOREIGN KEY([AspNetUsers_Id])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_AspNetUsers]
GO
ALTER TABLE [dbo].[Picture]  WITH CHECK ADD  CONSTRAINT [FK_Picture_Model] FOREIGN KEY([Model_Id])
REFERENCES [dbo].[Model] ([Id])
GO
ALTER TABLE [dbo].[Picture] CHECK CONSTRAINT [FK_Picture_Model]
GO
ALTER TABLE [dbo].[Promo_VehicleType]  WITH CHECK ADD  CONSTRAINT [FK_Promo_Reservation_PromotionModel] FOREIGN KEY([PromotionModel_Id])
REFERENCES [dbo].[PromotionModel] ([Id])
GO
ALTER TABLE [dbo].[Promo_VehicleType] CHECK CONSTRAINT [FK_Promo_Reservation_PromotionModel]
GO
ALTER TABLE [dbo].[Promo_VehicleType]  WITH CHECK ADD  CONSTRAINT [FK_Promo_Reservation_VehicleType] FOREIGN KEY([VehicleType_Id])
REFERENCES [dbo].[VehicleType] ([Id])
GO
ALTER TABLE [dbo].[Promo_VehicleType] CHECK CONSTRAINT [FK_Promo_Reservation_VehicleType]
GO
ALTER TABLE [dbo].[PromoTarget]  WITH CHECK ADD  CONSTRAINT [FK_PromoTarget_CC] FOREIGN KEY([CC_Name])
REFERENCES [dbo].[CC] ([Name])
GO
ALTER TABLE [dbo].[PromoTarget] CHECK CONSTRAINT [FK_PromoTarget_CC]
GO
ALTER TABLE [dbo].[PromoTarget]  WITH CHECK ADD  CONSTRAINT [FK_PromoTarget_Doors] FOREIGN KEY([Doors_Count])
REFERENCES [dbo].[Doors] ([Count])
GO
ALTER TABLE [dbo].[PromoTarget] CHECK CONSTRAINT [FK_PromoTarget_Doors]
GO
ALTER TABLE [dbo].[PromoTarget]  WITH CHECK ADD  CONSTRAINT [FK_PromoTarget_Fuel] FOREIGN KEY([Fuel_Name])
REFERENCES [dbo].[Fuel] ([Name])
GO
ALTER TABLE [dbo].[PromoTarget] CHECK CONSTRAINT [FK_PromoTarget_Fuel]
GO
ALTER TABLE [dbo].[PromoTarget]  WITH CHECK ADD  CONSTRAINT [FK_PromoTarget_Make] FOREIGN KEY([Make_Name])
REFERENCES [dbo].[Make] ([Name])
GO
ALTER TABLE [dbo].[PromoTarget] CHECK CONSTRAINT [FK_PromoTarget_Make]
GO
ALTER TABLE [dbo].[PromoTarget]  WITH CHECK ADD  CONSTRAINT [FK_PromoTarget_Model] FOREIGN KEY([Model_Name])
REFERENCES [dbo].[Model] ([Name])
GO
ALTER TABLE [dbo].[PromoTarget] CHECK CONSTRAINT [FK_PromoTarget_Model]
GO
ALTER TABLE [dbo].[PromoTarget]  WITH CHECK ADD  CONSTRAINT [FK_PromoTarget_PromotionModel] FOREIGN KEY([PromoModel_Id])
REFERENCES [dbo].[PromotionModel] ([Id])
GO
ALTER TABLE [dbo].[PromoTarget] CHECK CONSTRAINT [FK_PromoTarget_PromotionModel]
GO
ALTER TABLE [dbo].[PromotionModel]  WITH CHECK ADD  CONSTRAINT [FK_PromotionModel_Office] FOREIGN KEY([Office_Name])
REFERENCES [dbo].[Office] ([Name])
GO
ALTER TABLE [dbo].[PromotionModel] CHECK CONSTRAINT [FK_PromotionModel_Office]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Customer] FOREIGN KEY([Customer_Id])
REFERENCES [dbo].[Customer] ([User_Id])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_Customer]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Employee] FOREIGN KEY([Employee_Id])
REFERENCES [dbo].[Employee] ([User_ID])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_Employee]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Vehicle] FOREIGN KEY([Vehicle_Id])
REFERENCES [dbo].[Vehicle] ([Id])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_Vehicle]
GO
ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Type_Vehicle] FOREIGN KEY([VehicleType_Id])
REFERENCES [dbo].[VehicleType] ([Id])
GO
ALTER TABLE [dbo].[Vehicle] CHECK CONSTRAINT [FK_Type_Vehicle]
GO
ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_Office] FOREIGN KEY([Office_Name])
REFERENCES [dbo].[Office] ([Name])
GO
ALTER TABLE [dbo].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_Office]
GO
ALTER TABLE [dbo].[VehicleType]  WITH CHECK ADD  CONSTRAINT [FK_VehicleType_CC] FOREIGN KEY([CC_Name])
REFERENCES [dbo].[CC] ([Name])
GO
ALTER TABLE [dbo].[VehicleType] CHECK CONSTRAINT [FK_VehicleType_CC]
GO
ALTER TABLE [dbo].[VehicleType]  WITH CHECK ADD  CONSTRAINT [FK_VehicleType_Doors] FOREIGN KEY([Doors_Count])
REFERENCES [dbo].[Doors] ([Count])
GO
ALTER TABLE [dbo].[VehicleType] CHECK CONSTRAINT [FK_VehicleType_Doors]
GO
ALTER TABLE [dbo].[VehicleType]  WITH CHECK ADD  CONSTRAINT [FK_VehicleType_Fuel] FOREIGN KEY([Fuel_Name])
REFERENCES [dbo].[Fuel] ([Name])
GO
ALTER TABLE [dbo].[VehicleType] CHECK CONSTRAINT [FK_VehicleType_Fuel]
GO
ALTER TABLE [dbo].[VehicleType]  WITH CHECK ADD  CONSTRAINT [FK_VehicleType_Model] FOREIGN KEY([Model_Id])
REFERENCES [dbo].[Model] ([Id])
GO
ALTER TABLE [dbo].[VehicleType] CHECK CONSTRAINT [FK_VehicleType_Model]
GO
/****** Object:  StoredProcedure [SchCommon].[AddCustomer]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:
-- Create date: 
-- Description:	Création d'un client.
-- =============================================
CREATE PROCEDURE [SchCommon].[AddCustomer]
	@new_ID			int	OUTPUT,		
	@name		varchar(50),
	@surName	varchar(50),
	@birthDate	date,
	@email	varchar(50),
	@phone	varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	INSERT INTO  [SchCommon].[vCustomer]([Name],[Surname],BirthDate,Email,Phone) VALUES (@name,@surName,@birthDate, @email, @phone);
	SET @new_ID = SCOPE_IDENTITY() --Affecte l'id généré.
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetCCList]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des catégories de cylindrées (textuel, en L).
-- =============================================
CREATE PROCEDURE [SchCommon].[GetCCList]
	
 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT [Name] FROM [SchCommon].[vCC]
	 
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetCustomerByuserName]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:
-- Create date: 
-- Description:	Récupération des détails d'un client par son UserName.
-- =============================================
CREATE PROCEDURE [SchCommon].[GetCustomerByuserName]
	
	@UserName NVARCHAR(256)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT [Id],[UserName],[FirstName],[LastName],[Birthday],[Email],[PhoneNumber] FROM [SchCommon].[vCustomer]
	WHERE [UserName]=@UserName
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetCustomerDetails]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:
-- Create date: 
-- Description:	Récupération des détails d'un client par son ID.
-- =============================================
Create PROCEDURE [SchCommon].[GetCustomerDetails]
	
	@Id  INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT [Name],[Surname],BirthDate,Email,Phone FROM [SchCommon].[vCustomer]
	WHERE Pers_Id=@Id
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetDoorsList]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des catégories de nombre de portes.
-- =============================================
Create PROCEDURE [SchCommon].[GetDoorsList]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT * FROM [SchCommon].[vDoors]
	 
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetFuelList]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des catégories de carburant.
-- =============================================
Create PROCEDURE [SchCommon].[GetFuelList]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT * FROM [SchCommon].[vFuel]
	 
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetMakeList]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des catégories de constructeurs (Marques).
-- =============================================
Create PROCEDURE [SchCommon].[GetMakeList]
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT * FROM [SchCommon].[vMake]
	 
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetModelsByMake]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des modèles d'un constructeur.
-- =============================================
Create PROCEDURE [SchCommon].[GetModelsByMake]
	
	@makeName	varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT * FROM [SchCommon].[vModel]
	WHERE Make_name = @makeName;
	 
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetOfficeList]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération de la liste des agences / emplacements.
-- =============================================
Create PROCEDURE [SchCommon].[GetOfficeList]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT [Name] FROM [SchCommon].vOffice
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetPictures]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Description:	Récupération des photos d'un type de véhicule.
-- =============================================
CREATE PROCEDURE [SchCommon].[GetPictures]

@vehicleTypeId	int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT * FROM [SchCommon].[vPicture]
			WHERE  VehicleType_Id =@vehicleTypeId;
	 
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetPromoByVehicle]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des promos liées à un type véhicule.
-- pour clients et employés.
-- =============================================
CREATE PROCEDURE [SchCommon].[GetPromoByVehicle]
	
	@vehicleTypeId	int,
	@officeName	varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT * FROM [SchCommon].[vPromo]
	WHERE VehicleType_Id = @vehicleTypeId AND Office_Name = @officeName;
	 
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetPromoModels]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des promos par agences.
-- (les promotions globales sont celles du siège (AirCar Belgium).
-- Pour clients et employés.
-- =============================================
CREATE PROCEDURE [SchCommon].[GetPromoModels]
	
	@officeName	varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT DISTINCT  PromotionModel_Id,[Name],Office_Name,[StartDate],[EndDate],[PercentReduc],[FixedReduc] FROM [SchCommon].[vPromo]
	WHERE Office_Name = @officeName;
	 
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetReservationByCstmr]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Description:	Récupération des réservations d'un client.
-- (clôturées ou non)
-- Pour clients et employés.
-- =============================================
CREATE PROCEDURE [SchCommon].[GetReservationByCstmr]
	
	@customer_Id	INT,
	@isClosed		BIT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT *   FROM [SchCommon].[vReservation] 
	WHERE Customer_Id =	@customer_Id AND IsClosed = @isClosed;
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetVehicleById]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Description:	Récupération d'un véhicule (avec détails) d'après son ID.
-- Pour clients et employés.
-- =============================================
CREATE PROCEDURE [SchCommon].[GetVehicleById]
	
	@id		INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT DISTINCT * FROM [SchCommon].[vVehicle] WHERE Id = @id;
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetVehiclesByFilter]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--https://www.sqlservercentral.com/Forums/Topic616897-338-1.aspx ( résol. formatage ''' )
-- =============================================
-- Description:	Récupération d'un véhicule de chaque type selon des critères facultatifs.
-- les dates, qui filtrent selon la disponibilité du véhicule si entrées, 
-- sont également optionnelles à ce niveau afin de pouvoir réutiliser la SP pour la page Fleet.
-- Pour clients et employés.
-- =============================================
CREATE PROCEDURE [SchCommon].[GetVehiclesByFilter]
	@startDate	date = null, 
	@endtDate	date = null,
	@officeName	varchar(50) = null,
	@makeName	varchar(50) = null,
	@fuelName	varchar(50) = null,
	@doorsCount	tinyint = 0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @sqlString nvarchar(MAX)
	DECLARE @sqlStringType nvarchar(1000) =''
	DECLARE @sqlStringDate nvarchar(1000) 
	DECLARE @isFirst int = 1
	
	
	--  ! Test de condition ne marche pas, utilise la vesion finissant par "WHERE" lorsque params entrés Nulls.
	-- Début du string de la requête si : 
	IF (@officeName is null AND @makeName is null AND @fuelName is null AND @doorsCount = 0) 
	--	-- Il y a uniquement les dates de renseignées ou rien.
		BEGIN
		SET @sqlString = 'SELECT DISTINCT [Office_Name],[DailyPrice],[VehicleType_Id],[Make_name],[Model_Name],[Fuel_Name],[CC_Name],[Doors_Count] FROM [SchCommon].vVehicle '
		END
	ELSE
		-- Il y a au moins un critère et éventuelleement les dates de renseignées.
		BEGIN
		SET @sqlString = 'SELECT DISTINCT [Office_Name],[DailyPrice],[VehicleType_Id],[Make_name],[Model_Name],[Fuel_Name],[CC_Name],[Doors_Count] FROM [SchCommon].vVehicle WHERE ' 
		END

	---- Compose le string des critères de selection du type de véhicule.
	IF	
	@officeName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType  + ' Office_Name = ''' +  @officeName + ''' '
		SET @isFirst = 0
		END
	IF	@makeName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType + '[Make_name] = ''' +  @makeName + ''' '
		SET @isFirst = 0
		END
	IF	@fuelName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType + '[Fuel_Name] = ''' +  @fuelName + ''' '
		SET @isFirst = 0
		END
	IF	@doorsCount != 0
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType + '[Doors_Count] = ' + cast(@doorsCount as nvarchar) 
		SET @isFirst = 0
		END

	--	--Sélectionne les réservations qui recouvrent les dates qui nous intéressent et qui n'ont pas été annulées / clôturées.
	IF (@startDate <> null AND @endtDate <> null) 
		BEGIN
		SET @sqlStringDate = ' WHERE Id IN (SELECT Vehicle_Id FROM [SchCommon].[vReservation]
															WHERE (StartDate >= @startDate AND StartDate <= @endtDate)
																	OR (EndDate >= @startDate AND EndDate <= @endtDate)
															AND IsClosed = 0)'
		END

		-- String final.
		IF @sqlStringType is not NULL
			BEGIN
			SET @sqlString = @sqlString + @sqlStringType 
			END

		IF @sqlStringDate is not NULL
			BEGIN
			SET @sqlString =  @sqlString + ' AND ' + @sqlStringDate 
			END

	EXEC SP_EXECUTESQL @sqlString 	  

END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetVehiclesOffer]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--https://www.sqlservercentral.com/Forums/Topic616897-338-1.aspx ( résol. formatage ''' )
-- =============================================
-- Description:	Récupération d'un véhicule de chaque type selon des critères facultatifs.
-- les dates, qui filtrent selon la disponibilité du véhicule si entrées, 
-- sont également optionnelles à ce niveau afin de pouvoir réutiliser la SP pour la page Fleet.
-- Pour clients et employés.
-- =============================================
CREATE PROCEDURE [SchCommon].[GetVehiclesOffer]
	@startDate	date = null, 
	@endtDate	date = null,
	@officeName	varchar(50) = null,
	@makeName	varchar(50) = null,
	@fuelName	varchar(50) = null,
	@doorsCount	tinyint = 0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

	DECLARE @sqlString nvarchar(MAX)
	DECLARE @sqlStringType nvarchar(1000) =''
	DECLARE @sqlStringDate nvarchar(1000) 
	DECLARE @isFirst int = 1
	
	
	--  ! Test de condition ne marche pas, utilise la vesion finissant par "WHERE" lorsque params entrés Nulls.
	-- Début du string de la requête si : 
	IF (@officeName is null AND @makeName is null AND @fuelName is null AND @doorsCount = 0) 
	--	-- Il y a uniquement les dates de renseignées ou rien.
		BEGIN
		SET @sqlString = 'SELECT COUNT([Id]) AS vCount,[Office_Name],[DailyPrice],[VehicleType_Id],[Make_name],[Model_Name],[Fuel_Name],[CC_Name],[Doors_Count] FROM [SchCommon].vVehicle '
		END
	ELSE
		-- Il y a au moins un critère et éventuelleement les dates de renseignées.
		BEGIN
		SET @sqlString = 'SELECT COUNT([Id]),[Office_Name],[DailyPrice],[VehicleType_Id],[Make_name],[Model_Name],[Fuel_Name],[CC_Name],[Doors_Count] FROM [SchCommon].vVehicle WHERE ' 
		END

	---- Compose le string des critères de selection du type de véhicule.
	IF	
	@officeName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType  + ' Office_Name = ''' +  @officeName + ''' '
		SET @isFirst = 0
		END
	IF	@makeName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType + '[Make_name] = ''' +  @makeName + ''' '
		SET @isFirst = 0
		END
	IF	@fuelName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType + '[Fuel_Name] = ''' +  @fuelName + ''' '
		SET @isFirst = 0
		END
	IF	@doorsCount != 0
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType + '[Doors_Count] = ' + cast(@doorsCount as nvarchar) 
		SET @isFirst = 0
		END

	--	--Sélectionne les réservations qui recouvrent les dates qui nous intéressent et qui n'ont pas été annulées / clôturées.
	IF (@startDate <> null AND @endtDate <> null) 
		BEGIN
		SET @sqlStringDate = ' WHERE Id IN (SELECT Vehicle_Id FROM [SchCommon].[vReservation]
															WHERE (StartDate >= @startDate AND StartDate <= @endtDate)
																	OR (EndDate >= @startDate AND EndDate <= @endtDate)
															AND IsClosed = 0)'
		END

		-- String final.
		IF @sqlStringType is not NULL
			BEGIN
			SET @sqlString = @sqlString + @sqlStringType 
			END

		IF @sqlStringDate is not NULL
			BEGIN
			SET @sqlString =  @sqlString + ' AND ' + @sqlStringDate 
			END

		SET @sqlString = @sqlString + ' GROUP BY [Office_Name],[DailyPrice],[VehicleType_Id],[Make_name],[Model_Name],[Fuel_Name],[CC_Name],[Doors_Count]'

	EXEC SP_EXECUTESQL @sqlString 	  

END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetVehiclesOffer2]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--https://www.sqlservercentral.com/Forums/Topic616897-338-1.aspx ( résol. formatage ''' )
-- =============================================
-- Description:	Récupération d'un véhicule de chaque type selon des critères facultatifs.
-- les dates, qui filtrent selon la disponibilité du véhicule si entrées, 
-- sont également optionnelles à ce niveau afin de pouvoir réutiliser la SP pour la page Fleet.
-- Pour clients et employés.
-- =============================================
CREATE PROCEDURE [SchCommon].[GetVehiclesOffer2]
	@startDate	date = null, 
	@endtDate	date = null,
	@officeName	varchar(50) = null,
	@makeName	varchar(50) = null,
	@fuelName	varchar(50) = null,
	@doorsCount	tinyint = 0

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

	DECLARE @sqlString nvarchar(MAX)
	DECLARE @sqlStringType nvarchar(1000) =''
	DECLARE @sqlStringDate nvarchar(1000) 
	DECLARE @isFirst int = 1
	
	
	--  ! Test de condition ne marche pas, utilise la vesion finissant par "WHERE" lorsque params entrés Nulls.
	-- Début du string de la requête si : 
	IF (@officeName is null AND @makeName is null AND @fuelName is null AND @doorsCount = 0) 
	--	-- Il y a uniquement les dates de renseignées ou rien.
		BEGIN
		
		SET @sqlString = 'SELECT DISTINCT [Office_Name],[DailyPrice],[VehicleType_Id],[Make_name],[Model_Name],[Fuel_Name],[CC_Name],[Doors_Count] FROM [SchCommon].vVehicle '
		END
	ELSE
		-- Il y a au moins un critère et éventuelleement les dates de renseignées.
		BEGIN
		SET @sqlString = 'SELECT DISTINCT [Office_Name],[DailyPrice],[VehicleType_Id],[Make_name],[Model_Name],[Fuel_Name],[CC_Name],[Doors_Count] FROM [SchCommon].vVehicle WHERE ' 
		END

	---- Compose le string des critères de selection du type de véhicule.
	IF	
	@officeName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType  + ' Office_Name = ''' +  @officeName + ''' '
		SET @isFirst = 0
		END
	IF	@makeName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType + '[Make_name] = ''' +  @makeName + ''' '
		SET @isFirst = 0
		END
	IF	@fuelName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType + '[Fuel_Name] = ''' +  @fuelName + ''' '
		SET @isFirst = 0
		END
	IF	@doorsCount != 0
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType + '[Doors_Count] = ' + cast(@doorsCount as nvarchar) 
		SET @isFirst = 0
		END

	--	--Sélectionne les réservations qui recouvrent les dates qui nous intéressent et qui n'ont pas été annulées / clôturées.
	IF (@startDate <> null AND @endtDate <> null) 
		BEGIN
		SET @sqlStringDate = ' WHERE Id IN (SELECT Vehicle_Id FROM [SchCommon].[vReservation]
															WHERE (StartDate >= @startDate AND StartDate <= @endtDate)
																	OR (EndDate >= @startDate AND EndDate <= @endtDate)
															AND IsClosed = 0)'
		END

		-- String final.
		IF @sqlStringType is not NULL
			BEGIN
			SET @sqlString = @sqlString + @sqlStringType 
			END

		IF @sqlStringDate is not NULL
			BEGIN
			SET @sqlString =  @sqlString + ' AND ' + @sqlStringDate 
			END

		SET @sqlString = @sqlString + ' GROUP BY [Office_Name],[DailyPrice],[VehicleType_Id],[Make_name],[Model_Name],[Fuel_Name],[CC_Name],[Doors_Count]'

	EXEC SP_EXECUTESQL @sqlString 	  

END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetVehicleTypeById]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Description:	Récupération d'un type de véhicule d'après son ID.
-- Pour clients et employés.
-- =============================================
Create PROCEDURE [SchCommon].[GetVehicleTypeById]
	
	@id		INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT DISTINCT * FROM [SchCommon].[vVehicle] WHERE TypeId = @id;
END 
GO
/****** Object:  StoredProcedure [SchCommon].[UpdateCustomer]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:
-- Create date: 
-- Description:	Modification des données d'un client.
-- =============================================
CREATE PROCEDURE [SchCommon].[UpdateCustomer]
	
	--@userName	nvarchar(256) OUTPUT,
	@id			int,
	@name		varchar(50),
	@surName	varchar(50),
	@birthDate	date,
	@email	varchar(50),
	@phone	varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	UPDATE  [SchCommon].[vCustomer]
	 SET [FirstName] = @name,
	 [LastName] = @surName,
	  [Birthday] =  @birthDate,
	  [Email] = @email,
	  [PhoneNumber] = @phone,
	  [UserName] = @name + ' ' + @surName
	 WHERE [Id] = @id;
	 --SET @userName = [UserName];
END 
GO
/****** Object:  StoredProcedure [SchCustomer].[AddReservation]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Création d'une réservation, non clôturée par défaut.
-- Pour client.
-- date de réservation ajoutée par SGBD.
-- =============================================
CREATE PROCEDURE [SchCustomer].[AddReservation]
@new_ID			int	OUTPUT,		
@Vehicle_Id		int,
@Customer_Id	int,
@StartDate		date,
@EndDate		date,
@ToPay			decimal(9,2)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	INSERT INTO SchCustomer.vReservation([Vehicle_Id],[Customer_Id],[StartDate],[EndDate],[ToPay])
			VALUES (@Vehicle_Id,@Customer_Id,@StartDate,@EndDate,@ToPay)
			SET @new_ID = SCOPE_IDENTITY() --Affecte l'id généré.
END 
GO
/****** Object:  StoredProcedure [SchCustomer].[GetReservationById]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération d'une réservation d'après son ID.
-- Pour clients.
-- =============================================
Create PROCEDURE [SchCustomer].[GetReservationById]
	
	@id		INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT * FROM [SchCustomer].vReservation
END 
GO
/****** Object:  StoredProcedure [SchEmployee].[AddReservation]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Création d'une réservation, non clôturée par défaut.
-- Pour employés (ajout de son ID).
-- date de réservation ajoutée par SGBD.
-- =============================================
CREATE PROCEDURE [SchEmployee].[AddReservation]
@new_ID			int	OUTPUT,		
@Vehicle_Id		int,
@Customer_Id	int,
@StartDate		date,
@EndDate		date,
@ToPay			decimal(9,2),
@Paid			decimal(9,2),
@Employee_Id	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	INSERT INTO SchEmployee.vReservation([Vehicle_Id],[Customer_Id],[StartDate],[EndDate],[ToPay],[Paid],[Employee_Id],[IsClosed])
			VALUES (@Vehicle_Id,@Customer_Id,@StartDate,@EndDate,@ToPay,@Paid,@Employee_Id,0)
	SET @new_ID = SCOPE_IDENTITY() --Affecte l'id généré.
END 
GO
/****** Object:  StoredProcedure [SchEmployee].[AddVehicle]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Description:	Ajout d'un véhicule à la flotte d'une agence
-- Pour employés (ajout de son ID).
-- =============================================
CREATE PROCEDURE [SchEmployee].[AddVehicle]

@new_ID			int	OUTPUT,
@vehicleType_Id	int,
@basetarif_Id	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	INSERT INTO SchEmployee.vVehicle(VehicleType_Id,BaseTarif_Id)
			VALUES (@vehicleType_Id,@basetarif_Id)
	SET @new_ID = SCOPE_IDENTITY() --Affecte l'id généré.
END 
GO
/****** Object:  StoredProcedure [SchEmployee].[GetEmployeeById]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	Récupération des nom et prénom et l'agence d'un employé par son ID.
-- =============================================
CREATE PROCEDURE [SchEmployee].[GetEmployeeById]
	
	@Id  INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT [Name],[Surname],Office_Name FROM [SchEmployee].vEmployee 
	WHERE Id=@Id
END 
GO
/****** Object:  StoredProcedure [SchEmployee].[GetReservationById]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération d'une réservation d'après son ID.
-- Pour employés.
-- =============================================
Create PROCEDURE [SchEmployee].[GetReservationById]
	
	@id		INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT * FROM SchEmployee.vReservation
END 
GO
/****** Object:  StoredProcedure [SchEmployee].[UpdateReservation]    Script Date: 25-08-18 08:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Description:	Met à jour / Clôture une réservation.
-- Pour employés
-- =============================================
CREATE PROCEDURE [SchEmployee].[UpdateReservation]
@id				int,		
@Vehicle_Id		int,
@Customer_Id	int,
@StartDate		date,
@EndDate		date,
@ToPay			decimal(9,2),
@Paid			decimal(9,2),
@isClosed		bit

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	UPDATE SchEmployee.vReservation
		SET [Vehicle_Id]=@Vehicle_Id,
			[Customer_Id]=@Customer_Id,
			[StartDate]=@StartDate,
			[EndDate]=@EndDate,
			[ToPay]=@ToPay,
			[Paid]=@Paid,
			[IsClosed]=@isClosed
		WHERE Id = @id;
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AspNetUsers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 262
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "Customer"
            Begin Extent = 
               Top = 164
               Left = 291
               Bottom = 243
               Right = 461
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vCustomer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vCustomer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Picture"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vPicture'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vPicture'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Promo_VehicleType"
            Begin Extent = 
               Top = 25
               Left = 36
               Bottom = 121
               Right = 231
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PromoTarget"
            Begin Extent = 
               Top = 8
               Left = 562
               Bottom = 138
               Right = 736
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PromotionModel"
            Begin Extent = 
               Top = 25
               Left = 308
               Bottom = 155
               Right = 478
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vPromo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vPromo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[43] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Reservation"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2025
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vReservation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vReservation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Vehicle"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VehicleType"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BaseTarif"
            Begin Extent = 
               Top = 3
               Left = 480
               Bottom = 133
               Right = 650
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Model"
            Begin Extent = 
               Top = 149
               Left = 447
               Bottom = 262
               Right = 617
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vVehicle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vVehicle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "VehicleType"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Model"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 119
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vVehicleType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vVehicleType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Person"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Employee"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'SchEmployee', @level1type=N'VIEW',@level1name=N'vEmployee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchEmployee', @level1type=N'VIEW',@level1name=N'vEmployee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Reservation"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'SchEmployee', @level1type=N'VIEW',@level1name=N'vReservation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchEmployee', @level1type=N'VIEW',@level1name=N'vReservation'
GO
USE [master]
GO
ALTER DATABASE [AirCar] SET  READ_WRITE 
GO
