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