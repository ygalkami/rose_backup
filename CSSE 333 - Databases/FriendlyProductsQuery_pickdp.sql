USE NWindpickdp82
GO

CREATE VIEW FriendlyProducts AS
SELECT Products.ProductID, Products.ProductName, Products.QuantityPerUnit, Products.UnitPrice, Suppliers.CompanyName, Categories.CategoryName
FROM (Products JOIN Suppliers on Products.SupplierID = Suppliers.SupplierID) JOIN Categories on Categories.CategoryID = Products.CategoryID
WHERE Products.Discontinued <> 'TRUE'