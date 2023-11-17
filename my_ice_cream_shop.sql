-- Create the database
DROP DATABASE IF EXISTS ice_cream_shop;
CREATE DATABASE ice_cream_shop;
USE ice_cream_shop;

-- Create tables
CREATE TABLE customers (
    customer_id INT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email_address VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(12) NOT NULL,
    address_id INT NOT NULL,
    visit_count INT DEFAULT 0
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    phone_number CHAR(12),
    address VARCHAR(255) NOT NULL,
    job_title VARCHAR(50),
    hire_date DATE,
    salary DECIMAL(10 , 2 ),
    manager_id INT,
    CONSTRAINT FK_manager_id FOREIGN KEY (manager_id)
        REFERENCES employees (employee_id)
);

CREATE TABLE financial_data (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_date DATE NOT NULL,
    transaction_type ENUM('Revenue', 'Cost') NOT NULL,
    description VARCHAR(255) NOT NULL,
    amount DECIMAL(10 , 2 ) NOT NULL,
    category VARCHAR(50) NOT NULL
);

     	 
CREATE TABLE orders (
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT NULL,
    card_number CHAR(16) NOT NULL,
    card_type VARCHAR(255) NOT NULL,
    tax_amount DECIMAL(10 , 2 ),
    discount_amount DECIMAL(10 , 2 ),
    gross_amount DECIMAL(10 , 2 ),
    net_amount DECIMAL(10 , 2 )
);

CREATE TABLE products (
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    description TEXT,
    list_price DECIMAL(10 , 2 ) NOT NULL
);

CREATE TABLE order_items (
    item_id INT NOT NULL,
    order_id INT NOT NULL,
    inventory_id INT NOT NULL,
    item_price DECIMAL(8 , 2 ) NOT NULL,
    quantity INT DEFAULT 1
);
    
CREATE TABLE addresses (
    address_id INT NOT NULL,
    customer_id INT NOT NULL,
    line1 VARCHAR(60),
    line2 VARCHAR(60) DEFAULT NULL,
    city VARCHAR(30) NOT NULL,
    state CHAR(2) NOT NULL,
    zip_code CHAR(5) NOT NULL
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255) NOT NULL UNIQUE
);
    
CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT NOT NULL,
    inventory_name VARCHAR(255) NOT NULL,
    date_added DATETIME DEFAULT NULL,
    CONSTRAINT inventory_fk_categories FOREIGN KEY (category_id)
        REFERENCES categories (category_id)
);
    
-- Altering the tables to add pk and fk constraints
ALTER TABLE customers
MODIFY COLUMN customer_id INT AUTO_INCREMENT PRIMARY KEY,
MODIFY COLUMN address_id INT DEFAULT NULL;

ALTER TABLE employees
MODIFY COLUMN address VARCHAR(255);

ALTER TABLE orders
ADD CONSTRAINT order_pk PRIMARY KEY (order_id);

ALTER TABLE orders
ADD CONSTRAINT customer_fk_id
    FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id);
    
ALTER TABLE products
ADD CONSTRAINT product_pk PRIMARY KEY (product_id);

ALTER TABLE order_items
ADD CONSTRAINT items_id PRIMARY KEY (item_id);

ALTER TABLE order_items
ADD CONSTRAINT items_fk
    FOREIGN KEY (order_id)
	REFERENCES orders (order_id);
    
ALTER TABLE order_items
ADD CONSTRAINT items_fk_inventory
    FOREIGN KEY (inventory_id)
	REFERENCES inventory (inventory_id);

ALTER TABLE addresses
ADD CONSTRAINT addresses_pk PRIMARY KEY (address_id);

ALTER TABLE addresses
ADD CONSTRAINT addresses_fk
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id);

ALTER TABLE inventory
ADD CONSTRAINT inventory_fk
    FOREIGN KEY (category_id)
    REFERENCES categories(category_id);


-- Beginning data insertion
INSERT INTO customers (customer_id, first_name, last_name, email_address, phone_number, visit_count) VALUES
(1, 'Jack', 'Skelington', 'scaryguy1999@yahoo.com', 907-192-4545, 6),
(2, 'Sandy', 'Claws', 'charitableguy01@hotmail.com', 907-194-8793, 1),
(3, 'Bob', 'Ross', 'bobross@gmail.com', 425-867-5309, 104),
(4, 'Christopher', 'Walken', 'christopherwalken13@gmail.com', 425-784-1211, 3),
(5, 'Monica', 'Lewinsky', 'pennavenue0998@hotmail.com', 202-645-5459, 2),
(6, 'Robin', 'Williams', 'robinwilliamscomedyclub@aol.com', 362-540-9877, 15),
(7, 'Ben', 'Stiller', 'benstiller9124@gmail.com', 745-123-6784, 0),
(8, 'Michael', 'Jackson', 'michaeljackson@heehee.com', 981-657-1045, 22),
(9, 'Kobe', 'Bryant', 'helitours918@yahoo.com', 209-443-1874, 1),
(10, 'Joe', 'Bob', 'averagejoe1@gmail.com', 345-875-4574, 1704),
(11, 'Susie', 'Que', 'susieque87@yahoo.com', 202-748-6655, 2);

