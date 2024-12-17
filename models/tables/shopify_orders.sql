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
  o.tags,
  o.gift_order,
  o.is_prepaid_subscription,
  o.requested_shipping_method,
  
--Timestamps
  o.created_at,
  c.created_at as customer_created_at,
  o.cancelled_at,
  greatest(oa.updated_at, o.updated_at, c.updated_at) as updated_at,
  po.created_at as previous_order_created_at,
  fa.first_fulfilled_at,
  
--Numbers
  o.customer_order_number,
  o.customer_prepaid_order_number,

--Order Aggregates
  oa.count_of_items,
  oa.net_sales,
  oa.gross_sales,
  oa.weight,
  oa.basket_type,
  o.shipping_price,
  o.shipping_amount_paid,
  o.total_tax,
  case 
    when o.source = 'ordergroove' and oda.discount_type = 'manual' and oda.discount_title = 'Item Discount' then 'automatic'
    else oda.discount_type
  end as discount_type,
  case 
    when o.source = 'ordergroove' and oda.discount_type = 'manual' and oda.discount_title = 'Item Discount' then 'Subscribe & Save'
    else oda.discount_title
  end as discount_title,  
  substring(od.codes_used,0,1024) as codes_used,
  od.amount as discounts,  -- To be deprecated. oa.order_discount now includes all discounts, except for freight discounts
  oa.order_discount,
  od.freight_discount,

--Calculated Columns
  datediff(second, po.created_at, o.created_at) as time_since_previous_order

from {{ref('shopify_base_orders')}} o
join {{ref('shopify_order_aggregates')}} oa on oa.order_id = o.id
join {{ref('shopify_base_customers')}} c on c.id = o.customer_id
left join {{ref('shopify_base_orders')}} po on po.customer_id = o.customer_id and po.customer_order_number = (o.customer_order_number - 1)
left join {{ref('shopify_order_discounts')}} od on od.order_id = o.id
left join {{ref('shopify_order_discount_applications')}} oda on oda.order_id = o.id
left join {{ref('shopify_fulfillment_aggregates')}} fa on fa.order_id = o.id
