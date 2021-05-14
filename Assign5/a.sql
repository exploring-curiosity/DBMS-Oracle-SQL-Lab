
set serveroutput on;
REM 1.Check whether the given pizza type is available. If not display appropriate message.

DECLARE
	ptype pizza.pizza_type % TYPE;
    	p_id pizza.pizza_id % TYPE;
	pizza_type pizza.pizza_type % TYPE;
	u_price pizza.unit_price % TYPE;
    	
BEGIN
    ptype:='&ptype';

    SELECT pizza_id,pizza_type,unit_price INTO p_id,pizza_type,u_price
    FROM pizza 
    WHERE pizza_type=ptype;

   

    IF SQL%ROWCOUNT>0 THEN
        
        DBMS_OUTPUT.PUT_LINE('Pizza Type Found');
        DBMS_OUTPUT.PUT_LINE('Pizza_id   : '||p_id);
	DBMS_OUTPUT.PUT_LINE('Unit_Price : '||u_price);
        
    ELSE
	
        DBMS_OUTPUT.PUT_LINE('Pizza Type Not Found');
    END IF;
   

END;
/