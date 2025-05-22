CREATE OR REPLACE PACKAGE thr_package IS
  PROCEDURE add_thr(
    p_reservation_id   IN tour_has_reservations.reservation_id%TYPE,
    p_tour_id          IN tour_has_reservations.tour_id%TYPE,
    p_is_price_reduced IN tour_has_reservations.is_price_reduced%TYPE DEFAULT 0,
    p_is_active        IN tour_has_reservations.is_active%TYPE        DEFAULT 1
  );

  PROCEDURE update_thr(
    p_reservation_id   IN tour_has_reservations.reservation_id%TYPE,
    p_tour_id          IN tour_has_reservations.tour_id%TYPE,
    p_is_price_reduced IN tour_has_reservations.is_price_reduced%TYPE,
    p_is_active        IN tour_has_reservations.is_active%TYPE
  );

  PROCEDURE delete_thr(
    p_reservation_id   IN tour_has_reservations.reservation_id%TYPE,
    p_tour_id          IN tour_has_reservations.tour_id%TYPE
  );
END thr_package;
/


CREATE OR REPLACE PACKAGE BODY thr_package IS

  PROCEDURE add_thr(
    p_reservation_id   IN tour_has_reservations.reservation_id%TYPE,
    p_tour_id          IN tour_has_reservations.tour_id%TYPE,
    p_is_price_reduced IN tour_has_reservations.is_price_reduced%TYPE DEFAULT 0,
    p_is_active        IN tour_has_reservations.is_active%TYPE        DEFAULT 1
  ) IS
  BEGIN
    INSERT INTO tour_has_reservations (
      reservation_id, tour_id, is_price_reduced, is_active
    ) VALUES (
      p_reservation_id, p_tour_id, p_is_price_reduced, p_is_active
    );
    COMMIT;
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      RAISE_APPLICATION_ERROR(-20051, 'Provided reservation-tour relation already exists');
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END add_thr;

  PROCEDURE update_thr(
    p_reservation_id   IN tour_has_reservations.reservation_id%TYPE,
    p_tour_id          IN tour_has_reservations.tour_id%TYPE,
    p_is_price_reduced IN tour_has_reservations.is_price_reduced%TYPE,
    p_is_active        IN tour_has_reservations.is_active%TYPE
  ) IS
  BEGIN
    UPDATE tour_has_reservations
       SET is_price_reduced = p_is_price_reduced,
           is_active        = p_is_active
     WHERE reservation_id = p_reservation_id
       AND tour_id        = p_tour_id;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20052,
        'No existing relation for reservation='||p_reservation_id||
        ' and tour='||p_tour_id);
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END update_thr;

  PROCEDURE delete_thr(
    p_reservation_id   IN tour_has_reservations.reservation_id%TYPE,
    p_tour_id          IN tour_has_reservations.tour_id%TYPE
  ) IS
  BEGIN
    UPDATE tour_has_reservations
       SET is_active = 0
     WHERE reservation_id = p_reservation_id
       AND tour_id        = p_tour_id;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20053,
        'No existing relation found for reservation='||p_reservation_id||
        ' and tour='||p_tour_id);
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END delete_thr;

END thr_package;
/


SELECT * FROM tours;
SELECT * FROM reservations;

BEGIN
    thr_package.add_thr(23,2);
END;
/

BEGIN
    thr_package.update_thr(23, 2, 0, 1);
END;
/

SELECT * FROM tour_has_reservations;


BEGIN
    thr_package.delete_thr(23, 2);
END;
/