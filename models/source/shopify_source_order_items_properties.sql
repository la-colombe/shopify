select

  _sdc_source_key_id as order_id,
  _sdc_level_0_id as line_item_number,
  name as property_name,
  nvl(value__string, value__bigint::varchar) as property_value,
  _sdc_received_at as updated_at

from {{ source('shopify_singer', 'orders__line_items__properties') }}