drop table employees.sql

@Z:\Assignment2\employees.sql

rem ***************************************
rem 11. Display firsy name, job id and salary of all the employees.
rem ***************************************

SELECT first_name,job_id,salary from employees;

rem ****************************************
rem 12. Display the id, name(first & last), salary and annual salary of all the employees. Sort the 
rem employees by first name. Label the columns as shown below:
rem (EMPLOYEE_ID, FULL NAME, MONTHLY SAL, ANNUAL SALARY)
rem ****************************************

SELECT employee_id AS EMPLOYEE_ID ,CONCAT(CONCAT(first_name,' '),last_name) AS FULL_NAME,salary AS MONTHLYSAL,salary*12 AS ANNUALSAL FROM employees ORDER BY first_name;

rem ****************************************
rem 13. List the different jobs in which the employees are working for.
rem ****************************************

SELECT DISTINCT(job_id) from Employees;

rem ****************************************
rem 14. Display the id, first name, job id, salary and commission of employees who are earning 
rem commissions.
rem ****************************************

SELECT employee_id,first_name,job_id,salary,commission_pct from employees WHERE commission_pct>0;