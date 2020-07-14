
select * from {{ref('nation')}}
where N_NAME = '{{var("nation")}}'