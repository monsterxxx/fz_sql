SELECT
  ORGANIZATION.FULLNAME AS [Компания],
  T1.INSTRUCTOR_NAME AS [Инструктор],
  CLIENT_PAYMONTH_LAST.PERSON_ID,
  CLIENT_PAYMONTH_LAST.LAST_PAYMONTH AS [Последний оплаченый месяц],
  PERSON.LASTNAME & " " & PERSON.FIRSTNAME AS [Фамилия Имя],
  DateDiff("yyyy", PERSON.BIRTHDAY, Date()) AS [Возраст],
  T2.TESTS_QUANTITY AS [Номер теста]
FROM (FUNCTIONAL_TESTING_PRE AS T1 INNER JOIN CLIENT_PAYMONTH_LAST ON (CLIENT_PAYMONTH_LAST.COMPANY = T1.ORGANIZATION_ID) AND (CLIENT_PAYMONTH_LAST.PERSON_ID = T1.PERSON_ID)) INNER JOIN PERSON ON PERSON.PERSON_ID = T1.PERSON_ID) INNER JOIN ORGANIZATION ON ORGANIZATION.ORGANIZATION_ID = T1.ORGANIZATION_ID,
(SELECT TOP 1 1 AS TESTS_QUANTITY FROM TEST UNION ALL SELECT TOP 1 2 FROM TEST UNION ALL SELECT TOP 1 3 FROM TEST UNION ALL SELECT TOP 1 4 FROM TEST) AS T2
