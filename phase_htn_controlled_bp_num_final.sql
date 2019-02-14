SELECT * INTO #htn_pts_MV
FROM
(SELECT DISTINCT person.person_id 
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
		AND DATEDIFF(YEAR,person.date_of_birth, patient_encounter.billable_timestamp)>= 18
		AND DATEDIFF (yy, CAST (person.date_of_birth as DATETIME), '2018-06-30') <= 85 
		GROUP BY person.person_id ) pt_max_enc_date ON pt_max_enc_date.person_id = person.person_id AND pt_max_enc_date.max_enc_date = patient_encounter.billable_timestamp
	) pt_max_enc_date_loc  ON pt_max_enc_date_loc.person_id = person.person_id
WHERE  (patient_diagnosis.diagnosis_code_id = 'I10' and DATEDIFF(mm, '2017-07-01', patient_diagnosis.create_timestamp) <=6)
AND (patient_diagnosis.create_timestamp NOT BETWEEN '2017-07-01' AND '2018-06-30' AND patient_diagnosis.diagnosis_code_id NOT in ('N18.6', 'Z94.0', 'Z3A.35', 'Z3A.18', 'Z3A.08', 'Z34.93', 'Z34.92', 'Z34.91', 'Z34.90', 'Z34.83', 'Z34.82', 'Z34.81', 'Z34.80', 'Z34.03', 'Z34.02', 'Z34.01', 'Z34.00', 'Z33.1', 'Z32.02', 'Z32.01', 'O99.89', 'O99.89', 'O99.810', 'O99.340', 'O99.331', 'O99.280', 'O99.019', 'O99.013', 'O99.012', 'O98.419', 'O40.9XX0', 'O32.1XX9', 'O26.892', 'O26.891', 'O26.86', 'O26.03', 'O26.00', 'O24.911', 'O24.419', 'O23.43', 'O20.9', 'O16.5', 'O16.2', 'O13.3', 'O12.03', 'O09.892', 'N96', 'O09.212', 'O09.291', 'O09.31', 'O09.891'))
AND pt_max_enc_date_loc.location_id = '8250AA0C-BCF3-42CB-9338-ED25F1049571')as #htn_pts_MV

SELECT * INTO #htn_pts_PA
FROM
(SELECT DISTINCT person.person_id 
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
		AND DATEDIFF(YEAR,person.date_of_birth, patient_encounter.billable_timestamp)>= 18
		AND DATEDIFF (yy, CAST (person.date_of_birth as DATETIME), '2018-06-30') <= 85 
		GROUP BY person.person_id ) pt_max_enc_date ON pt_max_enc_date.person_id = person.person_id AND pt_max_enc_date.max_enc_date = patient_encounter.billable_timestamp
	) pt_max_enc_date_loc  ON pt_max_enc_date_loc.person_id = person.person_id
WHERE  (patient_diagnosis.diagnosis_code_id = 'I10' and DATEDIFF(mm, '2017-07-01', patient_diagnosis.create_timestamp) <=6)
AND (patient_diagnosis.create_timestamp NOT BETWEEN '2017-06-30' AND '2018-06-30' AND patient_diagnosis.diagnosis_code_id NOT in ('N18.6', 'Z94.0', 'Z3A.35', 'Z3A.18', 'Z3A.08', 'Z34.93', 'Z34.92', 'Z34.91', 'Z34.90', 'Z34.83', 'Z34.82', 'Z34.81', 'Z34.80', 'Z34.03', 'Z34.02', 'Z34.01', 'Z34.00', 'Z33.1', 'Z32.02', 'Z32.01', 'O99.89', 'O99.89', 'O99.810', 'O99.340', 'O99.331', 'O99.280', 'O99.019', 'O99.013', 'O99.012', 'O98.419', 'O40.9XX0', 'O32.1XX9', 'O26.892', 'O26.891', 'O26.86', 'O26.03', 'O26.00', 'O24.911', 'O24.419', 'O23.43', 'O20.9', 'O16.5', 'O16.2', 'O13.3', 'O12.03', 'O09.892', 'N96', 'O09.212', 'O09.291', 'O09.31', 'O09.891'))
AND pt_max_enc_date_loc.location_id = '9D971E61-2B5A-4504-9016-7FD863790EE2')as #htn_pts_PA

