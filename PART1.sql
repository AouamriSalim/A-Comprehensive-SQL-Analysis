SELECT DISTINCT sous_famille.cat AS cat, 
       SUM(Pointage.v_h_sv + Pointage.v_h_ch) AS Montant_global, 
       date AS date
FROM Pointage 
LEFT JOIN sous_famille ON LEFT(Pointage.code_mat, 5) = sous_famille.code_sfamille
WHERE YEAR(date) = 2022 AND cat IS NOT NULL
GROUP BY cat, date

UNION 

SELECT DISTINCT sous_famille.cat AS cat, 
       0 AS Montant_global, 
       DATE AS DATE
FROM Pointage 
LEFT JOIN sous_famille ON LEFT(Pointage.code_mat, 5) <> (code_sfamille) AND cat IS NOT NULL
WHERE YEAR(date) = 2022
GROUP BY cat, DATE

ORDER BY cat, DATE;
