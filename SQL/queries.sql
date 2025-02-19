--  Identify the most expensive product.
SELECT ProductName, Price
FROM Products
ORDER BY Price DESC
LIMIT 1

-- Retrieve Employee Names and Their Handled Orders
SELECT Employees.FirstName, Employees.LastName, Orders.OrderID, Orders.OrderDate
FROM Employees
INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID;

-- Count the number of orders each customer has placed 
-- Identify the top 5 customers who placed the most orders.
SELECT Customers.CustomerName, COUNT(Orders.OrderID) As TotalOrders
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
ORDER BY TotalOrders DESC
LIMIT 5;

-- Calculate total revenue per product.
SELECT prod.ProductName, SUM(ord.Quantity*prod.Price) As TotalRevenue
FROM Products prod
INNER JOIN OrderDetails ord ON ord.ProductID = prod.ProductID
GROUP BY prod.ProductName
ORDER BY TotalRevenue DESC;

-- Get total sales per month.
SELECT to_char(OrderDate, 'YYYY-MM') AS OrderMonth, COUNT(OrderID) as Sales
FROM Orders
GROUP BY OrderMonth
ORDER BY OrderMonth DESC;

-- Identify the Most Popular Product
SELECT prod.ProductName, SUM(ord.Quantity) As TotalQuantity
FROM Products prod
INNER JOIN OrderDetails ord ON prod.ProductID = ord.ProductID
GROUP BY prod.ProductName
ORDER BY TotalQuantity DESC
Limit 1

-- Retrieve Orders Shipped by a Specific Shipper
SELECT Orders.OrderID, Orders.OrderDate, Shippers.ShipperName
FROM Orders
JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
WHERE Shippers.ShipperName = 'Speedy Express';

-- Find Customers Who Have Not Placed Any Orders
SELECT cust.CustomerID, cust.CustomerName
FROM Customers cust
LEFT JOIN Orders ord ON ord.CustomerID = cust.CustomerID
WHERE ord.OrderID IS NULL

-- Rank employees based on the number of orders they handled.
SELECT Employees.FirstName, Employees.LastName, COUNT(Orders.OrderID) AS OrderCount
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID
ORDER BY OrderCount DESC;

-- Find the Second Most Expensive Product
SELECT ProductName, Price
FROM Products
ORDER BY Price DESC
LIMIT 1 OFFSET 1;

SELECT ProductName, Price 
FROM Products
WHERE Price = (
    SELECT MAX(Price) 
    FROM Products 
    WHERE Price < (SELECT MAX(Price) FROM Products)
);

-- Customers Who Have Ordered More Than the Average number of orders 

SELECT CustomerID, COUNT(OrderID) AS Total_Orders
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > (
	SELECT AVG(Total_Orders) 
	FROM (
	    SELECT CustomerID, COUNT(OrderID) AS Total_Orders
	    FROM Orders
	    GROUP BY CustomerID
	) AS OrderCounts
)
ORDER BY Total_Orders DESC;

-- Alternative with WITH for Readability
WITH OrderCounts AS (
    SELECT CustomerID, COUNT(OrderID) AS Total_Orders
    FROM Orders
    GROUP BY CustomerID
),
AvgOrders AS (
    SELECT AVG(Total_Orders) AS AvgOrderCount FROM OrderCounts
)
SELECT CustomerID, Total_Orders
FROM OrderCounts
WHERE Total_Orders > (SELECT AvgOrderCount FROM AvgOrders)
ORDER BY Total_Orders DESC;

-- Rank products based on total revenue using the RANK() window function.
SELECT ProductName, 
       SUM(Quantity * Price) AS TotalRevenue,
       RANK() OVER (ORDER BY SUM(Quantity * Price) DESC) AS Rank
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY ProductName;

