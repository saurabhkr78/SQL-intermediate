/*To create Database*/
CREATE DATABASE Company;

/*To create a table*/
CREATE TABLE student (
    UID INT,
    name VARCHAR(20),
    city VARCHAR(20),
    marks VARCHAR(20),
    PRIMARY KEY (UID)
);
/* To insert data into a table*/
INSERT INTO student (UID, name, city, marks) VALUES (1, 'Alice', 'New York', '85');
INSERT INTO student (UID, name, city, marks) VALUES (2, 'Bob', 'Los Angeles', '90');
INSERT INTO student (UID, name, city, marks) VALUES (3, 'Charlie', 'Chicago', '78');
INSERT INTO student (UID, name, city, marks) VALUES (4, 'David', 'Houston', '92');
INSERT INTO student (UID, name, city, marks) VALUES (5, 'Eve', 'Phoenix', '88');
INSERT INTO student (UID, name, city, marks) VALUES (6, 'Frank', 'Philadelphia', '80');
INSERT INTO student (UID, name, city, marks) VALUES (7, 'Grace', 'San Antonio', '95');
INSERT INTO student (UID, name, city, marks) VALUES (8, 'Hannah', 'San Diego', '85');
INSERT INTO student (UID, name, city, marks) VALUES (9, 'Ivy', 'Dallas', '89');
INSERT INTO student (UID, name, city, marks) VALUES (10, 'Jack', 'San Jose', '87');


/*To retrieve data from a table:*/
select * from student;

/*retreive specific column*/
SELECT name, city FROM student; 

/*To update existing data*/
UPDATE student SET marks = '95' WHERE UID = 1;
select * from student;

/*To delete data*/
DELETE FROM student WHERE UID = 2;
select * from student;

/*COUNT(): Counts the number of rows.*/
SELECT COUNT(*) FROM student;

/*AVG(): Calculates the average value of a numeric column.*/
SELECT AVG(marks) FROM student;
SELECT MIN(marks) FROM student;
SELECT SUM(marks)FROM student;



/*Aggregate Functions:-Aggregate functions are often used with the GROUP BY clause of the SELECT statement. The GROUP BY clause splits the result-set into groups of values and the aggregate function can be used to return a single value for each group.*/
/*AVG(): Calculates the average value of a numeric column.
COUNT(): Counts the number of rows.it counts null value also.
SUM(): Calculates the sum of a numeric column.
MAX(): Finds the maximum value in a column.
MIN(): Finds the minimum value in a column.*/


/*Use the WHERE clause to filter records*/
SELECT * FROM student WHERE city = 'New York';
SELECT * FROM student WHERE marks > '80';

/*Use the ORDER BY clause to sort records
The DESC command is used to sort the data returned in descending order*/
SELECT * FROM student ORDER BY marks DESC;

/*The WHERE clause can contain one or many AND operators.
The AND operator is used to filter records based on more than one condition
The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.

There are two wildcards often used in conjunction with the LIKE operator:
 The percent sign % represents zero, one, or multiple characters
 The underscore sign _ represents one, single character*/
SELECT * FROM student
WHERE city = 'New York' AND name LIKE 'A%';

/*The AND operator displays a record if all the conditions are TRUE.

The OR operator displays a record if any of the conditions are TRUE.*/
SELECT * FROM student
WHERE City = 'New York' AND (name LIKE 'A%' OR name LIKE 'B%');

/*The NOT operator is used in combination with other operators to give the opposite result, also called the negative result.*/
SELECT * FROM student
WHERE NOT City = 'New York';

/*It is not possible to test for NULL values with comparison operators, such as =, <, or <>.

We will have to use the IS NULL and IS NOT NULL operators instead.
A NULL value is different from a zero value or a field that contains spaces
*/
SELECT *FROM student WHERE city IS  NULL;
SELECT *FROM student WHERE city IS NOT NULL;

/*The DELETE statement is used to delete existing records in a table.
The WHERE clause specifies which record(s) should be deleted,If you omit the WHERE clause, all records in the table will be deleted!*/
DELETE FROM student WHERE name='Alice' or city ='New York' or marks=95;
select * from student;

/*Error code 1175 in MySQL occurs when you're trying to execute an UPDATE or DELETE statement without a WHERE clause that includes a primary key or unique key. This is a safety feature to prevent accidental modification or deletion of a large number of rows.
To bypass this restriction, you can disable safe updates mode for your current session, but it's generally recommended to do so only if you are sure about your query's correctness
You can check if safe updates mode is enabled by running:*/
SELECT @@GLOBAL.sql_safe_updates, @@SESSION.sql_safe_updates;

/*You can disable safe updates mode for your session by executing*/
SET SQL_SAFE_UPDATES = 0;
/*After running your query, it's a good practice to re-enable safe updates mode*/
SET SQL_SAFE_UPDATES = 1;


