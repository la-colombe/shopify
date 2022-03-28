select

	order_id,
	line_item_number,

	sum(amount) as line_item_discount

from {{ref('shopify_base_order_item_discount_allocations')}}
group by 1, 2