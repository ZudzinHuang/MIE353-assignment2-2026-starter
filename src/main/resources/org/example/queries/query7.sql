COPY (
    SELECT
        s1.firstName || ' ' || s1.lastName AS student1,
        s2.firstName || ' ' || s2.lastName AS student2,
        COUNT(*) AS coursesInCommon,
        AVG(t1.grade) AS student1Avg,
        AVG(t2.grade) AS student2Avg
    FROM transcript t1
    JOIN transcript t2 ON t1.courseId = t2.courseId AND t1.studentId < t2.studentId
    JOIN student s1 ON s1.studentId = t1.studentId
    JOIN student s2 ON s2.studentId = t2.studentId
    GROUP BY t1.studentId, t2.studentId, s1.firstName, s1.lastName, s2.firstName, s2.lastName
    HAVING COUNT(*) >= 3
) TO 'src/main/resources/data/output/query7.csv';