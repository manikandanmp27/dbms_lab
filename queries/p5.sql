-- Program 5: Company Database

-- Q1: Make a list of all project numbers for projects that involve an employee whose last name is 'Scott' (or 'Seo'), either as a worker or as a manager of the department that controls the project.
SELECT PNo FROM PROJECT 
JOIN WORKS_ON USING (PNo) 
JOIN EMPLOYEE USING (SSN) 
WHERE Name LIKE '%Seo'
UNION
SELECT PNo FROM PROJECT 
JOIN DEPARTMENT USING (DNo) 
JOIN EMPLOYEE ON MgrSSN = SSN 
WHERE Name LIKE '%Seo';

-- Q2: Show the resulting salaries if every employee working on the 'IoT' project is given a 10 percent raise.
SELECT E.SSN, E.Name, E.Salary, E.Salary*1.10 AS NewSalary
FROM EMPLOYEE E
JOIN WORKS_ON W USING (SSN)
JOIN PROJECT P USING (PNo)
WHERE PName = 'IoT';

-- Q3: Find the sum of the salaries of all employees of the 'Accounts' department, as well as the maximum salary, the minimum salary, and the average salary in this department.
SELECT SUM(Salary) AS TotalSalary, MAX(Salary) AS MaxSalary, 
       MIN(Salary) AS MinSalary, AVG(Salary) AS AvgSalary
FROM EMPLOYEE
WHERE DNo = (SELECT DNo FROM DEPARTMENT WHERE DName = 'Accounts');

-- Q4: Retrieve the name of each employee who works on all the projects controlled by department number 2 (or 5) (use NOT EXISTS operator).
SELECT E.Name FROM EMPLOYEE E
WHERE NOT EXISTS (
  SELECT PNo FROM PROJECT
  WHERE DNo = 2 AND NOT EXISTS (
    SELECT 1 FROM WORKS_ON W
    WHERE W.PNo = PROJECT.PNo AND W.SSN = E.SSN
  )
);

-- Q5: For each department that has more than five employees, retrieve the department number and the number of its employees who are making more than Rs.6,00,000 (or 60,000).
SELECT DNo, DName, COUNT(*) AS EmployeesAbove60K
FROM DEPARTMENT 
JOIN EMPLOYEE USING (DNo)
WHERE Salary > 60000
GROUP BY DNo, DName
HAVING COUNT(*) > 5;