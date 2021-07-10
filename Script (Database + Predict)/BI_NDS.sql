CREATE DATABASE BI_NDS
GO

USE BI_NDS
GO

--
-- Xoa bang NguonDuLieu neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'NguonDuLieu') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE NguonDuLieu
GO

--
-- Xoa bang District neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'District') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE District
GO

--
-- Xoa bang Location neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Location') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Location
GO

--
-- Xoa bang Vendor neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Vendor') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Vendor
GO

--
-- Xoa bang PaymentType neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'PaymentType') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE PaymentType
GO

--
-- Xoa bang RateCode neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'RateCode') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE RateCode
GO

--
-- Xoa bang YellowTaxiTrip neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'YellowTaxiTrip') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE YellowTaxiTrip
GO

--
-- Tao bang NguonDuLieu: 
--

CREATE TABLE NguonDuLieu
(
  Ma int NOT NULL,
  TenNguonDuLieu varchar(50) NOT NULL,
  NgayTao datetime NOT NULL,
  NgayCapNhat datetime NOT NULL,
  CONSTRAINT PK_NguonDuLieu PRIMARY KEY (Ma)
)
GO

--
-- Tao bang Location:
-- 

CREATE TABLE Location
(
	Ma int IDENTITY(1, 1) NOT NULL,
	LocationID int NOT NULL,
	LocationName varchar(50) NOT NULL,
	ShapeArea float NOT NULL,
	ShapeLeng float NOT NULL,
	The_Geom_Text text,
	The_Geom as (geometry::STGeomFromText(the_geom_text,0)),
	DistrictID int NOT NULL, 
	NgayTao datetime NOT NULL,
	NgayCapNhat datetime NOT NULL,
	NguonDuLieu int NOT NULL,
	CONSTRAINT PK_Location PRIMARY KEY (Ma)
)
GO

--
-- Tao bang District:
--

CREATE TABLE District
(
	Ma int IDENTITY(1, 1) NOT NULL,
	DistrictID int NOT NULL,
	DistrictName varchar(50) NOT NULL, 
	NgayTao datetime NOT NULL,
	NgayCapNhat datetime NOT NULL,
	NguonDuLieu int NOT NULL,
	CONSTRAINT PK_District PRIMARY KEY (Ma)
)
GO

--
-- Tao bang Vendor:
-- 

CREATE TABLE Vendor
(
	Ma int IDENTITY(1, 1) NOT NULL,
	VendorID int NOT NULL,
	VendorName varchar(50) NULL,
	NgayTao datetime NOT NULL,
	NgayCapNhat datetime NOT NULL,
	NguonDuLieu int NOT NULL,
	CONSTRAINT PK_Vendor PRIMARY KEY (Ma)
)
GO

--
-- Tao bang PaymentType:
-- 

CREATE TABLE PaymentType
(
	Ma int IDENTITY(1, 1) NOT NULL,
	PaymentTypeID int NOT NULL,
	PaymentTypeName varchar(50) NOT NULL,
	NgayTao datetime NOT NULL,
	NgayCapNhat datetime NOT NULL,
	NguonDuLieu int NOT NULL,
	CONSTRAINT PK_PaymentType PRIMARY KEY (Ma)
)
GO

--
-- Tao bang RateCode:
-- 

CREATE TABLE RateCode
(
	Ma int IDENTITY(1, 1) NOT NULL,
	RateCodeID int NOT NULL,
	RateCodeName varchar(50) NOT NULL,
	NgayTao datetime NOT NULL,
	NgayCapNhat datetime NOT NULL,
	NguonDuLieu int NOT NULL,
	CONSTRAINT PK_RateCode PRIMARY KEY (Ma)
)
GO

--
-- Tao bang YellowTaxiTrip:
--
CREATE TABLE YellowTaxiTrip
(
	Ma int IDENTITY(1, 1) NOT NULL,
	YellowTaxiTripID int NOT NULL,
	VendorID int NOT NULL,
	Tpep_Pickup_Datetime datetime NOT NULL,
	Tpep_Dropoff_Datetime datetime NOT NULL,
	Passenger_Count int NULL,
	Trip_Distance float NULL,
	RatecodeID int NULL,
	Store_And_Fwd_Flag varchar(50) NULL,
	PaymentTypeID int NOT NULL,
	Fare_Amount float NOT NULL,
	Extra float NOT NULL,
	MTA_Tax float NOT NULL,
	Tip_Amount float NOT NULL,
	Tolls_Amount float NOT NULL,
	Improvement_Surcharge float NOT NULL,
	Total_Amount float NOT NULL,
	PULocationID int NOT NULL,
	DOLocationID int NOT NULL,
	NgayTao datetime NOT NULL,
	NgayCapNhat datetime NOT NULL,
	NguonDuLieu int NOT NULL,
	CONSTRAINT PK_YellowTaxiTrip PRIMARY KEY (Ma)
)
GO



--
-- Nhap lieu cho bang NguonDuLieu
--

