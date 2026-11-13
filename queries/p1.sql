-- Library Database


--Q1 Retrieve details of all books in the library: id, title, name of publisher, authors, number of copies in each branch, etc.
SELECT B.Book_id, B.Title, P.Name,
       BA.Author_Name, LB.Branch_Name,
       BC.No_of_Copies
FROM BOOK B
JOIN PUBLISHER P USING (Pub_id)
JOIN BOOK_AUTHORS BA USING (Book_id)
JOIN BOOK_COPIES BC USING (Book_id)
JOIN LIBRARY_BRANCH LB USING (Branch_id);
--Q2 Get the particulars of borrowers who have borrowed more than 3 books from Jan 2019 to Jun 2019.
SELECT
    Card_No,
    COUNT(*) AS Total_Books_Borrowed
FROM BOOK_LENDING
WHERE Date_Out BETWEEN '2019-01-01' AND '2019-06-30'
GROUP BY Card_No
HAVING COUNT(*) > 8;
--Q3 Delete a book in BOOK table and update the contents of other tables to reflect this data manipulation operation.
DELETE FROM BOOK
WHERE Book_id = 103;
--Q4 Partition the BOOK table based on year of publication. Demonstrate its working with a simple query.
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
--O5 Create a view of all books and its number of copies that are currently available in the Library.
CREATE VIEW Available_Books AS
SELECT B.Book_id, B.Title, SUM(BC.No_of_Copies) Total_Copies
FROM BOOK B JOIN BOOK_COPIES BC USING (Book_id)
GROUP BY B.Book_id, B.Title;

SELECT * FROM Available_Books;
