rem*************************
rem Sudharshan R
rem 185001173

drop table employee;

CREATE TABLE EMPLOYEE
( e_no NUMBER(3) constraint eno_pk PRIMARY KEY,
  name VARCHAR2(15) constraint name_null NOT NULL,
  dob date constraint dob_null NOT NULL,
  dept VARCHAR2(20) constraint dept_null NOT NULL,
  room_no NUMBER(3) ,  
  salary NUMBER(10,2)
);

INSERT INTO EMPLOYEE VALUES
( 1,
  'Sudan',
  '27-JUN-00',
  'cse',
  311,
  24000.00
);

INSERT INTO EMPLOYEE VALUES
( 2,
  'Sree',
  '24-JUN-00',
  'ece',
  211,
  34000.00
);

INSERT INTO EMPLOYEE VALUES
( 3,
  'Shiva',
  '21-JUN-00',
  'cse',
  511,
  14000.00
);

SELECT * FROM EMPLOYEE; 

rem ********************************
rem violation of primary key e_no 

INSERT INTO EMPLOYEE VALUES
( 3,
  'Sva',
  '29-JUN-00',
  'rse',
  341,
  15000.00
);

rem ********************************

rem violation of null name 

INSERT INTO EMPLOYEE VALUES
( 4,
  null,
  '29-JUN-00',
  'rse',
  341,
  15000.00
);


rem ********************************
rem violation of null dob 

INSERT INTO EMPLOYEE VALUES
( 3,
  'Sva',
  null,
  'rse',
  341,
  15000.00
);

rem ********************************
rem violation of null dept

INSERT INTO EMPLOYEE VALUES
( 3,
  'Sva',
  '29-JUN-00',
  null,
  341,
  15000.00
);

