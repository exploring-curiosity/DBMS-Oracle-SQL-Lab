rem 2. Flight number CX­7520 is scheduled only on Tuesday, Friday and Sunday

DROP TRIGGER CX_7520_schd;

CREATE TRIGGER CX_7520_schd
	BEFORE INSERT OR UPDATE
	ON fl_schedule	
	FOR EACH ROW
DECLARE 
	day VARCHAR2(10);
BEGIN
	SELECT TO_CHAR(:new.departs,'DY') INTO day FROM DUAL;
	IF (:new.flno = 'CX-7520') AND (day NOT IN ('TUE','FRI','SUN')) THEN
		RAISE_APPLICATION_ERROR(-20175,'Error: Flight CX-7520 cant be schedule on '||day);
	END IF;
END;
/

SAVEPOINT S2;

rem deleting fligth records of 'CX-7520'

DELETE FROM fl_schedule
WHERE flno='CX-7520';

rem violating insert condition--SATURDAY

INSERT INTO fl_schedule values('CX-7520','23-apr-05',1245,'23-apr-05',1850,450.25);

rem satisfying insert condition--SUNDAY

INSERT INTO fl_schedule values('CX-7520','24-apr-05',1245,'24-apr-05',1850,450.25);

SELECT * FROM fl_schedule WHERE flno='CX-7520';

rem violating update condition--wednesday
	
update fl_schedule
SET departs='20-apr-05' 
WHERE flno='CX-7520';
	
rem satisfying update condition

update fl_schedule
SET departs='19-apr-05' 
WHERE flno='CX-7520';

SELECT * FROM fl_schedule WHERE flno='CX-7520';

ROLLBACK TO S2;