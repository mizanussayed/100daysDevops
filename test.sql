USE test_sql_db;
----------------Pivot Operator -----------------------
SELECT Gen.GenderName, emp.City, Emp.name, Emp.Salary
FROM Employees Emp
INNER JOIN Genders  Gen ON Emp.GenderId = Gen.Id
ORDER BY Emp.City;

Select City , sum(Salary)
from Employees
GROUP by City

SELECT -- GenderName,
    Dhaka, Khulna, Chittagong
FROM
    (
    SELECT -- Gen.GenderName, 
        Emp.City, Emp.Salary
    FROM Employees Emp
        INNER JOIN Genders  Gen
        ON Emp.GenderId = Gen.Id
) as sourceTable
PIVOT
(
  Sum(Salary) -- will be rows values
  FOR City    -- Source of Column Header
  IN (Dhaka, Khulna, Chittagong)   -- Header
)
AS PivotTable

---------------- ------ Unpivot Operator -----------------------
Select City , Salary
From
    (
    SELECT Dhaka, Khulna, Chittagong
    FROM
        (
        SELECT Emp.City, Emp.Salary
        FROM Employees Emp
    ) as sourceTable
    PIVOT
    (
     Sum(Salary) FOR City IN (Dhaka, Khulna, Chittagong)  
    )
    AS PivotTable
    ) 
    AS PiTble
UNPIVOT
(
   Salary FOR City IN (Dhaka, Khulna, Chittagong)  
)
AS UNPivotTable

---------------- ------  Correlated Subquery  -----------------------
Select Name,
    (
    Select GenderName
    FROM Genders
    WHERE Id = Employees. GenderId
) Gender
From Employees
---------------- ------  Re-runnable SQL Scripts -----------------------
USE test_sql_db;
IF OBJECT_ID('Employees') IS NULL
BEGIN
    PRINT 'Employee Table created ..'
END
ELSE
BEGIN
    PRINT 'Table already created'
END
--or 
IF NOT EXISTS (SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'Email'
    AND TABLE_NAME = 'Employees' AND TABLE_SCHEMA = 'dbo')
BEGIN
    PRINT 'Email column not fund'
END
---------------------- Merge Table -----------------------
MERGE Employees2 AS T
USING Employees AS S
ON T.ID = S.ID 
WHEN MATCHED THEN
   UPDATE SET T.Name = S.Name  
WHEN NOT MATCHED BY TARGET THEN
  INSERT (ID, Name) VALUES (S.ID, S.Name)
WHEN NOT MATCHED BY Source THEN
  DELETE;

---------------------- Except Operator VS NOT IN -----------------------
    SELECT ID , NAME
    FROM Employees
EXCEPT
    SELECT Id, Name
    FROM Employees2
--NOT IN
SELECT ID , NAME, City
FROM Employees
WHERE ID NOT IN (
SELECT ID
FROM Employees2)

---------------------- Intersect Operator VS INNER JOIN -----------------------
    SELECT ID , NAME
    FROM Employees
INTERSECT
    SELECT Id, Name
    FROM Employees2
--NOT IN
SELECT emp.ID , emp.NAME, City
FROM Employees emp
    INNER JOIN Employees2 ON emp.ID = Employees2.ID
----------------------Cross Apply / inner Join with fn-----------------------
GO
CREATE FUNCTION fnEmployeeByDept 
(
@deptId int
)
RETURNS @empTable TABLE (Id Int,
    Name NVARCHAR(50),
    City NVARCHAR(25))
AS
BEGIN
    INSERT into @empTable
    select Id, Name, City
    from Employees
    WHERE GenderId = @deptId
    RETURN
END
GO
SELECT D. Name DepartmentName , emp.Name, emp.City
FROM Departments D
CROSS APPLY fnEmployeeByDept(D.ID) emp
----------------------Outer Apply / left Join with fn-----------------------
SELECT D. Name DepartmentName , emp.Name, emp.City
FROM Departments D
OUTER APPLY fnEmployeeByDept(D.ID) emp
----------------------Table type valued Parameter-----------------------
CREATE TYPE EmpTableType AS TABLE   --- create type
(
    Id int PRIMARY key,
    Name NVARCHAR(50),
    Gender NVARCHAR(10)
)
GO
CREATE PROCEDURE spInsertEmployees
    --- create sp
    @EmpTable EmpTableType READONLY
