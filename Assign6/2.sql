DROP PROCEDURE CalAmount;

CREATE Procedure CalAmount(ornum IN varchar2) IS
	total int;
	dis int;
	bill real;
BEGIN
	total:=0;
	SELECT SUM(qty*unit_price) INTO total FROM order_list natural join pizza WHERE order_no=ornum;
	IF (total>2000 AND total<=5000) THEN
		dis:=5;
	ELSIF (total<=10000 AND total>5000) THEN
		dis:=10;
	ELSIF (total>10000) THEN
		dis:=20;
	ELSE
		dis:=0;
	END IF;
	bill := total - (total * dis * 0.01);
	UPDATE orders 
	SET total_amt=total,discount=dis,bill_amt=bill
	WHERE order_no=ornum;
END;
/


DECLARE
	ord varchar2(5);
	CURSOR orslct IS 
		SELECT order_no 
		FROM orders;
BEGIN
	OPEN orslct;
	FETCH orslct INTO ord;
	WHILE orslct%FOUND LOOP
		CalAmount(ord);
		FETCH orslct INTO ord;
	END LOOP;
	CLOSE orslct;
END;
/


SELECT * FROM ORDERS;
