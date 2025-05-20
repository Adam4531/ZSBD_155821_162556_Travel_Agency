-- inicjalizacja pakietów
CREATE OR REPLACE PACKAGE reservations_package IS

PROCEDURE add_reservation(
    p_user_id             IN reservations.user_id%TYPE,
    p_date_of_reservation IN reservations.date_of_reservation%TYPE,
    p_amount_of_children  IN reservations.amount_of_children%TYPE,
    p_amount_of_adults    IN reservations.amount_of_adults%TYPE,
    p_is_confirmed        IN reservations.is_confirmed%TYPE DEFAULT 0,
    p_is_active           IN reservations.is_active%TYPE  DEFAULT 1
);
    
PROCEDURE update_reservation(
    p_id IN reservations.id%TYPE,
    p_user_id IN reservations.user_id%TYPE,
    p_date_of_reservation IN reservations.date_of_reservation%TYPE,
    p_amount_of_children IN reservations.amount_of_children%TYPE,
    p_amount_of_adults IN reservations.amount_of_adults%TYPE,
    p_is_confirmed IN reservations.is_confirmed%TYPE DEFAULT 0,
    p_is_active IN reservations.is_active%TYPE DEFAULT 1
);

PROCEDURE delete_reservation(
    p_id IN reservations.id%TYPE
);
    
    
END reservations_package;
/

--implementacja pakietów
CREATE OR REPLACE PACKAGE BODY reservations_package IS

PROCEDURE add_reservation(
    p_user_id IN reservations.user_id%TYPE,
    p_date_of_reservation IN reservations.date_of_reservation%TYPE,
    p_amount_of_children IN reservations.amount_of_children%TYPE,
    p_amount_of_adults IN reservations.amount_of_adults%TYPE,
    p_is_confirmed IN reservations.is_confirmed%TYPE,
    p_is_active IN reservations.is_active%TYPE
) IS 
    BEGIN 
        INSERT INTO reservations (
        user_id,
        date_of_reservation,
        amount_of_children,
        amount_of_adults,
        is_confirmed,
        is_active
    ) VALUES (
        p_user_id,
        p_date_of_reservation,
        p_amount_of_children,
        p_amount_of_adults,
        p_is_confirmed,
        p_is_active 
    );
    COMMIT;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20001, 'Reservation with provided data already exists');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END add_reservation;


PROCEDURE update_reservation(
    p_id IN reservations.id%TYPE,
    p_user_id IN reservations.user_id%TYPE,
    p_date_of_reservation IN reservations.date_of_reservation%TYPE,
    p_amount_of_children IN reservations.amount_of_children%TYPE,
    p_amount_of_adults IN reservations.amount_of_adults%TYPE,
    p_is_confirmed IN reservations.is_confirmed%TYPE,
    p_is_active IN reservations.is_active%TYPE
) IS
    BEGIN
    UPDATE reservations
        SET date_of_reservation = p_date_of_reservation,
            amount_of_children = p_amount_of_children,
            amount_of_adults = p_amount_of_adults,
            is_confirmed = p_is_confirmed,
            is_active = p_is_active
        WHERE id=p_id;
        
        IF SQL%ROWCOUNT=0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'No reservation found with id=' || p_id);
        END IF;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
            
END update_reservation;


PROCEDURE delete_reservation(
    p_id IN reservations.id%TYPE
) IS
BEGIN
    DELETE FROM reservations WHERE id=p_id;
    
        IF SQL%ROWCOUNT=0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'No reservaion found with id=' || p_id);
        END IF;
    
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        ROLLBACK;
        RAISE;

END delete_reservation;


END reservations_package;
/


--testy
BEGIN
  reservations_package.add_reservation(1, DATE '2011-05-01', 2,2);
END;
/

