--Program 1 : Library Database
--Q1
SELECT B.Book_id, B.Title, P.Name,
       BA.Author_Name, LB.Branch_Name,
       BC.No_of_Copies
FROM BOOK B
JOIN PUBLISHER P USING (Pub_id)
JOIN BOOK_AUTHORS BA USING (Book_id)
JOIN BOOK_COPIES BC USING (Book_id)
JOIN LIBRARY_BRANCH LB USING (Branch_id);
--Q2
SELECT
    Card_No,
    COUNT(*) AS Total_Books_Borrowed
FROM BOOK_LENDING
WHERE Date_Out BETWEEN '2019-01-01' AND '2019-06-30'
GROUP BY Card_No
HAVING COUNT(*) > 3;
--Q3
DELETE FROM BOOK
WHERE Book_id = 103;
--Q4
CREATE TABLE BOOK_PARTITIONED (
    Book_id INT,
    Title VARCHAR(100),
    Pub_id INT,
    Pub_Year INT,
    PRIMARY KEY (Book_id, Pub_Year)
)
PARTITION BY RANGE (Pub_Year) (
    PARTITION P1 VALUES LESS THAN (2019),
    PARTITION P2 VALUES LESS THAN (2021),
    PARTITION P3 VALUES LESS THAN (2023),
    PARTITION P4 VALUES LESS THAN MAXVALUE
);
INSERT INTO BOOK_PARTITIONED VALUES
(201, 'Database Systems', 1, 2018),
(202, 'Operating Systems', 2, 2020),
(203, 'Computer Networks', 1, 2017),
(204, 'Artificial Intelligence', 3, 2021),
(205, 'Machine Learning', 4, 2022);
SELECT * FROM BOOK_PARTITIONED
PARTITION (P1);
--O5
CREATE VIEW Available_Books AS
SELECT B.Book_id, B.Title, SUM(BC.No_of_Copies) Total_Copies
FROM BOOK B JOIN BOOK_COPIES BC USING (Book_id)
GROUP BY B.Book_id, B.Title;

SELECT * FROM Available_Books;

CREATE DATABASE library;
USE library;

CREATE TABLE PUBLISHER (
    Pub_id INT PRIMARY KEY,
    Name VARCHAR(50) UNIQUE,
    Address VARCHAR(100),
    Phone VARCHAR(15)
);

CREATE TABLE BOOK (
    Book_id INT PRIMARY KEY,
    Title VARCHAR(100),
    Pub_id INT,
    Pub_Year INT,
    FOREIGN KEY (Pub_id) REFERENCES PUBLISHER(Pub_id)
);

CREATE TABLE BOOK_AUTHORS (
    Book_id INT,
    Author_Name VARCHAR(50),
    FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id)
        ON DELETE CASCADE
);

CREATE TABLE LIBRARY_BRANCH (
    Branch_id INT PRIMARY KEY,
    Branch_Name VARCHAR(50),
    Address VARCHAR(100)
);

CREATE TABLE BOOK_COPIES (
    Book_id INT,
    Branch_id INT,
    No_of_Copies INT,
    FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id)
        ON DELETE CASCADE,
    FOREIGN KEY (Branch_id) REFERENCES LIBRARY_BRANCH(Branch_id)
);

CREATE TABLE BOOK_LENDING (
    Book_id INT,
    Branch_id INT,
    Card_No INT,
    Date_Out DATE,
    Due_Date DATE,
    FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id)
        ON DELETE CASCADE,
    FOREIGN KEY (Branch_id) REFERENCES LIBRARY_BRANCH(Branch_id)
);

INSERT INTO PUBLISHER VALUES
(1, 'Pearson', 'Bangalore', '9876543210'),
(2, 'McGraw Hill', 'Delhi', '8765432109'),
(3, 'O''Reilly Media', 'Mumbai', '7654321098'),
(4, 'Oxford Press', 'Chennai', '7543210987'),
(5, 'Wiley India', 'Hyderabad', '9123456780');

INSERT INTO BOOK VALUES
(101, 'Database Systems', 1, 2018),
(102, 'Operating Systems', 2, 2020),
(103, 'Computer Networks', 1, 2017),
(104, 'Artificial Intelligence', 3, 2021),
(105, 'Machine Learning', 4, 2022);

INSERT INTO BOOK_AUTHORS VALUES
(101, 'Elmasri'),
(102, 'Silberschatz'),
(103, 'Tanenbaum'),
(104, 'Stuart Russell'),
(105, 'Tom Mitchell');

INSERT INTO LIBRARY_BRANCH VALUES
(1, 'Central Library', 'MG Road'),
(2, 'City Branch', 'Jayanagar'),
(3, 'North Branch', 'Yeshwanthpur'),
(4, 'South Branch', 'BTM Layout'),
(5, 'East Branch', 'Whitefield');

INSERT INTO BOOK_COPIES VALUES
(101, 1, 5),
(101, 2, 3),
(102, 3, 4),
(103, 4, 6),
(104, 5, 2);

INSERT INTO BOOK_LENDING VALUES
(101, 1, 1001, '2019-01-05', '2019-01-15'),
(102, 2, 1001, '2019-02-10', '2019-02-20'),
(103, 3, 1001, '2019-03-12', '2019-03-22'),
(104, 4, 1001, '2019-04-18', '2019-04-28'),
(105, 5, 1001, '2019-05-09', '2019-05-19'),
(101, 2, 1001, '2019-05-15', '2019-05-25'),
(102, 3, 1001, '2019-06-01', '2019-06-11'),
(103, 4, 1001, '2019-06-10', '2019-06-20'),
(104, 5, 1001, '2019-06-18', '2019-06-28');