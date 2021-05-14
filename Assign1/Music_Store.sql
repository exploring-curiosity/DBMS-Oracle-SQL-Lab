drop table SungBy;
drop table Artist;
drop table Song;
drop table Album;
drop table Studio;
drop table Musician;


CREATE TABLE Musician 
(
	Mus_ID NUMBER(3) CONSTRAINT id_pk PRIMARY KEY,
	Mus_name VARCHAR2(25) CONSTRAINT name_null NOT NULL,
	Mus_birthplace VARCHAR2(25) 
);

CREATE TABLE Studio
(
	Studio_name VARCHAR2(25) CONSTRAINT std_name_pk PRIMARY KEY,
	Studio_addr VARCHAR2(50) ,
	Studio_Phone NUMBER(10)
);

rem question 7 done in line 6
rem question 8 done in line 5 
CREATE TABLE Album
(
	album_name VARCHAR2(25) CONSTRAINT album_null NOT NULL,
	album_ID NUMBER(3) CONSTRAINT a_id_pk PRIMARY KEY,
	year_of_release NUMBER(4) CONSTRAINT Album_release_check CHECK ( year_of_release > 1945),
	no_of_tracks NUMBER(3) CONSTRAINT no_of_tracks_null NOT NULL,
	stud_name VARCHAR2(25) CONSTRAINT stud_fk REFERENCES Studio(Studio_name) ,
	album_genre VARCHAR2(20) CONSTRAINT al_genre_restriction CHECK (album_genre in ('CAR','DIV','MOV','POP')),
	musician_id NUMBER(3) CONSTRAINT mus_id_fk REFERENCES Musician(Mus_ID)  
);

rem question 8 done in line 9

CREATE TABLE Song
(
	alb_ID NUMBER(3) CONSTRAINT a_id_fk REFERENCES Album(album_ID) ,
	track_no NUMBER(3) ,
	Song_name VARCHAR2(25) CONSTRAINT sname_null NOT NULL,
	Song_len NUMBER(3) ,
	Song_genre VARCHAR2(25) CONSTRAINT song_genre_restriction CHECK(Song_genre in ('PHI','REL','LOV','DEV','PAT')),
	CONSTRAINT song_alid_track_pk PRIMARY KEY (alb_ID,track_no),
	CONSTRAINT song_len_check_7 CHECK(Song_len >= 7 AND Song_genre='PAT') 
);

rem question 6 done in line 4

CREATE TABLE Artist
(
	artist_ID NUMBER(3) CONSTRAINT art_id_pk PRIMARY KEY,
	artist_name VARCHAR2(25) CONSTRAINT art_name_null NOT NULL
);

CREATE TABLE SungBy
(
	al_ID NUMBER(3) ,
	ar_ID NUMBER(3) CONSTRAINT ar_id_fk REFERENCES Artist(artist_ID),
	track NUMBER(3) ,
	recording_date DATE,
	CONSTRAINT al_id_fk FOREIGN KEY (al_ID,track) REFERENCES Song(alb_ID,track_no) ,
	CONSTRAINT Sung_by_pk PRIMARY KEY (al_ID,ar_ID,track)
);



	
rem question 1 to 9
rem already done during create table

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

rem question 15

ALTER TABLE SungBy
DROP CONSTRAINT al_id_fk;

ALTER TABLE SungBy
ADD CONSTRAINT al_id_fk FOREIGN KEY (al_ID,track) REFERENCES Song(alb_ID,track_no) ON DELETE CASCADE;
