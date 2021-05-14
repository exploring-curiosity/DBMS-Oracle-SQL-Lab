
rem question 10

ALTER TABLE Artist
ADD (gender char(1));

rem Question 11

ALTER TABLE Song
DROP CONSTRAINT sname_null;

ALTER TABLE Song
MODIFY (Song_name VARCHAR2(70) CONSTRAINT sname_null NOT NULL);

rem Question 12

ALTER TABLE Studio
ADD CONSTRAINT ph_un
UNIQUE (Studio_Phone);

rem Question 13

ALTER TABLE SungBy
MODIFY (recording_date DATE CONSTRAINT rdate_null NOT NULL);

rem question 14

ALTER TABLE Song
DROP CONSTRAINT song_genre_restriction;

ALTER TABLE Song
MODIFY (Song_genre VARCHAR2(25) CONSTRAINT song_genre_restriction CHECK (Song_genre in ('PHI','REL','LOV','DEV','PAT','NAT')) );


ALTER TABLE Song
DROP CONSTRAINT song_len_check_7;

ALTER TABLE Song
ADD CONSTRAINT song_len_check_7
CHECK((Song_len >= 7 AND Song_genre='PAT' ) OR (Song_genre in ('PHI','REL','LOV','DEV','NAT')));

rem question 15

ALTER TABLE SungBy
DROP CONSTRAINT al_id__track_fk;

ALTER TABLE SungBy
ADD CONSTRAINT al_id__track_fk FOREIGN KEY (al_ID,track) REFERENCES Song(alb_ID,track_no) ON DELETE CASCADE;

rem Question 10 new entry with gender

INSERT INTO Artist VALUES
(
	104,
	'Jane Wills',
	'M'
);

rem Question 11 new Entry with longer Song name width

INSERT INTO Song VALUES
(
	456,
	897,
	'Vinnai Thaandi Varuvaaiya By ilayaraja',
	4,
	'REL'
);

rem Question 12 new Entry Violated constraint Phone number

INSERT INTO Studio VALUES
(
	'ken',
	'Bing',
	9923514674
);

rem Question 13 new entry violated constraint Date null

INSERT INTO SungBy VALUES
(
	457,
	101,
	896,
	null
);

rem Question 14 new entry new genre added NAT

INSERT INTO Song VALUES
(
	456,
	899,
	'Hindu siddhate',
	3,
	'NAT'
);

SELECT * FROM Musician;

SELECT * FROM Studio;

SELECT * FROM Album;

SELECT * FROM Song;

SELECT * FROM Artist;

SELECT * FROM SungBy;