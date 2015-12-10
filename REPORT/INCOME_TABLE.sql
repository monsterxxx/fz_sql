SELECT PAYMENT.CLAUSE AS Статья, PAYMENT.PAYMENT_DATE AS Дата, Null AS Инструктор, PAYMENT.REASON AS Группа_или_Товары, PERSON.LASTNAME &" "& PERSON.FIRSTNAME AS Клиент, PAYMENT.SUMMA AS Сумма
FROM PAYMENT 
INNER JOIN PERSON ON PERSON.PERSON_ID = PAYMENT.PERSON_ID
WHERE (((PAYMENT.DIRECTION)=True) AND ((PAYMENT.GROUP_ID) Is Null))
UNION ALL
SELECT 10 + GROUPS.GROUP_TYPE, PAYMENT.PAYMENT_DATE, PERSON.LASTNAME &" "& PERSON.FIRSTNAME, GROUPS.FULLNAME, PERSON1.LASTNAME  &" "& PERSON1.FIRSTNAME, PAYMENT.SUMMA
FROM PAYMENT 
INNER JOIN GROUPS ON PAYMENT.GROUP_ID = GROUPS.GROUP_ID
INNER JOIN (TRAINER INNER JOIN PERSON ON PERSON.PERSON_ID = TRAINER.PERSON_ID) ON PAYMENT.TRAINER_ID = TRAINER.TRAINER_ID
INNER JOIN PERSON AS PERSON1 ON PERSON1.PERSON_ID = PAYMENT.PERSON_ID
WHERE ((PAYMENT.DIRECTION)=True)
