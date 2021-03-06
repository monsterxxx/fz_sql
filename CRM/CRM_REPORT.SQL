SELECT CRM_UNITED.COLUMN AS Графа,
ORGANIZATION.FULLNAME AS Компания,
CRM_UNITED.PERSON_ID,
PERSON.LASTNAME & " " & PERSON.FIRSTNAME AS Клиент,
PERSON.INFOSOURCE AS [Откуда узнали],
PERSON.REMIND_DATE AS [Напоминание],
PERSON.REFUSAL_REASON AS [Причина отказа],
CRM_UNITED.PAYMONTH AS Месяц
FROM ((SELECT COLUMN, COMPANY, PERSON_ID, PAYMONTH FROM CRM_PAYMENT
UNION ALL
SELECT * FROM CRM_DEBT
UNION ALL
SELECT * FROM CRM_TRY
UNION ALL
SELECT * FROM CRM_FREE
UNION ALL
SELECT * FROM CRM_NEW_PAYMENT
UNION ALL
SELECT 'Вернулись', COMPANY, PERSON_ID, CALMONTH FROM CRM_GONE_RETURN RETURN WHERE (THISMONTHPAYDEBT IS NOT NULL) AND (LASTMONTHPAYDEBT IS NULL) AND (FIRSTPAY IS NULL)
UNION ALL
SELECT 'Ушли', COMPANY, PERSON_ID, CALMONTH FROM CRM_GONE_RETURN RETURN WHERE (THISMONTHPAYDEBT IS NULL) AND (LASTMONTHPAYDEBT IS NOT NULL) AND (LASTPAYDEBT IS NOT NULL)
UNION ALL
SELECT 'Ушли. Потом вернулись', COMPANY, PERSON_ID, CALMONTH FROM CRM_GONE_RETURN RETURN WHERE (THISMONTHPAYDEBT IS NULL) AND (LASTMONTHPAYDEBT IS NOT NULL) AND (LASTPAYDEBT IS NULL)
)  AS CRM_UNITED LEFT JOIN ORGANIZATION ON ORGANIZATION.ORGANIZATION_ID = CRM_UNITED.COMPANY) LEFT JOIN PERSON ON PERSON.PERSON_ID = CRM_UNITED.PERSON_ID;
