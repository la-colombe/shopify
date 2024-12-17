select 

  order_id,
  min(created_at) as first_fulfilled_at

from {{ref('shopify_source_order_fulfillments')}} 
group by 1