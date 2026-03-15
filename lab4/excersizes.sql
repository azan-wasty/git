--Q1
SELECT TOP 1 
    R.race_name, MAX(RR.completion_time) - MIN(RR.completion_time) AS TimeDifference
FROM Race R
JOIN Race_Result RR ON R.race_id = RR.race_id
GROUP BY R.race_name
ORDER BY TimeDifference ASC;

--Q2
SELECT TOP 1
    D.first_name, D.last_name, COUNT(RR.race_id) AS TotalWins, SUM(DR.reward_amount) AS TotalWinnings
FROM Driver D
JOIN Race_Result RR ON D.driver_id = RR.driver_id
LEFT JOIN Driver_Reward DR ON D.driver_id = DR.driver_id
WHERE RR.finishing_position = 1
GROUP BY D.driver_id, D.first_name, D.last_name
ORDER BY TotalWins DESC;