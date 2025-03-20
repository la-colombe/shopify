select

  id,
  title,
  producttype as product_type,
  vendor,
  tags,
  handle,
  publishedat as published_at,
  createdat as created_at,
  _sdc_received_at as updated_at

from {{ source('stitch_shopify', 'products') }}
