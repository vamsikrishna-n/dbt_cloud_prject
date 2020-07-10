{% macro get_column_values(column_name,table_name) %}

{% set mfgrs_query %}
select distinct
{{column_name}}
from {{table_name}}
{% endset %}
{% set results = run_query(mfgrs_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}

{% macro get_mfgrs_list_method() %}
{{ return(get_column_values('p_mfgr',ref('party')))}}
{% endmacro %}