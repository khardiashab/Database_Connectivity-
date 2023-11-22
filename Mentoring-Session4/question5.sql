-- Find the amount paid by the customer for every delivery taken

--  for all customers with following details

-- Customer_Id, Name, Order_Id, Order_Date, Inv_Id, Delivery_Date,

--  Connection_Type and Price.

use lpg;

SELECT
    cd.id AS customer_id,
    cd.name,
    o.id AS order_id,
    o.date AS order_date,
    b.inv_id,
    b.date AS delivery_date,
    cd.connection_type,
    p.price * o.quantity AS Amount_paid
FROM
    cust_details AS cd
    INNER JOIN orders AS o ON o.cust_id = cd.id
    INNER JOIN billing_details AS b ON b.order_id = o.id
    INNER JOIN pricing AS p ON cd.connection_type = p.type
WHERE
    b.delivery_status = 'Delivered'
    AND YEAR(b.date) = p.year
    AND MONTHNAME(b.date) = p.month;