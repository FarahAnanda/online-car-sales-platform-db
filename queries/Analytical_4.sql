WITH avg_prices AS (
    SELECT 
        c.model, 
        ROUND(AVG(c.price), 2) AS avg_price,
        ROUND(AVG(b.bid_price) FILTER (WHERE b.date_bid > CURRENT_DATE - INTERVAL '6 months'), 2) AS avg_bid_6month
    FROM cars c
    JOIN advertisements a ON c.car_id = a.car_id
    LEFT JOIN bids b ON a.ad_id = b.ad_id
    WHERE b.bid_price IS NOT NULL AND b.date_bid > CURRENT_DATE - INTERVAL '6 months'
    GROUP BY c.model
)
SELECT 
    model, 
    avg_price, 
    avg_bid_6month, 
    ROUND(avg_price - avg_bid_6month, 2) AS difference,
    ROUND((avg_price - avg_bid_6month) / avg_price * 100, 2) AS difference_percent
FROM avg_prices;