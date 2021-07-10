CREATE DATABASE BI_YellowTaxiTrip
GO

USE BI_YellowTaxiTrip
GO

--
-- Xoa bang Yellow_Taxi_Trip neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Yellow_Taxi_Trip') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Yellow_Taxi_Trip
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
-- Tao bang Yellow_Taxi_Trip:
--
CREATE TABLE Yellow_Taxi_Trip
(
	YellowTaxiTripID int IDENTITY(1, 1) NOT NULL,
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
	NgayTao datetime DEFAULT GETDATE(),
	NgayCapNhat datetime DEFAULT GETDATE(),
	PULocationID int NOT NULL,
	DOLocationID int NOT NULL
	CONSTRAINT PK_Yellow_Taxi_Trip PRIMARY KEY (YellowTaxiTripID)
)
GO

--
-- Tao bang Vendor:
-- 

CREATE TABLE Vendor
(
	VendorID int NOT NULL,
	VendorName varchar(50) NULL,
	NgayTao datetime DEFAULT GETDATE(),
	NgayCapNhat datetime DEFAULT GETDATE(),
	CONSTRAINT PK_Vendor PRIMARY KEY (VendorID)
)
GO

--
-- Tao bang PaymentType:
-- 

CREATE TABLE PaymentType
(
	PaymentTypeID int NOT NULL,
	PaymentTypeName varchar(50) NOT NULL,
	NgayTao datetime DEFAULT GETDATE(),
	NgayCapNhat datetime DEFAULT GETDATE(),
	CONSTRAINT PK_PaymentType PRIMARY KEY (PaymentTypeID)
)
GO

--
-- Tao bang RateCode:
-- 

CREATE TABLE RateCode
(
	RateCodeID int NOT NULL,
	RateCodeName varchar(50) NOT NULL,
	NgayTao datetime DEFAULT GETDATE(),
	NgayCapNhat datetime DEFAULT GETDATE(),
	CONSTRAINT PK_RateCode PRIMARY KEY (RateCodeID)
)
GO

--
-- Tao khoa ngoai cho bang Yello_Taxi_Trip
--
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Yellow_Taxi_Trip_Vendor') AND parent_object_id = OBJECT_ID(N'Yellow_Taxi_Trip'))
ALTER TABLE Yellow_Taxi_Trip 
	WITH CHECK ADD CONSTRAINT FK_Yellow_Taxi_Trip_Vendor
	FOREIGN KEY(VendorID) REFERENCES Vendor(VendorID)
GO

--
-- Tao khoa ngoai cho bang Yellow_Taxi_Trip
--
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Yellow_Taxi_Trip_PaymentType') AND parent_object_id = OBJECT_ID(N'Yellow_Taxi_Trip'))
ALTER TABLE Yellow_Taxi_Trip 
	WITH CHECK ADD CONSTRAINT FK_Yellow_Taxi_Trip_PaymentType
	FOREIGN KEY(payment_type) REFERENCES PaymentType(PaymentTypeID)
GO

--
-- Tao khoa ngoai cho bang Yello_Taxi_Trip
--
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_Yellow_Taxi_Trip_RateCode') AND parent_object_id = OBJECT_ID(N'Yellow_Taxi_Trip'))
ALTER TABLE Yellow_Taxi_Trip 
	WITH CHECK ADD CONSTRAINT FK_Yellow_Taxi_Trip_RateCode
	FOREIGN KEY(RatecodeID) REFERENCES RateCode(RateCodeID)
GO

--
-- Nhap lieu cho bang Vendor
--
INSERT INTO Vendor(VendorID, VendorName)
VALUES 
  (1, 'Creative Mobile Technologies, LLC')
GO

INSERT INTO Vendor(VendorID, VendorName)
VALUES 
  (2, 'VeriFone Inc')
GO

INSERT INTO Vendor(VendorID, VendorName)
VALUES 
  (3, 'Digital Dispatch Systems')
GO

INSERT INTO Vendor(VendorID, VendorName)
VALUES 
  (4, 'CQ-BI-03')
GO

--
-- Nhap lieu cho bang PaymentType
--
INSERT INTO PaymentType(PaymentTypeID, PaymentTypeName)
VALUES 
  (1, 'Credit card')
GO

INSERT INTO PaymentType(PaymentTypeID, PaymentTypeName)
VALUES 
  (2, 'Cash')
GO

INSERT INTO PaymentType(PaymentTypeID, PaymentTypeName)
VALUES 
  (3, 'No charge')
GO

INSERT INTO PaymentType(PaymentTypeID, PaymentTypeName)
VALUES 
  (4, 'Dispute')
GO

INSERT INTO PaymentType(PaymentTypeID, PaymentTypeName)
VALUES 
  (5, 'Unknown')
GO

INSERT INTO PaymentType(PaymentTypeID, PaymentTypeName)
VALUES 
  (6, 'Voided trip')
GO


--
-- Nhap lieu cho bang RateCode
--
INSERT INTO RateCode(RateCodeID, RateCodeName)
VALUES 
  (1, 'Standard rate')
GO

INSERT INTO RateCode(RateCodeID, RateCodeName)
VALUES 
  (2, 'JFK')
GO

INSERT INTO RateCode(RateCodeID, RateCodeName)
VALUES 
  (3, 'Newark')
GO

INSERT INTO RateCode(RateCodeID, RateCodeName)
VALUES 
  (4, 'Nassau or Westchester')
GO

INSERT INTO RateCode(RateCodeID, RateCodeName)
VALUES 
  (5, 'Negotiated fare')
GO

INSERT INTO RateCode(RateCodeID, RateCodeName)
VALUES 
  (6, 'Group ride')
GO