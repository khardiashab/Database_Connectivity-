
/*
 Query.2 Display one customer from each product category who purchased a 
 maximum number of cylinders with Connection_Type, Cust_Id, Name and Quantity purchased.
 
 */
 use lpg;
WITH RankedResults AS (
	SELECT
		c.id AS customer_id,
		c.name,
		c.connection_type,
		SUM(COALESCE(o.quantity, 0)) AS total_quantity,
		ROW_NUMBER() OVER (
			PARTITION BY c.connection_type
			ORDER BY
				SUM(COALESCE(o.quantity, 0)) DESC
		) AS rank_within_type
	FROM
		cust_details AS c
		LEFT JOIN orders AS o ON c.id = o.cust_id
		AND o.status = 'Ordered'
	GROUP BY
		c.id,
		c.name,
		c.connection_type
)
SELECT
	customer_id,
	name,
	connection_type,
	total_quantity
FROM
	RankedResults
WHERE
	rank_within_type = 1;
