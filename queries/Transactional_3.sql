SELECT a.ad_id, c.brand, c.model, c.year, c.price, a.date_posted
FROM advertisements a
JOIN cars c ON a.car_id = c.car_id
WHERE a.user_id = 2
ORDER BY a.date_posted DESC;