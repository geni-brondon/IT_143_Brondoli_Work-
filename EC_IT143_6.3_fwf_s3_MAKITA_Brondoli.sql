/*****************************************************************************************************************
NAME:   EC_IT143_6.3_fwf_s3_MAKITA_Brondoli.sql
PURPOSE: My script purpose...

MODIFICATION LOG:
Ver      Date        Author             Description
-----   ----------   -----------        -------------------------------------------------------------------------------
1.0     05/23/2022   MAKITA_Brondoli      1. Built this script for EC IT440


RUNTIME: 
Xm Xs

NOTES: 
This is where I talk about what this script is, why I built it, and other stuff...
 
******************************************************************************************************************/

------------What is a scalar function?

--A---- SQL scalar function is operation that take one or more input values and return a single value.


----------------What is a trigger?

--A- -- A trigger in SQL is a piece of code that is executed automatically in response to a specific event on a table in the database.
--Triggers are used to enforce business rules, maintain data integrity, and log changes.






------Q1-- How to extract the first name from the contact name.


------------A1--- let's find out 


select contactname from v_w3_schools_customers ; 


----------------Step 4. Research and test a solution.

--------------My research How to extract the first name from the contact name in database sql
------ here is the link      https://sql-server-helper.com/tips/split-name.aspx


        SELECT contactname,
        SUBSTRING(contactname, 1, NULLIF(CHARINDEX(' ', contactname) - 1, -1)) 
        AS [FirstName] from t_w3_schools_customers



        ----------Step 5. Create a user-defined scalar function.

CREATE FUNCTION  function_one
(
    @v_combined_name AS VARCHAR(500)
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @v_first_name AS VARCHAR(100);
    SET @v_first_name =
        LEFT(@v_combined_name, CHARINDEX(' ', @v_combined_name + ' ') - 1);

    RETURN @v_first_name;
END;
GO

SELECT
    ContactName,
    dbo.function_one(ContactName) AS fisrtname_UDF
FROM t_w3_schools_customers;


--------------Step 6. Compare UDF results to ad hoc query results.

        SELECT
    contactname,
    SUBSTRING(contactname, 1, NULLIF(CHARINDEX(' ', contactname) - 1, -1)) AS FirstName,
    dbo.function_one(contactname) AS first_name2
FROM t_w3_schools_customers;


------------Step 7. Perform a “0 results expected” test.



WITH s1
AS (
   
        SELECT
    contactname,
    SUBSTRING(contactname, 1, NULLIF(CHARINDEX(' ', contactname) - 1, -1)) AS FirstName,
    dbo.function_one(contactname) AS first_name2
FROM t_w3_schools_customers 
) 
     

SELECT s1.*
FROM s1
WHERE s1.FirstName <> s1.first_name2;  



