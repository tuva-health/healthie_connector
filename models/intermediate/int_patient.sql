with mapped_data as (
    select
        id as person_id
        , id as patient_id
        , first_name
        , last_name
        , case when sex = 'Male' then 'male' 
               when sex = 'Female' then 'female'
               else 'unknown' end as sex
        , dob as birth_date
        , ssn as social_security_number
        , phone_number as phone
    from {{ ref('stg_healthie_user') }}
    where not coalesce(is_provider)
)

select
      cast(person_id as {{ dbt.type_string() }}) as person_id
    , cast(patient_id as {{ dbt.type_string() }}) as patient_id
    , cast(first_name as {{ dbt.type_string() }}) as first_name
    , cast(last_name as {{ dbt.type_string() }}) as last_name
    , cast(sex as {{ dbt.type_string() }}) as sex
    , cast(null as {{ dbt.type_string() }}) as race
    , cast(birth_date as date) as birth_date
    , cast(null as date) as death_date
    , cast(null as {{ dbt.type_int() }}) as death_flag
    , cast(social_security_number as {{ dbt.type_string() }}) as social_security_number
    , cast(null as {{ dbt.type_string() }}) as address
    , cast(null as {{ dbt.type_string() }}) as city
    , cast(null as {{ dbt.type_string() }}) as state
    , cast(null as {{ dbt.type_string() }}) as zip_code
    , cast(null as {{ dbt.type_string() }}) as county
    , cast(null as {{ dbt.type_float() }}) as latitude
    , cast(null as {{ dbt.type_float() }}) as longitude
    , cast(phone as {{ dbt.type_string() }}) as phone
    , cast(data_source as {{ dbt.type_string() }}) as data_source
    , cast(null as {{ dbt.type_string() }}) as file_name
    , cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from mapped_data
