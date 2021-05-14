SET SERVEROUTPUT ON;
REM 3. Display the customer name along with the details of pizza type and its quantity 
REM ordered for the given order number. Also find the total quantity ordered for the given
REM order number as shown below:

DECLARE
	no_of_orders NUMBER(3);
    order_id CHAR(5);
    c_name customer.cust_name % TYPE;
    p_type pizza.pizza_type % TYPE;
    qty order_list.qty % TYPE;
    
    CURSOR order_details IS
		SELECT pizza_type, qty
		FROM pizza, order_list
		WHERE order_no = order_id
        AND pizza.pizza_id = order_list.pizza_id;
    
    CURSOR person_details IS
        SELECT cust_name
        FROM customer, orders
        WHERE orders.cust_id = customer.cust_id
        AND orders.order_no = order_id;

BEGIN
	order_id := '&order_id';
    
    OPEN person_details;
    OPEN order_details;
    
    FETCH person_details INTO c_name;
    FETCH order_details INTO p_type, qty;
    
	IF person_details%FOUND = False THEN
		DBMS_OUTPUT.PUT_LINE('Specified order does not exist.');
	ELSE
        DBMS_OUTPUT.PUT_LINE('Customer Name: '||c_name||'.');
        DBMS_OUTPUT.PUT_LINE('Has ordered the following Pizza: ');
        DBMS_OUTPUT.PUT_LINE(RPAD('PIZZA TYPE', 13)||RPAD('QTY.', 4));
        WHILE order_details%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(p_type, 13)||RPAD(qty, 4));
            FETCH order_details INTO p_type, qty;
        END LOOP;
        
	END IF;

	CLOSE person_details;
	CLOSE order_details;
END;
