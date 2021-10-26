select * from
    (select id,name,dept_name,salary
     from in_dep) as i
  natural join
    (select dept_name,building,budget
     from in_dep) as d;

select * from
  (select * from emp1) as one
  natural join
  (select * from emp2) as two;

select * from
  (select * from emp3) as one
  natural join
  (select * from emp4) as two;
