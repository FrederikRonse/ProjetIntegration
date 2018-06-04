USE [master]
GO
/****** Object:  Database [AirCar]    Script Date: 04-06-18 04:39:20 ******/
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
/****** Object:  User [AcEmployee]    Script Date: 04-06-18 04:39:20 ******/
CREATE USER [AcEmployee] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[SchEmployee]
GO
/****** Object:  User [AcCustomer]    Script Date: 04-06-18 04:39:20 ******/
CREATE USER [AcCustomer] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[SchCustomer]
GO
/****** Object:  DatabaseRole [Employee]    Script Date: 04-06-18 04:39:20 ******/
CREATE ROLE [Employee]
GO
/****** Object:  DatabaseRole [Customer]    Script Date: 04-06-18 04:39:20 ******/
CREATE ROLE [Customer]
GO
ALTER ROLE [Employee] ADD MEMBER [AcEmployee]
GO
ALTER ROLE [Customer] ADD MEMBER [AcCustomer]
GO
/****** Object:  Schema [SchCommon]    Script Date: 04-06-18 04:39:20 ******/
CREATE SCHEMA [SchCommon]
GO
/****** Object:  Schema [SchCustomer]    Script Date: 04-06-18 04:39:20 ******/
CREATE SCHEMA [SchCustomer]
GO
/****** Object:  Schema [SchEmployee]    Script Date: 04-06-18 04:39:20 ******/
CREATE SCHEMA [SchEmployee]
GO
/****** Object:  Table [dbo].[Reservation]    Script Date: 04-06-18 04:39:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Vehicle_Id] [int] NOT NULL,
	[Customer_Id] [int] NOT NULL,
	[ReservationDate] [datetime] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[PickupDate] [date] NULL,
	[ReturnDate] [date] NULL,
	[ToPay] [decimal](9, 2) NULL,
	[Paid] [decimal](9, 2) NULL,
	[Employee_Id] [int] NULL,
	[IsClosed] [bit] NULL,
 CONSTRAINT [PK_Reservation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchEmployee].[vReservation]    Script Date: 04-06-18 04:39:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchEmployee].[vReservation]
AS
SELECT        Id, Vehicle_Id, Customer_Id, ReservationDate, StartDate, EndDate, ToPay, PickupDate, ReturnDate, Paid, Employee_Id, IsClosed
FROM            dbo.Reservation
GO
/****** Object:  Table [dbo].[VehicleType]    Script Date: 04-06-18 04:39:20 ******/
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
/****** Object:  Table [dbo].[Vehicle]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  Table [dbo].[BaseTarif]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  Table [dbo].[Model]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  View [SchCommon].[vVehicle]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCommon].[vVehicle]
AS
SELECT        dbo.Vehicle.Id, dbo.Vehicle.VehicleType_Id, dbo.Vehicle.BaseTarif_Id, dbo.BaseTarif.DailyPrice, dbo.BaseTarif.Office_name, dbo.BaseTarif.Name AS TarifName, dbo.Model.Make_name, dbo.Model.Name AS Model_Name, 
                         dbo.VehicleType.Fuel_Name, dbo.VehicleType.CC_Name, dbo.VehicleType.Doors_Count
FROM            dbo.Vehicle INNER JOIN
                         dbo.BaseTarif ON dbo.Vehicle.BaseTarif_Id = dbo.BaseTarif.Id INNER JOIN
                         dbo.VehicleType ON dbo.Vehicle.VehicleType_Id = dbo.VehicleType.Id INNER JOIN
                         dbo.Model ON dbo.VehicleType.Model_Id = dbo.Model.Id
GO
/****** Object:  Table [dbo].[Fuel]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  View [SchCommon].[vFuel]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vFuel]
AS
SELECT        Name
FROM            dbo.Fuel
GO
/****** Object:  View [SchCustomer].[vReservation]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCustomer].[vReservation]
AS
SELECT        Id, Vehicle_Id, Customer_Id, ReservationDate, StartDate, EndDate, ToPay, IsClosed, PickupDate, ReturnDate
FROM            dbo.Reservation
GO
/****** Object:  Table [dbo].[Make]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  View [SchCommon].[vMake]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vMake]
AS
SELECT        Name
FROM            dbo.Make
GO
/****** Object:  View [SchCommon].[vReservation]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCommon].[vReservation]
AS
SELECT        Id, Vehicle_Id, Customer_Id, ReservationDate, StartDate, EndDate, ToPay, IsClosed, PickupDate, ReturnDate, Paid, Employee_Id
FROM            dbo.Reservation
GO
/****** Object:  View [SchCommon].[vModel]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  Table [dbo].[PromotionModel]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  View [SchCommon].[vPromo]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCommon].[vPromo]
AS
SELECT        dbo.Promo_VehicleType.PromotionModel_Id, dbo.Promo_VehicleType.VehicleType_Id, dbo.PromotionModel.Office_Name, dbo.PromotionModel.Name, dbo.PromotionModel.StartDate, dbo.PromotionModel.EndDate, 
                         dbo.PromotionModel.PercentReduc, dbo.PromotionModel.FixedReduc
FROM            dbo.PromotionModel INNER JOIN
                         dbo.Promo_VehicleType ON dbo.PromotionModel.Id = dbo.Promo_VehicleType.PromotionModel_Id
GO
/****** Object:  View [SchCommon].[vVehicleType]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  Table [dbo].[Office]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  View [SchCommon].[vOffice]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vOffice]
AS
SELECT        Name
FROM            dbo.Office
GO
/****** Object:  Table [dbo].[CC]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  View [SchCommon].[vCC]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vCC]
AS
SELECT        Name
FROM            dbo.CC
GO
/****** Object:  Table [dbo].[Person]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Pers_Id] [int] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Pers_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCommon].[vCustomer]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vCustomer]
AS
SELECT        dbo.Customer.Pers_Id, dbo.Person.Name, dbo.Person.Surname, dbo.Person.BirthDate, dbo.Person.Email, dbo.Person.Phone
FROM            dbo.Person INNER JOIN
                         dbo.Customer ON dbo.Person.Id = dbo.Customer.Pers_Id
GO
/****** Object:  View [SchEmployee].[vVehicle]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchEmployee].[vVehicle]
AS
SELECT        dbo.Vehicle.Id, dbo.Vehicle.VehicleType_Id, dbo.Vehicle.BaseTarif_Id, dbo.BaseTarif.Office_name, dbo.BaseTarif.Name AS TarifName, dbo.BaseTarif.DailyPrice, dbo.Model.Make_name, dbo.Model.Name AS Model_Name, 
                         dbo.VehicleType.Fuel_Name, dbo.VehicleType.CC_Name, dbo.VehicleType.Doors_Count
FROM            dbo.Vehicle INNER JOIN
                         dbo.BaseTarif ON dbo.Vehicle.BaseTarif_Id = dbo.BaseTarif.Id INNER JOIN
                         dbo.VehicleType ON dbo.Vehicle.VehicleType_Id = dbo.VehicleType.Id INNER JOIN
                         dbo.Model ON dbo.VehicleType.Model_Id = dbo.Model.Id
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Pers_ID] [int] NOT NULL,
	[Office_Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Pers_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchEmployee].[vEmployee]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  Table [dbo].[Picture]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  View [SchCommon].[vPicture]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCommon].[vPicture]
AS
SELECT        dbo.Picture.*
FROM            dbo.Picture
GO
/****** Object:  Table [dbo].[PromoTarget]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  View [SchEmployee].[vPromo]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchEmployee].[vPromo]
AS
SELECT        dbo.Promo_VehicleType.PromotionModel_Id, dbo.Promo_VehicleType.VehicleType_Id, dbo.PromotionModel.Office_Name, dbo.PromotionModel.Name, dbo.PromotionModel.StartDate, dbo.PromotionModel.EndDate, 
                         dbo.PromotionModel.PercentReduc, dbo.PromotionModel.FixedReduc, dbo.PromoTarget.Id, dbo.PromoTarget.Make_Name, dbo.PromoTarget.Model_Name, dbo.PromoTarget.Fuel_Name, dbo.PromoTarget.CC_Name, 
                         dbo.PromoTarget.Doors_Count
FROM            dbo.PromotionModel INNER JOIN
                         dbo.Promo_VehicleType ON dbo.PromotionModel.Id = dbo.Promo_VehicleType.PromotionModel_Id INNER JOIN
                         dbo.PromoTarget ON dbo.PromotionModel.Id = dbo.PromoTarget.PromoModel_Id
GO
/****** Object:  Table [dbo].[Doors]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  View [SchCommon].[vDoors]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vDoors]
AS
SELECT        Count
FROM            dbo.Doors
GO
/****** Object:  Table [dbo].[Promo_Reservation]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promo_Reservation](
	[PromotionModel_Id] [int] NOT NULL,
	[Reservation_Id] [int] NOT NULL,
 CONSTRAINT [PK_Promo_Reservation] PRIMARY KEY CLUSTERED 
(
	[PromotionModel_Id] ASC,
	[Reservation_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[CC] ([Name]) VALUES (N'1.2L')
INSERT [dbo].[CC] ([Name]) VALUES (N'1.4L')
INSERT [dbo].[CC] ([Name]) VALUES (N'1.6L')
INSERT [dbo].[CC] ([Name]) VALUES (N'2L')
INSERT [dbo].[Customer] ([Pers_Id]) VALUES (3)
INSERT [dbo].[Customer] ([Pers_Id]) VALUES (7)
INSERT [dbo].[Doors] ([Count]) VALUES (3)
INSERT [dbo].[Doors] ([Count]) VALUES (5)
INSERT [dbo].[Employee] ([Pers_ID], [Office_Name]) VALUES (8, N'AirCar Belgium')
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
SET IDENTITY_INSERT [dbo].[Person] ON 

INSERT [dbo].[Person] ([Id], [Name], [Surname], [BirthDate], [Email], [Phone]) VALUES (3, N'NomClient1', N'prénomClient1', CAST(N'1990-05-15' AS Date), N'emailclient1@gmail.com', N'0498163173')
INSERT [dbo].[Person] ([Id], [Name], [Surname], [BirthDate], [Email], [Phone]) VALUES (7, N'NomClient2', N'PrénomClient2', CAST(N'1953-11-30' AS Date), N'emailClient2@gmail.com', N'0497458976')
INSERT [dbo].[Person] ([Id], [Name], [Surname], [BirthDate], [Email], [Phone]) VALUES (8, N'NomEmployé1', N'PrénomEmployé1', CAST(N'1982-06-01' AS Date), N'emailEmployé1@gmail.com', N'0236481578')
SET IDENTITY_INSERT [dbo].[Person] OFF
SET IDENTITY_INSERT [dbo].[Picture] ON 

INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (3, 1, N'Fiesta', 0, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (4, 2, N'Focus RS', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (5, 3, N'Focus ST', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (6, 4, N'Focus', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (7, 5, N'Galaxy', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (8, 6, N'Ka', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (9, 7, N'Mondeo', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (10, 8, N'Mustang', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (11, 10, N'S-Max', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (12, 11, N'Tourneo Custom', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (13, 12, N'Tourneo', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (14, 13, N'Touran', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (15, 14, N'Golf Sportsvan', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (16, 15, N'Multivan', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (17, 16, N'Polo', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (18, 17, N'Touareg', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (19, 18, N'Golf', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (20, 19, N'Golf Variant', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (21, 20, N'Up', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (22, 21, N'Tiguan', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (23, 22, N'Passat Variant', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (24, 23, N'Passat', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (25, 24, N'Beetle', NULL, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (28, 18, N'Golf_L', 1, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (29, 19, N'Golf Variant_L', 1, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (30, 23, N'Passat_L', 1, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (31, 16, N'Polo_L', 1, NULL)
INSERT [dbo].[Picture] ([Id], [Model_Id], [Label], [IsLarge], [Path]) VALUES (32, 20, N'Up_L', 1, NULL)
SET IDENTITY_INSERT [dbo].[Picture] OFF
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
/****** Object:  Index [IX_EmployeeOffice]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_EmployeeOffice] ON [dbo].[Employee]
(
	[Office_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UN_Name]    Script Date: 04-06-18 04:39:21 ******/
