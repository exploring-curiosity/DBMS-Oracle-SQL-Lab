DROP TABLE Emp_Payroll;
CREATE TABLE Emp_Payroll(
	eid NUMBER(3) CONSTRAINT eid_pk primary key,
	ename VARCHAR2(15) ,
	dob DATE,
	sex VARCHAR2(1),
	designation VARCHAR2(15),
	basic NUMBER(7,2),
	da NUMBER(7,2),
	hra NUMBER(7,2),
	pf NUMBER(7,2),
	mc NUMBER(7,2),
	gross NUMBER(7,2),
	tot_deduc NUMBER(7,2),
	net_pay NUMBER(7,2)
);


CREATE OR REPLACE PROCEDURE calc_net 
(id IN Emp_Payroll.eid % TYPE , bas IN Emp_Payroll.basic % TYPE) 
IS
	d NUMBER(7,2);
	h NUMBER(7,2);
	p NUMBER(7,2);
	m NUMBER(7,2);
	g NUMBER(7,2);
	td NUMBER(7,2);
	n NUMBER(7,2);

BEGIN
	d:=0.6*bas;
	h:=0.11*bas;
	p:=0.04*bas;
	m:=0.03*bas;
	g:=bas + d + h;
	td:=p+m;
	n:=g-td;
	UPDATE Emp_Payroll
	SET da = d,hra=h,pf=p,mc=m,gross=g,tot_deduc=td,net_pay=n
	WHERE eid=id;
END;
/
	