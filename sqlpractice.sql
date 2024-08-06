

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

Ques: Concatenate the Name and the Profession

Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| person_id   | int     |
| name        | varchar |
| profession  | ENUM    |
+-------------+---------+
person_id is the primary key (column with a unique value) for this table.
Each row in this table contains a person's ID, name, and profession.
The profession column in an enum of the type ('Doctor', 'Singer', 'Actor', 'Player', 'Engineer', or 'Lawyer')


Write a solution to report each person's name followed by the first letter of their profession enclosed in parentheses.

Return the result table ordered by person_id in descending order.

The result format is shown in the following example.



Example 1:

Input:
Person table:
+-----------+-------+------------+
| person_id | name  | profession |
+-----------+-------+------------+
| 1         | Alex  | Singer     |
| 3         | Alice | Actor      |
| 2         | Bob   | Player     |
| 4         | Messi | Doctor     |
| 6         | Tyson | Engineer   |
| 5         | Meir  | Lawyer     |
+-----------+-------+------------+
Output:
+-----------+----------+
| person_id | name     |
+-----------+----------+
| 6         | Tyson(E) |
| 5         | Meir(L)  |
| 4         | Messi(D) |
| 3         | Alice(A) |
| 2         | Bob(P)   |
| 1         | Alex(S)  |
+-----------+----------+
Explanation: Note that there should not be any white space between the name and the first letter of the profession.


ChatGPT:
In MySQL, the SUBSTRING function is used to extract a substring from a string. The parameters for SUBSTRING are:

The string to extract from.
The starting position (1-based index).
The length of the substring.
To get the first letter of the profession column, you need to start from position 1 and extract 1 character. Therefore, the correct usage of SUBSTRING in this context is:

SUBSTRING(profession, 1, 1)

In MySQL, the CONCAT function is used to concatenate multiple strings into one. The parameters for CONCAT are the strings you want to concatenate, separated by commas.

Here’s the corrected query that formats each person's name followed by the first letter of their profession enclosed in parentheses, and orders the results by person_id in descending order:


Sol:
select person_id, concat(name, '(',substring(profession,1,1),')' ) as name from person
order by person_id desc

===============================================================================================================================================================================================================================

Prob: All the matches of the league

Table: Teams

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| team_name   | varchar |
+-------------+---------+
team_name is the column with unique values of this table.
Each row of this table shows the name of a team.


Write a solution to report all the possible matches of the league. Note that every two teams play two matches with each other, with one team being the home_team once and the other time being the away_team.

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Teams table:
+-------------+
| team_name   |
+-------------+
| Leetcode FC |
| Ahly SC     |
| Real Madrid |
+-------------+
Output:
+-------------+-------------+
| home_team   | away_team   |
+-------------+-------------+
| Real Madrid | Leetcode FC |
| Real Madrid | Ahly SC     |
| Leetcode FC | Real Madrid |
| Leetcode FC | Ahly SC     |
| Ahly SC     | Real Madrid |
| Ahly SC     | Leetcode FC |
+-------------+-------------+
Explanation: All the matches of the league are shown in the table.

Sol:
select a.team_name as home_team,b.team_name as away_team

from teams a
cross join teams b
on a.team_name != b.team_name

===============================================================================================================================================================================================================================

Ques: Sort the Olympic Table

Table: Olympic

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| country       | varchar |
| gold_medals   | int     |
| silver_medals | int     |
| bronze_medals | int     |
+---------------+---------+
In SQL, country is the primary key for this table.
Each row in this table shows a country name and the number of gold, silver, and bronze medals it won in the Olympic games.


The Olympic table is sorted according to the following rules:

The country with more gold medals comes first.
If there is a tie in the gold medals, the country with more silver medals comes first.
If there is a tie in the silver medals, the country with more bronze medals comes first.
If there is a tie in the bronze medals, the countries with the tie are sorted in ascending order lexicographically.
Write a solution to sort the Olympic table.

The result format is shown in the following example.



Example 1:

Input:
Olympic table:
+-------------+-------------+---------------+---------------+
| country     | gold_medals | silver_medals | bronze_medals |
+-------------+-------------+---------------+---------------+
| China       | 10          | 10            | 20            |
| South Sudan | 0           | 0             | 1             |
| USA         | 10          | 10            | 20            |
| Israel      | 2           | 2             | 3             |
| Egypt       | 2           | 2             | 2             |
+-------------+-------------+---------------+---------------+
Output:
+-------------+-------------+---------------+---------------+
| country     | gold_medals | silver_medals | bronze_medals |
+-------------+-------------+---------------+---------------+
| China       | 10          | 10            | 20            |
| USA         | 10          | 10            | 20            |
| Israel      | 2           | 2             | 3             |
| Egypt       | 2           | 2             | 2             |
| South Sudan | 0           | 0             | 1             |
+-------------+-------------+---------------+---------------+
Explanation:
The tie between China and USA is broken by their lexicographical names. Since "China" is lexicographically smaller than "USA", it comes first.
Israel comes before Egypt because it has more bronze medals.


