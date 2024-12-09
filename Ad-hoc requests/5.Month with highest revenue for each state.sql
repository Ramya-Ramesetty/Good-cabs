
WITH City_Monthly_Revenue AS (
    SELECT 
        dim_city.city_name,
        DATE_FORMAT(fact_trips.date, '%M') AS month_name,
        SUM(fact_trips.fare_amount) AS monthly_revenue
    FROM 
        trips_db.fact_trips
    JOIN 
        trips_db.dim_city ON fact_trips.city_id = dim_city.city_id
	GROUP BY 
        dim_city.city_name, DATE_FORMAT(fact_trips.date, '%M')
),
City_Total_Revenue AS (
    SELECT 
        city_name,
        SUM(monthly_revenue) AS total_revenue
    FROM 
        City_Monthly_Revenue
    GROUP BY 
        city_name
),
City_Max_Revenue AS (
    SELECT 
        cmr.city_name,
        cmr.month_name AS highest_revenue_month,
        cmr.monthly_revenue AS revenue,
        ctr.total_revenue,
        ROUND((cmr.monthly_revenue * 100.0 / ctr.total_revenue), 2) AS percentage_contribution
    FROM 
        City_Monthly_Revenue cmr
    JOIN 
        City_Total_Revenue ctr ON cmr.city_name = ctr.city_name
    WHERE 
        cmr.monthly_revenue = (
            SELECT 
                MAX(monthly_revenue)
            FROM 
                City_Monthly_Revenue
            WHERE 
                city_name = cmr.city_name
        )
)
SELECT 
    city_name,
    highest_revenue_month,
    revenue,
    percentage_contribution
FROM 
    City_Max_Revenue
ORDER BY 
    city_name;
    
