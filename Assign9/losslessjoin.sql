rem *****************************************************************************************
rem Joining the 3NF tables EMPLOYEE,DEPARTMENT,PROJECT,WORKS_ON using NATURAL JOIN
rem *****************************************************************************************

SELECT * FROM EMPLOYEE 
	NATURAL JOIN DEPARTMENT
	NATURAL JOIN PROJECT
	NATURAL JOIN WORKS_ON
	ORDER BY empid;

rem *****************************************************************************************
rem displaying the 1NF COMPANY Table
rem *****************************************************************************************

SELECT * FROM COMPANY 
	ORDER BY empid;
	
rem *****************************************************************************************
rem INFERENCE : Join of 3NF decomposed tables has given the same result as that of the 
rem 		1NF table COMPANY
rem 		So LOSSLESS JOIN property is preserved
 	