INSERT INTO EMPLOYEE VALUES
('E001','John Seo','Bangalore','M',60000,NULL,1),
('E002','Alice Kim','Mysore','F',55000,'E001',1),
('E003','Bob Lee','Hubli','M',70000,'E001',2),
('E004','Carol Seo','Delhi','F',80000,'E003',2),
('E005','David Park','Bangalore','M',50000,NULL,3),
('E006','Eva Wong','Mysore','F',65000,'E005',3);

INSERT INTO DEPARTMENT VALUES
(1,'Accounts','E001','2020-01-01'),
(2,'Sales','E003','2021-03-15'),
(3,'IT','E005','2022-06-01');

INSERT INTO DLOCATION VALUES
(1,'Bangalore'),
(2,'Delhi'),
(3,'Mysore');

INSERT INTO PROJECT VALUES
(101,'ProjectA','Bangalore',1),
(102,'ProjectB','Delhi',2),
(103,'IoT','Mysore',3),
(104,'ProjectC','Bangalore',1),
(105,'ProjectD','Delhi',2);

INSERT INTO WORKS_ON VALUES
('E001',101,40),
('E002',101,20),
('E003',102,30),
('E004',102,25),
('E005',103,35),
('E006',103,40),
('E001',104,10),
('E003',105,15);