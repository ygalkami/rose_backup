/*
This procedure will delete a productID and orderID from the OrderDetails table.
Example)
DECLARE @status SMALLINT
exec @status = [delete_Order Details_1] <OrderID>, <ProductID>

David Pick
Jon Ogilvie
*/
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

ALTER PROCEDURE [dbo].[delete_Order Details_1]
(@OrderID_1 [int],
@ProductID_2 [int])
AS
BEGIN

-- Check to see if OrderID is valid
IF (SELECT Count(OrderID) from [Order Details] WHERE OrderID = @OrderID_1) = 0
BEGIN
	PRINT 'The OrderID ' + CONVERT(varchar(30), @OrderID_1 ) + ' does not exist'
	RETURN 1
END

-- Check to see if ProductID is valid
IF (SELECT Count(ProductID) from [Order Details] WHERE OrderID = @OrderID_1 AND ProductID = @ProductID_2) = 0
BEGIN
	PRINT 'The ProductID ' + CONVERT(varchar(30), @ProductID_2 ) + ' does not exist within the Order ' + CONVERT(varchar(30), @OrderID_1)
	RETURN 1
END

--Get the quantity of items in the order
DECLARE @quantity SMALLINT
SELECT @quantity = Quantity
FROM Nwindpickdp82.[dbo].[Order Details]
WHERE ( [OrderID] = @OrderID_1 AND [ProductID]= @ProductID_2)

--Delete the row with the given OrderID and ProductID in OrderDetails
DELETE Nwindpickdp82.[dbo].[Order Details]
WHERE ( [OrderID] = @OrderID_1 AND [ProductID]= @ProductID_2)

-- Check to see if delete is successful
IF NOT (SELECT Count(ProductID) from [Order Details] WHERE OrderID = @OrderID_1 AND ProductID = @ProductID_2) = 0
BEGIN
	PRINT 'The delete was unsuccessful.'
	RETURN 1
END

--Get the quantity of items in stock
DECLARE @inventory SMALLINT
SELECT @inventory = UnitsInStock
FROM Nwindpickdp82.[dbo].[Products]
WHERE ([ProductID]= @ProductID_2)

--Update the quantit in stock
UPDATE Nwindpickdp82.[dbo].[Products]
SET UnitsInStock = UnitsInStock+@quantity
WHERE (ProductID=@ProductID_2)

-- Check to see if update is successful
IF NOT (SELECT UnitsInStock from [Products] WHERE ProductID = @ProductID_2) = @inventory+@quantity
BEGIN
	PRINT 'The quantity update was unsuccessful.'
	RETURN 1
END

PRINT 'The delete and quantity update were successful.'

RETURN 0
END
