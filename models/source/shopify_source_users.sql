select

  id,
  replace(first_name,chr(10),'') as first_name,
  replace(last_name,chr(10),'') as last_name,
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
