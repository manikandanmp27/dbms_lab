-- Query 1: Projects involving employees with last name Seo
SELECT DISTINCT P.PNo FROM PROJECT P
LEFT JOIN WORKS_ON W USING (PNo)
LEFT JOIN EMPLOYEE E ON W.SSN = E.SSN
LEFT JOIN DEPARTMENT D ON P.DNo = D.DNo
WHERE E.Name LIKE '%Seo'
   OR D.MgrSSN IN (SELECT SSN FROM EMPLOYEE
                   WHERE Name LIKE '%Seo');

-- Query 2: Salaries with 10% raise for IoT project employees
SELECT E.SSN, E.Name, E.Salary, E.Salary*1.10 NewSalary
FROM EMPLOYEE E
JOIN WORKS_ON W USING (SSN)
JOIN PROJECT P USING (PNo)
WHERE PName = 'IoT';

-- Query 3: Salary statistics for Accounts department
SELECT SUM(Salary) TotalSalary, MAX(Salary) MaxSalary,
       MIN(Salary) MinSalary, AVG(Salary) AvgSalary
FROM EMPLOYEE E JOIN DEPARTMENT D USING (DNo)
WHERE DName = 'Accounts';

-- Query 4: Employees working on all projects of department 2
SELECT E.Name FROM EMPLOYEE E
WHERE NOT EXISTS (
  SELECT PNo FROM PROJECT
  WHERE DNo = 2 AND NOT EXISTS (
    SELECT 1 FROM WORKS_ON W
    WHERE W.PNo = PROJECT.PNo AND W.SSN = E.SSN
  )
);

-- Query 5: Departments with more than 5 employees earning > 60000
SELECT D.DNo, COUNT(*) EmployeesAbove60K
FROM DEPARTMENT D JOIN EMPLOYEE E USING (DNo)
WHERE Salary > 60000
GROUP BY D.DNo
HAVING COUNT(*) > 5;