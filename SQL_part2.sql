CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID) VALUES
(1, 'John', 'Doe', 1),
(2, 'Jane', 'Smith', 2),
(3, 'Alice', 'Johnson', 1),
(4, 'Bob', 'Jones', 3);

select * from Employee;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Manager');


select * from Departments;

/*INNER JOIN
The INNER JOIN keyword selects records that have matching values in both tables.
*/
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Departments.DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

/*LEFT JOIN:The LEFT JOIN keyword returns all records from the left table (table1), and the matching records from the right table (table2). The result is 0 records from the right side, if there is no match
The LEFT JOIN keyword ensures that all rows from the left table (Employees) are included in the result, regardless of whether there's a match in the right table (Departments).
If an employee doesn't have a corresponding department (i.e., their DepartmentID is NULL), the columns from the Departments table will contain NULL values in the result set.
*/

SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName, Departments.DepartmentName FROM Employees
LEFT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

-- example 2
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

INSERT INTO Students (StudentID, FirstName, LastName) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Johnson'),
(4, 'Bob', 'Jones');

CREATE TABLE Grades (
    GradeID INT PRIMARY KEY,
    StudentID INT,
    Grade INT
);

INSERT INTO Grades (GradeID, StudentID, Grade) VALUES
(101, 1, 85),
(102, 2, 90),
(103, 3, 78);
/*The LEFT JOIN ensures that all rows from the left table (Students) are included in the result, regardless of whether there's a match in the right table (Grades).*/
SELECT Students.StudentID, Students.FirstName, Students.LastName, Grades.Grade FROM Students
LEFT JOIN Grades ON Students.StudentID = Grades.StudentID;


/*The RIGHT JOIN keyword returns all records from the right table (table2), and the matching records from the left table (table1). The result is 0 records from the left side, if there is no match.
The RIGHT JOIN ensures that all rows from the right table (Grades) are included in the result, regardless of whether there's a match in the left table (Students).
*/
SELECT Students.StudentID, Students.FirstName, Students.LastName, Grades.Grade FROM Students
RIGHT JOIN Grades ON Students.StudentID = Grades.StudentID;



/*The FULL OUTER JOIN keyword returns all records when there is a match in left (table1) or right (table2) table records.
The FULL OUTER JOIN keyword returns all matching records from both tables whether the other table matches or not.*/
-- example 3
CREATE TABLE Employees2 (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT
);


INSERT INTO Employees2(EmployeeID, FirstName, LastName, DepartmentID) VALUES
(1, 'Elena', 'Gilbert', 1),
(2, 'Damon', 'Salvatore', 2),
(3, 'Stefan', 'Salvatore', NULL),
(4, 'Caroline', 'Forbes', 3),
(5, 'Bonnie', 'Bennett', 4);

