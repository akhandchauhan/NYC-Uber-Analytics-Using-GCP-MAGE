--  How many trips were completed

SELECT COUNT(*) AS total_trips 
FROM taxi_trips;

-- What is the average fare and tip amount per trip

SELECT 
    AVG(fare_amount) AS avg_fare,
    AVG(tip_amount) AS avg_tip
FROM taxi_trips;

-- the busiest pickup locations

SELECT 
    pickup_longitude, 
    pickup_latitude, 
    COUNT(*) AS trip_count
FROM taxi_trips
GROUP BY pickup_longitude, pickup_latitude
ORDER BY trip_count DESC
LIMIT 10;

--  the most common payment method

SELECT 
    payment_type,
    COUNT(*) AS count
FROM taxi_trips
GROUP BY payment_type
ORDER BY count DESC;

--  total revenue for each VendorID

SELECT 
    VendorID, 
    SUM(total_amount) AS total_revenue
FROM taxi_trips
GROUP BY VendorID
ORDER BY total_revenue DESC;

-- the busiest time for rides

SELECT 
    HOUR(tpep_pickup_datetime) AS hour_of_day, 
    COUNT(*) AS trip_count
FROM taxi_trips
GROUP BY hour_of_day
ORDER BY trip_count DESC;

-- the longest trip by distance
SELECT * 
FROM taxi_trips 
ORDER BY trip_distance DESC 
LIMIT 1;


-- the distribution of trips by passenger count

SELECT 
    passenger_count, 
    COUNT(*) AS trip_count
FROM taxi_trips
GROUP BY passenger_count
ORDER BY trip_count DESC;

--  most common trip distance range

SELECT 
    CASE 
        WHEN trip_distance <= 2 THEN '0-2 miles'
        WHEN trip_distance <= 5 THEN '2-5 miles'
        WHEN trip_distance <= 10 THEN '5-10 miles'
        ELSE '10+ miles'
    END AS distance_range,
    COUNT(*) AS trip_count
FROM taxi_trips
GROUP BY distance_range
ORDER BY trip_count DESC;

-- the total revenue by payment type

SELECT 
    payment_type, 
    SUM(total_amount) AS total_revenue
FROM taxi_trips
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- Which pickup locations generate the highest revenue

SELECT 
    pickup_longitude, 
    pickup_latitude, 
    SUM(total_amount) AS total_revenue
FROM taxi_trips
GROUP BY pickup_longitude, pickup_latitude
ORDER BY total_revenue DESC
LIMIT 10;

-- percentage of trips that included tips

SELECT 
    (COUNT(CASE WHEN tip_amount > 0 THEN 1 END) / COUNT(*)) * 100 AS percentage_tipped
FROM taxi_trips;

--  the correlation between trip distance and fare amount
SELECT 
    trip_distance, 
    AVG(fare_amount) AS avg_fare
FROM taxi_trips
GROUP BY trip_distance
ORDER BY trip_distance ASC;


-- What is the longest-duration trip
SELECT *, 
    TIMESTAMPDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime) AS trip_duration
FROM taxi_trips
ORDER BY trip_duration DESC
LIMIT 1;

-- Identify Possible Fraudulent Rides (Zero Distance but High Fare)

SELECT * 
FROM taxi_trips
WHERE trip_distance = 0 
AND total_amount > 20
ORDER BY total_amount DESC;

--  Estimate Average Speed of Trips

SELECT *, 
    (trip_distance / (TIMESTAMPDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime) / 60)) AS avg_speed_mph
FROM taxi_trips
WHERE TIMESTAMPDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime) > 0
ORDER BY avg_speed_mph DESC;

-- the Most Profitable Hour for Drivers

SELECT 
    HOUR(tpep_pickup_datetime) AS hour_of_day, 
    SUM(total_amount) AS total_revenue,
    COUNT(*) AS trip_count,
    SUM(total_amount) / COUNT(*) AS avg_revenue_per_trip
FROM taxi_trips
GROUP BY hour_of_day
ORDER BY total_revenue DESC;

-- Identify Passengers Who Paid Unusually High Tips

SELECT *, 
    (tip_amount / fare_amount) * 100 AS tip_percentage
FROM taxi_trips
WHERE (tip_amount / fare_amount) * 100 > ( 
    SELECT AVG(tip_amount / fare_amount) * 100 + 3 * STDDEV(tip_amount / fare_amount) * 100 FROM taxi_trips
)
ORDER BY tip_percentage DESC;

-- Rank Drivers by Total Revenue

SELECT 
    VendorID, 
    SUM(total_amount) AS total_revenue, 
    DENSE_RANK() OVER (ORDER BY SUM(total_amount) DESC) AS revenue_rank
FROM taxi_trips
GROUP BY VendorID;

