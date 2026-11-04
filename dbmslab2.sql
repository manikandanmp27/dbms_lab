--Program 2:Sales order
--Q1
SELECT COUNT(*) AS Count_Above_Avg
FROM CUSTOMER
WHERE Grade > (SELECT AVG(Grade) FROM CUSTOMER
               WHERE City = 'Bangalore');

--Q2
SELECT S.Salesman_id, S.Name, COUNT(*) Customers
FROM SALESMAN S JOIN CUSTOMER C USING (Salesman_id)
GROUP BY S.Salesman_id
HAVING COUNT(*) > 1;

--Q3
SELECT S.Salesman_id, S.Name, S.City, 'Has Customer' Status
FROM SALESMAN S JOIN CUSTOMER C USING (Salesman_id, City)
UNION
SELECT Salesman_id, Name, City, 'No Customer'
FROM SALESMAN S
WHERE NOT EXISTS (
  SELECT 1 FROM CUSTOMER C
  WHERE C.Salesman_id = S.Salesman_id AND C.City = S.City
);
--Q4
CREATE VIEW Highest_Order_Salesman AS
SELECT S.Salesman_id, S.Name, C.Cust_Name, O.Ord_No,
       O.Purchase_Amt, O.Ord_Date
FROM SALESMAN S JOIN ORDERS O USING (Salesman_id)
JOIN CUSTOMER C USING (Customer_id)
WHERE O.Purchase_Amt = (
  SELECT MAX(Purchase_Amt) FROM ORDERS
  WHERE Ord_Date = O.Ord_Date
);

SELECT * FROM Highest_Order_Salesman;
--Q5
DELETE FROM SALESMAN WHERE Salesman_id = 1000;


CREATE DATABASE sales_order;
USE sales_order;

CREATE TABLE SALESMAN (
    Salesman_id INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50),
    Commission FLOAT
);

CREATE TABLE CUSTOMER (
    Customer_id INT PRIMARY KEY,
    Cust_Name VARCHAR(50),
    City VARCHAR(50),
    Grade INT,
    Salesman_id INT,
    FOREIGN KEY (Salesman_id) REFERENCES SALESMAN(Salesman_id)
);

CREATE TABLE ORDERS (
    Ord_No INT PRIMARY KEY,
    Purchase_Amt FLOAT,
    Ord_Date DATE,
    Customer_id INT,
    Salesman_id INT,
    FOREIGN KEY (Customer_id) REFERENCES CUSTOMER(Customer_id),
    FOREIGN KEY (Salesman_id) REFERENCES SALESMAN(Salesman_id)
);

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