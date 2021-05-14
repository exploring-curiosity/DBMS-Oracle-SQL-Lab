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

@Z:\Assignment3\air_cre.sql
@Z:\Assignment3\air_pop.sql

rem *************************************************
rem 1. Display the flight number,departure date and time of a flight,
rem its route details and aircraft name of type either Schweizer or 
rem Piper that departs during 8.00 PM and 9.00 PM.
rem *************************************************

SELECT FlNo,departs,dtime,Routeid,orig_airport,dest_airport,distance,aname 
FROM Fl_Schedule 
JOIN ((Flights l JOIN Aircraft m ON l.aid=m.aid) JOIN Routes ON rid=routeID ) 
ON flightNo=flno 
WHERE aname LIKE 'Schweizer%' OR aname LIKE 'Piper%'
AND dtime >= 20 
AND dtime <= 21;

rem *************************************************
rem 2. For all the routes, display the flight number, origin and 
rem destination airport, if a flight is assigned for that route.
rem *************************************************


SELECT flightNO,orig_airport,dest_airport 
FROM Routes JOIN Flights 
ON routeID=rid;

rem ************************************************
rem 3. For all aircraft with cruisingrange over 5,000 miles, 
rem find the name of the aircraft and the average salary of 
rem all pilots certified for this aircraft.
rem ************************************************

SELECT aname,avg(salary) FROM Aircraft NATURAL
JOIN (CERTIFIED NATURAL JOIN Employee) 
GROUP BY aname
HAVING CRUISINGRANGE > 5000;