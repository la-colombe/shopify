select 

--IDs
  id,
  customer_id,
  order_number,

--Customer Info
  email,

--Order Status

  case source_name
    when 'web' then 'web'
    when '294517' then 'recharge'
    when 'Giftwizard' then 'giftwizard'
    else 'other'
  end as source,

  financial_status,
  fulfillment_status,
  order_status_url,
  processing_method,
  gateway,
  requested_shipping_method,

  case 
    when lower(tags) like '%giftwizard%' then TRUE
    else FALSE
  end as gift_order,

  shipping_address_1,
  shipping_address_2,
  shipping_name,
  shipping_city,
  shipping_country,
  shipping_country_code,
  shipping_latitude,
  shipping_longitude,
  shipping_state,
  shipping_state_code,
  shipping_zip,
  shipping_price,

--Timestamps
  created_at,
  updated_at,
  cancelled_at,

--Calculated Fields
  rank() over (partition by customer_id order by created_at, id asc) AS customer_order_number

from {{ref('shopify_source_orders')}} o