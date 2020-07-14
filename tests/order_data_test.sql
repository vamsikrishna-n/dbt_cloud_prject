select
O_ORDERKEY,
sum(O_TOTALPRICE) as Total
from {{ref('orders')}}
group by 1
having not (Total >= 0)

{# -- comments
    test
        - data test --> A data test is a select statement that returns 0 records when the test is successful.
        - schema test -->  (unique, not_null, accepted_values, relationships) -- defined in .yml file

    severity - warn or error - defined using config block and .yml file

    # run tests for one_specific_model
    dbt test --models one_specific_model

    # run tests for all models in package
    dbt test --models some_package.*

    # run only custom data tests
    dbt test --data

    # run only schema tests
    dbt test --schema

    # run custom data tests for one_specific_model
    dbt test --data --models one_specific_model

    # run schema tests for one_specific_model
    dbt test --schema --models one_specific_model

#}

