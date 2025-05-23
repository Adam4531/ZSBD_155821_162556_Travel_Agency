--reservations
CREATE TABLE reservations_archive AS SELECT * FROM reservations WHERE 1=0;

ALTER TABLE reservations_archive ADD (
    archived_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    archived_by VARCHAR2(30) DEFAULT SYS_CONTEXT('USER_ENV','SESSION_USER'));
);

DESCRIBE reservations_archive;

CREATE OR REPLACE TRIGGER trigger_reservations_archive
    BEFORE UPDATE ON reservations
    FOR EACH ROW
    WHEN (OLD.is_active=1 AND NEW.is_active=0)
BEGIN
    INSERT INTO reservations_archive(
                    id, user_id, date_of_reservation,
                    amount_of_children, amount_of_adults,
                    is_confirmed, is_active
                ) VALUES (
                    :OLD.id, :OLD.user_id, :OLD.date_of_reservation,
                    :OLD.amount_of_children, :OLD.amount_of_adults,
                    :OLD.is_confirmed, :OLD.is_active
                );
END;
/

--users
CREATE TABLE users_archive AS SELECT * FROM users WHERE 1=0;

ALTER TABLE users_archive ADD (
    archived_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    archived_by VARCHAR2(30) DEFAULT SYS_CONTEXT('USER_ENV','SESSION_USER'));
);

CREATE OR REPLACE TRIGGER trigger_users_archive
    BEFORE UPDATE ON users
    FOR EACH ROW
    WHEN (OLD.is_active=1 AND NEW.is_active=0)
BEGIN
      INSERT INTO users_archive (
        id, first_name, last_name, phone_number,
        email, password, date_of_birth, is_active
      ) VALUES (
        :OLD.id, :OLD.first_name, :OLD.last_name, :OLD.phone_number,
        :OLD.email, :OLD.password, :OLD.date_of_birth, :OLD.is_active
      );
END;
/


CREATE TABLE tours_archive AS SELECT * FROM tours WHERE 1=0;

ALTER TABLE tours_archive ADD (
    archived_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    archived_by VARCHAR2(30) DEFAULT SYS_CONTEXT('USER_ENV','SESSION_USER'));
);


CREATE OR REPLACE TRIGGER trg_tours_archive
  BEFORE UPDATE OF is_active ON tours
  FOR EACH ROW
  WHEN (OLD.is_active = 1 AND NEW.is_active = 0)
BEGIN
  INSERT INTO tours_archive (
    id, supervisor_id, max_number_of_participants,
    date_start, date_end, place_id,
    type_of_tour_id, price_id,
    country, region, city, accommodation, is_active
  ) VALUES (
    :OLD.id, :OLD.supervisor_id, :OLD.max_number_of_participants,
    :OLD.date_start, :OLD.date_end, :OLD.place_id,
    :OLD.type_of_tour_id, :OLD.price_id,
    :OLD.country, :OLD.region, :OLD.city, :OLD.accommodation, :OLD.is_active
  );
END;
/  

--types of tours
CREATE TABLE types_of_tour_archive AS
SELECT * FROM types_of_tour WHERE 1=0;


ALTER TABLE types_of_tour_archive
  ADD (
    archived_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    archived_by VARCHAR2(30) DEFAULT SYS_CONTEXT('USERENV','SESSION_USER')
  );
  
  
DESCRIBE types_of_tour_archive;


CREATE OR REPLACE TRIGGER trg_types_of_tour_archive
  BEFORE UPDATE OF is_active ON types_of_tour
  FOR EACH ROW
  WHEN (OLD.is_active = 1 AND NEW.is_active = 0)
BEGIN
  INSERT INTO types_of_tour_archive (
    id, name_of_type, is_active
  ) VALUES (
    :OLD.id, :OLD.name_of_type, :OLD.is_active
  );
END;
/

--price
CREATE TABLE price_archive AS
SELECT * FROM price WHERE 1=0;

ALTER TABLE price_archive
  ADD (
    archived_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    archived_by VARCHAR2(30) DEFAULT SYS_CONTEXT('USERENV','SESSION_USER')
  );

CREATE OR REPLACE TRIGGER trg_price_archive
  BEFORE UPDATE OF is_active ON price
  FOR EACH ROW
  WHEN (OLD.is_active = 1 AND NEW.is_active = 0)
BEGIN
  INSERT INTO price_archive (
    id, normal_price, reduced_price, is_active
  ) VALUES (
    :OLD.id, :OLD.normal_price, :OLD.reduced_price, :OLD.is_active
  );
END;
/

--thr
CREATE TABLE tour_has_reservations_archive AS
SELECT * FROM tour_has_reservations WHERE 1=0;

ALTER TABLE tour_has_reservations_archive
  ADD (
    archived_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    archived_by VARCHAR2(30) DEFAULT SYS_CONTEXT('USERENV','SESSION_USER')
  );

CREATE OR REPLACE TRIGGER trg_tour_has_reservations_archive
  BEFORE UPDATE OF is_active ON tour_has_reservations
  FOR EACH ROW
  WHEN (OLD.is_active = 1 AND NEW.is_active = 0)
BEGIN
  INSERT INTO tour_has_reservations_archive (
    reservation_id, tour_id,
    is_price_reduced, is_active
  ) VALUES (
    :OLD.reservation_id, :OLD.tour_id,
    :OLD.is_price_reduced, :OLD.is_active
  );
END;
/