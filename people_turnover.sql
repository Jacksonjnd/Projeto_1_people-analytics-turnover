-- Validação: Total de registros
SELECT
    COUNT(*) AS total_registros
FROM hr_employee_attrition;


-- Validação: Colaboradores únicos
SELECT
    COUNT(*) AS total_registros,
    COUNT(DISTINCT "EmployeeNumber") AS colaboradores_unicos
FROM hr_employee_attrition;


-- Validação: Duplicidades
SELECT
    "EmployeeNumber",
    COUNT(*) AS quantidade
FROM hr_employee_attrition
GROUP BY "EmployeeNumber"
HAVING COUNT(*) > 1;


-- Validação: Valores nulos
SELECT
    COUNT(*) FILTER (WHERE "EmployeeNumber" IS NULL) AS employee_number_nulos,
    COUNT(*) FILTER (WHERE "Attrition" IS NULL) AS attrition_nulos,
    COUNT(*) FILTER (WHERE "Department" IS NULL) AS department_nulos,
    COUNT(*) FILTER (WHERE "JobRole" IS NULL) AS job_role_nulos,
    COUNT(*) FILTER (WHERE "MonthlyIncome" IS NULL) AS monthly_income_nulos
FROM hr_employee_attrition;


-- Análise: Distribuição de attrition
SELECT
    "Attrition",
    COUNT(*) AS quantidade
FROM hr_employee_attrition
GROUP BY "Attrition";


-- Análise: Taxa de turnover
SELECT
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    COUNT(*) AS total_colaboradores,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition;


-- Análise: Turnover por departamento
SELECT
    "Department",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY "Department"
ORDER BY turnover_percentual DESC;


-- Análise: Turnover por cargo
SELECT
    "JobRole",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY "JobRole"
ORDER BY turnover_percentual DESC;


-- Análise: Turnover por tempo de empresa
SELECT
    CASE
        WHEN "YearsAtCompany" <= 1 THEN '0 a 1 ano'
        WHEN "YearsAtCompany" <= 3 THEN '2 a 3 anos'
        WHEN "YearsAtCompany" <= 5 THEN '4 a 5 anos'
        WHEN "YearsAtCompany" <= 10 THEN '6 a 10 anos'
        ELSE 'Mais de 10 anos'
    END AS faixa_tempo_empresa,
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY faixa_tempo_empresa
ORDER BY turnover_percentual DESC;


-- Análise: Turnover por horas extras
SELECT
    "OverTime",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY "OverTime"
ORDER BY turnover_percentual DESC;


-- Análise: Turnover por tempo de empresa e horas extras
SELECT
    CASE
        WHEN "YearsAtCompany" <= 1 THEN '0 a 1 ano'
        WHEN "YearsAtCompany" <= 3 THEN '2 a 3 anos'
        WHEN "YearsAtCompany" <= 5 THEN '4 a 5 anos'
        WHEN "YearsAtCompany" <= 10 THEN '6 a 10 anos'
        ELSE 'Mais de 10 anos'
    END AS faixa_tempo_empresa,
    "OverTime",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY
    faixa_tempo_empresa,
    "OverTime"
ORDER BY
    faixa_tempo_empresa,
    turnover_percentual DESC;


-- Análise: Turnover por faixa de renda mensal
SELECT
    CASE
        WHEN "MonthlyIncome" <= 3000 THEN 'Até 3.000'
        WHEN "MonthlyIncome" <= 6000 THEN '3.001 a 6.000'
        WHEN "MonthlyIncome" <= 10000 THEN '6.001 a 10.000'
        WHEN "MonthlyIncome" <= 15000 THEN '10.001 a 15.000'
        ELSE 'Acima de 15.000'
    END AS faixa_renda_mensal,
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY faixa_renda_mensal
ORDER BY turnover_percentual DESC;


