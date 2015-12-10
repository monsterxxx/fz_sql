select iif(isnull(p.lastname) = true, '', p.lastname) & ' ' & iif(p.firstname is null, '', p.firstname) & ' ' & iif(p.patronymic is null, '', p.patronymic) as [ФИО], 
	p.TEL_MOB as [Мобильный],
	p.TEL_WORK as [Рабочий],
	p.TEL_OTHER as [Другой]
from
	person p
	inner join employee e on (e.person_id = p.PERSON_ID)