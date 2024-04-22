# -- The ratio of male to female customers is about 68:32, using the data the store has on female customers,
# -- what strategy do you recommend the store puts in place to attract more female customers.

with total as (
SELECT gender, count(`Customer ID`)  as customer FROM retai_sales.shopping_trends_updated
group by 1 order by 2 desc)
select 
  sum(case when gender= 'male' then customer else 0 end) count_male,
  sum(case when gender= 'female' then customer else 0 end) count_female,
  round(sum(case when gender='male' then customer else 0 end)/ 
  (sum(case when gender ='male' then customer else 0 end)+sum(case when gender= 'female' then customer else 0 end))*100,2) pct_male,
  
  round(sum(case when gender='female' then customer else 0 end)/
  (sum(case when gender="male" then customer else 0 end)+sum(case when gender='female' then customer else 0 end))*100,2) pct_female
  from total;
  
  
  # -- What Female Age Group do we mostly serve
  select 
  case when age between 18 and 30 then "18-30"
  when age between 31 and 43 then "31-43"
  when age between 44 and 56 then "44-56"
  when age between 57 and 70 then "57-70"
  end as age_groups,
  count(`Customer ID`) as customers
  FROM retai_sales.shopping_trends_updated
  group by 1
  order by 2 desc;
  
  # -- What is the most and least popular category
  select Category,count(`Customer ID`) as customers FROM retai_sales.shopping_trends_updated
  group by 1 order by 2 desc;
  
  # Most popular item
  SELECT `Item Purchased`,count(`Customer ID`) as customers FROM retai_sales.shopping_trends_updated
  group by 1 order by 2 desc limit 5;
  
  # -- Which season has the most purchases
  SELECT Season,count(`Customer ID`) as customers FROM retai_sales.shopping_trends_updated
  group by 1 order by 2 desc;
  
  # Most popular payment method
  SELECT `Payment Method`,count(`Customer ID`) as customers FROM retai_sales.shopping_trends_updated
  group by 1 order by 2 desc;
  
  # Most popular shipping type
  SELECT `Shipping Type`,count(`Customer ID`) as customers FROM retai_sales.shopping_trends_updated
  group by 1 order by 2 desc;
  
  # -- What is the most popular age group served?
# -- Find the most purchased item by that age group

-- With age_data as(
SELECT

	Case
     when Age between 18 and 30 then '18-30'
     when Age between 31 and 43 then '31-43'
     when Age between 44 and 56 then '44-56'
     when Age between 57 and 70 then '57-70'
	end as age_groups,
    `Item Purchased`,
    -- `Customer ID`,
    count(`Customer ID`) as client_count


FROM retai_sales.shopping_trends_updated
Group by 1,2
Having age_groups = '57-70'
 Order by 3 desc -- )
 ;
 
 
 # -- What is the most popular age group served?
# -- Find the most common payment method used by the most popular age group served.

select

Case
   when Age between 18 and 30 then '18-30'
   when Age between 31 and 43 then '31-43'
   when Age between 44 and 56 then '44-56'
   when Age between 57 and 70 then '57-70'  
end as age_groups,
`Payment Method`,
count(`Customer ID`) as customers

FROM retai_sales.shopping_trends_updated
group by 1,2
having age_groups = '44-56'
Order by 3 desc;