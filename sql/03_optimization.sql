USE student_management;

-- Add indexes for frequently searched/joined columns.
CREATE INDEX idx_students_department ON students(department_id);
CREATE INDEX idx_marks_student ON marks(student_id);
CREATE INDEX idx_marks_course ON marks(course_id);
CREATE INDEX idx_attendance_student ON attendance(student_id);
CREATE INDEX idx_enrollments_course ON enrollments(course_id);

-- Use EXPLAIN to inspect a query execution plan.
EXPLAIN
SELECT s.student_name, c.course_name, m.marks
FROM marks m
JOIN students s ON m.student_id = s.student_id
JOIN courses c ON m.course_id = c.course_id
WHERE m.marks > 80;

-- Check indexes.
SHOW INDEX FROM students;
SHOW INDEX FROM marks;

-- Example of selecting only required columns instead of SELECT *.
SELECT student_id, student_name, email
FROM students
WHERE department_id = 1;
