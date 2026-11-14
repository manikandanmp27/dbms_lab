-- Query 1: Movies directed by ABCD
SELECT Mov_Title FROM MOVIES M
JOIN DIRECTOR D USING (Dir_id)
WHERE Dir_Name = 'ABCD';

-- Query 2: Movies with actors who acted in 2+ movies
SELECT DISTINCT Mov_Title FROM MOVIES
JOIN MOVIE_CAST USING (Mov_id)
WHERE Act_id IN (
  SELECT Act_id FROM MOVIE_CAST
  GROUP BY Act_id
  HAVING COUNT(*) >= 2
);

-- Query 3: Actors in movies before 2000 and after 2015
SELECT Act_Name FROM ACTOR
WHERE Act_id IN (SELECT Act_id FROM MOVIE_CAST JOIN MOVIES USING (Mov_id) WHERE Mov_Year < 2000)
  AND Act_id IN (SELECT Act_id FROM MOVIE_CAST JOIN MOVIES USING (Mov_id) WHERE Mov_Year > 2015);

-- Query 4: Highest rating per movie, sorted by title
SELECT M.Mov_Title, MAX(R.Rev_Stars) Highest_Stars
FROM MOVIES M JOIN RATING R USING (Mov_id)
GROUP BY M.Mov_id, M.Mov_Title
ORDER BY M.Mov_Title;

-- Query 5: Update ratings for movies directed by XYZ
UPDATE RATING
JOIN MOVIES USING (Mov_id)
JOIN DIRECTOR USING (Dir_id)
SET Rev_Stars = 5
WHERE Dir_Name = 'XYZ';