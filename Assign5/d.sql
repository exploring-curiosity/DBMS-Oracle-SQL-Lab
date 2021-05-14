REM 4. Display the total number of orders that contains one pizza type, two pizza type and 
REM so on.

DECLARE
	ptype_count NUMBER(3);
    counter NUMBER(3);
    max_count NUMBER(4);
    order_no orders.order_no % TYPE;
    
    CURSOR total_types IS
		SELECT COUNT(DISTINCT pizza_type)
		FROM pizza;
    
    CURSOR type_counter IS
        SELECT order_no
        FROM order_list
        GROUP BY order_no
        HAVING COUNT(order_no) = counter;

BEGIN
	counter := 0;
    OPEN total_types;
    
    FETCH total_types INTO max_count;
    
	IF max_count = 0 THEN
		DBMS_OUTPUT.PUT_LINE('Table: Pizza is Empty.');
	ELSE
        DBMS_OUTPUT.PUT_LINE('Number of Orders that contain: ');
        FOR COUNT IN 1..max_count LOOP
            ptype_count := 0;
            counter := counter + 1;
            OPEN type_counter;
            FETCH type_counter INTO order_no;
            WHILE type_counter%FOUND LOOP
                ptype_count := ptype_count + 1;
                FETCH type_counter INTO order_no;
            END LOOP;
            CLOSE type_counter;
            
            DBMS_OUTPUT.PUT_LINE(counter||' Pizza Type: '||ptype_count);
        END LOOP;
	END IF;

    CLOSE total_types;
END;
/