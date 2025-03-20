-- see shopify docs here:
-- https://help.shopify.com/api/reference/order

select

  -- ids
  o.id,
  o.customer__id as customer_id,
  o.checkout_id,
  o.cart_token,
  o.checkout_token,
  o.token,

  -- logical ids reported in the application
  o.number,
  o.order_number,

  -- state
  o.financial_status,
  o.fulfillment_status,
  o.confirmed,
  o.order_status_url,

  -- cancellation information
  o.cancel_reason,
  o.cancelled_at,

  -- etc
  o.closed_at,
  o.processed_at,
  lower(o.email) as email,
  lower(o.contact_email) as contact_email,
  o.name,
  o.note,
  o.tags,
  null as gateway, --removed in singer tap
  s.requested_shipping_method,

  -- attribution
  o.browser_ip,
  o.source_name,
  o.landing_site,
  
  --landing_site_ref,
  o.referring_site,

  -- financial
  o.currency,
  null as processing_method, --removed in singer tap

  -- numbers
  o.subtotal_price,
  o.taxes_included,
  o.total_discounts,
  o.total_line_items_price,
  o.total_price,
  --o.total_price_usd,
  o.total_tax,
  o.total_weight,
  s.shipping_price,
  o.total_shipping_price_set__presentment_money__amount as shipping_amount_paid,

  -- address
  o.shipping_address__address1 as shipping_address_1,
  o.shipping_address__address2 as shipping_address_2,
  o.shipping_address__city as shipping_city,
  o.shipping_address__country as shipping_country,
  o.shipping_address__country_code as shipping_country_code,
  o.shipping_address__first_name,
  o.shipping_address__last_name,
  o.shipping_address__latitude as shipping_latitude,
  o.shipping_address__longitude as shipping_longitude,
  o.shipping_address__name as shipping_name,
  o.shipping_address__phone,
  o.shipping_address__province as shipping_state,
  o.shipping_address__province_code as shipping_state_code,
  o.shipping_address__zip as shipping_zip,
  o.billing_address__address1,
  o.billing_address__address2,
  o.billing_address__city,
  o.billing_address__company,
  o.billing_address__country,
  o.billing_address__country_code,
  o.billing_address__first_name,
  o.billing_address__last_name,
  o.billing_address__latitude,
  o.billing_address__longitude,
  o.billing_address__name,
  o.billing_address__phone,
  o.billing_address__province,
  o.billing_address__province_code,
  o.billing_address__zip,

  -- audit
  convert_timezone('America/New_York',o.created_at) as created_at,
  greatest(o._sdc_received_at, s.updated_at) as updated_at

from {{ source('stitch_shopify', 'orders') }} o
left join {{ref('shopify_source_shipping')}} s on s.id = o.id

where
  -- filter test transactions
  o.test = false