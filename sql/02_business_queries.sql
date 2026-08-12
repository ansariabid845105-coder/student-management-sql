USE student_management;

-- 1. Display all students with their department.
SELECT s.roll_no, s.student_name, d.department_name
FROM students s
JOIN departments d ON s.department_id = d.department_id;

-- 2. Top 5 students by average marks.
SELECT s.student_name, ROUND(AVG(m.marks),2) AS average_marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name
ORDER BY average_marks DESC
LIMIT 5;

-- 3. Students with attendance below 75%.
SELECT s.student_name, c.course_name, a.attendance_percentage
FROM attendance a
JOIN students s ON a.student_id = s.student_id
JOIN courses c ON a.course_id = c.course_id
WHERE a.attendance_percentage < 75;

-- 4. Average marks by department.
SELECT d.department_name, ROUND(AVG(m.marks),2) AS avg_marks
FROM departments d
JOIN students s ON d.department_id = s.department_id
JOIN marks m ON s.student_id = m.student_id
GROUP BY d.department_id, d.department_name
ORDER BY avg_marks DESC;

-- 5. Course-wise average marks.
SELECT c.course_name, ROUND(AVG(m.marks),2) AS avg_marks
FROM courses c
JOIN marks m ON c.course_id = m.course_id
GROUP BY c.course_id, c.course_name;

-- 6. Most popular courses.
SELECT c.course_name, COUNT(e.student_id) AS enrolled_students
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY enrolled_students DESC;

-- 7. Students scoring above the overall average.
SELECT s.student_name, m.marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
WHERE m.marks > (SELECT AVG(marks) FROM marks)
ORDER BY m.marks DESC;

-- 8. Students with unpaid fees.
SELECT s.student_name, f.total_fee, f.paid_fee,
       (f.total_fee - f.paid_fee) AS outstanding
FROM students s
JOIN fees f ON s.student_id = f.student_id
WHERE f.paid_fee < f.total_fee
ORDER BY outstanding DESC;

-- 9. Number of students per department.
SELECT d.department_name, COUNT(s.student_id) AS student_count
FROM departments d
LEFT JOIN students s ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name;

-- 10. Students who are enrolled in more than one course.
SELECT s.student_name, COUNT(e.course_id) AS course_count
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name
HAVING COUNT(e.course_id) > 1;

-- 11. Highest mark in every course using a CTE.
WITH course_max AS (
    SELECT course_id, MAX(marks) AS highest_marks
    FROM marks
    GROUP BY course_id
)
SELECT c.course_name, s.student_name, m.marks
FROM marks m
JOIN course_max cm
  ON m.course_id = cm.course_id AND m.marks = cm.highest_marks
JOIN courses c ON m.course_id = c.course_id
JOIN students s ON m.student_id = s.student_id;

-- 12. Students whose marks are above their course average.
SELECT s.student_name, c.course_name, m.marks
FROM marks m
JOIN students s ON m.student_id = s.student_id
JOIN courses c ON m.course_id = c.course_id
WHERE m.marks > (
    SELECT AVG(m2.marks)
    FROM marks m2
    WHERE m2.course_id = m.course_id
);

-- 13. Count passed and failed records.
SELECT
    CASE WHEN marks >= 40 THEN 'Pass' ELSE 'Fail' END AS result,
    COUNT(*) AS total
FROM marks
GROUP BY CASE WHEN marks >= 40 THEN 'Pass' ELSE 'Fail' END;

-- 14. Students with no outstanding fees.
SELECT s.student_name
FROM students s
JOIN fees f ON s.student_id = f.student_id
WHERE f.paid_fee >= f.total_fee;

-- 15. Course teacher mapping.
SELECT c.course_code, c.course_name, t.teacher_name
FROM courses c
LEFT JOIN teachers t ON c.teacher_id = t.teacher_id
ORDER BY c.course_code;