-- Find the top 3 employees who handled the most orders per year
-- You need the top 3 each year
WITH Employee_ranking AS (
	SELECT emp.employeeID,emp.FirstName, emp.LastName, 
		   EXTRACT(YEAR FROM ord.OrderDate) AS OrderYear,
		   COUNT(ord.OrderID) As Total_orders,
		   RANK() OVER(
		   				PARTITION BY EXTRACT(YEAR FROM ord.OrderDate) 
						ORDER BY COUNT(ord.OrderID) DESC
					   ) As Ranking		
	FROM Employees emp
	JOIN Orders ord ON emp.EmployeeID = ord.EmployeeID
	GROUP BY emp.EmployeeID,EXTRACT(YEAR FROM ord.OrderDate)
)

SELECT employeeID,FirstName,LastName,OrderYear,Ranking
FROM Employee_ranking
WHERE Ranking <=3

-- Customers Who Ordered the Most Expensive Product
SELECT Customers.CustomerID, Customers.CustomerName
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE OrderDetails.ProductID = (SELECT ProductID FROM Products ORDER BY Price DESC LIMIT 1)

-- Identify customers who placed two or more orders within a 7-day window
WITH OrderHistory AS (
    SELECT CustomerID, OrderID, OrderDate,
           LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrderDate
    FROM Orders
)
SELECT CustomerID, OrderID, OrderDate, NextOrderDate
FROM OrderHistory
WHERE NextOrderDate IS NOT NULL
AND NextOrderDate - OrderDate <= INTERVAL '7 days';

-- Employees Who Have Processed More Orders Than The Average
WITH EmployeeOrders AS (
    SELECT EmployeeID, COUNT(OrderID) AS TotalOrders
    FROM Orders
    GROUP BY EmployeeID
)
SELECT Employees.EmployeeID, FirstName, LastName, TotalOrders
FROM EmployeeOrders
JOIN Employees ON EmployeeOrders.EmployeeID = Employees.EmployeeID
WHERE TotalOrders > (SELECT AVG(TotalOrders) FROM EmployeeOrders);

-- Total Revenue per category
SELECT Categories.CategoryName, SUM(OrderDetails.Quantity * Products.Price) AS TotalRevenue
FROM Categories
JOIN Products ON Categories.CategoryID = Products.CategoryID
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Categories.CategoryName
ORDER BY TotalRevenue DESC

-- Find Customers Who Have Ordered From More Than 3 Different Product Categories
SELECT CustomerID, COUNT(DISTINCT CategoryID) AS CategoryCount
FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY CustomerID
HAVING COUNT(DISTINCT CategoryID) > 3;

-- Find the customer who placed the most orders each year.
WITH CustomerOrderCounts AS (
    SELECT 
        o.CustomerID, 
        c.CustomerName,
        EXTRACT(YEAR FROM o.OrderDate) AS OrderYear, 
        COUNT(o.OrderID) AS TotalOrders,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM o.OrderDate) 
            ORDER BY COUNT(o.OrderID) DESC
        ) AS Rank
    FROM Orders o
    JOIN Customers c ON o.CustomerID = c.CustomerID
    GROUP BY o.CustomerID, c.CustomerName, OrderYear
)
SELECT CustomerID, CustomerName, OrderYear, TotalOrders
FROM CustomerOrderCounts
WHERE Rank = 1;

-- Identify the Top 3 Products Sold Each Month
WITH ProductSales AS (
    SELECT 
        p.ProductID,
        p.ProductName,
        EXTRACT(YEAR FROM o.OrderDate) AS OrderYear,
        EXTRACT(MONTH FROM o.OrderDate) AS OrderMonth,
        SUM(od.Quantity) AS TotalQuantitySold,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM o.OrderDate), EXTRACT(MONTH FROM o.OrderDate) 
            ORDER BY SUM(od.Quantity) DESC
        ) AS Rank
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY p.ProductID, p.ProductName, OrderYear, OrderMonth
)
SELECT ProductID, ProductName, OrderYear, OrderMonth, TotalQuantitySold
FROM ProductSales
WHERE Rank <= 3;

