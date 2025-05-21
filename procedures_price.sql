--inicjalizacja
CREATE OR REPLACE PACKAGE price_package IS
  PROCEDURE add_price(
    p_normal_price  IN price.normal_price%TYPE,
    p_reduced_price IN price.reduced_price%TYPE,
    p_is_active     IN price.is_active%TYPE DEFAULT 1
  );

  PROCEDURE update_price(
    p_id            IN price.id%TYPE,
    p_normal_price  IN price.normal_price%TYPE,
    p_reduced_price IN price.reduced_price%TYPE,
    p_is_active     IN price.is_active%TYPE
  );

  PROCEDURE delete_price(
    p_id IN price.id%TYPE
  );
END price_package;
/

--implementacja 
CREATE OR REPLACE PACKAGE BODY price_package IS
  PROCEDURE add_price(
    p_normal_price  IN price.normal_price%TYPE,
    p_reduced_price IN price.reduced_price%TYPE,
    p_is_active     IN price.is_active%TYPE DEFAULT 1
  ) IS
  BEGIN
    INSERT INTO price (
      normal_price, reduced_price, is_active
    ) VALUES (
      p_normal_price, p_reduced_price, p_is_active
    );
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END add_price;

PROCEDURE update_price(
    p_id            IN price.id%TYPE,
    p_normal_price  IN price.normal_price%TYPE,
    p_reduced_price IN price.reduced_price%TYPE,
    p_is_active     IN price.is_active%TYPE
  ) IS
  BEGIN
    UPDATE price
       SET normal_price  = p_normal_price,
           reduced_price = p_reduced_price,
           is_active      = p_is_active
     WHERE id = p_id;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20042, 'No price found with id=' || p_id);
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END update_price;

PROCEDURE delete_price(
    p_id IN price.id%TYPE
  ) IS
  BEGIN
    UPDATE price
       SET is_active = 0
     WHERE id = p_id;
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20043, 'No price found with id=' || p_id);
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END delete_price;
END price_package;
/

--testy
BEGIN
  price_package.add_price(
    p_normal_price  => 12342.31,
    p_reduced_price => 1.50
  );
END;
/

--SELECT * FROM price;

BEGIN
  price_package.update_price(
    p_id             => 1,
    p_normal_price   => 1500.00,
    p_reduced_price  => 1200.00,
    p_is_active      => 1
  );
END;
/

--SELECT * FROM price;

BEGIN
  price_package.delete_price(
    p_id => 1
  );
END;
/

--SELECT * FROM price;