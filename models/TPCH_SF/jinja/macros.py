from jinja2 import Template

# Macros

template_string = ''' 
{% macro bool_eval(value) -%}
    {% if value -%}
        True
    {%- else -%}
        False
    {%- endif %}
{%- endmacro -%}

My one element list has bool value of: {{ bool_eval(my_list) }}
My one key dict has bool value of: {{ bool_eval(my_dict) }}
My short string has bool value of: {{ bool_eval(my_string) }}

My empty list has bool value of: {{ bool_eval(my_list_empty) }}
My empty dict has bool value of: {{ bool_eval(my_dict_empty) }}
My empty string has bool value of: {{ bool_eval(my_string_empty) }}
'''

data = {
    "my_list": [
        "list-element"
    ],
    "my_dict": {
        "my_key": "my_value"
    },
    "my_string": "example string",
    "my_list_empty": [],
    "my_dict_empty": {},
    "my_string_empty": ""
}

formated_query = Template(template_string).render(data)
print(formated_query)