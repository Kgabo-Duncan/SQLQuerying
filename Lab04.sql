/*Querying with Transact-SQL
Lab 4 – Using Set Operators
Overview
In this lab, you will use set operators to combine the results of multiple queries in the 
AdventureWorksLT database.
Before starting this lab, you should view Module 4 – Using Set Operators in the course Querying with 
Transact-SQL. Then, if you have not already done so, follow the instructions in the Getting Started 
document for this course to set up the lab environment.
If you find some of the challenges difficult, don’t worry – you can find suggested solutions for all of the 
challenges in the Lab Solution folder for this module.
What You’ll Need
 An Azure SQL Database instance with the AdventureWorksLT sample database. Review the 
Getting Started document for information about how to provision this.*/

-- 1: Retrieve Customer Addresses

/*Customers can have two kinds of address: a main office address and a shipping address. The accounts 
department want to ensure that the main office address is always used for billing, and have asked you to 
write a query that clearly identifies the different types of address for each customer.
Tip: Review the documentation for the UNION operator in the Transact-SQL Reference.*/

/*1. Retrieve billing addresses
Write a query that retrieves the company name, first line of the street address, city, and a column 
named AddressType with the value ‘Billing’ for customers where the address type in the 
SalesLT.CustomerAddress table is ‘Main Office’.*/

SELECT c.[CompanyName], a.[AddressLine1], a.[City], 'Billing' AS [AddressType] 
FROM [SalesLT].[Customer] AS c
	JOIN [SalesLT].[CustomerAddress] AS ca 
ON c.[CustomerID] = ca.[CustomerID]
	JOIN [SalesLT].[Address] AS a 
ON a.[AddressID] = ca.[AddressID]
WHERE ca.[AddressType] = 'Main Office';

/*2. Retrieve shipping addresses
Write a similar query that retrieves the company name, first line of the street address, city, and a 
column named AddressType with the value ‘Shipping’ for customers where the address type in the 
SalesLT.CustomerAddress table is ‘Shipping’.*/

SELECT c.[CompanyName], a.[AddressLine1], a.[City], 'Shipping' as [AddressType]
FROM  [SalesLT].[Customer] AS c
	JOIN [SalesLT].[CustomerAddress] AS ca 
ON c.[CustomerID] = ca.[CustomerID]
	JOIN [SalesLT].[Address] AS a
ON ca.[AddressID] = A.[AddressID]
WHERE ca.[AddressType] ='Shipping';


/*3. Combine billing and shipping addresses
Combine the results returned by the two queries to create a list of all customer addresses that is sorted 
by company name and then address type.*/

SELECT c.[CompanyName], a.[AddressLine1], a.[City], 'Billing' AS [AddressType] 
FROM [SalesLT].[Customer] AS c
	JOIN [SalesLT].[CustomerAddress] AS ca 
ON c.[CustomerID] = ca.[CustomerID]
	JOIN [SalesLT].[Address] AS a 
ON a.[AddressID] = ca.[AddressID]
WHERE ca.[AddressType] = 'Main Office'
UNION ALL
SELECT c.[CompanyName], a.[AddressLine1], a.[City], 'Shipping' as [AddressType]
FROM  [SalesLT].[Customer] AS c
	JOIN [SalesLT].[CustomerAddress] AS ca 
ON c.[CustomerID] = ca.[CustomerID]
	JOIN [SalesLT].[Address] AS a
ON ca.[AddressID] = a.[AddressID]
WHERE ca.[AddressType] ='Shipping'
ORDER BY c.[CompanyName], [AddressType];


/*Challenge 2: Filter Customer Addresses
You have created a master list of all customer addresses, but now you have been asked to create filtered 
lists that show which customers have only a main office address, and which customers have both a main 
office and a shipping address.*/
Tip: Review the documentation for the EXCEPT and INTERSECT operators in the Transact-SQL Reference.
1. Retrieve customers with only a main office address
Write a query that returns the company name of each company that appears in a table of customers 
with a ‘Main Office’ address, but not in a table of customers with a ‘Shipping’ address.
2. Retrieve only customers with both a main office address and a shipping address
Write a query that returns the company name of each company that appears in a table of customers 
with a ‘Main Office’ address, and also in a table of customers with a ‘Shipping’ address.
Next Steps
Well done! You’ve completed the lab, and you’re ready to learn how to add aggregate functions and 
groupings to your queries in Module 5 – Using Functions and Aggregating Data in the Course Querying 
with Transact-SQL