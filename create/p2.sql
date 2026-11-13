/*
Sales_Order Database   
Schema: 
SALESMAN(Salesman_id, Name, City, Commission), 
CUSTOMER(Customer_id, Cust_Name, City, Grade, Salesman_id), 
ORDERS(Ord_No, Purchase_Amt, Ord_Date, Customer_id, Salesman_id)
*/

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
