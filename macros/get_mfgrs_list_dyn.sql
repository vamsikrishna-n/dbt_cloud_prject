{% macro get_mfgrs_list_dyn() %}
{% set mfgrs_query %}
select distinct
p_mfgr
from {{ref('party')}}
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