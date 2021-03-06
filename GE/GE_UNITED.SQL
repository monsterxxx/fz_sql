  SELECT 'Размер' AS COLUMN,
    MONTHDATE,
    GROUP_ID,
    GROUP_SIZE AS AMOUNT
  FROM GE_COMBINED
UNION ALL
  SELECT 'Заполненность',
    MONTHDATE,
    GROUP_ID,
    FULLNESS
  FROM GE_COMBINED
UNION ALL
  SELECT 'Выручка',
    MONTHDATE,
    GROUP_ID,
    INCOME
  FROM GE_COMBINED
UNION ALL
  SELECT 'Тренировок',
    MONTHDATE,
    GROUP_ID,
    TRAINING_QUANTITY
  FROM GE_COMBINED
UNION ALL
  SELECT 'Арендная ставка',
    MONTHDATE,
    GROUP_ID,
    RENTAL_RATE
  FROM GE_COMBINED
UNION ALL
  SELECT 'Аренда',
    MONTHDATE,
    GROUP_ID,
    RENT
  FROM GE_COMBINED
UNION ALL
  SELECT 'ЗП инструкторов',
    MONTHDATE,
    GROUP_ID,
    TRAINERS_SALARY
  FROM GE_COMBINED
UNION ALL
  SELECT 'Прибыль',
    MONTHDATE,
    GROUP_ID,
    PROFIT
  FROM GE_COMBINED
UNION ALL
  SELECT 'План прибыли',
    MONTHDATE,
    GROUP_ID,
    PROFIT_PLAN
  FROM GE_COMBINED
