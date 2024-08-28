SELECT c.model,
       COUNT(a.ad_id) AS count_product,
       COUNT(b.bid_id) AS count_bid
FROM cars c
JOIN advertisements a ON c.car_id = a.car_id
LEFT JOIN bids b ON a.ad_id = b.ad_id
GROUP BY c.model
ORDER BY count_bid DESC
LIMIT 10;