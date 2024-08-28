CREATE TABLE Locations (
    location_id SERIAL PRIMARY KEY,
    location_name VARCHAR(255) NOT NULL,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL
);

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact VARCHAR(255) NOT NULL,
    location_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

CREATE TABLE Cars (
    car_id SERIAL PRIMARY KEY,
    brand VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    color VARCHAR(50) NOT NULL,
    mileage INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE advertisements (
    ad_id SERIAL PRIMARY KEY,
    car_id INT NOT NULL REFERENCES cars(car_id),
    user_id INT NOT NULL REFERENCES users(user_id),
    location_id INT NOT NULL REFERENCES locations(location_id),
    date_posted DATE NOT NULL,
    allow_bidding BOOLEAN NOT NULL
);

CREATE TABLE Bids (
    bid_id SERIAL PRIMARY KEY,
    ad_id INT NOT NULL,
    user_id INT NOT NULL,
    date_bid DATE NOT NULL,
    bid_price DECIMAL(10, 2) NOT NULL,
    bid_status VARCHAR(50) NOT NULL,
    FOREIGN KEY (ad_id) REFERENCES Advertisements(ad_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);