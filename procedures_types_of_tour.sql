CREATE OR REPLACE PACKAGE types_of_tour_package IS
  PROCEDURE add_type(
    p_name_of_type IN types_of_tour.name_of_type%TYPE,
    p_is_active    IN types_of_tour.is_active%TYPE DEFAULT 1
  );

  PROCEDURE update_type(
    p_id           IN types_of_tour.id%TYPE,
    p_name_of_type IN types_of_tour.name_of_type%TYPE,
    p_is_active    IN types_of_tour.is_active%TYPE
  );

  PROCEDURE delete_type(
    p_id IN types_of_tour.id%TYPE
  );
END types_of_tour_package;
/


CREATE OR REPLACE PACKAGE BODY types_of_tour_package IS

PROCEDURE add_type(
    p_name_of_type IN types_of_tour.name_of_type%TYPE,
    p_is_active    IN types_of_tour.is_active%TYPE DEFAULT 1
  ) IS
  BEGIN
    INSERT INTO types_of_tour (
      name_of_type, is_active
    ) VALUES (
      p_name_of_type, p_is_active
    );
    COMMIT;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      RAISE_APPLICATION_ERROR(-20031, 'Tour type already exists');
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END add_type;

  PROCEDURE update_type(
    p_id           IN types_of_tour.id%TYPE,
    p_name_of_type IN types_of_tour.name_of_type%TYPE,
    p_is_active    IN types_of_tour.is_active%TYPE
  ) IS
  BEGIN
    UPDATE types_of_tour
       SET name_of_type = p_name_of_type,
           is_active    = p_is_active
     WHERE id = p_id;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20032, 'No tour type found with id=' || p_id);
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END update_type;

PROCEDURE delete_type(
    p_id IN types_of_tour.id%TYPE
  ) IS
  BEGIN
    UPDATE types_of_tour
       SET is_active = 0
     WHERE id = p_id;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20033, 'No tour type found with id=' || p_id);
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END delete_type;

END types_of_tour_package;
/




BEGIN
    types_of_tour_package.add_type('test3', 1);
END;
/

--SELECT * FROM types_of_tour;


BEGIN
    types_of_tour_package.update_type(1, 'test2', 1);
END;
/

BEGIN
    types_of_tour_package.delete_type(2);
END;
/