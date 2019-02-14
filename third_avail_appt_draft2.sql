begin

IF OBJECT_ID ('tempdb..#temp915') IS NOT NULL

DROP TABLE #temp915

SELECT

            r.description,

            c.category,

            ap.start_date,

            ap.begintime,

            ROW_NUMBER() OVER (PARTITION BY r.description ORDER BY ap.start_date)as rn

            into #TEMP915

    

  FROM appt_slots ap

  join resources r on ap.resource_id = r.resource_id

  join categories c on c.category_id = ap.category_id

 

 where  appt_count = '0'

and start_date > GETDATE()

and category !='Block For Huddle Time'

and category !='Telephone Call'

and category !='Block For All Staff Meeting'

 

 end

 

SELECT

       * from #TEMP915 T

  where T.rn <=3

 