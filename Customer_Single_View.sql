UC-3: Write a query to save the result of UC-2 to a CSV file.
-------------------------------------------------------
use DaAssignmet

create table Customer_Single_View
(
	User_id int,
	Total_spend decimal, 
	Total_bill decimal, 
	Total_Visits int, 
	first_transaction_date date, 
	last_transaction_date date,
	first_transaction_store varchar(255), 
	last_transaction_store varchar(255),
	fav_store varchar(255),
	total_quantity_purchased varchar(255)
)

insert into Customer_Single_View (
	User_id, 
	Total_spend, 
	Total_bill, 
	Total_Visits, 
	first_transaction_date, 
	last_transaction_date,
	first_transaction_store, 
	last_transaction_store,
	fav_store,
	total_quantity_purchased)
select 
	t.user_id as User_id,
	sum(t.amount-t.discount) as Total_spend, 
	sum(t.amount) as Total_bill, 
	count(*) as Total_Visits, 
	min(t.txn_date) as first_transaction_date, 
	max(t.txn_date) as last_transaction_date,
	min(t.store_name) as first_transaction_store, 
	max(t.store_name) as last_transaction_store,
	min(st.store_name) as fav_store,
	sum(tlll.qty) as total_quantity_purchased
	
from transaction_log_loyalty t 
inner join transaction_log_loyalty_lineitem tlll ON tlll.user_id = t.user_id
left join (select user_id, store_name from transaction_log_loyalty ) st on t.user_id = st.user_id
group by t.user_id
order by t.user_id


select * into [D:\MS SQL\empPayroll\output4.csv]
from UC2_Customer_Single_View


select * into [D:\MS SQL\DA Assignment\output4view.csv]
from UC2_Customer_Single_View

select * into output2.csv
from Customer_Single_View

D:\MS SQL\DA Assignment


select * into samout.csv
from Customer_Single_View


bcp DaAssignmet.Customer_Single_View
out C:\samout.csv -c -T -S (localdb)\MSSQLLocalDB
