SELECT CLIENT_ID, GROUP_ID, FOR_YEAR, FOR_MONTH, Count(CAME) AS [Count-CAME]
FROM (SELECT TRAINING_ID, GROUP_ID, year(CREATE_DATE) AS FOR_YEAR, month(CREATE_DATE) AS FOR_MONTH FROM TRAINING)  AS T1
  INNER JOIN (SELECT CLIENT_ID, TRAINING_ID, CAME FROM ATTENDANCE WHERE CAME=True)  AS T2 ON T1.TRAINING_ID = T2.TRAINING_ID
GROUP BY CLIENT_ID, GROUP_ID, FOR_YEAR, FOR_MONTH;
