UC-6: For ‘Category penetration’, use 'transaction_loyalty' and 'transaction_loyalty_lineitem' table and
display the following column records i.e. category, number of Bills, number of customers , total Sales
and ”total quantity sold” category wise.
-----------------------------------------------------------

select * from product_master where item_sku = '5311HD'
select * from transaction_log_loyalty_lineitem


select 
	pm.category as Category, 
	count(tlll.bill_date) as Bills, 
	count(tlll.user_id) as Customers, 
	sum(tlll.net_amount) as Sales, 
	sum(tlll.qty) as Qty_sold
	from product_master pm
	inner join transaction_log_loyalty_lineitem tlll
	ON tlll.item_code = pm.item_sku
	group by pm.category
	order by pm.category

select pm.category as Category, count(tlll.bill_date) as Bills, count(tlll.user_id) as Customers, sum(tlll.item_rate) as Sales, sum(tlll.qty) as Qty_sold
from product_master pm
inner join transaction_log_loyalty_lineitem tlll
ON tlll.item_code = pm.item_sku
group by pm.category
order by pm.category