CREATE TABLE Departments2 (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments2 (DepartmentID, DepartmentName) VALUES
(1, 'Engineering'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'HR'),
(5, 'Finance');

-- In MySQL, you can't directly use FULL OUTER JOIN.
SELECT Employees2.EmployeeID, Employees2.FirstName, Employees2.LastName, Departments2.DepartmentName
FROM Employees2
FULL JOIN Departments2 ON Employees2.DepartmentID = Departments2.DepartmentID
order by Employee2.FirstName;


-- In MySQL, you can't directly use FULL OUTER JOIN. Instead, you can simulate it using a combination of LEFT JOIN and RIGHT JOIN with UNION
SELECT Employees2.EmployeeID, Employees2.FirstName, Employees2.LastName, Departments2.DepartmentName
FROM Employees2
LEFT JOIN Departments2 ON Employees2.DepartmentID = Departments2.DepartmentID

UNION

SELECT Employees2.EmployeeID, Employees2.FirstName, Employees2.LastName, Departments2.DepartmentName
FROM Departments2
LEFT JOIN Employees2 ON Employees2.DepartmentID = Departments2.DepartmentID;



/*Self Join
A self join is a regular join, but the table is joined with itself.*/

CREATE TABLE Friends (
  id INT PRIMARY KEY AUTO_INCREMENT,  -- Add an auto-incrementing ID for each friend
  name VARCHAR(50) NOT NULL,
  favorite_book VARCHAR(100) NOT NULL
);
INSERT INTO Friends (name, favorite_book)
VALUES ('Alice', 'Pride and Prejudice'),
       ('Bob', 'The Lord of the Rings'),
       ('Charlie', 'The Hitchhiker\'s Guide to the Galaxy'),
       ('David', 'Pride and Prejudice'),
       ('Emily', 'The Martian');
-- with alias
SELECT f1.name AS friend1, f2.name AS friend2
FROM Friends f1
JOIN Friends f2 ON f1.favorite_book = f2.favorite_book
WHERE f1.id <> f2.id;  -- Exclude finding themself as a friend --<> is used for the not equal to comparison operator


-- without alias
SELECT Friends.name AS friend1, Friends.name AS friend2
FROM Friends
JOIN Friends  -- No aliases here
ON Friends.favorite_book = Friends.favorite_book
WHERE Friends.id <> Friends.id;  -- Exclude finding themself as a friend --<> is used for the not equal to comparison operator




/*union
UNION operator is used to combine the result-set of two or more SELECT statements.

Every SELECT statement within UNION must have the same number of columns
The columns must also have similar data types
The columns in every SELECT statement must also be in the same order
By default, UNION removes duplicate rows from the combined result set.
If you want to include duplicates, you can use UNION ALL instead of UNION.


*/

CREATE TABLE Employees3 (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

INSERT INTO Employees3 (EmployeeID, FirstName, LastName) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Johnson');

CREATE TABLE Managers (
    ManagerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

INSERT INTO Managers (ManagerID, FirstName, LastName) VALUES
(101, 'Michael', 'Scott'),
(102, 'Leslie', 'Knope');



SELECT FirstName, LastName
FROM Employees3
UNION
SELECT FirstName, LastName
FROM Managers;


SELECT FirstName, LastName
FROM Employees
UNION ALL
SELECT FirstName, LastName
FROM Managers;


-- union with where clause
CREATE TABLE employeesx (
  id INT,
  namess VARCHAR(50),
  department VARCHAR(50)
);
INSERT INTO employeesx (id, namess, department)
VALUES
  (1, 'John Doe', 'Sales'),
  (2, 'Jane Doe', 'Marketing'),
  (3, 'Bob Smith', 'IT');
CREATE TABLE managersx (
  id INT,
  namess VARCHAR(50),
  department VARCHAR(50)
);
ALTER TABLE managersx
ADD COLUMN namess VARCHAR(50);



INSERT INTO managersx (id, name, department)
VALUES
  (4, 'Alice Johnson', 'Sales'),
  (5, 'Mike Brown', 'Marketing'),
  (6, 'Emily Davis', 'IT');
  
  
SELECT id, namess, department
FROM employeesx
WHERE department = 'Sales'

UNION ALL

SELECT id, namess, department
FROM managersx
WHERE department = 'Sales';

-- using alias
SELECT ex.id, ex.namess, ex.department
FROM employeesx ex
WHERE ex.department = 'Sales'

UNION ALL

SELECT mx.id, mx.namess, mx.department
FROM managersx mx
WHERE mx.department = 'Sales';


/*
The GROUP BY statement groups rows that have the same values into summary/result rows.
The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns.
*/
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    amount DECIMAL(10, 2),
    sale_date DATE
);
INSERT INTO sales (sale_id, product_id, amount, sale_date) VALUES
(1, 101, 10.00, '2023-01-01'),
(2, 101, 20.00, '2023-01-02'),
(3, 102, 15.00, '2023-01-01'),
(4, 103, 25.00, '2023-01-02'),
(5, 102, 30.00, '2023-01-03'),
(6, 101, 50.00, '2023-01-03');

SELECT product_id, COUNT(*) AS sale_count
/* COUNT(*): This is an aggregate function that counts the number of rows in each group. The * means it counts all rows regardless of the content of the columns.
     AS sale_count: This is an alias. It renames the result of COUNT(*) to sale_count for better readability in the result set.*/
FROM sales
GROUP BY product_id;

SELECT product_id, SUM(amount) AS total_sales, COUNT(*) AS sale_count
FROM sales
GROUP BY product_id
ORDER BY sale_count DESC;


-- group by with join with above sales table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100)
);

