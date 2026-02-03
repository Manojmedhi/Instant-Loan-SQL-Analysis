USE InstantLoanDB;

-- How does repayment grow over time for each loan? (Running Total of Repayments)

SELECT
    r.LoanID,
    r.PaymentDate,
    r.AmountPaid,
    SUM(r.AmountPaid) OVER (
        PARTITION BY r.LoanID
        ORDER BY r.PaymentDate
    ) AS Running_Repaid_Amount
FROM Repayments r;

-- Outstanding Amount After Each Payment (After each payment, how much is still pending?)

SELECT
    r.LoanID,
    r.PaymentDate,
    r.AmountPaid,
    l.LoanAmount,
    l.LoanAmount
      - COALESCE(
            SUM(r.AmountPaid) OVER (
                PARTITION BY r.LoanID
                ORDER BY r.PaymentDate
            ),
            0
        ) AS Outstanding_Amount
FROM Repayments r
JOIN Loans l
ON r.LoanID = l.LoanID;

-- Rank Customers by Total Loan Amount (Who are the top borrowers?)

SELECT
    c.CustomerName,
    SUM(l.LoanAmount) AS Total_Loan,
    RANK() OVER (
        ORDER BY SUM(l.LoanAmount) DESC
    ) AS Loan_Rank
FROM Customers c
JOIN Loans l
ON c.CustomerID = l.CustomerID
GROUP BY c.CustomerName;


-- NTILE – Customer Segmentation (Divide customers into risk/value buckets.)

SELECT
    c.CustomerName,
    SUM(l.LoanAmount) AS Total_Loan,
    NTILE(3) OVER (
        ORDER BY SUM(l.LoanAmount) DESC
    ) AS Customer_Bucket
FROM Customers c
JOIN Loans l
ON c.CustomerID = l.CustomerID
GROUP BY c.CustomerName;


SELECT *
FROM (
    SELECT
        LoanID,
        PaymentDate,
        LAG(PaymentDate) OVER (
            PARTITION BY LoanID
            ORDER BY PaymentDate
        ) AS Previous_Payment_Date
    FROM Repayments
) t
WHERE DATEDIFF(day, Previous_Payment_Date, PaymentDate) > 40;