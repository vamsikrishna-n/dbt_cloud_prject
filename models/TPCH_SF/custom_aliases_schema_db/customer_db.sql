{{ config (
    database = 'DEMO_TEST_DB',
    alias = 'INDIAN_CUSTOMERS',
    schema = 'core'
    ) }}

select * from {{ ref('customer')}}
where C_NATIONKEY in ( select N_NATIONKEY from {{ref('nation')}} where N_NAME = 'INDIA')
