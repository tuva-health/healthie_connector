select
    cast(city as {{ dbt.type_string() }}) as city
    , cast(country as {{ dbt.type_string() }}) as country
    , cast(l.cursor as {{ dbt.type_string() }}) as location_cursor
    , cast(id as {{ dbt.type_string() }}) as id
    , cast(line1 as {{ dbt.type_string() }}) as line1
    , cast(line2 as {{ dbt.type_string() }}) as line2
    , cast(l.name as {{ dbt.type_string() }}) as location_name
    , cast(npi as {{ dbt.type_string() }}) as npi
    , cast(other_id as {{ dbt.type_string() }}) as other_id
    , cast(other_id_qual as {{ dbt.type_string() }}) as other_id_qual
    , cast(place_of_service as {{ dbt.type_string() }}) as place_of_service
    , cast(place_of_service_id as {{ dbt.type_string() }}) as place_of_service_id
    , cast(l.state as {{ dbt.type_string() }}) as location_state
    , cast(to_oneline as {{ dbt.type_string() }}) as to_oneline
    , cast(user as {{ dbt.type_string() }}) as user
    , cast(user_id as {{ dbt.type_string() }}) as user_id
    , cast(zip as {{ dbt.type_string() }}) as zip
from {{ source('healthie', 'location') }} as l
