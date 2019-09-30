drop table if exists owns;
drop table if exists participated;
drop table if exists accident;
drop table if exists person;
drop table if exists car;

create table person(
  driver_id char(5),
  name varchar(20) NOT NULL,
  address varchar(20),
  primary key(driver_id)
);

create table car(
  license_plate char(8),
  model varchar(20),
  year numeric(4,0) check (year > 1900 and year < 2100),
  primary key(license_plate)
);

create table owns (
  driver_id char(5),
  license_plate char(8),
  primary key(driver_id, license_plate)
);

create table accident (
  report_number char(5),
  year numeric(4,0) check (year > 1900 and year < 2100),
  location varchar(20),
  primary key(report_number)
);

create table participated (
  report_number char(5),
  license_plate char(8),
  driver_id char(5),
  damage_amount numeric(10,2),
  primary key(report_number, license_plate)
);

ALTER TABLE "owns" ADD FOREIGN KEY ("driver_id") REFERENCES "person" ("driver_id");
ALTER TABLE "owns" ADD FOREIGN KEY ("license_plate") REFERENCES "car" ("license_plate");
ALTER TABLE "participated" ADD FOREIGN KEY ("license_plate") REFERENCES "car" ("license_plate");
ALTER TABLE "participated" ADD FOREIGN KEY ("report_number") REFERENCES "accident" ("report_number");
ALTER TABLE "participated" ADD FOREIGN KEY ("driver_id") REFERENCES "person" ("driver_id");

insert into person values ('85726', 'Adams', 'Ainslie St.');
insert into person values ('75205', 'Addison', 'Church St.');
insert into person values ('19632', 'Bruus', 'Bowler St.');
insert into person values ('53051', 'Bryant', 'Broad St.');
insert into person values ('72369', 'Carpenter', 'Churchill St.');
insert into person values ('36509', 'Gimbert', 'Bowler St.');
insert into person values ('23608', 'Grosvenor', 'Addison St.');
insert into person values ('41164', 'Gulley', 'Ainslie St.');
insert into person values ('81818', 'Hancock', 'Aldine Ave.');
insert into person values ('81443', 'Hankey', 'Alexander St.');
insert into person values ('86461', 'Hawkins', 'Altgeld St.');
insert into person values ('40906', 'Henson', 'Ancona St.');
insert into person values ('60459', 'Homer', 'Bloomingdale Ave.');
insert into person values ('33543', 'Jones', 'Blue Island Ave.');
insert into person values ('57148', 'Kelly', 'Bonaparte St.');
insert into person values ('58337', 'Roberts', 'Bowler St.');
insert into person values ('50302', 'Rushton', 'Brighton Pl.');
insert into person values ('45972', 'Ryder', 'Broad St.');
insert into person values ('45716', 'Sinclair', 'Church St.');
insert into person values ('86696', 'Slater', 'Churchill St.');
insert into person values ('73719', 'Smith', 'Cicero Ave.');
insert into person values ('75079', 'Spooner', 'Dickens Ave.');
insert into person values ('68527', 'Stewart', 'Dobson Ave.');
insert into person values ('81338', 'Stokes', 'Dominick St.');
insert into person values ('73506', 'Sutton', 'Altgeld St.');
insert into person values ('29400', 'Thomas', 'Bowler St.');
insert into person values ('87957', 'Tilstone', 'Church St.');

