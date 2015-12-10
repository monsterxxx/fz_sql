SELECT IIf(GROUPS.GROUP_TYPE = 1, 'Взрослые группы', IIf(GROUPS.GROUP_TYPE = 2, 'Детские группы', 'Индивидуальные')) AS Статья,
	IIf(GROUPS.GROUP_TYPE = 1, 'Взрослые группы', IIf(GROUPS.GROUP_TYPE = 2, 'Детские группы', 'Индивидуальные')) AS [Тип группы],
	MONTHNAME(PAYMENT.FOR_MONTH, TRUE) AS [За месяц], 
	GROUPS.FULLNAME AS [Группа],
	(PERSON.LASTNAME &' '& PERSON.FIRSTNAME) AS [Инструктор],
	(PERSON_1.LASTNAME  &' '& PERSON_1.FIRSTNAME) AS Клиент,
	T3.Count-CAME AS [Посещений в сентябре],
	'' AS Основание,
	'' AS Получатель,
	PAYMENT.PAYMENT_DATE AS Дата,
	PAYMENT.SUMMA AS Сумма,
	0 AS [Сумма ППИ]
FROM (PERSON INNER JOIN (TRAINER INNER JOIN (GROUPS INNER JOIN PAYMENT ON GROUPS.GROUP_ID = PAYMENT.GROUP_ID) ON TRAINER.TRAINER_ID = PAYMENT.TRAINER_ID) ON PERSON.PERSON_ID = TRAINER.PERSON_ID) 
INNER JOIN PERSON AS PERSON_1 ON PAYMENT.PERSON_ID = PERSON_1.PERSON_ID
LEFT JOIN (SELECT CLIENT_ID, GROUP_ID, Count(CAME) AS [Count-CAME]
				FROM 
					(SELECT TRAINING_ID, GROUP_ID 
					 FROM TRAINING 
					 	WHERE Month(CREATE_DATE)=9
					 )  AS T1 
					 INNER JOIN 
					 (SELECT CLIENT_ID, TRAINING_ID, CAME 
					 FROM ATTENDANCE 
					 	WHERE CAME=True)  AS T2 ON (T1.TRAINING_ID = T2.TRAINING_ID)
				GROUP BY CLIENT_ID, GROUP_ID) AS T3 ON (T3.CLIENT_ID = PAYMENT.CLIENT_ID AND T3.GROUP_ID = GROUPS.GROUP_ID)
WHERE (PAYMENT.CLAUSE = 1)
UNION ALL
SELECT 'Задолженности',
	IIf(GROUPS.GROUP_TYPE = 1, 'Взрослые группы', IIf(GROUPS.GROUP_TYPE = 2, 'Детские группы', 'Индивидуальные')),
	MONTHNAME(CLIENT_MONTH_GROUP_DEBT.FOR_MONTH, TRUE), 
	GROUPS.FULLNAME, 
	(PERSON_1.LASTNAME  &' '& PERSON_1.FIRSTNAME), 
	(PERSON.LASTNAME &' '& PERSON.FIRSTNAME),
	NULL,
	'' AS Основание,
	'' AS Получатель,
	'' AS Дата,
	CLIENT_MONTH_GROUP_DEBT.DEBT,
	0
FROM (TRAINER INNER JOIN ((PERSON INNER JOIN (CLIENT_MONTH_GROUP_DEBT INNER JOIN CLIENT ON CLIENT_MONTH_GROUP_DEBT.CLIENT_ID = CLIENT.CLIENT_ID) ON PERSON.PERSON_ID = CLIENT.PERSON_ID) INNER JOIN GROUPS ON CLIENT_MONTH_GROUP_DEBT.GROUP_ID = GROUPS.GROUP_ID) ON TRAINER.TRAINER_ID = GROUPS.TRAINER_ID) INNER JOIN PERSON AS PERSON_1 ON TRAINER.PERSON_ID = PERSON_1.PERSON_ID
WHERE (((CLIENT_MONTH_GROUP_DEBT.DEBT)>0))
UNION ALL
SELECT IIf(PAYMENT.CLAUSE = 2, 'ЗП инструторов', IIf(PAYMENT.CLAUSE = 3, 'ЗП работников', 'Продажа товаров и услуг')),  
	'',
	IIf(PAYMENT.FOR_MONTH is Null, MONTHNAME(MONTH(PAYMENT.PAYMENT_DATE), TRUE), MONTHNAME(PAYMENT.FOR_MONTH, TRUE)), 
	'',
	'',
	NULL,
	IIf(PAYMENT.CLAUSE = 9, 'Продажа товаров и услуг', ''), 
	IIf(PAYMENT.CLAUSE IN (2, 3), 'Заработная плата', PAYMENT.REASON), 
	(PERSON.LASTNAME &' '& PERSON.FIRSTNAME), 
	PAYMENT.PAYMENT_DATE,
	PAYMENT.SUMMA,
	0