INSERT INTO orders (order_id, customer_id, order_date, card_number, card_type, tax_amount, discount_amount, gross_amount, net_amount) VALUES
(1, 8, '2015-03-28 09:40:28', 4204401811818539, 'Visa', 0.00, 5.75, 35.99, 30.24),
(2, 5,'2021-08-11 11:43:18', 6011308859848088, 'Discover', 2.50, 5.00, 15.99, 10.99),
(3, 6, '2020-01-15 04:55:04', 4130580335547150, 'Visa', 0.00, 0.00, 4.99, 4.99),
(4, 6, '2023-06-27 15:29:27', 4130580335547150, 'Visa', 0.00, 0.00, 6.99, 6.99),
(5, 3, '2020-08-28 08:38:48', 6011061932438175, 'Discover', 1.35, 0.00, 13.50, 13.50),
(6, 3, '2019-07-04 19:47:30', 345278630035653, 'AmericanExpress', 2.00, 1.00, 20.00, 19.00),
(7, 3, '2019-07-01 15:56:23', 345278630035653, 'AmericanExpress', 0.00, 2.00, 3.99, 1.99),
(8, 3, '2021-11-12 10:15:36', 345278630035653, 'AmericanExpress', 0.00, 8.50, 40.79, 32.29),
(9, 2, '2007-04-08 09:14:33', 5573187713675404, 'Mastercard',10.78, 6.00, 107.89, 101.89),
(10, 1, '2016-02-12 14:53:22', 4836857630762677, 'Visa', 0.00, 9.00, 90.00, 81.00),
(11, 5, '2004-02-15 07:32:21', 4061299498434097, 'Visa', 0.97, 0.00, 9.70, 9.70),
(12, 4, '2012-10-23 09:31:19', 4451789035150519, 'Visa', 0.00, 0.00, 15.99, 15.99);



-- Manager (Employee ID: 1)
INSERT INTO employees (first_name, last_name, date_of_birth, email, phone_number, address, job_title, hire_date, salary, manager_id)
VALUES
('Katy', 'Jakeman', '1990-05-03', 'katy.jakeman@gmail.com', '425-985-4581', '13434 124th Ave NE, Kirkland, WA 98034', 'Manager', '2023-05-20', 50000.00, NULL);

-- 5 Employees
INSERT INTO employees (first_name, last_name, date_of_birth, email, phone_number, address, job_title, hire_date, salary, manager_id)
VALUES
('Alice', 'Johnson', '1993-08-20', 'alice.j@gmail.com', '206-987-6543', '456 Elm St, Kirkland, WA 98033', 'Clerk', '2023-02-20', 40000.00, 1),
('Bob', 'Smith', '1988-11-30', 'bob.smith@gmail.com', '425-111-2222', '789 Oak St, Bellevue, WA 98048', 'Sales Rep', '2023-02-20', 45000.00, 1),
('Eva', 'Brown', '1995-04-05', 'eva.brown@gmail.com', '206-555-5555', '321 Pine St, Seattle, WA 98125', 'Clerk', '2023-02-20', 40000.00, 1),
('Daniel', 'Williams', '1991-10-10', 'daniel.w@gmail.com', '425-222-3333', '567 Cedar St, Kirkland, WA 98034', 'Sales Rep', '2023-02-20', 45000.00, 1),
('Sophia', 'Davis', '1992-06-15', 'sophia.d@gmail.com', '206-888-9999', '987 Birch St, Bellevue, WA 98038', 'Clerk', '2023-02-20', 40000.00, 1);


