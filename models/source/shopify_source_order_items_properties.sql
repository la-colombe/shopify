select

  _sdc_source_key_id as order_id,
  _sdc_level_0_id as line_item_number,
  "name",
  value,
  _sdc_received_at as updated_at

from {{ source('stitch_shopify', 'orders__line_items__properties') }}