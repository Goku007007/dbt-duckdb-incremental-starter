
  
  create view "portfolio"."main"."stg_orders__dbt_tmp" as (
    select
  order_id,
  customer_id,
  cast(order_date as date) as order_date,
  cast(total_amount as double) as total_amount,
  _loaded_at
from "portfolio"."main_raw"."orders"
  );
