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

CREATE TABLE EMPLOYEE (
    SSN VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(50),
    Address VARCHAR(100),
    Sex CHAR(1),
    Salary FLOAT,
    SuperSSN VARCHAR(10),
    DNo INT
);

CREATE TABLE DEPARTMENT (
    DNo INT PRIMARY KEY,
    DName VARCHAR(50),
    MgrSSN VARCHAR(10),
    MgrStartDate DATE,
    FOREIGN KEY (MgrSSN) REFERENCES EMPLOYEE(SSN)
);

CREATE TABLE DLOCATION (
    DNo INT,
    DLocation VARCHAR(50),
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo)
);

CREATE TABLE PROJECT (
    PNo INT PRIMARY KEY,
    PName VARCHAR(50),
    PLocation VARCHAR(50),
    DNo INT,
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo)
);

CREATE TABLE WORKS_ON (
    SSN VARCHAR(10),
    PNo INT,
    Hours INT,
    FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN),
    FOREIGN KEY (PNo) REFERENCES PROJECT(PNo)
);

INSERT INTO EMPLOYEE VALUES
('E001','John Seo','Bangalore','M',60000,NULL,1),
('E002','Alice Kim','Mysore','F',55000,'E001',1),
('E003','Bob Lee','Hubli','M',70000,'E001',2),
('E004','Carol Seo','Delhi','F',80000,'E003',2),
('E005','David Park','Bangalore','M',50000,NULL,3),
('E006','Eva Wong','Mysore','F',65000,'E005',3);

INSERT INTO DEPARTMENT VALUES
(1,'Accounts','E001','2020-01-01'),
(2,'Sales','E003','2021-03-15'),
(3,'IT','E005','2022-06-01');

INSERT INTO DLOCATION VALUES
(1,'Bangalore'),
(2,'Delhi'),
(3,'Mysore');

INSERT INTO PROJECT VALUES
(101,'ProjectA','Bangalore',1),
(102,'ProjectB','Delhi',2),
(103,'IoT','Mysore',3),
(104,'ProjectC','Bangalore',1),
(105,'ProjectD','Delhi',2);

INSERT INTO WORKS_ON VALUES
('E001',101,40),
('E002',101,20),
('E003',102,30),
('E004',102,25),
('E005',103,35),
('E006',103,40),
('E001',104,10),
('E003',105,15);