WITH ranked_cars AS (
    SELECT 
        l.location_name, 
        c.brand, 
        c.model, 
        c.year, 
        c.price, 
        ROUND(AVG(c.price) OVER (PARTITION BY l.location_name), 2) AS avg_car_city,
        ROW_NUMBER() OVER (PARTITION BY l.location_name ORDER BY RANDOM()) AS rank
    FROM cars c
    JOIN advertisements a ON c.car_id = a.car_id
    JOIN locations l ON a.location_id = l.location_id
)
SELECT location_name, brand, model, year, price, avg_car_city
FROM ranked_cars
WHERE rank <= 2
ORDER BY location_name;