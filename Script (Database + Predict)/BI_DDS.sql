CREATE DATABASE BI_DDS
GO

USE BI_DDS
GO

--
-- Xoa bang Dim_District neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Dim_District') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Dim_District
GO

--
-- Xoa bang Dim_Location neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Dim_Location') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Dim_Location
GO

--
-- Xoa bang Dim_Vendor neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Dim_Vendor') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Dim_Vendor
GO

--
-- Xoa bang Dim_PaymentType neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Dim_PaymentType') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Dim_PaymentType
GO

--
-- Xoa bang Dim_RateCode neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Dim_RateCode') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Dim_RateCode
GO

--
-- Xoa bang Dim_Year neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Dim_Year') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Dim_Year
GO

--
-- Xoa bang Dim_Quarter neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Dim_Quarter') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Dim_Quarter
GO

--
-- Xoa bang Dim_Month neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Dim_Month') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Dim_Month
GO

--
-- Xoa bang Dim_Day neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Dim_Day') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Dim_Day
GO

--
-- Xoa bang Dim_Hour neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Dim_Hour') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Dim_Hour
GO

--
-- Xoa bang Fact_Taxi_Trips neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Fact_Taxi_Trips') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Fact_Taxi_Trips
GO


--
-- Tao bang Dim_Location:
-- 

CREATE TABLE Dim_Location
(
	ID_Location int IDENTITY(1, 1) NOT NULL,
	LocationID int NOT NULL,
	LocationName varchar(50) NOT NULL,
	ShapeArea float NOT NULL,
	ShapeLeng float NOT NULL,
	DistrictID int NOT NULL,
	NguonDuLieu int NOT NULL,
	CONSTRAINT PK_Dim_Location PRIMARY KEY (ID_Location)
)
GO

--
-- Tao bang Dim_District:
--

CREATE TABLE Dim_District
(
	ID_District int IDENTITY(1, 1) NOT NULL,
	DistrictID int NOT NULL,
	DistrictName varchar(50) NOT NULL, 
	NguonDuLieu int NOT NULL,
	CONSTRAINT PK_Dim_District PRIMARY KEY (ID_District)
)
GO

--
-- Tao bang Dim_Vendor:
-- 

CREATE TABLE Dim_Vendor
(
	ID_Vendor int IDENTITY(1, 1) NOT NULL,
	VendorID int NOT NULL,
	VendorName varchar(50) NULL,
	NguonDuLieu int NOT NULL,
	CONSTRAINT PK_Dim_Vendor PRIMARY KEY (ID_Vendor)
)
GO

--
-- Tao bang Dim_PaymentType:
-- 

CREATE TABLE Dim_PaymentType
(
	ID_PaymentType int IDENTITY(1, 1) NOT NULL,
	PaymentTypeID int NOT NULL,
	PaymentTypeName varchar(50) NOT NULL,
	NguonDuLieu int NOT NULL,
	CONSTRAINT PK_Dim_PaymentType PRIMARY KEY (ID_PaymentType)
)
GO

--
-- Tao bang Dim_RateCode:
-- 

CREATE TABLE Dim_RateCode
(
	ID_RateCode int IDENTITY(1, 1) NOT NULL,
	RateCodeID int NOT NULL,
	RateCodeName varchar(50) NOT NULL,
	NguonDuLieu int NOT NULL,
	CONSTRAINT PK_Dim_RateCode PRIMARY KEY (ID_RateCode)
)
GO


--
-- Tao bang Dim_Year:
-- 

CREATE TABLE Dim_Year
(
	ID_Year int IDENTITY(1, 1) NOT NULL,
	Nam int NOT NULL,
	CONSTRAINT PK_Dim_Year PRIMARY KEY (ID_Year)
)
GO


--
-- Tao bang Dim_Quarter:
-- 

CREATE TABLE Dim_Quarter
(
	ID_Quarter int IDENTITY(1, 1) NOT NULL,
	ID_Year INT NOT NULL,
	Quy int NOT NULL,
	CONSTRAINT PK_Dim_Quarter PRIMARY KEY (ID_Quarter)
)
GO

--
-- Tao bang Dim_Month:
-- 

CREATE TABLE Dim_Month
(
	ID_Month int IDENTITY(1, 1) NOT NULL,
	ID_Quarter int NOT NULL,
	Thang int NOT NULL,
	CONSTRAINT PK_Dim_Month PRIMARY KEY (ID_Month)
)
GO

--
-- Tao bang Dim_Day:
-- 

CREATE TABLE Dim_Day
(
	ID_Day int IDENTITY(1, 1) NOT NULL,
	ID_Month int NOT NULL,
	Ngay int NOT NULL,
	CONSTRAINT PK_Dim_Day PRIMARY KEY (ID_Day)
)
GO

--
-- Tao bang Dim_Hour:
-- 

CREATE TABLE Dim_Hour
(
	ID_Hour int IDENTITY(1, 1) NOT NULL,
	ID_Day int NOT NULL,
	Gio int NOT NULL,
	CONSTRAINT PK_Dim_Hour PRIMARY KEY (ID_Hour)
)
GO

--
-- Tao bang Fact_Taxi_Trips:
--
CREATE TABLE Fact_Taxi_Trips
(
	ID_Taxi_Trips int IDENTITY(1, 1) NOT NULL,
	ID_Address_PickUp int NOT NULL,
	ID_Address_DropOff int NOT NULL,
	ID_Time_PickUp int NOT NULL,
	ID_Time_DropOff int NOT NULL,
	ID_Vendor int NOT NULL,
	ID_PaymentType int NOT NULL,
	ID_RateCode int NOT NULL,
	Count_Trips INT NULL,
	Sum_Tip_Amount float NULL,
	Sum_Trip_Distance float NULL,
	Total_Amount_Trips float NOT NULL,
	CONSTRAINT PK_Fact_Taxi_Trips PRIMARY KEY (ID_Taxi_Trips)
)
GO

