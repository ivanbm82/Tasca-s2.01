SELECT c.idcustomers, c.customers_name, g.glasses_brand, g.glasses_price, s.sale_seller_name,s.sale_date

FROM sale As s
INNER JOIN customers As c
On s.customers_idcustomers = c.idcustomers
inner join glasses as g
on g.sale_sale_id = s.sale_id
where c.idcustomers = 1 and s.sale_date BETWEEN '2010-01-01' AND '2012-06-15';

SELECT s.sale_id, s.sale_seller_name, s.sale_date, g.glasses_brand

FROM sale AS s
INNER JOIN glasses AS g
ON g.sale_sale_id = s.sale_id
WHERE s.sale_seller_name = 'Diego Cervantes'
and s.sale_date BETWEEN '2021-01-01' AND '2022-01-01';

SELECT a.supplier_name , g.glasses_brand, s.sale_date

FROM glasses AS g
INNER JOIN supplier AS a
ON g.supplier_supplier_id = a.supplier_id
INNER JOIN sale AS s
ON g.sale_sale_id = s.sale_id;
    
    
