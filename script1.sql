-- -----------------------------------------------------
-- Drop the 'hospital' database/schema
-- -----------------------------------------------------

DROP SCHEMA IF EXISTS hospital;
-- -----------------------------------------------------
-- Create 'hospital' database/schema and use this database
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Create 'hospital' database/schema and use this database
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS hospital;

USE hospital;

-- -----------------------------------------------------
-- Drop tables
-- -----------------------------------------------------

-- drop table Ward;
-- drop table Patient;
-- drop table Bed;
-- drop table Doctor;
-- drop table Drug;
-- drop table Visit;
-- drop table Prescription;

-- -----------------------------------------------------
-- Create table Ward
-- -----------------------------------------------------

create table [IF NOT EXISTS] Ward (
wardID varchar(9),
wardName varchar(15),
wardType varchar(30),
primary key (wardID)
);

-- -----------------------------------------------------
-- Create table Patient
-- -----------------------------------------------------

create table IF NOT EXISTS] Patient(
patientID varchar(9),
fName varchar(20) not null,
lName varchar(20) not null,
street varchar(20) not null,
town varchar(20) not null,
county varchar(15) not null,
contactNo varchar(10) not null,
arriveDate date,
dischargeDate date,
primary key (patientID)
);

-- -----------------------------------------------------
-- Create table Bed
-- -----------------------------------------------------
create table IF NOT EXISTS] Bed(
bedNumber int,
bedType varchar(15) not null,
wardID varchar(9) not null,
patientID varchar(9) not null,
primary key (bedNumber),
foreign key (wardID) references Ward(wardID) on update cascade on delete cascade,
foreign key (patientID) references Patient(patientID) on update cascade on delete cascade
);

-- -----------------------------------------------------
-- Create table Doctor
-- -----------------------------------------------------
create table IF NOT EXISTS] Doctor(
PPS varchar(15),
fName varchar(20) not null,
lName varchar(20) not null,
street varchar(20) not null,
town varchar(20) not null,
county varchar(15) not null,
contactNo varchar(10) not null,
hireDate date not null,
specialisation varchar(15),
primary key(PPS)
);

-- -----------------------------------------------------
-- Create table Drug
-- -----------------------------------------------------
create table IF NOT EXISTS] Drug(
drugID varchar(15),
drugName varchar(15),
manufacturer varchar(15),
primary key(drugID)
);

-- -----------------------------------------------------
-- Create table Visit
-- -----------------------------------------------------
create table IF NOT EXISTS] Visit(
visitID varchar(15),
patientID varchar(9),
PPS varchar (15),
date date,
time time,
primary key(visitID),
foreign key (patientID) references Patient(patientID) on update cascade on delete cascade,
foreign key (PPS) references Doctor(PPS) on update cascade on delete cascade
);

-- -----------------------------------------------------
-- Create table Prescription
-- -----------------------------------------------------
create table IF NOT EXISTS] Prescription(
visitID varchar(15),
drugID varchar(15),
dosageDetails varchar(100),
primary key (visitID, drugID),
foreign key (visitID) references Visit(visitID) on update cascade on delete cascade,
foreign key (drugID) references Drug(drugID) on update cascade on delete cascade
);

/* Populate tables with data */

/*Ward Table*/
insert into Ward values('orth01', 'St Jades', 'Orthopeadic Ward');
insert into Ward values('stroke01', 'St Lukes', 'Stroke rehab Ward');
insert into Ward values('ger01','St Pats','Geriatric Ward');
insert into Ward values('gen01','St Annes','General Ward');
insert into Ward values ('surg01','St Josephs','Surgical Ward');

/*Patient Table*/
insert into Patient values ('p12345','Niall','Test','Coumdubh','Annascaul','Co. Kerry','0863698959','2019-10-10','2019-10-12');
insert into Patient values ('p12346','John','Test','Coumdubh','Annascaul','Co. Kerry','0863698980','2019-10-09','2019-10-12');
insert into Patient values ('p12347','Amy','Test','Coumdubh','Annascaul','Co. Kerry','0863698981','2019-10-08','2019-10-12');

/*Drug Table*/
insert into Drug values ('t123234', 'Carbara', 'placebo');
insert into Drug values ('b1221', 'Zanex', 'Relaxant');
insert into Drug values ('1221ghed', 'Molipaxin', 'antidepressants');
insert into Drug values ('cal0123', 'Calpol', 'Pain killer');

/*DoctorTable*/
insert into Doctor values ('12323423V', 'Tom','Molloy', 'Mainstreet', 'Annascaul', 'Co. Kerry', '066-977343', '2019-01-01','Orthopeadic');
insert into Doctor values ('12329898V', 'John','Barber', 'Sandy cove', 'Lixnaw', 'Co. Kerry', '066-979833', '2019-01-01','Orthopeadic');
insert into Doctor values ('12323872M', 'Mary','Brien', 'Main street', 'Listowel', 'Co. Kerry', '066-978343', '2019-01-01','Orthopeadic');

/*BedTable*/
insert into Bed (bedNumber,bedType, wardID, patientID) values (1, 'standard', 'stroke01','p12345');
insert into Bed (bedNumber,bedType, wardID, patientID) values (2, 'water', 'stroke01','p12346');
insert into Bed (bedNumber,bedType, wardID, patientID) values (3, 'hot air', 'stroke01','p12347');