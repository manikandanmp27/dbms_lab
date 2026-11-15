-- Program 3: Movie Database

-- Q1: List the titles of all movies directed by 'ABCD'.
SELECT Mov_Title FROM MOVIES M
JOIN DIRECTOR D USING (Dir_id)
WHERE Dir_Name = 'ABCD';

-- Q2: Find the movie names where one or more actors acted in two or more movies.
SELECT DISTINCT Mov_Title FROM MOVIES
JOIN MOVIE_CAST USING (Mov_id)
WHERE Act_id IN (
  SELECT Act_id FROM MOVIE_CAST
  GROUP BY Act_id
  HAVING COUNT(*) >= 2
);

-- Q3: List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN operation).
SELECT DISTINCT A.Act_Name
FROM ACTOR A
JOIN MOVIE_CAST C1 USING (Act_id)
JOIN MOVIES M1 USING (Mov_id)
JOIN MOVIE_CAST C2 USING (Act_id)
JOIN MOVIES M2 USING (Mov_id)
WHERE M1.Mov_Year < 2000
  AND M2.Mov_Year > 2015;

-- Q4: Find the title of movies and number of stars for each movie that has at least one rating and find the highest number of stars that movie received. Sort the result by movie title.
SELECT M.Mov_Title, MAX(R.Rev_Stars) Highest_Stars
FROM MOVIES M JOIN RATING R USING (Mov_id)
GROUP BY M.Mov_id, M.Mov_Title
ORDER BY M.Mov_Title;

-- Q5: Update rating of all movies directed by 'XYZ' to 5.
UPDATE RATING
JOIN MOVIES USING (Mov_id)
JOIN DIRECTOR USING (Dir_id)
SET Rev_Stars = 5
WHERE Dir_Name = 'XYZ';