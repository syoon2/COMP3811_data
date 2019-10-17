select * from
    (select id,name,dept_name,salary
     from in_dep) as i
  natural join
    (select dept_name,building,budget
     from in_dep) as d;

select * from
  (select id,name from emp1) as one
  natural join
  (select name,street,city,salary from emp2) as two;
