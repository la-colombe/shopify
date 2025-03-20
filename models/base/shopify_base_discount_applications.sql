select

--IDs
  _sdc_source_key_id as order_id,

--Discount Attributes
  type,
  title,

--Timestamps
  _sdc_received_at as updated_at


from {{ source('shopify_singer', 'orders__discount_applications') }}