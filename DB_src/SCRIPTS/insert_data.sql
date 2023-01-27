INSERT INTO addresses (postal_code, city, street_name, building_number, local_number)
VALUES ('01-077', 'Warszawa', 'Koszykowa', '13B', 10);
INSERT INTO addresses (postal_code, city, street_name, building_number, local_number)
VALUES ('01-075', 'Warszawa', 'Jana Pawła 2', '34', NULL);
INSERT INTO addresses (postal_code, city, street_name, building_number, local_number)
VALUES ('09-412', 'Kraków', 'Waryńskiego', '12', NULL);
INSERT INTO addresses (postal_code, city, street_name, building_number, local_number)
VALUES ('08-017', 'Kraków', 'Swojska', '25A', NULL);
INSERT INTO addresses (postal_code, city, street_name, building_number, local_number)
VALUES ('02-532', 'Wrocław', 'Wyszogrodzka', '71C', 23);
COMMIT;

INSERT INTO dorms (name, gender, max_count, address_id)
VALUES ('Riviera', 'C', 2000, 2);
INSERT INTO dorms (name, gender, max_count, address_id)
VALUES ('Balloon', 'M', 1500, 3);
INSERT INTO dorms (name, gender, max_count, address_id)
VALUES ('Rumcajs', 'F', 3200, 3);
INSERT INTO dorms (name, gender, max_count, address_id)
VALUES ('Mikrus', 'C', 2000, 2);
INSERT INTO dorms (name, gender, max_count, address_id)
VALUES ('Bartek', 'M', 1200, 5);
INSERT INTO dorms (name, gender, max_count, address_id)
VALUES ('Babilon', 'C', 4000, 4);
INSERT INTO dorms (name, gender, max_count, address_id)
VALUES ('Alcatraz', 'C', 2700, 1);
COMMIT;

INSERT INTO rooms (room_num, gender, max_count, dorm_id)
VALUES (507, 'M', 9, 2);
INSERT INTO rooms (room_num, gender, max_count, dorm_id)
VALUES (103, 'F', 8, 2);
INSERT INTO rooms (room_num, gender, max_count, dorm_id)
VALUES (304, 'M', 5, 3);
INSERT INTO rooms (room_num, gender, max_count, dorm_id)
VALUES (302, 'M', 1, 3);
INSERT INTO rooms (room_num, gender, max_count, dorm_id)
VALUES (102, 'M', 4, 5);
INSERT INTO rooms (room_num, gender, max_count, dorm_id)
VALUES (507, 'F', 5, 1);
INSERT INTO rooms (room_num, gender, max_count, dorm_id)
VALUES (808, 'F', 8, 4);
INSERT INTO rooms (room_num, gender, max_count, dorm_id)
VALUES (447, 'M', 4, 1);
COMMIT;

EXEC ADD_STUDENT(310192, 'Aleksandra', 'Samek', 1, 'F');
EXEC ADD_STUDENT(310127, 'Piotr', 'Wozik', 1, 'M');
EXEC ADD_STUDENT(184372, 'Zosia', 'Kostka', 1, 'F');
EXEC ADD_STUDENT(228933, 'Jacek', 'Jaworowicz', 2, 'M');
EXEC ADD_STUDENT(190253, 'Magda', 'Sosik', 2, 'F');
EXEC ADD_STUDENT(784309, 'Daniel', 'Zawadzki', 2, 'M');
EXEC ADD_STUDENT(125744, 'Krystyna', 'Czubówna', 3, 'F');
EXEC ADD_STUDENT(877849, 'Andrzej', 'Klops', 4, 'M');
EXEC ADD_STUDENT(111002, 'Michał', 'Odrobinka', 5, 'M');
EXEC ADD_STUDENT(375744, 'Witold', 'Pietrek', 5, 'M');
COMMIT;

INSERT INTO positions (name, min_salary, max_salary)
VALUES ('Kierownik', 7000, 12000);
INSERT INTO positions (name, min_salary, max_salary)
VALUES ('Woźna', 4000, 5500);
INSERT INTO positions (name, min_salary, max_salary)
VALUES ('Konserwator', 7500, 10000);
INSERT INTO positions (name, min_salary, max_salary)
VALUES ('Nadzorca', 6000, 9000);
INSERT INTO positions (name, min_salary, max_salary)
VALUES ('Szatniarz', 4000, 7500);
INSERT INTO positions (name, min_salary, max_salary)
VALUES ('Portiernik', 3000, 8000);
COMMIT;

INSERT INTO staff (name, surname, salary, dorm_id, position_id)
VALUES ('Grażyna', 'Nowak', 5000, 1, 5);
INSERT INTO staff (name, surname, salary, dorm_id, position_id)
VALUES ('Jędrzej', 'Zajko', 5500, 2, 5);
INSERT INTO staff (name, surname, salary, dorm_id, position_id)
VALUES ('Jarosław', 'Janiak', 8000, 5, 3);
INSERT INTO staff (name, surname, salary, dorm_id, position_id)
VALUES ('Marcin', 'Patras', 10000, 4, 1);
INSERT INTO staff (name, surname, salary, dorm_id, position_id)
VALUES ('Stefan', 'Batory', 4500, 3, 2);
COMMIT;

INSERT INTO furniture (name, condition, room_id)
VALUES ('chair', 9, 1);
INSERT INTO furniture (name, condition, room_id)
VALUES ('cupboard', 8, 2);
INSERT INTO furniture (name, condition, room_id)
VALUES ('table', 2, 3);
INSERT INTO furniture (name, condition, room_id)
VALUES ('table', 5, 3);
INSERT INTO furniture (name, condition, room_id)
VALUES ('chair', 5, 4);
INSERT INTO furniture (name, condition, room_id)
VALUES ('desk', 7, 3);
COMMIT;
