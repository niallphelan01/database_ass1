use hospital;

/*create an index on Visits as this could speed up such a search*/
create index visitDateind on visit(date);
create index patientind on patient(patientID);
/*script to show the indexes from a visit*/
show index from visit;
show index from patient;
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
/*show the view of the currentPrescriptionbyPatient*/
SELECT * FROM hospital.currentprescriptionbypatient;

/*current time and date*/
SELECT DATE_FORMAT(CURDATE(), '%Y-%m-%d') todaysDate;
select Date_format(Now(),'%H:%i:%s') todaysTime;



create table Visit_audit(
visitID varchar(15),
patientID varchar(9),
PPS varchar (15),
changedate DATETIME Default NULL,
action VARCHAR(50) default null
);

DELIMITER $$
create trigger TriggerForVisitUpdate
     before update on visit
     for each row
BEGIN
   insert into visit_audit
   set action = 'update visit',
   visitID = OLD.visitID,
   patientID=OLD.patientID,
   PPS=OLD.PPS,
   changedate=NOW();
 END $$
DELIMITER ; 

/*lets say that there was an issue where the doctor on visits was used was 12323873M rather than 12323423V, we backup and then use the new pps number*/
update visit 
set visit.PPS = '12323873M'
where visit.PPS = '12323423V' ;

/*show the triggers */
show triggers;
/*drop the specific trigger*/
drop trigger TriggerForVisitUpdate;


insert into visit values('a1c368','p12351', '12323423V','2019-10-12', '10:39:59');



select * from prescription;


select fName,lName,arriveDate, bed.bedNumber
from Patient
natural join Bed;


/* complete a check for current paitents i.e. patients with no discharge date and list them along with their bed number ward number and ward descritption */
create view currentPatientListview as
select concat( fName,' ', lName) as Name, date_format(arriveDate, '%W %M %D, %Y') as "Arrival Date" , bed.bedNumber as "Bed No.", Ward.wardName as "Ward Name", Ward.wardType
from patient
natural join Bed   /*Natural join can be used as field names are the same*/
natural join Ward
where dischargeDate is null
order by lName,fName;
/*view the currentPAtientListView*/
SELECT * FROM hospital.currentpatientlistview;

/* Total number of patients that have been through the hospital*/
select count(patientID) as "Total number of patients" from Patient;

/*Number of current patients in the hospital*/
select count(patientID) as "Current number of patients" from Patient where dischargeDate is null;

/*Show the list of the number of days a patient was in hospital for only discharged patients*/
select concat( fName,' ', lName), datediff(dischargeDate, arriveDate) as "Number of days in hospital"  from Patient
where dischargeDate is not null;


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
drop user HospitalAdmin;

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

/*drop the Doctoruser*/
drop user Doctor;


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


