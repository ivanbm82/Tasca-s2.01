SELECT c.category_name, p.product_name, s.shop_order_datetime, t.town_name
FROM category AS c
INNER JOIN product AS p
	ON c.category_id = p.category_category_id
INNER JOIN order_has_products AS op
	ON p.product_id = op.product_product_id
INNER JOIN shop_order AS s
	ON s.shop_order_id = op.shop_order_shop_order_id
INNER JOIN customer AS cu
	ON cu.customer_id = s.customer_customer_id
INNER JOIN town AS t
	ON t.town_id = cu.town_town_id
WHERE c.category_name LIKE 'Drink' AND t.town_name LIKE 'Montcada i Reixac';

SELECT e.employee_name, e.employee_surname, e.employee_position, od.order_delivery_datetime
FROM order_delivery AS od
INNER JOIN employee AS e
	ON e.employee_id = employee_employee_id
WHERE e.employee_name = 'Federico';

