WITH RankedTrips AS (
    SELECT 
        dim_city.city_name,
       sum(fact_passenger_summary.new_passengers) as total_new_passengers,
        ROW_NUMBER() OVER (ORDER BY sum(fact_passenger_summary.new_passengers) DESC) AS rank_top,
        ROW_NUMBER() OVER (ORDER BY sum(fact_passenger_summary.new_passengers) ASC) AS rank_bottom
    FROM 
        trips_db.fact_passenger_summary
    JOIN 
        trips_db.dim_city 
    ON 
        fact_passenger_summary.city_id = dim_city.city_id
        group by dim_city.city_name
)
SELECT 
    city_name,
   total_new_passengers,
    CASE 
        WHEN rank_top <= 3 THEN 'Top 3'
        WHEN rank_bottom <= 3 THEN 'Bottom 3'
        ELSE NULL
    END AS category
FROM 
    RankedTrips
WHERE 
    rank_top <= 3 OR rank_bottom <= 3
ORDER BY 
    city_name, category asc;
