USE nwindpickdp82
GO

ALTER PROC uspCustomersByCountry
@country VARCHAR(25) = 'Germany',
@count INT OUTPUT
AS
-- Shows how an OUTPUT parameter can be used to return a result
SET @count = (SELECT COUNT(*) FROM Customers WHERE Country =
@country)
-- The following three “naked” queries show various things in the result sets.
SELECT CustomerID, CompanyName, ContactName FROM Customers
WHERE Country = @country

-- Check for errors
DECLARE @Status SMALLINT
SET @Status = @@ERROR
IF @Status <> 0 
BEGIN
	-- Return error code to the calling program to indicate failure.
	PRINT 'Error ' + CONVERT(varchar(30), @Status) + ' occurred.'
	RETURN(@Status)
END

DELETE Customers WHERE 1=0

-- Check for errors
SET @Status = @@ERROR
IF @Status <> 0 
BEGIN
	-- Return error code to the calling program to indicate failure.
	PRINT 'Error ' + CONVERT(varchar(30), @Status) + ' occurred.'
	RETURN(@Status)
END

SELECT * FROM Orders 
WHERE EXISTS(SELECT * FROM Customers c
WHERE Country = @country AND o.CustomerID =
c.CustomerID)


-- Check for errors
SET @Status = @@ERROR
IF @Status <> 0 
BEGIN
	-- Return error code to the calling program to indicate failure.
	PRINT 'Error ' + CONVERT(varchar(30), @Status) + ' occurred.'
	RETURN(@Status)
END

RETURN 0
GO