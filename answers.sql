-- Tell the engine which database I want to work with
USE salesDB;

-- Question 1: Build a Complete Database Management System
-- Choosen real-world use case:E-commerce Store

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Create Categories Table
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create OrderDetails Table (Many-to-Many relationship between Orders and Products)
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create ShippingAddress Table (One-to-One relationship with Customers)
CREATE TABLE ShippingAddress (
    AddressID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT UNIQUE,
    AddressLine1 VARCHAR(255) NOT NULL,
    AddressLine2 VARCHAR(255),
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100),
    PostalCode VARCHAR(20),
    Country VARCHAR(100) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Example Data Insertion for Categories
INSERT INTO Categories (CategoryName) VALUES ('Electronics'), ('Clothing'), ('Furniture');

-- Example Data Insertion for Products
INSERT INTO Products (ProductName, CategoryID, Price, StockQuantity) VALUES 
('Laptop', 1, 799.99, 50),
('T-shirt', 2, 19.99, 200),
('Sofa', 3, 499.99, 30);

-- Example Data Insertion for Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Elm St');

-- Example Data Insertion for Orders
INSERT INTO Orders (CustomerID, TotalAmount) VALUES
(1, 819.98),  -- Order for John Doe
(2, 499.99);  -- Order for Jane Smith

-- Example Data Insertion for OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 799.99),  -- John Doe ordered 1 Laptop
(1, 2, 1, 19.99),   -- John Doe ordered 1 T-shirt
(2, 3, 1, 499.99);  -- Jane Smith ordered 1 Sofa

-- Example Data Insertion for ShippingAddress
INSERT INTO ShippingAddress (CustomerID, AddressLine1, AddressLine2, City, State, PostalCode, Country) VALUES
(1, '123 Main St', NULL, 'New York', 'NY', '10001', 'USA'),
(2, '456 Elm St', 'Apt 2', 'Los Angeles', 'CA', '90001', 'USA');
