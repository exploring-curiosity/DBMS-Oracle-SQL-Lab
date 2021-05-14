
REM 3.Display the customer name along with the details of pizza type and 
REM its quantity ordered for the given order number. Also find the total quantity 
REM ordered for the givenorder number


DECLARE
    c_name customer.cust_name%TYPE;
    p_type pizza.pizza_type % TYPE;
    qty NUMBER(2);
    total_qty NUMBER(2);
    order_id orders.order_no%TYPE;

    CURSOR order_cur IS
        SELECT cust_name,pizza_type,qty
        FROM pizza,order_list,customer,orders
        WHERE pizza.pizza_id=order_list.pizza_id
        AND  orders.cust_id = customer.cust_id
        AND order_list.order_no=orders.order_no
        AND orders.order_no = order_id;

BEGIN
    order_id:='&order_id';
    total_qty:=0;

    OPEN order_cur;
    

    FETCH order_cur INTO c_name,p_type,qty;


    IF order_cur%FOUND=TRUE THEN
        DBMS_OUTPUT.PUT_LINE('Customer Name: '||c_name);
        DBMS_OUTPUT.PUT_LINE('Pizza Orders: ');
        DBMS_OUTPUT.PUT_LINE(RPAD('PIZZA TYPE', 15)||RPAD('QTY', 5));
        WHILE order_cur%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE(RPAD(p_type, 15)||RPAD(qty, 5));
            total_qty:=total_qty+qty;
            FETCH order_cur INTO c_name,p_type, qty;
        END LOOP;

        DBMS_OUTPUT.PUT_LINE('----------------------');
        DBMS_OUTPUT.PUT_LINE('Total Quantity:'||total_qty);

    ELSE
        DBMS_OUTPUT.PUT_LINE('INVALID ORDER NO');

    END IF;

    CLOSE order_cur;
   
END;
/

