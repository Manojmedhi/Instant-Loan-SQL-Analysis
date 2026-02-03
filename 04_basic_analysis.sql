USE InstantLoanDB;

-- TOTAL LOAN AMOUNT DISBURSED

SELECT SUM(LoanAmount) AS TotalLoanDisbursed FROM Loans;

-- Number of Loans by Status (Active / Closed / Overdue)

SELECT LoanStatus, COUNT(*) AS Loan_Count FROM Loans GROUP BY LoanStatus;

-- Total Loan Amount by Status

SELECT LoanStatus, SUM(LoanAmount) AS Total_Loan_Amount FROM Loans GROUP BY LoanStatus;

-- Customers with More Than One Loan

SELECT CustomerID, COUNT(LoanID) AS Total_Loans FROM Loans GROUP BY CustomerID HAVING COUNT(LoanID)>1;

-- Total Repayment Collected So Far

SELECT SUM(AmountPaid) AS Total_repayment_collected FROM Repayments;

-- Loan-wise Repayment Amount

SELECT LoanID, SUM(AmountPaid) AS RepaymentAmount FROM Repayments GROUP BY LoanID;

