--Contains details on discounts applied at the line_item level

select

  _sdc_source_key_id as order_id,
  _sdc_level_0_id as line_item_number,
  amount

from {{source('shopify_singer', 'orders__line_items__discount_allocations')}}