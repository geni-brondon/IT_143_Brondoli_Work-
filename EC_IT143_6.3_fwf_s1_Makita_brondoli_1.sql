/*****************************************************************************************************************
NAME:    EC_IT143_6.3_fwf
PURPOSE: My script purpose...

MODIFICATION LOG:
Ver      Date        Author            Description
-----   ----------   -----------       -------------------------------------------------------------------------------
1.0     05/23/2022   MAKITA_Brondoli      1. Built this script for EC IT440


RUNTIME: 
Xm Xs

NOTES: 
This is where I talk about what this script is, why I built it, and other stuff...
 
******************************************************************************************************************/

--------Step 1. Start with a question.



--How to extract the last name from the contact name.




--A1--- let's find out by practise 


select contactname from v_w3_schools_customers ; 


----------------Step 4. Research and test a solution.

--------------My research How to extract the first name from the contact name in database sql
------ here is the link      https://sql-server-helper.com/tips/split-name.aspx



SELECT contactname,
       SUBSTRING(contactname, CHARINDEX(' ', contactname) + 1, LEN(contactname)) AS [LastName] 
       from t_w3_schools_customers ;


       
        ----------Step 5. Create a user-defined scalar function.

        DROP FUNCTION IF EXISTS dbo.function_two 

        CREATE FUNCTION dbo.function_two
(
    @v_combined_name VARCHAR(500)
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @v_last_name VARCHAR(100);

    SET @v_last_name =
        RIGHT(
            @v_combined_name,
            CHARINDEX(' ', REVERSE(@v_combined_name) + ' ') - 1
        );

    RETURN @v_last_name;
END;
GO



SELECT
    ContactName,
    dbo.function_two(ContactName) AS LastName_UDF
FROM t_w3_schools_customers;




--------------Step 6. Compare UDF results to ad hoc query results.


SELECT contactname,
       SUBSTRING(contactname, CHARINDEX(' ', contactname) + 1, LEN(contactname)) AS [LastName] ,
       dbo.function_two(ContactName) as last_name2 
       from t_w3_schools_customers ;


       --------Step 7. Perform a “0 results expected” test.  


WITH s1
AS (
    SELECT
        contactname,
        RIGHT(contactname,
              CHARINDEX(' ', REVERSE(contactname) + ' ') - 1
        ) AS LastName,
        dbo.function_two(contactname) AS last_name2
    FROM t_w3_schools_customers
)

SELECT s1.*
FROM s1
WHERE s1.LastName <> s1.last_name2;
