{{config (materilized='view') }}

with region as
(
select * from {{ ref('region') }}
)
, nation as
(
select * from {{ ref('nation') }}
)
, customer as
(
select * from {{ ref('customer') }}
)
, orders as
(
select * from {{ ref('orders') }}
)
, orders_by_region as
(
select
    region.r_name,
    count(*)
from
region left join nation
  on region.r_regionkey = nation.n_regionkey
left join customer
  on nation.n_nationkey = customer.c_nationkey
left join orders
  on customer.c_custkey = orders.o_custkey
group by region.r_name

)

select * from orders_by_region



