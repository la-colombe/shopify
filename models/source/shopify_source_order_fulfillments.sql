select 

  id as fulfillment_id,
  _sdc_source_key_id as order_id,
  name,
  service,
  status,
  tracking_company,
  tracking_number,
  tracking_url,
  created_at,
  updated_at,
  shipment_status

from stitch_shopify.orders__fulfillments