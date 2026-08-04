-- EDA DATA EXPLORATION

-- 1. TOTAL ROWS
SELECT COUNT(*) AS total_rows
FROM tf_staging;  -- this dataset contains 70 rows

-- 2. CHECK ALL THE UNIQUE DEPARTMENT
SELECT DISTINCT department AS unique_department
FROM tf_staging; -- there are 6 unique department and there are 3 duplicates due to spelling errors, we need t fix(H.R., human resoures, Engineerin)

-- 3. CHECK UNIQUE GENDER
SELECT DISTINCT gender AS unique_gender
FROM tf_staging; -- there are 2 unique gender values and 1 blank row, 2 spelling errors (F,m), and one number value (1)

-- 4. CHECK THE UNIQUE HIRE DATE FORMAT
SELECT DISTINCT hire_date 
FROM tf_staging; -- 5 DMY values where detected from the uput and it needs t be correted as YMD

-- 5. FIND IF THERE IS NULL OR BLANK IN SALARY FIELD
SELECT salary
FROM tf_staging;
WHERE TRIM(salary) LIKE '%-%' OR salary = 0 AND TRIM(salary) = ''; -- there are two blank rows, one negative value and one row with 0 values

-- 6. CHECK FOR DUPLICATES IN THE EMPLOYEE ID
SELECT employee_id, COUNT(*) AS UNIQUE_ROWS
FROM tf_staging	
GROUP BY employee_id
HAVING COUNT(*) > 1; -- there is no duplicate in the employee_id column as the primary key

-- 7. CHECK FOR INVALID EMAILS MISSING @
SELECT email
FROM tf_staging
WHERE email NOT LIKE '%@%'; -- one row had an inalid email(halimamusa.techforce.com) and one blank row

-- FIND EMAIL WITH EXTRA SPACE
SELECT email
FROM tf_staging
WHERE email LIKE '% %'; -- biodun.adebayo@techforce.com and chidi.aneke@techforce.com has extra whitespace 

-- DATA CLEANING PROPER

-- 1. fill up blanks in salary
SELECT first_name, salary, department, hire_date, job_title
FROM tf_staging
WHERE salary LIKE '%-%'
ORDER BY salary DESC; -- I found that that the two blans was from employees in sales aand customer support department and with the job titles; sales representative and support agent 

-- a. sales salary blank
UPDATE tf_staging
SET salary = 410000
WHERE department = 'Sales' AND job_title = 'Sales Representative'; -- attributed a fix salary of  410000 to aall sales representative an it filled up one of the blank salary row
-- b. customer support salary blank
UPDATE tf_staging
SET salary = 950000
WHERE department = 'Finance' AND job_title = 'Finance Manager';
-- C. salary with negative value was cleaned automatically 

-- 2. CLEANING DEPARTMENT NAMES WITH ERROR
SELECT department, salary, job_title, first_name 
FROM tf_staging
WHERE department ='Engineering'
ORDER BY department DESC; 

-- a. cleaning for 'engineerin'
UPDATE tf_staging
SET department = 'Engineering'
WHERE job_title = 'Software Engineer'; -- changed one row

-- b. cleaning for 'Human Resources'
UPDATE tf_staging
SET department = 'HR'
WHERE department = 'Human Resources'; -- changed 8 rows

-- c. cleaning for 'H.R.'
UPDATE tf_staging
SET department = 'HR'
WHERE department = 'H.R.';

-- 3. CLEANING FOR GENDER
SELECT DISTINCT(gender), first_name, last_name
FROM tf_staging;

-- a. cleaning for 'Female'
UPDATE tf_staging
SET gender = 'F'
WHERE gender = 'Female'; -- 60 rows where changed

-- b. cleaning for 'Male'
UPDATE tf_staging
SET gender = 'M'
WHERE gender = 'Male'; -- 34 rows where changed nd SQL automaticlly detected the pattern and changed the row with 'm' to uppercase

-- c. cleaning for the blank row
UPDATE tf_staging
SET gender = 'M'
WHERE gender = ''; -- 1 row changed to 'M' because I detected that the employee's name is 'Musa', thereby a male

-- d. cleaning for the row with '1'
UPDATE tf_staging
SET gender = 'M'
WHERE gender = '1'; -- row changed to 'M' because I detected that the employee's name is 'Musa', thereby a male


-- 4. cleaning hire date field to YMD
SELECT hire_date
FROM tf_staging;

SELECT *
FROM tf_staging;

-- A. convert to YMD
ALTER TABLE tf_staging
MODIFY hire_date DATE;

ROLLBACK;

-- 4. cleaning the email field
SELECT email
FROM tf_staging;

