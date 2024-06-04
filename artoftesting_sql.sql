https://artoftesting.com/sql-queries-for-interview#SQL_Query_Interview_Questions_for_Freshers

CREATE TABLE EmployeeDetails (
    EmpId INT PRIMARY KEY,
    FullName VARCHAR(100),
    ManagerId INT,
    DateOfJoining DATE,
    City VARCHAR(100)
);

INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId, DateOfJoining, City) VALUES
(121, 'John Snow', 321, '2019-01-31', 'Toronto'),
(321, 'Walter White', 986, '2020-01-30', 'California'),
(421, 'Kuldeep Rana', 876, '2021-11-27', 'New Delhi');


CREATE TABLE EmployeeSalary (
    EmpId INT PRIMARY KEY,
    Project VARCHAR(50),
    Salary DECIMAL(10, 2),
    Variable DECIMAL(10, 2)
);

INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable) VALUES
(121, 'P1', 8000.00, 500.00),
(321, 'P2', 10000.00, 1000.00),
(421, 'P1', 12000.00, 0.00);

1. Write an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – ‘986’.
select EmpId, FullName from EmployeeDetails where ManagerId = 986

2. Write an SQL query to fetch the different projects available from the EmployeeSalary table.
 SELECT DISTINCT(Project) FROM EmployeeSalary;

3. Write an SQL query to fetch the count of employees working in project ‘P1’.
SELECT COUNT(*)
FROM EmployeeSalary
WHERE Project = 'P1';

4. Write an SQL query to find the maximum, minimum, and average salary of the employees.
SELECT Max(Salary),
Min(Salary),
AVG(Salary)
FROM EmployeeSalary;

5. Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000.
SELECT EmpId, Salary
FROM EmployeeSalary
WHERE Salary BETWEEN 9000 AND 15000;

6. Write an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321.
SELECT EmpId, City, ManagerId
FROM EmployeeDetails
WHERE City='Toronto' AND ManagerId='321';

7. Write an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321.
SELECT EmpId, City, ManagerId
FROM EmployeeDetails
WHERE City='California' OR ManagerId='321';

8. Write an SQL query to fetch all those employees who work on Projects other than P1.
SELECT EmpId
FROM EmployeeSalary
WHERE NOT Project='P1';

9. Write an SQL query to display the total salary of each employee adding the Salary with Variable value.
SELECT EmpId,
Salary+Variable as TotalSalary
FROM EmployeeSalary;

10. Write an SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” and ends with any sequence of characters.
For this question, we can create an SQL query using like operator with ‘_’ and ‘%’ wild card characters, where ‘_’ matches a single character and ‘%’ matches ‘0 or multiple characters.

SELECT FullName
FROM EmployeeDetails
WHERE FullName LIKE ‘__hn%’;


UNION: This operator combines the results of the two SELECT statements, removing any duplicate EmpIds.
11. Write an SQL query to fetch all the EmpIds which are present in either of the tables – ‘EmployeeDetails’ and ‘EmployeeSalary’.
SELECT empid FROM employeedetails
UNION
SELECT empid FROM employeesalary;

INTERSECT: to get common elements
12. Write an SQL query to fetch common records between two tables.
SELECT empid FROM employeedetails INTERSECT  SELECT EmpId FROM employeesalary;
SUBQUERY: SELECT * FROM employeedetails where empid IN ( SELECT EmpId FROM employeesalary);

13. Write an SQL query to fetch records that are present in one table but not in another table.
SELECT * FROM employeedetails where empid NOT  IN ( SELECT EmpId FROM employeesalary);
SELECT d.*
FROM employeedetails d
LEFT JOIN employeesalary s ON d.empid = s.empid
WHERE s.empid IS NULL;

14.  Write an SQL query to fetch the EmpIds that are present in both the tables –  ‘EmployeeDetails’ and ‘EmployeeSalary.
SELECT EmpId FROM
EmployeeDetails
where EmpId IN
(SELECT EmpId FROM EmployeeSalary);

SELECT d.empid
FROM employeedetails d
INNER JOIN employeesalary s ON d.empid = s.empid;

15. Write an SQL query to fetch the EmpIds that are present in EmployeeDetails but not in EmployeeSalary.
SELECT EmpId FROM
EmployeeDetails
where EmpId NOT IN
(SELECT EmpId FROM EmployeeSalary);


16. Write an SQL query to fetch the employee’s full names and replace the space with ‘-’.
select REPLACE(fullname,' ','-') from employeedetails;

17. Write an SQL query to fetch the position of a given character(s) in a field.
SELECT INSTR(FullName, 'Snow')
FROM EmployeeDetails;

--- CONCAT_WS(separator, string1, string2, ...)
18. Write an SQL query to display both the EmpId and ManagerId together.
select CONCAT_WS('-',empid, managerid) from employeedetails;

19. Write a query to fetch only the first name(string before space) from the FullName column of the EmployeeDetails table.


20. Write an SQL query to uppercase the name of the employee and lowercase the city values.
select upper(fullname), lower(city) from employeedetails;

21. Write an SQL query to find the count of the total occurrences of a particular character – ‘n’ in the FullName field.

22. Write an SQL query to update the employee names by removing leading and trailing spaces.
UPDATE EmployeeDetails
SET FullName = LTRIM(RTRIM(FullName));

23. Fetch all the employees who are not working on any project.
SELECT EmpId
FROM EmployeeSalary
WHERE Project IS NULL;


24. Write an SQL query to fetch employee names having a salary greater than or equal to 5000 and less than or equal to 10000.
select fullname from employeedetails where empid in (SELECT EmpId  FROM employeesalary where
 salary between 10000 and 120000);

 25. Write an SQL query to find the current date-time.
 select NOW();

 26. Write an SQL query to fetch all the Employee details from the EmployeeDetails table who joined in the Year 2020.
 SELECT * FROM EmployeeDetails
WHERE DateOfJoining BETWEEN '2020/01/01'
AND '2020/12/31';

select * from employeedetails where YEAR(dateofjoining) = '2020';

27.Write an SQL query to fetch all employee records from the EmployeeDetails table who have a salary record in the EmployeeSalary table.
select * from employeedetails where empid IN(select empid from employeesalary where salary i
s not

28. Write an SQL query to fetch the project-wise count of employees sorted by project’s count in descending order.
select project,  count(*) as count_emp from employeesalary group by project order by count_emp DESC;

29.Write a query to fetch employee names and salary records. Display the employee details even if the salary record is not present for the employee.
select d.fullname, s.salary from employeedetails d LEFT JOIN employeesalary s ON d.empid=s.e
mpid;
select d.fullname, s.salary from employeedetails d JOIN employeesalary s ON d.empid=s.empid;

30. Write an SQL query to join 3 tables.
SELECT column1, column2
FROM TableA
JOIN TableB ON TableA.Column3 = TableB.Column3
JOIN TableC ON TableA.Column4 = TableC.Column4;

41. Consider a SalesData with columns SaleID, ProductID, RegionID, SaleAmount. Write a query to find the total sales amount for each product in each region.
The below query sums up SaleAmount for each combination of ProductID and RegionID, giving an insight into the total sales per product per region.

SELECT ProductID, RegionID, SUM(SaleAmount) AS TotalSales
FROM SalesData
GROUP BY ProductID, RegionID;

42. Write a query to find employees who earn more than their managers.