FROM PAYMENT 
INNER JOIN PERSON ON PERSON.PERSON_ID = PAYMENT.PERSON_ID
WHERE (PAYMENT.CLAUSE IN (9, 2, 3))
UNION ALL
SELECT IIf(PAYMENT.CLAUSE = 4, 'Административные расходы', IIf(PAYMENT.CLAUSE = 5, 'Аренда', IIf(PAYMENT.CLAUSE = 8, 'Интерьер', IIf(PAYMENT.CLAUSE = 10, 'Прочие доходы', IIf(PAYMENT.CLAUSE = 11, 'Прочие расходы', IIf(PAYMENT.CLAUSE = 12, 'Реклама', IIf(PAYMENT.CLAUSE = 13, 'Спортивный инвентарь', 'Хозяйственные расходы'))))))), 
	IIf(PAYMENT.CLAUSE = 10, 'Прочие доходы',''),
	IIf(PAYMENT.FOR_MONTH is Null, MONTHNAME(MONTH(PAYMENT.PAYMENT_DATE), TRUE), MONTHNAME(PAYMENT.FOR_MONTH, TRUE)),
	'',
	'',
	NULL,
	IIf(PAYMENT.CLAUSE = 10, 'Прочие доходы', ''), 
	IIf(PAYMENT.CLAUSE = 5, 'Аренда', PAYMENT.REASON), 
	ORGANIZATION.FULLNAME,
	PAYMENT.PAYMENT_DATE,
	PAYMENT.SUMMA,
	0
FROM PAYMENT 
INNER JOIN ORGANIZATION ON ORGANIZATION.ORGANIZATION_ID = PAYMENT.ORGANIZATION_ID
WHERE (PAYMENT.CLAUSE IN (10, 4, 5, 8, 11, 12, 13, 14))
UNION ALL
SELECT IIf(PAYMENT.CLAUSE = 2, 'Переменные', IIf(PAYMENT.CLAUSE = 3, 'Постоянные', '')),  
	'',
	IIf(PAYMENT.FOR_MONTH is Null, MONTHNAME(MONTH(PAYMENT.PAYMENT_DATE), TRUE), MONTHNAME(PAYMENT.FOR_MONTH, TRUE)), 
	'',
	'',
	NULL,
	'',
	'', 
	'',
	PAYMENT.PAYMENT_DATE,
	0,
	PAYMENT.SUMMA
FROM PAYMENT 
INNER JOIN PERSON ON PERSON.PERSON_ID = PAYMENT.PERSON_ID
WHERE (PAYMENT.CLAUSE IN (2, 3))
UNION ALL
SELECT IIf(PAYMENT.CLAUSE = 4, 'Постоянные', IIf(PAYMENT.CLAUSE = 5, 'Постоянные', IIf(PAYMENT.CLAUSE = 8, 'Инвестиции', IIf(PAYMENT.CLAUSE = 11, 'Постоянные', IIf(PAYMENT.CLAUSE = 12, 'Постоянные', IIf(PAYMENT.CLAUSE = 13, 'Инвестиции', 'Постоянные')))))), 
	IIf(PAYMENT.CLAUSE = 10, 'Прочие доходы',''),
	IIf(PAYMENT.FOR_MONTH is Null, MONTHNAME(MONTH(PAYMENT.PAYMENT_DATE), TRUE), MONTHNAME(PAYMENT.FOR_MONTH, TRUE)),
	'',
	'',
	NULL,
	'',
	'', 
	'',
	PAYMENT.PAYMENT_DATE,
	0,
	PAYMENT.SUMMA
FROM PAYMENT 
INNER JOIN ORGANIZATION ON ORGANIZATION.ORGANIZATION_ID = PAYMENT.ORGANIZATION_ID
WHERE (PAYMENT.CLAUSE IN (4, 5, 8, 11, 12, 13, 14))