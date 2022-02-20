create Database TravelOnTheGo;
use TravelOnTheGo;
create table Passanger
(Passanger_name varchar(50),
category varchar(15),
Gender varchar(1),
Boarding_city varchar(25),
Destination_city varchar(25),
Distance int,
Bus_type varchar(10)
);
create table price
(Bus_type varchar(10),
Distance int,
Price int
);

insert into passanger values('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
insert into passanger values('Anmol', 'Non-AC' ,'M','Mumbai', 'Hyderabad', 700, 'Sitting');
insert into passanger values('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
insert into passanger values('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
insert into passanger values('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper');
insert into passanger values('Ankur', 'AC', 'M' ,'Nagpur', 'Hyderabad', 500 ,'Sitting');
insert into passanger values('Hemant', 'Non-AC' ,'M', 'panaji', 'Mumbai', 700 ,'Sleeper');
insert into passanger values('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500 ,'Sitting');
insert into passanger values('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');
insert into PRICE  VALUES ('Sleeper', 350, 770);
insert into PRICE  VALUES ('Sleeper', 500, 1100);
insert into PRICE  VALUES ('Sleeper', 600, 1320);
insert into PRICE  VALUES ('Sleeper', 700, 1540);
insert into PRICE  VALUES ('Sleeper', 1000, 2200);
insert into PRICE  VALUES ('Sleeper', 1200, 2640);
insert into PRICE  VALUES ('Sleeper', 350, 434);
insert into PRICE  VALUES ('Sitting', 500, 620);
insert into PRICE  VALUES ('Sitting', 500, 620);
insert into PRICE  VALUES ('Sitting', 600, 744);
insert into PRICE  VALUES ('Sitting', 700, 868);
insert into PRICE  VALUES ('Sitting', 1000, 1240);
insert into PRICE  VALUES ('Sitting', 1200, 1488);
insert into PRICE  VALUES ('Sitting', 1500, 1860);
/*How many females and how many male passengers travelled for a minimum distance of 600 KM s?*/
Select Gender, count(*) from passanger where Distance >= 600 group by gender;

/*Find the minimum ticket price for Sleeper Bus.*/
select min(price) from price where bus_type = 'sleeper';

/*Select passenger names whose names start with character 'S' */
Select * from passanger where Passanger_name like 'S%';

rename table price to price_table;

/*Calculate price charged for each passenger displaying Passenger name, Boarding City, 
Destination City, Bus_Type, Price in the output*/

SELECT
    p.Passanger_name,
    p.Boarding_city,
    p.Destination_City,
    p.Bus_type,
    pt.Price
FROM
    TravelOnTheGo.Passanger p
INNER JOIN TravelOnTheGo.price_table pt
    ON pt.distance = p.distance
    group by p.Passanger_name;
    

/*What are the passenger name/s and his/her ticket price who travelled in the Sitting bus 
for a distance of 1000 KM s*/

Select psg.Passanger_name, pt.Price from TravelOnTheGo.Passanger as psg 
join TravelOnTheGo.Price_table as pt on
psg.Bus_type = pt.Bus_type  
where psg.Distance >1000 and psg.Bus_Type = 'Sitting';

/*What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to 
Panaji?*/

select psg.Passanger_name, psg.Boarding_city , psg.Destination_city ,
psg.Boarding_city, pt.Bus_type, pt.Price FROM TravelOnTheGo.Passanger as psg inner join TravelOnTheGo.price_table as pt USING (distance)
where ((psg.Boarding_city='Bengaluru' and psg.Destination_city='Panaji')
or (psg.Boarding_city='Panaji' and psg.Destination_city='Bengaluru'));

/*List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
*/

select distinct(Distance) 
from TravelOnTheGo.Passanger
order by Distance desc;

/*Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables*/

select passanger_name, (distance/(SELECT sum(distance) from TravelOnTheGo.Passanger))*100 as percentage
from TravelOnTheGo.Passanger;

/*Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise */

SELECT passanger.distance, price_table.price,
CASE
	WHEN price_table.price > 1000 THEN "Expensive"
    WHEN price_table.price < 1000 and price > 500 THEN "Average_Cost"
    ELSE "Cheap" 
END as price_table_Catergory
FROM TravelOnTheGo.Passanger join TravelOnTheGo.price_table on Passanger.distance = price_table.distance
group by passanger.distance;
