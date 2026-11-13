/*
Library Database   
Schema: 
BOOK(Book_id, Title, Publisher_Name, Pub_Year), 
BOOK_AUTHORS(Book_id, Author_Name), 
PUBLISHER(Pub_id, Name, Address, Phone), 
BOOK_COPIES(Book_id, Branch_id, No_of_Copies), 
BOOK_LENDING(Book_id, Branch_id, Card_No, Date_Out, Due_Date), 
LIBRARY_BRANCH(Branch_id, Branch_Name, Address) 
*/

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