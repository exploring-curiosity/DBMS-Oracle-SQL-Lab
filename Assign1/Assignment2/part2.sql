drop table employees;

@Z:\Assignment2\employees.sql

rem ***************************************
rem 11. Display firsy name, job id and salary of all the employees.
rem ***************************************

SELECT first_name,job_id,salary 
FROM employees;

rem ****************************************
rem 12. Display the id, name(first & last), salary and annual salary of all the employees.
rem Sort the employees by first name. Label the columns as shown below:
rem (EMPLOYEE_ID, FULL NAME, MONTHLY SAL, ANNUAL SALARY)
rem ****************************************

SELECT employee_id AS EMPLOYEE_ID ,CONCAT(CONCAT(first_name,' '),last_name) AS FULL_NAME,
salary AS MONTHLYSAL,salary*12 AS ANNUALSAL 
FROM employees 
ORDER BY first_name;

rem ****************************************
rem 13. List the different jobs in which the employees are working for.
rem ****************************************

SELECT DISTINCT(job_id) 
FROM Employees;

rem ****************************************
rem 14. Display the id, first name, job id, salary and commission of employees  
rem who are earning commissions
rem ****************************************

SELECT employee_id,first_name,job_id,salary,commission_pct 
FROM employees 
WHERE commission_pct IS NOT NULL;

rem ****************************************
rem 15. Display the details (id, first name, job id, salary and dept id) of employees who are
rem MANAGERS.
rem ****************************************

SELECT employee_id,first_name,job_id,salary,department_id 
FROM employees 
WHERE job_id LIKE '%MAN' OR job_id LIKE '%MGR';

rem ****************************************
rem 16. Display the details of employees other than sales representatives 
rem (id, first name, hire date,job id, salary and dept id) who are hired after ‘01­May­1999’ 
rem or whose salary is at least 10000.
rem ****************************************

SELECT employee_id,first_name,hire_date,job_id,salary,department_id 
FROM employees 
WHERE (job_id NOT IN ('SA_REP')) AND ( hire_date >= '01-MAY-1999' OR salary >=10000);

rem ****************************************
rem 17. Display the employee details (first name, salary, hire date and dept id) 
rem whose salary falls in the range of 5000 to 15000 and his/her name begins with
rem  any of characters (A,J,K,S). Sort the output by first name.
rem ****************************************

SELECT first_name,salary,hire_date,department_id 
FROM employees 
WHERE (salary >= 5000 AND salary <= 15000) AND (SUBSTR(first_name,1,1) IN ('A','J','K','S'))
ORDER BY first_name;

rem ****************************************
rem 18. Display the experience of employees in no. of years and months who were hired after 
rem 1998.Label the columns as: (EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, EXP­YRS, EXP­MONTHS)
rem ****************************************

SELECT employee_id,first_name,hire_date,floor(months_between(SYSDATE,hire_date)/12) "EXP-YRS",
floor(Mod(months_between(SYSDATE,hire_date),12)) "EXP-MONTHS" 
FROM employees 
WHERE extract(year from hire_date)>1998;

rem ****************************************
rem 19. Display the total number of departments.
rem ****************************************

SELECT COUNT(DISTINCT(department_id)) 
FROM employees;

rem ****************************************
rem 20. Show the number of employees hired by year­wise. Sort the result by year­wise.
rem ****************************************

SELECT extract(year from hire_date) AS year,COUNT(*) AS No_of_emp  
FROM employees 
GROUP BY extract(year from hire_date) 
ORDER BY extract(year from hire_date);

rem ****************************************
rem 21. Display the minimum, maximum and average salary, number of employees for each
rem department. Exclude the employee(s) who are not in any department. Include the
rem department(s) with at least 2 employees and the average salary is more than 10000. 
rem Sort the result by minimum salary in descending order.
rem ****************************************

SELECT min(salary),max(salary),avg(salary),count(department_id) 
FROM employees 
GROUP BY department_id 
HAVING COUNT(*)>1 AND department_id IS NOT NULL AND avg(salary)>10000 
ORDER BY min(salary) DESC;
