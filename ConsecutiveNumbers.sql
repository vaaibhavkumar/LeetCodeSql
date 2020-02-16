;With OrderedDataAndConsecutiveNums AS 
(
    SELECT 
        Id, 
        Num, 
        LEAD(Num,1,1) OVER (Partition by Id ORDER by Id) AS Num_Next1,
        LEAD(Num,2,1) OVER (Partition by Id ORDER by Id) AS Num_Next2
    FROM 
    (    SELECT TOP 100 PERCENT Id, Num 
    FROM Logs Order by Id    ) AS InnerTable1
)
SELECT DISTINCT Num AS ConsecutiveNums FROM OrderedDataAndConsecutiveNums
WHERE Num = Num_Next1 
AND Num = Num_Next2
