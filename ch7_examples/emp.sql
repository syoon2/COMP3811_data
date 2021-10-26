create table emp (id int, name varchar(20), street varchar(20), city varchar(20), salary int);
insert into emp values (57766, 'Kim', 'Main', 'Perryridge', 75000);
insert into emp values (98776, 'Kim', 'North', 'Hampton', 67000);

# Decompose (badly!) into emp1 and emp2
create table emp1 (id int, name varchar(20));
create table emp2 (name varchar(20), street varchar(20), city varchar(20), salary int);
insert into emp1 values (57766, 'Kim');
insert into emp1 values (98776, 'Kim');
insert into emp2 values ('Kim', 'Main', 'Perryridge', 75000);
insert into emp2 values ('Kim', 'North', 'Hampton', 67000);

# Better
create table emp3 (id int, name varchar(20));
create table emp4 (id int, street varchar(20), city varchar(20), salary int);
insert into emp3 values (57766, 'Kim');
insert into emp3 values (98776, 'Kim');
insert into emp4 values (57766, 'Main', 'Perryridge', 75000);
insert into emp4 values (98776, 'North', 'Hampton', 67000);
