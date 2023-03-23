USE `optica`;

INSERT INTO address_customer (`address_street`,`address_postcode`,`address_number`,`address_city`)
VALUES ('La Rosa', '08110', '27', 'Montcada i Reixac'),
	   ('Clavell', '08110', '12', 'Montcada i Reixac'),
       ('Mayor', '08110', '5', 'Montcada i Reixac'),
       ('Dalia', '08110', '38', 'Montcada i Reixac');
       
INSERT INTO address_supplier (`address_street`,`address_postcode`,`address_number`,`address_city`)
VALUES ('Blanco', '38400', '3', 'Puerto Cruz Santa Tenerife'),
	   ('Avenida Madrid', '08028', '9', 'Barcelona'),
       ('Poligono Industrial Camposol', '30006', '36', 'Murcia'),
       ('Castello', '08110', '4', 'Montcada i Reixac');
       
INSERT INTO supplier (supplier_name, supplier_phone_number, supplier_fax_number, supplier_nif, address_supplier_idaddress)
VALUES ('GAFAS Y GAFAS', '930000001', NULL, '12365498A', 1),
	   ('GAFAS DISENOS', '930000002', NULL, '98754162G', 2),
       ('GAFAS RAYSOL', '930000003', NULL, '97360182P', 3),
       ('GAFAS DICOGAF', '930000004', NULL, '25964871E', 4);
       
INSERT INTO customers (`customers_name`,`customers_phone_number`,`customers_mail`,`customers_record_date`,`customers_recommendation`,`address_customer_idaddress`)
VALUES ('Luis Fernandez','666555444','a@ksj.com','2010/03/08',NULL,1),
	   ('Antonio Perez','666999333','p@ksj.com','2010/03/08',NULL,2),
       ('Maria Martin','999666555','o@ksj.com','2010/03/08',NULL,3),
	   ('Federico ','888555111','y@ksj.com','2010/03/08',NULL,4);

INSERT INTO sale (sale_seller_name, sale_date, customers_idcustomers)
VALUES ('Eva Gonzalez', '2010/03/09', 1),
	   ('Diego Cervantes', '2021/01/05', 2), 
       ('Diego Cervantes', '2020/07/20', 1),
       ('Diego Cervantes', '2021/09/06', 3),
       ('Eva Gonzalez', '2022/11/18', 4);
       
INSERT INTO glasses (`glasses_brand`,`glasses_graduation_left_eye`,`glasses_graduation_right_eye`,`glasses_frame_type`,`glasses_frame_color`,`glasses_lenses_color`,`glasses_price`,`supplier_supplier_id`,`sale_sale_id`)
VALUES 	('cuco','0.25', '0.20', 'completa metal', 'negras','azul', '795', 1, 1),
		('noche','0.37', '0.25', 'al aire', 'gris','verde', '795', 2, 3),
        ('verano','0.45', '0.50', 'completa plastico', 'blancas','azul', '795', 1, 2),
        ('hielo','5.25', '4.75', 'semi metal', 'marron','verde', '795', 4, 4),
        ('amazna','2.25', '1.75', 'al aire', 'gris','azul', '795', 3, 5);

