with location_base as (
    select
        id as location_id
        , npi
        , location_name as name
        , line1 as address
        , city
        , location_state as state
        , zip as zip_code
        , 'Healthie' as data_source
    from {{ ref('stg_healthie_location') }}
)

select
      cast(location_id as {{ dbt.type_string() }}) as location_id
    , cast(npi as {{ dbt.type_string() }}) as npi
    , cast(name as {{ dbt.type_string() }}) as name
    , cast(null as {{ dbt.type_string() }}) as facility_type
    , cast(null as {{ dbt.type_string() }}) as parent_organization
    , cast(address as {{ dbt.type_string() }}) as address
    , cast(city as {{ dbt.type_string() }}) as city
    , cast(state as {{ dbt.type_string() }}) as state
    , cast(zip_code as {{ dbt.type_string() }}) as zip_code
    , cast(null as {{ dbt.type_float() }}) as latitude
    , cast(null as {{ dbt.type_float() }}) as longitude
    , cast(data_source as {{ dbt.type_string() }}) as data_source
    , cast(null as {{ dbt.type_string() }}) as file_name
    , cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from location_base