INSERT INTO products (product_id, product_name) VALUES
(101, 'Product A'),
(102, 'Product B'),
(103, 'Product C');

SELECT p.product_id, p.product_name, SUM(s.amount) AS total_sales
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name;


/*The HAVING clause is used in SQL to filter rows returned by a GROUP BY*/
-- Example: Total Sales Amount for Each Product with Total Sales Greater Than 40
SELECT product_id, SUM(amount) AS total_sales
FROM sales
GROUP BY product_id
HAVING SUM(amount) > 40;


-- example 2
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2)
);
INSERT INTO Orders (OrderID, CustomerID, TotalAmount)
VALUES (1, 101, 200.50),
       (2, 102, 450.25),
       (3, 101, 300.75),
       (4, 103, 700.00),
       (5, 102, 100.00);

SELECT CustomerID, COUNT(OrderID) AS OrderCount, SUM(TotalAmount) AS TotalSpent
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 1 AND SUM(TotalAmount) > 500;



/*
EXISTS Operator
The EXISTS operator is used to test for the existence of any record in a subquery.

The EXISTS operator returns TRUE if the subquery returns one or more records.

The outer query retrieves data from a table or tables specified in the FROM clause.
The WHERE clause contains the EXISTS operator followed by a subquery.
The subquery is executed for each row in the outer query's result set.
If the subquery returns at least one row, the EXISTS operator evaluates to true, and the outer query includes the current row in its result set. Otherwise, it evaluates to false, and the row is excluded.


*/

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100)
);

INSERT INTO Customers (CustomerID, Name)
VALUES (1, 'John Doe'),
       (2, 'Jane Smith'),
       (3, 'Alice Johnson');

CREATE TABLE Orders2 (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
INSERT INTO Orders2 (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES (1, 1, '2024-05-20', 150.00),
       (2, 2, '2024-05-21', 200.50),
       (3, 1, '2024-05-22', 75.25),
       (4, 3, '2024-05-23', 300.00),
       (5, 2, '2024-05-24', 150.75);

SELECT CustomerID, Name
FROM Customers
WHERE EXISTS (
    SELECT *
    FROM Orders
    WHERE Orders.CustomerID = Customers.CustomerID
);

/*
Using "ANY": You're asking, "Is this single number greater than any number in the list?" If it's greater than at least one number in the list, the answer is "Yes."

Using "ALL": You're asking, "Is this single number greater than all numbers in the list?" It means the single number has to be greater than every number in the list for the answer to be "Yes."

In SQL, you can use these concepts to compare a value to a set of values returned by a subquery. For example, if you have a list of prices, you can use "ANY" to check if a price is greater than any price in the list, or "ALL" to check if it's greater than all prices in the list.


*/

CREATE TABLE Students1 (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100)
);


INSERT INTO Students1 (StudentID, Name)
VALUES (1, 'Alice'),
       (2, 'Bob'),
       (3, 'Charlie');


CREATE TABLE Scores (
    ScoreID INT PRIMARY KEY,
    StudentID INT,
    Subject VARCHAR(100),
    Score INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);


INSERT INTO Scores (ScoreID, StudentID, Subject, Score)
VALUES (1, 1, 'Math', 90),
       (2, 1, 'Science', 85),
       (3, 2, 'Math', 88),
       (4, 2, 'Science', 92),
       (5, 3, 'Math', 75),
       (6, 3, 'Science', 80);

-- ANY
SELECT Name
FROM Students1
WHERE StudentID = ANY (
    SELECT StudentID
    FROM Scores
    WHERE Subject = 'Math'
    AND Score > (SELECT MAX(Score) FROM Scores WHERE Subject = 'Math')
);


-- ALL
SELECT Name
FROM Students1
WHERE StudentID = ALL (
    SELECT StudentID
    FROM Scores
    WHERE Subject = 'Math'
    AND Score > (SELECT MAX(Score) FROM Scores WHERE Subject = 'Math')
);


/*
Insert SELECT INTO:
This statement copies data from one table into a new table.
The new table will be created with the column-names and types as defined in the old table. 
You can create new column names using the AS clause.



*/

CREATE TABLE Employees5 (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(100),
    Salary DECIMAL(10, 2)
);
INSERT INTO Employees5 (EmployeeID, Name, Department, Salary)
VALUES (1, 'John Doe', 'HR', 50000.00),
       (2, 'Alice Smith', 'IT', 60000.00),
       (3, 'Bob Johnson', 'Finance', 55000.00);

CREATE TABLE HighPaidEmployees (
    EmployeeID INT,
    Name VARCHAR(100),
    Department VARCHAR(100),
    Salary DECIMAL(10, 2)
);

INSERT INTO HighPaidEmployees
SELECT *
FROM Employees5
WHERE Salary > 55000.00;


select * from Employees5;
select * from HighPaidEmployees;


/*Select Into:creates a backup copy of Customers
-- uses the IN clause to copy the table into a new table in another database
-- copies only a few columns into a new table
-- copies data from more than one table into a new table
Tip: SELECT INTO can also be used to create a new, empty table using the schema of another. Just add a WHERE clause that causes the query to return no data:

SELECT * INTO newtable
FROM oldtable
WHERE 1 = 0;


*/

-- Create source_db database
CREATE DATABASE source_db;

-- Switch to source_db
USE source_db;

-- Create Employees table in source_db
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(100),
    Salary DECIMAL(10, 2)
);


