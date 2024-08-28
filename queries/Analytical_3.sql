WITH bid_pairs AS (
    SELECT 
        c.model,
        b.user_id,
        b.date_bid AS first_bid_date,
        LEAD(b.date_bid) OVER (PARTITION BY c.model, b.user_id ORDER BY b.date_bid ASC) AS next_bid_date,
        b.bid_price AS first_bid_price,
        LEAD(b.bid_price) OVER (PARTITION BY c.model, b.user_id ORDER BY b.date_bid ASC) AS next_bid_price
    FROM bids b
    JOIN advertisements a ON b.ad_id = a.ad_id
    JOIN cars c ON a.car_id = c.car_id
    WHERE c.model = 'Camry'
)
SELECT *
FROM bid_pairs
WHERE next_bid_date IS NOT NULL;