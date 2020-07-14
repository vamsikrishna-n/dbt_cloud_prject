{% snapshot orders_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='order_id',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from {{ ref('orders_data')}}

{% endsnapshot %}

{#
    snapshot implement SCD Type 2 over multiple source tables.
    In dbt, snapshots are select statements, defined within a snapshot block in a .sql file.
        snapshots requiers follow to implement
            1. unique_key - A primary key column or expression for the record
            2. strategy - dbt uses two snapshot strategys
                    - timestamp - uses updated_at field. A column which represents when the source row was last updated
                    - check - uses check_cols fields. A list of columns to check for changes, or all to check all columns
            3. target_schema - The schema that dbt should render the snapshot table into
                Snapshots cannot be rebuilt.
                As such, its a good idea to put snapshots in a separate schema so end users know they are special.

        snapshot meta-fields
            along with source data set, snapshot tables will be added with additional metafields.
                dbt_valid_from - The timestamp when this snapshot row was first inserted
                dbt_valid_to - The timestamp when this row row became invalidated.
                dbt_scd_id - A unique key generated for each snapshotted record.
                dbt_updated_at - The updated_at timestamp of the source record when this snapshot row was inserted.

    snapshot can be configred from dbt_project.yml and config block

    -commands

        dbt snapshot
        dbt snapshot --select order_snapshot

    - downsides of snapshot
        - SCD type2 - (versioning and flag) need to be configured separately
        - SCD type1 and type 3 - no info
        - deleted records - snapshots do not invalidate records which are deleted from source system.

#}