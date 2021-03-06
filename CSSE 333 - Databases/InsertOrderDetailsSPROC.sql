Use NWindpickdp82
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


ALTER PROCEDURE [dbo].[insert_Order Details_1]
(@OrderID_1 [int],
@ProductID_2 [int],
@UnitPrice_3 [money] = -1,
@Quantity_4 [smallint],
@Discount_5 [real] = 0)
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

--If a unit price is not provided, get it from DB 
IF (@UnitPrice_3 = -1) 
BEGIN
	-- Update UnitPrice values
	SELECT @UnitPrice_3 = UnitPrice
	FROM Nwindpickdp82.[dbo].[Products]
	WHERE ([ProductID] = @ProductID_2)

	PRINT 'Got Unit Price from DB.'
END

--Get the current stock
DECLARE @currentStock SMALLINT
SELECT @currentStock = UnitsInStock
FROM Nwindpickdp82.[dbo].[Product]
WHERE ([ProductID] = @ProductID_2)

--Calculate the new stock
DECLARE @newStock SMALLINT
SET @newStock = @currentStock-@Quantity_4

--If there aren't enough items in stock, error out.
IF @newStock<0
BEGIN
	PRINT 'There are only ' +@currentStock+ 'of ProductID ' + CONVERT(varchar(30), @ProductID_2 ) + 'in stock; cannot order ' + CONVERT(varchar(30), @Quantity_4) + 'of them.'
	RETURN 1
END

--If the new stock is below reorder level, notify user.
IF @newStock < (SELECT ReorderLevel FROM Nwindpickdp82.dbo.Products WHERE ProductID = @ProductID_2)
BEGIN
	PRINT 'Stock has dropped below reorder level:  time to reorder product number ' + convert(varchar(30), @ProductID_2) + '.'
END
z
--Update the stock
UPDATE Nwindpickdp82.[dbo].[Product]
SET UnitsInStock = UnitsInStock-@Quantity_4
WHERE ([ProductID] = @ProductID_2)

PRINT 'Updated stock quantity.'

--Insert the order
INSERT INTO Nwindpickdp82.[dbo].[Order Details]
( [OrderID], [ProductID], [UnitPrice], [Quantity], [Discount])
VALUES ( @OrderID_1, @ProductID_2, @UnitPrice_3, @Quantity_4, @Discount_5)


RETURN 0
END
