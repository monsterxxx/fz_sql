SELECT payments.*, 
DATEADD(SECOND, payment_DATE, cast('1970-01-01 00:00:00' as timestamp)),
waybills.*
FROM PAYMENTS join waybills on (waybills.id=PAYMENTS.WAYBILL_ID)
where payments.is_deleted = 0 and waybills.is_deleted = 0 and waybills.record_type=1
order by DATEADD(SECOND, payment_DATE, cast('1970-01-01 00:00:00' as timestamp)) desc