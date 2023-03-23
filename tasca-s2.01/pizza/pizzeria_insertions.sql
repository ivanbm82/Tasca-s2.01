USE pizza_shop;

INSERT INTO province (province_name)
VALUES ('Barcelona'),
	   ('Lerida'),
	   ('Gerona'),
       ('Tarragona');

INSERT INTO town (town_name, province_province_id)
VALUES ('Montcada i Reixac', 1),
	   ('Cerdanyola', 1),
       ('Ripollet', 1),
       ('Blanes', 3),
	   ('Sort', 2),
       ('Tarragona', 3);

INSERT INTO customer (customer_name, customer_surname, customer_address, customer_postcode, customer_phone_number, town_town_id)
VALUES ('Ivan', 'Garcia', 'C/ Can Castells 40', '08110', '666111222', 1),
	   ('Luis', 'Martin', 'C/ Major, 12', '05893', '616365982', 2),
       ('Anto', 'Luna', 'C/ Domingo 1', '08120', '635987012', 3),
       ('Maria', 'Martinez', 'C/ La Rosa 27', '35698', '632745900', 4),
       ('Laura', 'Sanchez', 'Passeig Lluís Company 69', '96385', '621899455', 5),
       ('Diego', 'Marquez', 'C/ Alella', '21100', '656313242', 2),
       ('Fran', 'Cervantes', 'C/ Sant Jordi 656', '10056', '666589589', 6);

INSERT INTO shop (shop_address, shop_postcode, town_town_id)
VALUES ('C/ Diputacion 23', '08654', 1),
	   ('Rambla Sant Ramon 96', '98563', 2),
       ('C/ Perdida 0', '01598', 3),
       ('C/ Mayor 12', '18003', 6);

INSERT INTO shop_order (shop_order_datetime, shop_order_option, shop_order_price, customer_customer_id, shop_shop_id)
VALUES ('2021-10-12 13:15:18', 'shop', '13.25', 1, 1),
	   ('2021-12-01 20:35:08', 'Delivery', '14.25', 1, 1),
       ('2022-06-15 15:22:13', 'shop', '9.00', 2, 2),
       ('2023-11-09 22:15:46', 'Delivery', '23.50', 3, 3),
       ('2022-12-21 19:55:38', 'shop', '11.50', 4, 3),
       ('2018-07-10 20:25:45', 'shop', '26.25', 5, 4),
	   ('2019-12-22 21:38:00', 'shop', '8.25', 5, 4),
       ('2021-08-21 20:59:00', 'Delivery', '45.50', 6, 2),
       ('2023-01-08 21:17:00', 'Delivery', '40.50', 7, 4);

INSERT INTO employee (employee_name, employee_surname, employee_nif, employee_phone_number, employee_position, shop_shop_id)
VALUES ('Cristina', 'Roig', NULL, '666888555', 'Cook', 1),
	   ('Pau', 'Casal', NULL, '666888222', 'Delivery staff', 1),
       ('Merçe', 'Rodoreda', '654987321', NULL, 'Delivery staff', 2),
       ('Alex', 'Clot', '36958350G', '632658698', 'Cook', 2),
       ('Federico', 'Fernàndez', NULL, NULL, 'Delivery staff', 3),
       ('Peter', 'Garcia', NULL, NULL, 'Cook', 3),
       ('Luis', 'Simps', NULL, '633500522', 'Cook', 4),
       ('Jose', 'Vila', '53060632T', '698689654', 'Delivery staff', 4);

INSERT INTO order_delivery (employee_employee_id, shop_order_shop_order_id, order_delivery_datetime)
VALUES (2, 2, '2021-12-01 21:35:08'),
	   (5, 4, '2023-11-09 22:45:46'),
       (3, 8, '2021-08-21 21:59:00'),
       (8, 9, '2023-01-08 21:45:00');

INSERT INTO category (category_name)
VALUES ('pizza'),
	   ('pizza'),
       ('pizza'),
       ('Burger'),
       ('Drink');

INSERT INTO product (product_name, product_description, product_image, product_price, category_category_id)
VALUES ('cheeses', 'Tomato, mozzarella, emmental cheese', NULL, 10.25, 1),
	   ('Vegan margherita', 'Tomato, oil', NULL, 12.50, 2),
       ('American', 'Tomato, mozzarella, bacon, pepperoni', NULL, 14.25, 3),
       ('Leader', 'Beef, tomato, bacon and caramelized onions', NULL, 10.75, 4),
       ('Australian', 'Beef, cheedar, bacon, BBQ sauce', NULL, 11.99, 4),
       ('Beer', NULL, NULL, 2.50, 5),
       ('Coke', NULL, NULL, 2.00, 5);

INSERT INTO order_has_products (product_product_id, shop_order_shop_order_id, products_quantity)
VALUES (1, 1, 1),
	   (7, 1, 2),
	   (4, 2, 1),
       (6, 2, 1),
       (7, 3, 4),
       (2, 4, 1),
       (5, 4, 1),
       (6, 4, 2),
       (4, 5, 1),
       (3, 6, 2),
       (6, 7, 3),
       (3, 8, 1),
       (4, 8, 2),
       (1, 9, 3); 

