rem ***************************************************************************************
rem Consider the following relation Company with the set of functional dependencies:
rem COMPANY(empid, name, address, bdate, sex, salary, dno, dname, mgr_id, pno, pname, pdno, hrs)
rem fd1: empid -> name, address, bdate, sex, salary, dno
rem fd2: dno -> dname, mgr_id
rem fd3: pno -> pname, pdno where pdno is the DEPARTMENT controlling the PROJECT.
rem fd4: empid, pno -> hrs
rem Identify the primary key. Given the FD, key attributes now decompose the Company relation into
rem various Normal forms.
rem To prove that the decomposition is correct: apply the two properties
rem a) The lossless-join decomposition.
rem b) Preservation of FD.
rem For lossless-join decomposition, use the instances as shown below to populate your Company
rem relation before decomposition
rem INSTANCES AS IN PDF
rem From the above instances, its clear that the relation Company has 16 tuples. Join all the decomposed
rem relations and prove that the join results in loss-less join decomposition.
rem *****************************************************************************************




rem The primary key is identified to be empid,pno

rem Creating the company relation

DROP TABLE COMPANY;

CREATE TABLE COMPANY
(
	empid NUMBER(9),
	name VARCHAR(20),
	address VARCHAR2(30),
	bdate DATE,
	sex CHAR(1),
	salary NUMBER(7),
	dno NUMBER(2),
	dname VARCHAR2(20),
	mgr_id NUMBER(9),
	pno NUMBER(2),
	pname VARCHAR2(20),
	pdno NUMBER(1),
	hrs NUMBER(3,1),
	CONSTRAINT cmp_pk PRIMARY KEY (empid,pno)
);

rem *******************************************************************************************
rem Populating COMPANY based on given instances
rem *******************************************************************************************

INSERT INTO COMPANY VALUES
(
	123456789,'John B Smith','731 Fondren, Houston, TX','09-JAN-1965','M',
	30000,5,'Research',333445555,1,'ProductX',5,32.5
);

INSERT INTO COMPANY VALUES
(
	123456789,'John B Smith','731 Fondren, Houston, TX','09-JAN-1965','M',
	30000,5,'Research',333445555,2,'ProductY',5,7.5
);


INSERT INTO COMPANY VALUES
(
	333445555,'Franklin T Wong','638 Voss, Houston, TX','08-DEC-1955','M',
	40000,5,'Research',333445555,2,'ProductY',5,10.0
);

INSERT INTO COMPANY VALUES
(
	333445555,'Franklin T Wong','638 Voss, Houston, TX','08-DEC-1955','M',
	40000,5,'Research',333445555,3,'ProductZ',5,10.0
);

INSERT INTO COMPANY VALUES
(
	333445555,'Franklin T Wong','638 Voss, Houston, TX','08-DEC-1955','M',
	40000,5,'Research',333445555,10,'Computerization',4,10.0
);

INSERT INTO COMPANY VALUES
(
	333445555,'Franklin T Wong','638 Voss, Houston, TX','08-DEC-1955','M',
	40000,5,'Research',333445555,20,'Reorganization',1,10.0
);

INSERT INTO COMPANY VALUES
(
	999887777,'Alicia J Zelaya','3321 Castle, Spring, TX','19-Jan-1968','F',
	25000,4,'Administration',987654321,30,'Newbenefits',4,30.0
);

INSERT INTO COMPANY VALUES
(
	999887777,'Alicia J Zelaya','3321 Castle, Spring, TX','19-Jan-1968','F',
	25000,4,'Administration',987654321,10,'Computerization',4,10.0
);

INSERT INTO COMPANY VALUES
(
	987854321,'Jennifer S Wallace','291 Berry, Bellaire, TX','20-Jun-1941','F',
	43000,4,'Administration',987654321,30,'Newbenefits',4,20.0
);

INSERT INTO COMPANY VALUES
(
	987854321,'Jennifer S Wallace','291 Berry, Bellaire, TX','20-Jun-1941','F',
	43000,4,'Administration',987654321,20,'Reorganization',1,15.0
);

INSERT INTO COMPANY VALUES
(
	666884444,'Ramesh K Narayan','975 Fire Oak, Humble, TX','15-Sep-1962','M',
	38000,5,'Research',333445555,3,'ProductZ',5,40.0
);

INSERT INTO COMPANY VALUES
(
	453453453,'Joyce A English','5631 Rice, Houston, TX','31-Jul-1972','F',
	25000,5,'Research',333445555,1,'ProductX',5,20.0
);

INSERT INTO COMPANY VALUES
(
	453453453,'Joyce A English','5631 Rice, Houston TX','31-Jul-1972','F',
	25000,5,'Research',333445555,2,'ProductY',5,20.0
);

INSERT INTO COMPANY VALUES
(
	987987987,'Ahmad V Jabbar','980 Dallas, Houston, TX','29-Mar-1969','M',
	25000,4,'Administration',987654321,30,'Newbenefits',4,5.0
);

INSERT INTO COMPANY VALUES
(
	987987987,'Ahmad V Jabbar','980 Dallas, Houston, TX','29-Mar-1969','M',
	25000,4,'Administration',987654321,10,'Computerization',4,35.0
);

INSERT INTO COMPANY VALUES
(
	888665555,'James E Borg','450 Stone, Houston, TX','10-Nov-1937','M',
	55000,1,'Headquarters',NULL,20,'Reorganization',1,NULL
);

rem *************************************************************************************
rem decomposing to 3NF
rem *************************************************************************************

rem *************************************************************************************
rem FD1 ->  empid -> name, address, bdate, sex, salary, dno
rem creating EMPLOYEE using FD1
rem *************************************************************************************

DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;

