SELECT W.RECORD_TYPE,
	W.IS_RESERVE,
	DATEADD(SECOND, W.WAYBILL_DATE, cast('1970-01-01 00:00:00' as timestamp)) AS "Дата заказа",
	SUP.NAME AS "Клиент",
	SUP.PHONE AS "Телефон",
	SUP.COMMENT AS "Примечания клиента",
	W.COMMENT AS "Примечания заказа",
	GG.NAME AS "Группа товара",
	G.NAME AS "Наименование",
	S.NAME AS "Размер",
	WI.PRICE AS "Базовая цена",
	IIF(WI.PRICE=0, 0, 100*WI.DISCOUNT/WI.PRICE) AS "%Скидки",
	WI.QUANTITY AS "Кол.",
	SR.REMAINDER AS "Остаток в FZ",
	SR.REMAINDER - SR.RESERVED AS "Доступно в FZ",
	SR.EXPECTED AS "Ожидается в FZ",
	SR1.REMAINDER AS "Остаток на складе",
	SR1.REMAINDER - SR1.RESERVED AS "Доступно на складе",
	SR1.EXPECTED AS "Ожидается на складе",
	WI.PRICE*WI.QUANTITY AS "Сумма",
	WI.DISCOUNT*WI.QUANTITY AS "Скидка",
	(WI.PRICE-WI.DISCOUNT)*WI.QUANTITY AS "Итог"
FROM WAYBILLS W
	JOIN SUPPLIERS SUP ON SUP.ID = W.CONTRACTOR_ID
	JOIN WAYBILL_ITEMS WI ON WI.WAYBILL_ID = W.ID
	JOIN GOODS G ON G.ID = WI.GOODS_ID
	LEFT JOIN GOOD_GROUPS GG ON GG.ID = G.GROUP_ID
	LEFT JOIN SIZES S ON S.ID = WI.SIZE_ID
	LEFT JOIN SIZED_REMAINDERS SR ON (S.ID = SR.SIZE_ID AND SR.SHOP_ID = 0)
	LEFT JOIN SIZED_REMAINDERS SR1 ON (S.ID = SR.SIZE_ID AND SR.SHOP_ID = 1)
	WHERE W.IS_DELETED = 0 AND WI.IS_DELETED = 0