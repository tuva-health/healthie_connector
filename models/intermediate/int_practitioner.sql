with mapped_data as (
  select
    id as practitioner_id
    , npi
    , first_name
    , last_name
    , 'Healthie' as data_source
  from {{ ref('stg_healthie_user') }}
  where is_provider
)

select {% if target.type == 'fabric' %} top 0 {% else %}{% endif %}
      cast(practitioner_id as {{ dbt.type_string() }}) as practitioner_id
    , cast(npi as {{ dbt.type_string() }}) as npi
    , cast(first_name as {{ dbt.type_string() }}) as first_name
    , cast(last_name as {{ dbt.type_string() }}) as last_name
    , cast(null as {{ dbt.type_string() }}) as practice_affiliation
    , cast(null as {{ dbt.type_string() }}) as specialty
    , cast(null as {{ dbt.type_string() }}) as sub_specialty
    , cast(data_source as {{ dbt.type_string() }}) as data_source
    , cast(null as {{ dbt.type_string() }}) as file_name
    , cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from mapped_data
