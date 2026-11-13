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
SELECT S.Salesman_id, S.Name, S.City, 'Has Customer' Status
FROM SALESMAN S JOIN CUSTOMER C USING (Salesman_id, City)
UNION
SELECT Salesman_id, Name, City, 'No Customer'
FROM SALESMAN S
WHERE NOT EXISTS (
  SELECT 1 FROM CUSTOMER C
  WHERE C.Salesman_id = S.Salesman_id AND C.City = S.City
);
-- Q4 Create a view that finds the salesman who has the customer with the highest order of a day.
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

-- Q5 Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted.
DELETE FROM SALESMAN WHERE Salesman_id = 1000;