Sol:
select country, gold_medals,silver_medals,bronze_medals from olympic
order by gold_medals desc,silver_medals desc,bronze_medals desc, country asc

===============================================================================================================================================================================================================================

Ques: The Winner University


SQL Schema
Pandas Schema
Table: NewYork

+-------------+------+
| Column Name | Type |
+-------------+------+
| student_id  | int  |
| score       | int  |
+-------------+------+
In SQL, student_id is the primary key for this table.
Each row contains information about the score of one student from New York University in an exam.


Table: California

+-------------+------+
| Column Name | Type |
+-------------+------+
| student_id  | int  |
| score       | int  |
+-------------+------+
In SQL, student_id is the primary key for this table.
Each row contains information about the score of one student from California University in an exam.


There is a competition between New York University and California University. The competition is held between the same number of students from both universities. The university that has more excellent students wins the competition. If the two universities have the same number of excellent students, the competition ends in a draw.

An excellent student is a student that scored 90% or more in the exam.

Return:

"New York University" if New York University wins the competition.
"California University" if California University wins the competition.
"No Winner" if the competition ends in a draw.
The result format is in the following example.



Example 1:

Input:
NewYork table:
+------------+-------+
| student_id | score |
+------------+-------+
| 1          | 90    |
| 2          | 87    |
+------------+-------+
California table:
+------------+-------+
| student_id | score |
+------------+-------+
| 2          | 89    |
| 3          | 88    |
+------------+-------+
Output:
+---------------------+
| winner              |
+---------------------+
| New York University |
+---------------------+
Explanation:
New York University has 1 excellent student, and California University has 0 excellent students.
Example 2:

Input:
NewYork table:
+------------+-------+
| student_id | score |
+------------+-------+
| 1          | 89    |
| 2          | 88    |
+------------+-------+
California table:
+------------+-------+
| student_id | score |
+------------+-------+
| 2          | 90    |
| 3          | 87    |
+------------+-------+
Output:
+-----------------------+
| winner                |
+-----------------------+
| California University |
+-----------------------+
Explanation:
New York University has 0 excellent students, and California University has 1 excellent student.
Example 3:

Input:
NewYork table:
+------------+-------+
| student_id | score |
+------------+-------+
| 1          | 89    |
| 2          | 90    |
+------------+-------+
California table:
+------------+-------+
| student_id | score |
+------------+-------+
| 2          | 87    |
| 3          | 99    |
+------------+-------+
Output:
+-----------+
| winner    |
+-----------+
| No Winner |
+-----------+
Explanation:
Both New York University and California University have 1 excellent student.

Sol:
# Write your MySQL query statement below
with californiac  as(
select count(*) as cali_count from california where score >=90

),
newyorkc as(
    select count(*) as nyw_count from newyork where score >=90

)
select case
when cali_count > nyw_count then 'California University'
when cali_count < nyw_count then 'New York University'
else "No Winner"
END as winner from californiac, newyorkc

===============================================================================================================================================================================================================================

Ques: Users That Actively Request Confirmation Messages

Table: Signups

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
user_id is the column with unique values for this table.
Each row contains information about the signup time for the user with ID user_id.


Table: Confirmations

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
user_id is a foreign key (reference column) to the Signups table.
action is an ENUM (category) of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').


Write a solution to find the IDs of the users that requested a confirmation message twice within a 24-hour window. Two messages exactly 24 hours apart are considered to be within the window. The action does not affect the answer, only the request time.

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Signups table:
+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
| 3       | 2020-03-21 10:16:13 |
| 7       | 2020-01-04 13:57:59 |
| 2       | 2020-07-29 23:09:44 |
| 6       | 2020-12-09 10:39:37 |
+---------+---------------------+
Confirmations table:
+---------+---------------------+-----------+
| user_id | time_stamp          | action    |
+---------+---------------------+-----------+
| 3       | 2021-01-06 03:30:46 | timeout   |
| 3       | 2021-01-06 03:37:45 | timeout   |
| 7       | 2021-06-12 11:57:29 | confirmed |
| 7       | 2021-06-13 11:57:30 | confirmed |
| 2       | 2021-01-22 00:00:00 | confirmed |
| 2       | 2021-01-23 00:00:00 | timeout   |
| 6       | 2021-10-23 14:14:14 | confirmed |
| 6       | 2021-10-24 14:14:13 | timeout   |
+---------+---------------------+-----------+
Output:
+---------+
| user_id |
+---------+
| 2       |
| 3       |
| 6       |
+---------+
Explanation:
User 2 requested two messages within exactly 24 hours of each other, so we include them.
User 3 requested two messages within 6 minutes and 59 seconds of each other, so we include them.
User 6 requested two messages within 23 hours, 59 minutes, and 59 seconds of each other, so we include them.
User 7 requested two messages within 24 hours and 1 second of each other, so we exclude them from the answer.

