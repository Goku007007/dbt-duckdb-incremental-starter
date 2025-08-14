{{ config(materialized='incremental', unique_key='order_id') }}

select
  o.order_id,
  o.customer_id,
  o.order_date,
  o.total_amount,
  c.customer_name,
  o._loaded_at
from {{ ref('stg_orders') }} o
left join {{ source('raw','customers') }} c
  on c.customer_id = o.customer_id

{% if is_incremental() %}
where o._loaded_at > (
  select coalesce(max(_loaded_at), '1900-01-01') from {{ this }}
)
{% endif %}
