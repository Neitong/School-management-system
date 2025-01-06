# School Management System

## Instruction

### The school management system requires three main tables:

- **Students**: The Students table should store student information including student ID as the primary key, first name, last name, date of birth, email (which must be unique), and enrollment date.

- **Courses**: The Courses table needs to contain course ID as the primary key, course name, number of credits (between 1-6), department name, and maximum number of allowed students (must be a positive number between 10 and 100).

- **Enrollments**: The Enrollments table acts as a junction table connecting students and courses, containing both student ID and course ID as foreign keys referencing their respective tables, along with enrollment date and grade (which can be null but must be either A, B, C, D, or F when provided).

The system should ensure that a student cannot enroll in the same course twice and that all students must be at least 16 years old based on their date of birth.

---

### What relationship is Students to Enrollments table?
**Students to Enrollments**: One-to-many. A student can enroll in multiple courses, but each enrollment record belongs to only one student.

### What relationship is Students to Courses table?
**Students to Courses**: Many-to-many. Each student can enroll in multiple courses, and each course can have multiple students enrolled.

### If we want students to enroll only in one course, what can we change inside the database to achieve that?
To ensure that students can enroll in only one course, we can add a unique constraint on the student ID in the Enrollments table. This will prevent a student from having multiple entries in the Enrollments table.

---

### SQL Code to Create the Database

```sql
CREATE DATABASE School_management_system;

USE School_management_system;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    enrollment_date DATE NOT NULL
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT CHECK (credits BETWEEN 1 AND 6),
    department_name VARCHAR(100) NOT NULL,
    max_students INT CHECK (max_students BETWEEN 10 AND 100)
);

CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(1) CHECK (grade IN ('A', 'B', 'C', 'D', 'F') OR grade IS NULL),
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
```

## Show results table

### School management system

```
MariaDB [School_management_system]> SHOW TABLES;
+------------------------------------+
| Tables_in_school_management_system |
+------------------------------------+
| courses                            |
| enrollments                        |
| students                           |
+------------------------------------+
3 rows in set (0.003 sec)
```

### Students table
```
MariaDB [School_management_system]> SELECT * FROM Students;
+------------+------------+-----------+---------------+----------------------+-----------------+
| student_id | first_name | last_name | date_of_birth | email                | enrollment_date |
+------------+------------+-----------+---------------+----------------------+-----------------+
|          1 | Nei        | Tong      | 2005-04-14    | neitong@student.cadt | 2025-01-10      |
+------------+------------+-----------+---------------+----------------------+-----------------+
1 row in set (0.001 sec)

MariaDB [School_management_system]> INSERT INTO Students(student_id, first_name, last_name, date_of_birth, email, enrollment_date)
    -> VALUES(2, 'Srey', 'Nich', '2004-10-15', 'sreynich@student.cadt', '2025-01-10'),
    -> (3, 'Ra', 'Fat', '2006-04-14', 'rafat@student.cadt', '2025-01-10');
Query OK, 2 rows affected (0.002 sec)
Records: 2  Duplicates: 0  Warnings: 0

MariaDB [School_management_system]> SELECT * FROM Students;
+------------+------------+-----------+---------------+-----------------------+-----------------+
| student_id | first_name | last_name | date_of_birth | email                 | enrollment_date |
+------------+------------+-----------+---------------+-----------------------+-----------------+
|          1 | Nei        | Tong      | 2005-04-14    | neitong@student.cadt  | 2025-01-10      |
|          2 | Srey       | Nich      | 2004-10-15    | sreynich@student.cadt | 2025-01-10      |
|          3 | Ra         | Fat       | 2006-04-14    | rafat@student.cadt    | 2025-01-10      |
+------------+------------+-----------+---------------+-----------------------+-----------------+
3 rows in set (0.001 sec)
```

### Courses table	
```
MariaDB [School_management_system]> SELECT * FROM Courses;  
+-----------+-------------------+---------+--------------------------------------+--------------+
| course_id | course_name       | credits | department_name                      | max_students |
+-----------+-------------------+---------+--------------------------------------+--------------+
|         1 | OOP               |       3 | Computer Science                     |          100 |
|         2 | Operating System  |       3 | Computer Science                     |          100 |
|         3 | Design Database   |       3 | Computer Science                     |          100 |
|         4 | Graphic Design    |       3 | Ecommerce                            |          100 |
|         5 | Digital Marketing |       3 | Ecommerce                            |          100 |
|         6 | Machine Learning  |       3 | Computer Science                     |          100 |
|         7 | Networking        |       3 | Telecommunication & Cyber Securities |          100 |
|         8 | Basic Hacking     |       3 | Telecommunication & Cyber Securities |          100 |
|         9 | Advanced Hacking  |       3 | Telecommunication & Cyber Securities |          100 |
|        10 | Web Application   |       3 | Computer Science                     |          100 |
+-----------+-------------------+---------+--------------------------------------+--------------+
10 rows in set (0.001 sec)
```

### Enrollments table
```
MariaDB [School_management_system]> SELECT * FROM Enrollments; 
+---------------+------------+-----------+-----------------+-------+
| enrollment_id | student_id | course_id | enrollment_date | grade |
+---------------+------------+-----------+-----------------+-------+
|             1 |          1 |         1 | 2025-04-10      | A     |
+---------------+------------+-----------+-----------------+-------+
1 row in set (0.001 sec)
```



