SELECT cat, [1] AS Jan, [2] AS Feb, [3] AS Mar, [4] AS Apr, [5] AS Mai, [6] AS Jun, [7] AS Jul, [8] AS Aug, [9] AS Sep, [10] AS Okt, [11] AS Nov, [12] AS Dece
FROM (
    SELECT DISTINCT MONTH(date) AS date,
           (CASE WHEN date = dat THEN SUM(Pointage.v_h_sv + Pointage.v_h_ch + (regul.montant / 1000)) ELSE SUM(Pointage.v_h_sv + Pointage.v_h_ch) END) AS Montant_global,
           sous_famille.cat AS cat
    FROM Pointage
    LEFT JOIN sous_famille ON LEFT(code_mat, 5) = code_sfamille
    LEFT JOIN regul ON date = dat AND LEFT(Pointage.code_mat, 5) = LEFT(regul.code_mat, 5)
    WHERE date BETWEEN '20220101' AND '20221201' AND cat IS NOT NULL
    GROUP BY cat, date, dat

    UNION 

    SELECT DISTINCT MONTH(date) AS date,
           0 AS Montant_global,
           sous_famille.cat AS cat
    FROM Pointage
    LEFT JOIN sous_famille ON LEFT(code_mat, 5) NOT IN (code_sfamille) AND cat IS NOT NULL
    WHERE YEAR(date) = 2022
    GROUP BY cat, DATE
) source
PIVOT (
    SUM(montant_global) FOR date IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
) AS pvtMonth
ORDER BY cat;