SELECT * INTO #htn_pts_SV
FROM
(SELECT DISTINCT person.person_id 
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
		AND DATEDIFF(YEAR,person.date_of_birth, patient_encounter.billable_timestamp)>= 18
		AND DATEDIFF (yy, CAST (person.date_of_birth as DATETIME), '2018-06-30') <= 85 
		GROUP BY person.person_id ) pt_max_enc_date ON pt_max_enc_date.person_id = person.person_id AND pt_max_enc_date.max_enc_date = patient_encounter.billable_timestamp
	) pt_max_enc_date_loc  ON pt_max_enc_date_loc.person_id = person.person_id
WHERE  (patient_diagnosis.diagnosis_code_id = 'I10' and DATEDIFF(mm, '2017-07-01', patient_diagnosis.create_timestamp) <=6)
AND (patient_diagnosis.create_timestamp NOT BETWEEN '2017-07-01' AND '2018-06-30' AND patient_diagnosis.diagnosis_code_id NOT in ('N18.6', 'Z94.0', 'Z3A.35', 'Z3A.18', 'Z3A.08', 'Z34.93', 'Z34.92', 'Z34.91', 'Z34.90', 'Z34.83', 'Z34.82', 'Z34.81', 'Z34.80', 'Z34.03', 'Z34.02', 'Z34.01', 'Z34.00', 'Z33.1', 'Z32.02', 'Z32.01', 'O99.89', 'O99.89', 'O99.810', 'O99.340', 'O99.331', 'O99.280', 'O99.019', 'O99.013', 'O99.012', 'O98.419', 'O40.9XX0', 'O32.1XX9', 'O26.892', 'O26.891', 'O26.86', 'O26.03', 'O26.00', 'O24.911', 'O24.419', 'O23.43', 'O20.9', 'O16.5', 'O16.2', 'O13.3', 'O12.03', 'O09.892', 'N96', 'O09.212', 'O09.291', 'O09.31', 'O09.891'))
AND pt_max_enc_date_loc.location_id = 'DD0707A2-60AE-49EB-AF3B-DBDF032C4CC2')as #htn_pts_SV

