{% macro event_types_aggs(column_name) %}
    
{% set event_types = dbt_utils.get_query_results_as_dict("select DISTINCT event_type from " ~ ref('stg_events')) %}
        {% for each_event_type in event_types['event_type'] %}
       ,SUM(CASE WHEN {{column_name}} = '{{each_event_type}}' then 1 ELSE 0 end) as {{each_event_type}}_total
        {% endfor %}
{% endmacro %}