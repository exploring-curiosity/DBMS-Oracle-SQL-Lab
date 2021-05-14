SET SERVEROUTPUT ON;

REM 1. Check whether the given pizza type is available. If not display appropriate message.

DECLARE
	ptype pizza.pizza_type%type;	

BEGIN
	ptype := '&ptype';
	UPDATE pizza SET pizza_type=pizza_type WHERE pizza_type=ptype;    	
	if SQL%found then
		dbms_output.put_line('PIZZA IS AVAILABLE');
	else
		dbms_output.put_line('PIZZA NOT AVAILABLE');
	END IF;	
END;
/