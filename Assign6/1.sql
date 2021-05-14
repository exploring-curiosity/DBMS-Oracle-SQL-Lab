DROP FUNCTION TotalPizza;

CREATE FUNCTION TotalPizza(ornum IN varchar2) RETURN int IS
num int;
BEGIN
SELECT SUM(qty) INTO num FROM order_list WHERE order_no=ornum;
RETURN num;
END;
/

SELECT order_no,TotalPizza(order_no) AS "Total pizza" from orders;