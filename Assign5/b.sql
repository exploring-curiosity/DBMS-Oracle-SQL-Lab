
REM 2. For the given customer name and a range of order date, find whether a customer had
REM placed any order, if so display the number of orders placed by the customer along 
REM with the order number(s).

DECLARE
	no_of_orders NUMBER(3);
    order_id CHAR(5);
    c_name customer.cust_name % TYPE;
    start_date DATE;
    end_date DATE;
    
    CURSOR order_select IS
		SELECT order_no
		FROM orders, customer
		WHERE order_date BETWEEN start_date AND end_date
        AND customer.cust_id = orders.cust_id
        AND cust_name = c_name;

BEGIN
	c_name := '&c_name';
	start_date := '&start_date';
	end_date := '&end_date';
    
	OPEN order_select;
    
    	FETCH order_select INTO order_id;
    
	IF order_select%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE('Customer '||c_name||' has not done any orders in this time period.');
	ELSE
        DBMS_OUTPUT.PUT_LINE('Orders:');
        WHILE order_select%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE(order_id);
            FETCH order_select INTO order_id;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Customer '||c_name||' has done '||order_select%ROWCOUNT||' orders in this time period.');
        
	END IF;

	CLOSE order_select;
END;
/
