USE BI_DDS
GO

CREATE TABLE dm_Count_Trips_Month
(
Count_Trips_Month int IDENTITY(1, 1) NOT NULL,
Vendor_Name varchar(50),
District_Name varchar(50),
Location_Name varchar(50),
Year_key int,
Month_key int,
Count_pickup int,
CONSTRAINT PK_dm_Count_Trips_Month PRIMARY KEY CLUSTERED (Count_Trips_Month)
)
GO

INSERT INTO dbo.dm_Count_Trips_Month (Vendor_Name, District_Name, Location_Name, Year_key, Month_key, Count_pickup)
SELECT v.VendorName, di.DistrictName, l.LocationName, y.Nam, m.Thang, COUNT(f.ID_Taxi_Trips) AS count_pickup
FROM Fact_Taxi_Trips f
	join Dim_Hour h on f.ID_Time_PickUp = h.ID_Hour
	join Dim_Day d on h.ID_Day = d.ID_Day
	join Dim_Month m on d.ID_Month = m.ID_Month
	join Dim_Quarter q on m.ID_Quarter = q.ID_Quarter
	join Dim_Year y on q.ID_Year = y.ID_Year
	join Dim_Location l on f.ID_Address_PickUp = l.ID_Location
	join Dim_District di on l.DistrictID = di.ID_District
	join Dim_Vendor v on f.ID_Vendor = v.ID_Vendor
GROUP BY v.VendorName, di.DistrictName, l.LocationName, y.Nam, m.Thang