/*the complete sequence of commands*/
-- Step 1: Disable safe updates mode
SET SQL_SAFE_UPDATES = 0;

-- Step 2: Run the DELETE query
DELETE FROM student WHERE name='Alice' OR city='New York' OR marks='95';

-- Step 3: Re-enable safe updates mode
SET SQL_SAFE_UPDATES = 1;

-- Step 4: Verify the deletion
SELECT * FROM student;


/*To delete the table completely, use the DROP TABLE statement*/
drop table student;

/*The SELECT TOP clause is used to specify the number of records to return.
The SELECT TOP clause is useful on large tables with thousands of records. Returning a large number of records can impact performance.
*/
SELECT * FROM student
LIMIT 4;


SELECT * FROM student
WHERE marks>=80
LIMIT 6;


SELECT * FROM student
ORDER BY name ASC
LIMIT 5;


/*Wildcard Characters
%	Represents zero or more characters.The % wildcard represents any number of characters, even zero characters.
_	Represents a single character.It can be any character or number, but each _ represents one, and only one, character.
[]	Represents any single character within the brackets *
^	Represents any character not in the brackets *
-	Represents any single character within the specified range *
{}	Represents any escaped character **
!	Represents any character not in the brackets	h[!oa]t finds hit, but not hot and hat
-	Represents any single character within the specified range	c[a-b]t finds cat and cbt
#	Represents any single numeric character	2#5 finds 205, 215, 225, 235, 245, 255, 265, 275, 285, and 295

* Not supported in PostgreSQL and MySQL databases.
** Supported only in Oracle databases.
*/


/*Any wildcard, like % and _ , can be used in combination with other wildcards.*/
SELECT * FROM student
WHERE name LIKE '_r%';

/*The IN operator allows you to specify multiple values in a WHERE clause.

The IN operator is a shorthand for multiple OR conditions.*/
SELECT * FROM student
WHERE city IN ('New York', 'Chicago', 'Dallas');

/*NOT IN
By using the NOT keyword in front of the IN operator, you return all records that are NOT any of the values in the list.*/
SELECT * FROM student
WHERE city NOT IN ('New York', 'Chicago', 'Dallas');

/*You can also use IN with a subquery in the WHERE clause.*/
SELECT * FROM student
WHERE UID IN (SELECT UID FROM student);

SELECT * FROM student
WHERE UID NOT IN (SELECT UID FROM student);


/*The BETWEEN operator selects values within a given range. The values can be numbers, text, or dates.
The BETWEEN operator is inclusive: begin and end values are included. */

SELECT * FROM student
WHERE marks BETWEEN 70 AND 90;

SELECT * FROM student WHERE UID BETWEEN 3 AND 7;


SELECT * FROM student
WHERE marks NOT BETWEEN 70 AND 90;

SELECT * FROM student WHERE UID BETWEEN 3 AND 7 AND city IN ('Chicago', 'Houston', 'Phoenix');

SELECT * FROM student WHERE name BETWEEN 'Charlie' AND 'Grace';

SELECT * FROM student WHERE name NOT BETWEEN 'Charlie' AND 'Grace';

SELECT * FROM student WHERE name NOT BETWEEN 'Charlie' AND 'Grace' AND city IN ('New York', 'Los Angeles', 'San Diego');

/*between dates*/
SELECT *
FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31';

SELECT * FROM orders
WHERE order_date BETWEEN '2022-01-01' AND '2022-03-31'
AND customer_id IN (1, 2, 3);



/*SQL Aliases
SQL aliases are used to give a table, or a column in a table, a temporary name.

Aliases are often used to make column names more readable.

An alias only exists for the duration of that query.

An alias is created with the AS keyword.*/


SELECT UID AS ID ,name AS N
FROM student;

SELECT name AS "my students"
FROM student;

/*Alias for Tables*/
SELECT * FROM student AS Persons;

/*Concatenate Columns:
The following SQL statement creates an alias named "Address" that combine four columns (Address, PostalCode, City and Country)*/
SELECT CONCAT(name, ', ', city) AS Location
FROM student;


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Customer 1'),
(2, 'Customer 2'),
(3, 'Customer 3'),
(4, 'Around the Horn');

INSERT INTO Orders (OrderID, OrderDate, CustomerID) VALUES
(101, '2024-05-01', 1),
(102, '2024-05-02', 2),
(103, '2024-05-03', 3),
(104, '2024-05-04', 4),
(105, '2024-05-05', 4);


SELECT o.OrderID, o.OrderDate, c.CustomerName
FROM Customers AS c, Orders AS o
WHERE c.CustomerName='Around the Horn' AND c.CustomerID=o.CustomerID;

/*joins*/
















