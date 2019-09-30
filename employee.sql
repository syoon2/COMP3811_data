drop table if exists works;
drop table if exists manages;
drop table if exists company;
drop table if exists employee;

create table employee(
  id char(5),
  person_name varchar(30),
  street varchar(30),
  city varchar(30),
  primary key(id)
);

create table works(
  id char(5),
  company_name varchar(30),
  salary numeric(8,2),
  primary key(id)
);

create table company(
  company_name varchar(30),
  city varchar(30),
  primary key(company_name)
);

create table manages(
  id char(5),
  manager_id char(5),
  primary key(id)
);

ALTER TABLE manages ADD CONSTRAINT manages_id_fkey FOREIGN KEY (id) REFERENCES employee(id);
ALTER TABLE manages ADD CONSTRAINT manages_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES employee(id);
ALTER TABLE works ADD CONSTRAINT works_company_name_fkey FOREIGN KEY (company_name) REFERENCES company(company_name);
ALTER TABLE works ADD CONSTRAINT works_id_fkey FOREIGN KEY (id) REFERENCES employee(id);

insert into employee values ('85726', 'Adams', 'Ainslie St.', 'Chicago');
insert into employee values ('75205', 'Addison', 'Church St.', 'New York');
insert into employee values ('19632', 'Bruus', 'Bowler St.', 'Chicago');
insert into employee values ('53051', 'Bryant', 'Broad St.', 'New York');
insert into employee values ('72369', 'Carpenter', 'Churchill St.', 'Washington');
insert into employee values ('36509', 'Gimbert', 'Bowler St.', 'Washington');
insert into employee values ('23608', 'Grosvenor', 'Addison St.', 'New York');
insert into employee values ('41164', 'Gulley', 'Ainslie St.', 'Chicago');
insert into employee values ('81818', 'Hancock', 'Aldine Ave.', 'Washington');
insert into employee values ('81443', 'Hankey', 'Alexander St.', 'New York');
insert into employee values ('86461', 'Hawkins', 'Altgeld St.', 'Chicago');
insert into employee values ('40906', 'Henson', 'Ancona St.', 'Washington');
insert into employee values ('60459', 'Homer', 'Bloomingdale Ave.', 'New York');
insert into employee values ('33543', 'Jones', 'Blue Island Ave.', 'Chicago');
insert into employee values ('57148', 'Kelly', 'Bonaparte St.', 'Washington');
insert into employee values ('58337', 'Roberts', 'Bowler St.', 'New York');
insert into employee values ('50302', 'Rushton', 'Brighton Pl.', 'Chicago');
insert into employee values ('45972', 'Ryder', 'Broad St.', 'Washington');
insert into employee values ('45716', 'Sinclair', 'Church St.', 'New York');
insert into employee values ('86696', 'Slater', 'Churchill St.', 'Chicago');
insert into employee values ('73719', 'Smith', 'Cicero Ave.', 'New York');
insert into employee values ('75079', 'Spooner', 'Dickens Ave.', 'Washington');
insert into employee values ('68527', 'Stewart', 'Dobson Ave.', 'Chicago');
insert into employee values ('81338', 'Stokes', 'Dominick St.', 'Washington');
insert into employee values ('73506', 'Sutton', 'Altgeld St.', 'New York');
insert into employee values ('29400', 'Thomas', 'Bowler St.', 'Chicago');
insert into employee values ('87957', 'Tilstone', 'Church St.', 'Chicago');
insert into company values ('Bank of America', 'Chicago');
insert into company values ('California Federal Bank', 'New York');
insert into company values ('First Capital Bank', 'Chicago');
insert into company values ('Small Bank Corparation', 'New York');
insert into company values ('First Bank Corporation', 'Washington');
Insert into works values ('19632','Bank of America', 30000);
Insert into works values ('23608','Bank of America', 33000);
Insert into works values ('86461','Bank of America', 29000);
Insert into works values ('73506','Bank of America', 27000);
Insert into works values ('29400','Bank of America', 34000);
Insert into works values ('87957','Bank of America', 36000);
Insert into works values ('85726','Bank of America', 63000);
Insert into works values ('75205','California Federal Bank', 34000);
Insert into works values ('81443','California Federal Bank', 29000);
Insert into works values ('75079','California Federal Bank', 29000);
Insert into works values ('68527','California Federal Bank', 32000);
Insert into works values ('81338','California Federal Bank', 31000);
Insert into works values ('72369','California Federal Bank', 58000);
Insert into works values ('41164','First Capital Bank', 28000);
Insert into works values ('45716','First Capital Bank', 32000);
Insert into works values ('86696','First Capital Bank', 36000);
Insert into works values ('73719','First Capital Bank', 34000);
Insert into works values ('36509','First Capital Bank', 57000);
Insert into works values ('53051','Small Bank Corparation', 30000);
Insert into works values ('58337','Small Bank Corparation', 28000);
Insert into works values ('50302','Small Bank Corparation', 33000);
Insert into works values ('45972','Small Bank Corparation', 36000);
Insert into works values ('81818','Small Bank Corparation', 61000);
Insert into works values ('40906','First Bank Corporation', 31000);
Insert into works values ('60459','First Bank Corporation', 27000);
Insert into works values ('57148','First Bank Corporation', 29000);
Insert into works values ('33543','First Bank Corporation', 59000);
Insert into manages values ('75205','72369');
Insert into manages values ('19632','85726');
Insert into manages values ('53051','81818');
Insert into manages values ('23608','85726');
Insert into manages values ('41164','36509');
Insert into manages values ('81443','72369');
Insert into manages values ('86461','85726');
Insert into manages values ('40906','33543');
Insert into manages values ('33543','57148');
Insert into manages values ('57148','60459');
Insert into manages values ('58337','81818');
Insert into manages values ('50302','81818');
Insert into manages values ('45972','81818');
Insert into manages values ('45716','36509');
Insert into manages values ('86696','36509');
Insert into manages values ('73719','36509');
Insert into manages values ('75079','72369');
Insert into manages values ('68527','72369');
Insert into manages values ('81338','72369');
Insert into manages values ('85726','73506');
Insert into manages values ('29400','85726');
Insert into manages values ('87957','85726');