INSERT INTO NguonDuLieu(Ma, TenNguonDuLieu, NgayTao, NgayCapNhat)
VALUES 
  (1, 'Yello_Taxi_Trip', '2010-01-01 00:00:00', '2010-01-01 00:00:00')
GO

INSERT INTO NguonDuLieu(Ma, TenNguonDuLieu, NgayTao, NgayCapNhat)
VALUES 
  (2, 'Taxi_Zone', '2010-01-01 00:00:00', '2010-01-01 00:00:00')
GO


--
-- Tao khoa ngoai cho cac bang
--

-- Tao cac khoa ngoai bang District --
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_District_NguonDuLieu') AND parent_object_id = OBJECT_ID(N'District'))
ALTER TABLE District  
	WITH CHECK ADD CONSTRAINT FK_District_NguonDuLieu
	FOREIGN KEY(NguonDuLieu) REFERENCES NguonDuLieu(Ma)
GO

-- Tao cac khoa ngoai bang Location --
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Location_NguonDuLieu') AND parent_object_id = OBJECT_ID(N'Location'))
ALTER TABLE Location  
	WITH CHECK ADD CONSTRAINT FK_Location_NguonDuLieu
	FOREIGN KEY(NguonDuLieu) REFERENCES NguonDuLieu(Ma)
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Location_District') AND parent_object_id = OBJECT_ID(N'Location'))
ALTER TABLE Location  
	WITH CHECK ADD CONSTRAINT FK_Location_District
	FOREIGN KEY(DistrictID) REFERENCES District(Ma)
GO

-- Tao cac khoa ngoai bang Vendor --
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Vendor_NguonDuLieu') AND parent_object_id = OBJECT_ID(N'Vendor'))
ALTER TABLE Vendor  
	WITH CHECK ADD CONSTRAINT FK_Vendor_NguonDuLieu
	FOREIGN KEY(NguonDuLieu) REFERENCES NguonDuLieu(Ma)
GO

-- Tao cac khoa ngoai bang RateCode --
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Vendor_RateCode') AND parent_object_id = OBJECT_ID(N'RateCode'))
ALTER TABLE RateCode  
	WITH CHECK ADD CONSTRAINT FK_RateCode_NguonDuLieu
	FOREIGN KEY(NguonDuLieu) REFERENCES NguonDuLieu(Ma)
GO

-- Tao cac khoa ngoai bang PaymentType --
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_PaymenType_NguonDuLieu') AND parent_object_id = OBJECT_ID(N'PaymentType'))
ALTER TABLE PaymentType  
	WITH CHECK ADD CONSTRAINT FK_PaymentType_NguonDuLieu
	FOREIGN KEY(NguonDuLieu) REFERENCES NguonDuLieu(Ma)
GO

-- Tao cac khoa ngoai bang YellowTaxiTrip --
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_YellowTaxiTrip_Vendor') AND parent_object_id = OBJECT_ID(N'YellowTaxiTrip'))
ALTER TABLE YellowTaxiTrip  
	WITH CHECK ADD CONSTRAINT FK_YellowTaxiTrip_Vendor
	FOREIGN KEY(VendorID) REFERENCES Vendor(Ma)
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_YellowTaxiTrip_PULocationID_Location') AND parent_object_id = OBJECT_ID(N'YellowTaxiTrip'))
ALTER TABLE YellowTaxiTrip
	WITH CHECK ADD CONSTRAINT FK_YellowTaxiTrip_PULocationID_Location
	FOREIGN KEY(PULocationID) REFERENCES Location(Ma)
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_YellowTaxiTrip_DOLocationID_Location') AND parent_object_id = OBJECT_ID(N'YellowTaxiTrip'))
ALTER TABLE YellowTaxiTrip  
	WITH CHECK ADD CONSTRAINT FK_YellowTaxiTrip_DOLocationID_Location
	FOREIGN KEY(DOLocationID) REFERENCES Location(Ma)
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_YellowTaxiTrip_PaymentType') AND parent_object_id = OBJECT_ID(N'YellowTaxiTripType'))
ALTER TABLE YellowTaxiTrip  
	WITH CHECK ADD CONSTRAINT FK_YellowTaxiTrip_PaymentType
	FOREIGN KEY(PaymentTypeID) REFERENCES PaymentType(Ma)
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_YellowTaxiTrip_RateCode') AND parent_object_id = OBJECT_ID(N'YellowTaxiTrip'))
ALTER TABLE YellowTaxiTrip  
	WITH CHECK ADD CONSTRAINT FK_YellowTaxiTrip_RateCode
	FOREIGN KEY(RateCodeID) REFERENCES RateCode(Ma)
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_YellowTaxiTrip_NguonDuLieu') AND parent_object_id = OBJECT_ID(N'YellowTaxiTrip'))
ALTER TABLE YellowTaxiTrip  
	WITH CHECK ADD CONSTRAINT FK_YellowTaxiTrip_NguonDuLieu
	FOREIGN KEY(NguonDuLieu) REFERENCES NguonDuLieu(Ma)
GO

