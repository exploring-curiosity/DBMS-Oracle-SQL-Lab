REM Dropping tables...

DROP TABLE ORDER_LIST;
DROP TABLE ORDERS;
DROP TABLE PIZZA;
DROP TABLE CUSTOMER;

REM creating CUSTOMER table..

CREATE TABLE CUSTOMER(
cust_id varchar2(10) CONSTRAINT cust_id_pk PRIMARY KEY,
cust_name varchar2(30),
address varchar2(50), 
phone number(10)	
);

REM creating PIZZA table..

CREATE TABLE PIZZA(
pizza_id varchar2(20) CONSTRAINT pizza_id_pk PRIMARY KEY, 
pizza_type varchar2(30), 
unit_price number(10)
);

REM creating ORDERS table..

CREATE TABLE ORDERS(
order_no varchar2(10) CONSTRAINT order_no_pk PRIMARY KEY,
cust_id varchar2(10),
order_date date,
delv_date date,
total_amt number,
CONSTRAINT c_id_fk FOREIGN KEY(cust_id) REFERENCES CUSTOMER(cust_id)
);

REM creating ORDER_LIST table..

CREATE TABLE ORDER_LIST(
order_no varchar2(20),
pizza_id varchar2(20),
qty number(10),
CONSTRAINT order_pizza_pk PRIMARY KEY(order_no,pizza_id),
CONSTRAINT order_pizza_fk1 FOREIGN KEY(pizza_id) REFERENCES PIZZA(pizza_id),
CONSTRAINT order_pizza_fk2 FOREIGN KEY(order_no) REFERENCES ORDERS(order_no)
);



