

rem 1. The date of arrival should be always later than or on the same date of departure.

drop trigger arr_dept;

CREATE trigger arr_dept
	BEFORE INSERT OR UPDATE ON fl_schedule 
	FOR EACH ROW
BEGIN
	IF INSERTING THEN
		IF (:new.arrives<:new.departs) THEN
			RAISE_APPLICATION_ERROR(-20173,'Error:Cannot perform INSERT operation -- DEPARTURE date Should be on or before the ARRIVAL DATE');
		END IF;
	ELSE
		IF (:old.arrives<:new.departs) OR (:new.arrives<:old.departs) THEN
			RAISE_APPLICATION_ERROR(-20174,'Error:Cannot perform UPDATE operation -- DEPARTURE date Should be on or before the ARRIVAL DATE');
		END IF;
	END IF;
END;
/
SAVEPOINT S1;

rem deleting fligth record of 'AF-12'

DELETE FROM fl_schedule
WHERE flno='AF-12';

rem violating insert condition

INSERT INTO fl_schedule values('AF-12','23-apr-05',1245,'22-apr-05',1850,450.25);

rem satisfying insert condition

INSERT INTO fl_schedule values('AF-12','20-apr-05',1245,'20-apr-05',1850,450.25);

SELECT * FROM fl_schedule WHERE flno='AF-12';

rem violating update condition
	
update fl_schedule
SET arrives='19-apr-05' 
WHERE flno='AF-12';
	
rem satisfying update condition

update fl_schedule
SET arrives='21-apr-05' 
WHERE flno='AF-12';

SELECT * FROM fl_schedule WHERE flno='AF-12';

ROLLBACK TO S1;