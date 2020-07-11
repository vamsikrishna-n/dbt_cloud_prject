{{ config (materialized='table',
 schema = 'transformations')}}
with orders as
(
select * from {{ ref('orders') }}
)
select * from orders