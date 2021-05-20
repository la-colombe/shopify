select

	c.id,
	c.first_name,
	c.last_name,
	c.email,
	c.state,
	c.tags,
	c.tax_exempt,
	c.created_at,
	greatest(c.updated_at, ca.updated_at) as updated_at,
	c.accepts_marketing,

-- Aggregates
	ca.number_of_orders,
	ca.average_order_value,
	ca.first_order_date,
	ca.last_order_date,
	ca.years_active,
	ca.lifetime_revenue,
	ca.items_purchased,
	substring(cd.codes_used, 0, 1024) as codes_used,

-- Calculated Columns
	ca.lifetime_revenue / nullif(ca.years_active,0) as annual_revenue,
	ca.items_purchased::float / nullif(ca.number_of_orders,0) as items_per_order

 from {{ref('shopify_base_customers')}} c
 join {{ref('shopify_customer_aggregates')}} ca on ca.customer_id = c.id
 left join {{ref('shopify_customer_discounts')}} cd on cd.customer_id = c.id