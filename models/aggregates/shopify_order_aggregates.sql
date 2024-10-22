select 

	order_id,
	
	--Calculated Column
	sum(quantity) as count_of_items,
	sum(line_item_net_sales) as net_sales,
	sum(line_item_gross_sales) as gross_sales,
	sum(line_item_discount) as order_discount,
	sum(line_item_weight) as weight,
	max(updated_at) as updated_at,
  listagg(distinct case when p.product_type_desc is not null then p.product_type_desc else 'Other' end 
  + ' - ' + nvl(p.msrtd_format_desc, p.ontap_format_desc, p.ssrtd_format_desc, p.roasted_format_desc, 'Other'), ', ')
  within group (order by product_type_desc, p.msrtd_format_desc, p.ontap_format_desc, p.ssrtd_format_desc, p.roasted_format_desc, 'Other') as basket_type

from {{ref('shopify_base_order_items')}} s
join analytics_consolidated.mas_products p using (sku)
group by 1