/* Numerator: # of diabetic patients* aged 55-75 who have been prescribed an ACE or ARB,
where the medication order is current during the measurement year								
*/

SELECT Count (DISTINCT person.person_id), pt_max_enc_date_loc.location_id
FROM person
INNER JOIN patient_encounter ON patient_encounter.person_id = person.person_id
INNER JOIN patient_diagnosis ON patient_diagnosis.enc_id = patient_encounter.enc_id
INNER JOIN patient_medication ON patient_medication.enc_id = patient_encounter.enc_id
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
AND ((patient_medication.medication_name like '%Benicar%'	
OR patient_medication.medication_name like '%olmesartan%'
OR patient_medication.medication_name like 	'%medoxomil%' 
OR patient_medication.medication_name like 	'%Byvalson%'
OR patient_medication.medication_name like 	'%nebivolol%'
OR patient_medication.medication_name like 	'%valsartan%'
OR patient_medication.medication_name like 	'%candesartan%'
OR patient_medication.medication_name like 	'%cilexetil%'
OR patient_medication.medication_name like 	'%Cozaar%'	
OR patient_medication.medication_name like 	'%losartan%'
OR patient_medication.medication_name like 	'%Diovan%'
OR patient_medication.medication_name like 	'%Edarbi%'
OR patient_medication.medication_name like 	'%azilsartan%'
OR patient_medication.medication_name like 	'%medoxomil%'
OR patient_medication.medication_name like 	'%Entresto%'
OR patient_medication.medication_name like 	'%sacubitril%'
OR patient_medication.medication_name like 	'%eprosartan%'	
OR patient_medication.medication_name like 	'%Exforge%'	
OR patient_medication.medication_name like 	'%amlodipine%'
OR patient_medication.medication_name like 	'%irbesartan%'
OR patient_medication.medication_name like 	'%losartan%'	
OR patient_medication.medication_name like 	'%Micardis%'
OR patient_medication.medication_name like 	'%telmisartan%'
OR patient_medication.medication_name like 	'%Teveten%'
OR patient_medication.medication_name like 	'%eprosartan%'
OR patient_medication.medication_name like 	'%Twynsta%'	
OR patient_medication.medication_name like 	'%Hyzaar%'
OR patient_medication.medication_name like 	'%hydrochlorothiazide%'
OR patient_medication.medication_name like 	'%Tribenzor%'
OR patient_medication.medication_name like 	'%Altace%'	
OR patient_medication.medication_name like 	'%ramipril%'
OR patient_medication.medication_name like 	'%benazepril%'
OR patient_medication.medication_name like 	'%Capoten%'
OR patient_medication.medication_name like 	'%captopril%'
OR patient_medication.medication_name like 	'%enalapril%'		
OR patient_medication.medication_name like 	'%Epaned%'	
OR patient_medication.medication_name like 	'%fosinopril%'	
OR patient_medication.medication_name like 	'%lisinopril%'	
OR patient_medication.medication_name like 	'%Lotensin%'
OR patient_medication.medication_name like 	'%Lotrel%'	
OR patient_medication.medication_name like 	'%Mavik%'
OR patient_medication.medication_name like 	'%trandolapril%'
OR patient_medication.medication_name like 	'%moexipril%'	
OR patient_medication.medication_name like 	'%Monopril%'	
OR patient_medication.medication_name like 	'%perindopril%' 
OR patient_medication.medication_name like 	'%erbumine%'	
OR patient_medication.medication_name like 	'%Prestalia%'
OR patient_medication.medication_name like 	'%perindopril%' 
OR patient_medication.medication_name like 	'%arginine%'
OR patient_medication.medication_name like 	'%Prinivil%'	
OR patient_medication.medication_name like 	'%Qbrelis%'	
OR patient_medication.medication_name like 	'%quinapril%'	
OR patient_medication.medication_name like 	'%ramipril%'	
OR patient_medication.medication_name like 	'%Tarka%'	
OR patient_medication.medication_name like 	'%trandolapril%'
OR patient_medication.medication_name like 	'%verapamil%'
OR patient_medication.medication_name like 	'%trandolapril%'	
OR patient_medication.medication_name like 	'%Univasc%'	
OR patient_medication.medication_name like 	'%moexipril%'
OR patient_medication.medication_name like 	'%Vasotec%'	
OR patient_medication.medication_name like 	'%Zestril%'	
OR patient_medication.medication_name like 	'%Accuretic%'
OR patient_medication.medication_name like 	'%quinapril%'
OR patient_medication.medication_name like 	'%Capozide%'	
OR patient_medication.medication_name like 	'%Lotensin%' 
OR patient_medication.medication_name like 	'$Prinzide%'	
OR patient_medication.medication_name like 	'%Uniretic%'	
OR patient_medication.medication_name like 	'%Vaseretic%'	
OR patient_medication.medication_name like 	'%Zestoretic%'
)/* AND patient_medication.medication_name like '%statin%' */
AND patient_medication.start_date BETWEEN '2017-07-01' AND '2018-06-30')
GROUP BY pt_max_enc_date_loc.location_id
HAVING COUNT (patient_encounter.billable_timestamp) >= 2

