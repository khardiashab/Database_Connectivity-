DELIMITER //

-- Procedure to identify the price of all products in the current month
CREATE PROCEDURE PriceOfCurrentMonth()
BEGIN
    -- Declare variables
    DECLARE currentMonth VARCHAR(20);
    DECLARE currentYear INT;

    -- Set current month and year
    SET currentMonth = MONTHNAME(CURRENT_DATE());
    SET currentYear = YEAR(CURRENT_DATE());

    -- Retrieve price details for current month
    SELECT
        p.month,
        p.year,
        p.type AS product_type,
        p.price
    FROM
        pricing AS p
    WHERE
        p.month = currentMonth
        AND p.year = currentYear;
END //

DELIMITER ;

-- Call the PriceOfCurrentMonth procedure
CALL PriceOfCurrentMonth();