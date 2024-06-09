

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
Ques: Loan Types

Table: Loans

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| loan_id     | int     |
| user_id     | int     |
| loan_type   | varchar |
+-------------+---------+
loan_id is column of unique values for this table.
This table contains loan_id, user_id, and loan_type.
Write a solution to find all distinct user_id's that have at least one Refinance loan type and at least one Mortgage loan type.

Return the result table ordered by user_id in ascending order.

The result format is in the following example.



Example 1:

Input:
Loans table:
+---------+---------+-----------+
| loan_id | user_id | loan_type |
+---------+---------+-----------+
| 683     | 101     | Mortgage  |
| 218     | 101     | AutoLoan  |
| 802     | 101     | Inschool  |
| 593     | 102     | Mortgage  |
| 138     | 102     | Refinance |
| 294     | 102     | Inschool  |
| 308     | 103     | Refinance |
| 389     | 104     | Mortgage  |
+---------+---------+-----------+
Output
+---------+
| user_id |
+---------+
| 102     |
+---------+
Explanation
- User_id 101 has three loan types, one of which is a Mortgage. However, this user does not have any loan type categorized as Refinance, so user_id 101 won't be considered.
- User_id 102 possesses three loan types: one for Mortgage and one for Refinance. Hence, user_id 102 will be included in the result.
- User_id 103 has a loan type of Refinance but lacks a Mortgage loan type, so user_id 103 won't be considered.
- User_id 104 has a Mortgage loan type but doesn't have a Refinance loan type, thus, user_id 104 won't be considered.
Output table is ordered by user_id in ascending order.

ChatGPT:
COUNT(CASE WHEN loan_type = 'Refinance' THEN 1 END) >= 1:

This part of the expression counts the occurrences of 'Refinance' loan types for each user_id.
The CASE statement checks each row to see if the loan_type is 'Refinance'. If it is, it returns 1; otherwise, it returns NULL.
The COUNT function then counts the number of non-null values returned by the CASE statement, effectively counting the occurrences of 'Refinance' loan types for each user.
COUNT(...) >= 1 ensures that there is at least one occurrence of 'Refinance' loan type for each user.


Sol:
SELECT user_id
FROM loans
GROUP BY user_id
HAVING COUNT(CASE WHEN loan_type = 'Refinance' THEN 1 END) >= 1
   AND COUNT(CASE WHEN loan_type = 'Mortgage' THEN 1 END) >= 1
ORDER BY user_id ASC;

===============================================================================================================================================================================================================================

Ques:Find Expensive cities

Table: Listings

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| listing_id  | int     |
| city        | varchar |
| price       | int     |
+-------------+---------+
listing_id is column of unique values for this table.
This table contains listing_id, city, and price.
Write a solution to find cities where the average home prices exceed the national average home price.

Return the result table sorted by city in ascending order.

The result format is in the following example.



Example 1:

Input:
Listings table:
+------------+--------------+---------+
| listing_id | city         | price   |
+------------+--------------+---------+
| 113        | LosAngeles   | 7560386 |
| 136        | SanFrancisco | 2380268 |
| 92         | Chicago      | 9833209 |
| 60         | Chicago      | 5147582 |
| 8          | Chicago      | 5274441 |
| 79         | SanFrancisco | 8372065 |
| 37         | Chicago      | 7939595 |
| 53         | LosAngeles   | 4965123 |
| 178        | SanFrancisco | 999207  |
| 51         | NewYork      | 5951718 |
| 121        | NewYork      | 2893760 |
+------------+--------------+---------+
Output
+------------+
| city       |
+------------+
| Chicago    |
| LosAngeles |
+------------+
Explanation
The national average home price is $6,122,059.45. Among the cities listed:
- Chicago has an average price of $7,048,706.75
- Los Angeles has an average price of $6,277,754.5
- San Francisco has an average price of $3,900,513.33
- New York has an average price of $4,422,739
Only Chicago and Los Angeles have average home prices exceeding the national average. Therefore, these two cities are included in the output table. The output table is sorted in ascending order based on the city names.

Sol:
WITH cte AS (
    SELECT city, AVG(price) AS avg_price
    FROM Listings
    GROUP BY city
    HAVING avg_price > (SELECT AVG(price) FROM Listings)
    ORDER BY city ASC
)
SELECT city
FROM cte;

===============================================================================================================================================================================================================================

Ques: Total Distance Travelled

Table: Users

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| name        | varchar |
+-------------+---------+
user_id is the column with unique values for this table.
Each row of this table contains user id and name.
Table: Rides

+--------------+------+
| Column Name  | Type |
+--------------+------+
| ride_id      | int  |
| user_id      | int  |
| distance     | int  |
+--------------+------+
ride_id is the column of unique values for this table.
Each row of this table contains ride id, user id, and traveled distance.
Write a solution to calculate the distance traveled by each user. If there is a user who hasn't completed any rides, then their distance should be considered as 0. Output the user_id, name and total traveled distance.

Return the result table ordered by user_id in ascending order.

The result format is in the following example.



Example 1:

Input:
Users table:
+---------+---------+
| user_id | name    |
+---------+---------+
| 17      | Addison |
| 14      | Ethan   |
| 4       | Michael |
| 2       | Avery   |
| 10      | Eleanor |
+---------+---------+
Rides table:
+---------+---------+----------+
| ride_id | user_id | distance |
+---------+---------+----------+
| 72      | 17      | 160      |
| 42      | 14      | 161      |
| 45      | 4       | 59       |
| 32      | 2       | 197      |
| 15      | 4       | 357      |
| 56      | 2       | 196      |
| 10      | 14      | 25       |
+---------+---------+----------+
Output:
+---------+---------+-------------------+
| user_id | name    | traveled distance |
+---------+---------+-------------------+
| 2       | Avery   | 393               |
| 4       | Michael | 416               |
| 10      | Eleanor | 0                 |
| 14      | Ethan   | 186               |
| 17      | Addison | 160               |
+---------+---------+-------------------+
Explanation:
-  User id 2 completed two journeys of 197 and 196, resulting in a combined travel distance of 393.
-  User id 4 completed two journeys of 59 and 357, resulting in a combined travel distance of 416.
-  User id 14 completed two journeys of 161 and 25, resulting in a combined travel distance of 186.
-  User id 16 completed only one journey of 160.
-  User id 10 did not complete any journeys, thus the total travel distance remains at 0.
Returning the table orderd by user_id in ascending order.

ChatGPT:
The COALESCE function is used to handle NULL values, ensuring that traveled distance is 0 if there are no rides for a user.

Sol:
select u.user_id, name, COALESCE(gp.sum_dist,0) as "traveled distance"  from users u left join (select r.user_id, sum(distance) as sum_dist from rides r group by r.user_id) gp on
u.user_id = gp.user_id
order by user_id asc;

===============================================================================================================================================================================================================================
