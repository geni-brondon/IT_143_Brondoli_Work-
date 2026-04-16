/*****************************************************************************************************************
NAME:    
PURPOSE: My script purpose...

MODIFICATION LOG:
Ver      Date        Author           Description
-----   ----------   -----------      -------------------------------------------------------------------------------
1.0     05/23/2022   MAKITA_Brondoli      1. Built this script for EC IT440


RUNTIME: 
Xm Xs

NOTES: 
This is where I talk about what this script is, why I built it, and other stuff...
 
******************************************************************************************************************/



----------------Q1-How to keep track of who last modified a record.


------------A2--- let's find out	



--------------Step 3. Research and test a solution.

https://bertwagner.com/posts/tracking-who-last-changed-a-row/


--------Step 4. Create an after-update trigger.

ALTER TABLE t_w3_schools_customers
ADD LastModifiedBy VARCHAR(100);


UPDATE t_w3_schools_customers
SET ContactName = 'brondoli'
WHERE CustomerID = 1

ALTER TRIGGER My_trigger
ON t_w3_schools_customers
AFTER UPDATE
AS
BEGIN

SET NOCOUNT ON;

UPDATE t_w3_schools_customers
SET 
LastModifiedDate = GETDATE(),
LastModifiedBy = SYSTEM_USER
WHERE CustomerID IN
(
SELECT CustomerID
FROM inserted
);

END;




UPDATE t_w3_schools_customers
SET ContactName = 'Audit Test'
WHERE CustomerID =	2;



----------------Step 5. Test results to see if they are as expected.

SELECT CustomerID, LastModifiedBy
FROM t_w3_schools_customers