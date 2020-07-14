from jinja2 import Template

# variables example

template_string = """ 
--Using variables 
SELECT {{COLUMNS_LIST}} FROM {{TABLE}};
"""
data = { "TABLE" : "ORDERS",
"COLUMNS_LIST": "*",
}

formated_query = Template(template_string).render(data)
print(formated_query)

# for loop with list

template_string = """ 
--Using for loop with list
SELECT 
{% for col in COLUMNS_LIST -%}
{{col}},
{%- endfor %} 
FROM {{TABLE}}
"""

data = { "TABLE" : "ORDERS",
"COLUMNS_LIST": ['col1','col2','col3','col4','col5']
}

formated_query = Template(template_string).render(data)
print(formated_query)

# for loop with dictionary

template_string = """ 
--Using for loop with dicitionary
SELECT 
{% for k,v in COLUMNS_LIST.items() -%}
{{v}},
{%- endfor %} 
FROM {{TABLE}}
"""

data = { "TABLE" : "ORDERS",
"COLUMNS_LIST": {'k1':'col1','k2':'col2','k3':'col3','k4':'col4','k5':'col5'}
}

formated_query = Template(template_string).render(data)
print(formated_query)

# conditions with IF

template_string = """ 
--Using If condition
SELECT 
{% for col in COLUMNS_LIST -%}
{{col}} {% if not loop.last %},{% endif %}
{%- endfor %} 
FROM {{TABLE}}
"""

data = { "TABLE" : "ORDERS",
"COLUMNS_LIST": ['col1','col2','col3','col4','col5']
}

formated_query = Template(template_string).render(data)
print(formated_query)

# Conditions with IF
# and comparisons operators ==, !=, >, >=, <, <=
# Logical operators AND, OR , NOT

template_string = """ 
--Using If condition and comparisons operators
SELECT 
{% for col in COLUMNS_LIST -%}
    {{col}} 
    {%- if not loop.last %},{% endif %}
{%- endfor %} 
FROM {{TABLE}}
{%- if CONDITION1 >= 100 %}
    WHERE {{COLUMNS_LIST.2}} = 100
        {% if not CONDITION2 %}
        and {{COLUMNS_LIST.4}} IS NOTNULL
        {% elif CONDITION3 == 'Fail'  %}
        and order_status = 'successful'
        {% else %}
        and order_status = 'New'
        {%- endif %}
{% endif %}
"""

data = { "TABLE" : "ORDERS",
"COLUMNS_LIST": ['col1','col2','col3','col4','col5'],
"CONDITION1" : 100,
"CONDITION2" : True,
"CONDITION3" : 'Fail'
}

formated_query = Template(template_string).render(data)
print(formated_query)


# Using Filters

data = { "TABLE" : "ORDERS",
"COLUMNS_LIST": ['col1','col2','col3','col4','col5'],
"CONDITION1" : 100,
"CONDITION2" : True,
"CONDITION3" : 'Fails'
}

template_string = """ 
--Using If condition and comparisons operators
SELECT 
{% for col in COLUMNS_LIST -%}
    {{col|upper}} 
    {{col|upper}} 
    {%- if not loop.last %},{% endif %}
{%- endfor %} 
FROM {{TABLE}}
{%- if CONDITION1 >= 100 %}
    WHERE {{COLUMNS_LIST.2}} = 100
        {%- if not CONDITION2 %}
        and {{COLUMNS_LIST.4}} IS NOTNULL
        {%- elif CONDITION3 == 'Fail'  %}
        and order_status = 'successful'
        {% else %}
        {%- filter upper %}
        and order_status = 'new'
        {% endfilter %}
        {%- endif %}
{% endif %}
"""

formated_query = Template(template_string).render(data)
print(formated_query)


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
My intiger string has bool value of : {{ bool_eval(my_int) }}
My zero string has bool value of : {{ bool_eval(my_int) }}

My empty list has bool value of: {{ bool_eval(my_list_empty) }}
My empty dict has bool value of: {{ bool_eval(my_dict_empty) }}
My empty string has bool value of: {{ bool_eval(my_string_empty) }}
My None element has bool value of : {{ bool_eval(None_value) }}
'''

data = {    "my_list": ["list-element"],
            "my_dict": {"my_key": "my_value"},
            "my_string": "example string",
            "my_int" : 123 ,
            "my_list_empty": [],
            "my_dict_empty": {},
            "my_string_empty": "",
            "zero_int" : 0 ,
            "None_value" : None
}

formated_query = Template(template_string).render(data)
print(formated_query)

####################
# Test with IS
####################
# boolean - check is variable is a boolean
# integer - check if variable is an integer
# float - check if variable is a float
# number - check if variable is number, will return True for both integer and float
# string - check if variable is a string
# mapping - check if variable is a mapping, i.e. dictionary
# iterable - check if variable can be iterated over, will match string, list, dict, etc.
# sequence - check if variable is a sequence


template_string = ''' 
{{my_bool}} is string--> {{my_bool is  boolean}}

{{my_list}} is iterable--> {{my_list is  iterable}}
{{my_list}} is sequence--> {{my_list is  sequence}}

{{my_dict}} is mapping--> {{my_dict is  mapping}}

{{my_string}} is string--> {{my_string is  string}}
{{my_string}} is sequence--> {{my_string is  sequence}}

{{my_int}} is integer--> {{my_int is  integer}}
{{my_int}} is number--> {{my_int is  number}}
{{my_int}} is sequence--> {{my_int is  sequence}}
{{my_float}} is string--> {{my_float is  float}}
'''

data = {    "my_bool" : True,
            "my_list": ["list-element"],
            "my_dict": {"my_key": "my_value"},
            "my_string": "example string",
            "my_int" : 123 ,
            "my_float" : 123.5,
            "None_value" : None
}

formated_query = Template(template_string).render(data)
print(formated_query)


# Escaping

data = { "TABLE" : "ORDERS",
"COLUMNS_LIST": ['col1','col2','col3','col4','col5'],
"CONDITION1" : 100,
"CONDITION2" : True,
"CONDITION3" : 'Fails'
}

template_string = """ 
--Using If condition and comparisons operators
{% raw %}
SELECT 
{% for col in COLUMNS_LIST -%}
    {{col|upper}} 
    {{col|upper}} 
    {%- if not loop.last %},{% endif %}
{%- endfor %} 
FROM {{TABLE}}
{% endraw %}
"""

formated_query = Template(template_string).render(data)
print(formated_query)

# Template inheritance
template_string = """ 
{% block base1 %}Index{% endblock %}
"""

formated_query = Template(template_string).render()
print(formated_query)






### Some use full links ###
#   https://changhsinlee.com/pyderpuffgirls-ep5/
#   https://ttl255.com/jinja2-tutorial-part-1-introduction-and-variable-substitution/
#   https://overiq.com/flask-101/basics-of-jinja-template-language/

