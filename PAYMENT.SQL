SELECT * FROM
(SELECT ORGANIZATION.FULLNAME AS COMPANY,
	-1 AS DIRECTION,
	PAYMENT.CASHLESS AS CASHLESS,
	0 AS DEBT,
	GROUP_TYPE.FULLNAME AS [Тип группы],
	IIf(PAYMENT.COMPANY = 117, PAYMENT_TYPE.FULLNAME, GROUP_TYPE.FULLNAME) AS Статья,
	IIf(PAYMENT.COMPANY = 117, TRAINING.CREATE_DATE, DateSerial(PAYMENT.FOR_YEAR, PAYMENT.FOR_MONTH,1)) AS [За месяц],
	SPORT.FULLNAME AS [Вид спорта],
	GROUPS.FULLNAME AS Группа,
	(PERSON.LASTNAME &' '& PERSON.FIRSTNAME) AS Инструктор,
	IIf(PAYMENT.PAYMENT_TYPE_ID IN (1, 25), (PERSON_1.LASTNAME  &' '& PERSON_1.FIRSTNAME), PAYMENT_TYPE.FULLNAME) AS Клиент,
	'' AS Основание,
	'' AS Получатель,
	PAYMENT.PAYMENT_DATE AS Дата,
	PAYMENT.SUMMA AS Сумма,
	PAYMENT.SUMMA AS [Сумма оплат],
	0 AS [Сумма задолженностей],
	'' AS [Тип расходов],
	PAYMENT.CLIENT_ID,
	PAYMENT.GROUP_ID
FROM ((PERSON RIGHT JOIN TRAINER ON PERSON.PERSON_ID = TRAINER.PERSON_ID) RIGHT JOIN (SPORT INNER JOIN (PAYMENT_TYPE INNER JOIN ((GROUP_TYPE INNER JOIN GROUPS ON GROUP_TYPE.GROUP_TYPE_ID = GROUPS.GROUP_TYPE_ID) INNER JOIN (ORGANIZATION INNER JOIN (PAYMENT LEFT JOIN PERSON AS PERSON_1 ON PAYMENT.PERSON_ID = PERSON_1.PERSON_ID) ON ORGANIZATION.ORGANIZATION_ID = PAYMENT.COMPANY) ON GROUPS.GROUP_ID = PAYMENT.GROUP_ID) ON PAYMENT_TYPE.PAYMENT_TYPE_ID = PAYMENT.PAYMENT_TYPE_ID) ON SPORT.SPORT_ID = GROUPS.SPORT_ID) ON TRAINER.TRAINER_ID = PAYMENT.TRAINER_ID) LEFT JOIN TRAINING ON PAYMENT.TRAINING_ID = TRAINING.TRAINING_ID
WHERE (((PAYMENT.PAYMENT_TYPE_ID) In (1,18,25)))
UNION ALL
SELECT ORGANIZATION.FULLNAME AS COMPANY,
	-1 AS DIRECTION,
	0 AS CASHLESS,
	1 AS DEBT,
	GROUP_TYPE.FULLNAME,
	GROUP_TYPE.FULLNAME,
	DateSerial(CLIENT_MONTH_GROUP_DEBT.FOR_YEAR, CLIENT_MONTH_GROUP_DEBT.FOR_MONTH,1),
	SPORT.FULLNAME,
	GROUPS.FULLNAME,
	(PERSON_1.LASTNAME  &' '& PERSON_1.FIRSTNAME),
	(PERSON.LASTNAME &' '& PERSON.FIRSTNAME),
	'' AS Основание,
	'' AS Получатель,
	null AS Дата,
	CLIENT_MONTH_GROUP_DEBT.DEBT,
	0,
	CLIENT_MONTH_GROUP_DEBT.DEBT,
	'',
	CLIENT.CLIENT_ID,
	GROUPS.GROUP_ID
FROM ((PERSON AS PERSON_1 INNER JOIN TRAINER ON PERSON_1.PERSON_ID = TRAINER.PERSON_ID) INNER JOIN (SPORT INNER JOIN (GROUP_TYPE INNER JOIN (PERSON INNER JOIN ((CLIENT_MONTH_GROUP_DEBT INNER JOIN CLIENT ON CLIENT_MONTH_GROUP_DEBT.CLIENT_ID = CLIENT.CLIENT_ID) INNER JOIN GROUPS ON CLIENT_MONTH_GROUP_DEBT.GROUP_ID = GROUPS.GROUP_ID) ON PERSON.PERSON_ID = CLIENT.PERSON_ID) ON GROUP_TYPE.GROUP_TYPE_ID = GROUPS.GROUP_TYPE_ID) ON SPORT.SPORT_ID = GROUPS.SPORT_ID) ON TRAINER.TRAINER_ID = GROUPS.TRAINER_ID) INNER JOIN ORGANIZATION ON GROUPS.ORGANIZATION_ID = ORGANIZATION.ORGANIZATION_ID
WHERE (((CLIENT_MONTH_GROUP_DEBT.DEBT)>0))
UNION ALL
SELECT ORGANIZATION_1.FULLNAME AS COMPANY,
	PAYMENT_TYPE.DIRECTION AS DIRECTION,
	PAYMENT.CASHLESS AS CASHLESS,
	0 AS DEBT,
	IIf(PAYMENT.COMPANY = 117, 'Мероприятия', IIf(PAYMENT_TYPE.DIRECTION = -1, PAYMENT_TYPE.FULLNAME, IIf(PAYMENT_TYPE.VARIABLE_EXPENSE = -1, 'Переменные', IIf(PAYMENT_TYPE.INVESTMENT = -1, 'Инвестиции', 'Постоянные')))),
	PAYMENT_TYPE.FULLNAME,
	IIf(PAYMENT.COMPANY = 117, IIf(TRAINING.CREATE_DATE IS NULL, PAYMENT.PAYMENT_DATE, TRAINING.CREATE_DATE), IIf(PAYMENT.FOR_MONTH IS NULL, PAYMENT.PAYMENT_DATE, DateSerial(PAYMENT.FOR_YEAR, PAYMENT.FOR_MONTH,1))),
	'',
	IIf(PAYMENT.COMPANY = 117, GROUPS.FULLNAME, '') AS [Группа],
	'' AS [Инструктор],
	IIf(PAYMENT.ORGANIZATION_ID IS NOT NULL, ORGANIZATION.FULLNAME, '') AS CLIENT,
    IIf(PAYMENT.PAYMENT_TYPE_ID = 19, GROUPS.FULLNAME, IIf(PAYMENT.REASON IS NOT NULL, PAYMENT.REASON, PAYMENT_TYPE.FULLNAME)) AS Основание,
	IIf(PAYMENT.PERSON_ID IS NOT NULL, (PERSON.LASTNAME &' '& PERSON.FIRSTNAME), ORGANIZATION.FULLNAME) AS Получатель,
	PAYMENT.PAYMENT_DATE,
	PAYMENT.SUMMA,
	PAYMENT.SUMMA,
	0,
	IIf(PAYMENT.COMPANY = 117, 'Мероприятия', IIf(PAYMENT_TYPE.VARIABLE_EXPENSE = -1, 'Переменные', IIf(PAYMENT_TYPE.INVESTMENT = -1, 'Инвестиции', 'Постоянные'))) AS [Тип расходов],
	0,
	0
FROM (PERSON RIGHT JOIN (PAYMENT_TYPE INNER JOIN (GROUPS RIGHT JOIN (EMPLOYEE RIGHT JOIN (ORGANIZATION AS ORGANIZATION_1 INNER JOIN (ORGANIZATION RIGHT JOIN PAYMENT ON ORGANIZATION.ORGANIZATION_ID = PAYMENT.ORGANIZATION_ID) ON ORGANIZATION_1.ORGANIZATION_ID = PAYMENT.COMPANY) ON EMPLOYEE.EMPLOYEE_ID = PAYMENT.EMPLOYEE_ID) ON GROUPS.GROUP_ID = PAYMENT.GROUP_ID) ON PAYMENT_TYPE.PAYMENT_TYPE_ID = PAYMENT.PAYMENT_TYPE_ID) ON PERSON.PERSON_ID = PAYMENT.PERSON_ID) LEFT JOIN TRAINING ON PAYMENT.TRAINING_ID = TRAINING.TRAINING_ID
WHERE (((PAYMENT_TYPE.BANK_OPERATION)=False) AND ((PAYMENT_TYPE.KASSA_OPERATION)=False) AND ((PAYMENT.PAYMENT_TYPE_ID) Not In (1,18,25)))
UNION ALL
SELECT ORGANIZATION.FULLNAME AS COMPANY,
	0 AS DIRECTION,
	0 AS CASHLESS,
	1 AS DEBT,
	'Переменные',
	'ЗП инструкторам',
	TRAINER_SALARY_DEBT.MONTHDATE,
	'',
	'',
	'',
	'',
	'Задолженности по ЗП',
	(PERSON.LASTNAME &' '& PERSON.FIRSTNAME),
	null,
	TRAINER_SALARY_DEBT.DEBT,
	0,
	TRAINER_SALARY_DEBT.DEBT,
	'Переменные' AS [Тип расходов],
	0,
	0
FROM (TRAINER_SALARY_DEBT INNER JOIN PERSON ON TRAINER_SALARY_DEBT.PERSON_ID = PERSON.PERSON_ID) INNER JOIN ORGANIZATION ON TRAINER_SALARY_DEBT.COMPANY = ORGANIZATION.ORGANIZATION_ID
UNION ALL
SELECT ORGANIZATION.FULLNAME AS COMPANY,
  0 AS DIRECTION,
  0 AS CASHLESS,
  1 AS DEBT,
  'Постоянные',
  'ЗП работникам',
  EMPLOYEE_SALARY_DEBT.MONTHDATE,
  '',
  '',
  '',
  '',
  'Задолженности по ЗП',
  (PERSON.LASTNAME &' '& PERSON.FIRSTNAME),
  null,
  EMPLOYEE_SALARY_DEBT.DEBT,
  0,
  EMPLOYEE_SALARY_DEBT.DEBT,
  'Переменные' AS [Тип расходов],
  0,
  0
FROM (EMPLOYEE_SALARY_DEBT INNER JOIN PERSON ON EMPLOYEE_SALARY_DEBT.PERSON_ID = PERSON.PERSON_ID) INNER JOIN ORGANIZATION ON EMPLOYEE_SALARY_DEBT.COMPANY = ORGANIZATION.ORGANIZATION_ID
) AS T10
LEFT JOIN
(SELECT CLIENT_ID, GROUP_ID, FOR_MONTH, FOR_YEAR, Count(CAME) AS [Пос в месяце]
				FROM
					(SELECT TRAINING_ID, GROUP_ID, MONTH(CREATE_DATE) AS FOR_MONTH, YEAR(CREATE_DATE) AS FOR_YEAR
					 FROM TRAINING
					 )  AS T1
					 INNER JOIN
					 (SELECT CLIENT_ID, TRAINING_ID, CAME
					 FROM ATTENDANCE
					 	WHERE CAME=True) AS T2 ON (T1.TRAINING_ID = T2.TRAINING_ID)
				GROUP BY CLIENT_ID, GROUP_ID, FOR_MONTH, FOR_YEAR) AS T11
ON (T11.CLIENT_ID = T10.CLIENT_ID AND T11.GROUP_ID = T10.GROUP_ID AND T11.FOR_MONTH = MONTH(T10.[За месяц]) AND T11.FOR_YEAR = YEAR(T10.[За месяц]))