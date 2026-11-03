COPY (
    SELECT student.firstName || ' ' || student.lastName AS fullName
    FROM student
    WHERE EXISTS (
        SELECT * FROM transcript NATURAL JOIN course
        WHERE transcript.studentId = student.studentId AND course.courseName = 'Data Modelling'
    )
    AND EXISTS (
        SELECT * FROM transcript NATURAL JOIN course
        WHERE transcript.studentId = student.studentId AND course.courseName != 'Data Modelling' AND transcript.grade >= 90
    )
) TO 'src/main/resources/data/output/query6.csv';