CREATE TABLE EMPLOYEE
(
	empid NUMBER(9) CONSTRAINT emp_pk PRIMARY KEY,
	name VARCHAR2(20) ,
	address VARCHAR2(30),
	bdate DATE,
	sex CHAR(1),
	salary NUMBER(7),
	dno NUMBER(2)
);

rem *************************************************************************************
rem FD2 -> dno -> dname, mgr_id
rem Creating DEPARTMENT using FD2
rem *************************************************************************************

DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;

CREATE TABLE DEPARTMENT 
(
	dno NUMBER(1) CONSTRAINT dept_pk PRIMARY KEY,
	dname VARCHAR2(20),
	mgr_id NUMBER (9) CONSTRAINT mgr_id_fk REFERENCES EMPLOYEE(empid)
); 


rem **************************************************************************************	
rem FD3 -> pno -> pname, pdno 
rem Creating PROJECT using FD3
rem **************************************************************************************	
	
DROP TABLE PROJECT CASCADE CONSTRAINTS;

create table PROJECT(
	pno NUMBER(2) CONSTRAINT pno_pk PRIMARY KEY,
	pname VARCHAR2(15),
	pdno number(2) CONSTRAINT pdno_fk REFERENCES DEPARTMENT(dno)
);



rem **************************************************************************************	
rem FD4 -> empid, pno -> hrs 
rem Creating WORKS_ON using FD3
rem **************************************************************************************

DROP TABLE WORKS_ON CASCADE CONSTRAINTS;

create table WORKS_ON(
	empid NUMBER(9) CONSTRAINT empid_fk REFERENCES EMPLOYEE(empid),
	pno NUMBER(2) CONSTRAINT pno_fk REFERENCES PROJECT(pno),
	hours NUMBER(3,1),
	CONSTRAINT eid_pno_pk PRIMARY KEY (empid,pno)
);


rem **************************************************************************************
rem Populating all 3NF tables created Above
rem **************************************************************************************

rem **************************************************************************************
rem Poplating EMPLOYEE
rem **************************************************************************************

INSERT INTO EMPLOYEE VALUES
(
	123456789,'John Smith','731 Fondren,Houston,TX','05-APR-1986','M',30000.00,5
);

INSERT INTO EMPLOYEE VALUES
(
	333445555,'Franklin Wong','638 Voss,Houston,TX','25-OCT-1983','M',40000.00,5
);

INSERT INTO EMPLOYEE VALUES
(
	999887777,'Alicia Zelaya','3321 Castle,Spring,TX','03-MAY-1958','F',25000.00,4
);

INSERT INTO EMPLOYEE VALUES
(
	987654321,'Jennifer Wallace','291 Berry,Bellaire,TX','28-FEB-1942' ,'F',43000.00,4
);

INSERT INTO EMPLOYEE VALUES
(	
	666884444,'Ramesh Narayan','975 Fire Oak,Humble,TX','04-JAN-1988','M',38000.00,5
);

INSERT INTO EMPLOYEE VALUES
(	
	453453453,'Joyce English','5631 Rice,Houston,TX','30-DEC-1988','F',25000.00,5
);

INSERT INTO EMPLOYEE VALUES
(	
	987987987,'Ahmad Jabbar','980 Dallas,Houston,TX','05-MAY-1989','M',25000.00,4
);

INSERT INTO EMPLOYEE VALUES
(
	888665555,'James Borg','450 Stone,Houston,TX','23-APR-1978','M',55000.00,1
);

rem **************************************************************************************
rem Populating DEPARTMENT
rem **************************************************************************************


INSERT INTO DEPARTMENT VALUES
(
	5,'Research',333445555
);

INSERT INTO DEPARTMENT VALUES
(
	4,'Administration',987654321
);

INSERT INTO DEPARTMENT VALUES
(
	1,'Headquarters',NULL
);

rem **************************************************************************************
rem Populating PROJECT
rem **************************************************************************************

INSERT INTO PROJECT VALUES
(
	1,'ProductX',5
);

INSERT INTO PROJECT VALUES
(
	2,'ProductY',5
);

INSERT INTO PROJECT VALUES
(
	3,'ProductZ',5
);

INSERT INTO PROJECT VALUES
(
	10,'Computerization',4
);

INSERT INTO PROJECT VALUES
(
	20,'Reorganization',1
);

INSERT INTO PROJECT VALUES
(
	30,'Newbenefits',4
);


rem **************************************************************************************
rem Populating WORKS_ON
rem **************************************************************************************


INSERT INTO WORKS_ON VALUES
(
	123456789,1,32.5
);

INSERT INTO WORKS_ON VALUES
(
	123456789,2,7.5
);

INSERT INTO WORKS_ON VALUES
(
	666884444,3,40.0
);

INSERT INTO WORKS_ON VALUES
(
	453453453,1,20.0
);

INSERT INTO WORKS_ON VALUES
(
	453453453,2,20.0
);

INSERT INTO WORKS_ON VALUES
(
	333445555,2,10.0
);

INSERT INTO WORKS_ON VALUES
(
	333445555,3,10.0
);

INSERT INTO WORKS_ON VALUES
(
	333445555,10,10.0
);
INSERT INTO WORKS_ON VALUES
(
	333445555,20,10.0
);

INSERT INTO WORKS_ON VALUES
(
	999887777,30,30.0
);

INSERT INTO WORKS_ON VALUES
(
	999887777,10,10.0
);

INSERT INTO WORKS_ON VALUES
(
	987987987,10,35.0
);

INSERT INTO WORKS_ON VALUES
(
	987987987,30,5.0
);

INSERT INTO WORKS_ON VALUES
(
	987654321,30,20.0
);

INSERT INTO WORKS_ON VALUES
(
	987654321,20,15.0
);

INSERT INTO WORKS_ON VALUES
(
	888665555,20,NULL
);
