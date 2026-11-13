-- Library Database

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