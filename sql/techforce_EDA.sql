select *
from tf_staging;

-- 1. OVERVIEW
SELECT COUNT(*) AS total_employees 
FROM tf_staging; -- THERE ARE 57 EMPLOYEES

SELECT 
		MIN(salary) AS min_salary, MAX(salary) AS max_salary,
		ROUND(AVG(salary),2) AS avg_salary,
        ROUND(STDDEV(salary),2) AS salary_stddev
FROM tf_staging; -- min_salary = 1150000, max_salary = 980000, avg_salary = 522192.98, salary_stddev = 217415.07

-- 2. HEAD COUNT BY CATEGORY
-- A. BY DEPARTMENT
SELECT department, COUNT(*) AS headcount
FROM tf_staging
GROUP BY department
ORDER BY headcount DESC; -- Engineering = 15, Sales = 10, Marketing = 8, HR = 8, Finance = 8, Customer Support = 8

-- B. BY JOB TITLE
SELECT job_title, COUNT(*) AS headcount
FROM tf_staging
GROUP BY job_title
ORDER BY headcount DESC; -- Software Engineer = 8, Marketing Specialist = 8, Support Agent = 8, Sales Representative = 7, HR Officer = 6, Accountant = 5, Data Analyst = 4, Sales Manager = 3, Finance Manager = 3, Senior Software Engineer = 2, HR Manager = 2, IT Manager	= 1

-- C. BY CITY
SELECT city, COUNT(*) AS headcount
FROM tf_staging
GROUP BY city
ORDER BY headcount DESC; -- Lagos = 20, Port Harcourt = 19, Abuja = 16, Kano = 2

-- C. BY GENDER
SELECT gender, COUNT(*) AS headcount
FROM tf_staging
GROUP BY gender
ORDER BY headcount DESC;  -- M = 30, F = 27

-- 3. HIRING TREND
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS hires
FROM tf_staging
GROUP BY hire_year
ORDER BY hire_year; -- 2016 = 1, 2017 = 4, 2018 = 9, 2019 = 10, 2020 = 13, 2021 = 11, 2022 = 8, 2023 = 1

-- 4. SALARY BY DEPARTMENT
SELECT department,
		ROUND(AVG(salary),2) AS avg_salary,
        MIN(salary) AS min_salary, MAX(salary) AS max_salary,
		COUNT(*) AS headcount
FROM tf_staging
GROUP BY department
ORDER BY avg_salary DESC; -- department, avg_salary, min_salary, max_salary, headcount
					-- Finance,	663125,	470000,	950000,	8
					-- Engineering,	634000,	1150000, 980000, 15
					-- Sales, 548000, 410000,	880000,	10
					-- HR,	480000,	360000,	820000,	8
					-- Marketing,	423750,	390000,	450000,	8
					-- Customer Support,	280000,	280000,	280000,	8

-- 5. SALARY BY GENDER(PAY GAP CHECK)
SELECT gender, ROUND(AVG(salary),2) AS avg_salary,
		COUNT(*) AS headcount
FROM tf_staging
GROUP BY gender; -- gender, avg_salary, headcount
					-- M,	578833.33,	30
					-- F,	459259.26,	27
                    
-- 6. TOP-PAYING JOB TITLES
 SELECT job_title, ROUND(AVG(salary),2) AS avg_salary
FROM tf_staging
GROUP BY job_title
ORDER BY avg_salary DESC LIMIT 5; -- job_title, avg_salary
									-- IT Manager,	1150000
									-- Senior Software Engineer,	965000
									-- Finance Manager,	950000
									-- Sales Manager,	870000
									-- HR Manager,	810000
                                    
-- 7. TENURE VS SALARY
SELECT employee_id, first_name, last_name, salary,
		timestampdiff(YEAR, hire_date, CURDATE()) AS years_tenure
FROM tf_staging
ORDER BY years_tenure DESC; -- employee_id, first_name, last, salary, years_tenure
								-- 12	Patricia	Nnamdi	800000	10
						-- 15	Olumide	Fashola	950000	9
						-- 40	Tochukwu	Okafor	950000	9
						-- 30	Uche	Nwofor	950000	8
						-- 28	Rotimi	Olatunji	860000	8
						-- 23	Chioma	Okonkwo	420000	8
						-- 6	Blessing	Nwosu	870000	8
						-- 1	Chinedu	Okafor	1150000	8
						-- 35	Kunle	Adesanya	440000	8
						-- 2	Ifeoma	Adeyemi	950000	7
						-- 7	Kelechi	Obi	410000	7
						-- 56	Tony	Eze	820000	7
						-- 10	Grace	Udo	450000	7
						-- 53	Abby	Ikenna	450000	7
						-- 47	Chidi	Aneke	495000	7
						-- 33	Oluwaseun	Adeleke	980000	7
						-- 16	Ngozi	Onuoha	510000	7
						-- 42	Seun	Alade	430000	7
						-- 26	Bassey	Effiong	590000	7
					-- 38	Chukwuemeka	Eze	880000	7
					-- 3	Tunde	Bakare	620000	6
					-- 52	Dele	Omotoso	410000	6
					-- 57	Lanre	Badmus	370000	6
					-- 13	Yusuf	Mohammed	380000	6
					-- 8	Fatima	Suleiman	410000	6
					-- 18	Victoria	Akpan	280000	6
					-- 21	Adaora	Nkem	540000	6
					-- 22	Biodun	Adebayo	410000	6
					-- 29	Halima	Musa	370000	6
					-- 43	Preye	Fubara	280000	6
					-- 44	Idris	Balogun	600000	6
					-- 48	Amara	Eze	570000	6
					-- 50	Zainab	Musa	280000	6
					-- 39	Aisha	Garba	280000	5
					-- 19	Samuel	Etim	280000	5
					-- 41	Adunola	Ogunleye	455000	5
					-- 17	Ahmed	Bello	470000	5
					-- 46	Adaeze	Okonkwo	375000	5
					-- 25	Ifunanya	Okoro	280000	5
					-- 34	Adaobi	Peters	410000	5
					-- 11	Daniel	Igwe	400000	5
					-- 55	Chika	Nwosu	440000	5
					-- 9	Emeka	Chukwu	410000	5
					-- 24	Musa	Aliyu	480000	5
					-- 4	Amaka	Eze	580000	4
					-- 5	Segun	Olawale	470000	4
					-- 36	Ebuka	Obi	560000	4
					-- 37	Nkechi	Umeh	365000	4
					-- 31	Sade	Ogundimu	460000	4
					-- 45	Bola	Adeyemi	410000	4
					-- 14	Chiamaka	Eze	360000	4
					-- 51	Ogo	Nwosu	545000	4
					-- 54	Ogundipe	Ogundipe	500000	4
					-- 20	Joy	Ibrahim	280000	3
					-- 27	Kemi	Adeyinka	390000	3
					-- 32	Taiwo	Oladele	280000	3
					-- 49	Femi	Kuti	410000	3
                    
                    
	select *
    from tf_staging;