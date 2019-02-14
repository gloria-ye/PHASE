SELECT DISTINCT person.person_id
FROM person
INNER JOIN patient_encounter ON patient_encounter.person_id = person.person_id
INNER JOIN assessment_impression_plan_ aip on aip.enc_id = patient_encounter.enc_id
INNER JOIN patient_diagnosis ON patient_diagnosis.enc_id = patient_encounter.enc_id
INNER JOIN referrals_order_ ON referrals_order_.enc_id = patient_encounter.enc_id
WHERE DATEDIFF(YEAR,person.date_of_birth, patient_encounter.billable_timestamp)>= 12
AND patient_encounter.billable_timestamp >= '2017-07-01'
AND patient_encounter.billable_timestamp <= '2018-06-30' 
AND billable_ind = 'Y'
AND person.first_name not like '%test%' OR person.last_name not like '%test%'
AND patient_diagnosis.create_timestamp NOT BETWEEN '2017-07-01' AND '2018-06-30'
AND NOT (referrals_order_.actTextDisplay like '%psych%' or referrals_order_.actTextDisplay like '%Integrated Behavioral Health%')
AND patient_diagnosis.diagnosis_code_id NOT in ('296.20', '296.80', '296.80', '300.4', '309.0', '311', 'F32.0', 'F32.1', 'F32.1', 'F32.2', 'F32.3', 'F32.8', 'F32.89', 'F32.9', 'F33.0', 'F33.1', 'F33.2', 'F33.9', 'F34.1', 'F41.8', 'F41.9', 'F43.21', 'F43.23', 'F53', 'O99.340', 'O99.343', 'O99.345')
AND 
(patient_encounter.location_id = '9D971E61-2B5A-4504-9016-7FD863790EE2' 
OR patient_encounter.location_id in ('1B7C644F-57CB-44A9-BA73-FE663C067D5E', '8250AA0C-BCF3-42CB-9338-ED25F1049571')
OR patient_encounter.location_id = 'DD0707A2-60AE-49EB-AF3B-DBDF032C4CC2')

SELECT COUNT (DISTINCT person.person_id), pt_max_enc_date_loc.location_id
FROM person
INNER JOIN patient_encounter ON patient_encounter.person_id = person.person_id
INNER JOIN assessment_impression_plan_ aip on aip.enc_id = patient_encounter.enc_id
INNER JOIN patient_diagnosis ON patient_diagnosis.enc_id = patient_encounter.enc_id
INNER JOIN referrals_order_ ON referrals_order_.enc_id = patient_encounter.enc_id
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
		AND person.first_name not like '%test%' OR person.last_name not like '%test%'
		AND DATEDIFF(YEAR,person.date_of_birth, patient_encounter.billable_timestamp)>= 12
		GROUP BY person.person_id ) pt_max_enc_date 
		ON pt_max_enc_date.person_id = person.person_id AND pt_max_enc_date.max_enc_date = patient_encounter.billable_timestamp
	) pt_max_enc_date_loc  ON pt_max_enc_date_loc.person_id = person.person_id AND pt_max_enc_date_loc.max_enc_id = patient_encounter.enc_id
WHERE patient_diagnosis.create_timestamp NOT BETWEEN '2017-07-01' AND '2018-06-30'
AND NOT (referrals_order_.actTextDisplay like '%psych%' or referrals_order_.actTextDisplay like '%Integrated Behavioral Health%')
AND patient_diagnosis.diagnosis_code_id NOT in ('296.20', '296.80', '296.80', '300.4', '309.0', '311', 'F32.0', 'F32.1', 'F32.1', 'F32.2', 'F32.3', 'F32.8', 'F32.89', 'F32.9', 'F33.0', 'F33.1', 'F33.2', 'F33.9', 'F34.1', 'F41.8', 'F41.9', 'F43.21', 'F43.23', 'F53', 'O99.340', 'O99.343', 'O99.345')
 GROUP BY pt_max_enc_date_loc.location_id 
