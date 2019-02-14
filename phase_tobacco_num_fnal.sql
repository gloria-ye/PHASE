SELECT COUNT (DISTINCT person.person_id), pt_max_enc_date_loc.location_id /*, tobacco_usage_.txt_tobacco_use_status, txt_tobacco_cessation_code, CAST (tobacco_usage_.enc_date as DATE) tobacco_usage_enc_date, pt_max_enc_date.max_enc_date */
FROM person
INNER JOIN patient_encounter ON patient_encounter.person_id = person.person_id
INNER JOIN tobacco_usage_ ON tobacco_usage_.person_id = patient_encounter.person_id
INNER JOIN	
	(SELECT DISTINCT person.person_id, tobacco_usage_.enc_date, patient_encounter.location_id, pt_max_enc_date.max_enc_date, patient_encounter.enc_id max_enc_id
	FROM person
	INNER JOIN patient_encounter ON patient_encounter.person_id = person.person_id
	INNER JOIN tobacco_usage_ ON tobacco_usage_.person_id = patient_encounter.person_id
	INNER JOIN
		(SELECT DISTINCT person.person_id, MAX(patient_encounter.billable_timestamp) max_enc_date
		FROM person
		INNER JOIN patient_encounter ON patient_encounter.person_id = person.person_id
		WHERE patient_encounter.billable_timestamp >= '2017-07-01'
		AND patient_encounter.billable_timestamp <= '2018-06-30' 
		AND billable_ind = 'Y'
		AND (person.first_name not like '%test%' OR person.last_name not like '%test%')
		AND DATEDIFF(YEAR,person.date_of_birth, patient_encounter.billable_timestamp)>= 18
		GROUP BY person.person_id ) pt_max_enc_date 
	ON pt_max_enc_date.person_id = person.person_id 
	AND DATEDIFF (mm, CAST (tobacco_usage_.enc_date as DATE), CAST (pt_max_enc_date.max_enc_date as DATE))<= 24
	AND pt_max_enc_date.max_enc_date = patient_encounter.billable_timestamp
	) pt_max_enc_date_loc  ON pt_max_enc_date_loc.person_id = person.person_id
WHERE tobacco_usage_.txt_tobacco_use_status = 'no/never' 
GROUP BY pt_max_enc_date_loc.location_id
UNION
SELECT COUNT (DISTINCT person.person_id), pt_max_enc_date_loc.location_id /*, tobacco_usage_.txt_tobacco_use_status, txt_tobacco_cessation_code, CAST (tobacco_usage_.enc_date as DATE) tobacco_usage_enc_date, pt_max_enc_date.max_enc_date */
FROM person
INNER JOIN patient_encounter ON patient_encounter.person_id = person.person_id
INNER JOIN tobacco_usage_ ON tobacco_usage_.person_id = patient_encounter.person_id
INNER JOIN tobacco_cessation_discuss_ ON tobacco_cessation_discuss_.enc_id = tobacco_usage_.enc_id
INNER JOIN patient_diagnosis ON patient_diagnosis.enc_id = tobacco_cessation_discuss_.enc_id
INNER JOIN	
	(SELECT DISTINCT person.person_id, tobacco_usage_.enc_date, patient_encounter.location_id, pt_max_enc_date.max_enc_date, patient_encounter.enc_id max_enc_id
	FROM person
	INNER JOIN patient_encounter ON patient_encounter.person_id = person.person_id
	INNER JOIN tobacco_usage_ ON tobacco_usage_.person_id = patient_encounter.person_id
	INNER JOIN
		(SELECT DISTINCT person.person_id, MAX(patient_encounter.billable_timestamp) max_enc_date
		FROM person
		INNER JOIN patient_encounter ON patient_encounter.person_id = person.person_id
		WHERE patient_encounter.billable_timestamp >= '2017-07-01'
		AND patient_encounter.billable_timestamp <= '2018-06-30' 
		AND billable_ind = 'Y'
		AND (person.first_name not like '%test%' OR person.last_name not like '%test%')
		AND DATEDIFF(YEAR,person.date_of_birth, patient_encounter.billable_timestamp)>= 18
		GROUP BY person.person_id ) pt_max_enc_date 
	ON pt_max_enc_date.person_id = person.person_id 
	AND DATEDIFF (mm, CAST (tobacco_usage_.enc_date as DATE), CAST (pt_max_enc_date.max_enc_date as DATE))<= 24
	AND pt_max_enc_date.max_enc_date = patient_encounter.billable_timestamp
	) pt_max_enc_date_loc  ON pt_max_enc_date_loc.person_id = person.person_id
WHERE (tobacco_usage_.txt_tobacco_use_status = 'yes' OR patient_diagnosis.diagnosis_code_id = 'Z71.6' OR txt_tobacco_cessation_code in ('315232003', '225324006', '225323000'))
GROUP BY pt_max_enc_date_loc.location_id