import pandas as pd
import numpy as np
import random
from faker import Faker
from datetime import timedelta

# Load the datasets
car_data = pd.read_csv('Car Data.csv')
us_cities = pd.read_csv('us-cities-top-1k.csv')

# Create a locations dataframe from us_cities
locations = us_cities[['City', 'lat', 'lon']].drop_duplicates().reset_index(drop=True)
locations['location_id'] = locations.index + 1

locations = locations[['location_id', 'City', 'lat', 'lon']]
locations = locations.rename(columns={'City': 'location_name', 'lat': 'latitude', 'lon': 'longitude'})

# Generate cars data
cars = car_data[['Car ID', 'Brand', 'Model', 'Year', 'Color', 'Mileage', 'Price']].copy()
cars.rename(columns={'Car ID': 'car_id'}, inplace=True)

# Merge `car_data` with `locations` to get `location_id`
car_data.rename(columns={'Location': 'location_name'}, inplace=True)
car_data_with_location_id = pd.merge(car_data, locations, on='location_name', how='left')

# Initialize Faker
fake = Faker()

# Generate location_id
num_users_car_location = 1000
car_locations = car_data_with_location_id['location_id'].sample(n=num_users_car_location, replace=True).tolist()

num_users_random_location = 500
random_locations = random.choices(locations['location_id'], k=num_users_random_location)

all_locations = car_locations + random_locations

# Generate users data
num_users = 1500
users_data = {
    'user_id': range(1, num_users + 1),
    'name': [fake.name() for _ in range(num_users)],
    'contact': [fake.email() for _ in range(num_users)],
    'location_id': all_locations
}

users = pd.DataFrame(users_data)

# Generate advertisements data
advertisements = pd.DataFrame({
    'ad_id': range(1, len(cars) + 1),
    'car_id': cars['car_id'],
    'user_id': [random.choice(users['user_id']) for _ in range(len(cars))],
    'location_id': car_data_with_location_id['location_id'],
    'date_posted': [fake.date_between(start_date='-1y', end_date='today') for _ in range(len(cars))],
    'allow_bidding': [random.choice([True, False]) for _ in range(len(cars))]
})

# Merge advertisements with cars to get the car price
ads_with_bidding = advertisements[advertisements['allow_bidding']].merge(
    cars[['car_id', 'Price']], on='car_id', how='left'
)

# Generate bids data
bids = []
bid_id_counter = 1

for ad in ads_with_bidding.itertuples():
    num_bids = random.randint(0, 10)
    last_bid_accepted = False
    
    for _ in range(num_bids):
        if last_bid_accepted:
            break
        
        bid_date = fake.date_between(start_date=ad.date_posted + timedelta(days=1), end_date='today')
        bid_price = int(ad.Price * random.uniform(0.8, 0.99))  # Bid price lower than the car price, cast to int
        bid_status = random.choice(['Accepted', 'Sent'])
        
        # Ensure user doesn't bid on their own ad
        bidder_id = random.choice([uid for uid in users['user_id'] if uid != ad.user_id])
        
        bids.append({
            'bid_id': bid_id_counter,
            'ad_id': ad.ad_id,
            'user_id': bidder_id,
            'date_bid': bid_date,
            'bid_price': bid_price,
            'bid_status': bid_status
        })
        
        if bid_status == 'Accepted':
            last_bid_accepted = True
        
        bid_id_counter += 1

bids_df = pd.DataFrame(bids)

# Save files
locations.to_csv('locations.csv', index=False)
users.to_csv('users.csv', index=False)
cars.to_csv('cars.csv', index=False)
advertisements.to_csv('advertisements.csv', index=False)
bids_df.to_csv('bids.csv', index=False)
