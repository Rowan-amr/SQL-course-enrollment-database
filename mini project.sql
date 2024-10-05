CREATE TABLE students(
    student_id SERIAL PRIMARY KEY, 
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    date_of_birth DATE
);
CREATE TABLE instructors (
    instructor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    course_description TEXT
);
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE,
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES students (student_id) ON DELETE CASCADE,
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses (course_id) ON DELETE CASCADE
);

INSERT INTO students (first_name, email, date_of_birth)
VALUES 
('John', 'john.doe@example.com', '2000-05-15'),
('Jane', 'jane.smith@example.com', '1998-11-20'),
('Mark', 'mark.johnson@example.com', '1999-01-10'),
('Emily', 'emily.davis@example.com', '2001-03-12'),
('Daniel', 'daniel.white@example.com', '1997-07-08'),
('Sophia', 'sophia.lee@example.com', '2000-09-14'),
('Chris', 'chris.martin@example.com', '1998-12-03'),
('Anna', 'anna.brown@example.com', '1999-02-22'),
('David', 'david.miller@example.com', '2001-06-05'),
('Sarah', 'sarah.jones@example.com', '1997-08-19');


INSERT INTO courses (course_name, course_description)
VALUES 
('Database Systems', 'Introduction to relational databases and SQL'),
('Web Development', 'Learn the basics of HTML, CSS, and JavaScript'),
('Machine Learning', 'Introduction to supervised and unsupervised learning'),
('Data Structures', 'Learn about arrays, stacks, queues, and trees'),
('Computer Networks', 'Basics of networking, protocols, and security');



INSERT INTO instructors (first_name, last_name, email)
VALUES 
('Alice', 'Wright', 'alice.wright@example.com'),
('Bob', 'Taylor', 'bob.taylor@example.com'),
('Carol', 'Anderson', 'carol.anderson@example.com');




INSERT INTO enrollments (student_id, course_id, enrollment_date)
VALUES 
(11, 6, '2024-01-10'),
(12, 6, '2024-01-15'),
(13, 7, '2024-01-20'),
(14, 8, '2024-01-25'),
(15, 8, '2024-02-05'),
(16, 9, '2024-02-10'),
(17, 10, '2024-02-15'),
(18, 9, '2024-02-20'),
(19, 7, '2024-03-01'),
(20, 6, '2024-03-05'),
(11, 8, '2024-03-10'),
(12, 9, '2024-03-15'),
(13, 10, '2024-03-20'),
(14, 7, '2024-03-25'),
(15, 6, '2024-04-01');





-- select all students
select * from students;
--select all courses
SELECT * FROM courses;

--select all enrollments and student names with courses names
select * from enrollments;
SELECT 
    e.enrollment_id, 
    s.first_name, 
    c.course_name
FROM enrollments AS e
JOIN students AS s ON e.student_id = s.student_id
JOIN courses AS c ON c.course_id = e.course_id;


-- select student names who  are enrolled in web development course
SELECT first_name
FROM students as s
JOIN enrollments as e on e.student_id = s.student_id
WHERE course_id = 7

--select courses who has 4 or more enrollments
SELECT course_name from courses c
join enrollments e on c.course_id = e.course_id
group by c.course_name 
having count(e.student_id) >=4;

--update email student
UPDATE students
SET email = ('jane.smith@outlook.com')
WHERE student_id = 12 

--calculate average age for students
SELECT AVG(EXTRACT(YEAR FROM AGE(date_of_birth))) AS age
FROM students;

--select course which has mac number of students
SELECT course_name 
FROM courses c
JOIN enrollments e
on c.course_id = e.course_id 
GROUP BY course_name
ORDER BY COUNT(e.student_id) DESC
LIMIT 1;



-- sort courses by count student numbers 
SELECT course_name 
FROM courses c
JOIN enrollments e
on c.course_id = e.course_id 
GROUP BY course_name
ORDER BY COUNT(e.student_id) DESC;

--select number of courses each student enrolled in 
SELECT first_name, count(e.course_id) as course_count
from students s 
join enrollments e 
on s.student_id = e.student_id 
group by first_name
HAVING COUNT(e.course_id) > 1;


--calculate avg, min and max enrollments for 
SELECT 
    AVG(enrollment_count) AS average_enrollments,
    MIN(enrollment_count) AS minimum_enrollments,
    MAX(enrollment_count) AS maximum_enrollments
FROM (
    SELECT course_id, COUNT(student_id) AS enrollment_count
    FROM enrollments
    GROUP BY course_id
) AS course_enrollments;



--select top 3 students who has max  enrollments
select first_name, count(e.course_id) as courses_number 
from students s 
join enrollments e 
on s.student_id = e.student_id 
group by s.first_name
order by courses_number DESC
limit 3;



--union between two queries 


select s.first_name 
from students s 
UNION
select c.course_name
from courses c; 


--function
CREATE OR REPLACE PROCEDURE add_student(
    p_first_name VARCHAR(50),
    p_email VARCHAR(150),
    p_date_of_birth DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO students (first_name, email, date_of_birth)
    VALUES (p_first_name, p_email, p_date_of_birth);
END;
$$;


CALL add_student('Rowan', 'rowanamr@hotmail.com', '2009-09-19');


-- Aggreagate functions 
--select total number of students
SELECT COUNT(student_id) as total_students
from students



SELECT 
    c.course_name
FROM 
    courses c
WHERE 
    EXISTS (
        SELECT 1
        FROM enrollments e
        WHERE e.course_id = c.course_id
    );


SELECT 
    first_name,
    date_of_birth,
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(date_of_birth)) < 18 THEN 'Young'
        WHEN EXTRACT(YEAR FROM AGE(date_of_birth)) BETWEEN 18 AND 64 THEN 'Adult'
        ELSE 'Senior'
    END AS age_category
FROM 
    students;



