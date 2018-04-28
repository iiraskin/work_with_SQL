SELECT *
FROM Carriages
WHERE id_car_tr = 00234
ORDER BY id_car;


SELECT *
FROM Operations_with_carriages
WHERE id_op_car = 10051290 AND oper_car_time BETWEEN '2016-09-01. 00:00:00' AND '2016-12-01. 00:00:00';


SELECT car_number
FROM Carriages
WHERE id_car_tr IN (
  SELECT id_tr
  FROM Trains
  WHERE tr_place IN (
    SELECT id_st_obj
    FROM Stations
  )
);


SELECT Operations_with_trains.code, Operations_with_trains.oper_type, Operations_with_trains.oper_time
FROM Operations_with_trains, Fixed_objects
WHERE Fixed_objects.id_parent = 530000 AND Operations_with_trains.id_op_obj = Fixed_objects.id_obj
UNION
SELECT Operations_with_carriages.op_car_code, Operations_with_carriages.oper_car_type, Operations_with_carriages.oper_car_time
FROM Operations_with_carriages, Fixed_objects
WHERE Fixed_objects.id_parent = 530000 AND Operations_with_carriages.id_op_car_obj = Fixed_objects.id_obj
