

Ques:Invalid Tweets


Write a solution to find invalid tweets. A tweet is considered invalid if it meets any of the following criteria:

It exceeds 140 characters in length.
It has more than 3 mentions.
It includes more than 3 hashtags.
Return the result table ordered by tweet_id in ascending order.
Sol:
SELECT tweet_id, tweet_text
FROM tweets
WHERE
    LENGTH(tweet_text) > 140 OR
    (LENGTH(tweet_text) - LENGTH(REPLACE(tweet_text, '@', ''))) > 3 OR
    (LENGTH(tweet_text) - LENGTH(REPLACE(tweet_text, '#', ''))) > 3
ORDER BY tweet_id ASC;


REPLACE(tweet_text, '@', ''): This function removes all occurrences of the @ character from the tweet_text.
LENGTH(REPLACE(tweet_text, '@', '')): This calculates the length of the tweet text after all @ characters have been removed.
LENGTH(tweet_text) - LENGTH(REPLACE(tweet_text, '@', '')): This calculates the difference in length before and after removing the @ characters. This difference represents the number of @ characters (mentions) in the tweet.
> 3: This condition checks if there are more than 3 mentions.
REPLACE(tweet_text, '#', ''): This function removes all occurrences of the # character from the tweet_text.
LENGTH(REPLACE(tweet_text, '#', '')): This calculates the length of the tweet text after all # characters have been removed.
LENGTH(tweet_text) - LENGTH(REPLACE(tweet_text, '#', '')): This calculates the difference in length before and after removing the # characters. This difference represents the number of # characters (hashtags) in the tweet.
> 3: This condition checks if there are more than 3 hashtags.

================================================================================================================================================================================================================================


Ques: Students With Invalid Departments

Table: Departments

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
In SQL, id is the primary key of this table.
The table has information about the id of each department of a university.


Table: Students

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
| department_id | int     |
+---------------+---------+
In SQL, id is the primary key of this table.
The table has information about the id of each student at a university and the id of the department he/she studies at.


Find the id and the name of all students who are enrolled in departments that no longer exist.

Return the result table in any order.

The result format is in the following example.

solution:
select s.id, s.name from students s
where
department_id not in
(select id from departments);


using Joins:
select s.id, s.name from students s
left join
departments d
on s.department_id = d.id
where d.id is NULL;

ChatGPT Explanation:

Sample Data

Departments Table
id	name
1	Computer Sci
2	Mathematics
3	Physics

Students Table
id	name	department_id
1	Alice	    1
2	Bob	        2
3	Charlie	    4
4	David	    3
5	Eve	        5

Step-by-Step Execution of the Query

LEFT JOIN:
We join the Students table with the Departments table using a left join. The result of this join includes all rows from the Students table and the matching rows from the Departments table.
If there is no match, the result will contain NULL for the columns from the Departments table.

s.id	s.name	s.department_id	d.id	d.name
1	Alice	1	1	Computer Sci
2	Bob	    2	2	Mathematics
3	Charlie	4	NULL	NULL
4	David	3	3	Physics
5	Eve 	5	NULL	NULL


WHERE d.id IS NULL:
We filter the result to include only the rows where d.id is NULL, which means that there was no matching department for that student.

s.id	s.name	s.department_id	d.id	d.name
3	    Charlie	    4	        NULL	NULL
5	    Eve	        5	        NULL	NULL


SELECT s.id, s.name:
We select only the id and name columns from the Students table for the final result.

id	name
3	Charlie
5	Eve

===============================================================================================================================================================================================================================

Ques: Find the Team Size
Table: Employee

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| employee_id   | int     |
| team_id       | int     |
+---------------+---------+
employee_id is the primary key (column with unique values) for this table.
Each row of this table contains the ID of each employee and their respective team.


Write a solution to find the team size of each of the employees.

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Employee Table:
+-------------+------------+
| employee_id | team_id    |
+-------------+------------+
|     1       |     8      |
|     2       |     8      |
|     3       |     8      |
|     4       |     7      |
|     5       |     9      |
|     6       |     9      |
+-------------+------------+
Output:
+-------------+------------+
| employee_id | team_size  |
+-------------+------------+
|     1       |     3      |
|     2       |     3      |
|     3       |     3      |
|     4       |     1      |
|     5       |     2      |
|     6       |     2      |
+-------------+------------+
Explanation:
Employees with Id 1,2,3 are part of a team with team_id = 8.
Employee with Id 4 is part of a team with team_id = 7.
Employees with Id 5,6 are part of a team with team_id = 9.

