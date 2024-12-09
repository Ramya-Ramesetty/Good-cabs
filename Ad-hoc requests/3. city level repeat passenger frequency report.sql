SELECT 	dim_city.city_name,
    ROUND(SUM(CASE WHEN trip_count = '2-Trips' THEN repeat_passenger_count else 0 END) / sum(repeat_passenger_count) * 100, 2)  AS '2-Trips',
    ROUND(SUM(CASE WHEN trip_count = '3-Trips' THEN repeat_passenger_count else 0 END) / sum(repeat_passenger_count) * 100, 2)  AS '3-Trips',
    ROUND(SUM(CASE WHEN trip_count = '4-Trips' THEN repeat_passenger_count else 0 END) / sum(repeat_passenger_count) * 100, 2)  AS '4-Trips',
    ROUND(SUM(CASE WHEN trip_count = '5-Trips' THEN repeat_passenger_count else 0 END) / sum(repeat_passenger_count) * 100, 2)  AS '5-Trips',
    ROUND(SUM(CASE WHEN trip_count = '6-Trips' THEN repeat_passenger_count else 0 END) / sum(repeat_passenger_count) * 100, 2)  AS '6-Trips',
    ROUND(SUM(CASE WHEN trip_count = '7-Trips' THEN repeat_passenger_count else 0 END) / sum(repeat_passenger_count) * 100, 2)  AS '7-Trips',
    ROUND(SUM(CASE WHEN trip_count = '8-Trips' THEN repeat_passenger_count else 0 END) / sum(repeat_passenger_count) * 100, 2)  AS '8-Trips',
    ROUND(SUM(CASE WHEN trip_count = '9-Trips' THEN repeat_passenger_count else 0 END) / sum(repeat_passenger_count) * 100, 2)  AS '9-Trips',
    ROUND(SUM(CASE WHEN trip_count = '10-Trips' THEN repeat_passenger_count else 0 END) / sum(repeat_passenger_count) * 100, 2)  AS '10-Trips'
FROM 
    trips_db.dim_repeat_trip_distribution trips
JOIN trips_db.dim_city 
 on
 dim_city.city_id = trips.city_id
GROUP BY 
    dim_city.city_name;