ChatGPT:
DATE_ADD(time_stamp, INTERVAL 24 HOUR) AS time_stamp_plus_24

Adding 24 hours:

2024-07-01 10:00:00 + 24 hours = 2024-07-02 10:00:00



Sol:
with cte as
(select *, LEAD(time_stamp) OVER(PARTITION BY user_id order by time_stamp) as next_conf_time from confirmations)

select distinct user_id from cte
where next_conf_time between time_stamp and DATE_ADD(time_stamp, INTERVAL 24 HOUR)

==============================================================================================================================================================================================================

Ques:

Product Sales Analysis V

Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| user_id     | int   |
| quantity    | int   |
+-------------+-------+
sale_id contains unique values.
product_id is a foreign key (column with unique values) to Product table.
Each row of this table shows the ID of the product and the quantity purchased by a user.


Table: Product

+-------------+------+
| Column Name | Type |
+-------------+------+
| product_id  | int  |
| price       | int  |
+-------------+------+
product_id contains unique values.
Each row of this table indicates the price of each product.


Write a solution to report the spending of each user.

Return the resulting table ordered by spending in descending order. In case of a tie, order them by user_id in ascending order.

The result format is in the following example.



Example 1:

Input:
Sales table:
+---------+------------+---------+----------+
| sale_id | product_id | user_id | quantity |
+---------+------------+---------+----------+
| 1       | 1          | 101     | 10       |
| 2       | 2          | 101     | 1        |
| 3       | 3          | 102     | 3        |
| 4       | 3          | 102     | 2        |
| 5       | 2          | 103     | 3        |
+---------+------------+---------+----------+
Product table:
+------------+-------+
| product_id | price |
+------------+-------+
| 1          | 10    |
| 2          | 25    |
| 3          | 15    |
+------------+-------+
Output:
+---------+----------+
| user_id | spending |
+---------+----------+
| 101     | 125      |
| 102     | 75       |
| 103     | 75       |
+---------+----------+
Explanation:
User 101 spent 10 * 10 + 1 * 25 = 125.
User 102 spent 3 * 15 + 2 * 15 = 75.
User 103 spent 3 * 25 = 75.
Users 102 and 103 spent the same amount and we break the tie by their ID while user 101 is on the top.

ChatGPT:
This groups the results by user_id to calculate the total spending per user.

Solu:
# Write your MySQL query statement below
select user_id, sum(s.quantity * p.price) as spending

from sales s join product p
on s.product_id = p.product_id
group by user_id
order by spending desc, user_id

================================================================================================================================================================================================================================================

Ques: Not Boring Movies
Table: Cinema

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
id is the primary key (column with unique values) for this table.
Each row contains information about the name of a movie, its genre, and its rating.
rating is a 2 decimal places float in the range [0, 10]


Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".

Return the result table ordered by rating in descending order.

The result format is in the following example.



Example 1:

Input:
Cinema table:
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 1  | War        | great 3D    | 8.9    |
| 2  | Science    | fiction     | 8.5    |
| 3  | irish      | boring      | 6.2    |
| 4  | Ice song   | Fantacy     | 8.6    |
| 5  | House card | Interesting | 9.1    |
+----+------------+-------------+--------+
Output:
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 5  | House card | Interesting | 9.1    |
| 1  | War        | great 3D    | 8.9    |
+----+------------+-------------+--------+
Explanation:
We have three movies with odd-numbered IDs: 1, 3, and 5. The movie with ID = 3 is boring so we do not include it in the answer.


ChatGPT:
MOD(id, 2) = 1
This condition ensures that only rows with odd-numbered IDs are included. The MOD(id, 2) function returns the remainder of id divided by 2, which is 1 for odd numbers.


Sol:

SELECT
    id,
    movie,
    description,
    rating
FROM
    Cinema
WHERE
    MOD(id, 2) = 1  -- Odd-numbered IDs
    AND description != 'boring'
ORDER BY
    rating DESC;

================================================================================================================================================================================================================================================
Ques: Game Play Analysis II


Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.


Write a solution to report the device that is first logged in for each player.

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output:
+-----------+-----------+
| player_id | device_id |
+-----------+-----------+
| 1         | 2         |
| 2         | 3         |
| 3         | 1         |
+-----------+-----------+





Intermediate Result:


| player_id | device_id | event_date | games_played | rnk |
| --------- | --------- | ---------- | ------------ | --- |
| 1         | 2         | 2016-03-01 | 5            | 1   |
| 1         | 2         | 2016-05-02 | 6            | 2   |
| 2         | 3         | 2017-06-25 | 1            | 1   |
| 3         | 1         | 2016-03-02 | 0            | 1   |
| 3         | 4         | 2018-07-03 | 5            | 2   |


