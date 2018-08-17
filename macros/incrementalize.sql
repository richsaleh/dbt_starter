{% macro incrementalize(this) -%}
    {%- if not execute -%}
        {{ return(False) }}
    {%- else -%}
        {{ return(adapter.already_exists(this.schema, this.table) and not flags.FULL_REFRESH) }}
    {% endif %}
{% endmacro %}
