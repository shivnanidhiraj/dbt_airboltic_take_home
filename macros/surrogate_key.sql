-- created the macro to generate surrogate key

{% macro generate_surrogate_key(columns) %}
    md5(concat({{ columns | join('::text, ') }}::text))
{% endmacro %}
