DROP TABLE Transactions CASCADE CONSTRAINTS PURGE;
DROP TABLE toys CASCADE CONSTRAINTS PURGE;
DROP TABLE Category CASCADE CONSTRAINTS PURGE;
DROP TABLE Customers CASCADE CONSTRAINTS PURGE;

CREATE TABLE customers(
CustId NUMBER PRIMARY KEY,
CustName VARCHAR2(10) NOT NULL,
CustType CHAR(1)
);


CREATE TABLE Category(
CId CHAR(4) PRIMARY KEY CHECK (CId Like 'C%'),
CName VARCHAR2(15) 
);

CREATE TABLE toys(
ToyId CHAR(5) PRIMARY KEY CHECK (ToyId  Like 'T%'),
ToyName VARCHAR2(50) UNIQUE NOT NULL,
CId CHAR(4) NOT NULL REFERENCES Category(CId),
Price NUMBER NOT NULL CHECK (Price > 0),
Stock NUMBER NOT NULL);



CREATE TABLE Transactions
(
TxnId NUMBER  PRIMARY KEY,
CustId NUMBER  REFERENCES Customers(CustId),
ToyId CHAR(5)  REFERENCES Toys(ToyId),
Quantity NUMBER ,
TxnCost NUMBER);


COMMIT;

DELETE FROM Transactions;
DELETE FROM toys;
DELETE FROM Category;
DELETE FROM Customers;



INSERT INTO Customers VALUES (101,'Tom','R');
INSERT INTO Customers VALUES (102,'Harry',NULL);
INSERT INTO Customers VALUES (103,'Dick','P');
INSERT INTO Customers VALUES (104,'JoY','P');



INSERT INTO Category VALUES ('C101','Vehicles');
INSERT INTO Category VALUES ('C102','Musical');
INSERT INTO Category VALUES ('C103','Dolls');
INSERT INTO Category VALUES ('C104','Craft');



INSERT INTO Toys VALUES ('T1001','GT Racing Car','C101',500,40);
INSERT INTO Toys VALUES ('T1002','Hummer Monster Car','C101',600,20);
INSERT INTO Toys VALUES ('T1003','ThunderBot Car','C101',700,15);
INSERT INTO Toys VALUES ('T1004','Ken Beat','C102',150,20);
INSERT INTO Toys VALUES ('T1005','Drummer','C102',200,10);					
INSERT INTO Toys VALUES ('T1006','Kelly','C103',150,13);
INSERT INTO Toys VALUES ('T1007','Barbie','C103',550,40);					


INSERT INTO Transactions VALUES (1000,103,'T1006',5,2750);
INSERT INTO Transactions VALUES (1001,104,'T1002',2,1200);
INSERT INTO Transactions VALUES (1002,103,'T1005',3,600);
INSERT INTO Transactions VALUES (1003,101,'T1001',1,500);
INSERT INTO Transactions VALUES (1004,101,'T1004',3,450);
INSERT INTO Transactions VALUES (1005,103,'T1003',3,2100);
INSERT INTO Transactions VALUES (1006,104,'T1003',4,2400);

COMMIT;

