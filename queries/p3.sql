-- Query 1: Movies directed by ABCD
SELECT Mov_Title FROM MOVIES M
JOIN DIRECTOR D USING (Dir_id)
WHERE Dir_Name = 'ABCD';

-- Query 2: Movies with actors who acted in 2+ movies
SELECT DISTINCT Mov_Title FROM MOVIES
WHERE Mov_id IN (
  SELECT Mov_id FROM MOVIE_CAST
  GROUP BY Act_id
  HAVING COUNT(DISTINCT Mov_id) >= 2
);

-- Query 3: Actors in movies before 2000 and after 2015
SELECT DISTINCT A.Act_Name
FROM ACTOR A
JOIN MOVIE_CAST C1 USING (Act_id)
JOIN MOVIES M1 USING (Mov_id)
JOIN MOVIE_CAST C2 USING (Act_id)
JOIN MOVIES M2 USING (Mov_id)
WHERE M1.Mov_Year < 2000
  AND M2.Mov_Year > 2015;

-- Query 4: Highest rating per movie, sorted by title
SELECT M.Mov_Title, MAX(R.Rev_Stars) Highest_Stars
FROM MOVIES M JOIN RATING R USING (Mov_id)
GROUP BY M.Mov_id, M.Mov_Title
ORDER BY M.Mov_Title;

-- Query 5: Update ratings for movies directed by XYZ
UPDATE RATING SET Rev_Stars = 5
WHERE Mov_id IN (
  SELECT Mov_id FROM MOVIES
  WHERE Dir_id = (SELECT Dir_id FROM DIRECTOR
                  WHERE Dir_Name = 'XYZ')
);