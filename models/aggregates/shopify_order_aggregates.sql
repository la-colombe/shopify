select 

	order_id,
	
	--Calculated Column
	sum(quantity) as count_of_items,
	sum(line_item_net_sales) as net_sales,
	sum(line_item_gross_sales) as gross_sales,
	sum(line_item_discount) as order_discount,
	sum(line_item_weight) as weight,
	max(updated_at) as updated_at

from {{ref('shopify_base_order_items')}}
group by 1