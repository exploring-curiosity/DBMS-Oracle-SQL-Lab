
DROP TABLE Employee Cascade CONSTRAINTS;
DROP TABLE Certified Cascade CONSTRAINTS;
DROP TABLE Aircraft Cascade CONSTRAINTS;
DROP TABLE Routes Cascade CONSTRAINTS;
DROP TABLE Flights Cascade CONSTRAINTS;
DROP TABLE Fl_schedule Cascade CONSTRAINTS;

@F:\SEM4\DBMS\Assign3\air_cre.sql
@F:\SEM4\DBMS\Assign3\air_pop.sql


DROP VIEW Schedule_15;
DROP VIEW Airtype;
DROP VIEW Losangeles_Flights;
DROP VIEW Losangeles_Route;

rem ************************************************************
rem 1 Create a view Schedule_15 that display the flight number, route, airport(origin, destination) 
rem departure (date, time), arrival (date, time) of a flight on 15 apr 2005. Label the view 
rem column as flight, route, from_airport, to_airport, ddate, dtime, adate, atime respectively.rem ************************************************************

CREATE VIEW Schedule_15 (flight, route, from_airport, to_airport, ddate, dtime, adate, atime) AS
SELECT flightno,routeID,orig_airport,dest_airport,departs,dtime,arrives,atime 
FROM Flights JOIN Routes ON (rid=routeid) JOIN fl_schedule ON (flno=flightno)
WHERE departs='15-APR-2005';

DESC Schedule_15;

SELECT * FROM Schedule_15;

SAVEPOINT s1;

SELECT table_name,Column_name,insertable
FROM USER_updatable_COLUMNS
WHERE table_name='SCHEDULE_15';

rem trying to insert

INSERT INTO Schedule_15 VALUES ('MC0097','A123','Los Angeles','Washington D.C.','24-MAR-2005',0100,'24-MAR-2005',1900);

rem insert is not allowed 

ROLLBACK TO S1;

SELECT table_name,Column_name,updatable
FROM USER_updatable_COLUMNS
WHERE table_name='SCHEDULE_15';


UPDATE Schedule_15 SET dtime=0100 WHERE route='MD200';
UPDATE Schedule_15 SET adate='28-JUN-2007' WHERE route='MD200';
UPDATE Schedule_15 SET atime=0300 WHERE route='MD200';
UPDATE Schedule_15 SET ddate='27-JUN-2007' WHERE route='MD200';

SELECT * FROM FL_schedule JOIN FLIGHTS ON(FlightNo=Flno) WHERE rid='MD200' and FLIGHTno='9E-3851';

rem update is allowed for certain attributes ddate,dtime,adate,atime

ROLLBACK TO S1;

rem Before delecting

SELECT * FROM Schedule_15 WHERE route='MD200' AND flight='9E-3851';

SELECT flightno,routeID,orig_airport,dest_airport,departs,dtime,arrives,atime 
FROM Flights JOIN Routes ON (rid=routeid) JOIN fl_schedule ON (flno=flightno)
WHERE routeid='MD200' AND flightno='9E-3851';


DELETE FROM Schedule_15 WHERE route='MD200' AND flight='9E-3851';

rem After Deleting
SELECT * FROM Schedule_15 WHERE route='MD200' AND flight='9E-3851';

SELECT flightno,routeID,orig_airport,dest_airport,departs,dtime,arrives,atime 
FROM Flights JOIN Routes ON (rid=routeid) JOIN fl_schedule ON (flno=flightno)
WHERE routeid='MD200' AND flightno='9E-3851';

ROLLBACK TO S1;

rem DELETE IS ALLOWED AND IS REFLECTED ON BASE TABLE

rem ************************************************************
rem 2 Define a view Airtype that display the number of aircrafts for each of its type. Label the 
rem column as craft_type, total.
rem ************************************************************

CREATE VIEW Airtype (craft_type,total) AS
SELECT DISTINCT(type), COUNT(*) from Aircraft
GROUP BY (type);

DESC Airtype;
SELECT * FROM Airtype;
SAVEPOINT S2;

SELECT table_name,Column_name,insertable
FROM USER_updatable_COLUMNS
WHERE table_name='AIRTYPE';

rem Trying to insert

INSERT INTO AIRTYPE VALUES ('JET',3);

rem insert not allowed

SELECT table_name,Column_name,updatable
FROM USER_updatable_COLUMNS
WHERE table_name='AIRTYPE';

rem trying to update

UPDATE Airtype set craft_type='aks' where craft_type='Boeing';
UPDATE Airtype SET Total=2 WHERE Craft_type='Piper';

rem update not allowed

rem trying to delete

DELETE FROM airtype WHERE craft_type='Airbus';

rem delete operation not allowed

ROLLBACK TO S2;
rem ************************************************************
rem 3 Create a view Losangeles_Route that contains Los Angeles in the route. Ensure that the 
rem view always contain/allows only information about the Los Angeles route.
rem ************************************************************
CREATE VIEW Losangeles_route AS
SELECT * FROM routes WHERE dest_airport='Los Angeles' OR orig_airport='Los Angeles'
WITH CHECK OPTION; 

DESC Losangeles_route;
SELECT * FROM Losangeles_route;
SAVEPOINT S3;

SELECT table_name,Column_name,insertable
FROM USER_updatable_COLUMNS
WHERE table_name='LOSANGELES_ROUTE';


rem trying to insert

