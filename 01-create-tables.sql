Delete From Stock
Delete From OrderItems
Delete From Orders
Delete From Customers
Delete From Employees
Delete From Stores
Delete From Products
Delete From Categories

Drop TABLE Stock
Drop Table OrderItems
Drop TABLE Orders
Drop Table Customers
Drop Table Employees
Drop TABLE Stores
Drop Table Products
Drop Table Categories

CREATE TABLE Categories (
    CategoryID   INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL,
    CategoryType NVARCHAR(20) NOT NULL -- 'Surf', 'Coffee' e.g.
);
 
CREATE TABLE Products (
    ProductID    INT IDENTITY(1,1) PRIMARY KEY,
    ProductName  NVARCHAR(100) NOT NULL,
    CategoryID   INT NOT NULL FOREIGN KEY REFERENCES Categories(CategoryID),
    UnitPrice    DECIMAL(10,2) NOT NULL,
    IsActive     BIT DEFAULT 1
);
 
CREATE TABLE Stores (
    StoreID      INT IDENTITY(1,1) PRIMARY KEY,
    StoreName    NVARCHAR(100) NOT NULL,
    City         NVARCHAR(50),
    StoreType    NVARCHAR(20) -- 'Beachfront', 'Downtown', 'Online'
);
 
CREATE TABLE Employees (
    EmployeeID   INT IDENTITY(1,1) PRIMARY KEY,
    FirstName    NVARCHAR(50) NOT NULL,
    LastName     NVARCHAR(50) NOT NULL,
    StoreID      INT NOT NULL FOREIGN KEY REFERENCES Stores(StoreID),
    HireDate     DATE NOT NULL
);
 
CREATE TABLE Customers (
    CustomerID   INT IDENTITY(1,1) PRIMARY KEY,
    FirstName    NVARCHAR(50) NOT NULL,
    LastName     NVARCHAR(50) NOT NULL,
    Email        NVARCHAR(100),
    SignupDate   DATE DEFAULT GETDATE()
);
 
CREATE TABLE Orders (
    OrderID      INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID   INT NOT NULL FOREIGN KEY REFERENCES Customers(CustomerID),
    StoreID      INT NOT NULL FOREIGN KEY REFERENCES Stores(StoreID),
    EmployeeID   INT NOT NULL FOREIGN KEY REFERENCES Employees(EmployeeID),
    OrderDate    DATETIME NOT NULL DEFAULT GETDATE()
);
 
CREATE TABLE OrderItems (
    OrderItemID  INT IDENTITY(1,1) PRIMARY KEY,
    OrderID      INT NOT NULL FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID    INT NOT NULL FOREIGN KEY REFERENCES Products(ProductID),
    Quantity     INT NOT NULL,
    UnitPrice    DECIMAL(10,2) NOT NULL -- price at time of sale
);

CREATE TABLE Stock (
    StockID             INT IDENTITY(1,1) PRIMARY KEY,
    StoreID             INT NOT NULL FOREIGN KEY REFERENCES Stores(StoreID),
    ProductID           INT NOT NULL FOREIGN KEY REFERENCES Products(ProductID),
    QuantityOnHand      INT NOT NULL DEFAULT 0,
    ReorderLevel        INT NOT NULL DEFAULT 5,
    LastRestockedDate   DATE NULL,
    CONSTRAINT UQ_Stock_Store_Product UNIQUE (StoreID, ProductID)
);