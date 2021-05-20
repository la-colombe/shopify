select 

	o.customer_id,
   
--Calculated Columns
	--Orders
	count(o.id) as number_of_orders,
	min(o.created_at) as first_order_date,
	max(o.created_at) as last_order_date,
	datediff(second, min(o.created_at), max(o.created_at))::float / (60*60*24*365) as years_active,
	max(greatest(o.updated_at, oa.updated_at)) as updated_at,

	--Order Items
	sum(oa.count_of_items) as items_purchased,
	sum(oa.net_sales) as lifetime_revenue,
	avg(oa.net_sales) as average_order_value

from {{ref('shopify_base_orders')}} o
join {{ref('shopify_order_aggregates')}} oa on oa.order_id = o.id
group by 1
