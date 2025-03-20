select

  order_id,
  line_item_number,
  max(case when "name" in ('Prepaid Origin Order','_ordergroove.subscription.prepaidOriginOrder') then value end) as prepaid_origin_order_number,
  max(case when "name" = '_ordergroove.subscription.prepaidOrdersPerBilling' then value end) as prepaid_orders_per_billing

from {{ref('shopify_source_order_items_properties')}}
group by 1, 2