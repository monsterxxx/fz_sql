SELECT GROUP_TRAINER.GROUP_TRAINER_ID, 
    PERSON.LASTNAME, 
    GROUPS.FULLNAME, 
    GROUP_TRAINER.PERCENT, 
    IIf([SALARY_TYPE_ID]=0,"с выручки","с остатка") AS SALARY_TYPE, 
    IIf(IsNull([RENT_TYPE_ID]),"",IIf([RENT_TYPE_ID]=0,"фикс","по дням")) AS RENT_TYPE, 
    GROUP_RENT.AMOUNT, IIf(IsNull([GROUP_RENT].[FROM_YEAR]),[GROUP_TRAINER].[FROM_YEAR],IIf(DateSerial([GROUP_TRAINER].[FROM_YEAR],[GROUP_TRAINER].[FROM_MONTH],1)>DateSerial([GROUP_RENT].[FROM_YEAR],[GROUP_RENT].[FROM_MONTH],1),[GROUP_TRAINER].[FROM_YEAR],[GROUP_RENT].[FROM_YEAR])) AS FROM__YEAR, IIf(IsNull([GROUP_RENT].[FROM_YEAR]),[GROUP_TRAINER].[FROM_MONTH],IIf(DateSerial([GROUP_TRAINER].[FROM_YEAR],[GROUP_TRAINER].[FROM_MONTH],1)>DateSerial([GROUP_RENT].[FROM_YEAR],[GROUP_RENT].[FROM_MONTH],1),[GROUP_TRAINER].[FROM_MONTH],[GROUP_RENT].[FROM_MONTH])) AS FROM__MONTH
FROM (PERSON INNER JOIN TRAINER ON PERSON.PERSON_ID = TRAINER.PERSON_ID) 
INNER JOIN ((GROUPS LEFT JOIN GROUP_RENT ON (GROUPS.GROUP_ID = GROUP_RENT.GROUP_ID AND GROUP_RENT.TO_YEAR Is NULL))
INNER JOIN GROUP_TRAINER ON GROUPS.GROUP_ID = GROUP_TRAINER.GROUP_ID) ON TRAINER.TRAINER_ID = GROUP_TRAINER.TRAINER_ID
WHERE (((GROUP_TRAINER.TO_MONTH) Is Null));
