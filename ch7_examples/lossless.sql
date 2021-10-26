drop table if exists r;
drop table if exists r1;
drop table if exists r2;
create table r (a char(1), b char(1), c char(1));
insert into r (a,b,c) values ('α', '1', 'A'), ('β', '2', 'B');
select a,b into r1 from r;
select b,c into r2 from r;

select * from
  (select a,b from r1) as one
  natural join
  (select b,c from r2) as two;
