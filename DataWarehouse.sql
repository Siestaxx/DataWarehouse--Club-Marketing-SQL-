SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
DROP TABLE IF EXISTS comprehensive_summary; CREATE TABLE comprehensive_summary AS SELECT m.Member_Number,
m.First_Name,
m.Last_Name,
m.Gender,
m.BirthDate,
mem.Membership_Type,
mem.Year_Joined,
COALESCE(d.Total_Dining_Consumption, 0) AS Total_Dining_Consumption, COALESCE(t.Total_Tennis_Expenses, 0) AS Total_Tennis_Expenses, COALESCE(p.Total_Pool_Expenses, 0) AS Total_Pool_Expenses, COALESCE(g.Total_Golf_Expenses, 0) AS Total_Golf_Expenses, COALESCE(o.Total_Other_Expenses, 0) AS Total_Other_Expenses, COALESCE(c.Number_Of_Children, 0) AS Number_Of_Children, COALESCE(pr1.Promoone_Participation, 0) AS Promoone_Participation, COALESCE(pr2.Promotwo_Participation, 0) AS Promotwo_Participation
FROM members m
LEFT JOIN memberships mem ON m.Member_Number = mem.Member_Number LEFT JOIN (
SELECT Member_Number, SUM(Total) AS Total_Dining_Consumption FROM dining
GROUP BY Member_Number
) d ON m.Member_Number = d.Member_Number LEFT JOIN (
SELECT Member_Number, SUM(Amount) AS Total_Tennis_Expenses FROM tennis
GROUP BY Member_Number
) t ON m.Member_Number = t.Member_Number LEFT JOIN (
SELECT Member_Number, SUM(Amount) AS Total_Pool_Expenses FROM pool
GROUP BY Member_Number
) p ON m.Member_Number = p.Member_Number LEFT JOIN (
SELECT Member_Number, SUM(Amount) AS Total_Golf_Expenses FROM golf
GROUP BY Member_Number
) g ON m.Member_Number = g.Member_Number LEFT JOIN (
SELECT Member_Number, SUM(Amount) AS Total_Other_Expenses
FROM other
GROUP BY Member_Number
) o ON m.Member_Number = o.Member_Number LEFT JOIN (
SELECT Member_Number, COUNT(Member_Number) AS Number_Of_Children FROM members
WHERE Relationship_to_Member = 'Child'
GROUP BY Member_Number
) c ON m.Member_Number = c.Member_Number LEFT JOIN (
SELECT Member_Number, COUNT(*) AS Promoone_Participation FROM promoone
GROUP BY Member_Number
) pr1 ON m.Member_Number = pr1.Member_Number LEFT JOIN (
SELECT Member_Number, COUNT(*) AS Promotwo_Participation FROM promotwo
GROUP BY Member_Number
) pr2 ON m.Member_Number = pr2.Member_Number; SELECT * FROM comprehensive_summary LIMIT 25;