INSERT INTO Losangeles_route VALUES('AB100','Madison','Montreal',1500);
INSERT INTO Losangeles_route VALUES('AB100','Los Angeles','Montreal',1500);

rem Insert allowed only for routes with los angeles(check option)

ROLLBACK TO S3;

SELECT table_name,Column_name,updatable
FROM USER_updatable_COLUMNS
WHERE table_name='LOSANGELES_ROUTE';

rem trying to update

UPDATE Losangeles_route SET routeid='AB123' WHERE routeid='LW100';
rem route id can be updated only if it has no child records


UPDATE Losangeles_route SET orig_airport='Honolulu' WHERE routeid='LW100';
rem update can be done only when Check is preserved
UPDATE Losangeles_route SET orig_airport='Honolulu' WHERE routeid='CL150';
rem update is done here

UPDATE Losangeles_route SET dest_airport='Honolulu' WHERE routeid='LW100';
rem UPDATE IS DONE HERE since Check condition is preserved
UPDATE Losangeles_route SET dest_airport='Honolulu' WHERE routeid='CL150';
rem update can be done only when Check is preserved

UPDATE Losangeles_route SET distance=1500 WHERE routeid='LW100';
rem Upadte can be done here

SELECT * from Losangeles_route WHERE routeid IN('LW100','CL150');

SELECT * from Routes WHERE routeid IN('LW100','CL150');


rem Update operation can be performed AS the With check option is verified
rem UPDATE IS reflected on Base table

ROLLBACK TO s3;

rem trying to delete

rem before deleting

rem inserting temporary feild into view

INSERT INTO Losangeles_route VALUES('AB100','Los Angeles','Montreal',1500);

SELECT * from Losangeles_route WHERE routeid='AB100';
SELECT * from Routes WHERE routeid='AB100';

DELETE FROM Losangeles_route WHERE routeid='LW100';
rem deletion can only be done whre there are no child records
DELETE FROM Losangeles_route WHERE routeid='AB100';
rem deletion is done here

SELECT * from Losangeles_route WHERE routeid='AB100';
SELECT * from Routes WHERE routeid='AB100';
 
ROLL BACK TO S3;
rem ************************************************************
rem 4 . Create a view named Losangeles_Flight on Schedule_15 (as defined in 1) that display flight, 
rem departure (date, time), arrival (date, time) of flight(s) from Los Angeles.
rem ************************************************************
CREATE VIEW Losangeles_Flights AS
SELECT flight,ddate,dtime,adate,atime
FROM Schedule_15
WHERE from_airport='Los Angeles' OR to_airport='Los Angeles';

DESC Losangeles_Flights;
SELECT * FROM Losangeles_Flights;
SAVEPOINT S4;


SELECT table_name,Column_name,insertable
FROM USER_updatable_COLUMNS
WHERE table_name='LOSANGELES_FLIGHTS';

rem trying to insert

INSERT INTO Losangeles_Flights VALUES ('SR-0097','27-JUN-02',1500,'28-JUN-02',0100);

rem insert is not allowed for key attribute flight

ROLLBACK TO S4;

rem trying to update

SELECT table_name,Column_name,updatable
FROM USER_updatable_COLUMNS
WHERE table_name='LOSANGELES_FLIGHTS';

UPDATE Losangeles_Flights SET flight='SR-0097' WHERE flight='HA-1';
UPDATE Losangeles_Flights SET dtime=1500 WHERE flight='JJ-2482';
UPDATE Losangeles_Flights SET adate='27-JUN-05' WHERE flight='JJ-2482';
UPDATE Losangeles_Flights SET atime=2300 WHERE flight='JJ-2482';
UPDATE Losangeles_Flights SET ddate='27-JUN-05' WHERE flight='SQ-11';

rem dtime,adate,atime,ddate are updateable

SELECT * FROM Losangeles_flights WHERE flight IN('JJ-2482','SQ-11');
SELECT * FROM Schedule_15 WHERE Flight IN ('JJ-2482','SQ-11'); 
SELECT f.flightno,fl.departs,fl.dtime,fl.arrives,fl.atime
	FROM Routes r,Flights f,Fl_schedule fl
	WHERE (f.rid=r.routeid) AND 
		(f.flightno=fl.flno) AND 
		(orig_airport LIKE 'Los Angeles') AND
		(f.flightno IN ('SQ-11','JJ-2482'));

ROLLBACK TO S4;

rem trying to delete

rem before deleting

SELECT * FROM losangeles_flights WHERE flight='SQ-11';
SELECT * FROM Schedule_15 WHERE flight='SQ-11';
SELECT f.flightno,fl.departs,fl.dtime,fl.arrives,fl.atime
	FROM Routes r,Flights f,Fl_schedule fl
	WHERE (f.rid=r.routeid) AND 
		(f.flightno=fl.flno) AND 
		(orig_airport LIKE 'Los Angeles') AND
		(f.flightno='SQ-11');

DELETE FROM Losangeles_flights WHERE flight='SQ-11';

rem after deleting

SELECT * FROM losangeles_flights WHERE flight='SQ-11';
SELECT * FROM Schedule_15 WHERE flight='SQ-11';
SELECT f.flightno,fl.departs,fl.dtime,fl.arrives,fl.atime
	FROM Routes r,Flights f,Fl_schedule fl
	WHERE (f.rid=r.routeid) AND 
		(f.flightno=fl.flno) AND 
		(orig_airport LIKE 'Los Angeles') AND
		(f.flightno='SQ-11');
rem delete works and updates in base table

ROLLBACK TO S4;

