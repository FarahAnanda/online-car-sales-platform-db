WITH bid_data AS (
    SELECT 
        c.brand, 
        c.model,
        ROUND(AVG(bid_price) FILTER (WHERE b.date_bid > CURRENT_DATE - INTERVAL '1 month'), 2) AS m_min_1,
        ROUND(AVG(bid_price) FILTER (WHERE b.date_bid > CURRENT_DATE - INTERVAL '2 months' AND b.date_bid <= CURRENT_DATE - INTERVAL '1 month'), 2) AS m_min_2,
        ROUND(AVG(bid_price) FILTER (WHERE b.date_bid > CURRENT_DATE - INTERVAL '3 months' AND b.date_bid <= CURRENT_DATE - INTERVAL '2 months'), 2) AS m_min_3,
        ROUND(AVG(bid_price) FILTER (WHERE b.date_bid > CURRENT_DATE - INTERVAL '4 months' AND b.date_bid <= CURRENT_DATE - INTERVAL '3 months'), 2) AS m_min_4,
        ROUND(AVG(bid_price) FILTER (WHERE b.date_bid > CURRENT_DATE - INTERVAL '5 months' AND b.date_bid <= CURRENT_DATE - INTERVAL '4 months'), 2) AS m_min_5,
        ROUND(AVG(bid_price) FILTER (WHERE b.date_bid > CURRENT_DATE - INTERVAL '6 months' AND b.date_bid <= CURRENT_DATE - INTERVAL '5 months'), 2) AS m_min_6
    FROM bids b
    JOIN advertisements a ON b.ad_id = a.ad_id
    JOIN cars c ON a.car_id = c.car_id
    GROUP BY c.brand, c.model
    HAVING COUNT(*) > 0
)
SELECT *
FROM bid_data
WHERE m_min_1 IS NOT NULL AND m_min_2 IS NOT NULL AND m_min_3 IS NOT NULL AND m_min_4 IS NOT NULL AND m_min_5 IS NOT NULL AND m_min_6 IS NOT NULL;