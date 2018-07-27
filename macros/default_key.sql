{%- macro default_key() -%}{{ dbt_utils.surrogate_key('-1001') }}{%- endmacro -%}
