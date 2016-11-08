select
  id,
  first_name,
  last_name,
  email,
  verified_email,
  default_address__id as default_address_id,
  note,
  state,
  tags,
  tax_exempt,
  created_at,
  updated_at
from
  {{ var('source_schema') }}.{{ var('customers_table') }}
