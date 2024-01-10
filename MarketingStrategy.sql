SELECT
DISTINCT Member_Number, Total_Golf_Expenses, Total_Tennis_Expenses, Total_Pool_Expenses, Total_Other_Expenses
FROM comprehensive_summary ORDER BY Total_Golf_Expenses DESC LIMIT 10;

SELECT
Number_Of_Children,
SUM(Total_Dining_Consumption) AS Total_Dining_Spending, SUM(Total_Tennis_Expenses) AS Total_Tennis_Spending, SUM(Total_Pool_Expenses) AS Total_Pool_Spending, SUM(Total_Golf_Expenses) AS Total_Golf_Spending, SUM(Total_Other_Expenses) AS Total_Other_Spending
FROM comprehensive_summary GROUP BY Number_Of_Children ORDER BY Number_Of_Children;