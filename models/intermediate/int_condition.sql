with mapped_data as (
    select
        id as condition_id
        , user_id as person_id
        , user_id as patient_id
        , updated_at as recorded_date
        , first_symptom_date as onset_date
        , end_date as resolved_date
        , case when active then 'active'
               when not active then 'inactive'
            end as status
        , 'clinical diagnosis' as condition_type
        , 'icd-10-cm' as source_code_type
        , source_code as icd_code
        , display_name as source_description
        , case when primary then 1 else null end as condition_rank
        , 'Healthie' as data_source
    from {{ ref('stg_healthie_diagnosis') }}
)

select
      cast(condition_id as {{ dbt.type_string() }}) as condition_id
    , cast(person_id as {{ dbt.type_string() }}) as person_id
    , cast(patient_id as {{ dbt.type_string() }}) as patient_id
    , cast(null as {{ dbt.type_string() }}) as encounter_id
    , cast(null as {{ dbt.type_string() }}) as claim_id
    , cast(recorded_date as date) as recorded_date
    , cast(onset_date as date) as onset_date
    , cast(resolved_date as date) as resolved_date
    , cast(status as {{ dbt.type_string() }}) as status
    , cast(condition_type as {{ dbt.type_string() }}) as condition_type
    , cast(source_code_type as {{ dbt.type_string() }}) as source_code_type
    , cast(source_code as {{ dbt.type_string() }}) as source_code
    , cast(source_description as {{ dbt.type_string() }}) as source_description
    , cast(null as {{ dbt.type_string() }}) as normalized_code_type
    , cast(null as {{ dbt.type_string() }}) as normalized_code
    , cast(null as {{ dbt.type_string() }}) as normalized_description
    , cast(condition_rank as {{ dbt.type_int() }}) as condition_rank
    , cast(null as {{ dbt.type_string() }}) as present_on_admit_code
    , cast(null as {{ dbt.type_string() }}) as present_on_admit_description
    , cast(data_source as {{ dbt.type_string() }}) as data_source
    , cast(null as {{ dbt.type_string() }}) as file_name
    , cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from mapped_data