-- step A: preview; to check if there's dupicaate in the email field
SELECT first_name, email, count(*)
FROM tf_staging
GROUP BY email, first_name
HAVING COUNT(*) = 1;   -- 7 uniques rows and 13 duplicates

-- step B: create a unique identifier 
ALTER TABLE tf_staging ADD COLUMN row_id INT AUTO_INCREMENT PRIMARY KEY;

-- Step C: Delete duplicates — keep only the row with the lowest row_id
DELETE t1
FROM tf_staging t1
INNER JOIN tf_staging t2
  ON t1.first_name  = t2.first_name
  AND t1.email = t2.email
  AND t1.last_name   = t2.last_name
  AND t1.row_id      > t2.row_id;

-- 5. fill up the blank email
SELECT first_name, last_name, email
FROM tf_staging
WHERE first_name = 'Taiwo'; -- found only one blank row

-- STEP A: FILL UP THE BLANK ROW
UPDATE tf_staging
SET email = 'fatima.suleiman@techforce.com'
WHERE email = ''; -- got a duplicate so i reexecited my query to remove duplicate

-- step B: add @ to halima's email
UPDATE tf_staging
SET email = 'halima.musa@techforce.com'
WHERE first_name = 'Halima';

-- i lost my hire date so i used this query to get it back
UPDATE tf_staging t
JOIN tf_dirty d ON t.employee_id = d.employee_id
SET t.hire_date = d.hire_date;

SELECT hire_date
FROM tf_staging;

-- 6. cleaning email with whitespace
SELECT email
FROM tf_staging
WHERE email LIKE '% %';

-- a. clean the emails with whitespace
UPDATE tf_staging
SET email = trim(email)
WHERE email LIKE '% %'; -- update the rows with trim

-- 7. CLEAN ROWS WITH NO FIRST AND LAST NAMES
SELECT first_name, last_name 
FROM tf_staging
WHERE last_name = ''; -- two names with whiespace and one blank row

-- a. remove whitespace
UPDATE tf_staging
SET first_name = trim(first_name); -- two updated

-- b. add first name to the blank row
UPDATE tf_staging
SET first_name = 'Ogundipe'
WHERE last_name = 'Ogundipe';

-- c. there is no blank in last_name field

-- 7. UPDATE THE DATE FORMAT

-- a. view the date fied
SELECT DISTINCT hire_date
FROM tf_staging;

-- b. replace every / with -
UPDATE tf_staging
SET hire_date = REPLACE(hire_date, '/', '-'); -- REPLACED 3 ROWS

-- c. update the date format to YMD
UPDATE tf_staging
SET hire_date = CASE
	WHEN hire_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN hire_date
    WHEN  hire_date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$' THEN '%Y-%m-%d'
    ELSE hire_date
END; -- it wrked but it replaed seun and taiwo hire date with '%Y-%m-%d', so i reiewed fr tf_dirty tabe and got the right date so ill be replaing it

-- d. view the details f those affeted rows
SELECT hire_date, first_name, last_name, email
FROM tf_staging
WHERE first_name ='Seun'; -- I realized that taiw had dupliate, so I went bak to rerun the query to remove duplicate row for taiwo  

-- e. preview the raw data to take the original dates in other to repae with 
SELECT hire_date, first_name, last_name, email
FROM tf_dirty; -- taiwo: 09-15-2022, seun 23-11-2018                                    

-- f. replace taiwo hiredate
UPDATE tf_staging
SET hire_date = '2022-09-15'
WHERE first_name = 'Taiwo';

-- g. replace seun hire date
UPDATE tf_staging
SET hire_date = '2018-11-23'
WHERE first_name = 'Seun';

-- h. confirm the changes made
SELECT *
FROM tf_staging; -- confirmed, all dates format is YMD! HURRAY! HURRAY!! HURRAY!!!

-- 9. fix the employee id field as there are inconsistencies

-- a. preview the column employee and row id
SELECT *
FROM tf_staging;

-- b. delete row_id column
ALTER TABLE tf_staging DROP COLUMN row_id;

-- c. create the column again
ALTER TABLE tf_staging ADD COLUMN row_id INT AUTO_INCREMENT PRIMARY KEY;

-- update the employee id olumn using row id collumn as the right format b sellf oining the table
UPDATE tf_staging t
JOIN tf_dirty d ON t.employee_id = d.employee_id
SET t.employee_id = t.row_id;

-- 10. cleaning the invalid salary of abby

-- a. preview
select salary,job_title,department, hire_date
from tf_staging
where job_title= 'Marketing Specialist';

-- b. update the salary
UPDATE tf_staging
SET salary = 450000
WHERE first_name = 'Abby';

-- 11. leaning the outlier hire date 2028-03-15
UPDATE tf_staging  
SET hire_date = '2018-03-15'
WHERE hire_date = '2028-03-15'