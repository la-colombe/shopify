select

  id,
  first_name,
  last_name,
  email,
  state,
  tags,
  tax_exempt,
  created_at,
  updated_at,
  accepts_marketing

from {{ref('shopify_source_users')}}