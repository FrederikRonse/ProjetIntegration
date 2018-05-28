USE [master]
GO
/****** Object:  Database [AirCar]    Script Date: 29-05-18 00:50:35 ******/
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
/****** Object:  User [AcEmployee]    Script Date: 29-05-18 00:50:35 ******/
CREATE USER [AcEmployee] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[SchEmployee]
GO
/****** Object:  User [AcCustomer]    Script Date: 29-05-18 00:50:35 ******/
CREATE USER [AcCustomer] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[SchCustomer]
GO
/****** Object:  DatabaseRole [Employee]    Script Date: 29-05-18 00:50:35 ******/
CREATE ROLE [Employee]
GO
/****** Object:  DatabaseRole [Customer]    Script Date: 29-05-18 00:50:35 ******/
CREATE ROLE [Customer]
GO
ALTER ROLE [Employee] ADD MEMBER [AcEmployee]
GO
ALTER ROLE [Customer] ADD MEMBER [AcCustomer]
GO
/****** Object:  Schema [SchCommon]    Script Date: 29-05-18 00:50:35 ******/
CREATE SCHEMA [SchCommon]
GO
/****** Object:  Schema [SchCustomer]    Script Date: 29-05-18 00:50:35 ******/
CREATE SCHEMA [SchCustomer]
GO
/****** Object:  Schema [SchEmployee]    Script Date: 29-05-18 00:50:35 ******/
CREATE SCHEMA [SchEmployee]
GO
/****** Object:  Table [dbo].[Reservation]    Script Date: 29-05-18 00:50:35 ******/
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
/****** Object:  View [SchEmployee].[vReservation]    Script Date: 29-05-18 00:50:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchEmployee].[vReservation]
AS
SELECT        Id, Vehicle_Id, Customer_Id, ReservationDate, StartDate, EndDate, ToPay, PickupDate, ReturnDate, Paid, Employee_Id, IsClosed
FROM            dbo.Reservation
GO
/****** Object:  Table [dbo].[PromotionModel]    Script Date: 29-05-18 00:50:35 ******/
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
/****** Object:  Table [dbo].[Promo_Vehicle]    Script Date: 29-05-18 00:50:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promo_Vehicle](
	[PromotionModel_Id] [int] NOT NULL,
	[Vehicle_Id] [int] NOT NULL,
 CONSTRAINT [PK_Promo_Vehicle] PRIMARY KEY CLUSTERED 
(
	[PromotionModel_Id] ASC,
	[Vehicle_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCustomer].[vPromo]    Script Date: 29-05-18 00:50:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCustomer].[vPromo]
AS
SELECT        dbo.PromotionModel.Id, dbo.PromotionModel.Office_Name, dbo.PromotionModel.Name, dbo.PromotionModel.StartDate, dbo.PromotionModel.EndDate, dbo.PromotionModel.PercentReduc, dbo.PromotionModel.FixedReduc, 
                         dbo.Promo_Vehicle.Vehicle_Id
FROM            dbo.PromotionModel INNER JOIN
                         dbo.Promo_Vehicle ON dbo.PromotionModel.Id = dbo.Promo_Vehicle.PromotionModel_Id
GO
/****** Object:  Table [dbo].[Fuel]    Script Date: 29-05-18 00:50:35 ******/
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
/****** Object:  View [SchCommon].[vFuel]    Script Date: 29-05-18 00:50:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vFuel]
AS
SELECT        Name
FROM            dbo.Fuel
GO
/****** Object:  View [SchCustomer].[vReservation]    Script Date: 29-05-18 00:50:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchCustomer].[vReservation]
AS
SELECT        Id, Vehicle_Id, Customer_Id, ReservationDate, StartDate, EndDate, ToPay, IsClosed, PickupDate, ReturnDate
FROM            dbo.Reservation
GO
/****** Object:  Table [dbo].[Make]    Script Date: 29-05-18 00:50:35 ******/
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
/****** Object:  View [SchCommon].[vMake]    Script Date: 29-05-18 00:50:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vMake]
AS
SELECT        Name
FROM            dbo.Make
GO
/****** Object:  Table [dbo].[Model]    Script Date: 29-05-18 00:50:35 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UN_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCommon].[vModel]    Script Date: 29-05-18 00:50:35 ******/
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
/****** Object:  Table [dbo].[PromoTarget]    Script Date: 29-05-18 00:50:35 ******/
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
/****** Object:  View [SchEmployee].[vPromo]    Script Date: 29-05-18 00:50:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchEmployee].[vPromo]
AS
SELECT        dbo.PromotionModel.Id, dbo.PromotionModel.Office_Name, dbo.PromotionModel.Name, dbo.PromotionModel.StartDate, dbo.PromotionModel.EndDate, dbo.PromotionModel.PercentReduc, dbo.PromotionModel.FixedReduc, 
                         dbo.Promo_Vehicle.Vehicle_Id, dbo.PromoTarget.Id AS TargetId, dbo.PromoTarget.Make_Name, dbo.PromoTarget.Model_Name, dbo.PromoTarget.Fuel_Name, dbo.PromoTarget.CC_Name, dbo.PromoTarget.Doors_Count
FROM            dbo.PromotionModel INNER JOIN
                         dbo.Promo_Vehicle ON dbo.PromotionModel.Id = dbo.Promo_Vehicle.PromotionModel_Id INNER JOIN
                         dbo.PromoTarget ON dbo.PromotionModel.Id = dbo.PromoTarget.PromoModel_Id
GO
/****** Object:  Table [dbo].[Office]    Script Date: 29-05-18 00:50:35 ******/
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
/****** Object:  View [SchCommon].[vOffice]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vOffice]
AS
SELECT        Name
FROM            dbo.Office
GO
/****** Object:  Table [dbo].[CC]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  View [SchCommon].[vCC]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vCC]
AS
SELECT        Name
FROM            dbo.CC
GO
/****** Object:  Table [dbo].[Person]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  Table [dbo].[Customer]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  View [SchCommon].[vCustomer]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  Table [dbo].[Vehicle]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Model_Id] [int] NOT NULL,
	[BaseTarif_Id] [int] NOT NULL,
	[Fuel_Name] [varchar](25) NOT NULL,
	[CC_Name] [varchar](25) NOT NULL,
	[Doors_Count] [tinyint] NOT NULL,
 CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BaseTarif]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaseTarif](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[DailyPrice] [decimal](9, 2) NOT NULL,
	[Office_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_BaseTarif] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [SchCustomer].[vVehicle]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [SchCustomer].[vVehicle]
AS
SELECT        dbo.Vehicle.Id, dbo.Model.Make_name, dbo.Model.Name AS Model_Name, dbo.Vehicle.Fuel_Name, dbo.Vehicle.CC_Name, dbo.Vehicle.Doors_Count, dbo.BaseTarif.DailyPrice, dbo.BaseTarif.Office_name
FROM            dbo.Vehicle INNER JOIN
                         dbo.BaseTarif ON dbo.Vehicle.BaseTarif_Id = dbo.BaseTarif.Id INNER JOIN
                         dbo.Model ON dbo.Vehicle.Model_Id = dbo.Model.Id
GO
/****** Object:  View [SchEmployee].[vVehicle]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [SchEmployee].[vVehicle]
AS
SELECT        dbo.Vehicle.Id, dbo.Model.Make_name, dbo.Model.Name AS Model_Name, dbo.Vehicle.Fuel_Name, dbo.Vehicle.CC_Name, dbo.Vehicle.Doors_Count, dbo.BaseTarif.DailyPrice, dbo.BaseTarif.Office_name, 
                         dbo.Vehicle.BaseTarif_Id, dbo.BaseTarif.Name AS TarifName
FROM            dbo.Vehicle INNER JOIN
                         dbo.BaseTarif ON dbo.Vehicle.BaseTarif_Id = dbo.BaseTarif.Id INNER JOIN
                         dbo.Model ON dbo.Vehicle.Model_Id = dbo.Model.Id
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  View [SchEmployee].[vEmployee]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  Table [dbo].[Doors]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  View [SchCommon].[vDoors]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [SchCommon].[vDoors]
AS
SELECT        Count
FROM            dbo.Doors
GO
/****** Object:  Table [dbo].[Promo_Reservation]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  Index [IX_Promo_Reservation]    Script Date: 29-05-18 00:50:36 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Promo_Reservation] ON [dbo].[Promo_Reservation]
(
	[PromotionModel_Id] ASC,
	[Reservation_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
ALTER TABLE [dbo].[Promo_Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Promo_Vehicle_PromotionModel] FOREIGN KEY([PromotionModel_Id])
REFERENCES [dbo].[PromotionModel] ([Id])
GO
ALTER TABLE [dbo].[Promo_Vehicle] CHECK CONSTRAINT [FK_Promo_Vehicle_PromotionModel]
GO
ALTER TABLE [dbo].[Promo_Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Promo_Vehicle_Vehicle] FOREIGN KEY([Vehicle_Id])
REFERENCES [dbo].[Vehicle] ([Id])
GO
ALTER TABLE [dbo].[Promo_Vehicle] CHECK CONSTRAINT [FK_Promo_Vehicle_Vehicle]
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
ALTER TABLE [dbo].[PromoTarget]  WITH CHECK ADD  CONSTRAINT [FK_PromoTarget_Model] FOREIGN KEY([Make_Name])
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
ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_BaseTarif] FOREIGN KEY([BaseTarif_Id])
REFERENCES [dbo].[BaseTarif] ([Id])
GO
ALTER TABLE [dbo].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_BaseTarif]
GO
ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_CC] FOREIGN KEY([CC_Name])
REFERENCES [dbo].[CC] ([Name])
GO
ALTER TABLE [dbo].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_CC]
GO
ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_Doors] FOREIGN KEY([Doors_Count])
REFERENCES [dbo].[Doors] ([Count])
GO
ALTER TABLE [dbo].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_Doors]
GO
ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_Fuel] FOREIGN KEY([Fuel_Name])
REFERENCES [dbo].[Fuel] ([Name])
GO
ALTER TABLE [dbo].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_Fuel]
GO
ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_Model] FOREIGN KEY([Model_Id])
REFERENCES [dbo].[Model] ([Id])
GO
ALTER TABLE [dbo].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_Model]
GO
/****** Object:  StoredProcedure [SchCommon].[AddCustomer]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:
-- Create date: 
-- Description:	Création d'un client.
-- =============================================
Create PROCEDURE [SchCommon].[AddCustomer]
	
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
END 
GO
/****** Object:  StoredProcedure [SchCommon].[GetCCList]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetCustomerDetails]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetDoorsList]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetFuelList]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetMakeList]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetModelsByMake]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  StoredProcedure [SchCommon].[GetOfficeList]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  StoredProcedure [SchCommon].[UpdateCustomer]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  StoredProcedure [SchCustomer].[AddReservation]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Création d'une réservation, non clôturée par défaut.
-- Pour client.
-- date de réservation ajoutée par SGBD.
-- =============================================
Create PROCEDURE [SchCustomer].[AddReservation]
	
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
END 
GO
/****** Object:  StoredProcedure [SchCustomer].[GetPromoByVehicle]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des promos liées à un véhicule.
-- pour clients.
-- =============================================
Create PROCEDURE [SchCustomer].[GetPromoByVehicle]
	
	@vehicleId	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT * FROM [SchCustomer].[vPromo]
	WHERE Vehicle_Id = @vehicleId;
	 
END 
GO
/****** Object:  StoredProcedure [SchCustomer].[GetPromoModels]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des promos par agences.
-- (les promotions globales sont celles du siège (AirCar Belgium).
-- Pour clients.
-- =============================================
Create PROCEDURE [SchCustomer].[GetPromoModels]
	
	@officeName	varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT DISTINCT  [Id],[Name],[StartDate],[EndDate],[PercentReduc],[FixedReduc] FROM SchCustomer.[vPromo]
	WHERE Office_Name = @officeName;
	 
END 
GO
/****** Object:  StoredProcedure [SchCustomer].[GetReservationByCstmr]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Description:	Récupération des réservations d'un client.
-- (clôturées ou non)
-- Pour clients.
-- =============================================
Create PROCEDURE [SchCustomer].[GetReservationByCstmr]
	
	@customer_Id	INT,
	@isClosed		BIT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT *   FROM [SchCustomer].vReservation
	WHERE Customer_Id =	@customer_Id AND IsClosed = @isClosed;
END 
GO
/****** Object:  StoredProcedure [SchCustomer].[GetReservationById]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  StoredProcedure [SchCustomer].[GetVehicleById]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération d'un véhicule d'après son ID.
-- Pour clients.
-- =============================================
Create PROCEDURE [SchCustomer].[GetVehicleById]
	
	@id		INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT * FROM [SchCustomer].vVehicle
END 
GO
/****** Object:  StoredProcedure [SchCustomer].[GetVehiclesByFilter]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des véhicules selon
-- critères facultatifs
-- Pour clients.
-- =============================================
Create PROCEDURE [SchCustomer].[GetVehiclesByFilter]
	
	@officeName	varchar(50) = null,
	@makeName	varchar(50) = null,
	@fuelName	varchar(50) = null,
	@doorsCount	tinyint = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @sqlString nvarchar(1000)
	DECLARE @isFirst int = 1

	IF (@officeName = null AND @makeName = null AND @fuelName = null AND @doorsCount = null) 
		BEGIN
		SET @sqlString = 'SELECT * FROM [SchCustomer].vVehicle '
		END
	ELSE
		BEGIN
		SET @sqlString = 'SELECT * FROM [SchCustomer].vVehicle WHERE '
		END

	IF	
	@officeName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlString = @sqlString + ' AND '
		SET @sqlString = @sqlString + '[Office_name] = @officeName'
		END
	IF	@makeName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlString = @sqlString + ' AND '
		SET @sqlString = @sqlString + '[Make_name] = @makeName'
		END
	IF	@fuelName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlString = @sqlString + ' AND '
		SET @sqlString = @sqlString + '[Fuel_Name] = @fuelName'
		END
	IF	@doorsCount IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlString = @sqlString + ' AND '
		SET @sqlString = @sqlString + '[Doors_Count] = @doorsCount'
		END

	EXEC SP_EXECUTESQL @sqlString 	  
END 
GO
/****** Object:  StoredProcedure [SchEmployee].[AddReservation]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Création d'une réservation, non clôturée par défaut.
-- Pour employés (ajout de son ID).
-- date de réservation ajoutée par SGBD.
-- =============================================
Create PROCEDURE [SchEmployee].[AddReservation]
	
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
END 
GO
/****** Object:  StoredProcedure [SchEmployee].[GetEmployeeById]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  StoredProcedure [SchEmployee].[GetPromoByVehicle]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des promos liées à un véhicule.
-- pour employés.
-- =============================================
CREATE PROCEDURE [SchEmployee].[GetPromoByVehicle]
	
	@vehicleId	int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT [Id],[Office_Name],[Name],[StartDate],[EndDate],[PercentReduc],[FixedReduc] FROM SchEmployee.[vPromo]
	WHERE Vehicle_Id = @vehicleId;
	 
END 
GO
/****** Object:  StoredProcedure [SchEmployee].[GetPromoModels]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des promos par agences.
-- (les promotions globales sont celles du siège (AirCar Belgium).
-- Pour employés.
-- =============================================
Create PROCEDURE [SchEmployee].[GetPromoModels]
	
	@officeName	varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT DISTINCT  [Id],[Name],[StartDate],[EndDate],[PercentReduc],[FixedReduc] FROM SchEmployee.[vPromo]
	WHERE Office_Name = @officeName;
	 
END 
GO
/****** Object:  StoredProcedure [SchEmployee].[GetReservationByCstmr]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Description:	Récupération des réservations d'un client.
-- (clôturées ou non)
-- Pour Employés.
-- =============================================
Create PROCEDURE [SchEmployee].[GetReservationByCstmr]
	
	@customer_Id	INT,
	@isClosed		BIT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT *   FROM [SchEmployee].vReservation
	WHERE Customer_Id =	@customer_Id AND IsClosed = @isClosed;
END 
GO
/****** Object:  StoredProcedure [SchEmployee].[GetReservationById]    Script Date: 29-05-18 00:50:36 ******/
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
/****** Object:  StoredProcedure [SchEmployee].[GetVehicleById]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération d'un véhicule d'après son ID.
-- Pour employés.
-- =============================================
Create PROCEDURE [SchEmployee].[GetVehicleById]
	
	@id		INT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT * FROM [SchEmployee].vVehicle
END 
GO
/****** Object:  StoredProcedure [SchEmployee].[GetVehiclesByFilter]    Script Date: 29-05-18 00:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Récupération des véhicules selon
-- critères facultatifs
-- Pour Employés.
-- =============================================
Create PROCEDURE [SchEmployee].[GetVehiclesByFilter]
	
	@officeName	varchar(50) = null,
	@makeName	varchar(50) = null,
	@fuelName	varchar(50) = null,
	@doorsCount	tinyint = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @sqlString nvarchar(1000)
	DECLARE @isFirst int = 1

	IF (@officeName = null AND @makeName = null AND @fuelName = null AND @doorsCount = null) 
		BEGIN
		SET @sqlString = 'SELECT * FROM [SchEmployee].vVehicle '
		END
	ELSE
		BEGIN
		SET @sqlString = 'SELECT * FROM [SchEmployee].vVehicle WHERE '
		END

	IF	
	@officeName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlString = @sqlString + ' AND '
		SET @sqlString = @sqlString + '[Office_name] = @officeName'
		END
	IF	@makeName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlString = @sqlString + ' AND '
		SET @sqlString = @sqlString + '[Make_name] = @makeName'
		END
	IF	@fuelName IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlString = @sqlString + ' AND '
		SET @sqlString = @sqlString + '[Fuel_Name] = @fuelName'
		END
	IF	@doorsCount IS NOT NULL
		BEGIN
		IF @isFirst = 0 SET @sqlString = @sqlString + ' AND '
		SET @sqlString = @sqlString + '[Doors_Count] = @doorsCount'
		END

	EXEC SP_EXECUTESQL @sqlString 	  
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
         Begin Table = "PromotionModel"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Promo_Vehicle"
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
' , @level0type=N'SCHEMA',@level0name=N'SchCustomer', @level1type=N'VIEW',@level1name=N'vPromo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchCustomer', @level1type=N'VIEW',@level1name=N'vPromo'
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
            TopColumn = 7
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
' , @level0type=N'SCHEMA',@level0name=N'SchCustomer', @level1type=N'VIEW',@level1name=N'vReservation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchCustomer', @level1type=N'VIEW',@level1name=N'vReservation'
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
         Begin Table = "Promo_Vehicle"
            Begin Extent = 
               Top = 6
               Left = 380
               Bottom = 102
               Right = 575
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PromoTarget"
            Begin Extent = 
               Top = 131
               Left = 240
               Bottom = 261
               Right = 414
            End
            DisplayFlags = 280
            TopColumn = 3
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
' , @level0type=N'SCHEMA',@level0name=N'SchEmployee', @level1type=N'VIEW',@level1name=N'vPromo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchEmployee', @level1type=N'VIEW',@level1name=N'vPromo'
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
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Model"
            Begin Extent = 
               Top = 153
               Left = 260
               Bottom = 266
               Right = 430
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
' , @level0type=N'SCHEMA',@level0name=N'SchEmployee', @level1type=N'VIEW',@level1name=N'vVehicle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'SchEmployee', @level1type=N'VIEW',@level1name=N'vVehicle'
GO
USE [master]
GO
ALTER DATABASE [AirCar] SET  READ_WRITE 
GO
