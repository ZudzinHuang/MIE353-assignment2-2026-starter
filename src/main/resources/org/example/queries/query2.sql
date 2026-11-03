COPY (
    SELECT DISTINCT courseName
    FROM course
    WHERE courseId LIKE '___4_____'
) TO 'src/main/resources/data/output/query2.csv';