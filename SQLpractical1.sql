mysql> CREATE DATABASE college_demo;
Query OK, 1 row affected (0.03 sec)

mysql> USE college_demo;
Database changed
mysql> CREATE TABLE department(
    -> dept_id INT PRIMARY KEY,
    -> dept_name VARCHAR(50) UNIQUE NOT NULL
    -> );
Query OK, 0 rows affected (0.17 sec)

mysql> CREATE TABLE student (
    -> roll_no INT PRIMARY KEY,
    -> name VARCHAR(50) NOT NULL,
    -> email VARCHAR(50) UNIQUE,
    -> dept_id INT,
    -> FOREIGN KEY (dept_id) REFERENCES department(dept_id)
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> CREATE TABLE course (
    -> course_id INT PRIMARY KEY,
    -> course_name VARCHAR(50) NOT NULL,
    -> dept_id INT,
    -> FOREIGN KEY (dept_id) REFERENCES department(dept_id)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> CREATE TABLE enrollment (
    -> roll_no INT,
    -> course_id INT,
    -> semester INT CHECK (semester BETWEEN 1 and 8),
    -> grade CHAR(2),
    -> PRIMARY KEY (roll_no, course_id, semester),
    -> FOREIGN KEY (roll_no) REFERENCES student(roll_no),
    -> FOREIGN KEY (course_id) REFERENCES course(course_id)
    -> );

mysql> INSERT INTO department Values(1, 'Computer Science'), (2, 'Electronics');

     ->  INSERT INTO student Values(101, 'Nilisha', 'nilisha@mail.com', '123456789012', 1 );
     ->  INSERT INTO student Values(102, 'Rahul', 'rahul@mail.com', '987654321098', 2 );

     -> INSERT INTO course Values(501, 'DBMS', 1 ),(502, 'Circuits', 2);

     ->  INSERT INTO enrollment Values (101, 501, 3, 'A');
     ->  INSERT INTO enrollment Values (101, 502, 3, 'B'); -- same student, different course; allowed