Solu:# Write your MySQL query statement below
select employee_id, count(team_id) OVER (PARTITION BY team_id) as team_size from employee ;
Another:
# Write your MySQL query statement below
with CTE as(
    select team_id, count(team_id) as team_size  from employee group by team_id
)
(select e.employee_id, c.team_size from employee e join cte c
on e.team_id = c.team_id);
================================================================================================================================================================================================================================


Ques:Duplicate Emails

Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.


Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Person table:
+----+---------+
| id | email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
Output:
+---------+
| Email   |
+---------+
| a@b.com |
+---------+
Explanation: a@b.com is repeated two times.

Sol:
with CTE as(
select email, count(*) as count from person group by email having count >1)
(select email from CTE)

================================================================================================================================================================================================================================

Table: Customers

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID and name of a customer.


Table: Orders

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
customerId is a foreign key (reference columns) of the ID from the Customers table.
Each row of this table indicates the ID of an order and the ID of the customer who ordered it.


Write a solution to find all customers who never order anything.

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Customers table:
+----+-------+
| id | name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Orders table:
+----+------------+
| id | customerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Output:
+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+

Sol:
select name as customers from customers where id not in
(select customerId from orders)

================================================================================================================================================================================================================================

Ques: Rising Temperature

Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.


Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output:
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation:
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).



Self-Join Explained by ChatGPT.:


The query uses a self-join on the Weather table. This means that we are joining the table with itself, but treating one instance as the current day's data (w1) and the other instance as the previous day's data (w2).

Join Condition
The condition DATEDIFF(w1.recordDate, w2.recordDate) = 1 ensures that we only join rows where the recordDate of w1 is exactly one day after the recordDate of w2.

How Pairs Are Generated
Let's go through the table row by row to see how pairs are formed.

First Row (id = 1, recordDate = 2015-01-01):

w1 is this row.
No rows in w2 have recordDate = 2015-01-01 + 1 day = 2015-01-02, so no pairs are formed.
Second Row (id = 2, recordDate = 2015-01-02):

w1 is this row.
We look for rows in w2 where recordDate = 2015-01-02 - 1 day = 2015-01-01.
We find a match: (id = 1, recordDate = 2015-01-01, temperature = 10).
Pair formed: (w1.id = 2, w1.recordDate = 2015-01-02, w1.temperature = 25, w2.id = 1, w2.recordDate = 2015-01-01, w2.temperature = 10).
Third Row (id = 3, recordDate = 2015-01-03):

w1 is this row.
We look for rows in w2 where recordDate = 2015-01-03 - 1 day = 2015-01-02.
We find a match: (id = 2, recordDate = 2015-01-02, temperature = 25).
Pair formed: (w1.id = 3, w1.recordDate = 2015-01-03, w1.temperature = 20, w2.id = 2, w2.recordDate = 2015-01-02, w2.temperature = 25).
Fourth Row (id = 4, recordDate = 2015-01-04):

w1 is this row.
We look for rows in w2 where recordDate = 2015-01-04 - 1 day = 2015-01-03.
We find a match: (id = 3, recordDate = 2015-01-03, temperature = 20).
Pair formed: (w1.id = 4, w1.recordDate = 2015-01-04, w1.temperature = 30, w2.id = 3, w2.recordDate = 2015-01-03, w2.temperature = 20).
Summary of Generated Pairs
The self-join and DATEDIFF condition generate pairs as follows:

For recordDate = 2015-01-02 in w1, the previous day 2015-01-01 is in w2.
For recordDate = 2015-01-03 in w1, the previous day 2015-01-02 is in w2.
For recordDate = 2015-01-04 in w1, the previous day 2015-01-03 is in w2.
These pairs are then filtered based on the temperature condition w1.temperature > w2.temperature to identify dates with rising temperatures.

I'm not able to understand why this condition works?
w1.temperature > w2.temperature;
If you reverse it, its not working
w2.temperature > w1.temperature;

Now, we need to check whether the temperature of the current day (w1.temperature) is greater than the temperature of the previous day (w2.temperature):

For the pair (id = 2, date = 2015-01-02, temp = 25) and (id = 1, date = 2015-01-01, temp = 10), the condition w1.temperature > w2.temperature translates to 25 > 10, which is true.
For the pair (id = 3, date = 2015-01-03, temp = 20) and (id = 2, date = 2015-01-02, temp = 25), the condition w1.temperature > w2.temperature translates to 20 > 25, which is false.
For the pair (id = 4, date = 2015-01-04, temp = 30) and (id = 3, date = 2015-01-03, temp = 20), the condition w1.temperature > w2.temperature translates to 30 > 20, which is true.


Sol:
select w1.id from weather w1 , weather w2
where DATEDIFF(w1.recordDate, w2.recordDate) = 1 and w1.temperature>w2.temperature;

===============================================================================================================================================================================================================================
