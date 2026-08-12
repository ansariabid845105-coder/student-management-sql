USE student_management;

-- 1. Check invalid marks.
SELECT *
FROM marks
WHERE marks < 0 OR marks > 100;

-- 2. Check invalid attendance.
SELECT *
FROM attendance
WHERE attendance_percentage < 0
   OR attendance_percentage > 100;

-- 3. Check duplicate emails.
SELECT email, COUNT(*) AS occurrences
FROM students
GROUP BY email
HAVING COUNT(*) > 1;

-- 4. Check duplicate roll numbers.
SELECT roll_no, COUNT(*) AS occurrences
FROM students
GROUP BY roll_no
HAVING COUNT(*) > 1;

-- 5. Check orphan-style enrollment records.
SELECT e.*
FROM enrollments e
LEFT JOIN students s ON e.student_id = s.student_id
WHERE s.student_id IS NULL;

-- 6. Detect duplicate student-like records by name + email.
SELECT student_name, email, COUNT(*) AS occurrences
FROM students
GROUP BY student_name, email
HAVING COUNT(*) > 1;

-- The schema uses UNIQUE constraints to prevent duplicates at insertion time.
SHOW CREATE TABLE students;
