select * from retail_transaction.chohort_analysis limit 5;

-- Checking for null values
select * 
from `retail_transaction.chohort_analysis` 
where Customer_Name is NULL
OR Product is NULL
OR Total_Items is NULL
OR Total_Cost is NULL
OR Payment_Method IS NULL
OR Store_Type IS NULL
OR Discount_Applied IS NULL
OR Customer_Category IS NULL
OR Season IS NULL
OR Promotion IS NULL;

-- The dataset ranges from which year to which year
select distinct extract(year from Date),
count(*) as year_count
from `retail_transaction.chohort_analysis`
group by 1
order by 2 desc;



