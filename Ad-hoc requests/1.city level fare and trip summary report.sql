SELECT 
    dim_city.city_name,
    COUNT(fact_trips.trip_id) AS total_trips,
     SUM(fare_amount) / SUM(distance_travelled_km) AS average_fare_per_km,
     SUM(fare_amount) / COUNT(trip_id) AS average_fare_per_trip,
    round((COUNT(fact_trips.trip_id) * 100) / SUM(COUNT(fact_trips.trip_id)) OVER (),2) AS percent_contribution_to_total_trips
FROM 
    trips_db.fact_trips
JOIN 
    trips_db.dim_city 
ON 
    fact_trips.city_id = dim_city.city_id
GROUP BY 
    dim_city.city_name;