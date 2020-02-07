-- age 0-14 year 2562
select 'Dx.Flu+vaccine age 15-25 year 2562' as "หัวข้อ",to_char(count(opbkk_service_year_2562.pid),'9G999G999') "รายคน"
		 ,( SELECT count(distinct(opbkk_service.txid))
										from (select * from opbkk_service where dateopd <> '' and dateopd not in ('79','78')) opbkk_service
										inner JOIN opbkk_diag_have_code on opbkk_service.txid = opbkk_diag_have_code.txid
										inner JOIN opbkk_drug_have_influenza on opbkk_service.txid = opbkk_drug_have_influenza.txid 
										where age_year <> ''
										and to_number(opbkk_service.age_year, '999') between 15 and 25
										and to_timestamp(dateopd,'DD-Mon-YYYY') between '2018-10-01' and '2019-09-30'
					) visit
		 ,to_char(sum(opbkk_service_year_2562.sum),'9G999G999G999') "จำนวนเงิน" 
		 ,to_char(sum(opbkk_service_year_2562.male),'9G999G999') male ,to_char(sum(opbkk_service_year_2562.famale),'9G999G999') famale
			from (
					SELECT opbkk_service.pid,sum(opbkk_service.amount_actualcharge::int),(case when opbkk_service.sex = '1' then 1 else 0 end) as male,
										(case when opbkk_service.sex = '2' then 1 else 0 end) as famale
										from (select * from opbkk_service where dateopd <> '' and dateopd not in ('79','78')) opbkk_service
										inner JOIN opbkk_diag_have_code on opbkk_service.txid = opbkk_diag_have_code.txid
										inner JOIN opbkk_drug_have_influenza on opbkk_service.txid = opbkk_drug_have_influenza.txid 
										where age_year <> ''
										and to_number(opbkk_service.age_year, '999') between 15 and 25
										and to_timestamp(dateopd,'DD-Mon-YYYY') between '2018-10-01' and '2019-09-30'
										GROUP BY opbkk_service.pid,opbkk_service.sex
			) opbkk_service_year_2562
union all
		select 'Dx.Flu+Non vaccine age 15-25 year 2562' as "blank",to_char(count(opbkk_service_year_2562.pid),'9G999G999') pid
		 ,( SELECT count(distinct(opbkk_service.txid))
										from (select * from opbkk_service where dateopd <> '' and dateopd not in ('79','78')) opbkk_service
										inner JOIN opbkk_diag_have_code on opbkk_service.txid = opbkk_diag_have_code.txid
										--inner JOIN opbkk_drug_have_influenza on opbkk_service.txid = opbkk_drug_have_influenza.txid 
										where age_year <> ''
										and to_number(opbkk_service.age_year, '999') between 15 and 25
										and to_timestamp(dateopd,'DD-Mon-YYYY') between '2018-10-01' and '2019-09-30'
					) visit
		 ,to_char(sum(opbkk_service_year_2562.sum),'9G999G999G999') sum 
		 ,to_char(sum(opbkk_service_year_2562.male),'9G999G999') male ,to_char(sum(opbkk_service_year_2562.famale),'9G999G999') famale
			from (
					SELECT opbkk_service.pid,sum(to_number((case when opbkk_service.amount_actualcharge = '' then '0' else opbkk_service.amount_actualcharge end ),'9G999G999G999')),(case when opbkk_service.sex = '1' then 1 else 0 end) as male,
										(case when opbkk_service.sex = '2' then 1 else 0 end) as famale
										from (select * from opbkk_service where dateopd <> '' and dateopd not in ('79','78')) opbkk_service
										inner JOIN opbkk_diag_have_code on opbkk_service.txid = opbkk_diag_have_code.txid
										--inner JOIN opbkk_drug_have_influenza on opbkk_service.txid = opbkk_drug_have_influenza.txid 
										where age_year <> ''
										and to_number(opbkk_service.age_year, '999') between 15 and 25
										and to_timestamp(dateopd,'DD-Mon-YYYY') between '2018-10-01' and '2019-09-30'
										GROUP BY opbkk_service.pid,opbkk_service.sex
			) opbkk_service_year_2562				 
union all					  
	select 'Non Dx.Flu+vaccine age 15-25 year 2562' as "blank",to_char(count(opbkk_service_year_2562.pid),'9G999G999') pid
     ,( SELECT count(distinct(opbkk_service.txid))
									from (select * from opbkk_service where dateopd <> '' and dateopd not in ('79','78')) opbkk_service
									--inner JOIN opbkk_diag_have_code on opbkk_service.txid = opbkk_diag_have_code.txid
									inner JOIN opbkk_drug_have_influenza on opbkk_service.txid = opbkk_drug_have_influenza.txid 
									where age_year <> ''
									and to_number(opbkk_service.age_year, '999') between 15 and 25
									and to_timestamp(dateopd,'DD-Mon-YYYY') between '2018-10-01' and '2019-09-30'
                ) visit
	 ,to_char(sum(opbkk_service_year_2562.sum),'9G999G999G999') sum 
	 ,to_char(sum(opbkk_service_year_2562.male),'9G999G999') male ,to_char(sum(opbkk_service_year_2562.famale),'9G999G999') famale
		from (
				SELECT opbkk_service.pid,sum(to_number((case when opbkk_service.amount_actualcharge = '' then '0' else opbkk_service.amount_actualcharge end ),'9G999G999G999')),(case when opbkk_service.sex = '1' then 1 else 0 end) as male,
									(case when opbkk_service.sex = '2' then 1 else 0 end) as famale
									from (select * from opbkk_service where dateopd <> '' and dateopd not in ('79','78')) opbkk_service
									--inner JOIN opbkk_diag_have_code on opbkk_service.txid = opbkk_diag_have_code.txid
									inner JOIN opbkk_drug_have_influenza on opbkk_service.txid = opbkk_drug_have_influenza.txid 
									where age_year <> ''
									and to_number(opbkk_service.age_year, '999') between 15 and 25
									and to_timestamp(dateopd,'DD-Mon-YYYY') between '2018-10-01' and '2019-09-30'
									GROUP BY opbkk_service.pid,opbkk_service.sex
		) opbkk_service_year_2562	