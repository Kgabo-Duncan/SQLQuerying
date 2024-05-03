/*Lab 2 – Querying Tables with SELECT
Overview
In this lab, you will use SELECT queries to retrieve, sort, and filter data from the AdventureWorksLT
database.
Before starting this lab, you should view Module 2 – Querying Tables with SELECT in the course 
Querying with Transact-SQL. Then, if you have not already done so, follow the instructions in the Getting 
Started document for this course to set up the lab environment.
If you find some of the challenges difficult, don’t worry – you can find suggested solutions for all of the 
challenges in the Lab Solution folder for this module.
What You’ll Need
 An Azure SQL Database instance with the AdventureWorksLT sample database. Review the 
Getting Started document for information about how to provision this.
Challenge 1: Retrieve Data for Transportation Reports
The logistics manager at Adventure Works has asked you to generate some reports containing details of 
the company’s customers to help to reduce transportation costs.*/ 
--Tip: Review the documentation for the SELECT and ORDER BY clauses in the Transact-SQL Reference.

/*1. Retrieve a list of cities
Initially, you need to produce a list of all of you customers' locations. Write a Transact-SQL query that 
queries the Address table and retrieves all values for City and StateProvince, removing duplicates.*/

SELECT *
	FROM [SalesLT].[Address];
-- 1. Solution
SELECT DISTINCT [City],[StateProvince] 
	FROM [SalesLT].[Address];

--Checking for number of duplicates for each city/state
SELECT [City], COUNT([CITY]) AS CountDuplicates ,[StateProvince]
	FROM [SalesLT].[Address]
	GROUP BY [CITY],[StateProvince]
	HAVING COUNT(CITY)>1;

/*2. Retrieve the heaviest products
Transportation costs are increasing and you need to identify the heaviest products. Retrieve the names 
of the top ten percent of products by weight.*/

--2. Solution
SELECT TOP 10 PERCENT [Name], [Weight]
	FROM [SalesLT].[Product] 
	ORDER BY WEIGHT DESC;

/*3. Retrieve the heaviest 100 products not including the heaviest ten
The heaviest ten products are transported by a specialist carrier, therefore you need to modify the 
previous query to list the heaviest 100 products not including the heaviest ten.*/

--3. SOLUTION
SELECT  [Name], [Weight]
	FROM [SalesLT].[Product]
	ORDER BY WEIGHT DESC
		OFFSET 10 ROWS 
	FETCH NEXT 100 ROWS ONLY;

/*Challenge 2: Retrieve Product Data
The Production Manager at Adventure Works would like you to create some reports listing details of the 
products that you sell.*/
--Tip: Review the documentation for the WHERE and LIKE keywords in the Transact-SQL Reference.

/*1. Retrieve product details for product model 1
Initially, you need to find the names, colors, and sizes of the products with a product model ID 1.*/

--1. Solution
SELECT [Name], [Color], [Size]
	FROM [SalesLT].[Product]
	WHERE [ProductModelID] = 1;

/*2. Filter products by color and size
Retrieve the product number and name of the products that have a color of 'black', 'red', or 'white' and 
a size of 'S' or 'M'.*/

--2. SOLUTION
SELECT [ProductNumber], [Name]
	FROM [SalesLT].[Product]
	WHERE [Color] 
		IN ('black', 'red', 'white') 
		AND [Size] IN ('S', 'M');

/*3. Filter products by product number
Retrieve the product number, name, and list price of products whose product number begins 'BK-'.*/

--3. Solution
SELECT [ProductNumber], [Name], [ListPrice]
	FROM [SalesLT].[Product]
	WHERE [ProductNumber] 
		LIKE ('BK-%');

/*4. Retrieve specific products by product number
Modify your previous query to retrieve the product number, name, and list price of products whose 
product number begins 'BK-' followed by any character other than 'R’, and ends with a '-' followed by 
any two numerals.*/

--4. SOLOUTION
SELECT [ProductNumber], [Name], [ListPrice]
	FROM [SalesLT].[Product]
	WHERE [ProductNumber] 
		LIKE ('BK-R%-[0-9][0-9]');

/*Next Steps
Well done! You’ve completed the lab, and you’re ready learn how to retrieve data from more than one 
table in Module 3 – Querying Multiple Tables with Joins in the course Querying with Transact-SQL*/