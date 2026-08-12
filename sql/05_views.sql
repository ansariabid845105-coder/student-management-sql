USE student_management;

CREATE OR REPLACE VIEW student_performance AS
SELECT
    s.student_id,
    s.roll_no,
    s.student_name,
    d.department_name,
    ROUND(AVG(m.marks), 2) AS average_marks,
    ROUND(AVG(a.attendance_percentage), 2) AS average_attendance
FROM students s
JOIN departments d ON s.department_id = d.department_id
LEFT JOIN marks m ON s.student_id = m.student_id
LEFT JOIN attendance a
    ON s.student_id = a.student_id
    AND m.course_id = a.course_id
GROUP BY
    s.student_id, s.roll_no, s.student_name, d.department_name;

SELECT * FROM student_performance
ORDER BY average_marks DESC;
