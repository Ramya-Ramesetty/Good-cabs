-- 6th query
select * from trips_db.fact_passenger_summary;
select * from trips_db.dim_city;
select * from trips_db.dim_date;
-- 1.monthly repeat passenger rate
select 
  city_name, 
  fact_passenger_summary.month, fact_passenger_summary.total_passengers,fact_passenger_summary.repeat_passengers,
  (repeat_passengers/total_passengers)*100 as repeat_passenger_rate 
from  
  trips_db.fact_passenger_summary
join 
  trips_db.dim_city 
on 
  fact_passenger_summary.city_id = dim_city.city_id; 
-- 2. city-level repeat passenger rate
select
 dim_city.city_name, DATE_FORMAT(fact_passenger_summary.month, '%M') AS month_name,
 fact_passenger_summary.month, 
sum(fact_passenger_summary.total_passengers) as total_passengers, 
sum(fact_passenger_summary.repeat_passengers) as repeat_passengers,
ROUND((SUM(fact_passenger_summary.repeat_passengers) / SUM(fact_passenger_summary.total_passengers)) * 100, 2) as repeat_passenger_rate
from 
 trips_db.fact_passenger_summary
join
  trips_db.dim_city 
on 
  fact_passenger_summary.city_id = dim_city.city_id
group by
  dim_city.city_name, fact_passenger_summary.month
ORDER BY 
  dim_city.city_name, fact_passenger_summary.month;
    
    
    