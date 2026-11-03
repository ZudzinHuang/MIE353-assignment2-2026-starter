COPY (
    SELECT DISTINCT professor.firstName || ' ' || professor.lastName AS fullName
    FROM professor NATURAL JOIN teaches NATURAL JOIN transcript
    JOIN student ON student.studentId = transcript.studentId
    WHERE student.firstName = 'Rebecca' AND student.lastName = 'Ward'
) TO 'src/main/resources/data/output/query4.csv';