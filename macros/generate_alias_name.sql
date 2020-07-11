{% macro generate_alias_name(custom_alias_name=none, node=none) -%}

    {%- if custom_alias_name is none -%}

        {{ node.name }}

    {%- else -%}

       {{'S'}}_{{ custom_alias_name | trim }}

    {%- endif -%}

{%- endmacro %}


{# --default implementation of generate_alias_name macro
    {% macro generate_alias_name(custom_alias_name=none, node=none) -%}

        {%- if custom_alias_name is none -%}

            {{ node.name }}

        {%- else -%}

            {{ custom_alias_name | trim }}

        {%- endif -%}

    {%- endmacro %}



#}