use hospital;

insert into Ward values('orth01', 'St Jades', 'Orthopeadic Ward');
insert into Ward values('stroke01', 'St Lukes', 'Stroke rehab Ward');
insert into Ward values('ger01','St Pats','Geriatric Ward');
insert into Ward values('gen01','St Annes','General Ward');
insert into Ward values ('surg01','St Josephs','Surgical Ward');


insert into Patient values ('p12345','Niall','Test','Coumdubh','Annascaul','Co. Kerry','0863698959','2019-10-10','2019-10-12');
insert into Patient values ('p12346','John','Test','Coumdubh','Annascaul','Co. Kerry','0863698980','2019-10-09','2019-10-12');
insert into Patient values ('p12347','Amy','Test','Coumdubh','Annascaul','Co. Kerry','0863698981','2019-10-08','2019-10-12');
insert into Patient values ('p12348','Donna','Test','Coumdubh','Annascaul','Co. Kerry','0863698982','2019-10-02', null); /*patient still present*/ 
insert into Patient values ('p12349','Jackie','Test','Coumdubh','Annascaul','Co. Kerry','0863698983','2019-10-01', null); /*patient still present*/
insert into Patient values ('p12350','Marcus','Test','Coumdubh','Annascaul','Co. Kerry','0863698985','2019-10-28', null); /*patient still present*/ 
insert into Patient values ('p12351','Jonnie','Test','Coumdubh','Annascaul','Co. Kerry','0863698988','2019-11-01', null); /*patient still present*/


insert into Drug values ('t123234', 'Carbara', 'placebo');
insert into Drug values ('b1221', 'Zanex', 'Relaxant');
insert into Drug values ('1221ghed', 'Molipaxin', 'antidepressants');
insert into Drug values ('cal0123', 'Calpol', 'Pain killer');
insert into Drug values ('pan0123','Panadol','Pain Killer');
insert into Drug values ('lac4323', 'PruneJuice','Laxitive');


insert into Doctor values ('12323423V', 'Tom','Molloy', 'Mainstreet', 'Annascaul', 'Co. Kerry', '066-977343', '2019-01-01','Orthopeadic');
insert into Doctor values ('12329898V', 'John','Barber', 'Sandy cove', 'Lixnaw', 'Co. Kerry', '066-979833', '2019-01-01','Orthopeadic');
insert into Doctor values ('12323872M', 'Mary','Brien', 'Main street', 'Listowel', 'Co. Kerry', '066-978343', '2019-01-01','Orthopeadic');
insert into Doctor values ('12323873M', 'Richard',' Men', 'Main street', 'Listowel', 'Co. Kerry', '066-978344', '2019-07-01','Cardio');
insert into Doctor values ('12323877M', 'Robbie',' Thomson', 'Mary street', 'Listowel', 'Co. Kerry', '066-976344', '2019-08-01','General');


insert into Bed (bedNumber,bedType, wardID, patientID) values (1, 'standard', 'stroke01','p12345');
insert into Bed (bedNumber,bedType, wardID, patientID) values (2, 'water', 'stroke01','p12346');
insert into Bed (bedNumber,bedType, wardID, patientID) values (3, 'hot air', 'stroke01','p12347');
insert into Bed (bedNumber,bedType, wardID, patientID) values (21, 'hot air', 'ger01','p12348');
insert into Bed (bedNumber,bedType, wardID, patientID) values (24, 'hot air', 'surg01','p12349');
insert into Bed (bedNumber,bedType, wardID, patientID) values (24, 'standard', 'surg01','p12349');
insert into Bed (bedNumber,bedType, wardID, patientID) values (25, 'private', 'surg01','p12350');
insert into Bed (bedNumber,bedType, wardID, patientID) values (4, 'shared', 'surg01','p12351');

insert into Visit values('a1234','p12345', '12323423V','2019-10-10', '10:15:59');

/*Visit table*/
insert into Visit values('a1234','p12345', '12323423V','2019-10-10', '10:15:59');
/*Prescription table*/
insert into Prescription values ('a1234', 't123234', 'take 2 a day before breakfast');
/*create an index on Visits as this could speed up such a search*/
create index visitDateind on visit(date);
/*script to show the indexes from a visit*/
show index from visit;
select * from visit;


/* list of current patient Prescriptions likr a certain last name*/
create view CurrentPrescriptionbyPatient as
select concat(patient.fname, ' ', patient.lname) as "Patient Name", concat(Doctor.fName, ' ', Doctor.lName) as "Dr Prescribing Drug", drug.drugName as "Medication", prescription.dosageDetails as "Medication to be taken", concat(visit.date, '  ', visit.time) as "Prescribed on:" 
from patient join visit
on patient.patientID = visit.patientID
join doctor
on visit.PPS = doctor.PPS
join prescription
on visit.visitID=prescription.visitID
join drug
on prescription.drugID=drug.drugID
where patient.lname like '%Te%';

select * from prescription;


select fName,lName,arriveDate, bed.bedNumber
from Patient
natural join Bed;


/* complete a check for current paitents i.e. patients with no discharge date and list them along with their bed number ward number and ward descritption */
create currentpatientlistview CurrentPatientList as
select concat( fName,' ', lName) as Name, date_format(arriveDate, '%W %M %D, %Y') as "Arrival Date" , bed.bedNumber as "Bed No.", Ward.wardName as "Ward Name", Ward.wardType
from patient
natural join Bed   /*Natural join can be used as field names are the same*/
natural join Ward
where dischargeDate is null
order by lName,fName;`Patient Name`currentprescriptionbypatient

/* Total number of patients that have been through the hospital*/
select count(patientID) as "Total number of patients" from Patient;
/*Number of current patients in the hospital*/
select count(patientID) as "Current number of patients" from Patient where dischargeDate is null;

select concat( fName,' ', lName), datediff(dischargeDate, arriveDate) as "Number of days in hospital"  from Patient;


/*Create user statement for administrator*/
create user HospitalAdmin identified by 'admin';
grant select on hospital.* to HospitalAdmin;
grant select, insert, update on Patient.* to HospitalAdmin;
grant select on visit.* to Administrator;
grant select on Prescription.* to Administrator;
grant select on doctor.* to Administrator;
grant select, insert, update on bed.* to Administrator;
grant select,insert, update on ward.* to Administrator;
show grants for HospitalAdmin;

/*drop the HospitalAdmin user*/
drop user Doctor;

/*Create user statement for Doctor*/
create user Doctor identified by 'doc';
grant select on hospital.* to Doctor;
grant select, insert, update on Patient.* to Doctor;
grant select, insert, update on visit.* to Doctor;
grant select, insert, update on Prescription.* to Doctor;
grant select, insert, update on doctor.* to Doctor;
grant select on bed.* to Doctor;
grant select on ward.* to Doctor;
show grants for Doctor;


/*Create user statement for a doctor*/


/*revoke all privlages*/



desc patient;
/*To DO's
Add more data especially for visits and prescriptions
Add a trigger statement
Add additional index statements
Create users and grant privilages for them etc (doctor at least) 
Create a list of frequently used queries on the db


- where, along with some combination of like, in, not in, between...and, is null, etc.
- sort using order by
- an aggregate function
- a join between two or more tables
- a subquery
*/


