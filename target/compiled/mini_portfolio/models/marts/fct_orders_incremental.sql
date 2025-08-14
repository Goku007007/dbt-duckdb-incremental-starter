

select
  o.order_id,
  o.customer_id,
  o.order_date,
  o.total_amount,
  c.customer_name,
  o._loaded_at
from "portfolio"."main"."stg_orders" o
left join "portfolio"."main_raw"."customers" c
  on c.customer_id = o.customer_id


where o._loaded_at > (
  select coalesce(max(_loaded_at), '1900-01-01') from "portfolio"."main"."fct_orders_incremental"
)
