SELECT a.ad_id, c.brand, c.model, c.year, c.price, 
    ROUND(CAST(SQRT(POWER(l.latitude - loc.latitude, 2) + POWER(l.longitude - loc.longitude, 2)) AS NUMERIC), 2) AS distance
FROM advertisements a
JOIN cars c ON a.car_id = c.car_id
JOIN locations l ON a.location_id = l.location_id
JOIN locations loc ON loc.location_name = 'New Orleans'
ORDER BY distance ASC, c.price ASC
LIMIT 10;