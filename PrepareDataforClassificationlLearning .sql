


--  Prepare data for classification learning.  high utilization in year 2 based on demographics and diagnoses in year 1. 

SELECT  
      [patient_id]
	  into #patientY1Y2
  FROM [TC].[dbo].[claims]
  where year= 'y1' or year= 'y2'
  group by patient_id
  having min ([year])!= max ([year])

--(95792 rows affected)

-- step-2 create input attributes as binary Elix indicators
  use TC
  SELECT  [patient_id]
      ,MAX(case when [diagnosis]= 'ELIX0' THEN 1 ELSE 0 END) AS ELXI0
	  ,MAX(case when [diagnosis]= 'ELIX1' THEN 1 ELSE 0 END) AS ELXI1
	  ,MAX(case when [diagnosis]= 'ELIX2' THEN 1 ELSE 0 END) AS ELXI2
	  ,MAX(case when [diagnosis]= 'ELIX3' THEN 1 ELSE 0 END) AS ELXI3
	  ,MAX(case when [diagnosis]= 'ELIX4' THEN 1 ELSE 0 END) AS ELXI4
	  ,MAX(case when [diagnosis]= 'ELIX5' THEN 1 ELSE 0 END) AS ELXI5
	  ,MAX(case when [diagnosis]= 'ELIX6' THEN 1 ELSE 0 END) AS ELXI6
	  ,MAX(case when [diagnosis]= 'ELIX7' THEN 1 ELSE 0 END) AS ELXI7
	  ,MAX(case when [diagnosis]= 'ELIX8' THEN 1 ELSE 0 END) AS ELXI8
	  ,MAX(case when [diagnosis]= 'ELIX9' THEN 1 ELSE 0 END) AS ELXI9
	  ,MAX(case when [diagnosis]= 'ELIX10' THEN 1 ELSE 0 END) AS ELXI10
	  ,MAX(case when [diagnosis]= 'ELIX11' THEN 1 ELSE 0 END) AS ELXI11
	  ,MAX(case when [diagnosis]= 'ELIX12' THEN 1 ELSE 0 END) AS ELXI12
	  ,MAX(case when [diagnosis]= 'ELIX13' THEN 1 ELSE 0 END) AS ELXI13
	  ,MAX(case when [diagnosis]= 'ELIX14' THEN 1 ELSE 0 END) AS ELXI14
	  ,MAX(case when [diagnosis]= 'ELIX15' THEN 1 ELSE 0 END) AS ELXI15
	  ,MAX(case when [diagnosis]= 'ELIX116' THEN 1 ELSE 0 END) AS ELXI16
	  ,MAX(case when [diagnosis]= 'ELIX17' THEN 1 ELSE 0 END) AS ELXI17
	  ,MAX(case when [diagnosis]= 'ELIX18' THEN 1 ELSE 0 END) AS ELXI118
	  ,MAX(case when [diagnosis]= 'ELIX19' THEN 1 ELSE 0 END) AS ELXI19
	  ,MAX(case when [diagnosis]= 'ELIX20' THEN 1 ELSE 0 END) AS ELXI20
	  ,MAX(case when [diagnosis]= 'ELIX21' THEN 1 ELSE 0 END) AS ELXI21
	  ,MAX(case when [diagnosis]= 'ELIX22' THEN 1 ELSE 0 END) AS ELXI22
	  ,MAX(case when [diagnosis]= 'ELIX23' THEN 1 ELSE 0 END) AS ELXI23
	  ,MAX(case when [diagnosis]= 'ELIX24' THEN 1 ELSE 0 END) AS ELXI24
	  ,MAX(case when [diagnosis]= 'ELIX25' THEN 1 ELSE 0 END) AS ELXI25
	  ,MAX(case when [diagnosis]= 'ELIX26' THEN 1 ELSE 0 END) AS ELXI26
	  ,MAX(case when [diagnosis]= 'ELIX27' THEN 1 ELSE 0 END) AS ELXI27
	  ,MAX(case when [diagnosis]= 'ELIX28' THEN 1 ELSE 0 END) AS ELXI28
	  ,MAX(case when [diagnosis]= 'ELIX29' THEN 1 ELSE 0 END) AS ELXI29

	  into #ElixY1

 FROM [TC].[dbo].[diagnoses] d, [TC].[dbo].[claims] c
  where d.claim_id = c.claim_id
   and year = 'y1'
  GROUP BY patient_id
--(115619 rows affected)

--STEP3

Select patient_id, count(*) as countClaims, 
 case when count(*) >= 100 then 1 else 0 end as HightUtilzer
 into #claimcount
 FROM  [TC].[dbo].[claims] c
   where  year = 'y2'
  GROUP BY patient_id
--(114663 rows affected)

--- step 4 join the table 

--#patientY1Y2 #ElixY1 #claimcount

select  #ElixY1.*

into #t1
 from #patientY1Y2 , #ElixY1 
 where #patientY1Y2.patient_id = #ElixY1.patient_id

 --(95792 rows affected)

select #t1.*, countClaims, HightUtilzer
into hightUtilizationY2V1

from #t1, #claimcount
where #t1.patient_id = #claimcount.patient_id
--(95792 rows affected)

Select * from hightUtilizationY2V1