/* 
 Query.3  Display Customer Id, Successfully_Delivered and value of customer based on purchase of cylinders using
 SQL Case Statement.
 when Successfully_Delivered >= 8 then 'Highly Valued'
 when Successfully_Delivered between 5 and 7 then 'Moderately Valued'
 Else 'Low Valued'
 
 */

use lpg;

select
    customer_id,
    name,
    purchased_quantity,
    CASE
        WHEN p.purchased_quantity >= 8 THEN 'Highly Valued'
        WHEN p.purchased_quantity BETWEEN 5 AND 7 THEN 'Moderately Valued'
        ELSE 'Low Valued'
    END as Succfully_Deleivered
FROM () as p;

-- main QUERY

SELECT
    cd.`Id` as customer_id,
    cd.name,
    ob.*
from cust_details as cd, (
        SELECT
            cust_id,
            sum(quantity) as purchased_quantity,
            CASE
                WHEN sum(quantity) >= 8 THEN 'Highly Valued'
                WHEN sum(quantity) BETWEEN 5 AND 7 THEN 'Moderately Valued'
                ELSE 'Low Valued'
            END as Succfully_Deleivered
        from orders
        where id in(
                select order_id
                from billing_details
                where
                    delivery_status = "Delivered"
            )
        GROUP BY cust_id
    ) as ob
    WHERE cd.`Id` = ob.cust_id
    ;

-- query 1

SELECT
    cust_id,
    sum(quantity) as purchased_quantity,
    CASE
        WHEN sum(quantity) >= 8 THEN 'Highly Valued'
        WHEN sum(quantity) BETWEEN 5 AND 7 THEN 'Moderately Valued'
        ELSE 'Low Valued'
    END as Succfully_Deleivered
from orders
where id in(
        select order_id
        from billing_details
        where
            delivery_status = "Delivered"
    )
GROUP BY cust_id;

-- query 2

SELECT order_id
from billing_details
WHERE
    delivery_status = "Delivered";