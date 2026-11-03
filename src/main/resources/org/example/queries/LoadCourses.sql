CREATE TABLE IF NOT EXISTS course (
    courseId   VARCHAR(20) PRIMARY KEY,
    courseName VARCHAR(255) NOT NULL,
    gradCourse INT NOT NULL CHECK (gradCourse >= 0 AND gradCourse <= 2)
);
COPY course FROM 'src/main/resources/data/courses.csv';