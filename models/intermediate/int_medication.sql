with medications_base as (
    select
        m.id as medication_id
        , m.user_id as person_id
        , m.user_id as patient_id
        , m.start_date as dispensing_date
        , m.start_date as prescribing_date
        , m.code as source_code
        , route
        , 'Healthie' as data_source
    from {{ ref('stg_healthie_medication_type') }} as m
    inner join {{ ref('int_patient') }} as p
      on p.patient_id = m.user_id
)

select
      cast(medication_id as {{ dbt.type_string() }}) as medication_id
    , cast(person_id as {{ dbt.type_string() }}) as person_id
    , cast(patient_id as {{ dbt.type_string() }}) as patient_id
    , cast(null as {{ dbt.type_string() }}) as encounter_id
    , cast(dispensing_date as date) as dispensing_date
    , cast(prescribing_date as date) as prescribing_date
    , cast(null as {{ dbt.type_string() }}) as source_code_type
    , cast(source_code as {{ dbt.type_string() }}) as source_code
    , cast(null as {{ dbt.type_string() }}) as source_description
    , cast(null as {{ dbt.type_string() }}) as ndc_code
    , cast(null as {{ dbt.type_string() }}) as ndc_description
    , cast(null as {{ dbt.type_string() }}) as rxnorm_code
    , cast(null as {{ dbt.type_string() }}) as rxnorm_description
    , cast(null as {{ dbt.type_string() }}) as atc_code
    , cast(null as {{ dbt.type_string() }}) as atc_description
    , cast(route as {{ dbt.type_string() }}) as route
    , cast(null as {{ dbt.type_string() }}) as strength
    , cast(null as {{ dbt.type_int() }}) as quantity
    , cast(null as {{ dbt.type_string() }}) as quantity_unit
    , cast(null as {{ dbt.type_int() }}) as days_supply
    , cast(null as {{ dbt.type_string() }}) as practitioner_id
    , cast(data_source as {{ dbt.type_string() }}) as data_source
    , cast(null as {{ dbt.type_string() }}) as file_name
    , cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from medications_base