-- Insert sample data into Employees table
INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES (1, 'John Doe', 'HR', 50000.00),
       (2, 'Alice Smith', 'IT', 60000.00),
       (3, 'Bob Johnson', 'Finance', 55000.00);


-- Create target_db database
CREATE DATABASE target_db;

-- Switch to target_db
USE target_db;

-- Create a new table in target_db with the same structure as Employees in source_db
CREATE TABLE HighPaidEmployees (
    EmployeeID INT,
    Name VARCHAR(100),
    Department VARCHAR(100),
    Salary DECIMAL(10, 2)
);

-- Insert data into HighPaidEmployees from Employees in source_db
INSERT INTO HighPaidEmployees
SELECT *
FROM source_db.Employees
WHERE Salary > 55000.00;


-- example2
-- Create source_db database
CREATE DATABASE source_db2;

-- Switch to source_db
USE source_db2;

-- Create Employees table in source_db2
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(100),
    Salary DECIMAL(10, 2)
);

-- Insert sample data into Employees table
INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES (1, 'John Doe', 'HR', 50000.00),
       (2, 'Alice Smith', 'IT', 60000.00),
       (3, 'Bob Johnson', 'Finance', 55000.00);

-- Create target_db database
CREATE DATABASE target_db2;

-- Switch to target_db
USE target_db2;

-- Create a new table with only the desired columns
CREATE TABLE EmployeesBasicInfo (
    EmployeeID INT,
    Name VARCHAR(100)
);

-- Insert data into EmployeesBasicInfo from Employees in source_db
INSERT INTO EmployeesBasicInfo (EmployeeID, Name)
SELECT EmployeeID, Name
FROM source_db.Employees;

select * from EmployeesBasicInfo;

-- example 3
-- Create Departments table in source_db
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

-- Insert sample data into Departments table
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (1, 'HR'),
       (2, 'IT'),
       (3, 'Finance');

-- Create target_db database if not already created
CREATE DATABASE IF NOT EXISTS target_db2;

-- Switch to target_db
USE target_db2;

