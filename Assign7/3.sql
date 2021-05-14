rem 3. An aircraft is assigned to a flight only if its cruising range is more than the distance of the 
rem    flights’ route

DROP TRIGGER as_air;

CREATE TRIGGER as_air
	BEFORE INSERT OR UPDATE 
	ON flights
	FOR EACH ROW
DECLARE
	cr aircraft.cruisingrange%TYPE;
	dist routes.distance%TYPE;	
BEGIN
	SELECT cruisingrange INTO cr FROM aircraft a WHERE a.aid=:new.aid;
	SELECT distance INTO dist FROM routes r WHERE r.routeID=:new.rID;
	IF dist>=cr THEN
		 RAISE_APPLICATION_ERROR(-20176,'Error:distance('||dist||') should be grater than cruising range('||cr||')');
	END IF;
END;
/

SAVEPOINT S3;

REM creating a sample route
INSERT INTO routes values('CP173','Chicago','Paris',6450);

REM violating INSERT command - flight id = 11 - cruising range = 6441

INSERT INTO flights values('RS-28','CP173',11);

REM satisfying INSERT command - flight id = 12 - cruising range = 6475

INSERT INTO flights values('RS-28','CP173',12);

SELECT * FROM flights WHERE flightNo = 'RS-28';

REM violating UPDATE command - flight id = 13 - cruising range = 2605

UPDATE flights 
SET aid=13 
WHERE flightNo = 'RS-28';

REM Satisfying UPDATE command - flight id = 9 - cruising range = 6900

UPDATE flights 
SET aid=9 
WHERE flightNo = 'RS-28';

SELECT * FROM flights WHERE flightNo = 'RS-28';

ROLLBACK TO S3;