Sol:
with cte as (
select player_id, device_id, event_date, games_played,
dense_rank() over(partition by player_id order by event_date asc) as rnk
from activity )
select player_id, device_id from cte where rnk=1

================================================================================================================================================================================================================================================

Sol:

 Ad-Free Sessions
Solved
Easy
Topics
Companies
SQL Schema
Pandas Schema
Table: Playback

+-------------+------+
| Column Name | Type |
+-------------+------+
| session_id  | int  |
| customer_id | int  |
| start_time  | int  |
| end_time    | int  |
+-------------+------+
session_id is the column with unique values for this table.
customer_id is the ID of the customer watching this session.
The session runs during the inclusive interval between start_time and end_time.
It is guaranteed that start_time <= end_time and that two sessions for the same customer do not intersect.


Table: Ads

+-------------+------+
| Column Name | Type |
+-------------+------+
| ad_id       | int  |
| customer_id | int  |
| timestamp   | int  |
+-------------+------+
ad_id is the column with unique values for this table.
customer_id is the ID of the customer viewing this ad.
timestamp is the moment of time at which the ad was shown.


Write a solution to report all the sessions that did not get shown any ads.

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Playback table:
+------------+-------------+------------+----------+
| session_id | customer_id | start_time | end_time |
+------------+-------------+------------+----------+
| 1          | 1           | 1          | 5        |
| 2          | 1           | 15         | 23       |
| 3          | 2           | 10         | 12       |
| 4          | 2           | 17         | 28       |
| 5          | 2           | 2          | 8        |
+------------+-------------+------------+----------+
Ads table:
+-------+-------------+-----------+
| ad_id | customer_id | timestamp |
+-------+-------------+-----------+
| 1     | 1           | 5         |
| 2     | 2           | 17        |
| 3     | 2           | 20        |
+-------+-------------+-----------+
Output:
+------------+
| session_id |
+------------+
| 2          |
| 3          |
| 5          |
+------------+
Explanation:
The ad with ID 1 was shown to user 1 at time 5 while they were in session 1.
The ad with ID 2 was shown to user 2 at time 17 while they were in session 4.
The ad with ID 3 was shown to user 2 at time 20 while they were in session 4.
We can see that sessions 1 and 4 had at least one ad. Sessions 2, 3, and 5 did not have any ads, so we return them.


ChatGPT:


Result of LEFT JOIN
The result of this query will include all rows from the Playback table, with matching rows from the Ads table (or NULL if there is no match):

session_id	customer_id	start_time	end_time	ad_id	timestamp
1	1	1	5	1	5
2	1	15	23	NULL	NULL
3	2	10	12	NULL	NULL
4	2	17	28	2	17
4	2	17	28	3	20
5	2	2	8	NULL	NULL
Applying the NULL Filter
Now, we want to filter out the sessions that have no ads shown. We do this by looking for rows where a.ad_id is NULL:


Sol:


SELECT session_id
FROM Playback p LEFT JOIN Ads a
ON p.customer_id = a.customer_id
AND a.timestamp BETWEEN start_time and end_time
WHERE a.customer_id IS NULL

================================================================================================================================================================================================================================================

Ques: Immediate Food Delivery I

Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the primary key (column with unique values) of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).


If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

Write a solution to find the percentage of immediate orders in the table, rounded to 2 decimal places.

The result format is in the following example.



Example 1:

Input:
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 5           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-11                  |
| 4           | 3           | 2019-08-24 | 2019-08-26                  |
| 5           | 4           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
+-------------+-------------+------------+-----------------------------+
Output:
+----------------------+
| immediate_percentage |
+----------------------+
| 33.33                |
+----------------------+
Explanation: The orders with delivery id 2 and 3 are immediate while the others are scheduled.


Sol:

# Write your MySQL query statement below
select round(count(delivery_id)/(select count(*) from delivery)*100,2) as immediate_percentage from delivery where order_date = customer_pref_delivery_date;


=============================================================================================================================================================================================================

Ques:
User Activity for the Past 30 Days I
Solved
Easy
Topics
Companies
SQL Schema
Pandas Schema
Table: Activity

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
This table may have duplicate rows.
The activity_type column is an ENUM (category) of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website.
Note that each session belongs to exactly one user.


Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day.

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+
Output:
+------------+--------------+
| day        | active_users |
+------------+--------------+
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |
+------------+--------------+
Explanation: Note that we do not care about days with zero active users.


ChatGPT:
The use of 29 days is intended to cover the past 30 days including the end date itself. This can be a bit confusing at first glance. Let’s break it down:

DATE_SUB('2019-07-27', INTERVAL 29 DAY) calculates the date 29 days before '2019-07-27', which is '2019-06-28'.
The range BETWEEN '2019-06-28' AND '2019-07-27' includes both '2019-06-28' and '2019-07-27', covering a total of 30 days.
So, the interval of 29 days is correct for including the day '2019-07-27' and the 29 days before it, resulting in a total span of 30 days.

