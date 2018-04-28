CREATE TABLE Fixed_objects (
  id_obj INT(6) NOT NULL,
  id_parent INT(6),

  CONSTRAINT pk_obj PRIMARY KEY (id_obj),
  CONSTRAINT fk_obj FOREIGN KEY ( id_parent) REFERENCES Fixed_objects( id_parent)
);

CREATE TABLE Stations (
  id_st_obj INT(6) NOT NULL,
  st_type VARCHAR(20) NOT NULL,
  st_name VARCHAR(20) NOT NULL,
  id_station INT(6),

  CONSTRAINT pk_st PRIMARY KEY (id_st_obj),
  CONSTRAINT fk_id_st FOREIGN KEY (id_st_obj) REFERENCES Fixed_objects( id_obj ),
  CONSTRAINT fk_station FOREIGN KEY (id_station) REFERENCES Stations( id_st_obj )
);

CREATE TABLE Ways (
  id_way_obj INT(6) NOT NULL,
  way_type VARCHAR(20) NOT NULL,
  way_name VARCHAR(20) NOT NULL,
  id_first_station INT(6) NOT NULL,
  id_second_station INT(6) NOT NULL,

  CONSTRAINT pk_way PRIMARY KEY (id_way_obj),
  CONSTRAINT fk_id_way FOREIGN KEY (id_way_obj) REFERENCES Fixed_objects( id_obj ),
  CONSTRAINT fk_st_frst FOREIGN KEY (id_first_station) REFERENCES Stations( id_st_obj ),
  CONSTRAINT fk_station_scnd FOREIGN KEY (id_second_station) REFERENCES Stations( id_st_obj )
);

CREATE TABLE Trains (
  id_tr INT(5) NOT NULL,
  id_obj_from INT(6) NOT NULL,
  id_obj_to INT(6) NOT NULL,
  tr_number INT(7) NOT NULL,
  tr_place INT(6) NOT NULL,

  CONSTRAINT pk_tr PRIMARY KEY (id_tr),
  CONSTRAINT fk_obj_from FOREIGN KEY (id_obj_from) REFERENCES Stations(id_st_obj),
  CONSTRAINT fk_obj_to FOREIGN KEY (id_obj_to) REFERENCES Stations(id_st_obj),
  CONSTRAINT fk_place FOREIGN KEY (tr_place) REFERENCES Fixed_objects(id_obj)
);

CREATE TABLE Carriages (
  id_car INT(8) NOT NULL,
  id_car_tr INT(5) NOT NULL,
  car_number INT(9) NOT NULL,
  cargo VARCHAR(15),
  cargo_weight INT(7),

  CONSTRAINT pk_car PRIMARY KEY (id_car),
  CONSTRAINT fk_tr FOREIGN KEY (id_car_tr) REFERENCES Trains(id_tr)
);

CREATE TABLE Operations_with_trains (
  code VARCHAR(2) NOT NULL,
  id_op_tr INT(5) NOT NULL,
  id_op_obj INT(6) NOT NULL,
  oper_type varchar(10) NOT NULL,
  oper_time DATETIME NOT NULL,

  CONSTRAINT pk_code PRIMARY KEY (code),
  CONSTRAINT fk_tr_op_tr FOREIGN KEY (id_op_tr) REFERENCES Trains(id_tr),
  CONSTRAINT fk_obj_op_tr FOREIGN KEY (id_op_obj) REFERENCES Fixed_objects(id_obj)
);

CREATE TABLE Operations_with_carriages (
  op_car_code VARCHAR(2) NOT NULL,
  id_op_car INT(8) NOT NULL,
  id_op_car_obj INT(6) NOT NULL,
  oper_car_type varchar(10) NOT NULL,
  oper_car_time DATETIME NOT NULL,

  CONSTRAINT pk_car_code PRIMARY KEY (op_car_code),
  CONSTRAINT fk_tr_op_car FOREIGN KEY (id_op_car) REFERENCES Carriages(id_car),
  CONSTRAINT fk_obj_op_car FOREIGN KEY (id_op_car_obj) REFERENCES Fixed_objects(id_obj)
);


--I know that these keys are created automatically.
--I want to show that I know how to create them.
CREATE UNIQUE INDEX ind1 ON Fixed_objects( id_obj );
CREATE UNIQUE INDEX ind2 ON Stations( id_st_obj );
CREATE UNIQUE INDEX ind3 ON Ways( id_way_obj );
CREATE UNIQUE INDEX ind4 ON Trains( id_tr );
CREATE UNIQUE INDEX ind5 ON Carriages( id_car );
CREATE UNIQUE INDEX ind6 ON Operations_with_trains( code );
CREATE UNIQUE INDEX ind7 ON Operations_with_Carriages( op_car_code );



