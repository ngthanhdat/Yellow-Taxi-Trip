CREATE DATABASE BI_Stage
GO

USE BI_Stage
GO

--
-- Xoa bang Taxi_Zone_Stage neu co ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Taxi_Zone_Stage') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Taxi_Zone_Stage
GO

--
-- Xoa bang District neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'District_Stage') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE District_Stage
GO

--
-- Xoa bang Yellow_Taxi_Trip_Stage neu co ton tai: 
--
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Yellow_Taxi_Trip_Stage') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Yellow_Taxi_Trip_Stage
GO

--
-- Xoa bang Vendor neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Vendor_Stage') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Vendor_Stage
GO

--
-- Xoa bang PaymentType neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'PaymentType_Stage') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE PaymentType_Stage
GO

--
-- Xoa bang RateCode neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'RateCode_Stage') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE RateCode_Stage
GO


--
-- Tao bang Taxi_Zone_Stage:
-- 

CREATE TABLE Taxi_Zone_Stage
(
	OBJECTID int NOT NULL,
	Shape_Leng varchar(50) NOT NULL,
	the_geom_text text,
	the_geom as (geometry::STGeomFromText(the_geom_text,0)),
	Shape_Area float NOT NULL,
	zone varchar(50) NOT NULL,
	LocationID int NOT NULL,
	borough varchar(50) NOT NULL
)
GO

--
-- Tao bang District_Stage:
--

CREATE TABLE District_Stage
(
	DistrictID int NOT NULL,
	DistrictName varchar(50) NOT NULL,
	CONSTRAINT PK_District PRIMARY KEY (DistrictName)
)
GO

--
-- Tao bang Yellow_Taxi_Trip_Stage: 
--

CREATE TABLE Yellow_Taxi_Trip_Stage
(
	YellowTaxiTripID int NOT NULL,
	VendorID int NOT NULL,
	tpep_pickup_datetime datetime NOT NULL,
	tpep_dropoff_datetime datetime NOT NULL,
	passenger_count int NOT NULL,
	trip_distance float NOT NULL,
	RatecodeID int NOT NULL,
	store_and_fwd_flag varchar(50) NOT NULL,
	payment_type int NOT NULL,
	fare_amount float NOT NULL,
	extra float NOT NULL,
	mta_tax float  NOT NULL,
	tip_amount float NOT NULL,
	tolls_amount float NOT NULL,
	improvement_surcharge float NOT NULL,
	total_amount float NOT NULL,
	PULocationID int NOT NULL,
	DOLocationID int NOT NULL
)
GO

--
-- Tao bang Vendor_Stage:
-- 

CREATE TABLE Vendor_Stage
(
	VendorID int NOT NULL,
	VendorName varchar(50) NULL,
	CONSTRAINT PK_Vendor PRIMARY KEY (VendorID)
)
GO

--
-- Tao bang PaymentType_Stage:
-- 

CREATE TABLE PaymentType_Stage
(
	PaymentTypeID int NOT NULL,
	PaymentTypeName varchar(50) NOT NULL,
	CONSTRAINT PK_PaymentType PRIMARY KEY (PaymentTypeID)
)
GO

--
-- Tao bang RateCode_Stage:
-- 

CREATE TABLE RateCode_Stage
(
	RateCodeID int NOT NULL,
	RateCodeName varchar(50) NOT NULL,
	CONSTRAINT PK_RateCode PRIMARY KEY (RateCodeID)
)
GO

