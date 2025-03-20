select

  id,
  parent_id,
  order_id,

  status,
  error_code,
  message,

  kind,
  amount,
  "authorization",
  currency,
  gateway,

  source_name,

  created_at,
  _sdc_received_at as updated_at

from {{ source('shopify_singer', 'transactions') }}

where
  -- filter test transactions
  test = false
