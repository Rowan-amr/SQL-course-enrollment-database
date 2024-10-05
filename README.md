# SQL-course-enrollment-database
The Student Course Enrollment System is a database-driven application designed to manage student enrollments in academic courses efficiently. This project allows educational institutions to handle student information, instructor details, course offerings, and enrollment records seamlessly.
# Student Course Enrollment System

This project is a simple database management system for handling student enrollments in various courses. It is designed to facilitate the management of students, instructors, courses, and their enrollments, providing functionalities for data retrieval and manipulation.

## Features

- Create, read, update, and delete (CRUD) operations for students, instructors, and courses.
- Manage student enrollments in different courses.
- Query capabilities to extract valuable insights such as:
  - Total number of students
  - Students enrolled in specific courses
  - Courses with a high number of enrollments
  - Average, minimum, and maximum enrollments per course
  - Age categorization of students

## Database Schema

The system consists of the following tables:

1. **students**: Stores student information including ID, name, email, and date of birth.
2. **instructors**: Stores instructor information including ID, name, and email.
3. **courses**: Contains course details such as ID, name, and description.
4. **enrollments**: Links students to courses and records enrollment dates.

### Table Structures

```sql
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
