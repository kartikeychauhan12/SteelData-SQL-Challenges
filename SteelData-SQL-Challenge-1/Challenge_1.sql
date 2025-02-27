
--1. What are the details of all cars purchased in the year 2022?

  select c.* , s.sale_id,s.salesman_id,s.purchase_date  from cars c
  inner join
  sales s on c.car_id=s.car_id
  where DATEPART(year,s.purchase_date) = '2022'
  order by s.car_id;


--2. What is the total number of cars sold by each salesperson?

 select sp.salesman_id ,sp.name, count(sale_id) as car_sold from salespersons sp
 inner join
 sales s on sp.salesman_id=s.salesman_id
 group by sp.salesman_id ,sp.name;


--3. What is the total revenue generated by each salesperson?

  with cte as
  (select s.salesman_id,count(s.sale_id) as car_sold,sum(cost_$) as total_revenue from cars c
  inner join
  sales s on c.car_id=s.car_id
  group  by  s.salesman_id )
  select c.salesman_id ,sp.name,c.total_revenue from cte c
  inner join
  salespersons sp on sp.salesman_id=c.salesman_id ;


--4. What are the details of the cars sold by each salesperson?
  
  with cte_1 as
  (select s.salesman_id,c.* from cars c
  inner join
  sales s on c.car_id=s.car_id)
  select  sp.name, c1.* from cte_1 c1
  inner join
  salespersons sp on sp.salesman_id=c1.salesman_id ;


--5. What is the total revenue generated by each car type?
  
  select type,sum(cost_$) as total_revenue from cars c
  inner join 
  sales s on s.car_id=c.car_id
  group by type;


--6. What are the details of the cars sold in the year 2021 by salesperson 'Emily Wong'?
  
  with cte_2 as
  (select s.salesman_id ,s.purchase_date,c.car_id,c.make,c.type,c.style,c.cost_$ from cars c
  inner join
  sales s on c.car_id=s.car_id)
  select  sp.name ,c2.car_id,c2.make,c2.type,c2.style,c2.cost_$  from cte_2 c2
  inner join
  salespersons sp on sp.salesman_id=c2.salesman_id
  where sp.name = 'Emily Wong' and DATEPART(YEAR,purchase_date) = '2021' ;


--7. What is the total revenue generated by the sales of hatchback cars?

  select style,sum(cost_$) as total_revenue from cars c
  inner join 
  sales s on s.car_id=c.car_id
  where style = 'hatchback'
  group by style;


--8. What is the total revenue generated by the sales of SUV cars in the year 2022?

  select style,sum(cost_$) as total_revenue from cars c
  inner join 
  sales s on s.car_id=c.car_id
  where style = 'Suv' and DATEPART(YEAR,purchase_date)='2022'
  group by style;


--9. What is the name and city of the salesperson who sold the most number of cars in the year 2023?

  select top 1  sp.name, sp.city, count(sale_id) as car_sold  from salespersons sp
  inner join
  sales s on sp.salesman_id=s.salesman_id
  where DATEPART(YEAR,purchase_date)= '2023'
  group by  sp.name,sp.city 
  order by car_sold desc ;


--10. What is the name and age of the salesperson who generated the highest revenue in the year 2022?

  with cte_3 as
  (select s.salesman_id,count(s.sale_id) as car_sold,sum(cost_$) as total_revenue from cars c
  inner join
  sales s on c.car_id=s.car_id
  where DATEPART(YEAR,purchase_date)= '2022'
  group  by  s.salesman_id )
  select top 1 sp.name, sp.age , c3.total_revenue  from cte_3 c3
  inner join
  salespersons sp on sp.salesman_id=c3.salesman_id
  order by total_revenue desc

