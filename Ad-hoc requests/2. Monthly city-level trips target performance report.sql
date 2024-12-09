SELECT 
    Actual.city_name,
    Actual.actual_trips,
    -- dim_date.month_name,
    Target.target_trips,
    CASE 
        WHEN Actual.actual_trips > Target.target_trips THEN 'Above Target'
        ELSE 'Below Target'
    END AS performance_status,
    ROUND(((Actual.actual_trips - Target.target_trips) * 100.0 / Target.target_trips), 2) AS percentage_difference
FROM 
    -- Subquery for Actual Trips aggregated at the city and month level
    (
        SELECT 
            dim_city.city_id,
            dim_city.city_name,
            COUNT(fact_trips.trip_id) AS actual_trips
        FROM 
            trips_db.fact_trips
        JOIN 
            trips_db.dim_city ON fact_trips.city_id = dim_city.city_id
	
        GROUP BY 
            dim_city.city_id, dim_city.city_name
    ) AS Actual
JOIN 
    -- Subquery for Target Trips aggregated at the city and month level
    (
        SELECT 
            monthly_target_trips.city_id,
            SUM(monthly_target_trips.total_target_trips) AS target_trips
        FROM 
            targets_db.monthly_target_trips
        
        GROUP BY 
            monthly_target_trips.city_id
    ) AS Target
ON 
    Actual.city_id = Target.city_id