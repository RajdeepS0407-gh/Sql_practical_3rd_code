## Code Breakdown and Output
-_________________________________________________________________________________________________________-
1. Database Setup:

```sql
CREATE DATABASE college_demo;
USE college_demo;

--Explanation:
> CREATE DATABASE college_demo;: Creates a new database named college_demo.
> USE college_demo;: Sets college_demo as the active database for upcoming operations.
--Output:
> Query OK, 1 row affected (0.03 sec)
> Database changed
-_________________________________________________________________________________________________________-
2. Creating department Table:

```sql
CREATE TABLE department(
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) UNIQUE NOT NULL
);

--Explanation: Creates the department table.
              > dept_id: Unique identifier for each department (Primary Key).
              > dept_name: Name of department, up to 50 characters, must be unique and cannot be null.
--Output: Query OK, 0 rows affected (0.17 sec)
-_________________________________________________________________________________________________________-
3. Creating student Table:

```sql
CREATE TABLE student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

--Explanation: Creates the student table.
             > roll_no: Unique student roll number (Primary Key).
             > name: Student's name (Cannot be blank).
             > email: Unique email address.
             > FOREIGN KEY (dept_id): Links each student to a valid department in the department table.
--Output: Query OK, 0 rows affected (0.06 sec)
-_________________________________________________________________________________________________________-
4. Creating course Table:

```sql
CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

--Explanation: Creates the course table.
              > course_id: Unique ID for each course (Primary Key).
              > course_name: Name of the course (Cannot be blank).
              > FOREIGN KEY (dept_id): Connects the course to its offering department.
--Output: Query OK, 0 rows affected (0.04 sec)
-_________________________________________________________________________________________________________-
5. Creating enrollment Table:

```sql
CREATE TABLE enrollment (
    roll_no INT,
    course_id INT,
    semester INT CHECK (semester BETWEEN 1 and 8),
    grade CHAR(2),
    PRIMARY KEY (roll_no, course_id, semester),
    FOREIGN KEY (roll_no) REFERENCES student(roll_no),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

--Explanation: Creates a composite table linking students to courses.
               > semester: Must be a value between 1 and 8 (CHECK constraint).
               > PRIMARY KEY (roll_no, course_id, semester): Composite Primary Key ensuring a student cannot enroll in the same course twice in the same semester.
               > FOREIGN KEY: Ensures roll_no and course_id exist in their respective tables.
--Output: Query OK, 0 rows affected (0.05 sec)
-_________________________________________________________________________________________________________-
6. Inserting Data into Tables:

```sql
INSERT INTO department Values(1, 'Computer Science'), (2, 'Electronics');

INSERT INTO student Values(101, 'Nilisha', 'nilisha@mail.com', '123456789012', 1 );
INSERT INTO student Values(102, 'Rahul', 'rahul@mail.com', '987654321098', 2 );

INSERT INTO course Values(501, 'DBMS', 1 ),(502, 'Circuits', 2);

INSERT INTO enrollment Values (101, 501, 3, 'A');
INSERT INTO enrollment Values (101, 502, 3, 'B'); -- same student, different course; allowed

--Explanation:
> Populates tables with sample data while strictly matching foreign key references (e.g. dept_id 1 and 2 exist in department).
> Student 101 ('Nilisha') is enrolled in two different courses (DBMS & Circuits) in semester 3, which is allowed by the composite primary key (roll_no, course_id, semester).

--Output:
Query OK, 2 rows affected (0.01 sec)  -- department
Query OK, 1 row affected (0.01 sec)   -- student 101
Query OK, 1 row affected (0.01 sec)   -- student 102
Query OK, 2 rows affected (0.01 sec)  -- course
Query OK, 1 row affected (0.01 sec)   -- enrollment 101 (DBMS)
Query OK, 1 row affected (0.01 sec)   -- enrollment 101 (Circuits)
-_________________________________________________________________________________________________________-
7. Viewing Table Contents (Fetching Records):     

```sql
SELECT * FROM student;

--Explanation: Retrieves all student records to verify successful insertion.
--Output:
+---------+--------------+-------------------+---------+
| roll_no | name         | email             | dept_id |
+---------+--------------+-------------------+---------+
|     101 | Rahul Sharma | rahul@example.com |       1 |
|     102 | Priya Singh  | priya@example.com |       2 |
+---------+--------------+-------------------+---------+
2 rows in set (0.00 sec)
-_________________________________________________________________________________________________________-
8. Normalization Analysis (Normal Forms):

- 1NF (First Normal Form): YES. Every table column holds single, atomic values with no lists, arrays, or repeating groups.
- 2NF (Second Normal Form): YES. All non-key attributes depend on the entire primary key.
       In the `enrollment` table, `grade` depends on the full composite primary key (`roll_no`, `course_id`, `semester`).
- 3NF (Third Normal Form): YES. There are no transitive dependencies. Non-key columns (like `name` or `course_name`) depend only
       on their respective primary keys and not on other non-key columns.
- BCNF (Boyce-Codd Normal Form): YES. Every determinant in all tables (`dept_id`, `roll_no`, `course_id`, and
      (`roll_no, course_id, semester`) is a candidate key.

-_________________________________________________________________________________________________________-
                                                  --END--
