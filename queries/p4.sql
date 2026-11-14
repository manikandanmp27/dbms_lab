-- Query 1: Students in 4th semester, section C
SELECT S.* FROM STUDENT S
JOIN CLASS C USING (USN)
JOIN SEMSEC SS USING (SSID)
WHERE Sem = 4 AND Sec = 'C';

-- Query 2: Male/female count by semester and section
SELECT Sem, Sec, Gender, COUNT(*) Total
FROM STUDENT S
JOIN CLASS C USING (USN)
JOIN SEMSEC SS USING (SSID)
GROUP BY Sem, Sec, Gender
ORDER BY Sem, Sec;

-- Query 3: View Test1 marks for one student
CREATE VIEW Test1_USN_11XX1234 AS
SELECT Subcode, Test1 FROM IA_MARKS
WHERE USN = '11XX1234';

-- Query 4: Final IA = average of best two tests
UPDATE IA_MARKS
SET FinalIA = (Test1 + Test2 + Test3 - LEAST(Test1,Test2,Test3))/2;

SELECT * FROM IA_MARKS;

-- Query 5: Categorize 8th semester students
SELECT S.USN, S.SName, Sem, Sec, FinalIA,
CASE
  WHEN FinalIA >= 17 THEN 'Outstanding'
  WHEN FinalIA >= 12 THEN 'Average'
  ELSE 'Weak'
END Category
FROM STUDENT S
JOIN CLASS C USING (USN)
JOIN SEMSEC SS USING (SSID)
JOIN IA_MARKS IA ON S.USN = IA.USN
WHERE Sem = 8 AND Sec IN ('A','B','C');