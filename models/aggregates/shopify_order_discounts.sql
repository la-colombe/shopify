select

order_id,
listagg(code, ', ') within group (order by code) as codes_used,
sum(amount) as amount,
sum(case when type = 'shipping' then amount end) as freight_discount,
sum(case when type != 'shipping' then amount end) as order_discount,
max(updated_at) as updated_at


from
{{ref('shopify_source_discount_codes')}}
group by 1