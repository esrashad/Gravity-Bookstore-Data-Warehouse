/*this scritp for DDL DWH 
Author: 
Date:
Breif: Gravity BookStore DWH
*/

/******************************************************************/
CREATE TABLE dim_customer(
	customer_key INT IDENTITY(1,1) PRIMARY KEY,    -- Surrogate key
	customer_id_bk INT NOT NULL,                   -- Business key
	first_name VARCHAR(200),
    last_name VARCHAR(200),
    email VARCHAR(350),
	ssc TinyINT,
    start_date DATETIME2,
    end_date DATETIME2,
    is_current TinyINT
);
GO
/******************************************************************/
CREATE TABLE dim_book(
book_key INT IDENTITY(1,1) PRIMARY KEY,   -- surrogate key
book_id_bk INT NOT NULL,                  -- business key
title VARCHAR(400),
isbn13 VARCHAR(13),
num_pages INT,
publication_date DATE,
language_id_bk INT,
language_code VARCHAR(8),
language_name VARCHAR(50),
publisher_id_bk INT NOT NULL,
publisher_name  NVARCHAR(1000),   -- keep as NVARCHAR
ssc TinyINT,
start_date DATETIME2,
end_date DATETIME2,
is_current TinyINT
);
GO
/******************************************************************/
CREATE TABLE dbo.dim_address(
address_key INT IDENTITY(1,1) PRIMARY KEY,
address_id_bk INT NOT NULL,
street_num VARCHAR(10),
street_name VARCHAR(200),
city VARCHAR(100),
country_id_bk INT NOT NULL,
country_name VARCHAR(200),
status_id_bk INT,
address_status VARCHAR(30),
ssc TinyINT,
start_date DATETIME2,
end_date DATETIME2,
is_current TinyINT
);
GO
/******************************************************************/
CREATE TABLE dbo.dim_author(
author_key INT IDENTITY(1,1) PRIMARY KEY,
author_id_bk INT NOT NULL,
author_name VARCHAR(400),
ssc TinyINT,
);
GO
/******************************************************************/
CREATE TABLE dbo.bridge_book_author (
    book_id_fk   INT NOT NULL,

    author_id_fk INT NOT NULL,
    CONSTRAINT PK_bridge_book_author PRIMARY KEY (book_id_fk, author_id_fk),
    CONSTRAINT FK_BridgeBookAuthor_DimBook FOREIGN KEY (book_id_fk) REFERENCES dbo.dim_book(book_key),
    CONSTRAINT FK_BridgeBookAuthor_DimAuthor FOREIGN KEY (author_id_fk) REFERENCES dbo.dim_author(author_key)
);
GO
/******************************************************************/
CREATE TABLE dbo.bridge_customer_address(
    address_id_fk INT NOT NULL,
    customer_id_fk INT NOT NULL,
    CONSTRAINT PK_bridge_customer_address PRIMARY KEY (address_id_fk, customer_id_fk),
    CONSTRAINT FK_BridgeCustomerAddress_DimAddress FOREIGN KEY (address_id_fk) REFERENCES dbo.dim_address(address_key),
    CONSTRAINT FK_BridgeCustomerAddress_DimCustomer FOREIGN KEY (customer_id_fk) REFERENCES dbo.dim_customer(customer_key)
);
GO
/******************************************************************/
CREATE TABLE dim_shipping_method(
method_key INT IDENTITY(1,1) PRIMARY KEY,
method_id_bk INT NOT NULL,
method_name VARCHAR(100),
ssc TinyINT,
start_date DATETIME2,
end_date DATETIME2,
is_current TinyINT
);
GO

--INSERT INTO dim_order_history_status    -- handle NULLS
--(history_id_bk, status_id_bk, status_value, status_date, status_time, ssc)
--VALUES (-1, NULL, 'Unknown', NULL, NULL, 0);
/******************************************************************/
CREATE TABLE dim_order_history_status(
history_key INT IDENTITY(1,1) PRIMARY KEY,
history_id_bk INT NOT NULL,
status_id_bk INT,
status_value VARCHAR(20),
status_date DATE,
status_time TIME,
ssc TinyINT
);

ALTER TABLE [dbo].[dim_order_history_status]
ALTER COLUMN status_time TIME;
GO
/******************************************************************/
CREATE TABLE fact_orders(
    fact_orders_key INT IDENTITY(1,1) PRIMARY KEY,
    order_id_bk INT NOT NULL,  
    

    book_id_fk INT NOT NULL,
    history_id_fk INT NOT NULL,
    method_id_fk INT NOT NULL,
    customer_id_fk INT NOT NULL,
    order_date_id_fk INT NOT NULL,
    order_time_id_fk INT NOT NULL,
    

    price DECIMAL(10,2),
    shipping_cost DECIMAL(10,2),
    ssc TinyINT,
    CONSTRAINT FK_FactBook_DimBook FOREIGN KEY (book_id_fk) REFERENCES dim_book(book_key),
    CONSTRAINT FK_FactOrder_HistoryStatus FOREIGN KEY (history_id_fk) REFERENCES dim_order_history_status(history_key),
    CONSTRAINT FK_FactOrder_ShippingMethod FOREIGN KEY (method_id_fk) REFERENCES dim_shipping_method(method_key),
    CONSTRAINT FK_FactOrder_Customer FOREIGN KEY (customer_id_fk) REFERENCES dim_customer(customer_key),
    CONSTRAINT FK_FactOrder_OrderDate FOREIGN KEY (order_date_id_fk) REFERENCES Dim_Date(Date_SK),
    CONSTRAINT FK_FactOrder_OrderTime FOREIGN KEY (order_time_id_fk) REFERENCES Dim_Time(Time_SK)
);
GO