To further clarify:

Day 0: '2019-07-27'
Day 1: '2019-07-26'
...
Day 29: '2019-06-28'

Other Queries:
SELECT activity_date AS day,
       COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27'
GROUP BY activity_date;

SELECT activity_date AS day,
       COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date;

Sol:

select activity_date as day,
COUNT(DISTINCT user_id) as active_users
from activity
where activity_date BETWEEN DATE_ADD('2019-07-27', INTERVAL -29 DAY) AND '2019-07-27'
group by activity_date
===========================================================================================================================================================================================================================z

Ques:
NPV Queries

Table: NPV

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| year          | int     |
| npv           | int     |
+---------------+---------+
(id, year) is the primary key (combination of columns with unique values) of this table.
The table has information about the id and the year of each inventory and the corresponding net present value.


Table: Queries

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| year          | int     |
+---------------+---------+
(id, year) is the primary key (combination of columns with unique values) of this table.
The table has information about the id and the year of each inventory query.


Write a solution to find the npv of each query of the Queries table.

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
NPV table:
+------+--------+--------+
| id   | year   | npv    |
+------+--------+--------+
| 1    | 2018   | 100    |
| 7    | 2020   | 30     |
| 13   | 2019   | 40     |
| 1    | 2019   | 113    |
| 2    | 2008   | 121    |
| 3    | 2009   | 12     |
| 11   | 2020   | 99     |
| 7    | 2019   | 0      |
+------+--------+--------+
Queries table:
+------+--------+
| id   | year   |
+------+--------+
| 1    | 2019   |
| 2    | 2008   |
| 3    | 2009   |
| 7    | 2018   |
| 7    | 2019   |
| 7    | 2020   |
| 13   | 2019   |
+------+--------+
Output:
+------+--------+--------+
| id   | year   | npv    |
+------+--------+--------+
| 1    | 2019   | 113    |
| 2    | 2008   | 121    |
| 3    | 2009   | 12     |
| 7    | 2018   | 0      |
| 7    | 2019   | 0      |
| 7    | 2020   | 30     |
| 13   | 2019   | 40     |
+------+--------+--------+
Explanation:
The npv value of (7, 2018) is not present in the NPV table, we consider it 0.
The npv values of all other queries can be found in the NPV table.

ChatGPT:
The IFNULL function in SQL is used to return a specified value if the expression is NULL. Otherwise, it returns the expression. It is commonly used to handle NULL values in a dataset.

In the context of your query, IFNULL(n.npv, 0) means that if n.npv is NULL, it will return 0 instead. If n.npv is not NULL, it will return the value of n.

Sol:
# Write your MySQL query statement below# Write your MySQL query statement below
SELECT q.id, q.year, ifnull(n.npv,0) as npv
FROM npv n
RIGHT JOIN queries q
ON n.id = q.id AND n.year = q.year
order by q.id
==========================================================================================================================================================================================================================================

Ques:

The Number of Users That Are Eligible for Discount
Solved
Easy
Topics
Companies
SQL Schema
0
Table: Purchases

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| user_id     | int      |
| time_stamp  | datetime |
| amount      | int      |
+-------------+----------+
(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
Each row contains information about the purchase time and the amount paid for the user with ID user_id.


A user is eligible for a discount if they had a purchase in the inclusive interval of time [startDate, endDate] with at least minAmount amount. To convert the dates to times, both dates should be considered as the start of the day (i.e., endDate = 2022-03-05 should be considered as the time 2022-03-05 00:00:00).

Write a solution to report the number of users that are eligible for a discount.

The result format is in the following example.



Example 1:

Input:
Purchases table:
+---------+---------------------+--------+
| user_id | time_stamp          | amount |
+---------+---------------------+--------+
| 1       | 2022-04-20 09:03:00 | 4416   |
| 2       | 2022-03-19 19:24:02 | 678    |
| 3       | 2022-03-18 12:03:09 | 4523   |
| 3       | 2022-03-30 09:43:42 | 626    |
+---------+---------------------+--------+
startDate = 2022-03-08, endDate = 2022-03-20, minAmount = 1000
Output:
+----------+
| user_cnt |
+----------+
| 1        |
+----------+
Explanation:
Out of the three users, only User 3 is eligible for a discount.
 - User 1 had one purchase with at least minAmount amount, but not within the time interval.
 - User 2 had one purchase within the time interval, but with less than minAmount amount.
 - User 3 is the only user who had a purchase that satisfies both conditions.


 Sol:
 CREATE FUNCTION getUserIDs(startDate DATE, endDate DATE, minAmount INT) RETURNS INT
BEGIN
  DECLARE userCount INT;

  SELECT COUNT(DISTINCT user_id) INTO userCount
  FROM purchases
  WHERE time_stamp BETWEEN startDate AND endDate
    AND amount >= minAmount;

  RETURN userCount;
END;

============================================================================================================================================================================================================================================

Ques:
Project Employees II
Table: Project

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key (combination of columns with unique values) of this table.
employee_id is a foreign key (reference column) to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.


Table: Employee

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key (column with unique values) of this table.
Each row of this table contains information about one employee.


Write a solution to report all the projects that have the most employees.

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+
Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+
Output:
+-------------+
| project_id  |
+-------------+
| 1           |
+-------------+
Explanation: The first project has 3 employees while the second one has 2.

Sol:
# Write your MySQL query statement below

with cte as(
select project_id,count(*) as cnt  from project
group by  project_id)
select project_id from cte
where cnt = (select max(cnt) from cte)

============================================================================================================================================================================================================================================

Que:
Sales Analysis I

Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
| unit_price   | int     |
+--------------+---------+
product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the name and the price of each product.
Table: Sales

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| seller_id   | int     |
| product_id  | int     |
| buyer_id    | int     |
| sale_date   | date    |
| quantity    | int     |
| price       | int     |
+-------------+---------+
This table can have repeated rows.
product_id is a foreign key (reference column) to the Product table.
Each row of this table contains some information about one sale.


Write a solution that reports the best seller by total sales price, If there is a tie, report them all.

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Product table:
+------------+--------------+------------+
| product_id | product_name | unit_price |
+------------+--------------+------------+
| 1          | S8           | 1000       |
| 2          | G4           | 800        |
| 3          | iPhone       | 1400       |
+------------+--------------+------------+
Sales table:
+-----------+------------+----------+------------+----------+-------+
| seller_id | product_id | buyer_id | sale_date  | quantity | price |
+-----------+------------+----------+------------+----------+-------+
| 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
| 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
| 2         | 2          | 3        | 2019-06-02 | 1        | 800   |
| 3         | 3          | 4        | 2019-05-13 | 2        | 2800  |
+-----------+------------+----------+------------+----------+-------+
Output:
+-------------+
| seller_id   |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation: Both sellers with id 1 and 3 sold products with the most total price of 2800.

Sol:

WITH jt AS (
  SELECT s.seller_id, SUM(s.price) AS price_amt
  FROM product d
  INNER JOIN Sales s ON d.product_id = s.product_id
  GROUP BY s.seller_id
)
SELECT jt.seller_id
FROM jt
WHERE jt.price_amt = (SELECT MAX(price_amt) FROM jt);

=============================================================================================================================================================================================================================================


Ques:
Sales Analysis II
Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
| unit_price   | int     |
+--------------+---------+
product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the name and the price of each product.
Table: Sales

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| seller_id   | int     |
| product_id  | int     |
| buyer_id    | int     |
| sale_date   | date    |
| quantity    | int     |
| price       | int     |
+-------------+---------+
This table might have repeated rows.
product_id is a foreign key (reference column) to the Product table.
buyer_id is never NULL.
sale_date is never NULL.
Each row of this table contains some information about one sale.


Write a solution to report the buyers who have bought S8 but not iPhone. Note that S8 and iPhone are products presented in the Product table.

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Product table:
+------------+--------------+------------+
| product_id | product_name | unit_price |
+------------+--------------+------------+
| 1          | S8           | 1000       |
| 2          | G4           | 800        |
| 3          | iPhone       | 1400       |
+------------+--------------+------------+
Sales table:
+-----------+------------+----------+------------+----------+-------+
| seller_id | product_id | buyer_id | sale_date  | quantity | price |
+-----------+------------+----------+------------+----------+-------+
| 1         | 1          | 1        | 2019-01-21 | 2        | 2000  |
| 1         | 2          | 2        | 2019-02-17 | 1        | 800   |
| 2         | 1          | 3        | 2019-06-02 | 1        | 800   |
| 3         | 3          | 3        | 2019-05-13 | 2        | 2800  |
+-----------+------------+----------+------------+----------+-------+
Output:
+-------------+
| buyer_id    |
+-------------+
| 1           |
+-------------+
Explanation: The buyer with id 1 bought an S8 but did not buy an iPhone. The buyer with id 3 bought both.

Sol:

SELECT buyer_id
FROM Product as p
JOIN Sales as s ON p.product_id=s.product_id
group by buyer_id
having SUM(p.product_name = 'S8') >0 and SUM(p.product_name = 'iphone')=0x

=============================================================================================================================================================================================================================================

Ques:

Reported Posts
Table: Actions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| post_id       | int     |
| action_date   | date    |
| action        | enum    |
| extra         | varchar |
+---------------+---------+
This table may have duplicate rows.
The action column is an ENUM (category) type of ('view', 'like', 'reaction', 'comment', 'report', 'share').
The extra column has optional information about the action, such as a reason for the report or a type of reaction.
extra is never NULL.


Write a solution to report the number of posts reported yesterday for each report reason. Assume today is 2019-07-05.

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Actions table:
+---------+---------+-------------+--------+--------+
| user_id | post_id | action_date | action | extra  |
+---------+---------+-------------+--------+--------+
| 1       | 1       | 2019-07-01  | view   | null   |
| 1       | 1       | 2019-07-01  | like   | null   |
| 1       | 1       | 2019-07-01  | share  | null   |
| 2       | 4       | 2019-07-04  | view   | null   |
| 2       | 4       | 2019-07-04  | report | spam   |
| 3       | 4       | 2019-07-04  | view   | null   |
| 3       | 4       | 2019-07-04  | report | spam   |
| 4       | 3       | 2019-07-02  | view   | null   |
| 4       | 3       | 2019-07-02  | report | spam   |
| 5       | 2       | 2019-07-04  | view   | null   |
| 5       | 2       | 2019-07-04  | report | racism |
| 5       | 5       | 2019-07-04  | view   | null   |
| 5       | 5       | 2019-07-04  | report | racism |
+---------+---------+-------------+--------+--------+
Output:
+---------------+--------------+
| report_reason | report_count |
+---------------+--------------+
| spam          | 1            |
| racism        | 2            |
+---------------+--------------+
Explanation: Note that we only care about report reasons with non-zero number of reports.

Sol:

# Write your MySQL query statement below
select  extra as report_reason, count(distinct post_id) as report_count from actions
where extra is not null and
action_date ='2019-07-04'
AND action = 'report'
group by extra

=============================================================================================================================================================================================================================================

Ques:

Weather Type in Each Country
Table: Countries

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| country_id    | int     |
| country_name  | varchar |
+---------------+---------+
country_id is the primary key (column with unique values) for this table.
Each row of this table contains the ID and the name of one country.


Table: Weather

+---------------+------+
| Column Name   | Type |
+---------------+------+
| country_id    | int  |
| weather_state | int  |
| day           | date |
+---------------+------+
(country_id, day) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the weather state in a country for one day.


Write a solution to find the type of weather in each country for November 2019.

The type of weather is:

Cold if the average weather_state is less than or equal 15,
Hot if the average weather_state is greater than or equal to 25, and
Warm otherwise.
Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Countries table:
+------------+--------------+
| country_id | country_name |
+------------+--------------+
| 2          | USA          |
| 3          | Australia    |
| 7          | Peru         |
| 5          | China        |
| 8          | Morocco      |
| 9          | Spain        |
+------------+--------------+
Weather table:
+------------+---------------+------------+
| country_id | weather_state | day        |
+------------+---------------+------------+
| 2          | 15            | 2019-11-01 |
| 2          | 12            | 2019-10-28 |
| 2          | 12            | 2019-10-27 |
| 3          | -2            | 2019-11-10 |
| 3          | 0             | 2019-11-11 |
| 3          | 3             | 2019-11-12 |
| 5          | 16            | 2019-11-07 |
| 5          | 18            | 2019-11-09 |
| 5          | 21            | 2019-11-23 |
| 7          | 25            | 2019-11-28 |
| 7          | 22            | 2019-12-01 |
| 7          | 20            | 2019-12-02 |
| 8          | 25            | 2019-11-05 |
| 8          | 27            | 2019-11-15 |
| 8          | 31            | 2019-11-25 |
| 9          | 7             | 2019-10-23 |
| 9          | 3             | 2019-12-23 |
+------------+---------------+------------+
Output:
+--------------+--------------+
| country_name | weather_type |
+--------------+--------------+
| USA          | Cold         |
| Australia    | Cold         |
| Peru         | Hot          |
| Morocco      | Hot          |
| China        | Warm         |
+--------------+--------------+
Explanation:
Average weather_state in USA in November is (15) / 1 = 15 so weather type is Cold.
Average weather_state in Austraila in November is (-2 + 0 + 3) / 3 = 0.333 so weather type is Cold.
Average weather_state in Peru in November is (25) / 1 = 25 so the weather type is Hot.
Average weather_state in China in November is (16 + 18 + 21) / 3 = 18.333 so weather type is Warm.
Average weather_state in Morocco in November is (25 + 27 + 31) / 3 = 27.667 so weather type is Hot.
We know nothing about the average weather_state in Spain in November so we do not include it in the result table.

Sol:

select c.country_name,
CASE
    WHEN avg(w.weather_state) <= 15 then 'Cold'
    WHEN avg(w.weather_state) >=25 THEN 'Hot'
    ELSE 'Warm'
END as weather_type
from countries c
inner join weather w
on c.country_id = w.country_id
where day between '2019-11-01' and '2019-11-30'
group by c.country_id


===============================================================================================================================================================================================================================================


Ques:
Ads Performance
Easy
Topics
Companies
SQL Schema
Pandas Schema
Table: Ads

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| ad_id         | int     |
| user_id       | int     |
| action        | enum    |
+---------------+---------+
(ad_id, user_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the ID of an Ad, the ID of a user, and the action taken by this user regarding this Ad.
The action column is an ENUM (category) type of ('Clicked', 'Viewed', 'Ignored').


A company is running Ads and wants to calculate the performance of each Ad.

Performance of the Ad is measured using Click-Through Rate (CTR) where:


Write a solution to find the ctr of each Ad. Round ctr to two decimal points.

Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.

The result format is in the following example.



Example 1:

Input:
Ads table:
+-------+---------+---------+
| ad_id | user_id | action  |
+-------+---------+---------+
| 1     | 1       | Clicked |
| 2     | 2       | Clicked |
| 3     | 3       | Viewed  |
| 5     | 5       | Ignored |
| 1     | 7       | Ignored |
| 2     | 7       | Viewed  |
| 3     | 5       | Clicked |
| 1     | 4       | Viewed  |
| 2     | 11      | Viewed  |
| 1     | 2       | Clicked |
+-------+---------+---------+
Output:
+-------+-------+
| ad_id | ctr   |
+-------+-------+
| 1     | 66.67 |
| 3     | 50.00 |
| 2     | 33.33 |
| 5     | 0.00  |
+-------+-------+
Explanation:
for ad_id = 1, ctr = (2/(2+1)) * 100 = 66.67
for ad_id = 2, ctr = (1/(1+2)) * 100 = 33.33
for ad_id = 3, ctr = (1/(1+1)) * 100 = 50.00
for ad_id = 5, ctr = 0.00, Note that ad_id = 5 has no clicks or views.
Note that we do not care about Ignored Ads.

Sol:

SELECT
    ad_id,
    CASE
        WHEN COUNT(CASE WHEN action='Clicked' THEN 1 END) + COUNT(CASE WHEN action='Viewed' THEN 1 END) = 0
        THEN 0
        ELSE ROUND(
            COUNT(CASE WHEN action='Clicked' THEN 1 END) /
            (COUNT(CASE WHEN action='Clicked' THEN 1 END) + COUNT(CASE WHEN action='Viewed' THEN 1 END)) * 100,
            2
        )
    END AS ctr
FROM
    Ads
GROUP BY
    ad_id
ORDER BY
    ctr DESC,
    ad_id ASC;

===============================================================================================================================================================================================================================================

Que:

Table: Days

+-------------+------+
| Column Name | Type |
+-------------+------+
| day         | date |
+-------------+------+
day is the column with unique values for this table.


Write a solution to convert each date in Days into a string formatted as "day_name, month_name day, year".

Return the result table in any order.

The result format is in the following example.



Example 1:

Input:
Days table:
+------------+
| day        |
+------------+
| 2022-04-12 |
| 2021-08-09 |
| 2020-06-26 |
+------------+
Output:
+-------------------------+
| day                     |
+-------------------------+
| Tuesday, April 12, 2022 |
| Monday, August 9, 2021  |
| Friday, June 26, 2020   |
+-------------------------+
Explanation: Please note that the output is case-sensitive.

ChatGPT:

Here's a breakdown of the format string used:

%W - Full name of the weekday (e.g., Monday)
%M - Full name of the month (e.g., August)
%e - Day of the month, numeric (e.g., 5 for 5th day)
%Y - Four-digit year (e.g., 2024)


Sol:

# Write your MySQL query statement below
select date_format(day, '%W, %M %e, %Y') as day from days

===============================================================================================================================================================================================================================================

Ques:

Product's Worth Over Invoices

Table: Product

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| name        | varchar |
+-------------+---------+
product_id is the column with unique values for this table.
This table contains the ID and the name of the product. The name consists of only lowercase English letters. No two products have the same name.


Table: Invoice

+-------------+------+
| Column Name | Type |
+-------------+------+
| invoice_id  | int  |
| product_id  | int  |
| rest        | int  |
| paid        | int  |
| canceled    | int  |
| refunded    | int  |
+-------------+------+
invoice_id is the column with unique values for this table and the id of this invoice.
product_id is the id of the product for this invoice.
rest is the amount left to pay for this invoice.
paid is the amount paid for this invoice.
canceled is the amount canceled for this invoice.
refunded is the amount refunded for this invoice.


Write a solution that will, for all products, return each product name with the total amount due, paid, canceled, and refunded across all invoices.

Return the result table ordered by product_name.

The result format is in the following example.


Sol:

# Write your MySQL query statement below

select name, ifnull(sum(rest),0) as rest, ifnull(sum(paid),0) as paid,
ifnull(sum(canceled),0) as canceled, ifnull(sum(refunded),0) as refunded
from invoice i right join product p
on p.product_id = i.product_id
group by name

===============================================================================================================================================================================================================================================