INSERT INTO car VALUES ('IHB-5305', 'Mitsubishi', 2010);
INSERT INTO car VALUES ('BDH-8144', 'Jeep', 2011);
INSERT INTO car VALUES ('FCF-5833', 'Nissan', 2011);
INSERT INTO car VALUES ('DIH-7507', 'Range Rover', 2016);
INSERT INTO car VALUES ('HCI-8101', 'Fiat', 2009);
INSERT INTO car VALUES ('GEA-5255', 'Kia', 2008);
INSERT INTO car VALUES ('FII-4703', 'BMW', 2014);
INSERT INTO car VALUES ('DGJ-3481', 'Range Rover', 2010);
INSERT INTO car VALUES ('CHD-5295', 'Ford', 2018);
INSERT INTO car VALUES ('FHH-7188', 'Hyundai', 2016);
INSERT INTO car VALUES ('IIE-5112', 'Mazda', 2009);
INSERT INTO car VALUES ('DCH-7464', 'Ford', 2015);
INSERT INTO car VALUES ('AEA-3723', 'Mitsubishi', 2009);
INSERT INTO car VALUES ('FFF-2342', 'Chevrolet', 2011);
INSERT INTO car VALUES ('FCI-6099', 'Chevrolet', 2015);
INSERT INTO car VALUES ('ICB-3882', 'Ford', 2013);
INSERT INTO car VALUES ('FDE-4051', 'Ford', 2018);
INSERT INTO car VALUES ('ACA-5537', 'Mitsubishi', 2014);
INSERT INTO car VALUES ('DCD-5360', 'Tesla', 2017);
INSERT INTO car VALUES ('BBE-2831', 'Dodge', 2014);
INSERT INTO car VALUES ('BIF-1481', 'Mercedes', 2011);
INSERT INTO car VALUES ('FIJ-8189', 'Mitsubishi', 2011);
INSERT INTO car VALUES ('CBH-7180', 'Fiat', 2011);
INSERT INTO car VALUES ('DHC-8972', 'Tesla', 2014);
INSERT INTO car VALUES ('AEI-7733', 'Fiat', 2007);
INSERT INTO car VALUES ('CFH-7278', 'Range Rover', 2013);
INSERT INTO car VALUES ('ADB-1780', 'Hyundai', 2010);
INSERT INTO car VALUES ('HBF-9305', 'Ford', 2011);
INSERT INTO car VALUES ('GFJ-8659', 'Chevrolet', 2007);
INSERT INTO car VALUES ('IDA-2403', 'Mazda', 2013);
INSERT INTO car VALUES ('AHH-4901', 'Range Rover', 2012);
INSERT INTO car VALUES ('BCD-2875', 'Tesla', 2007);
INSERT INTO car VALUES ('BBB-3521', 'Dodge', 2007);
INSERT INTO car VALUES ('CIB-2239', 'Toyota', 2016);
INSERT INTO car VALUES ('BCI-5656', 'Mazda', 2013);
INSERT INTO car VALUES ('HAJ-1341', 'Mazda', 2010);
INSERT INTO car VALUES ('GCD-3564', 'Tesla', 2008);
INSERT INTO car VALUES ('AFD-9301', 'Mazda', 2014);
INSERT INTO car VALUES ('IFH-8632', 'Ford', 2015);
INSERT INTO car VALUES ('ADH-4569', 'Hyundai', 2016);

insert into owns values ('85726', 'IHB-5305');
insert into owns values ('75205', 'BDH-8144');
insert into owns values ('19632', 'FCF-5833');
insert into owns values ('53051', 'DIH-7507');
insert into owns values ('72369', 'HCI-8101');
insert into owns values ('36509', 'GEA-5255');
insert into owns values ('23608', 'FII-4703');
insert into owns values ('41164', 'DGJ-3481');
insert into owns values ('81818', 'CHD-5295');
insert into owns values ('81443', 'FHH-7188');
insert into owns values ('86461', 'IIE-5112');
insert into owns values ('40906', 'DCH-7464');
insert into owns values ('60459', 'AEA-3723');
insert into owns values ('33543', 'FFF-2342');
insert into owns values ('57148', 'FCI-6099');
insert into owns values ('58337', 'ICB-3882');
insert into owns values ('50302', 'FDE-4051');
insert into owns values ('45972', 'ACA-5537');
insert into owns values ('45716', 'DCD-5360');
insert into owns values ('86696', 'BBE-2831');
insert into owns values ('73719', 'BIF-1481');
insert into owns values ('75079', 'FIJ-8189');
insert into owns values ('68527', 'CBH-7180');
insert into owns values ('81338', 'DHC-8972');
insert into owns values ('73506', 'AEI-7733');
insert into owns values ('29400', 'CFH-7278');
insert into owns values ('87957', 'ADB-1780');
insert into owns values ('85726', 'HBF-9305');
insert into owns values ('75205', 'GFJ-8659');
insert into owns values ('19632', 'IDA-2403');
insert into owns values ('53051', 'AHH-4901');
insert into owns values ('72369', 'BCD-2875');
insert into owns values ('36509', 'BBB-3521');
insert into owns values ('23608', 'CIB-2239');
insert into owns values ('41164', 'BCI-5656');
insert into owns values ('81818', 'HAJ-1341');
insert into owns values ('81443', 'GCD-3564');
insert into owns values ('86461', 'AFD-9301');
insert into owns values ('40906', 'IFH-8632');
insert into owns values ('60459', 'ADH-4569');

insert into accident values ('12345', 2010, 'Main St.');
insert into accident values ('57364', 2012, 'Salem St.');
insert into accident values ('29574', 2013, 'York St.');
insert into accident values ('95353', 2016, 'Bridge St.');
insert into accident values ('19377', 2014, 'Main St.');
insert into accident values ('12275', 2013, 'King St.');
insert into accident values ('92305', 2015, 'Charlotte St.');
insert into accident values ('32453', 2018, 'Queens Rd.');

insert into participated values ('12345', 'DCH-7464', '40906', '10000');
insert into participated values ('57364', 'AEA-3723', '60459', '3000');
insert into participated values ('29574', 'FFF-2342', '33543', '4500');
insert into participated values ('95353', 'FCI-6099', '57148', '1300');
insert into participated values ('19377', 'ICB-3882', '58337', '23000');
insert into participated values ('12275', 'FDE-4051', '50302', '4300');
insert into participated values ('92305', 'ACA-5537', '45972', '14000');
insert into participated values ('32453', 'DCD-5360', '45716', '18500');