-- Análise: Turnover por renda mensal, horas extras e tempo de empresa
SELECT
    CASE
        WHEN "YearsAtCompany" <= 1 THEN '0 a 1 ano'
        WHEN "YearsAtCompany" <= 3 THEN '2 a 3 anos'
        WHEN "YearsAtCompany" <= 5 THEN '4 a 5 anos'
        WHEN "YearsAtCompany" <= 10 THEN '6 a 10 anos'
        ELSE 'Mais de 10 anos'
    END AS faixa_tempo_empresa,
    CASE
        WHEN "MonthlyIncome" <= 3000 THEN 'Até 3.000'
        WHEN "MonthlyIncome" <= 6000 THEN '3.001 a 6.000'
        WHEN "MonthlyIncome" <= 10000 THEN '6.001 a 10.000'
        WHEN "MonthlyIncome" <= 15000 THEN '10.001 a 15.000'
        ELSE 'Acima de 15.000'
    END AS faixa_renda_mensal,
    "OverTime",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY
    faixa_tempo_empresa,
    faixa_renda_mensal,
    "OverTime"
ORDER BY
    turnover_percentual DESC;

-- Análise: Turnover por satisfação no trabalho
SELECT
    "JobSatisfaction",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY "JobSatisfaction"
ORDER BY "JobSatisfaction";

-- Análise: Turnover por satisfação no trabalho e horas extras
SELECT
    "JobSatisfaction",
    "OverTime",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY
    "JobSatisfaction",
    "OverTime"
ORDER BY
    "JobSatisfaction",
    turnover_percentual DESC;


-- Análise: Turnover por equilíbrio entre vida pessoal e trabalho
SELECT
    "WorkLifeBalance",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY "WorkLifeBalance"
ORDER BY "WorkLifeBalance";

-- Análise: Turnover por equilíbrio entre vida pessoal e trabalho e horas extras
SELECT
    "WorkLifeBalance",
    "OverTime",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY
    "WorkLifeBalance",
    "OverTime"
ORDER BY
    "WorkLifeBalance",
    turnover_percentual DESC;

-- Análise: Turnover por distância de casa
SELECT
    CASE
        WHEN "DistanceFromHome" <= 5 THEN 'Até 5'
        WHEN "DistanceFromHome" <= 10 THEN '6 a 10'
        WHEN "DistanceFromHome" <= 20 THEN '11 a 20'
        ELSE 'Acima de 20'
    END AS faixa_distancia,
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY faixa_distancia
ORDER BY turnover_percentual DESC;

-- Análise: Turnover por distância de casa e horas extras
SELECT
    CASE
        WHEN "DistanceFromHome" <= 5 THEN 'Até 5'
        WHEN "DistanceFromHome" <= 10 THEN '6 a 10'
        WHEN "DistanceFromHome" <= 20 THEN '11 a 20'
        ELSE 'Acima de 20'
    END AS faixa_distancia,
    "OverTime",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY
    faixa_distancia,
    "OverTime"
ORDER BY
    faixa_distancia,
    turnover_percentual DESC;

-- Análise: Turnover por faixa etária
SELECT
    CASE
        WHEN "Age" <= 25 THEN 'Até 25 anos'
        WHEN "Age" <= 35 THEN '26 a 35 anos'
        WHEN "Age" <= 45 THEN '36 a 45 anos'
        WHEN "Age" <= 55 THEN '46 a 55 anos'
        ELSE 'Acima de 55 anos'
    END AS faixa_etaria,
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY faixa_etaria
ORDER BY turnover_percentual DESC;