-- Tao khoa ngoai bang Fact_Taxi_Trips
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Fact_Taxi_Trips_Dim_Location_PickUp') AND parent_object_id = OBJECT_ID(N'Fact_Taxi_Trips'))
ALTER TABLE Fact_Taxi_Trips 
	WITH CHECK ADD CONSTRAINT FK_Fact_Taxi_Trips_Dim_Location_PickUp
	FOREIGN KEY(ID_Address_PickUp) REFERENCES Dim_Location(ID_Location)
GO
-- Tao khoa ngoai bang Fact_Taxi_Trips
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Fact_Taxi_Trips_Dim_Location_DropOff') AND parent_object_id = OBJECT_ID(N'Fact_Taxi_Trips'))
ALTER TABLE Fact_Taxi_Trips 
	WITH CHECK ADD CONSTRAINT FK_Fact_Taxi_Trips_Dim_Location_DropOff
	FOREIGN KEY(ID_Address_DropOff) REFERENCES Dim_Location(ID_Location)
GO

-- Tao khoa ngoai bang Fact_Taxi_Trips
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Fact_Taxi_Trips_Dim_Hour_PickUp') AND parent_object_id = OBJECT_ID(N'Fact_Taxi_Trips'))
ALTER TABLE Fact_Taxi_Trips 
	WITH CHECK ADD CONSTRAINT FK_Fact_Taxi_Trips_Dim_Hour_PickUp
	FOREIGN KEY(ID_Time_PickUp) REFERENCES Dim_Hour(ID_Hour)
GO
-- Tao khoa ngoai bang Fact_Taxi_Trips
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Fact_Taxi_Trips_Dim_Hour_DropOff') AND parent_object_id = OBJECT_ID(N'Fact_Taxi_Trips'))
ALTER TABLE Fact_Taxi_Trips 
	WITH CHECK ADD CONSTRAINT FK_Fact_Taxi_Trips_Dim_Hour_DropOff
	FOREIGN KEY(ID_Time_DropOff) REFERENCES Dim_Hour(ID_Hour)
GO

-- Tao khoa ngoai bang Fact_Taxi_Trips
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Fact_Taxi_Trips_Dim_Vendor') AND parent_object_id = OBJECT_ID(N'Fact_Taxi_Trips'))
ALTER TABLE Fact_Taxi_Trips 
	WITH CHECK ADD CONSTRAINT FK_Fact_Taxi_Trips_Dim_Vendor
	FOREIGN KEY(ID_Vendor) REFERENCES Dim_Vendor(ID_Vendor)
GO
-- Tao khoa ngoai bang Fact_Taxi_Trips
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Fact_Taxi_Trips_Dim_PaymentType') AND parent_object_id = OBJECT_ID(N'Fact_Taxi_Trips'))
ALTER TABLE Fact_Taxi_Trips 
	WITH CHECK ADD CONSTRAINT FK_Fact_Taxi_Trips_Dim_PaymentType
	FOREIGN KEY(ID_PaymentType) REFERENCES Dim_PaymentType(ID_PaymentType)
GO
-- Tao khoa ngoai bang Fact_Taxi_Trips
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Fact_Taxi_Trips_Dim_RateCode') AND parent_object_id = OBJECT_ID(N'Fact_Taxi_Trips'))
ALTER TABLE Fact_Taxi_Trips 
	WITH CHECK ADD CONSTRAINT FK_Fact_Taxi_Trips_Dim_RateCode
	FOREIGN KEY(ID_RateCode) REFERENCES Dim_RateCode(ID_RateCode)
GO

--
-- Tao khoa ngoai cho cac bang
--

-- Tao khoa ngoai bang Dim_Location
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Dim_Location_District') AND parent_object_id = OBJECT_ID(N'Dim_Location'))
ALTER TABLE Dim_Location 
	WITH CHECK ADD CONSTRAINT FK_Dim_Location_District
	FOREIGN KEY(DistrictID) REFERENCES Dim_District(ID_District)
GO

-- Tao khoa ngoai bang Dim_Quarter
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Dim_Quarter_Year') AND parent_object_id = OBJECT_ID(N'Dim_Quarter'))
ALTER TABLE Dim_Quarter 
	WITH CHECK ADD CONSTRAINT FK_Dim_Quarter_Dim_Year
	FOREIGN KEY(ID_Year) REFERENCES Dim_Year(ID_Year)
GO

-- Tao khoai ngoai bang Dim_Month
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Dim_Month_Quarter') AND parent_object_id = OBJECT_ID(N'Dim_Month'))
ALTER TABLE Dim_Month
	WITH CHECK ADD CONSTRAINT FK_Dim_Month_Dim_Quarter
	FOREIGN KEY(ID_Quarter) REFERENCES Dim_Quarter(ID_Quarter)
GO

-- Tao khoai ngoai bang Dim_Day
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Dim_Day_Dim_Month') AND parent_object_id = OBJECT_ID(N'Dim_Day'))
ALTER TABLE Dim_Day
	WITH CHECK ADD CONSTRAINT FK_Dim_Day_Dim_Month
	FOREIGN KEY(ID_Month) REFERENCES Dim_Month(ID_Month)
GO

-- Tao khoai ngoai bang Dim_Hour
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Dim_Hour_Dim_Day') AND parent_object_id = OBJECT_ID(N'Dim_Hour'))
ALTER TABLE Dim_Hour
	WITH CHECK ADD CONSTRAINT FK_Dim_Hour_Dim_Day
	FOREIGN KEY(ID_Day) REFERENCES Dim_Day(ID_Day)
GO