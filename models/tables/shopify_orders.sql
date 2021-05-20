select 

--IDs
  o.id,
  o.customer_id,
  o.order_number,

--Customer Info
  o.email,
  o.shipping_address_1,
  o.shipping_address_2,
  o.shipping_name,
  o.shipping_city,
  o.shipping_country,
  o.shipping_country_code,
  o.shipping_latitude,
  o.shipping_longitude,
  o.shipping_state,
  o.shipping_state_code,
  o.shipping_zip,
  
--Order Status
  o.financial_status,
  o.fulfillment_status,
  o.order_status_url,
  o.processing_method,
  o.gateway,
  o.source,
  o.gift_order,
  o.requested_shipping_method,
  
--Timestamps
  o.created_at,
  c.created_at as customer_created_at,
  o.cancelled_at,
  greatest(oa.updated_at, o.updated_at, c.updated_at) as updated_at,
  po.created_at as previous_order_created_at,
  
--Numbers
  o.customer_order_number,

--Order Aggregates
  oa.count_of_items,
  oa.net_sales,
  oa.gross_sales,
  oa.weight,
  o.shipping_price,
  substring(od.codes_used,0,1024) as codes_used,
  od.amount as discounts,
  od.order_discount,
  od.freight_discount,

--Calculated Columns
  datediff(second, po.created_at, o.created_at) as time_since_previous_order

from {{ref('shopify_base_orders')}} o
join {{ref('shopify_order_aggregates')}} oa on oa.order_id = o.id
join {{ref('shopify_base_customers')}} c on c.id = o.customer_id
left join {{ref('shopify_base_orders')}} po on po.customer_id = o.customer_id and po.customer_order_number = (o.customer_order_number - 1)
left join {{ref('shopify_order_discounts')}} od on od.order_id = o.id
