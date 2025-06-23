select
    cast(active as {{ dbt.type_boolean() }}) as active
    ,cast(cms1500_id as {{ dbt.type_string() }}) as cms1500_id
    ,cast(created_at as {{ dbt.type_string() }}) as created_at
    ,cast(display_name as {{ dbt.type_string() }}) as display_name
    ,cast(end_date as {{ dbt.type_string() }}) as end_date
    ,cast(first_symptom_date as {{ dbt.type_string() }}) as first_symptom_date
    ,cast(icd_code as {{ dbt.type_string() }}) as icd_code
    ,cast(icd_code_id as {{ dbt.type_string() }}) as icd_code_id
    ,cast(id as {{ dbt.type_string() }}) as id
    ,cast(updated_at as {{ dbt.type_string() }}) as updated_at
from {{ source('healthie', 'icd_codes_cms_1500') }}