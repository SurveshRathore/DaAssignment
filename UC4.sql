UC-4: For ‘ Drop Rate’, Create a Stored procedure and display as ‘Total Visit’ by the user to fetch the
Total time customer visited the store.
Use 'transaction_loyalty' and 'transaction_loyalty_lineitem' table and daily total visits by users.
----------------------------------------------------------------------------------------------------

select store_name, count(*) as occurences from transaction_log_loyalty
group by occurences   
order by occurences desc

select count(*),min(txn_date) as occurences from transaction_log_loyalty
group by visit_rank  
order by occurences desc




select * from transaction_log_loyalty where user_id=95446
select visit_rank, count(*) occurences from transaction_log_loyalty
where visit_rank = 1
group by visit_rank

select distinct visit_rank, count(*) occurences from transaction_log_loyalty
group by visit_rank
order by occurences desc

select visit_rank, count(user_id) occurences from transaction_log_loyalty
group by visit_rank
order by visit_rank

select user_id, sum(visit_rank) occurences from transaction_log_loyalty
group by user_id
order by occurences desc

with CTEEngDuplicateDel AS ( select user_id,visit_rank, ROW_NUMBER() over(partition by visit_rank order by visit_rank ) as rowno  from transaction_log_loyalty )
select * from CTEEngDuplicateDel where rowno > 0 group by visit_rank

select store_id, count(*) occurences from transaction_log_loyalty
group by store_id, store_id order by occurences


select count(*) as occurences from transaction_log_loyalty
group by visit_rank  having visit_rank <2
order by occurences desc



---------------------------UC4
create proc UC4_Drop_Rate
as
BEGIN
	BEGIN TRANSACTION
	BEGIN TRY
	select  visit_rank, count(user_id) occurences from transaction_log_loyalty
	group by visit_rank
	order by visit_rank 
	COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
	print 'error'
	ROLLBACK TRANSACTION
	END CATCH
	
END

exec UC4_Drop_Rate