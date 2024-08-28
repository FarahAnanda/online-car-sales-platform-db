SELECT car_id, brand, model, year, price
FROM cars
WHERE model LIKE '%Yaris%'
ORDER BY price ASC
LIMIT 10;