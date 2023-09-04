--Product
Select * from DimProductSubcategory 
Select * from DimProductCategory
Select * from DimProduct 

--Product Table
SELECT DimProduct.ProductKey,a.ProductCategoryKey,a.ProductSubCategoryKey,DimProductCategory.EnglishProductCategoryName,a.EnglishProductSubCategoryName,
DimProduct.EnglishProductName
 from DimProductSubCategory a
 left JOIN DimProduct on DimProduct.ProductSubCategoryKey=a.ProductSubcategoryKey
 left JOIN DimProductCategory ON DimProductCategory.ProductCategoryKey= a.ProductCategoryKey

 --Geography
 Select SalesTerritoryKey,SalesTerritoryRegion,SalesTerritoryCountry from DimSalesTerritory
 --Customer
 Select CustomerKey,FirstName,LastName,Gender,YearlyIncome,EnglishOccupation,DateFirstPurchase,CommuteDistance from DimCustomer

 --Date
 Select DateKey,FullDateAlternateKey,DayNumberOfWeek,DayNumberOfMonth,EnglishDayNameOfWeek,
 EnglishMonthName,MonthNumberOfYear,CalendarQuarter,FiscalQuarter,FiscalYear from DimDate

 --Employee
 Select a.EmployeeKey,a.SalesTerritoryKey,a.Gender,a.EmergencyContactName,b.SalesQuotaKey,
 b.DateKey,b.CalendarYear,b.CalendarQuarter,b.SalesAmountQuota,b.Date from DimEmployee a
Join FactSalesQuota b
on a.EmployeeKey=b.EmployeeKey

--Fact Table
Select ProductKey,OrderDateKey,DueDateKey,ShipDateKey,CustomerKey,
SalesTerritoryKey,SalesOrderNumber,SalesOrderLineNumber,
OrderQuantity,SalesAmount,OrderDate,DueDate,ShipDate  from FactInternetSales


 

 

  

  
