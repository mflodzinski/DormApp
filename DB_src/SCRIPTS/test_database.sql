-- Test 'insert_students_history' trigger (should insert rows into students_history table)
INSERT INTO students (index_number, name, surname, gender, room_id)
VALUES (877434, 'Maciej', 'Łazowy', 'M', 4);
INSERT INTO students (index_number, name, surname, gender, room_id)
VALUES (113102, 'Jacek', 'Łanik', 'M', 5);
INSERT INTO students (index_number, name, surname, gender, room_id)
VALUES (370744, 'Kacper', 'Marchlewicz', 'M', 5);
COMMIT;

-- Test 'delete_students' trigger (should update rows from students_history table)
DELETE FROM students WHERE index_number = 877434;
DELETE FROM students WHERE index_number = 113102;
DELETE FROM students WHERE index_number = 370744;
COMMIT;

-- Test 'check_salary_staff' trigger (should return error when staff's salary not between position's threshold)
INSERT INTO staff (name, surname, salary, dorm_id, position_id)
VALUES ('Joanna', 'Krupa', 2000, 2, 1);
INSERT INTO staff (name, surname, salary, dorm_id, position_id)
VALUES ('Kacper', 'Marchlewicz', 7000, 3, 2);
COMMIT;

-- Test 'check_salary_positions' trigger (should return error when incorrect salary threshold)
INSERT INTO positions (name, min_salary, max_salary)
VALUES ('Elektryk', -2000, 4000);
INSERT INTO positions (name, min_salary, max_salary)
VALUES ('Windziarz', 3000, -4000);
COMMIT;

-- Test 'calculate_furniture_in_dorm' function
SELECT D.name, calculate_furniture_in_dorm(D.dorm_id) furniture_count
FROM DORMS D JOIN ROOMS R ON D.DORM_ID = R.DORM_ID
JOIN STUDENTS S ON R.ROOM_ID = S.ROOM_ID
WHERE S.name = 'Daniel';

-- Test 'calculate_avg_position_salary' function
SELECT P.name, calculate_avg_position_salary(P.name) avg_salary
FROM POSITIONS P JOIN STAFF S on P.POSITION_ID = S.POSITION_ID
WHERE S.name like 'J%';

set serveroutput ON;
--SHOULD PRINT : STUDENT GENDER DOES NOT MATCH ROOM
EXEC ADD_STUDENT(100000, 'PAWEL', 'PROBNY', 7, 'M');

--SHOULD PRINT : ROOM IS FULL
EXEC ADD_STUDENT(100000, 'PAWEL', 'PROBNY', 4, 'M');

--SHOULD PRINT : STUDENT GENDER DOES NOT MATCH DORM
EXEC ADD_STUDENT(100000, 'PULINA', 'PROBNA', 1, 'F');

--SHOULD ADD STUDENT TO ROOM, CONFIMED WITH OUTPUT: STUDENT REGISTERED IN DORM SUCCESSFULLY
EXEC ADD_STUDENT(100000, 'PAWEL', 'PROBNY', 1, 'M');

--SHOULD DELETE STUDENT, CONFIMED WITH OUTPUT: STUDENT REMOVED SUCCESFULLY
EXEC DELETE_STUDENT(100000);

--SHOULD PRINT 'STUDENT DOES NOT EXIST'
EXEC DELETE_STUDENT(0);

--SHOULD PLACE STUDENT IN DORM (IF THERE IS A ROOM LEFT), CONFIRMED WITH: STUDENT REGISTERED IN DORM SUCCESSFULLY
EXEC ALOCATE_STUDENT_IN_DORM('Riviera', 100000, 'PAWEL', 'PROBNY', 'M')
EXEC DELETE_STUDENT(100000);

--SHOULD PRINT: DIDNT FIND ROOM FOR A STUDENT
EXEC ALOCATE_STUDENT_IN_DORM('Rumcajs', 100000, 'PAWEL', 'PROBNY', 'M')

