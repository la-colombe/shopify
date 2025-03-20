select 

	id,
	product__id as product_id,
	upper(sku) as sku,
	title,
	price,
	compareatprice as compare_at_price,
	null::float as weight, --removed in singer tap
	null as weight_unit, --removed in singer tap
	_sdc_received_at as updated_at

from {{ source('shopify_singer', 'product_variants') }}