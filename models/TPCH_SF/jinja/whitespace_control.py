from jinja2 import Template


# variables example

template_string = """ 
(1) without trim or strip
Line1
        {% if something %}
            Line2
        {% endif %}
Line3
"""

data = { "something" : True}
formated_query = Template(template_string).render(data)
print(formated_query)

template_string = """ 
(2) added minus sign (-) to the start of the block
Line1
        {% if something -%}
            Line2
        {%- endif %}
Line3
"""

data = { "something" : True}
formated_query = Template(template_string).render(data)
print(formated_query)

template_string = """ 
(3) added minus sign (-) to the end of the block
Line1
        {% if something -%}
            Line2
        {% endif -%}
Line3
"""

data = { "something" : True}
formated_query = Template(template_string).render(data)
print(formated_query)

template_string = """ 
(4) Enable trim_blocks and lstrip_blocks 
Line1
        {% if something %}
            Line2
        {% endif %}
Line3
"""

data = { "something" : True}
formated_query = Template(template_string,trim_blocks= True,lstrip_blocks=True).render(data)
print(formated_query)

#   Whitespace control - trim_blocks and lstrip_blocks
#
#   You can also strip whitespace in templates by adding a minus sign (-) to the start or end of a block
#   (e.g. a For tag)a comment, or a variable expression, the whitespaces before or after that block will be removed
#
#   trim_blocks:
#       If this is set to True the first newline after a block is removed (block, not variable tag!). Defaults to False.
#
#   lstrip_blocks:
#       If this is set to True leading spaces and tabs are stripped from the start of a line to a block. Defaults to False.
