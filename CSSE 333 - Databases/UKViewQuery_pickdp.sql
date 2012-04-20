-- =============================================
-- Create View template
-- =============================================
USE NWindpickdp82 --<database_name, sysname, AdventureWorks>
GO

CREATE VIEW UKViewQuery AS
SELECT Orders.OrderID, Orders.CustomerID, Customers.CompanyName, Orders.ShipName, Orders.ShipCity, Orders.ShipCountry 
FROM Orders JOIN Customers on Orders.CustomerID = Customers.CustomerID
WHERE Orders.OrderID >= 10400 AND Orders.OrderID <= 10600 AND Orders.ShipCity = 'UK'