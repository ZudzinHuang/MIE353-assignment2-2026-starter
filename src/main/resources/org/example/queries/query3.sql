COPY (
    SELECT professor.firstName || ' ' || professor.lastName AS fullName
    FROM professor NATURAL JOIN teaches
    GROUP BY professor.profId, professor.firstName, professor.lastName
    HAVING COUNT(profId) = 1
) TO 'src/main/resources/data/output/query3.csv';