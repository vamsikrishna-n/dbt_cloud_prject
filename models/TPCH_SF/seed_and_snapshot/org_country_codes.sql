select * from {{ref('country_codes')}}



{#
    Seeds are CSV files in your dbt project (typically in your data directory),
    that dbt can load into your data warehouse using the dbt seed command.

    dbt seed
    dbt seed --full-refresh
    dbt run --models country_codes+
    dbt seed --select country_codes

#}