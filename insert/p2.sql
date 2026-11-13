-- Sales Order Database

INSERT INTO SALESMAN VALUES
(1000,'Amit','Bangalore',0.15),
(1001,'Ravi','Mysore',0.12),
(1002,'Neha','Chennai',0.14),
(1003,'Rahul','Delhi',0.13),
(1004,'Kiran','Bangalore',0.10);

INSERT INTO CUSTOMER VALUES
(2000,'Nithya','Bangalore',200,1000),
(2001,'Arun','Mysore',150,1001),
(2002,'Deepa','Chennai',180,1002),
(2003,'Vikram','Bangalore',250,1000),
(2004,'Kavya','Delhi',190,1003),
(2005,'Priya','Bangalore',220,1004);

INSERT INTO ORDERS VALUES
(3000,5000,'2024-04-10',2000,1000),
(3001,7000,'2024-04-10',2003,1000),
(3002,3500,'2024-04-10',2001,1001),
(3003,4200,'2024-04-10',2002,1002),
(3004,9000,'2024-04-10',2004,1003),
(3005,8000,'2024-04-10',2005,1004);
