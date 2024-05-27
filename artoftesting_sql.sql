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