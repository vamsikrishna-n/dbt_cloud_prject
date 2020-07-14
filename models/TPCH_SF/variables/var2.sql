
select * from {{ref('nation')}}
where N_NAME in {{var("asia")}}