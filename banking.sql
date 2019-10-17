drop table if exists borrower;
drop table if exists loan;
drop table if exists depositor;
drop table if exists account;
drop table if exists customer;
drop table if exists branch;

create table branch (
  branch_name varchar(10) not null,
  branch_city varchar(10),
  assets numeric(11,2),
  primary key (branch_name)
);

create table customer (
  id char(5),
  customer_name varchar(20) not null,
  customer_street varchar(20),
  customer_city varchar(10),
  primary key (ID)
);

create table loan (
  loan_number varchar(5) not null,
  branch_name varchar(10),
  amount numeric(11,2),
  primary key (loan_number)
);

create table borrower (
  id char(5) not null,
  loan_number varchar(5) not null,
  primary key (ID, loan_number)
);

create table account (
  account_number char(5) not null,
  branch_name varchar(10),
  balance numeric(11,2),
  primary key (account_number)
);

create table depositor (
  id char(5) not null,
  account_number char(5) not null,
  primary key (ID, account_number)
);

ALTER TABLE "account" ADD FOREIGN KEY ("branch_name") REFERENCES "branch" ("branch_name");
ALTER TABLE "loan" ADD FOREIGN KEY ("branch_name") REFERENCES "branch" ("branch_name");
ALTER TABLE "depositor" ADD FOREIGN KEY ("id") REFERENCES "customer" ("id");
ALTER TABLE "borrower" ADD FOREIGN KEY ("id") REFERENCES "customer" ("id");
ALTER TABLE "borrower" ADD FOREIGN KEY ("loan_number") REFERENCES "loan" ("loan_number");
ALTER TABLE "depositor" ADD FOREIGN KEY ("account_number") REFERENCES "account" ("account_number");

insert into branch values('Brighton', 'Brooklyn', 7100000);
insert into branch values('Downtown', 'Brooklyn', 9000000);
insert into branch values('Mianus', 'Horseneck', 400000);
insert into branch values('North Town', 'Rye', 3700000);
insert into branch values('Perryridge', 'Horseneck', 1700000);
insert into branch values('Pownal', 'Bennington', 300000);
insert into branch values('Redwood', 'Palo Alto', 2100000);
insert into branch values('Round Hill', 'Horseneck', 8000000);
insert into customer values('12355', 'Adams', 'Spring', 'Pittsfield');
insert into customer values('24544', 'Brooks', 'Senator', 'Brooklyn');
insert into customer values('34675', 'Curry', 'North', 'Rye');
insert into customer values('23777', 'Glenn', 'Sand Hill', 'Woodside');
insert into customer values('97363', 'Green', 'Walnut', 'Stamford');
insert into customer values('65737', 'Hayes', 'Main', 'Harrison');
insert into customer values('17677', 'Johnson', 'Alma', 'Palo Alto');
insert into customer values('12345', 'Jones', 'Main', 'Harrison');
insert into customer values('43465', 'Lindsay', 'Park', 'Pittsfield');
insert into customer values('79426', 'Smith', 'North', 'Rye');
insert into customer values('12733', 'Turner', 'Putnam', 'Stamford');
insert into customer values('95425', 'Williams', 'Nassau', 'Princeton');
insert into account values('A-101', 'Downtown', 500);
insert into account values('A-102', 'Perryridge', 400);
insert into account values('A-201', 'Brighton', 900);
insert into account values('A-215', 'Mianus', 700);
insert into account values('A-217', 'Brighton', 750);
insert into account values('A-222', 'Redwood', 700);
insert into account values('A-305', 'Round Hill', 350);
insert into depositor values('65737', 'A-101');
insert into depositor values('17677', 'A-102');
insert into depositor values('17677', 'A-201');
insert into depositor values('12345', 'A-217');
insert into depositor values('43465', 'A-222');
insert into depositor values('79426', 'A-215');
insert into depositor values('12733', 'A-305');
insert into loan values('L-11', 'Round Hill', 900);
insert into loan values('L-14', 'Downtown', 1500);
insert into loan values('L-15', 'Perryridge', 1500);
insert into loan values('L-16', 'Perryridge', 1300);
insert into loan values('L-17', 'Downtown', 1000);
insert into loan values('L-23', 'Redwood', 2000);
insert into loan values('L-93', 'Mianus', 500);
insert into borrower values('12355', 'L-16');
insert into borrower values('34675', 'L-93');
insert into borrower values('65737', 'L-15');
insert into borrower values('17677', 'L-14');
insert into borrower values('12345', 'L-17');
insert into borrower values('79426', 'L-11');
insert into borrower values('79426', 'L-23');
insert into borrower values('95425', 'L-17');
