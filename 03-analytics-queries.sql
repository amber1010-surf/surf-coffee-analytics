-- Total Revenue by Category
 
SELECT c.CategoryName,
       SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
FROM OrderItems oi
JOIN Products p ON oi.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY TotalRevenue DESC;


-- Top-Selling Products by Quantity
 
SELECT p.ProductName, SUM(oi.Quantity) AS UnitsSold
FROM OrderItems oi
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY UnitsSold DESC;


-- Revenue by Store
 
SELECT s.StoreName,
       SUM(oi.Quantity * oi.UnitPrice) AS Revenue
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Stores s ON o.StoreID = s.StoreID
GROUP BY s.StoreName
ORDER BY Revenue DESC;


-- Surf vs. Coffee Sales Split
 
SELECT c.CategoryType,
       SUM(oi.Quantity * oi.UnitPrice) AS Revenue
FROM OrderItems oi
JOIN Products p ON oi.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryType;
 
-- Current stock levels for one store (e.g. G-Town Shop, Cork = StoreID 3)
SELECT s.StoreName, p.ProductName, st.QuantityOnHand, st.ReorderLevel
FROM Stock st
JOIN Stores s ON st.StoreID = s.StoreID
JOIN Products p ON st.ProductID = p.ProductID
WHERE st.StoreID = 3
ORDER BY p.ProductName;
 