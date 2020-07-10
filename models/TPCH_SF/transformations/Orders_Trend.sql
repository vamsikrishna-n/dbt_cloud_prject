with orders as
(
select * from {{ ref('orders') }}
)
, lineitem as (
select * from {{ ref('lineitem') }}
)
, partsupp as (
select * from {{ ref('partsupp') }}
)
, party as (
select * from {{ ref('party') }}
)
, orders_trend as 
(
select distinct 
extract(year,o.o_orderdate) as year,
count(case when p_mfgr = 'Manufacturer#1' then o_totalprice end) over (partition by  extract(year,o_orderdate)) as  "Manufacturer#1_orders",
count(case when p_mfgr = 'Manufacturer#2' then o_totalprice end) over (partition by  extract(year,o_orderdate)) as  "Manufacturer#2_orders",
count(case when p_mfgr = 'Manufacturer#3' then o_totalprice end) over (partition by  extract(year,o_orderdate)) as  "Manufacturer#3_orders",
count(case when p_mfgr = 'Manufacturer#4' then o_totalprice end) over (partition by  extract(year,o_orderdate)) as  "Manufacturer#4_orders",
count(case when p_mfgr = 'Manufacturer#5' then o_totalprice end) over (partition by  extract(year,o_orderdate)) as  "Manufacturer#5_orders",
sum(case when p_mfgr = 'Manufacturer#1' then o_totalprice end) over (partition by  extract(year,o_orderdate)) as  "Manufacturer#1_Amount",
sum(case when p_mfgr = 'Manufacturer#2' then o_totalprice end) over (partition by  extract(year,o_orderdate)) as  "Manufacturer#2_Amount",
sum(case when p_mfgr = 'Manufacturer#3' then o_totalprice end) over (partition by  extract(year,o_orderdate)) as  "Manufacturer#3_Amount",
sum(case when p_mfgr = 'Manufacturer#4' then o_totalprice end) over (partition by  extract(year,o_orderdate)) as  "Manufacturer#4_Amount",
sum(case when p_mfgr = 'Manufacturer#5' then o_totalprice end) over (partition by  extract(year,o_orderdate)) as  "Manufacturer#5_Amount"
from orders o
left join lineitem l
on o.o_orderkey = l.l_orderkey
left join partsupp ps
on l.l_partkey = ps.ps_partkey and l.l_suppkey = ps.ps_suppkey
left join party p
on ps.ps_partkey = p.p_partkey
order by 1
)

select * from orders_trend