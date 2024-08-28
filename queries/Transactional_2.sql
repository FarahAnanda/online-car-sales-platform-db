-- Insert a new bid with the next available bid_id
INSERT INTO bids (bid_id, ad_id, user_id, date_bid, bid_price, bid_status)
VALUES (
    (SELECT MAX(bid_id) + 1 FROM bids), 
    101, 
    20, 
    CURRENT_DATE, 
    55000, 
    'Sent'
);

-- View the updated bids table
SELECT * FROM bids WHERE ad_id = 101;