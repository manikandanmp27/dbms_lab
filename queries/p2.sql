-- Sales Order Database

-- Q1 Count the customers with grades above Bangalore's average.
SELECT COUNT(*) AS Count_Above_Avg
FROM CUSTOMER
WHERE Grade > (SELECT AVG(Grade) FROM CUSTOMER
               WHERE City = 'Bangalore');

-- Q2 Find the name and numbers of all salesman who had more than one customer.
SELECT S.Salesman_id, S.Name, COUNT(*) Customers
FROM SALESMAN S JOIN CUSTOMER C USING (Salesman_id)
GROUP BY S.Salesman_id
HAVING COUNT(*) > 1;

-- Q3 List all the salesman and indicate those who have and don't have customers in their cities (Use UNION operation).
SELECT Salesman_id, Name, City, 'Has Customer' AS Status
FROM SALESMAN
WHERE (Salesman_id, City) IN (SELECT Salesman_id, City FROM CUSTOMER)
UNION
SELECT Salesman_id, Name, City, 'No Customer'
FROM SALESMAN
WHERE (Salesman_id, City) NOT IN (SELECT Salesman_id, City FROM CUSTOMER);

-- Q4 Create a view that finds the salesman who has the customer with the highest order of a day.
CREATE VIEW Highest_Order_Salesman AS
SELECT S.Salesman_id, S.Name, C.Cust_Name, O.Ord_No, O.Purchase_Amt, O.Ord_Date
FROM SALESMAN S 
JOIN ORDERS O USING (Salesman_id)
JOIN CUSTOMER C USING (Customer_id)
WHERE (Ord_Date, Purchase_Amt) IN (
  SELECT Ord_Date, MAX(Purchase_Amt) 
  FROM ORDERS 
  GROUP BY Ord_Date
);

SELECT * FROM Highest_Order_Salesman;

-- Q5 Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted.
DELETE FROM SALESMAN WHERE Salesman_id = 1000;
