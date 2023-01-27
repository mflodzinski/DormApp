create or replace PROCEDURE ADD_STUDENT 
(
  INDEX_NUMBER IN NUMBER,
  PNAME IN VARCHAR2,
  PSURNAME IN VARCHAR2,
  PROOM_ID IN NUMBER,
  PGENDER IN VARCHAR2 
) AS 
    VROOM_GENDER  VARCHAR2(1);
    VROOM_CURR NUMBER;
    VROOM_MAX NUMBER;
    
    VDORM_ID NUMBER;
    VDORM_GENDER  VARCHAR2(1);
    VDORM_CURR NUMBER;
    VDORM_MAX NUMBER;

    
BEGIN
    SELECT DORM_ID INTO VDORM_ID FROM ROOMS WHERE ROOM_ID = PROOM_ID;
    IF VDORM_ID IS NULL THEN
        dbms_output.put_line ('ROOM DOES NOT EXIST');
    ELSE
        SELECT GENDER, CURRENT_COUNT, MAX_COUNT INTO VDORM_GENDER, VDORM_CURR, VDORM_MAX FROM DORMS WHERE DORM_ID = VDORM_ID;
        IF VDORM_CURR < VDORM_MAX THEN
            IF VDORM_GENDER = 'C' OR VDORM_GENDER = PGENDER THEN
                SELECT GENDER, CURRENT_COUNT, MAX_COUNT INTO VROOM_GENDER, VROOM_CURR, VROOM_MAX FROM ROOMS WHERE ROOM_ID = PROOM_ID;
                IF VROOM_CURR < VROOM_MAX THEN
                    IF VROOM_GENDER = 'C' OR VROOM_GENDER = PGENDER THEN
                        UPDATE DORMS
                            SET CURRENT_COUNT = VDORM_CURR + 1
                            WHERE DORM_ID = VDORM_ID;
                        UPDATE ROOMS
                            SET CURRENT_COUNT = VROOM_CURR + 1
                            WHERE ROOM_ID = PROOM_ID;
                        INSERT INTO STUDENTS
                            VALUES (INDEX_NUMBER, PNAME, PSURNAME, PROOM_ID, PGENDER);
                        dbms_output.put_line ('STUDENT REGISTERED IN DORM SUCCESSFULLY');
                    ELSE
                        dbms_output.put_line ('STUDENT GENDER DOES NOT MATCH ROOM');
                    END IF;    
                ELSE 
                    dbms_output.put_line ('ROOM IS FULL');
                END IF;    
            ELSE 
                dbms_output.put_line ('STUDENT GENDER DOES NOT MATCH DORM');
            END IF;    
        ELSE 
            dbms_output.put_line ('DORM IS FULL');
        END IF;
    END IF;    
END ADD_STUDENT;

create or replace PROCEDURE DELETE_STUDENT 
(
  PINDEX_NUMBER IN NUMBER 
) AS 
    VROOM_ID  VARCHAR2(1);
    VROOM_CURR NUMBER;

    
    VDORM_ID NUMBER;
    VDORM_CURR NUMBER;
    
BEGIN
    --set serveroutput on;
    SELECT ROOM_ID INTO VROOM_ID FROM STUDENTS WHERE INDEX_NUMBER = PINDEX_NUMBER;
    IF VROOM_ID IS NULL THEN
        dbms_output.put_line ('STUDENT DOES NOT EXIST');
    ELSE
        SELECT R.DORM_ID, R.CURRENT_COUNT, D.CURRENT_COUNT INTO VDORM_ID, VROOM_CURR, VDORM_CURR 
        FROM ROOMS R 
        JOIN DORMS D ON (R.DORM_ID = D.DORM_ID)
        WHERE R.ROOM_ID = VROOM_ID;
        DELETE FROM STUDENTS WHERE INDEX_NUMBER = PINDEX_NUMBER;
        UPDATE ROOMS
            SET CURRENT_COUNT = VROOM_CURR - 1
            WHERE ROOM_ID = VROOM_ID;
        UPDATE DORMS
            SET CURRENT_COUNT = VDORM_CURR - 1
            WHERE DORM_ID = VDORM_ID;
        dbms_output.put_line ('STUDENT REMOVED SUCCESFULLY');    
    END IF;
    EXCEPTION
        WHEN no_data_found THEN
                dbms_output.put_line ('STUDENT DOES NOT EXIST');
                
END DELETE_STUDENT;


create or replace PROCEDURE ALOCATE_STUDENT_IN_DORM 
(
  PDORM_NAME IN VARCHAR2,
  PINDEX_NUMBER IN NUMBER,
  PNAME IN VARCHAR2,
  PSURNAME IN VARCHAR2, 
  PGENDER IN VARCHAR2 
) AS 
    VDORM_ID NUMBER;
    
    VROOM_ID NUMBER;
    VROOM_LEFT NUMBER := 0;
    
BEGIN
    SELECT DORM_ID INTO VDORM_ID FROM DORMS WHERE NAME = PDORM_NAME;
    IF VDORM_ID IS NULL THEN
        dbms_output.put_line ('DORM DOES NOT EXIST');    
    ELSE
        FOR ROOM IN(SELECT * FROM ROOMS WHERE (DORM_ID = VDORM_ID AND MAX_COUNT > CURRENT_COUNT AND (GENDER = 'C' OR GENDER = PGENDER)))
        LOOP
            IF(ROOM.CURRENT_COUNT = 0) THEN
                VROOM_ID := ROOM.ROOM_ID;
                EXIT;
            ELSE 
                IF (ROOM.MAX_COUNT - ROOM.CURRENT_COUNT > VROOM_LEFT ) THEN
                    VROOM_LEFT := ROOM.MAX_COUNT - ROOM.CURRENT_COUNT;
                    VROOM_ID := ROOM.ROOM_ID;
                END IF;
            END IF;    
        END LOOP;
        IF VROOM_ID IS NULL THEN
            dbms_output.put_line ('DIDNT FIND ROOM FOR A STUDENT');
        ELSE
            ADD_STUDENT(PINDEX_NUMBER, PNAME, PSURNAME, VROOM_ID, PGENDER);
        END IF;    
    END IF;

END ALOCATE_STUDENT_IN_DORM;
