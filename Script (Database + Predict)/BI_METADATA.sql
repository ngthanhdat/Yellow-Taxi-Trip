CREATE DATABASE BI_METADATA
GO

USE BI_METADATA
GO


--
-- Xoa bang Data_Flow neu ton tai: 
--
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'Data_Flow') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE Data_Flow
GO

--
-- Xoa bang DDS neu ton tai: 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'DDS') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE DDS
GO

--
-- Tao bang Data_Flow: 
--

CREATE TABLE Data_Flow
(
	ID int IDENTITY(1, 1) NOT NULL,
	TenNguonDuLieu varchar(50) NOT NULL,
	NgayCapNhat datetime NOT NULL
	CONSTRAINT PK_Data_Flow PRIMARY KEY (ID)
)
GO

--
-- Tao bang DDS: 
--

CREATE TABLE DDS
(
	ID int IDENTITY(1, 1) NOT NULL,
	TenBang varchar(50) NOT NULL,
	NgayCapNhat datetime NOT NULL
	CONSTRAINT PK_DDS PRIMARY KEY (ID)
)
GO

--
-- Nhap lieu bang Data_Flow:
--
SET IDENTITY_INSERT Data_Flow ON
GO

INSERT INTO Data_Flow(ID, TenNguonDuLieu, NgayCapNhat)
VALUES 
  (1, N'Yellow_Taxi_Trip', '2010-01-01 00:00:00')
GO

INSERT INTO Data_Flow(ID, TenNguonDuLieu, NgayCapNhat)
VALUES 
  (2, N'Taxi_Zone', '2010-01-01 00:00:00')
GO

SET IDENTITY_INSERT Data_Flow OFF
GO

--
-- Nhap lieu bang DDS:
--
SET IDENTITY_INSERT DDS ON
GO

INSERT INTO DDS(ID,	TenBang, NgayCapNhat)
VALUES 
  (1, N'Vendor', '2010-01-01 00:00:00')
GO

INSERT INTO DDS(ID,	TenBang, NgayCapNhat)
VALUES 
  (2, N'PaymentType', '2010-01-01 00:00:00')
GO

INSERT INTO DDS(ID,	TenBang, NgayCapNhat)
VALUES 
  (3, N'RateCode', '2010-01-01 00:00:00')
GO

INSERT INTO DDS(ID,	TenBang, NgayCapNhat)
VALUES 
  (4, N'District', '2010-01-01 00:00:00')
GO

INSERT INTO DDS(ID,	TenBang, NgayCapNhat)
VALUES 
  (5, N'Location', '2010-01-01 00:00:00')
GO

INSERT INTO DDS(ID,	TenBang, NgayCapNhat)
VALUES 
  (6, N'Year', '2010-01-01 00:00:00')
GO

INSERT INTO DDS(ID,	TenBang, NgayCapNhat)
VALUES 
  (7, N'Quarter', '2010-01-01 00:00:00')
GO

INSERT INTO DDS(ID,	TenBang, NgayCapNhat)
VALUES 
  (8, N'Month', '2010-01-01 00:00:00')
GO

INSERT INTO DDS(ID,	TenBang, NgayCapNhat)
VALUES 
  (9, N'Day', '2010-01-01 00:00:00')
GO

INSERT INTO DDS(ID,	TenBang, NgayCapNhat)
VALUES 
  (10, N'Hour', '2010-01-01 00:00:00')
GO

SET IDENTITY_INSERT DDS OFF
GO
