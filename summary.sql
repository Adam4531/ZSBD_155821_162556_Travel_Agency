CREATE TABLE reservation_summary (
  period_start      DATE,
  granularity       VARCHAR2(1), --M / Q / Y
  total_reservations NUMBER,
  total_revenue     NUMBER,
  CONSTRAINT pk_reservation_summary PRIMARY KEY(period_start, granularity)
);

CREATE OR REPLACE TRIGGER trg_update_reservation_summary
  AFTER INSERT ON tour_has_reservations
  FOR EACH ROW
DECLARE
  v_date        DATE;
  v_revenue     NUMBER;
  v_month_start DATE;
  v_quarter_start DATE;
  v_year_start  DATE;
BEGIN
    SELECT r.date_of_reservation,
         CASE WHEN :NEW.is_price_reduced = 1 THEN p.reduced_price ELSE p.normal_price END
    INTO v_date, v_revenue
    FROM reservations r
    JOIN tours t ON t.id = :NEW.tour_id
    JOIN price p ON p.id = t.price_id
   WHERE r.id = :NEW.reservation_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN;
  END;

  v_month_start   := TRUNC(v_date, 'MM');
  v_quarter_start := TRUNC(v_date, 'Q');
  v_year_start    := TRUNC(v_date, 'YYYY');

  MERGE INTO reservation_summary rs
    USING (SELECT v_month_start AS period_start, 'M' AS granularity FROM dual) src
    ON (rs.period_start = src.period_start AND rs.granularity = src.granularity)
  WHEN MATCHED THEN
    UPDATE SET
      rs.total_reservations = rs.total_reservations + 1,
      rs.total_revenue      = rs.total_revenue + v_revenue
  WHEN NOT MATCHED THEN
    INSERT (period_start, granularity, total_reservations, total_revenue)
    VALUES (src.period_start, src.granularity, 1, v_revenue);

  MERGE INTO reservation_summary rs
    USING (SELECT v_quarter_start AS period_start, 'Q' AS granularity FROM dual) src
    ON (rs.period_start = src.period_start AND rs.granularity = src.granularity)
  WHEN MATCHED THEN
    UPDATE SET
      rs.total_reservations = rs.total_reservations + 1,
      rs.total_revenue      = rs.total_revenue + v_revenue
  WHEN NOT MATCHED THEN
    INSERT (period_start, granularity, total_reservations, total_revenue)
    VALUES (src.period_start, src.granularity, 1, v_revenue);

  MERGE INTO reservation_summary rs
    USING (SELECT v_year_start AS period_start, 'Y' AS granularity FROM dual) src
    ON (rs.period_start = src.period_start AND rs.granularity = src.granularity)
  WHEN MATCHED THEN
    UPDATE SET
      rs.total_reservations = rs.total_reservations + 1,
      rs.total_revenue      = rs.total_revenue + v_revenue
  WHEN NOT MATCHED THEN
    INSERT (period_start, granularity, total_reservations, total_revenue)
    VALUES (src.period_start, src.granularity, 1, v_revenue);
END;
/