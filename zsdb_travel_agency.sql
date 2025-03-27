CREATE TABLE "users" (
  "id" int PRIMARY KEY,
  "first_name" varchar(50),
  "last_name" varchar(50),
  "phone_number" varchar(15),
  "email" varchar(30) UNIQUE,
  "password" varchar(45),
  "date_of_birth" date,
  "is_active" NUMBER(1) DEFAULT 1
);

CREATE TABLE "reservations" (
  "id" int PRIMARY KEY,
  "user_id" int,
  "date_of_reservation" date DEFAULT SYSDATE,
  "amount_of_children" int DEFAULT 0,
  "amount_of_adults" int DEFAULT 0,
  "is_confirmed" NUMBER(1) DEFAULT 1,
  "is_active" NUMBER(1) DEFAULT 1
);

CREATE TABLE "tours" (
  "id" int PRIMARY KEY,
  "supervisor_id" int,
  "max_number_of_participants" int,
  "date_start" date,
  "date_end" date,
  "place_id" int,
  "type_of_tour_id" int,
  "price_id" int,
  "country" varchar(45),
  "region" varchar(45),
  "city" varchar(45),
  "accommodation" varchar(45),
  "is_active" NUMBER(1) DEFAULT 1
);

CREATE TABLE "types_of_tour" (
  "id" int PRIMARY KEY,
  "name_of_type" varchar(45),
  "is_active" NUMBER(1) DEFAULT 1
);

CREATE TABLE "price" (
  "id" int PRIMARY KEY,
  "normal_price" decimal(7,2),
  "reduced_price" decimal(7,2),
  "is_active" NUMBER(1) DEFAULT 1
);

CREATE TABLE "tour_has_reservations" (
  "reservation_id" int,
  "tour_id" int,
  "is_active" NUMBER(1) DEFAULT 1,
  "is_price_reduced" NUMBER(1) DEFAULT 0,
  
  CONSTRAINT pk_tour_has_reservations PRIMARY KEY ("reservation_id", "tour_id")
);

ALTER TABLE "reservations" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "tours" ADD FOREIGN KEY ("supervisor_id") REFERENCES "users" ("id");

ALTER TABLE "tours" ADD FOREIGN KEY ("type_of_tour_id") REFERENCES "types_of_tour" ("id");

ALTER TABLE "tours" ADD FOREIGN KEY ("price_id") REFERENCES "price" ("id");

ALTER TABLE "tour_has_reservations" ADD FOREIGN KEY ("reservation_id") REFERENCES "reservations" ("id");

ALTER TABLE "tour_has_reservations" ADD FOREIGN KEY ("tour_id") REFERENCES "tours" ("id");


--DROP TABLE "tour_has_reservations" CASCADE CONSTRAINTS;
--DROP TABLE "tours" CASCADE CONSTRAINTS;
--DROP TABLE "reservations" CASCADE CONSTRAINTS;
--DROP TABLE "types_of_tour" CASCADE CONSTRAINTS;
--DROP TABLE "price" CASCADE CONSTRAINTS;
--DROP TABLE "users" CASCADE CONSTRAINTS;