/* . Display customer Id, Name, undelivered date and reason for undelivery using joins
 */

select
    cd.id as customer_id,
    cd.name,
    c.date as undelivered_date,
    c.reason
from cust_details as cd
    inner join orders as o on o.cust_id = cd.`Id`
    inner join billing_details as b on b.order_id = o.id
    inner join cancelled_bills as c on c.inv_id = b.inv_id;




    /* 2. Display customer Id, Name, Date and reason for Cancelled Orders of all cancellations made by all customers.
    */

    SELECT
      cd.id as customer_id,
      cd.name,
      co.`date`,
      co.reason
      from cust_details as cd 
      INNER JOIN orders as o  on o.cust_id = cd.`Id`
      INNER JOIN cancelled_orders as co on co.order_id = o.id
      ;