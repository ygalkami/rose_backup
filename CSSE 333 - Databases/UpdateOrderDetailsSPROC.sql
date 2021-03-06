/*
This procedure will update the properties of an order in the Order Details table.
Usage:
DECLARE @status SMALLINT
exec @status = [update_Order Details_1] <OrderID>, <ProductID>, <NewQuantity>, <NewUnitPrice>, <NewDiscount>
*/
set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


ALTER PROCEDURE [dbo].[update_Order Details_1]
(@OrderID_1 [int],
@ProductID_2 [int],
@NewQuantity_4 [smallint] = -1,
@NewUnitPrice_3 [money] = -1,
@NewDiscount_5 [real] = -1)
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

IF (@NewQuantity_4 = -1 AND @NewUnitPrice_3 = -1 AND @NewDiscount_5 = -1) 
BEGIN
	PRINT 'You must pass at least 3 parameters.'
	RETURN 1
END


IF (NOT (@NewQuantity_4 = -1)) 
-- Update Quantity values
BEGIN

		--Get old quantity
	DECLARE @oldOrderQuantity SMALLINT
	SELECT @oldOrderQuantity = count(Quantity) 
	FROM Nwindpickdp82.[dbo].[Order Details]
	WHERE ( [OrderID] = @OrderID_1 AND [ProductID] = @ProductID_2)

	--Calculate updated inventory
	DECLARE @newInventory SMALLINT
	SET @newInventory = (SELECT (UnitsInStock) FROM Nwindpickdp82.[dbo].[Products] WHERE ProductID = @ProductID_2) + @oldOrderQuantity - @NewQuantity_4

	--If insufficent stock, exit
	IF NOT (@newInventory > 0)
	BEGIN
		PRINT 'Insufficient stock to perform quantity update.'
		RETURN 1
	END

	IF @newInventory < (SELECT ReorderLevel FROM Nwindpickdp82.dbo.Products WHERE ProductID = @ProductID_2)
	BEGIN
		PRINT 'Stock has dropped below reorder level:  time to reorder product number ' + convert(varchar(30), @ProductID_2) + '.'
	END

	--If sufficient stock, update inventory
	UPDATE Nwindpickdp82.[dbo].[Products]
	SET UnitsInStock = UnitsInStock + @oldOrderQuantity - @NewQuantity_4
	WHERE [ProductID] = @ProductID_2

	--Update order info
	UPDATE Nwindpickdp82.[dbo].[Order Details]
	SET [Quantity] = @NewQuantity_4
	WHERE ( [OrderID] = @OrderID_1 AND [ProductID] = @ProductID_2)

	PRINT 'Updated Quantity.'
END

IF (NOT @NewUnitPrice_3 = -1) 
	BEGIN
	-- Update UnitPrice values
	UPDATE Nwindpickdp82.[dbo].[Order Details]
	SET [UnitPrice] = @NewUnitPrice_3
	WHERE ( [OrderID] = @OrderID_1 AND [ProductID] = @ProductID_2)

	PRINT 'Updated Unit Price.'
END

IF (NOT @NewDiscount_5 = -1) 
	BEGIN
	-- Update Discount values
	UPDATE Nwindpickdp82.[dbo].[Order Details]
	SET [Discount] = @NewDiscount_5
	WHERE ( [OrderID] = @OrderID_1 AND [ProductID] = @ProductID_2)

	PRINT 'Updated Discount.'
END




RETURN 0
END