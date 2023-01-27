--trigger addresses id
CREATE OR REPLACE TRIGGER address_idx
BEFORE INSERT ON addresses FOR EACH ROW
BEGIN
  SELECT address_seq.NEXTVAL
  INTO   :new.address_id
  FROM   dual;
END;


--trigger dorms id
CREATE OR REPLACE TRIGGER dorms_idx
BEFORE INSERT ON dorms FOR EACH ROW
BEGIN
  SELECT dorms_seq.NEXTVAL
  INTO   :new.dorm_id
  FROM   dual;
END;


--trigger rooms id
CREATE OR REPLACE TRIGGER rooms_idx
BEFORE INSERT ON rooms FOR EACH ROW
BEGIN
  SELECT rooms_seq.NEXTVAL
  INTO   :new.room_id
  FROM   dual;
END;


--trigger positions id
CREATE OR REPLACE TRIGGER positions_idx
BEFORE INSERT ON positions FOR EACH ROW
BEGIN
  SELECT position_seq.NEXTVAL
  INTO   :new.position_id
  FROM   dual;
END;


--trigger staff id
CREATE OR REPLACE TRIGGER staff_idx
BEFORE INSERT ON staff FOR EACH ROW
BEGIN
  SELECT staff_seq.NEXTVAL
  INTO   :new.staff_id
  FROM   dual;
END;


--trigger students_history id
CREATE OR REPLACE TRIGGER students_history_idx
BEFORE INSERT ON students_history FOR EACH ROW
BEGIN
  SELECT students_history_seq.NEXTVAL
  INTO   :new.student_history_id
  FROM   dual;
END;


--trigger furniture id
CREATE OR REPLACE TRIGGER furniture_idx
BEFORE INSERT ON furniture FOR EACH ROW
BEGIN
  SELECT furniture_seq.NEXTVAL
  INTO   :new.furniture_id
  FROM   dual;
END;


--trigger positions salary check
CREATE OR REPLACE TRIGGER check_salary_positions
BEFORE INSERT OR UPDATE ON positions FOR EACH ROW
BEGIN
   IF :new.max_salary < :new.min_salary OR :new.min_salary < 0 THEN
       dbms_output.put_line('Incorrect salary');
       raise_application_error(-20001, 'Negative salary error');
   END IF;
END;


--trigger staff salary check
CREATE OR REPLACE TRIGGER check_salary_staff
AFTER INSERT OR UPDATE ON staff FOR EACH ROW
DECLARE
    v_min_salary positions.min_salary%TYPE;
    v_max_salary positions.max_salary%TYPE;
BEGIN
    SELECT min_salary INTO v_min_salary from positions WHERE position_id = :new.position_id;
    SELECT max_salary INTO v_max_salary from positions WHERE position_id = :new.position_id;
    dbms_output.put_line(v_min_salary);
    dbms_output.put_line(v_max_salary);

    IF :new.salary NOT BETWEEN v_min_salary AND v_max_salary THEN
        dbms_output.put_line('Incorrect salary');
        raise_application_error(-20003, 'Salary not between threshold');
    END IF;
END;


--trigger students_history insert
CREATE OR REPLACE TRIGGER insert_students_history
AFTER INSERT ON students FOR EACH ROW
BEGIN
    INSERT INTO students_history (start_date, index_number) VALUES (CURRENT_DATE, :new.index_number);
END;


--trigger students delete
CREATE OR REPLACE TRIGGER delete_students
BEFORE DELETE ON students FOR EACH ROW
BEGIN
    UPDATE students_history SET end_date = CURRENT_DATE WHERE index_number = :old.index_number;
END;