-- Create a new table with combined data
CREATE TABLE EmployeeDepartmentInfo (
    EmployeeID INT,
    Name VARCHAR(100),
    DepartmentName VARCHAR(100)
);

-- Insert combined data into EmployeeDepartmentInfo from Employees and Departments in source_db
INSERT INTO EmployeeDepartmentInfo (EmployeeID, Name, DepartmentName)
SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM source_db2.Employees e
JOIN source_db2.Departments d ON e.Department = d.DepartmentName;

/*CASE:
The CASE expression goes through conditions and returns a value when the first condition is met (like an if-then-else statement). So, once a condition is true, it will stop reading and return the result. If no conditions are true, it returns the value in the ELSE clause.

If there is no ELSE part and no conditions are true, it returns NULL.

You can use CASE in SELECT, INSERT, UPDATE, and DELETE statements.
*/-- Step 1: Create the students table

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    score INT
);

-- Step 2: Insert sample data into the students table
INSERT INTO students (student_id, name, score) VALUES
(1, 'Alice', 85),
(2, 'Bob', 55),
(3, 'Charlie', 78),
(4, 'David', 92),
(5, 'Eve', 67);

SELECT * FROM students;

SELECT student_id, name, score,
       CASE
           WHEN score >= 90 THEN 'A'
           WHEN score >= 80 THEN 'B'
           WHEN score >= 70 THEN 'C'
           WHEN score >= 60 THEN 'D'
           ELSE 'F'
       END AS grade
FROM students;




/*Stored Procedure:Stored procedures in SQL are a way to encapsulate SQL code that you want to reuse
A stored procedure can include logic such as loops, conditional statements, and more.
*/

CREATE DATABASE IF NOT EXISTS my_database;
USE my_database;


DELIMITER $$

CREATE PROCEDURE CreateAndInsert()
BEGIN
    -- Create Employees table
    CREATE TABLE Employees9 (
        EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
        Name VARCHAR(100),
        Department VARCHAR(100),
        Salary DECIMAL(10, 2)
    );
    
    -- Insert data into Employees table
    INSERT INTO Employees9 (Name, Department, Salary)
    VALUES ('John Doe', 'HR', 50000.00),
           ('Alice Smith', 'IT', 60000.00),
           ('Bob Johnson', 'Finance', 55000.00);
END$$

DELIMITER ;


CALL CreateAndInsert();


SELECT * FROM Employees;


/*
The following constraints are commonly used in SQL
NOT NULL - Ensures that a column cannot have a NULL value
UNIQUE - Ensures that all values in a column are different
PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
FOREIGN KEY - Prevents actions that would destroy links between tables
CHECK - Ensures that the values in a column satisfies a specific condition
DEFAULT - Sets a default value for a column if no value is specified
CREATE INDEX - Used to create and retrieve data from the database very quickly
*/


/*Views:
 a view is a virtual table based on the result-set of an SQL statement.

A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database.

You can add SQL statements and functions to a view and present the data as if the data were coming from one single table.
*/
-- Create the database
CREATE DATABASE IF NOT EXISTS example_db;

-- Switch to the new database
USE example_db;

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Department VARCHAR(100),
    Salary DECIMAL(10, 2)
);

-- Insert sample data into Employees table
INSERT INTO Employees (Name, Department, Salary)
VALUES ('John Doe', 'HR', 50000.00),
       ('Alice Smith', 'IT', 60000.00),
       ('Bob Johnson', 'Finance', 55000.00),
       ('Mary Brown', 'IT', 70000.00),
       ('James Wilson', 'HR', 40000.00);

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100)
);

-- Insert sample data into Departments table
INSERT INTO Departments (DepartmentName)
VALUES ('HR'), ('IT'), ('Finance');

-- Create the view
CREATE VIEW EmployeeDetails AS
SELECT 
    e.EmployeeID,
    e.Name,
    e.Department,
    d.DepartmentName
FROM 
    Employees e
JOIN 
    Departments d ON e.Department = d.DepartmentName;
    
-- Select data from the view
SELECT * FROM EmployeeDetails;























