CREATE OR REPLACE PACKAGE tours_package IS
  PROCEDURE add_tour(
    p_supervisor_id           IN tours.supervisor_id%TYPE,
    p_max_participants        IN tours.max_number_of_participants%TYPE,
    p_date_start              IN tours.date_start%TYPE,
    p_date_end                IN tours.date_end%TYPE,
    p_place_id                IN tours.place_id%TYPE,
    p_type_id                 IN tours.type_of_tour_id%TYPE,
    p_price_id                IN tours.price_id%TYPE,
    p_country                 IN tours.country%TYPE,
    p_region                  IN tours.region%TYPE,
    p_city                    IN tours.city%TYPE,
    p_accommodation           IN tours.accommodation%TYPE,
    p_is_active               IN tours.is_active%TYPE DEFAULT 1
  );

  PROCEDURE update_tour(
    p_id                      IN tours.id%TYPE,
    p_supervisor_id           IN tours.supervisor_id%TYPE,
    p_max_participants        IN tours.max_number_of_participants%TYPE,
    p_date_start              IN tours.date_start%TYPE,
    p_date_end                IN tours.date_end%TYPE,
    p_place_id                IN tours.place_id%TYPE,
    p_type_id                 IN tours.type_of_tour_id%TYPE,
    p_price_id                IN tours.price_id%TYPE,
    p_country                 IN tours.country%TYPE,
    p_region                  IN tours.region%TYPE,
    p_city                    IN tours.city%TYPE,
    p_accommodation           IN tours.accommodation%TYPE,
    p_is_active               IN tours.is_active%TYPE
  );

  PROCEDURE delete_tour(
    p_id IN tours.id%TYPE
  );
END tours_package;
/


CREATE OR REPLACE PACKAGE BODY tours_package IS

  PROCEDURE add_tour(
    p_supervisor_id           IN tours.supervisor_id%TYPE,
    p_max_participants        IN tours.max_number_of_participants%TYPE,
    p_date_start              IN tours.date_start%TYPE,
    p_date_end                IN tours.date_end%TYPE,
    p_place_id                IN tours.place_id%TYPE,
    p_type_id                 IN tours.type_of_tour_id%TYPE,
    p_price_id                IN tours.price_id%TYPE,
    p_country                 IN tours.country%TYPE,
    p_region                  IN tours.region%TYPE,
    p_city                    IN tours.city%TYPE,
    p_accommodation           IN tours.accommodation%TYPE,
    p_is_active               IN tours.is_active%TYPE DEFAULT 1
  ) IS
  BEGIN
    INSERT INTO tours (
      supervisor_id,
      max_number_of_participants,
      date_start,
      date_end,
      place_id,
      type_of_tour_id,
      price_id,
      country,
      region,
      city,
      accommodation,
      is_active
    ) VALUES (
      p_supervisor_id,
      p_max_participants,
      p_date_start,
      p_date_end,
      p_place_id,
      p_type_id,
      p_price_id,
      p_country,
      p_region,
      p_city,
      p_accommodation,
      p_is_active
    );
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20021, 'Error adding tour: ' || SQLERRM);
  END add_tour;

  PROCEDURE update_tour(
    p_id                      IN tours.id%TYPE,
    p_supervisor_id           IN tours.supervisor_id%TYPE,
    p_max_participants        IN tours.max_number_of_participants%TYPE,
    p_date_start              IN tours.date_start%TYPE,
    p_date_end                IN tours.date_end%TYPE,
    p_place_id                IN tours.place_id%TYPE,
    p_type_id                 IN tours.type_of_tour_id%TYPE,
    p_price_id                IN tours.price_id%TYPE,
    p_country                 IN tours.country%TYPE,
    p_region                  IN tours.region%TYPE,
    p_city                    IN tours.city%TYPE,
    p_accommodation           IN tours.accommodation%TYPE,
    p_is_active               IN tours.is_active%TYPE
  ) IS
  BEGIN
    UPDATE tours
       SET supervisor_id              = p_supervisor_id,
           max_number_of_participants = p_max_participants,
           date_start                 = p_date_start,
           date_end                   = p_date_end,
           place_id                   = p_place_id,
           type_of_tour_id            = p_type_id,
           price_id                   = p_price_id,
           country                    = p_country,
           region                     = p_region,
           city                       = p_city,
           accommodation              = p_accommodation,
           is_active                  = p_is_active
     WHERE id = p_id;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20022, 'No tour found with id=' || p_id);
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END update_tour;

  PROCEDURE delete_tour(
    p_id IN tours.id%TYPE
  ) IS
  BEGIN
    UPDATE tours
       SET is_active = 0
     WHERE id = p_id;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20023, 'No tour found with id=' || p_id);
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END delete_tour;

END tours_package;
/



BEGIN
    tours_package.add_tour(
    p_supervisor_id    => 1,
    p_max_participants => 10,
    p_date_start       => DATE '2025-06-01',
    p_date_end         => DATE '2025-06-07',
    p_place_id         => 200,
    p_type_id          => 2,
    p_price_id         => 3,
    p_country          => 'Italy',
    p_region           => 'Sicily',
    p_city             => 'Palermo',
    p_accommodation    => 'Hotel',
    p_is_active        => 1
  );
END;
/


SELECT * FROM tours;
SELECT * FROM price;
SELECT * FROM types_of_tour;
SELECT * FROM place;
SELECT * FROM users;


BEGIN
  tours_package.update_tour(
    p_id               => 3,
    p_supervisor_id    => 1,
    p_max_participants => 12,
    p_date_start       => DATE '2025-07-01',
    p_date_end         => DATE '2025-07-08',
    p_place_id         => 4,
    p_type_id          => 4,
    p_price_id         => 3,
    p_country          => 'Spain',
    p_region           => 'Catalonia',
    p_city             => 'Girona',
    p_accommodation    => 'B&B',
    p_is_active        => 1
  );
END;
/


BEGIN
    tours_package.delete_tour(21);
END;
/

SELECT * FROM tours;
SELECT * FROM tours_archive;