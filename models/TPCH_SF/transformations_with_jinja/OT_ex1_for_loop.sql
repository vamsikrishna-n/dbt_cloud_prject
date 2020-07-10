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
( select distinct
{% for mfgr in ['Manufacturer#1','Manufacturer#2','Manufacturer#3','Manufacturer#4','Manufacturer#5'] %}
sum(case when p_mfgr = '{{mfgr}}' then o_totalprice end) over (partition by  extract(year,o_orderdate)) as  "{{mfgr}}_Amount",
count(case when p_mfgr = '{{mfgr}}' then o_totalprice end) over (partition by  extract(year,o_orderdate)) as  "{{mfgr}}_count",
{% endfor %}
extract(year,o.o_orderdate) as year
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