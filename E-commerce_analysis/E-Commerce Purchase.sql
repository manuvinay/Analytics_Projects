

-- Data Source: https://www.kaggle.com/datasets/mkechinov/ecommerce-purchase-history-from-electronics-store/metadata

This file contains purchase data from April 2020 to November 2020 from a large home appliances and electronics online store.

Each row in the file represents an event. All events are related to products and users. 
Each event is like many-to-many relation between products and users.


Table Name: purchase_data

Problems:

1. Find out the Day of the Month for each month.
Day of the month - Day of the month is the day when the maximum number of order got placed. 

Solution:

select 
	month, 
	date 
from (
	select *, 
	row_number() over(Partition by month order by orders desc) as rnk
	from(
		select
			month(event_time) as Month,
			date(event_time) as Date,
			count(distinct order_id) as orders
		from
			Purchase_Data
		where event_time is not NULL
		and event_time <> 0
		and date(event_time) <> '1970-01-01' -- To remove faulty rows based on date
		group by 1,2
		) B 
	) A
where rnk = 1
;




2. Find the top 5 Lucky users for each month
Lucky users - Lucky users are users whose cummulative order value is maximum in the month and they get a Discount voucher for their next order  

Solution:


select
	Month, user_id
from(
	select 
		*, row_number() over(partition by month order by order_value desc) as rnk
	from(
		select
			month(event_time) as month,
			user_id,
			sum(price) as order_value
		from(
			select  -- distinct rows 
				event_time,
				order_id,
				product_id,
				price,
				user_id
			from
				purchase_data
			where event_time is not NULL
				and event_time <> 0
				and date(event_time) <> '1970-01-01' -- To remove faulty rows based on date
				and user_id <> 0
			group by 1,2,3,4,5
			) A  
		group by 1,2
		) B 
	) C 
where rnk = 1
;



3. Find the best selling brand for each month
Best selling brand - The brand which made orders with maximum cummulative order value 

Solution:

select
	Month, brand
from(
	select 
		*, row_number() over(partition by month order by order_value desc) as rnk
	from(
		select
			month(event_time) as month,
			brand,
			sum(price) as order_value
		from(
			select  -- distinct rows 
				event_time,
				order_id,
				product_id,
				price,
				user_id,
				brand
			from
				purchase_data
			where event_time is not NULL
				and event_time <> 0
				and date(event_time) <> '1970-01-01' -- To remove faulty rows based on date
				and user_id <> 0
			group by 1,2,3,4,5,6
			) A  
		group by 1,2
		) B 
	) C 
where rnk = 1
;
