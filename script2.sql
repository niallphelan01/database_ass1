use hospital;

insert into Ward values('orth01', 'St Jades', 'Orthopeadic Ward');
insert into Ward values('stroke01', 'St Lukes', 'Stroke rehab Ward');
insert into Ward values('ger01','St Pats','Geriatric Ward');
insert into Ward values('gen01','St Annes','General Ward');
insert into Ward values ('surg01','St Josephs','Surgical Ward');


insert into Patient values ('p12345','Niall','Test','Coumdubh','Annascaul','Co. Kerry','0863698959','2019-10-10','2019-10-12');
insert into Patient values ('p12346','John','Test','Coumdubh','Annascaul','Co. Kerry','0863698980','2019-10-09','2019-10-12');
insert into Patient values ('p12347','Amy','Test','Coumdubh','Annascaul','Co. Kerry','0863698981','2019-10-08','2019-10-12');
insert into Patient values ('p12348','Donna','Test','Coumdubh','Annascaul','Co. Kerry','0863698982','2019-10-02', null);
insert into Patient values ('p12349','Jackie','Test','Coumdubh','Annascaul','Co. Kerry','0863698983','2019-10-01', null);


insert into Drug values ('t123234', 'Carbara', 'placebo');
insert into Drug values ('b1221', 'Zanex', 'Relaxant');
insert into Drug values ('1221ghed', 'Molipaxin', 'antidepressants');
insert into Drug values ('cal0123', 'Calpol', 'Pain killer');

insert into Doctor values ('12323423V', 'Tom','Molloy', 'Mainstreet', 'Annascaul', 'Co. Kerry', '066-977343', '2019-01-01','Orthopeadic');
insert into Doctor values ('12329898V', 'John','Barber', 'Sandy cove', 'Lixnaw', 'Co. Kerry', '066-979833', '2019-01-01','Orthopeadic');
insert into Doctor values ('12323872M', 'Mary','Brien', 'Main street', 'Listowel', 'Co. Kerry', '066-978343', '2019-01-01','Orthopeadic');

insert into Bed (bedNumber,bedType, wardID, patientID) values (1, 'standard', 'stroke01','p12345');
insert into Bed (bedNumber,bedType, wardID, patientID) values (2, 'water', 'stroke01','p12346');
insert into Bed (bedNumber,bedType, wardID, patientID) values (3, 'hot air', 'stroke01','p12347');
insert into Bed (bedNumber,bedType, wardID, patientID) values (21, 'hot air', 'ger01','p12348');
insert into Bed (bedNumber,bedType, wardID, patientID) values (24, 'hot air', 'surg01','p12349');

select fName,lName,arriveDate, bed.bedNumber
from Patient
natural join Bed;


/* complete a check for current paitents i.e. patients with no discharge date and list them along with their bed number ward number and ward descritption */
select concat( fName,' ', lName) as Name, date_format(arriveDate, '%W %M %D, %Y') as "Arrival Date" , bed.bedNumber, Ward.wardName, Ward.wardType
from patient
natural join Bed   /*Natural join can be used as field names are the same*/
natural join Ward
where dischargeDate is null
order by lName,fName;

/* Total number of patients that have been through the hospital*/
select count(patientID) as "Total number of patients" from Patient;
/*Number of current patients in the hospital*/
select count(patientID) as "Current number of patients" from Patient where dischargeDate is null;

select concat( fName,' ', lName), datediff(dischargeDate, arriveDate) as "Number of days in hospital"  from Patient;

desc patient;