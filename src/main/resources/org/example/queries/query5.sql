COPY (
    SELECT professor.firstName || ' ' || professor.lastName AS fullName
    FROM professor
    WHERE EXISTS (
        SELECT * FROM teaches
        WHERE teaches.profId = professor.profId
    )
    AND NOT EXISTS (
        SELECT * FROM teaches
        JOIN transcript ON transcript.courseId = teaches.courseId
        WHERE teaches.profId = professor.profId AND transcript.grade <= 49
    )
) TO 'src/main/resources/data/output/query5.csv';