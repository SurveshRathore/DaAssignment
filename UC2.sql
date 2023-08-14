UC-2: Write a complex query on 'transaction_loyalty' and 'transaction_loyalty_lineitem' to fetch User Id,
Total Spend, Total Bills, Total Visits, Last Transaction Date, First Transaction Date, First Transaction Store,
Last Transaction Store, Favourite Store and Total Qty Purchased for 'Customer Single View'.
Use 'transaction_loyalty' and 'transaction_loyalty_lineitem' table and Display above mentioned result
set in UC2.
---------------------------------------------------------------------------------------------------------------
use DaAssignmet

create view UC2_Customer_Single_View
AS
select 
	t.user_id as User_id,
	sum(t.amount-t.discount) as Total_spend, 
	sum(t.amount) as Total_bill, 
	count(*) as Total_Visits, 
	min(t.txn_date) as first_transaction_date, 
	max(t.txn_date) as last_transaction_date,
	min(t.store_name) as first_transaction_store, 
	max(t.store_name) as last_transaction_store,
	sum(tlll.qty) as total_quantity_purchased,
	min(st.store_name) as fav_store
	--,t.store_name from transaction_log_loyalty ON (select top 1 store_name from transaction_log_loyalty order by visit_rank desc)
from transaction_log_loyalty t 
inner join transaction_log_loyalty_lineitem tlll ON tlll.user_id = t.user_id
left join (select user_id, store_name from transaction_log_loyalty ) st on t.user_id = st.user_id
group by t.user_id


------------------original query
select 
	t.user_id as User_id,
	sum(t.amount-t.discount) as Total_spend, 
	sum(t.amount) as Total_bill, 
	count(*) as Total_Visits, 
	min(t.txn_date) as first_transaction_date, 
	max(t.txn_date) as last_transaction_date,
	min(t.store_name) as first_transaction_store, 
	max(t.store_name) as last_transaction_store,
	sum(tlll.qty) as total_quantity_purchased,
	min(st.store_name) as fav_store
	--,t.store_name from transaction_log_loyalty ON (select top 1 store_name from transaction_log_loyalty order by visit_rank desc)
from transaction_log_loyalty t 
inner join transaction_log_loyalty_lineitem tlll ON tlll.user_id = t.user_id
left join (select user_id, store_name from transaction_log_loyalty ) st on t.user_id = st.user_id
group by t.user_id
order by t.user_id



