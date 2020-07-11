{{ config(
        materialized='incremental' ,
        incremental_strategy='delete+insert' ,
        unique_key = 'o_orderkey'
) }}

with orders as (
    select * from {{ref('orders')}}  o order by o_orderkey
)

select * from orders
{%- if is_incremental() %}
    where o_orderkey > (select case when max(o_orderkey) IS NULL then 0 else max(o_orderkey) end from {{this}} )
    limit 100000
{% endif -%}

{#  --Commands
    Command for Incremental Load --> dbt run -m O_ex10_incremental_model
    Command for Full Load --> dbt run --full-refresh -m O_ex10_incremental_model

    -- Snowflake uses Merge as the default incremental_strategy, optionally we can change it to 'delete+insert'
    incremental_strategy='delete+insert'

    --SQL's verify the data from snowflake
    truncate table "DEMO_DB"."CLOUD_SCHEMA"."O_EX10_INCREMENTAL_MODEL";

    select count(*) from "DEMO_DB"."CLOUD_SCHEMA"."O_EX10_INCREMENTAL_MODEL";
    select O_ORDERKEY, count(*) from "DEMO_DB"."CLOUD_SCHEMA"."O_EX10_INCREMENTAL_MODEL" group by O_ORDERKEY having count(*) > 1;
    select max(O_ORDERKEY), min(O_ORDERKEY) from "DEMO_DB"."CLOUD_SCHEMA"."O_EX10_INCREMENTAL_MODEL";
#}
