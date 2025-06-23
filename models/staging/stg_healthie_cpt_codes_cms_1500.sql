select
      cast(cms1500_id as {{ dbt.type_string() }}) as cms1500_id
    , cast(cpt_code as {{ dbt.type_string() }}) as cpt_code
    , cast(cpt_code_id as {{ dbt.type_string() }}) as cpt_code_id
    , cast(created_at as {{ dbt.type_string() }}) as created_at
    , cast(epsdt as {{ dbt.type_string() }}) as epsdt
    , cast(family_planning_service as {{ dbt.type_boolean() }}) as family_planning_service
    , cast(fee as {{ dbt.type_string() }}) as fee
    , cast(id as {{ dbt.type_string() }}) as id
    , cast(mod1 as {{ dbt.type_string() }}) as mod1
    , cast(mod2 as {{ dbt.type_string() }}) as mod2
    , cast(mod3 as {{ dbt.type_string() }}) as mod3
    , cast(mod4 as {{ dbt.type_string() }}) as mod4
    , cast(pointers as {{ dbt.type_string() }}) as pointers
    , cast(service_date as {{ dbt.type_string() }}) as service_date
    , cast(service_end_date as {{ dbt.type_string() }}) as service_end_date
    , cast(units as {{ dbt.type_string() }}) as units
    , cast(updated_at as {{ dbt.type_string() }}) as updated_at
from {{ source('healthie', 'icd_codes_cms_1500') }}
