with base as (
    select
        accept_assignment
        , additional_text
        , adjustment
        , amount_paid
        , amount_reimbursed
        , billing_provider_id
        , check_numbers
        , claim_md_rejection_messages
        , claim_md_rejection_messages_info
        , claim_submissions
        , client_responsibility
        , client_responsibility_removed
        , client_sig_on_file
        , cms1500_policies
        , copay
        , copay_still_owed
        , cpt_code_names
        , cpt_codes_cms1500s
        , created_at
        , cursor
        , date_of_service
        , dietitian_id
        , eras
        , estimated_cpt_fees_for_user
        , form_answer_group_id
        , has_been_submitted
        , icd_codes_cms1500s
        , id
        , include_referrer_information
        , insured_sig_on_file
        , nineteen_reserved
        , org_info
        , organization_info_id
        , orig_ref_number
        , paid_out_at
        , patient
        , patient_account_num
        , patient_id
        , primary_plan_name
        , reasons
        , referral_info
        , reimbursed_at
        , rendering_provider
        , rendering_provider_other_id
        , rendering_provider_other_id_object
        , resubmission_code
        , service_location
        , service_location_id
        , status
        , tend_reserved
        , total_charge
        , updated_at
        , updated_by_sftp
        , use_indiv_npi
    from {{ ref('stg_healthie_cms_1500') }}
), 

diag_info as (
    select
        a.cms1500_id
        , a.icd_code
        , a.display_name
    from {{ ref('stg_healthie_icd_codes_cms_1500') }} as a
    inner join {{ ref('stg_healthie_diagnosis') }} as b
    on a.id = b.icd_codes_cms1500s_id
    where primary
)

mapped_data as (
select
      base.id as encounter_id
    , base.patient_id as person_id
    , base.patient_id as patient_id
    , base.date_of_service as encounter_start_date
    , base.date_of_service as encounter_end_date
    , base.service_location_id as facility_id
    , service_location as facility_name
    , 'icd-10-cm' as primary_diagnosis_code_type
    , di.icd_code as primary_diagnosis_code
    , di.display_name as primary_diagnosis_description
    , base.rendering_provider_other_id as attending_provider_id
    , 'Healthie' as data_source
from base
left join diag_info as di
on base.id = di.cms_1500_id
)

select
      cast(encounter_id as {{ dbt.type_string() }}) as encounter_id
    , cast(person_id as {{ dbt.type_string() }}) as person_id
    , cast(patient_id as {{ dbt.type_string() }}) as patient_id
    , cast(null as {{ dbt.type_string() }}) as encounter_type
    , cast(encounter_start_date as date) as encounter_start_date
    , cast(encounter_end_date as date) as encounter_end_date
    , cast(null as {{ dbt.type_int() }}) as length_of_stay
    , cast(null as {{ dbt.type_string() }}) as admit_source_code
    , cast(null as {{ dbt.type_string() }}) as admit_source_description
    , cast(null as {{ dbt.type_string() }}) as admit_type_code
    , cast(null as {{ dbt.type_string() }}) as admit_type_description
    , cast(null as {{ dbt.type_string() }}) as discharge_disposition_code
    , cast(null as {{ dbt.type_string() }}) as discharge_disposition_description
    , cast(attending_provider_id as {{ dbt.type_string() }}) as attending_provider_id
    , cast(null as {{ dbt.type_string() }}) as attending_provider_name
    , cast(facility_id as {{ dbt.type_string() }}) as facility_id
    , cast(facility_name as {{ dbt.type_string() }}) as facility_name
    , cast(primary_diagnosis_code_type as {{ dbt.type_string() }}) as primary_diagnosis_code_type
    , cast(primary_diagnosis_code as {{ dbt.type_string() }}) as primary_diagnosis_code
    , cast(primary_diagnosis_description as {{ dbt.type_string() }}) as primary_diagnosis_description
    , cast(null as {{ dbt.type_string() }}) as drg_code_type
    , cast(null as {{ dbt.type_string() }}) as drg_code
    , cast(null as {{ dbt.type_string() }}) as drg_description
    , cast(null as {{ dbt.type_numeric() }}) as paid_amount
    , cast(null as {{ dbt.type_numeric() }}) as allowed_amount
    , cast(null as {{ dbt.type_numeric() }}) as charge_amount
    , cast(data_source as {{ dbt.type_string() }}) as data_source
    , cast(null as {{ dbt.type_string() }}) as file_name
    , cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from mapped_data