INSERT INTO Fixed_objects (id_obj, id_parent)
VALUES (260000,NULL );

INSERT INTO Fixed_objects (id_obj, id_parent)
VALUES (260001,260000 );

INSERT INTO Fixed_objects (id_obj, id_parent)
VALUES (260002,260000 );

INSERT INTO Fixed_objects (id_obj, id_parent)
VALUES (260003,260000 );

INSERT INTO Fixed_objects (id_obj, id_parent)
VALUES (530000,NULL );

INSERT INTO Fixed_objects (id_obj, id_parent)
VALUES (530001,530000 );

INSERT INTO Fixed_objects (id_obj, id_parent)
VALUES (530002,530000 );

INSERT INTO Fixed_objects (id_obj, id_parent)
VALUES (345000,NULL );

INSERT INTO Fixed_objects (id_obj, id_parent)
VALUES (340023,345000 );

INSERT INTO Fixed_objects (id_obj, id_parent)
VALUES (450567,345000 );

INSERT INTO Fixed_objects (id_obj, id_parent)
VALUES (345067,345000 );



INSERT INTO Stations (id_st_obj, st_type, st_name, id_station )
VALUES (260000, 'station', 'N.Novgorod', 260000 );

INSERT INTO Stations (id_st_obj, st_type, st_name, id_station )
VALUES (260001, 'track', '01/01', 260000 );

INSERT INTO Stations (id_st_obj, st_type, st_name, id_station )
VALUES (260002, 'track', '03/01', 260000 );

INSERT INTO Stations (id_st_obj, st_type, st_name, id_station )
VALUES (260003, 'track', '01/02', 260000 );

INSERT INTO Stations (id_st_obj, st_type, st_name, id_station )
VALUES (530000, 'station', 'Samara', 530000 );

INSERT INTO Stations (id_st_obj, st_type, st_name, id_station )
VALUES (530001, 'track', '06/01', 530000 );

INSERT INTO Stations (id_st_obj, st_type, st_name, id_station )
VALUES (530002, 'track', '04/02', 530000 );



INSERT INTO Ways (id_way_obj, way_type, way_name, id_first_station, id_second_station)
VALUES (345000, 'way', '01', 260000, 530000);

INSERT INTO Ways (id_way_obj, way_type, way_name, id_first_station, id_second_station)
VALUES (340023, 'stage', '02/07', 530000, 260000);

INSERT INTO Ways (id_way_obj, way_type, way_name, id_first_station, id_second_station)
VALUES (450567, 'stage', '06/31', 260000, 530000);

INSERT INTO Ways (id_way_obj, way_type, way_name, id_first_station, id_second_station)
VALUES (345067, 'stage', '12/12', 260000, 530000);



INSERT INTO  Trains (id_tr, id_obj_from, id_obj_to, tr_number, tr_place)
VALUES ( 00234, 260000, 530000, 0151100, 450567 );

INSERT INTO  Trains (id_tr, id_obj_from, id_obj_to, tr_number, tr_place)
VALUES ( 10125, 260000, 530000, 2745667, 260003 );

INSERT INTO  Trains (id_tr, id_obj_from, id_obj_to, tr_number, tr_place)
VALUES ( 00029, 530000, 260000, 9563158, 345067 );



INSERT INTO  Carriages ( id_car, id_car_tr, car_number, cargo, cargo_weight )
VALUES ( 00043409, 00234, 000332559, 'A', 0000500 );

INSERT INTO  Carriages ( id_car, id_car_tr, car_number, cargo, cargo_weight )
VALUES ( 00043467, 00234, 000208559, 'B', 0001000 );

INSERT INTO  Carriages ( id_car, id_car_tr, car_number, cargo, cargo_weight )
VALUES ( 00043498, 00234, 002308555, 'A', 0015000 );

INSERT INTO  Carriages ( id_car, id_car_tr, car_number, cargo, cargo_weight )
VALUES ( 00151109, 00234, 000329051, 'A', 0000500 );

INSERT INTO  Carriages ( id_car, id_car_tr, car_number, cargo, cargo_weight )
VALUES ( 001904409, 00234, 000332009, 'C', 0004300 );

INSERT INTO  Carriages ( id_car, id_car_tr, car_number, cargo, cargo_weight )
VALUES ( 00563409, 10125, 023045668, 'B', 0015000 );

INSERT INTO  Carriages ( id_car, id_car_tr, car_number, cargo, cargo_weight )
VALUES ( 10051289, 10125, 45760089, 'C', 0563500 );

