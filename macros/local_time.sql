{%- macro local_time(column) -%}convert_timezone('America/Los_Angeles', {{ column }} ){%- endmacro -%}
