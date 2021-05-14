DROP PROCEDURE genbill;

CREATE PROCEDURE genbill(ornum IN varchar2) IS
	cust_rec customer%rowtype;
	CURSOR detail IS
		SELECT pizza_type,qty,unit_price,qty*unit_price
		FROM pizza NATURAL JOIN order_list WHERE order_no=ornum;
	str varchar2(20);
	a int;
	b int;
	c int;
	i int;
	d real;
	x date;
BEGIN
	SELECT cust_id,cust_name,address,phone INTO cust_rec FROM customer natural join orders WHERE order_no=ornum;
	SELECT order_date INTO x FROM orders WHERE order_no=ornum;
	DBMS_OUTPUT.PUT_LINE('**************************************************************');
	DBMS_OUTPUT.PUT_LINE('Order Number: '||ornum||chr(9)||chr(9)||'Customer Name:'||cust_rec.cust_name);
	DBMS_OUTPUT.PUT_LINE('Order Date:'||x||chr(9)||chr(9)||'Phone: '||cust_rec.phone);
	DBMS_OUTPUT.PUT_LINE('**************************************************************');
	OPEN detail;
	FETCH detail INTO str,a,b,c;
	i:=1;
	DBMS_OUTPUT.PUT_LINE('SNo'||CHR(9)||'Pizza Type'||CHR(9)||'Qty'||CHR(9)||'Price'||CHR(9)||'Amount');
	WHILE detail%FOUND LOOP
		DBMS_OUTPUT.PUT_LINE(i||'.'||CHR(9)||str||CHR(9)||CHR(9)||a||CHR(9)||b||CHR(9)||c);   
		i:=i+1;
		FETCH detail INTO str,a,b,c;
	END LOOP;   
	CLOSE detail;
	DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
	SELECT TotalPizza(order_no) INTO a FROM orders WHERE order_no = ornum;
	CalAmount(ornum);
	SELECT total_amt,discount,bill_amt INTO b,c,d FROM orders WHERE order_no=ornum;
	DBMS_OUTPUT.PUT_LINE(CHR(9)||'Total = '||CHR(9)||a||CHR(9)||CHR(9)||b);
	DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Total Amount '||CHR(9)||CHR(9)||':Rs.'||b);
	DBMS_OUTPUT.PUT_LINE('Discount ('||c||'%)'||CHR(9)||CHR(9)||':Rs.'||b*c*0.01);
	DBMS_OUTPUT.PUT_LINE('------------------------------- ----');
	DBMS_OUTPUT.PUT_LINE('Amount to be paid'||CHR(9)||':Rs.'||d);
	DBMS_OUTPUT.PUT_LINE('------------------------------- ----');
	DBMS_OUTPUT.PUT_LINE('Great Offers! Discount up to 25% on DIWALI Festival Day...');
	DBMS_OUTPUT.PUT_LINE('**************************************************************');
END;
/

DECLARE
	ornum VARCHAR2(10);
BEGIN
	ornum:='&order_number';
	SELECT order_no INTO ornum FROM ORDERS WHERE order_no=ornum;
	IF sql%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE('Invalid Order Number');
	ELSE
		genbill(ornum);
	END IF;
END;
/