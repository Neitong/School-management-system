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

CREATE TABLE Enrollments(
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(1) CHECK (grade IN ('A', 'B', 'C', 'D', 'F') OR grade IS NULL),
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);