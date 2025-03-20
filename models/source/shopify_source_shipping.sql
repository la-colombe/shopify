select 

	_sdc_source_key_id as id, 
	sum(price) as shipping_price, 
	max(title) as requested_shipping_method,
	max(_sdc_received_at) as updated_at

from {{ source('shopify_singer', 'orders__shipping_lines') }}
group by 1