ALTER TABLE [dbo].[Model] ADD  CONSTRAINT [UN_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ModelMake]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_ModelMake] ON [dbo].[Model]
(
	[Make_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Picture]    Script Date: 04-06-18 04:39:21 ******/
ALTER TABLE [dbo].[Picture] ADD  CONSTRAINT [IX_Picture] UNIQUE NONCLUSTERED 
(
	[Model_Id] ASC,
	[Label] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Promo_Reservation]    Script Date: 04-06-18 04:39:21 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Promo_Reservation] ON [dbo].[Promo_Reservation]
(
	[PromotionModel_Id] ASC,
	[Reservation_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PromoTargetCC]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_PromoTargetCC] ON [dbo].[PromoTarget]
(
	[CC_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PromoTargetDoors]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_PromoTargetDoors] ON [dbo].[PromoTarget]
(
	[Doors_Count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PromoTargetFuel]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_PromoTargetFuel] ON [dbo].[PromoTarget]
(
	[Fuel_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PromoTargetMake]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_PromoTargetMake] ON [dbo].[PromoTarget]
(
	[Make_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PromoTargetModel]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_PromoTargetModel] ON [dbo].[PromoTarget]
(
	[Model_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PromoTargetPromo]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_PromoTargetPromo] ON [dbo].[PromoTarget]
