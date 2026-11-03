CREATE VIEW transcriptSplit AS
SELECT studentId, courseId, grade,
       regexp_extract(courseId, '^([a-z]+)', 1) AS dept,
       CAST(regexp_extract(courseId, '^[a-z]+([0-9]+)', 1) AS INT) AS cnum
FROM transcript;

COPY (
    SELECT student.firstName || ' ' || student.lastName AS fullName,
           qualifying.dept AS department,
           '(' || low.courseId || ', ' || high.courseId || ')' AS courses,
           '(' || low.grade || ', ' || high.grade || ')' AS grades
    FROM (SELECT studentId, dept, MIN(cnum) AS lowNum, MAX(cnum) AS highNum
          FROM transcriptSplit
          GROUP BY studentId, dept
          HAVING MIN(cnum) < MAX(cnum)) qualifying,
         transcriptSplit low, transcriptSplit high, student
    WHERE low.studentId = qualifying.studentId AND low.dept = qualifying.dept AND low.cnum = qualifying.lowNum
      AND high.studentId = qualifying.studentId AND high.dept = qualifying.dept AND high.cnum = qualifying.highNum
      AND student.studentId = qualifying.studentId
      AND low.grade >= ALL (SELECT sameLow.grade FROM transcriptSplit sameLow
                            WHERE sameLow.studentId = low.studentId
                              AND sameLow.dept = low.dept AND sameLow.cnum = low.cnum)
      AND high.grade >= ALL (SELECT sameHigh.grade FROM transcriptSplit sameHigh
                             WHERE sameHigh.studentId = high.studentId
                               AND sameHigh.dept = high.dept AND sameHigh.cnum = high.cnum)
    ORDER BY fullName, department
) TO 'src/main/resources/data/output/query8.csv';