SELECT * INTO #htn_pts_bp_num_
FROM
(SELECT  vital_signs_.person_id,
person_last_bp.last_time_bp_taken,
min (vital_signs_.bp_systolic)as min_bp_systolic,
min (vital_signs_.bp_diastolic)as min_bp_diastolic
FROM vital_signs_
INNER JOIN patient_encounter ON patient_encounter.enc_id = vital_signs_.enc_id
INNER JOIN patient_diagnosis ON vital_signs_.person_id = patient_diagnosis.person_id
INNER JOIN person ON vital_signs_.person_id = person.person_id
INNER JOIN 
    (SELECT vital_signs_.person_id, count(*)as cnt,
    MAX (vital_signs_.create_timestamp) as last_time_bp_taken 
    FROM vital_signs_
    WHERE
    bp_systolic is NOT NULL and bp_diastolic is NOT NULL
    GROUP BY vital_signs_.person_id) person_last_bp 
ON vital_signs_.person_id = person_last_bp.person_id 
AND vital_signs_.create_timestamp = person_last_bp.last_time_bp_taken
WHERE 
vital_signs_.create_timestamp >= '2017-07-01 00:00.000'
AND vital_signs_.create_timestamp <= '2018-06-30 23:59.999'
AND vital_signs_.bp_systolic is NOT NULL AND vital_signs_.bp_diastolic is NOT NULL
AND person.date_of_birth >= '1933-06-30'
AND person.date_of_birth <='1958-06-30' 
AND vital_signs_.bp_systolic < 140 AND vital_signs_.bp_diastolic < 90 
AND patient_diagnosis.diagnosis_code_id in ( 'I16.9', 'I16.0', 'I15.1','I10', 'I11', 'I12', 'I13', 'I14','I15', 'I16', '401.9', '997.91', '401.0','401.1', '402.11', '402.90', '403.10', '404.90', '404.91', 'R03.0', 'Z86.79', 'I15.9', 'E10', 'E11', '250%', '250', '250.02','250.03', '250.43', '250.71', '648.01', 'E11.22', 'E11.65', 'E11.9', 'O24.439')
AND patient_diagnosis.diagnosis_code_id NOT in ('585.6', '586', '584.9', 'N18.6', 'N17.9', 'N19')
AND patient_encounter.billable_timestamp >= '2017-07-01 00:00.000'
AND patient_encounter.billable_timestamp <='2018-06-30 23:59.999'
AND patient_encounter.billable_ind = 'Y' 
AND patient_diagnosis.create_timestamp <= DATEADD(MONTH, +6, '2017-07-01')
AND patient_diagnosis.create_timestamp >= DATEADD (YEAR, -1, '2017-07-01')
AND NOT (person.first_name like '%test' or person.last_name like '%test')
GROUP BY vital_signs_.person_id, person_last_bp.last_time_bp_taken
HAVING COUNT(patient_encounter.billable_timestamp) >= 1

UNION

SELECT vital_signs_.person_id,
person_last_bp.last_time_bp_taken,
min (vital_signs_.bp_systolic)as min_bp_systolic,
min (vital_signs_.bp_diastolic)as min_bp_diastolic
FROM vital_signs_
INNER JOIN patient_encounter ON patient_encounter.enc_id = vital_signs_.enc_id
INNER JOIN patient_diagnosis ON vital_signs_.person_id = patient_diagnosis.person_id
INNER JOIN person ON vital_signs_.person_id = person.person_id
INNER JOIN (SELECT vital_signs_.person_id, count(*)as cnt,
MAX (vital_signs_.create_timestamp) as last_time_bp_taken 
FROM vital_signs_
WHERE
bp_systolic is NOT NULL and bp_diastolic is NOT NULL
GROUP BY vital_signs_.person_id) person_last_bp 
ON vital_signs_.person_id = person_last_bp.person_id 
AND vital_signs_.create_timestamp = person_last_bp.last_time_bp_taken
WHERE 
vital_signs_.create_timestamp >='2017-07-01 00:00.000'
AND vital_signs_.create_timestamp <= '2018-06-30 23:59.999'
AND vital_signs_.bp_systolic is NOT NULL AND vital_signs_.bp_diastolic is NOT NULL
AND person.date_of_birth >= '1933-06-30'
AND person.date_of_birth <='1958-06-30' 
AND vital_signs_.bp_systolic < 150 AND vital_signs_.bp_diastolic < 90 
AND patient_diagnosis.diagnosis_code_id in ( 'I16.9', 'I16.0', 'I15.1','I10', 'I11', 'I12', 'I13', 'I14','I15', 'I16', '401.9', '997.91', '401.0','401.1', '402.11', '402.90', '403.10', '404.90', '404.91', 'R03.0', 'Z86.79', 'I15.9')
AND patient_diagnosis.diagnosis_code_id NOT in ('585.6', '586', '584.9', 'N18.6', 'N17.9', 'N19', 'E10','E11', '250%', '250', '250.02','250.03', '250.43', '250.71', '648.01', 'E11.22', 'E11.65', 'E11.9', 'O24.439')
AND patient_encounter.billable_timestamp >= '2017-07-01 00:00.000'
AND patient_encounter.billable_timestamp <= '2018-06-30 23:59.999'
AND patient_encounter.billable_ind = 'Y' 
AND patient_diagnosis.create_timestamp <= DATEADD(MONTH, +6, '2017-07-01')
AND patient_diagnosis.create_timestamp >= DATEADD (YEAR, -1, '2017-07-01')
AND NOT (person.first_name like '%test' or person.last_name like '%test')
GROUP BY vital_signs_.person_id, person_last_bp.last_time_bp_taken
HAVING COUNT(patient_encounter.billable_timestamp) >= 1

UNION

/* Patients 18–59 years of age as of the last day of the measurement period whose BP was < 140/90 mm Hg. */
SELECT vital_signs_.person_id,
person_last_bp.last_time_bp_taken,
min (vital_signs_.bp_systolic)as min_bp_systolic,
min (vital_signs_.bp_diastolic)as min_bp_diastolic
FROM vital_signs_
INNER JOIN patient_encounter ON patient_encounter.enc_id = vital_signs_.enc_id
INNER JOIN patient_diagnosis ON vital_signs_.person_id = patient_diagnosis.person_id
INNER JOIN person ON vital_signs_.person_id = person.person_id
INNER JOIN (SELECT vital_signs_.person_id, count(*)as cnt,
MAX (vital_signs_.create_timestamp) as last_time_bp_taken 
FROM vital_signs_
WHERE
bp_systolic is NOT NULL and bp_diastolic is NOT NULL
GROUP BY vital_signs_.person_id) person_last_bp 
ON vital_signs_.person_id = person_last_bp.person_id 
AND vital_signs_.create_timestamp = person_last_bp.last_time_bp_taken
WHERE 
vital_signs_.create_timestamp >= '2017-07-01 00:00.000'
AND vital_signs_.create_timestamp <= '2018-06-30 23:59.999'
AND vital_signs_.bp_systolic is NOT NULL AND vital_signs_.bp_diastolic is NOT NULL
AND person.date_of_birth >= '1959-06-30'
AND person.date_of_birth <='2000-06-30' 
AND vital_signs_.bp_systolic < 140 AND vital_signs_.bp_diastolic < 90
AND patient_diagnosis.diagnosis_code_id in ( 'I16.9', 'I16.0', 'I15.1','I10', 'I11', 'I12', 'I13', 'I14','I15', 'I16', '401.9', '997.91', '401.0','401.1', '402.11', '402.90', '403.10', '404.90', '404.91', 'R03.0', 'Z86.79', 'I15.9')
AND patient_diagnosis.diagnosis_code_id NOT in ('585.6', '586', '584.9', 'N18.6', 'N17.9', 'N19')
AND patient_encounter.billable_timestamp >= '2017-07-01 00:00.000'
AND patient_encounter.billable_timestamp <= '2018-06-30 23:59.999'
AND patient_encounter.billable_ind = 'Y' 
AND patient_diagnosis.create_timestamp <= DATEADD(MONTH, +6, '2017-07-01')
AND patient_diagnosis.create_timestamp >= DATEADD (YEAR, -1, '2017-07-01')
AND NOT (person.first_name like '%test' or person.last_name like '%test')
GROUP BY vital_signs_.person_id, person_last_bp.last_time_bp_taken
HAVING COUNT(patient_encounter.billable_timestamp) >= 1) as htn_pts_bp_num

SELECT COUNT (#htn_pts_MV.person_id)
FROM #htn_pts_MV
INNER JOIN #htn_pts_bp_num_ ON #htn_pts_bp_num_.person_id = #htn_pts_MV.person_id
WHERE #htn_pts_MV.person_id IN (SELECT #htn_pts_bp_num_.person_id FROM #htn_pts_bp_num_)

SELECT COUNT (#htn_pts_PA.person_id)
FROM #htn_pts_PA
INNER JOIN #htn_pts_bp_num_ ON #htn_pts_bp_num_.person_id = #htn_pts_PA.person_id
WHERE #htn_pts_PA.person_id IN (SELECT #htn_pts_bp_num_.person_id FROM #htn_pts_bp_num_)

SELECT COUNT (#htn_pts_SV.person_id)
FROM #htn_pts_SV
INNER JOIN #htn_pts_bp_num_ ON #htn_pts_bp_num_.person_id = #htn_pts_SV.person_id
WHERE #htn_pts_SV.person_id IN (SELECT #htn_pts_bp_num_.person_id FROM #htn_pts_bp_num_)

DROP TABLE #htn_pts_MV
DROP TABLE #htn_pts_PA
DROP TABLE #htn_pts_bp_num_
DROP TABLE #htn_pts_SV