(
	[PromoModel_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UN_PromotionModel]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  Index [IX_PromotionModelOffice]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_PromotionModelOffice] ON [dbo].[PromotionModel]
(
	[Office_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ReservationCstmr]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_ReservationCstmr] ON [dbo].[Reservation]
(
	[Customer_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ReservationEmployee]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_ReservationEmployee] ON [dbo].[Reservation]
(
	[Employee_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ReservationVehicle]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_ReservationVehicle] ON [dbo].[Reservation]
(
	[Vehicle_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_VehicleTarif]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_VehicleTarif] ON [dbo].[Vehicle]
(
	[Office_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_VehicleType]    Script Date: 04-06-18 04:39:21 ******/
CREATE NONCLUSTERED INDEX [IX_VehicleType] ON [dbo].[Vehicle]
(
	[VehicleType_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_VehicleType_Unique]    Script Date: 04-06-18 04:39:21 ******/
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
ALTER TABLE [dbo].[BaseTarif]  WITH CHECK ADD  CONSTRAINT [FK_BaseTarif_Office] FOREIGN KEY([Office_name])
REFERENCES [dbo].[Office] ([Name])
GO
ALTER TABLE [dbo].[BaseTarif] CHECK CONSTRAINT [FK_BaseTarif_Office]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Person] FOREIGN KEY([Pers_Id])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Person]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Office] FOREIGN KEY([Office_Name])
REFERENCES [dbo].[Office] ([Name])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Office]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Person] FOREIGN KEY([Pers_ID])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Person]
GO
ALTER TABLE [dbo].[Model]  WITH CHECK ADD  CONSTRAINT [FK_Model_Make] FOREIGN KEY([Make_name])
REFERENCES [dbo].[Make] ([Name])
GO
ALTER TABLE [dbo].[Model] CHECK CONSTRAINT [FK_Model_Make]
GO
ALTER TABLE [dbo].[Picture]  WITH CHECK ADD  CONSTRAINT [FK_Picture_Model] FOREIGN KEY([Model_Id])
REFERENCES [dbo].[Model] ([Id])
GO
ALTER TABLE [dbo].[Picture] CHECK CONSTRAINT [FK_Picture_Model]
GO
ALTER TABLE [dbo].[Promo_Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Promo_Reservation_PromotionModel] FOREIGN KEY([PromotionModel_Id])
REFERENCES [dbo].[PromotionModel] ([Id])
GO
ALTER TABLE [dbo].[Promo_Reservation] CHECK CONSTRAINT [FK_Promo_Reservation_PromotionModel]
GO
ALTER TABLE [dbo].[Promo_Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Promo_Reservation_Reservation] FOREIGN KEY([Reservation_Id])
REFERENCES [dbo].[Reservation] ([Id])
GO
ALTER TABLE [dbo].[Promo_Reservation] CHECK CONSTRAINT [FK_Promo_Reservation_Reservation]
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
REFERENCES [dbo].[Customer] ([Pers_Id])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_Customer]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Employee] FOREIGN KEY([Employee_Id])
REFERENCES [dbo].[Employee] ([Pers_ID])
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
/****** Object:  StoredProcedure [SchCommon].[AddCustomer]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetCCList]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetCustomerDetails]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetDoorsList]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetFuelList]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetMakeList]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetModelsByMake]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetOfficeList]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetPictures]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetPromoByVehicle]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des promos liées à un type véhicule.
-- pour clients et employés.
-- =============================================
CREATE PROCEDURE [SchCommon].[GetPromoByVehicle]
	
	@vehicleTypeId	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT * FROM [SchCommon].[vPromo]
	WHERE VehicleType_Id = @vehicleTypeId;
	 
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetPromoModels]    Script Date: 04-06-18 04:39:21 ******/
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
 
	SELECT DISTINCT  PromotionModel_Id, VehicleType_Id,[Name],Office_Name,[StartDate],[EndDate],[PercentReduc],[FixedReduc] FROM [SchCommon].[vPromo]
	WHERE Office_Name = @officeName;
	 
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetReservationByCstmr]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetVehicleById]    Script Date: 04-06-18 04:39:21 ******/
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
 
	SELECT * FROM [SchCommon].[vVehicle] WHERE Id = @id;
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetVehiclesByFilter]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


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
	@doorsCount	tinyint = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @sqlString nvarchar(MAX)
	DECLARE @sqlStringType nvarchar(1000)
	DECLARE @sqlStringDate nvarchar(1000)
	DECLARE @isFirst int = 1
	
	
	
	-- Début du string de la requête si : 
	IF (@officeName = null AND @makeName = null AND @fuelName = null AND @doorsCount = null) 
		-- Il y a uniquement les dates de renseignées ou rien.
		BEGIN
		SET @sqlString = 'SELECT DISTINCT * FROM [SchCommon].vVehicle '
		END
	ELSE
		-- Il y a au moins un critère et éventuelleement les dates de renseignées.
		BEGIN
		SET @sqlString = 'SELECT DISTINCT * FROM [SchCommon].vVehicle WHERE '
		END

	-- Compose le string des critères de selection du type de véhicule.
	IF	
	@officeName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType + '[Office_name] = @officeName'
		SET @isFirst = 1
		END
	IF	@makeName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType + '[Make_name] = @makeName'
		SET @isFirst = 1
		END
	IF	@fuelName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType + '[Fuel_Name] = @fuelName'
		SET @isFirst = 1
		END
	IF	@doorsCount IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlStringType = @sqlStringType + ' AND '
		SET @sqlStringType = @sqlStringType + '[Doors_Count] = @doorsCount'
		SET @isFirst = 1
		END

		--Sélectionne les réservations qui recouvrent les dates qui nous intéressent et qui n'ont pas été annulées / clôturées.
	IF (@startDate <> null AND @endtDate <> null) 
		BEGIN
		SET @sqlStringDate = @sqlStringDate + ' WHERE Id IN (SELECT Vehicle_Id FROM [SchCommon].[vReservation]
															WHERE (StartDate >= @startDate AND StartDate <= @endtDate)
																	OR (EndDate >= @startDate AND EndDate <= @endtDate)
															AND IsClosed = 0)'
		END

		-- String final.
	IF (@sqlStringType <> NULL)
			SET @sqlString = @sqlString + @sqlStringType + ' AND '
			ELSE
			SET @sqlString = @sqlString + @sqlStringDate

	EXEC SP_EXECUTESQL @sqlString 	  

