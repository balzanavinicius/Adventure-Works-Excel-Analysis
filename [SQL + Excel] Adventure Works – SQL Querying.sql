			/* Adventure Works – SQL Excel Project */

			-- Relevant KPIs 

			-- 1. Total Online Sales by Category 
			-- 2. Total Online Revenue by Order Month
			-- 3. Total Online Sales Revenue & Cost by Country
			-- 4. Total Online Sales by Gender

	/* Chosen Tables */

	-- FactInternetSales
	-- DimSalesTerritory
	-- DimCustomer
	-- DimProductCategory *** (FactSales>DimProduct>DimProductSubcategory>DimProductCategory)

SELECT SalesOrderNumber, SalesAmount, TotalProductCost FROM FactInternetSales
SELECT SalesTerritoryCountry FROM DimSalesTerritory
SELECT Gender FROM DimCustomer
SELECT EnglishProductCategoryName FROM DimProductCategory

CREATE OR ALTER VIEW internetSales AS
SELECT
	SalesOrderNumber AS 'Sales Order',
	FORMAT(OrderDate, 'yyyy-MM-dd') AS 'Order Date',
	EnglishProductCategoryName AS 'Category',
	CONCAT(FirstName,' ',LastName) AS 'Full Name',
	Gender,
	SalesTerritoryCountry AS 'Country',
	OrderQuantity AS 'Quantity',
	FORMAT(TotalProductCost, '0.00') AS 'Product Cost',
	FORMAT(SalesAmount, '0.00') AS 'Product Revenue'
FROM
	FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN DimProductCategory dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
INNER JOIN DimSalesTerritory dst ON fis.SalesTerritoryKey = dst.SalesTerritoryKey
WHERE YEAR(OrderDate) = 2013
GO
	