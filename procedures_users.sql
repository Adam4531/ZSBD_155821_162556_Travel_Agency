--funkcje
CREATE OR REPLACE FUNCTION validate_email(p_email VARCHAR2) RETURN BOOLEAN IS
  v_pattern CONSTANT VARCHAR2(100) := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
BEGIN
  RETURN REGEXP_LIKE(p_email, v_pattern);
END validate_email;
/

--inicjalizacja pakietu
CREATE OR REPLACE PACKAGE users_package IS
  PROCEDURE add_user(
    p_first_name   IN users.first_name%TYPE,
    p_last_name    IN users.last_name%TYPE,
    p_phone_number IN users.phone_number%TYPE,
    p_email        IN users.email%TYPE,
    p_password     IN users.password%TYPE,
    p_date_of_birth IN users.date_of_birth%TYPE,
    p_is_active    IN users.is_active%TYPE DEFAULT 1
  );

  PROCEDURE update_user(
    p_id           IN users.id%TYPE,
    p_first_name   IN users.first_name%TYPE,
    p_last_name    IN users.last_name%TYPE,
    p_phone_number IN users.phone_number%TYPE,
    p_email        IN users.email%TYPE,
    p_password     IN users.password%TYPE,
    p_date_of_birth IN users.date_of_birth%TYPE,
    p_is_active    IN users.is_active%TYPE
  );

  PROCEDURE delete_user(
    p_id IN users.id%TYPE
  );
END users_package;
/


-- implementacja
CREATE OR REPLACE PACKAGE BODY users_package IS

PROCEDURE add_user(
    p_first_name   IN users.first_name%TYPE,
    p_last_name    IN users.last_name%TYPE,
    p_phone_number IN users.phone_number%TYPE,
    p_email        IN users.email%TYPE,
    p_password     IN users.password%TYPE,
    p_date_of_birth IN users.date_of_birth%TYPE,
    p_is_active    IN users.is_active%TYPE DEFAULT 1
  ) IS
        BEGIN
        
    IF NOT validate_email(p_email) THEN
        RAISE_APPLICATION_ERROR(-20014, 'Invalid format of email=' || p_email);
    END IF;
  
    INSERT INTO users (
      first_name, last_name, phone_number,
      email, password, date_of_birth, is_active
    ) VALUES (
      p_first_name, p_last_name, p_phone_number,
      p_email, p_password, p_date_of_birth, p_is_active
    );
    COMMIT;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      RAISE_APPLICATION_ERROR(-20011, 'User with this email has already exist, email=' || p_email);
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END add_user;

PROCEDURE update_user(
    p_id           IN users.id%TYPE,
    p_first_name   IN users.first_name%TYPE,
    p_last_name    IN users.last_name%TYPE,
    p_phone_number IN users.phone_number%TYPE,
    p_email        IN users.email%TYPE,
    p_password     IN users.password%TYPE,
    p_date_of_birth IN users.date_of_birth%TYPE,
    p_is_active    IN users.is_active%TYPE
  ) IS
  BEGIN
    IF NOT validate_email(p_email) THEN
        RAISE_APPLICATION_ERROR(-20014, 'Invalid format of email=' || p_email);
    END IF;
    
    UPDATE users
       SET first_name   = p_first_name,
           last_name    = p_last_name,
           phone_number = p_phone_number,
           email        = p_email,
           password     = p_password,
           date_of_birth= p_date_of_birth,
           is_active    = p_is_active
     WHERE id = p_id;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20012, 'No user found with id='||p_id);
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END update_user;

  PROCEDURE delete_user(p_id IN users.id%TYPE) IS
  BEGIN
    UPDATE users
       SET is_active = 0
     WHERE id = p_id;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20013, 'No user found with id='||p_id);
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END delete_user;

END users_package;
/


--testy
BEGIN
  users_package.add_user(
    p_first_name    => 'Jan',
    p_last_name     => 'Kowalski',
    p_phone_number  => '+48123123123',
    p_email         => 'jan.k2@example.com',
    p_password      => 'tajne',
    p_date_of_birth => DATE '1990-01-01'
  );
END;
/
BEGIN
  users_package.add_user(
    p_first_name    => 'Janusz',
    p_last_name     => 'Kowalski',
    p_phone_number  => '123123321',
    p_email         => 'janek.k@example.com',
    p_password      => 'tajne',
    p_date_of_birth => DATE '2000-01-01'
  );
END;
/

--test walidacji email
--BEGIN
--  users_package.add_user(
--    p_first_name    => 'Janusz',
--    p_last_name     => 'Kowalski',
--    p_phone_number  => '123123321',
--    p_email         => 'janek.k@example',
--    p_password      => 'tajne',
--    p_date_of_birth => DATE '2000-01-01'
--  );
--END;
--/

SELECT * FROM users;

BEGIN
  users_package.update_user(
    p_id            => 4,
    p_first_name    => 'Janusz',
    p_last_name     => 'Nowak',
    p_phone_number  => '+48011112222',
    p_email         => 'janusz.nowak@example.com',
    p_password      => 'nowehaslo',
    p_date_of_birth => DATE '1980-12-12',
    p_is_active     => 1
  );
END;
/

BEGIN
  users_package.delete_user(
    p_id => 22
  );
END;
/


--SELECT * FROM users;
--SELECT * FROM users_archive;

