CREATE DATABASE InstantLoanDB;

USE InstantLoanDB;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    RegistrationDate DATE
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanAmount DECIMAL(10,2),
    InterestRate DECIMAL(5,2),
    TenureMonths INT,
    LoanStatus VARCHAR(20),  -- Active, Closed, Overdue
    DisbursedDate DATE,

    CONSTRAINT FK_Loans_Customers
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Repayments (
    RepaymentID INT PRIMARY KEY,
    LoanID INT,
    PaymentDate DATE,
    AmountPaid DECIMAL(10,2),

    CONSTRAINT FK_Repayments_Loans
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

CREATE TABLE Late_Payments (
    LatePaymentID INT PRIMARY KEY,
    LoanID INT,
    LateFee DECIMAL(10,2),
    OverdueInterest DECIMAL(10,2),

    CONSTRAINT FK_LatePayments_Loans
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

