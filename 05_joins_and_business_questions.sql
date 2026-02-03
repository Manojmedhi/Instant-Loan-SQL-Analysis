USE InstantLoanDB;

-- Active Loans with Customer Details


SELECT c.CustomerID, c.CustomerName, c.City, l.LoanID, l.LoanAmount, l.LoanStatus 
FROM Customers c LEFT JOIN Loans l ON c.CustomerID=l.CustomerID WHERE LoanStatus='Active';

-- Total Loan Amount per Customer (How much has each customer borrowed in total?)

SELECT c.CustomerName,SUM(l.LoanAmount) AS TotalLoanAmount
FROM Customers c LEFT JOIN Loans l ON c.CustomerID=l.CustomerID GROUP BY CustomerName;

-- Loan Repayment Summary (Loans + Repayments) (How much has been repaid for each loan?)

SELECT l.LoanID, l.LoanAmount, COALESCE(SUM(r.AmountPaid), 0) AS Loan_Amount_Repaid 
FROM Loans l LEFT JOIN Repayments r ON l.LoanID= r.LoanID GROUP BY l.LoanID, l.LoanAmount;

-- Customers with Overdue Loans (Who are the risky customers?)

SELECT c.CustomerName, l.LoanID, l.LoanStatus FROM Customers c LEFT JOIN Loans l ON c.CustomerID=l.CustomerID WHERE LoanStatus= 'Overdue'; 

-- Late Fees & Overdue Interest (How much penalty has been charged?)

SELECT c.CustomerID,c.CustomerName, l.LoanID, (lp.LateFee+lp.OverdueInterest) AS TotalPenalty FROM Late_Payments lp JOIN Loans l ON lp.LoanID= l.LoanID
JOIN Customers c ON l.CustomerID=c.CustomerID;

-- City-Wise Loan Distribution (Which cities have higher loan exposure?)

SELECT c.City, COUNT(l.LoanID) AS Num_Loans,SUM(l.LoanAmount) AS LOAN_AMOUNT FROM Customers c LEFT JOIN Loans l ON c.CustomerID= l.CustomerID GROUP BY c.City;


