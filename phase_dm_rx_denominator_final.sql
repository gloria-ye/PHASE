SELECT Count (DISTINCT person.person_id), pt_max_enc_date_loc.location_id
FROM person
INNER JOIN patient_encounter ON patient_encounter.person_id = person.person_id
INNER JOIN patient_diagnosis ON patient_diagnosis.enc_id = patient_encounter.enc_id
INNER JOIN
	(SELECT DISTINCT person.person_id, patient_encounter.location_id, patient_encounter.enc_id max_enc_id
	FROM person
	INNER JOIN patient_encounter ON patient_encounter.person_id = person.person_id
	INNER JOIN
		(SELECT DISTINCT person.person_id, MAX(patient_encounter.billable_timestamp) max_enc_date
		FROM person
		INNER JOIN patient_encounter ON patient_encounter.person_id = person.person_id
		WHERE patient_encounter.billable_timestamp >= '2017-07-01'
		AND patient_encounter.billable_timestamp <= '2018-06-30' 
		AND billable_ind = 'Y'
		AND (person.first_name not like '%test%' OR person.last_name not like '%test%')
		AND DATEDIFF (yy, CAST (person.date_of_birth as DATE), '2018-06-30') >= 55
		AND DATEDIFF (yy, CAST (person.date_of_birth as DATE), '2018-06-30') <= 75
		GROUP BY person.person_id ) pt_max_enc_date ON pt_max_enc_date.person_id = person.person_id AND pt_max_enc_date.max_enc_date = patient_encounter.billable_timestamp
	) pt_max_enc_date_loc  ON pt_max_enc_date_loc.person_id = person.person_id
WHERE (patient_diagnosis.diagnosis_code_id like 'E10%' 
		   OR patient_diagnosis.diagnosis_code_id like 'E11%'
		   OR patient_diagnosis.diagnosis_code_id like 'E13%'
		   OR patient_diagnosis.diagnosis_code_id in ('O24.0', 'O24.1' , 'O24.3' , 'O24.8'))
GROUP BY pt_max_enc_date_loc.location_id
HAVING COUNT (patient_encounter.billable_timestamp) >= 2

select location_mstr.location_name, location_mstr.location_id from location_mstr