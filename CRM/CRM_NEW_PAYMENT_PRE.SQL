SELECT PERSON_ID,
  MIN(PAYMENT.PAYMENT_ID) AS PAYMENT_ID
FROM PAYMENT
WHERE PAYMENT_TYPE_ID = 1
GROUP BY PERSON_ID
