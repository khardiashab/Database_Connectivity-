/* Find Last Delivery Date from billing_details table of every customer and display customer Id and Name,
 Last_Delivery_Date and Quantity using Joins.
 (Note that the date in billing_details will act as last delivery date
 */
SELECT
    cd.id AS customer_id,
    cd.name,
    COALESCE(o.id, NULL) AS order_id,
    COALESCE(o.quantity, 0) AS purchased_quantity,
    b.inv_id,
    b.delivery_status,
    b.date AS delivery_date,
    ROW_NUMBER() OVER (PARTITION BY cd.id ORDER BY b.date DESC) AS row_number
FROM
    cust_details AS cd
    JOIN orders AS o ON o.cust_id = cd.id
    JOIN billing_details AS b ON b.order_id = o.id
WHERE
    cd.id IS NOT NULL
    AND o.id IS NOT NULL
    AND b.id IS NOT NULL;

SELECT
    cd.id AS customer_id,
    cd.name,
    o.id AS order_id,
    o.quantity AS purchased_quantity,
    b.inv_id,
    b.delivery_status,
    b.date AS latest_delivery_date
FROM cust_details AS cd
    LEFT JOIN orders AS o ON o.cust_id = cd.`Id`
    LEFT JOIN billing_details AS b ON b.order_id = o.id
WHERE b.date = (
        SELECT MAX(date)
        FROM billing_details
        WHERE order_id = o.id
    );

SELECT
    cd.id AS customer_id,
    cd.name,
    o.id AS order_id,
    o.quantity AS purchased_quantity,
    b.inv_id,
    b.delivery_status,
    b.date AS delivery_date
FROM cust_details AS cd
    LEFT JOIN (
        SELECT o1.*
        FROM orders AS o1
        WHERE o1.id = (
                SELECT o2.id
                FROM
                    orders AS o2
                WHERE
                    o2.cust_id = o1.cust_id
                ORDER BY
                    o2.date DESC
                LIMIT
                    1
            )
    ) AS o ON o.cust_id = cd.id
    LEFT JOIN billing_details AS b ON b.order_id = o.id
WHERE
    b.delivery_status = 'Delivered';


select
    max(b.`date`) as ldd,
    o.id as order_id,
    o.cust_id as cust_id
from billing_details as b
    JOIN orders as o on b.order_id = o.id
GROUP BY o.cust_id;
