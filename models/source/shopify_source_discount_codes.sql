select

  _sdc_source_key_id as order_id,
  _sdc_level_0_id as discount_number,
  lower(code) as code,
  amount,
  type,
  _sdc_received_at as updated_at


from {{ source('shopify_singer', 'orders__discount_codes') }}
