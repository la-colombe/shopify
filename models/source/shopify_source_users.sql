select

  id,
  first_name,
  last_name,
  lower(email) as email,
  verified_email,
  default_address__id as default_address_id,
  note,
  state,
  tags,
  tax_exempt,
  convert_timezone('America/New_York',created_at) as created_at,
  _sdc_received_at as updated_at,
  accepts_marketing

from {{ source('stitch_shopify', 'customers') }}
