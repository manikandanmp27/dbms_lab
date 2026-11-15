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


CREATE TABLE ACTOR (
    Act_id INT PRIMARY KEY,
    Act_Name VARCHAR(100),
    Act_Gender VARCHAR(10)
);

CREATE TABLE DIRECTOR (
    Dir_id INT PRIMARY KEY,
    Dir_Name VARCHAR(100),
    Dir_Phone VARCHAR(15)
);

CREATE TABLE MOVIES (
    Mov_id INT PRIMARY KEY,
    Mov_Title VARCHAR(100),
    Mov_Year INT,
    Mov_Lang VARCHAR(50),
    Dir_id INT,
    FOREIGN KEY (Dir_id) REFERENCES DIRECTOR(Dir_id)
);

CREATE TABLE MOVIE_CAST (
    Act_id INT,
    Mov_id INT,
    Role VARCHAR(100),
    PRIMARY KEY (Act_id, Mov_id),
    FOREIGN KEY (Act_id) REFERENCES ACTOR(Act_id),
    FOREIGN KEY (Mov_id) REFERENCES MOVIES(Mov_id)
);

CREATE TABLE RATING (
    Mov_id INT,
    Rev_Stars INT,
    FOREIGN KEY (Mov_id) REFERENCES MOVIES(Mov_id)
);

INSERT INTO ACTOR VALUES
(1,'Raj','M'),
(2,'Anu','F'),
(3,'Kiran','M'),
(4,'Megha','F'),
(5,'Arjun','M');

INSERT INTO DIRECTOR VALUES
(1,'ABCD','+919876543210'),
(2,'XYZ','+918765432109'),
(3,'PQR','+919123456789'),
(4,'LMN','+919988776655'),
(5,'EFG','+919090909090');

INSERT INTO MOVIES VALUES
(101,'Love Story',1998,'Hindi',1),
(102,'Dream Girl',2016,'English',1),
(103,'Action King',2020,'Kannada',2),
(104,'Future World',2022,'Telugu',3),
(105,'Classic Times',1985,'Tamil',4);

INSERT INTO MOVIE_CAST VALUES
(1,101,'Hero'),
(2,101,'Heroine'),
(1,102,'Guest'),
(3,103,'Villain'),
(1,103,'Hero'),
(4,104,'Heroine'),
(5,104,'Hero'),
(3,105,'Supporting'),
(2,105,'Heroine'),
(5,102,'Supporting');

INSERT INTO RATING VALUES
(101,4),
(102,3),
(103,5),
(104,4),
(105,2);