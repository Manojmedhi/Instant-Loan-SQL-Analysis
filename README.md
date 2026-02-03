# Instant-Loan-SQL-Analysis
Project Overview

This project analyzes customer loan data for a digital lending company that provides instant loans through a mobile application. The goal is to derive business insights related to loan disbursement, repayments, customer behavior, and risk patterns using SQL.

This project demonstrates real-world data analyst skills including data extraction, transformation, and business insight generation.

🎯 Business Objective

The company wants to:

Track loan disbursement performance

Monitor repayment behavior

Identify risky customers

Improve collection efficiency

Understand customer loan patterns

🗂️ Dataset Description
1️⃣ Customers Table

Contains customer information.

Column	Description
CustomerID	Unique customer identifier
Name	Customer name
Age	Customer age
City	Customer location
RegistrationDate	Date customer joined
2️⃣ Loans Table

Contains loan details.

Column	Description
LoanID	Unique loan identifier
CustomerID	Linked customer
LoanAmount	Loan amount
LoanStatus	Active / Closed / Default
DisbursementDate	Loan approval date
3️⃣ Repayments Table

Contains repayment transactions.

Column	Description
RepaymentID	Unique repayment identifier
LoanID	Linked loan
PaymentDate	Repayment date
AmountPaid	Amount repaid
🧠 SQL Concepts Used

Joins (INNER, LEFT)

Aggregation Functions (SUM, COUNT, AVG)

GROUP BY & HAVING

Window Functions

ROW_NUMBER

DENSE_RANK

LAG / LEAD

Running Total

CTE (Common Table Expressions)

Subqueries

Conditional Aggregation

Data Cleaning using COALESCE

Business KPI calculations

📊 Business Analysis Queries
✅ Total Loans Issued
SELECT COUNT(*) AS Total_Loans
FROM Loans;

✅ Total Loan Amount Disbursed
SELECT SUM(LoanAmount) AS Total_Disbursed
FROM Loans;

✅ Total Repayment Per Loan
SELECT LoanID, SUM(AmountPaid) AS Total_Repaid
FROM Repayments
GROUP BY LoanID;

✅ Outstanding Loan Amount
SELECT
    l.LoanID,
    l.LoanAmount - COALESCE(SUM(r.AmountPaid),0) AS Outstanding_Amount
FROM Loans l
LEFT JOIN Repayments r
ON l.LoanID = r.LoanID
GROUP BY l.LoanID, l.LoanAmount;

✅ Running Repayment Balance
SELECT
    LoanID,
    PaymentDate,
    SUM(AmountPaid) OVER(
        PARTITION BY LoanID
        ORDER BY PaymentDate
    ) AS Running_Total
FROM Repayments;

✅ Customers with Increasing Repayment Pattern
SELECT *
FROM (
    SELECT
        LoanID,
        PaymentDate,
        AmountPaid,
        LAG(AmountPaid) OVER (
            PARTITION BY LoanID
            ORDER BY PaymentDate
        ) AS Previous_Amount
    FROM Repayments
) t
WHERE AmountPaid > Previous_Amount;

📈 Key Business Insights

✔ Identified customers with repayment delays
✔ Measured loan repayment performance
✔ Detected high-risk loan accounts
✔ Tracked outstanding loan balances
✔ Analyzed customer repayment growth trends

🚀 Tools Used

SQL Server Management Studio (SSMS)

T-SQL

Relational Database Design

GitHub for Version Control

🛠️ How to Run This Project

Clone this repository

Import dataset into SQL Server

Run table creation scripts

Execute analysis queries

📁 Project Structure
📦 Instant Loan SQL Project
 ┣ 📜 Tables_Creation.sql
 ┣ 📜 Sample_Data_Insert.sql
 ┣ 📜 Analysis_Queries.sql
 ┗ 📄 README.md

🧑‍💻 Skills Demonstrated

SQL Query Optimization

Data Aggregation & KPI Analysis

Financial Data Analysis

Problem-Solving Using SQL

Business Insight Development
