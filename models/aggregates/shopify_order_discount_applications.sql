select

  order_id,

  count(distinct type) as distinct_types,

  case
    when distinct_types = 1 then max(type)
    else 'multi'
  end as discount_type,
  
  case
    when distinct_types = 1 then max(title)
    else 'multi'
  end as discount_title,

  max(updated_at) as updated_at

from {{ref('shopify_base_discount_applications')}}
group by 1