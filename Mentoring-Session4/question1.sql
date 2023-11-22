/*
 Query 1. Write a query to display a table with customer Id, Name,
 Connection_Type and No_Of Cylinders ordered from orders table.
 */
 use lpg;
select
	c.id as customer_id,
	c.name,
	c.connection_type,
	coalesce(o.No_of_cylinders, 0) as No_of_cylinders
from
	cust_details as c
	left join (
		select
			cust_id as customer_id,
			sum(quantity) as No_of_Cylinders
		from
			orders
		where
			status = 'ordered'
		group by
			cust_id
	) as o on o.customer_id = c.id;

;
