{% macro n_days_ago(n) %}dateadd('day', {{ n }}, {{ local_time() }} ){% endmacro %}
