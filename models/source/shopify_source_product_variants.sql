select 

	id,
	_sdc_source_key_id as product_id,
	upper(sku) as sku,
	title,
	option1,
	option2,
	option3,
	price,
	weight,
	weight_unit,
	_sdc_received_at as updated_at

from {{ source('stitch_shopify', 'products__variants') }}