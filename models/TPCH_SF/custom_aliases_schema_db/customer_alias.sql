{{ config (
    alias = 'INDIAN_CUSTOMERS'
    ) }}

select * from {{ ref('customer')}}
where C_NATIONKEY in ( select N_NATIONKEY from {{ref('nation')}} where N_NAME = 'INDIA')
