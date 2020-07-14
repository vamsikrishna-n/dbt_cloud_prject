

select * from {{ref('orders')}}
where O_ORDERDATE > '{{var('proj_start_date')}}'