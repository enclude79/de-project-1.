	insert into analysis.dm_rfm_segments
   select
	us.id as user_id,
    ntile(5) over (order by max(order_ts) nulls first) as recency,
    ntile(5) over (order by count(ord.order_id)) as frecuency,
    ntile(5) over (order by sum(payment) nulls first) as monetary_value
    from analysis.users us left join analysis.orders ord on us.id = ord.user_id and ord.status = 4
    group by 1
