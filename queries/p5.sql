-- Query 1: Projects involving employees with last name Seo
-- Worker on project
SELECT PNo FROM PROJECT 
JOIN WORKS_ON USING (PNo) 
JOIN EMPLOYEE USING (SSN) 
WHERE Name LIKE '%Seo'
UNION
-- Manager of controlling department
SELECT PNo FROM PROJECT 
JOIN DEPARTMENT USING (DNo) 
JOIN EMPLOYEE ON MgrSSN = SSN 
WHERE Name LIKE '%Seo';

-- Query 2: Salaries with 10% raise for IoT project employees
SELECT E.SSN, E.Name, E.Salary, E.Salary*1.10 NewSalary
FROM EMPLOYEE E
JOIN WORKS_ON W USING (SSN)
JOIN PROJECT P USING (PNo)
WHERE PName = 'IoT';

-- Query 3: Salary statistics for Accounts department
SELECT SUM(Salary), MAX(Salary), MIN(Salary), AVG(Salary)
FROM EMPLOYEE
WHERE DNo = (SELECT DNo FROM DEPARTMENT WHERE DName = 'Accounts');

-- Query 4: Employees working on all projects of department 2
SELECT Name FROM EMPLOYEE
WHERE SSN IN (
  SELECT SSN 
  FROM WORKS_ON JOIN PROJECT USING (PNo)
  WHERE DNo = 2
  GROUP BY SSN
  HAVING COUNT(DISTINCT PNo) = (SELECT COUNT(*) FROM PROJECT WHERE DNo = 2)
);

-- Query 5: Departments with more than 5 employees earning > 60000
SELECT DNo, DName, COUNT(*) AS EmployeesAbove60K
FROM DEPARTMENT 
JOIN EMPLOYEE USING (DNo)
WHERE Salary > 60000
GROUP BY DNo, DName
HAVING COUNT(*) > 5;