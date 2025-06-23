select
      cast(active as {{ dbt.type_boolean() }}) as active
    , cast(custom_module_id as {{ dbt.type_string() }}) as custom_module_id
    , cast(display_name as {{ dbt.type_string() }}) as display_name
    , cast(end_date as date) as end_date
    , cast(first_symptom_date as date) as first_symptom_date
    , cast(icd_code as {{ dbt.type_string() }}) as icd_code
    , cast(icd_code_id as {{ dbt.type_string() }}) as icd_code_id
    , cast(icd_codes_cms1500s_id as {{ dbt.type_string() }}) as icd_codes_cms1500s_id
    , cast(icd_codes_super_bill_id as {{ dbt.type_string() }}) as icd_codes_super_bill_id
    , cast(id as {{ dbt.type_string() }}) as id
    , cast(primary as {{ dbt.type_boolean() }}) as primary
    , cast(updated_at as {{ dbt.type_timestamp() }}) as updated_at
    , cast(user as {{ dbt.type_string() }}) as user
    , cast(user_id as {{ dbt.type_string() }}) as user_id
from {{ source('healthie', 'diagnosis') }}