INSERT INTO  Carriages ( id_car, id_car_tr, car_number, cargo, cargo_weight )
VALUES ( 03944409, 10125, 000329051, 'B', 1004030 );

INSERT INTO  Carriages ( id_car, id_car_tr, car_number, cargo, cargo_weight )
VALUES ( 345904409, 00029, 005672009, 'C', 0004300 );

INSERT INTO  Carriages ( id_car, id_car_tr, car_number, cargo, cargo_weight )
VALUES ( 10051290, 00029, 027896980, 'C', 0015000 );

INSERT INTO  Carriages ( id_car, id_car_tr, car_number, cargo, cargo_weight )
VALUES ( 09051200, 00029, 67860709, 'A', 0563500 );

INSERT INTO  Carriages ( id_car, id_car_tr, car_number, cargo, cargo_weight )
VALUES ( 03939409, 00029, 00320076, 'A', 1004030 );



INSERT INTO  Operations_with_trains ( code, id_op_tr, id_op_obj, oper_type, oper_time )
VALUES ( '01', 00234, 260000, 'Creation', '2016-10-18 12:00:00' );

INSERT INTO  Operations_with_trains ( code, id_op_tr, id_op_obj, oper_type, oper_time )
VALUES ( '78', 00234, 345067, 'X', '2016-10-27 04:45:00' );

INSERT INTO  Operations_with_trains ( code, id_op_tr, id_op_obj, oper_type, oper_time )
VALUES ( '05', 10125, 260003, 'Creation', '2016-11-01 15:30:00' );

INSERT INTO  Operations_with_trains ( code, id_op_tr, id_op_obj, oper_type, oper_time )
VALUES ( '11', 00029, 530001, 'Creation', '2016-10-25 00:00:00' );

INSERT INTO  Operations_with_trains ( code, id_op_tr, id_op_obj, oper_type, oper_time )
VALUES ( '21', 00029, 530001, 'Y', '2016-11-22 21:00:00' );

INSERT INTO  Operations_with_trains ( code, id_op_tr, id_op_obj, oper_type, oper_time )
VALUES ( '49', 00029, 345067, 'Z', '2016-11-14 11:00:00' );

INSERT INTO  Operations_with_trains ( code, id_op_tr, id_op_obj, oper_type, oper_time )
VALUES ( '08', 00029, 450567, 'Y', '2016-12-01 22:30:00' );



INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '38', 00043409, 260003, 'Creation', '2016-10-17 12:30:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '23', 00043467, 260003, 'Creation', '2016-09-27 15:00:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '77', 00043498, 260002, 'Creation', '2016-10-08 11:00:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '08', 00151109, 260003, 'Creation', '2016-10-14 23:30:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '12', 001904409, 260001, 'Creation', '2016-08-02 04:00:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '90', 00563409, 260002, 'Creation', '2016-11-01 12:30:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '67', 10051289, 260001, 'Creation', '2016-09-23 08:00:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '10', 03944409, 260002, 'Creation', '2016-09-23 19:00:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '31', 345904409, 530002, 'Creation', '2016-10-23 12:15:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '99', 10051290, 530001, 'Creation', '2016-10-17 14:00:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '35', 09051200, 530002, 'Creation', '2016-09-15 21:00:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '01', 03939409, 530002, 'Creation', '2016-10-01 14:30:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '68', 00043467, 260003, 'K', '2016-10-12 11:00:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '98', 00151109, 260003, 'L', '2016-10-19 14:30:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '04', 001904409, 260001, 'K', '2016-08-05 15:15:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '17', 00563409, 260002, 'M', '2016-11-22 08:30:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '80', 10051290, 530001, 'M', '2016-10-19 05:30:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '36', 09051200, 530002, 'N', '2016-09-15 23:00:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '69', 00043409, 260002, 'N', CAST('2016-11-23 15:0:00' AS DATE ) );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '15', 00151109, 450567, 'M', '2016-10-20 22:45:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '64', 001904409, 340023, 'N', '2016-11-15 10:00:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '70', 00563409, 260002, 'L', '2016-11-20 00:30:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '25', 10051289, 260003, 'M', '2016-10-02 20:30:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '55', 10051290, 340023, 'K', '2016-10-18 00:00:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '44', 09051200, 530001, 'K', '2016-11-05 01:00:00' );

INSERT INTO  Operations_with_Carriages ( op_car_code, id_op_car, id_op_car_obj,  oper_car_type, oper_car_time )
VALUES ( '54', 03939409, 530002, 'L', '2016-10-06 13:30:00' );