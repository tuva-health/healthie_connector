select
    cast(active as {{ dbt.type_boolean() }}) as active
    ,cast(code as {{ dbt.type_string() }}) as code
    ,cast(comment as {{ dbt.type_string() }}) as comment
    ,cast(created_at as {{ dbt.type_string() }}) as created_at
    ,cast(directions as {{ dbt.type_string() }}) as directions
    ,cast(dosage as {{ dbt.type_string() }}) as dosage
    ,cast(end_date as {{ dbt.type_string() }}) as end_date
    ,cast(frequency as {{ dbt.type_string() }}) as frequency
    ,cast(id as {{ dbt.type_string() }}) as id
    ,cast(mirrored as {{ dbt.type_boolean() }}) as mirrored
    ,cast(name as {{ dbt.type_string() }}) as name
    ,cast(requires_consolidation as {{ dbt.type_boolean() }}) as requires_consolidation
    ,cast(route as {{ dbt.type_string() }}) as route
    ,cast(start_date as {{ dbt.type_string() }}) as start_date
    ,cast(updated_at as {{ dbt.type_string() }}) as updated_at
    ,cast(user_id as {{ dbt.type_string() }}) as user_id
from {{ source('healthie', 'medication_type') }}