SELECT EMPLOYEE_SALARY_EARNED.COMPANY,
  EMPLOYEE_SALARY_EARNED.EMPLOYEE_ID,
  EMPLOYEE_SALARY_EARNED.PERSON_ID,
  EMPLOYEE_SALARY_EARNED.MONTHDATE,
  EMPLOYEE_SALARY_EARNED.SUMM_EARNED,
  EMPLOYEE_SALARY_PAID.SUMM_PAID,
  SUMM_EARNED - IIf(SUMM_PAID IS NULL, 0, SUMM_PAID) AS DEBT
FROM (EMPLOYEE_SALARY_EARNED LEFT JOIN EMPLOYEE_SALARY_PAID ON (EMPLOYEE_SALARY_EARNED.EMPLOYEE_ID = EMPLOYEE_SALARY_PAID.EMPLOYEE_ID) AND (EMPLOYEE_SALARY_EARNED.MONTHDATE = EMPLOYEE_SALARY_PAID.MONTHDATE))
WHERE ((([SUMM_EARNED]-IIf([SUMM_PAID] Is Null,0,[SUMM_PAID]))>0));
