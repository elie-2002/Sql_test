# Primary School Database - README

## Overview

This **Primary School Database** is designed to manage information about students, teachers, classes, subjects, and grades. The database includes SQL commands to create the necessary tables, insert, update, delete records, perform queries using joins and subqueries, and manage transactions, as well as permissions. It leverages SQL operations such as DDL (Data Definition Language), DML (Data Manipulation Language), DCL (Data Control Language), and TCL (Transaction Control Language).

## Database Structure

The database consists of the following tables:

1. **Students**: Holds student details like name, gender, and birthdate.
2. **Teachers**: Stores teacher information along with their subject specialization.
3. **Classes**: Tracks the different classes, assigning teachers to them.
4. **Subjects**: Contains the various subjects taught at the school.
5. **Grades**: Holds student grade records for each subject and class.

### 1. **Students Table**:
```sql
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender CHAR(1),
    birthdate DATE
);
```

### 2. **Teachers Table**:
```sql
CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    subject_id INT,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);
```

### 3. **Classes Table**:
```sql
CREATE TABLE Classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);
```

### 4. **Subjects Table**:
```sql
CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50)
);
```

### 5. **Grades Table**:
```sql
CREATE TABLE Grades (
    grade_id INT PRIMARY KEY,
    student_id INT,
    class_id INT,
    subject_id INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);
```

## SQL Commands

### 1. **Inserting Data** (DML: Data Manipulation Language)
```sql
-- Inserting into Students table
INSERT INTO Students (student_id, first_name, last_name, gender, birthdate)
VALUES (1, 'John', 'Doe', 'M', '2012-01-12'),
       (2, 'Jane', 'Smith', 'F', '2011-05-22');

-- Inserting into Subjects table
INSERT INTO Subjects (subject_id, subject_name)
VALUES (1, 'Mathematics'), (2, 'Science'), (3, 'English');

-- Inserting into Teachers table
INSERT INTO Teachers (teacher_id, first_name, last_name, subject_id)
VALUES (1, 'Alice', 'Johnson', 1), (2, 'Bob', 'Brown', 2);

-- Inserting into Classes table
INSERT INTO Classes (class_id, class_name, teacher_id)
VALUES (1, 'Grade 1', 1), (2, 'Grade 2', 2);

-- Inserting into Grades table
INSERT INTO Grades (grade_id, student_id, class_id, subject_id, grade)
VALUES (1, 1, 1, 1, 'A'), (2, 2, 2, 2, 'B');
```

### 2. **Updating Data**:
```sql
-- Updating a student's last name
UPDATE Students
SET last_name = 'Doe Jr.'
WHERE student_id = 1;

-- Updating a grade record
UPDATE Grades
SET grade = 'A+'
WHERE grade_id = 1;
```

### 3. **Deleting Data**:
```sql
-- Deleting a student record
DELETE FROM Students
WHERE student_id = 2;

-- Deleting a grade record
DELETE FROM Grades
WHERE grade_id = 2;
```

### 4. **Joins** (Retrieving Related Data)
```sql
-- Join Students and Grades to get student grades
SELECT S.first_name, S.last_name, G.grade, Sub.subject_name
FROM Students S
JOIN Grades G ON S.student_id = G.student_id
JOIN Subjects Sub ON G.subject_id = Sub.subject_id;

-- Join Students, Classes, and Teachers to get class and teacher information
SELECT S.first_name AS student_name, C.class_name, T.first_name AS teacher_name, Sub.subject_name
FROM Students S
JOIN Grades G ON S.student_id = G.student_id
JOIN Classes C ON G.class_id = C.class_id
JOIN Teachers T ON C.teacher_id = T.teacher_id
JOIN Subjects Sub ON G.subject_id = Sub.subject_id;
```

### 5. **Subqueries**:
```sql
-- Find students with grades higher than 'B'
SELECT first_name, last_name 
FROM Students 
WHERE student_id IN (SELECT student_id FROM Grades WHERE grade > 'B');

-- Calculate average grade for Mathematics
SELECT AVG(grade)
FROM Grades
WHERE subject_id = (SELECT subject_id FROM Subjects WHERE subject_name = 'Mathematics');
```

### 6. **Transaction Control (TCL)**:
```sql
-- Begin a transaction
BEGIN;

-- Insert and update records
INSERT INTO Students (student_id, first_name, last_name, gender, birthdate)
VALUES (3, 'Sam', 'Wilson', 'M', '2011-11-02');

UPDATE Students
SET last_name = 'Williams'
WHERE student_id = 3;

-- Commit the transaction
COMMIT;

-- Rollback example
BEGIN;
UPDATE Students
SET last_name = 'Johnson'
WHERE student_id = 1;
ROLLBACK;
```

### 7. **Data Control (DCL)**:
```sql
-- Granting SELECT permission
GRANT SELECT ON Students TO public_user;

-- Revoking permission
REVOKE SELECT ON Students FROM public_user;
```

## How to Use This Database

1. **Create the Tables**: Use the DDL commands provided to create the tables in your database.
2. **Insert Data**: Use the `INSERT INTO` commands to populate the database with initial data.
3. **Update and Delete Data**: Modify or remove data using `UPDATE` and `DELETE` commands.
4. **Perform Queries**: Use the `JOIN`, `SELECT`, and subquery examples to retrieve data from multiple related tables.
5. **Manage Transactions**: Use TCL commands (`BEGIN`, `COMMIT`, `ROLLBACK`) to handle transactions securely.
6. **Control Access**: Use DCL commands to grant or revoke permissions for users.

This primary school database provides a simple yet flexible structure for managing school-related data.
