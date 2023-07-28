select 

--IDs
  id,
  customer_id,
  order_number,

--Customer Info
  email,

--Order Status

  financial_status,
  fulfillment_status,
  order_status_url,
  processing_method,
  gateway,
  requested_shipping_method,
  
  tags,
  case 
    when lower(tags) like '%giftwizard%' then TRUE
    else FALSE
  end as gift_order,
  lower(tags) like '%ordergroove prepaid order%' as is_prepaid_subscription, 
  case 
    when is_prepaid_subscription or source_name = 'subscription_contract' then 'ordergroove'
    when source_name = 'web' then 'web'
    when source_name = '294517' then 'recharge'
    when source_name = 'Giftwizard' then 'giftwizard'
    else 'other'
  end as source,

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
  shipping_amount_paid,
  total_tax,

--Timestamps
  created_at,
  updated_at,
  cancelled_at,

--Calculated Fields
  rank() over (partition by customer_id order by created_at, id asc) AS customer_order_number,
  case when is_prepaid_subscription then rank() over (partition by customer_id, is_prepaid_subscription order by created_at, id asc) end as customer_prepaid_order_number

from {{ref('shopify_source_orders')}} o