-- Load data from CSV files into the corresponding tables

-- Locations
COPY Locations(location_id, location_name, latitude, longitude) 
FROM '/path/to/locations.csv' 
DELIMITER ',' 
CSV HEADER;

-- Users
COPY Users(user_id, name, contact, location_id) 
FROM '/path/to/users.csv' 
DELIMITER ',' 
CSV HEADER;

-- Cars
COPY Cars(car_id, brand, model, year, color, mileage, price) 
FROM '/path/to/cars.csv' 
DELIMITER ',' 
CSV HEADER;

-- Advertisements
COPY Advertisements(ad_id, car_id, user_id, location_id, date_posted, allow_bidding) 
FROM '/path/to/advertisements.csv' 
DELIMITER ',' 
CSV HEADER;

-- Bids
COPY Bids(bid_id, ad_id, user_id, date_bid, bid_price, bid_status) 
FROM '/path/to/bids.csv' 
DELIMITER ',' 
CSV HEADER;