-- Financial data for the month of October
INSERT INTO financial_data (transaction_date, transaction_type, description, amount, category)
VALUES
('2023-10-01', 'Revenue', 'Sales of ice cream', 500.00, 'Sales'),
('2023-10-02', 'Cost', 'Purchase of ingredients', 200.00, 'Ingredients'),
('2023-10-03', 'Cost', 'Employee salaries', 350.00, 'Labor'),
('2023-10-04', 'Revenue', 'Sales of waffle cones', 150.00, 'Sales'),
('2023-10-05', 'Cost', 'Rent payment', 800.00, 'Overheads'),
('2023-10-06', 'Revenue', 'Sales of milkshakes', 300.00, 'Sales'),
('2023-10-07', 'Cost', 'Utility bills', 120.00, 'Overheads'),
('2023-10-08', 'Revenue', 'Sales of sundaes', 250.00, 'Sales'),
('2023-10-09', 'Revenue', 'Sales of ice cream', 600.00, 'Sales'),
('2023-10-10', 'Cost', 'Purchase of ingredients', 220.00, 'Ingredients'),
('2023-10-11', 'Cost', 'Employee salaries', 360.00, 'Labor'),
('2023-10-12', 'Revenue', 'Sales of waffle cones', 180.00, 'Sales'),
('2023-10-13', 'Cost', 'Rent payment', 820.00, 'Overheads'),
('2023-10-14', 'Revenue', 'Sales of milkshakes', 320.00, 'Sales'),
('2023-10-15', 'Cost', 'Utility bills', 130.00, 'Overheads'),
('2023-10-16', 'Revenue', 'Sales of sundaes', 270.00, 'Sales'),
('2023-10-17', 'Revenue', 'Sales of ice cream', 550.00, 'Sales'),
('2023-10-18', 'Cost', 'Purchase of ingredients', 210.00, 'Ingredients'),
('2023-10-19', 'Cost', 'Employee salaries', 340.00, 'Labor'),
('2023-10-20', 'Revenue', 'Sales of waffle cones', 160.00, 'Sales'),
('2023-10-21', 'Cost', 'Rent payment', 810.00, 'Overheads'),
('2023-10-22', 'Revenue', 'Sales of milkshakes', 310.00, 'Sales'),
('2023-10-23', 'Cost', 'Utility bills', 140.00, 'Overheads'),
('2023-10-24', 'Revenue', 'Sales of sundaes', 260.00, 'Sales'),
('2023-10-25', 'Revenue', 'Sales of ice cream', 540.00, 'Sales'),
('2023-10-26', 'Cost', 'Purchase of ingredients', 230.00, 'Ingredients'),
('2023-10-27', 'Cost', 'Employee salaries', 370.00, 'Labor'),
('2023-10-28', 'Revenue', 'Sales of waffle cones', 170.00, 'Sales'),
('2023-10-29', 'Cost', 'Rent payment', 830.00, 'Overheads'),
('2023-10-30', 'Revenue', 'Sales of milkshakes', 330.00, 'Sales'),
('2023-10-31', 'Cost', 'Utility bills', 150.00, 'Overheads');


INSERT INTO categories (category_id, category_name) VALUES
(1, 'Ice Cream Flavors'),
(2, 'Cone Flavors'),
(3, 'Equipment');


INSERT INTO inventory (inventory_id, category_id, inventory_name, date_added) VALUES
(1, 1, 'Vanilla', '2023-11-10'),
(2, 1, 'Chocolate', '2023-11-10'),
(3, 1, 'Cookies n Cream', '2023-11-10'),
(4, 1, 'Mint Chocolate Chip', '2023-11-10'),
(5, 1, 'Chocolate Chip Cookie Dough', '2023-11-10'),
(6, 1, 'Buttered Pecan', '2023-11-10'),
(7, 1, 'Cookie Dough', '2023-11-10'),
(8, 1, 'Strawberry', '2023-11-10'),
(9, 1, 'Moose Tracks', '2023-11-10'),
(10, 1, 'Neapolitan', '2023-11-10'),
(11, 2, 'Sugar Cone', '2023-11-12'),
(12, 2, 'Waffle Cone', '2023-11-12'),
(13, 3, 'Drop-in Bar Freezer', '2023-11-05'),
(14, 3, 'Reach-in Freezer', '2023-11-05'),
(15, 3, 'Walk-in Freezer', '2023-11-05'),
(16, 3, 'Refrigerated Display Case', '2023-11-05'),
(17, 3, 'Ice Machine', '2023-11-05'),
(18, 3, 'Cone Dispenser', '2023-11-05'),
(19, 3, 'Ice Cream Dishes', '2023-11-09'),
(20, 3, 'Ice Cream Scoops', '2023-11-09'),
(21, 3, 'Disposable Spoons', '2023-11-09');

INSERT INTO order_items (item_id, order_id, inventory_id, item_price, quantity) VALUES
(1, 1, 12, '65.00', 2),
(2, 2, 16, '489.99', 1),
(3, 9, 14, '3527.00', 1),
(4, 3, 4, '200.00', 1),
(5, 4, 9, '200.00', 2),
(6, 10, 6, '200.00', 4),
(7, 12, 11, '299.00', 1),
(8, 7, 9, '200.00', 3),
(9, 4, 21, '799.99', 1),
(10, 5, 13, '699.99', 1),
(11, 8, 7, '200.99', 2),
(12, 9, 20, '699.00', 1);
