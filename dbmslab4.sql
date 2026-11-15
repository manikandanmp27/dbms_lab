-- Program 4: College Database

-- Q1: List all the student details studying in fourth semester 'C' section.
SELECT S.* FROM STUDENT S
JOIN CLASS C USING (USN)
JOIN SEMSEC SS USING (SSID)
WHERE Sem = 4 AND Sec = 'C';

-- Q2: Compute the total number of male and female students in each semester and in each section.
SELECT Sem, Sec, Gender, COUNT(*) Total
FROM STUDENT S
JOIN CLASS C USING (USN)
JOIN SEMSEC SS USING (SSID)
GROUP BY Sem, Sec, Gender
ORDER BY Sem, Sec;

-- Q3: Create a view of Test1 Marks of student USN '11XX1234' in all subjects.
CREATE VIEW Test1_USN_11XX1234 AS
SELECT Subcode, Test1 FROM IA_MARKS
WHERE USN = '11XX1234';

-- Q4: Calculate the FinalIA (average of best two test Marks) and update the corresponding table for all students.
UPDATE IA_MARKS
SET FinalIA = (Test1 + Test2 + Test3 - LEAST(Test1,Test2,Test3))/2;

SELECT * FROM IA_MARKS;

-- Q5: Categorize students based on the following criterion:
--     If FinalIA = 17 to 20 then CAT = 'Outstanding'
--     If FinalIA = 12 to 16 then CAT = 'Average'
--     If FinalIA < 12 then CAT = 'Weak'
--     Give these details only for 8th semester A, B, and C section students.
SELECT USN, SName, Sem, Sec, FinalIA,
CASE
  WHEN FinalIA >= 17 THEN 'Outstanding'
  WHEN FinalIA >= 12 THEN 'Average'
  ELSE 'Weak'
END Category
FROM STUDENT
JOIN CLASS USING (USN)
JOIN SEMSEC USING (SSID)
JOIN IA_MARKS USING (USN)
WHERE Sem = 8 AND Sec IN ('A','B','C');

CREATE TABLE STUDENT (
    USN VARCHAR(10) PRIMARY KEY,
    SName VARCHAR(50),
    Address VARCHAR(100),
    Phone BIGINT,
    Gender CHAR(1)
);

CREATE TABLE SEMSEC (
    SSID VARCHAR(10) PRIMARY KEY,
    Sem INT,
    Sec CHAR(1)
);

CREATE TABLE CLASS (
    USN VARCHAR(10),
    SSID VARCHAR(10),
    FOREIGN KEY (USN) REFERENCES STUDENT(USN),
    FOREIGN KEY (SSID) REFERENCES SEMSEC(SSID)
);

CREATE TABLE SUBJECT (
    Subcode VARCHAR(10) PRIMARY KEY,
    Title VARCHAR(50),
    Sem INT,
    Credits INT
);

CREATE TABLE IA_MARKS (
    USN VARCHAR(10),
    Subcode VARCHAR(10),
    SSID VARCHAR(10),
    Test1 INT,
    Test2 INT,
    Test3 INT,
    FinalIA FLOAT,
    FOREIGN KEY (USN) REFERENCES STUDENT(USN),
    FOREIGN KEY (Subcode) REFERENCES SUBJECT(Subcode),
    FOREIGN KEY (SSID) REFERENCES SEMSEC(SSID)
);

INSERT INTO STUDENT VALUES
('11XX1234','Ravi','Bangalore',9876543210,'M'),
('11XX1235','Sneha','Mysore',9988776655,'F'),
('11XX1236','Arjun','Hubli',9123456789,'M'),
('11XX1237','Anu','Bangalore',9012345678,'F'),
('11XX1238','Kiran','Davangere',9876501234,'M');

INSERT INTO SEMSEC VALUES
('S4A',4,'A'),('S4B',4,'B'),('S4C',4,'C'),
('S8A',8,'A'),('S8B',8,'B'),('S8C',8,'C');

INSERT INTO CLASS VALUES
('11XX1234','S4C'),
('11XX1235','S4A'),
('11XX1236','S4C'),
('11XX1237','S4B'),
('11XX1238','S8A');

INSERT INTO SUBJECT VALUES
('CS801','AI',8,4),
('CS802','ML',8,4),
('CS803','DL',8,4),
('CS401','OS',4,4),
('CS402','DBMS',4,4);

INSERT INTO IA_MARKS VALUES
('11XX1234','CS801','S8A',15,17,18,0),
('11XX1234','CS802','S8A',12,14,16,0),
('11XX1234','CS803','S8A',18,20,17,0),
('11XX1235','CS401','S4A',14,15,13,0),
('11XX1236','CS402','S4C',16,17,14,0),
('11XX1238','CS801','S8A',10,12,15,0);
