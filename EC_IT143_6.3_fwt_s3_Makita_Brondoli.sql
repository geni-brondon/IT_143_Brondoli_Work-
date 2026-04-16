/*****************************************************************************************************************
NAME:    My Script Name
PURPOSE: My script purpose...

MODIFICATION LOG:
Ver      Date        Author            Description
-----   ----------   -----------        -------------------------------------------------------------------------------
1.0     05/23/2022   Makita_Brondoli   1. Built this script for EC IT440


RUNTIME: 
Xm Xs

NOTES: 
This is where I talk about what this script is, why I built it, and other stuff...
 
******************************************************************************************************************/



----------------Q1-How to keep track of when a record was last modified.


------------A2--- let's find out	



--------------Step 3. Research and test a solution.




https://database.guide/create-a-last-modified-column-in-sql-server/


------------Step 4. Create an after-update trigger.

CREATE TRIGGER My_trigger
ON t_w3_schools_customers
AFTER UPDATE
AS
BEGIN

SET NOCOUNT ON;

UPDATE t_w3_schools_customers
SET LastModifiedDate = GETDATE()
WHERE CustomerID IN
(
SELECT CustomerID
FROM inserted
);

END;



ALTER TABLE t_w3_schools_customers
ADD LastModifiedDate DATETIME;



UPDATE t_w3_schools_customers
SET ContactName = 'jeremie bien'
WHERE CustomerID = 3;


------Step 5. Test results to see if they are as expected.


SELECT CustomerID, ContactName, LastModifiedDate
FROM t_w3_schools_customers ;


