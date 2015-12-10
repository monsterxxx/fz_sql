select g.name as "Наименование", 
	s.name as "Размер",
	sr.shop_id as "Склад",
	sr.remainder as "Остаток",
	sr.reserved as "Резерв",
	sr.expected as "Ожидается",
	DATEADD(SECOND, rc.CHANGE_DATE, cast('1970-01-01 00:00:00' as timestamp)) as "Дата изменения остатка",
	rc.remainder as "Остаток изменен на"
from sized_remainders as sr
	join sizes as s on (s.id = sr.size_id)
	join goods as g on (g.id = s.good_id)
	left join remainders_changes as rc on (rc.size_id = sr.size_id) and (rc.shop_id = sr.shop_id)
	
	