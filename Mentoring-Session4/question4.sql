/*
Query.4 Display Customer Id, Name, Order_Id, Inv_Id, Delivery Date of all deliveries received by customer for all
customers

*/

SELECT cd.id as customer_id, cd.name, o.id as order_id, b.inv_id, b.`date` as deliver_date  from cust_details as cd,
orders as o, billing_details as b     
 WHERE
 b.delivery_status= "Delivered" and b.order_id = o.id and o.cust_id = cd.`Id`;


SELECT cd.id as customer_id, cd.name, o.id as order_id, b.inv_id, b.`date` as deliver_date  
FROM cust_details as cd
LEFT JOIN orders as o ON o.cust_id = cd.`Id`
LEFT JOIN billing_details as b ON b.order_id = o.id
WHERE b.delivery_status = "Delivered";

-- subquery
select bd.inv_id, bd.`date`, o.id as order_id, o.cust_id as customer_id  from billing_details as bd, orders as o
where bd.delivery_status='Delivered' and bd.order_id = o.id;

SELECT c.id, o.id as order_id from cust_details as c LEFT JOIN orders as o on o.cust_id = c.`Id` ;