rem *************************************
rem R SUDHARSHAN
rem 185001173
rem CSE - c
rem 2nd Year
rem *************************************




DROP TABLE Employee Cascade CONSTRAINTS;
DROP TABLE Certified Cascade CONSTRAINTS;
DROP TABLE Aircraft Cascade CONSTRAINTS;
DROP TABLE Routes Cascade CONSTRAINTS;
DROP TABLE Flights Cascade CONSTRAINTS;
DROP TABLE Fl_schedule Cascade CONSTRAINTS;

@F:\SEM4\DBMS\Assign3\air_cre.sql
@F:\SEM4\DBMS\Assign3\air_pop.sql

rem ********************************************************************
rem : 1. Display the flight number,departure date and time of a flight,
rem : its  route details and aircraft name of type either Schweizer
rem : or Piper that departs during 8.00 PM AND 9.00 PM
rem ********************************************************************

SELECT f.flightno,s.departs,s.dtime ,r.routeid ,r.orig_airport ,r.dest_airport ,r.distance,a.aname 
FROM flights f 
JOIN fl_schedule s ON(f.flightno = s.flno) 
JOIN routes r ON(f.rid=r.routeid) 
JOIN aircraft a ON (f.aid= a.aid)
WHERE (a.type IN ('Schweizer','Piper')) AND (s.dtime BETWEEN 2000 AND 2100);

rem ********************************************************************
rem : 2. For all the routes, display the flight number, origin and destination airport, if a flight is 
rem : assigned for that route.
rem ********************************************************************

SELECT routeid,flightno,orig_airport,dest_airport
FROM flights f RIGHT OUTER JOIN routes r ON(f.rid=r.routeid);

rem ********************************************************************
rem : 3. For all aircraft with cruisingrange over 5,000 miles, find the name of the aircraft and the 
rem : average salary of all pilots certified for this aircraft.
rem ********************************************************************
 
SELECT aname as Aircraft_Name,Round(AVG(salary),2) as AVG_emp_SAL
FROM aircraft a JOIN certified c USING (aid) JOIN employee e USING (eid)
WHERE cruisingrange > 5000
GROUP BY aname;


rem ********************************************************************
rem : 4. Show the employee details such as id, name and salary who are not pilots and whose salary 
rem : is more than the average salary of pilots.
rem ********************************************************************

SELECT eid,ename,salary
FROM employee e
WHERE eid NOT IN (SELECT eid FROM certified c)
AND salary >(SELECT AVG(salary) 
             FROM employee JOIN certified
             USING(eid)
	    );


rem ********************************************************************
rem : 5. Find the id AND name of pilots who were certified to operate some aircrafts but at least one 
rem : of that aircraft is not scheduled from any routes.
rem ********************************************************************

SELECT distinct eid,ename
FROM employee e 
JOIN certified c  USING (eid) 
JOIN aircraft a USING (aid)
WHERE aid NOT IN (SELECT f.aid 
		  FROM flights f 
		  JOIN fl_schedule m ON(f.flightNo=m.flno)
		 );


rem ********************************************************************
rem : 6. Display the origin AND destination of the flights having at least three departures with 
rem : maximum distance covered.
rem ********************************************************************

SELECT orig_airport,dest_airport
FROM routes r
WHERE distance IN
       (SELECT max(ro.distance)
	FROM routes ro,fl_schedule s
	GROUP BY s.flno
	HAVING count(s.departs)>=3
       );

rem ********************************************************************
rem : 7. Display name and salary of pilot whose salary is more than the average salary of any pilots 
rem : for each route other than flights originating from Madison airport.
rem ********************************************************************

SELECT DISTINCT e.ename,e.salary
FROM Employee e,Certified c,Aircraft a,Routes r,Flights f
WHERE 	(f.rid=r.routeid)
	AND (f.aid=a.aid)
	AND (a.aid=c.aid)
	AND (c.eid=e.eid)
	AND r.routeid IN
		(
			SELECT routeid FROM routes
			WHERE orig_airport<>'Madison'
		)
	AND e.salary >
		(
			SELECT avg(salary)
			FROM employee e INNER JOIN certified c ON (e.eid=c.eid)
		);


rem ********************************************************************
rem : 8. Display the flight number, aircraft type, source and destination airport of the aircraft having 
rem : maximum number of flights to Honolulu;
rem ********************************************************************

SELECT flightno,type,orig_airport,dest_airport
FROM aircraft a JOIN flights f USING(aid) JOIN routes r ON(f.rid=r.routeid)
WHERE dest_airport='Honolulu' 
      AND aid IN (SELECT aid
             FROM aircraft a JOIN flights f USING(aid) JOIN routes r ON(f.rid=r.routeid)
             WHERE dest_airport = 'Honolulu'
             GROUP BY aid 
	     HAVING count(*) = ( SELECT max(count(*)) 
				 FROM aircraft a JOIN flights f USING(aid) JOIN routes r ON(f.rid=r.routeid)
				 WHERE dest_airport = 'Honolulu'
				 GROUP BY aid
			       )
	    );

rem ********************************************************************
rem: 9. Display the pilot(s) who are certified exclusively to pilot all aircraft in a type.
rem ********************************************************************


