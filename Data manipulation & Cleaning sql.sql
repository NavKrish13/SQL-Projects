Use Portfolio2
Select * from Sales

-- Converting DateTime
Select SaleDateconverted from Sales

Select SaleDate,CONVERT(date,SaleDate) as Date from Sales

Update Sales
SET	SaleDateConverted=CONVERT(date,SaleDate)

Alter Table Sales
Add SaleDateConverted Date;
-- Populating Property Adress column

Select a.parcelid,a.propertyaddress,b.parcelid,b.propertyaddress ,ISNULL(a.propertyaddress,b.propertyaddress)
from SAles a
join sales b
on a.parcelid=b.parcelid
AND a.uniqueID<>b.uniqueID
where a.propertyaddress is null

Update a
Set propertyaddress =ISNULL(a.propertyaddress,b.propertyaddress)
from SAles a
join sales b
on a.parcelid=b.parcelid
AND a.uniqueID<>b.uniqueID
where a.propertyaddress is null

Select * from sales 

-- Splitting Address column 
Select Propertyaddress ,
substring(propertyaddress,1,CHARINDEX(',',propertyaddress)) as Address,
CHARINDEX(',',propertyaddress) from Sales

Select propertyaddress ,
substring(propertyaddress,1,CHARINDEX(',',propertyaddress)-1) as Address,
substring(propertyaddress,CHARINDEX(',',propertyaddress)+2,LEN(propertyaddress)) as City from Sales

Alter Table Sales
Add Address Nvarchar(255);

Update Sales
Set Address= substring(propertyaddress,1,CHARINDEX(',',propertyaddress)-1);


Alter Table Sales
Add City Nvarchar(255);

Update Sales
Set City= substring(propertyaddress,CHARINDEX(',',propertyaddress)+2,LEN(propertyaddress));
Select * from Sales

-- Splitting OWners address 
Select owneraddress ,

PARSENAME(replace(owneraddress,',','.'),3) as OwnerAddress1,
PARSENAME(replace(owneraddress,',','.'),2) as OwnerCity,
PARSENAME(replace(owneraddress,',','.'),1) as OwnerState

from Sales

Alter Table Sales
Add Owneraddress1 Nvarchar(255),OwnerCity Nvarchar(255),Ownerstate Nvarchar(255);

Update Sales
Set Owneraddress1 = PARSENAME(replace(owneraddress,',','.'),3),
	OwnerCity	  = PARSENAME(replace(owneraddress,',','.'),2),
	OwnerState    = PARSENAME(replace(owneraddress,',','.'),1);

	Select * from sales

------ Change Y and N to standard 

Select distinct(soldasvacant),Count(soldasvacant) from sales
group by soldasvacant
order by 2


Select Soldasvacant,
 CASE	when soldasvacant='Y' THEN 'YES'
		when soldasvacant='N' THEN 'NO'
		ELSE soldasvacant
		END
from sales

Update sales
set SoldasVacant= CASE	when soldasvacant='Y' THEN 'YES'
		when soldasvacant='N' THEN 'NO'
		ELSE soldasvacant
		END

Select * from sales

-- Removing duplicates
WITH Rownumcte as
(
select * ,
	ROW_NUMBER() over(
	PARTITION BY 
				ParcelID,
				SaledateConverted,
				PropertyAddress,
				SalePrice,
				LegalReference
				Order by 
				  uniqueId
				  )row_num

from sales 

)

Select * from Rownumcte
where row_num >1

Select * from sales

--Delete unsused columns

Select * from Sales

Alter Table Sales
Drop Column Propertyaddress,Owneraddress,TaxDistrict

-- Creating a view
Create VIEW HouseSales as
Select [UniqueID ],
		ParcelID,
		SalePrice,
		LegalReference,
		SoldAsVacant,
		OWnername,
		Acreage,
		LandValue,
		BuildingValue
	from Sales

Select * from HouseSales	
		
		
		
		
		
		from Sales




Drop View HouseSales






