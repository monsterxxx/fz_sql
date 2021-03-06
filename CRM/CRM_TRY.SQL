SELECT 'Всего занималось' AS [COLUMN],
'Пробовали' AS [COLUMN1],
CRM_TRY_PRE.ORGANIZATION_ID, 
CRM_TRY_PRE.PERSON_ID,
CRM_TRY_PRE.TRYMONTH
FROM ((CRM_TRY_PRE LEFT JOIN CRM_PAYMENT_PRE ON (CRM_TRY_PRE.TRYMONTH = CRM_PAYMENT_PRE.PAYMONTH) AND (CRM_TRY_PRE.PERSON_ID = CRM_PAYMENT_PRE.PERSON_ID)) LEFT JOIN CRM_FREE ON (CRM_TRY_PRE.TRYMONTH = CRM_FREE.FREEMONTH) AND (CRM_TRY_PRE.PERSON_ID = CRM_FREE.PERSON_ID)) LEFT JOIN CRM_DEBT ON (CRM_TRY_PRE.TRYMONTH = CRM_DEBT.DEBTMONTH) AND (CRM_TRY_PRE.PERSON_ID = CRM_DEBT.PERSON_ID)
WHERE (((CRM_PAYMENT_PRE.PERSON_ID) Is Null) AND ((CRM_FREE.PERSON_ID) Is Null) AND ((CRM_DEBT.PERSON_ID) Is Null));
