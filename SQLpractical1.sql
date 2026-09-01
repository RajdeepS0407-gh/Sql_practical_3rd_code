DROP DATABASE IF EXISTS college_demo;
CREATE DATABASE college_demo;

USE college_demo;

SELECT @@transaction_isolation;
    
CREATE TABLE department(
     dept_id INT PRIMARY KEY,
     dept_name VARCHAR(50) UNIQUE NOT NULL
     );

CREATE TABLE student (
     roll_no INT PRIMARY KEY,
     name VARCHAR(50) NOT NULL,
     email VARCHAR(50) UNIQUE,
     phone VARCHAR(15),
     dept_id INT,
     FOREIGN KEY (dept_id) REFERENCES department(dept_id)
     );

CREATE INDEX idx_student_dept ON student(dept_id);


CREATE TABLE course (
     course_id INT PRIMARY KEY,
     course_name VARCHAR(50) NOT NULL,
     dept_id INT,
     FOREIGN KEY (dept_id) REFERENCES department(dept_id)
     );

CREATE TABLE enrollment (
     roll_no INT,
     course_id INT,
     semester INT CHECK (semester BETWEEN 1 and 8),
     grade CHAR(2),
     PRIMARY KEY (roll_no, course_id, semester),
     FOREIGN KEY (roll_no) REFERENCES student(roll_no),
     FOREIGN KEY (course_id) REFERENCES course(course_id)
     );

INSERT INTO department Values(1, 'Computer Science'), (2, 'Electronics');

       INSERT INTO student Values(101, 'Nilisha', 'nilisha@mail.com', '123456789012', 1 );
       INSERT INTO student Values(102, 'Rahul', 'rahul@mail.com', '987654321098', 2 );

       INSERT INTO course Values(501, 'DBMS', 1 ),(502, 'Circuits', 2);

       INSERT INTO enrollment Values (101, 501, 3, 'A');
       INSERT INTO enrollment Values (101, 502, 3, 'B'); -- same student, different course; allowed

SELECT * FROM department;
       SELECT * FROM course;
       SELECT * FROM enrollment;
       SELECT * FROM student;