SELECT * 
FROM employee 
WHERE eid IN (SELECT c.eid
			 FROM certified c JOIN aircraft a ON(c.aid=a.aid)
			 WHERE c.eid IN (SELECT c1.eid
							FROM certified c1 JOIN aircraft a1 ON(c1.aid=a1.aid)
							GROUP BY c1.eid
							HAVING(count(DISTINCT a1.type)) = 1
							)
			 GROUP BY c.eid,a.type
			 HAVING count(*) = (  SELECT count(a1.aid)
								 FROM aircraft a1 
								 WHERE a1.type = a.type
							   )
			);


rem **********************************************************************
rem: 10. Name the employee(s) who is earning the maximum salary among the airport having
rem: maximum number of departures.

rem **********************************************************************


SELECT DISTINCT (ename),salary
FROM flights f,routes r,aircraft a,certified c,employee e
WHERE
	(f.rid=r.routeid)
	AND (f.aid=a.aid)
	AND (a.aid=c.aid)
	AND (c.eid=e.eid)
	AND orig_airport=
		(
			select orig_airport
			FROM Routes ro,flights ff,fl_schedule fs
			WHERE (ro.routeid=ff.rid) AND (ff.flightno=fs.flno)
			group by orig_airport
			having count(*)=
				(
					SELECT max(count)
					FROM (SELECT count(*) AS count
						FROM Routes ro,flights ff,fl_schedule fs
						WHERE (ro.routeid=ff.rid) AND (ff.flightno=fs.flno)
					  	GROUP BY orig_airport)
				)
		)
	AND salary=
	(
		SELECT max(salary)
		FROM flights fl,routes ro,aircraft ai,certified ce,employee em
		WHERE
			(fl.rid=ro.routeid)
			AND (fl.aid=ai.aid)
			AND (ai.aid=ce.aid)
			AND (ce.eid=em.eid)
		GROUP BY orig_airport
		HAVING ro.orig_airport=r.orig_airport
	);


rem ***************************************************************************
rem: 11. Display the departure chart as follows:
rem: flight number, departure(date,airport,time), destination airport, arrival time, aircraft name
rem: for the flights FROM New York airport during 15 to 19th April 2005. Make sure that the route
rem: contains at least two flights in the above specified condition.
rem ***************************************************************************

SELECT DISTINCT	fl.flno,fl.departs,r.orig_airport,fl.dtime,r.dest_airport,fl.atime,a.aname
FROM fl_schedule fl,flights f,routes r,aircraft a
WHERE
	(f.flightno=fl.flno)
	AND (f.rid=r.routeid)
	AND (f.aid=a.aid)
	AND r.orig_airport='New York'
	AND (fl.departs BETWEEN '15-APR-2005' AND '19-APR-2005')
	AND (
			SELECT count(*)
			FROM 
			(
				SELECT fl.flno
				FROM fl_schedule fl,flights f,routes r
				WHERE (f.flightno=fl.flno)
					AND (f.rid=r.routeid)
					AND (fl.departs BETWEEN '15-APR-2005' AND '19-APR-2005')
					AND r.orig_airport='New York'
			)
		)>=2;

rem ********************************************************************
rem: 12. A customer wants to travel from Madison to New York with no more than two changes of
rem: flight. List the flight numbers from Madison if the customer wants to arrive in New York by 6.50 p.m.
rem **********************************************************************

SELECT flightno
FROM flights
WHERE flightno IN
	(
		SELECT f0.flightno
		FROM ((fl_schedule fl0 INNER JOIN flights f0 ON (fl0.flno=f0.flightno)) INNER JOIN routes r0 ON (f0.rid=r0.routeid))
		WHERE (r0.orig_airport='Madison') AND 
			(r0.dest_airport='New York') AND
			(fl0.atime<=1850) 
	)
	UNION
	(
		SELECT f0.flightno
		FROM ((fl_schedule fl0 INNER JOIN flights f0 ON (fl0.flno=f0.flightno)) INNER JOIN routes r0 ON (f0.rid=r0.routeid)),
			((fl_schedule fl1 INNER JOIN flights f1 ON (fl1.flno=f1.flightno)) INNER JOIN routes r1 ON (f1.rid=r1.routeid))
		WHERE (r0.dest_airport=r1.orig_airport) AND
			(r0.orig_airport='Madison') AND 
			(fl0.arrives<=fl1.departs) AND
			(r1.orig_airport<>'New York') AND
			(r1.dest_airport='New York') AND
			(fl1.atime<1850)
	);

rem ********************************************************************
rem: 13. Display the id and name of employee(s) who are not pilots.
rem ********************************************************************

SELECT e.eid,e.ename FROM employee e
WHERE e.eid IN
	(SELECT e1.eid FROM employee e1
	 MINUS
	 SELECT c.eid FROM certified c);

rem ********************************************************************
rem: 14. Display the id and name of pilot(s) who pilot the aircrafts from
rem: Los Angels and Detroit airport.
rem ********************************************************************
SELECT DISTINCT eid,e.ename 
FROM 
	employee e JOIN certified c USING (eid) 
	JOIN flights f using(aid) 
	JOIN aircraft a using(aid) 
	JOIN routes r on (r.routeID=f.rID) 
WHERE 
	r.orig_airport='Los Angeles'
INTERSECT
SELECT DISTINCT eid,e.ename 
FROM 
	employee e join certified c using (eid) 
	JOIN flights f using(aid) 
	JOIN aircraft a using(aid) 
	JOIN routes r on (r.routeID=f.rID) 
WHERE 
	r.orig_airport='Detroit';
