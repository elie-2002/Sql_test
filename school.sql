CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender CHAR(1),
    birthdate DATE
);

CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    subject_id INT,
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

CREATE TABLE Classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50)
);

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
-- Insert into Students table
INSERT INTO Students (student_id, first_name, last_name, gender, birthdate)
VALUES (1, 'John', 'Doe', 'M', '2012-01-12');

INSERT INTO Students (student_id, first_name, last_name, gender, birthdate)
VALUES (2, 'Jane', 'Smith', 'F', '2011-05-22');

-- Insert into Subjects table
INSERT INTO Subjects (subject_id, subject_name)
VALUES (1, 'Mathematics'), (2, 'Science'), (3, 'English');

-- Insert into Teachers table
INSERT INTO Teachers (teacher_id, first_name, last_name, subject_id)
VALUES (1, 'Alice', 'Johnson', 1), (2, 'Bob', 'Brown', 2);

-- Insert into Classes table
INSERT INTO Classes (class_id, class_name, teacher_id)
VALUES (1, 'Grade 1', 1), (2, 'Grade 2', 2);

-- Insert into Grades table
INSERT INTO Grades (grade_id, student_id, class_id, subject_id, grade)
VALUES (1, 1, 1, 1, 'A'), (2, 2, 2, 2, 'B');


-- Update student details
UPDATE Students
SET last_name = 'Doe Jr.'
WHERE student_id = 1;

-- Update grades
UPDATE Grades
SET grade = 'A+'
WHERE grade_id = 1;


-- Delete a student
DELETE FROM Students
WHERE student_id = 2;

-- Delete a grade record
DELETE FROM Grades
WHERE grade_id = 2;


-- Join Students and Grades to get student grades
SELECT S.first_name, S.last_name, G.grade, Sub.subject_name
FROM Students S
JOIN Grades G ON S.student_id = G.student_id
JOIN Subjects Sub ON G.subject_id = Sub.subject_id;

-- Join Students, Classes, and Teachers
SELECT S.first_name AS student_name, C.class_name, T.first_name AS teacher_name, Sub.subject_name
FROM Students S
JOIN Grades G ON S.student_id = G.student_id
JOIN Classes C ON G.class_id = C.class_id
JOIN Teachers T ON C.teacher_id = T.teacher_id
JOIN Subjects Sub ON G.subject_id = Sub.subject_id;


-- Find students who have a grade higher than 'B'
SELECT first_name, last_name 
FROM Students 
WHERE student_id IN (SELECT student_id FROM Grades WHERE grade > 'B');

-- Find the average grade for a specific subject
SELECT AVG(grade)
FROM Grades
WHERE subject_id = (SELECT subject_id FROM Subjects WHERE subject_name = 'Mathematics');