AS
BEGIN
    INSERT INTO Employees2
    SELECT *
    FROM @EmpTable
END
GO
DECLARE @empTable EmpTableType
--- declare and insert
INSERT INTO @EmpTable
VALUES(1, 'Kamal', 'Male'),
      (2, 'Mahi', 'Female');
EXEC spInsertEmployees @empTable
/*
Query to compute 
Sum of salary by City and Gender
Sum of salary by City only
Sum of salary by Gender only
Grand Total
*/
--------------------------------By Union All-------------
SELECT Emp.ID, Name, Gen.GenderName, Salary, City
FROM Employees Emp
    JOIN Genders Gen ON Emp.GenderId = Gen.ID
-----
    SELECT City, GenderName, SUM(Salary)
    FROM Employees Emp
        JOIN Genders Gen ON Emp.GenderId = Gen.ID
    GROUP BY City, GenderName
UNION ALL
    SELECT City, null, SUM(Salary)
    FROM Employees Emp
        JOIN Genders Gen ON Emp.GenderId = Gen.ID
    GROUP BY City
UNION ALL
    SELECT NULL, GenderName, SUM(Salary)
    FROM Employees Emp
        JOIN Genders Gen ON Emp.GenderId = Gen.ID
    GROUP BY GenderName
UNION ALL
    SELECT NULL, null, SUM(Salary)
    FROM Employees Emp

--------------------------------Grouping Sets with Group by-------------
SELECT City, GenderName, SUM(Salary)
FROM Employees Emp
    JOIN Genders Gen ON Emp.GenderId = Gen.ID
GROUP BY 
    GROUPING SETS
    (
        (City, GenderName),
        (City),
        (GenderName),
        ()
    )
ORDER BY GROUPING(City), GROUPING(GenderName)

----------------------------Rollup With Group by ------------------
--Grand total in every group
SELECT City, GenderName, SUM(Salary)
FROM Employees Emp
    JOIN Genders Gen ON Emp.GenderId = Gen.ID
--GROUP BY Rollup(City, GenderName) 
GROUP BY  City, GenderName  with ROLLUP
----------------------------Cube With Group by ------------------
-- every Combination
SELECT City, GenderName, SUM(Salary)
FROM Employees Emp
    JOIN Genders Gen ON Emp.GenderId = Gen.ID
GROUP BY Cube(City, GenderName)
----------------------------Grouping With Group by, Grouping_sets, Rollup, Cube ------------------
--it indicate the column is aggregated or not 1/0
SELECT
    CASE  WHEN Grouping(City) = 1 THEN 'All' ELSE ISNULL(City, 'Unknown') END City ,
    CASE WHEN Grouping(GenderName) = 1 THEN 'All' ELSE ISNULL(GenderName, 'Unknown') END GenderName,
    SUM(Salary)
FROM Employees Emp
    JOIN Genders Gen ON Emp.GenderId = Gen.ID
GROUP BY Cube(City, GenderName)
-- same result if Sure there is no null value 
SELECT
    ISNULL(City, 'All') City ,
    ISNULL(GenderName, 'All') GenderName,
    SUM(Salary)
FROM Employees Emp
    JOIN Genders Gen ON Emp.GenderId = Gen.ID
GROUP BY Cube(City, GenderName)

----------------------------Over Clause ------------------
SELECT Name, City,
    COUNT(*) Over(partition by City) EmpCount,
    SUM(Salary) Over(partition by City) Total,
    Max(Salary) Over(partition by City) MaxSal,
    Min(Salary) Over(partition by City) MinSal,
    AVG(Salary) Over(partition by City) AvgSal
FROM Employees

