DROP DATABASE IF EXISTS student_management;
CREATE DATABASE student_management;
USE student_management;

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    roll_no VARCHAR(30) NOT NULL UNIQUE,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    admission_year YEAR NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE (student_id, course_id)
);

CREATE TABLE marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    marks DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE (student_id, course_id)
);

CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    attendance_percentage DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE (student_id, course_id)
);

CREATE TABLE fees (
    fee_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    total_fee DECIMAL(10,2) NOT NULL,
    paid_fee DECIMAL(10,2) NOT NULL DEFAULT 0,
    due_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO departments (department_name) VALUES
('Computer Science'),
('Information Technology'),
('Electronics'),
('Mechanical');

INSERT INTO teachers (teacher_name, email, department_id) VALUES
('Amit Sharma', 'amit@college.edu', 1),
('Neha Singh', 'neha@college.edu', 1),
('Rahul Verma', 'rahul@college.edu', 2),
('Priya Mehta', 'priya@college.edu', 3),
('Vikas Kumar', 'vikas@college.edu', 4);

INSERT INTO students
(roll_no, student_name, email, admission_year, department_id) VALUES
('CSE001', 'Arjun Kumar', 'arjun@college.edu', 2025, 1),
('CSE002', 'Riya Singh', 'riya@college.edu', 2025, 1),
('CSE003', 'Aman Gupta', 'aman@college.edu', 2025, 1),
('CSE004', 'Sara Khan', 'sara@college.edu', 2025, 1),
('CSE005', 'Mohit Verma', 'mohit@college.edu', 2025, 1),
('IT001', 'Karan Patel', 'karan@college.edu', 2025, 2),
('IT002', 'Anjali Rao', 'anjali@college.edu', 2025, 2),
('ECE001', 'Dev Singh', 'dev@college.edu', 2025, 3),
('ME001', 'Pooja Sharma', 'pooja@college.edu', 2025, 4),
('ME002', 'Rohan Das', 'rohan@college.edu', 2025, 4);

INSERT INTO courses
(course_code, course_name, credits, teacher_id) VALUES
('CSE101', 'Programming Fundamentals', 4, 1),
('CSE102', 'Database Management Systems', 4, 2),
('CSE103', 'Data Structures', 4, 1),
('IT101', 'Web Development', 3, 3),
('ECE101', 'Digital Electronics', 3, 4),
('ME101', 'Engineering Mechanics', 3, 5);

INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1,1,'2025-08-10'), (1,2,'2025-08-10'), (1,3,'2025-08-10'),
(2,1,'2025-08-10'), (2,2,'2025-08-10'), (2,3,'2025-08-10'),
(3,1,'2025-08-10'), (3,2,'2025-08-10'), (3,3,'2025-08-10'),
(4,1,'2025-08-10'), (4,2,'2025-08-10'),
(5,1,'2025-08-10'), (5,2,'2025-08-10'),
(6,4,'2025-08-10'), (7,4,'2025-08-10'),
(8,5,'2025-08-10'),
(9,6,'2025-08-10'), (10,6,'2025-08-10');

INSERT INTO marks (student_id, course_id, marks) VALUES
(1,1,88),(1,2,91),(1,3,84),
(2,1,79),(2,2,86),(2,3,90),
(3,1,72),(3,2,68),(3,3,75),
(4,1,93),(4,2,95),
(5,1,61),(5,2,70),
(6,4,82),(7,4,89),(8,5,77),(9,6,73),(10,6,66);

INSERT INTO attendance
(student_id, course_id, attendance_percentage) VALUES
(1,1,92),(1,2,88),(1,3,91),
(2,1,86),(2,2,82),(2,3,90),
(3,1,72),(3,2,69),(3,3,78),
(4,1,95),(4,2,93),
(5,1,68),(5,2,74),
(6,4,88),(7,4,91),(8,5,80),(9,6,76),(10,6,71);

INSERT INTO fees (student_id, total_fee, paid_fee, due_date) VALUES
(1,120000,120000,'2026-01-15'),
(2,120000,100000,'2026-01-15'),
(3,120000,80000,'2026-01-15'),
(4,120000,120000,'2026-01-15'),
(5,120000,60000,'2026-01-15'),
(6,110000,110000,'2026-01-15'),
(7,110000,90000,'2026-01-15'),
(8,115000,115000,'2026-01-15'),
(9,105000,70000,'2026-01-15'),
(10,105000,105000,'2026-01-15');
