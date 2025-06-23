with procedure_base as (
    select
        cms1500_id
        , cpt_code
        , cpt_code_id
        , created_at
        , epsdt
        , family_planning_service
        , fee
        , id
        , mod1
        , mod2
        , mod3
        , mod4
        , pointers
        , service_date
        , service_end_date
        , units
        , updated_at
    from {{ ref('stg_healthie_cpt_codes_cms_1500') }}
),

id_map as (
    select distinct
        cms1500_id
        , patient_id
        , rendering_provider_other_id
    from {{ ref('stg_healthie_cms_1500') }}
),

mapped_data as (
    select
        pb.id as procedure_id
        , map.patient_id as person_id
        , map.patient_id
        , pb.cms1500_id as claim_id
        , service_date as procedure_date
        , cpt_code as source_code
        , case when hcpcs.hcpcs is not null then 'hcpcs'
               else null
            end as normalized_code_type
        , hcpcs.hcpcs as normalized_code
        , hcpcs.long_description as normalized_description
        , mod1 as modifier_1
        , mod2 as modifier_2
        , mod3 as modifier_3
        , mod4 as modifier_4
        , rendering_provider_other_id as practitioner_id
        , 'Healthie' as data_source
    from procedure_base as pb
    left join id_map as map
    on pb.cms1500_id = map.cms1500_id
    left join {{ ref('terminology__hcpcs_level_2') }} as hcpcs
    on pb.cpt_code = hcpcs.hcpcs
)

select
      cast(procedure_id as {{ dbt.type_string() }}) as procedure_id
    , cast(person_id as {{ dbt.type_string() }}) as person_id
    , cast(patient_id as {{ dbt.type_string() }}) as patient_id
    , cast(null as {{ dbt.type_string() }}) as encounter_id
    , cast(claim_id as {{ dbt.type_string() }}) as claim_id
    , cast(procedure_date as date) as procedure_date
    , cast(null as {{ dbt.type_string() }}) as source_code_type
    , cast(source_code as {{ dbt.type_string() }}) as source_code
    , cast(null as {{ dbt.type_string() }}) as source_description
    , cast(normalized_code_type as {{ dbt.type_string() }}) as normalized_code_type
    , cast(normalized_code as {{ dbt.type_string() }}) as normalized_code
    , cast(normalized_description as {{ dbt.type_string() }}) as normalized_description
    , cast(modifier_1 as {{ dbt.type_string() }}) as modifier_1
    , cast(modifier_2 as {{ dbt.type_string() }}) as modifier_2
    , cast(modifier_3 as {{ dbt.type_string() }}) as modifier_3
    , cast(modifier_4 as {{ dbt.type_string() }}) as modifier_4
    , cast(null as {{ dbt.type_string() }}) as modifier_5
    , cast(practitioner_id as {{ dbt.type_string() }}) as practitioner_id
    , cast(data_source as {{ dbt.type_string() }}) as data_source
    , cast(null as {{ dbt.type_string() }}) as file_name
    , cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from mapped_data