END 
GO
/****** Object:  StoredProcedure [SchCommon].[UpdateCustomer]    Script Date: 04-06-18 04:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:
-- Create date: 
-- Description:	Modification des données d'un client.
-- =============================================
Create PROCEDURE [SchCommon].[UpdateCustomer]
	
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
	 SET [Name] = @name,
	  Surname = @surName,
	  BirthDate =  @birthDate,
	  Email = @email,
	  Phone = @phone
	 WHERE Pers_Id = @id;
END 
GO
/****** Object:  StoredProcedure [SchCustomer].[AddReservation]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchCustomer].[GetReservationById]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchEmployee].[AddReservation]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchEmployee].[AddVehicle]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchEmployee].[GetEmployeeById]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchEmployee].[GetReservationById]    Script Date: 04-06-18 04:39:21 ******/
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
/****** Object:  StoredProcedure [SchEmployee].[UpdateReservation]    Script Date: 04-06-18 04:39:21 ******/
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
         Begin Table = "Picture"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
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
' , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vPicture'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchCommon', @level1type=N'VIEW',@level1name=N'vPicture'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[35] 2[19] 3) )"
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
         Begin Table = "PromotionModel"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Promo_VehicleType"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 441
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
         Configuration = "(H (1[28] 4[44] 2[14] 3) )"
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
         Top = -96
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
         Begin Table = "BaseTarif"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VehicleType"
            Begin Extent = 
               Top = 120
               Left = 38
               Bottom = 250
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Model"
            Begin Extent = 
               Top = 138
               Left = 246
               Bottom = 251
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
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "BaseTarif"
            Begin Extent = 
               Top = 10
               Left = 285
               Bottom = 140
               Right = 455
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Model"
            Begin Extent = 
               Top = 164
               Left = 288
               Bottom = 277
               Right = 458
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VehicleType"
            Begin Extent = 
               Top = 153
               Left = 55
               Bottom = 283
               Right = 225
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
' , @level0type=N'SCHEMA',@level0name=N'SchEmployee', @level1type=N'VIEW',@level1name=N'vVehicle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchEmployee', @level1type=N'VIEW',@level1name=N'vVehicle'
GO
USE [master]
GO
ALTER DATABASE [AirCar] SET  READ_WRITE 
GO