----------------------------Row_Number ------------------
SELECT Name, City, Salary, ROW_NUMBER() Over(ORDER BY CITY) RowNumber
FROM Employees
SELECT Name, City, Salary, ROW_NUMBER() Over( PARTITION BY CITY ORDER BY CITY) RowNumber
FROM Employees
----------------------------Rank and Dense_Rank ------------------
SELECT Name, City, Salary, RANK() Over(ORDER BY salary DESC) Rank
FROM Employees
SELECT Name, City, Salary, RANK() Over( PARTITION BY CITY ORDER BY Salary DESC) Rank
FROM Employees
SELECT Name, Salary,
    Row_Number() Over(ORDER BY salary DESC) RowNumber,
    RANK() Over(ORDER BY salary DESC) Rank,
    DENSE_RANK() Over(ORDER BY salary DESC) DensRank
FROM Employees
----------------------------Running Total ----------------------
SELECT Name, Salary,
    SUM(Salary) Over() Total
FROM Employees
SELECT Name, Salary,
    SUM(Salary) Over(order by Id) Total
FROM Employees

SELECT Name, city, Salary,
    SUM(Salary) Over( PARTITION by city order by Id) Total
FROM Employees
----------------------------Ntile ----------------------
SELECT Name, City,
    Ntile(3) Over(ORDER by Id) [Ntile]
FROM Employees
SELECT Name, City,
    Ntile(3) Over( Partition by city ORDER by Id) [Ntile]
FROM Employees
----------------------------Lead & Lag ----------------------
--Lead(Column_Name, Offset, Default_Value)
--Lag(Column_Name, Offset, Default_Value)
SELECT Name, City, Salary,
    Lead(Salary) Over(ORDER by Id) Lead_2
FROM Employees
SELECT Name, City, Salary,
    Lead(Salary, 2, 1000) Over(ORDER by Id) Lead_2
FROM Employees
SELECT Name, City, Salary,
    Lead(Salary) Over(partition by city ORDER by Id) Lead_2
FROM Employees
SELECT Name, City, Salary,
    Lead(Salary) Over(ORDER by Id) Lead_2,
    Salary,
    lag(Salary) Over(ORDER by Id) Lag_2
FROM Employees
----------------------------First_Value / Last_Value----------------------
SELECT Name, City, Salary,
    First_Value(Name) Over(ORDER by Salary desc) FirsValue
FROM Employees
SELECT Name, Salary,
    Last_Value(Name) Over(ORDER by Salary desc) FirsValue
FROM Employees
----------------------------Rows or Range Clause----------------------
--not sum whole range
SELECT Name, City, Salary,
    sum(Salary) Over(ORDER by Id) SumSal
FROM Employees
-- same as 
SELECT Name, City, Salary,
    SUM(Salary) Over(
        ORDER by Id RANGE BETWEEN UNBOUNDED PRECEDING and CURRENT ROW
    --  ORDER by Id ROWS BETWEEN UNBOUNDED PRECEDING and CURRENT ROW
        ) SumSal
FROM Employees
-- The Default for Rows or Range Clause is 
-- ROWS BETWEEN UNBOUNDED PRECEDING and CURRENT ROW
-- RANGE BETWEEN UNBOUNDED PRECEDING and CURRENT ROW
SELECT Name, Salary,
    SUM(Salary) Over(
        ORDER by Salary ROWS BETWEEN UNBOUNDED PRECEDING and UNBOUNDED Following 
        )SumSal
FROM Employees
SELECT Name, Salary,
    SUM(Salary) Over(
         ORDER by Salary rows BETWEEN 2 PRECEDING and 2 Following 
        ) SumSal
FROM Employees
SELECT Name, Salary, Last_Value (Name) 
    Over(
         ORDER by Salary DESC  ROWS BETWEEN UNBOUNDED PRECEDING and UNBOUNDED Following 
        ) FirsValue
FROM Employees

----------------------------Choose Function----------------------
SELECT CASE DATEPART(MONTH, GETDATE()) 
          WHEN 1 THEN 'Jun'
          WHEN 2 THEN 'feb'
          WHEN 3 THEN 'Mar'
          WHEN 4 THEN 'Apr'
END AS [Month]
--Using Choose 
-- Chose(index, val_1, val_2)
SELECT CHOOSE(DATEPART(MM, GETDATE()), 'Jan', 'Feb', 'Mar', 'Apr') AS [Month]

----------------------------IIF Function----------------------
--Iff(boolean_exp, true_val, false_val)
DECLARE @gender INT
SET @gender = 2
PRINT IIF(@gender = 1, 'Male', 'Female')
