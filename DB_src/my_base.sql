--DROP TABLE addresses cascade constraints;
--DROP TABLE dorms cascade constraints;
--DROP TABLE furniture cascade constraints;
--DROP TABLE positions cascade constraints;
--DROP TABLE rooms cascade constraints;
--DROP TABLE students cascade constraints;
--DROP TABLE students_history cascade constraints;
--DROP TABLE staff cascade constraints;


CREATE TABLE addresses (
    address_id      NUMBER(3) NOT NULL,
    postal_code     CHAR(6 CHAR) NOT NULL,
    city            VARCHAR2(50 CHAR) NOT NULL,
    street_name     VARCHAR2(50 CHAR) NOT NULL,
    building_number CHAR(4 CHAR) NOT NULL,
    local_number    NUMBER(2)
);

ALTER TABLE addresses ADD CONSTRAINT addresses_pk PRIMARY KEY ( address_id );

CREATE TABLE dorms (
    dorm_id       NUMBER(2) NOT NULL,
    name          VARCHAR2(50 CHAR) NOT NULL,
    gender        CHAR(1 CHAR) NOT NULL,
    max_count     NUMBER(4) NOT NULL,
    current_count NUMBER(4) DEFAULT 0 NOT NULL,
    address_id    NUMBER(3) NOT NULL
);

ALTER TABLE dorms
    ADD CHECK ( gender IN ( 'C', 'F', 'M' ) );

ALTER TABLE dorms ADD CONSTRAINT dorms_pk PRIMARY KEY ( dorm_id );

CREATE TABLE furniture (
    furniture_id NUMBER(6) NOT NULL,
    name         VARCHAR2(50) NOT NULL,
    condition    NUMBER(2) NOT NULL,
    room_id      NUMBER(5) NOT NULL
);

ALTER TABLE furniture ADD CONSTRAINT furniture_pk PRIMARY KEY ( furniture_id );

CREATE TABLE positions (
    position_id NUMBER(3) NOT NULL,
    name        VARCHAR2(50 CHAR) NOT NULL,
    min_salary  NUMBER(5) NOT NULL,
    max_salary  NUMBER(5) NOT NULL
);

ALTER TABLE positions ADD CONSTRAINT positions_pk PRIMARY KEY ( position_id );

CREATE TABLE rooms (
    room_id       NUMBER(5) NOT NULL,
    room_num      NUMBER(4) NOT NULL,
    gender        CHAR(1 CHAR) NOT NULL,
    max_count     NUMBER(1) NOT NULL,
    current_count NUMBER(1) DEFAULT 0 NOT NULL,
    dorm_id       NUMBER(2) NOT NULL
);

ALTER TABLE rooms
    ADD CHECK ( gender IN ( 'C', 'F', 'M' ) );

ALTER TABLE rooms ADD CONSTRAINT rooms_pk PRIMARY KEY ( room_id );

CREATE TABLE staff (
    staff_id    NUMBER(3) NOT NULL,
    name        VARCHAR2(50 CHAR) NOT NULL,
    surname     VARCHAR2(50 CHAR) NOT NULL,
    salary      NUMBER(5) NOT NULL,
    dorm_id     NUMBER(2) NOT NULL,
    position_id NUMBER(3) NOT NULL
);

ALTER TABLE staff ADD CONSTRAINT staff_pk PRIMARY KEY ( staff_id );

CREATE TABLE students (
    index_number NUMBER(6) NOT NULL,
    name         VARCHAR2(50 CHAR) NOT NULL,
    surname      VARCHAR2(50 CHAR) NOT NULL,
    room_id      NUMBER(5) NOT NULL,
    gender       CHAR(1 CHAR) NOT NULL
);

ALTER TABLE students
    ADD CHECK ( gender IN ( 'F', 'M' ) );

ALTER TABLE students ADD CONSTRAINT students_pk PRIMARY KEY ( index_number );

CREATE TABLE students_history (
    student_history_id    NUMBER(6) NOT NULL,
    start_date            DATE NOT NULL,
    end_date              DATE,
    students_index_number NUMBER(6) NOT NULL
);

ALTER TABLE students_history ADD CONSTRAINT students_history_pk PRIMARY KEY ( student_history_id );

ALTER TABLE dorms
    ADD CONSTRAINT dorms_addresses_fk FOREIGN KEY ( address_id )
        REFERENCES addresses ( address_id );

ALTER TABLE furniture
    ADD CONSTRAINT furniture_rooms_fk FOREIGN KEY ( room_id )
        REFERENCES rooms ( room_id );

ALTER TABLE rooms
    ADD CONSTRAINT rooms_dorms_fk FOREIGN KEY ( dorm_id )
        REFERENCES dorms ( dorm_id );

ALTER TABLE staff
    ADD CONSTRAINT staff_dorms_fk FOREIGN KEY ( dorm_id )
        REFERENCES dorms ( dorm_id );

ALTER TABLE staff
    ADD CONSTRAINT staff_positions_fk FOREIGN KEY ( position_id )
        REFERENCES positions ( position_id );

ALTER TABLE students_history
    ADD CONSTRAINT students_history_students_fk FOREIGN KEY ( students_index_number )
        REFERENCES students ( index_number );

ALTER TABLE students
    ADD CONSTRAINT students_rooms_fk FOREIGN KEY ( room_id )
        REFERENCES rooms ( room_id );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             0
-- ALTER TABLE                             18
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
