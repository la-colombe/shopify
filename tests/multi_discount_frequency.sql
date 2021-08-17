
-- Most orders with a discount have 1 and only 1 discount applied to the order
-- From Jan 2019 to June 2021, of the orders that have a discount applied, only 0.27% have more than 1 discount type
-- This test ensures the frequency of multi-discounts remains below a threshold of 0.5% for the past 30 days

{{
  config(
    severity='error',
    tags='dtc_weekly_tests'
  )
}}

select

  count(case when discount_type = 'multi' then order_id end)::float/count(order_id)::float as multi_discount_freq

from {{ref('shopify_order_discount_applications')}}

where datediff(day,date(updated_at),current_date) < 30
having multi_discount_freq > 0.005

