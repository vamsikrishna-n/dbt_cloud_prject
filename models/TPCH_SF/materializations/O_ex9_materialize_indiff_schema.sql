{{ config(schema='core')}}

with orders as
(
select * from {{ ref('orders') }}
)

select * from orders