-- Análise: Turnover por faixa etária, renda mensal e horas extras
SELECT
    CASE
        WHEN "Age" <= 25 THEN 'Até 25 anos'
        WHEN "Age" <= 35 THEN '26 a 35 anos'
        WHEN "Age" <= 45 THEN '36 a 45 anos'
        WHEN "Age" <= 55 THEN '46 a 55 anos'
        ELSE 'Acima de 55 anos'
    END AS faixa_etaria,
    CASE
        WHEN "MonthlyIncome" <= 3000 THEN 'Até 3.000'
        WHEN "MonthlyIncome" <= 6000 THEN '3.001 a 6.000'
        WHEN "MonthlyIncome" <= 10000 THEN '6.001 a 10.000'
        WHEN "MonthlyIncome" <= 15000 THEN '10.001 a 15.000'
        ELSE 'Acima de 15.000'
    END AS faixa_renda_mensal,
    "OverTime",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY
    faixa_etaria,
    faixa_renda_mensal,
    "OverTime"
ORDER BY
    turnover_percentual DESC;


-- Análise: Turnover por tempo desde a última promoção
SELECT
    CASE
        WHEN "YearsSinceLastPromotion" = 0 THEN 'Menos de 1 ano'
        WHEN "YearsSinceLastPromotion" <= 2 THEN '1 a 2 anos'
        WHEN "YearsSinceLastPromotion" <= 5 THEN '3 a 5 anos'
        ELSE 'Mais de 5 anos'
    END AS faixa_tempo_sem_promocao,
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY faixa_tempo_sem_promocao
ORDER BY turnover_percentual DESC;

-- Análise: Turnover por tempo de empresa e tempo desde a última promoção
SELECT
    CASE
        WHEN "YearsAtCompany" <= 1 THEN '0 a 1 ano'
        WHEN "YearsAtCompany" <= 3 THEN '2 a 3 anos'
        WHEN "YearsAtCompany" <= 5 THEN '4 a 5 anos'
        WHEN "YearsAtCompany" <= 10 THEN '6 a 10 anos'
        ELSE 'Mais de 10 anos'
    END AS faixa_tempo_empresa,
    CASE
        WHEN "YearsSinceLastPromotion" = 0 THEN '0 anos'
        WHEN "YearsSinceLastPromotion" <= 2 THEN '1 a 2 anos'
        WHEN "YearsSinceLastPromotion" <= 5 THEN '3 a 5 anos'
        ELSE 'Mais de 5 anos'
    END AS faixa_tempo_desde_promocao,
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY
    faixa_tempo_empresa,
    faixa_tempo_desde_promocao
ORDER BY
    faixa_tempo_empresa,
    turnover_percentual DESC;

-- Análise: Turnover por nível hierárquico, renda mensal e horas extras
SELECT
    "JobLevel",
    CASE
        WHEN "MonthlyIncome" <= 3000 THEN 'Até 3.000'
        WHEN "MonthlyIncome" <= 6000 THEN '3.001 a 6.000'
        WHEN "MonthlyIncome" <= 10000 THEN '6.001 a 10.000'
        WHEN "MonthlyIncome" <= 15000 THEN '10.001 a 15.000'
        ELSE 'Acima de 15.000'
    END AS faixa_renda_mensal,
    "OverTime",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY
    "JobLevel",
    faixa_renda_mensal,
    "OverTime"
ORDER BY
    turnover_percentual DESC;

-- Análise: Turnover por frequência de viagens e horas extras
SELECT
    "BusinessTravel",
    "OverTime",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY
    "BusinessTravel",
    "OverTime"
ORDER BY
    turnover_percentual DESC;

-- Análise: Turnover por estado civil
SELECT
    "MaritalStatus",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY "MaritalStatus"
ORDER BY turnover_percentual DESC;

-- Análise: Turnover por satisfação com o ambiente
SELECT
    "EnvironmentSatisfaction",
    COUNT(*) AS total_colaboradores,
    COUNT(*) FILTER (WHERE "Attrition" = 'Yes') AS desligamentos,
    ROUND(
        COUNT(*) FILTER (WHERE "Attrition" = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS turnover_percentual
FROM hr_employee_attrition
GROUP BY "EnvironmentSatisfaction"
ORDER BY "EnvironmentSatisfaction";










