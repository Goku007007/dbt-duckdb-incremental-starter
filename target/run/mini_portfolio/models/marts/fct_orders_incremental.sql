
        
            delete from "portfolio"."main"."fct_orders_incremental"
            where (
                order_id) in (
                select (order_id)
                from "fct_orders_incremental__dbt_tmp20250814121008294522"
            );

        
    

    insert into "portfolio"."main"."fct_orders_incremental" ("order_id", "customer_id", "order_date", "total_amount", "customer_name", "_loaded_at")
    (
        select "order_id", "customer_id", "order_date", "total_amount", "customer_name", "_loaded_at"
        from "fct_orders_incremental__dbt_tmp20250814121008294522"
    )
  