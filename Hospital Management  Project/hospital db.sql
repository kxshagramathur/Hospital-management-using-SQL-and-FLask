create database project;
use project;
show tables;

CREATE TABLE doctor
(
  doctor_id VARCHAR(5) NOT NULL,
  doctor_name VARCHAR(15),
  specialization VARCHAR(15),
  PRIMARY KEY (doctor_id)
);
insert into doctor values
('D01','Sanjay Shah','radiologist'),
('D02','Nandini Mehta','opthalmologist'),
('D03','Mahima Singh','ENT'),
('D04','Suchak Amita','cardiologist'),
('D05','Abhay Gokhale','ENT'),
('D06','Suhas Abhay','radiologist'),
('D07','Anita Burde','cardiologist'); 
select * from doctor;

CREATE TABLE staff
(
  staff_id VARCHAR(5) NOT NULL,
  staff_name VARCHAR(15),
  designation VARCHAR(15),
  salary VARCHAR(6),
  PRIMARY KEY (staff_id)
);
insert into staff values
('S01','Ajay','receptionist','15000'),
('S02','rahul','prescription','10000'),
('S03','Ajit','emergency','20000'),
('S04','alka','nurse','15000'),
('S05','Amey','nurse','15000'),
('S06','Deepak','pharmacist','10000'),
('S07','Ankur','watchman','10000');
select * from staff;


CREATE TABLE medical
(
  med_id VARCHAR(5) NOT NULL,
  med_name VARCHAR(15),
  quantity VARCHAR(4),
  exp_date DATE,
  mfg_date DATE,
  staff_id VARCHAR(5),
  PRIMARY KEY (med_id),
  FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);
insert into medical values
('M01','crosine','50','2024-02-01','2025-02-01','S06'),
('M02','Dolo650','60','2025-02-01','2017-02-01','S06'),
('M03','cetrizine','70','2026-02-01','2025-02-01','S06'),
('M04','Dioone','60','2024-02-01','2025-02-01','S06'),
('M05','combiflam','30','2025-02-01','2017-02-01','S06'),
('M06','koflet','70','2026-02-01','2025-02-01','S06'),
('M07','augmentin','10','2026-02-01','2025-02-01','S06');
select * from medical;

CREATE TABLE service
(
  service_id VARCHAR(5) NOT NULL,
  service_name VARCHAR(15),
  cost VARCHAR(6),
  PRIMARY KEY (service_id)
);
insert into service values
('Se01','eye checkup','200'),
('Se02','cardiography','2000'),
('Se03','throat','400'),
('Se04','sonography','1500'),
('Se05','xray','500'),
('Se06','xray checkup','4000'),
('Se07','ear','5000');
select * from service;
show tables;
CREATE TABLE provides
(
  doctor_id VARCHAR(5),
  service_id VARCHAR(5),
  PRIMARY KEY (doctor_id, service_id),
  FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
  FOREIGN KEY (service_id) REFERENCES service(service_id)
);
insert into provides values
('D01','Se05'),
('D02','Se01'),
('D03','Se03'),
('D04','Se02'),
('D05','Se07'),
('D06','Se06'),
('D07','Se04');
select * from provides;

CREATE TABLE prescribes
(
  pres_id VARCHAR(5),
  doctor_id VARCHAR(5),
  med_id VARCHAR(5),
  PRIMARY KEY (pres_id),
  FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
  FOREIGN KEY (med_id) REFERENCES medical(med_id),
  UNIQUE (doctor_id, med_id)
);
insert into prescribes values
('P01','D01','M01'),
('P02','D02','M02'),
('P03','D03','M03'),
('P04','D04','M04'),
('P05','D05','M05'),
('P06','D06','M06'),
('P07','D07','M07');
select * from prescribes;

CREATE TABLE patient_bill
(
  payment_id VARCHAR(5),
  amount VARCHAR(7),
  insurance_availability VARCHAR(1),
  service_id VARCHAR(5),
  med_id VARCHAR(5),
  PRIMARY KEY (payment_id),
  FOREIGN KEY (service_id) REFERENCES service(service_id),
  FOREIGN KEY (med_id) REFERENCES medical(med_id)
);
insert into patient_bill values
('Pa01','1000','1','Se01','M01'),
('Pa02','2000','0','Se02','M02'),
('Pa03','3000','1','Se03','M03'),
('Pa04','4000','1','Se04','M04'),
('Pa05','5000','1','Se05','M05'),
('Pa06','6000','1','Se06','M06'),
('Pa07','7000','0','Se07','M07');
select * from patient_bill;

CREATE TABLE patient
(
  admission_id VARCHAR(5),
  admission_date DATE,
  patient_name VARCHAR(15),
  gender VARCHAR(10),
  DOB DATE,
  blood_group VARCHAR(5),
  payment_id VARCHAR(5),
  PRIMARY KEY (admission_id),
  FOREIGN KEY (payment_id) REFERENCES patient_bill(payment_id)
);
insert into patient values
('ad01','2020-02-01','Rohit','M','1980-02-19','o+','pa01'),
('ad02','2021-03-02','Anjali','F','1990-12-17','a+','pa02'),
('ad03','2021-05-21','Atif','M','1987-09-09','a-','pa03'),
('ad04','2022-12-20','Kaira','F','1999-10-11','ab+','pa04'),
('ad05','2019-11-19','Tia','F','1985-06-01','b-','pa05'),
('ad06','2017-10-13',"Aarav","M","1994-03-15",'b+','pa06'),
('ad07','2023-09-18','Suhani','F','1987-05-15','a+','pa07');

select * from patient;

CREATE TABLE appointment
(
  app_id VARCHAR(5),
  app_date DATE,
  time VARCHAR(5),
  admission_id VARCHAR(5),
  PRIMARY KEY (app_id),
  FOREIGN KEY (admission_id) REFERENCES patient(admission_id)
);
insert into appointment values
('ap01','2020-02-01','1h','ad01'),
('ap02','2021-03-09','2h30m','ad02'),
('ap03','2021-08-01','3h','ad03'),
('ap04','2022-12-20','4h15m','ad04'),
('ap05','2019-11-19','30m','ad05'),
('ap06','2017-12-09','45m','ad06'),
('ap07','2023-11-23','1h15m','ad07');
select * from appointment;

CREATE TABLE laboratory
(
  sample_id VARCHAR(5),
  test_id VARCHAR(5),
  test_name VARCHAR(20),
  sample_name VARCHAR(20),
  test_date DATE,
  status VARCHAR(16),
  staff_id VARCHAR(5),
  admission_id VARCHAR(5),
  PRIMARY KEY (sample_id),
  FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
  FOREIGN KEY (admission_id) REFERENCES patient(admission_id),
  UNIQUE (test_id)
);
insert into laboratory values
('sa01','te01','toxicology test','Blood','2020-02-01','Done','s01','ad01'),
('sa02','te02','Cardiograpgy','Scan','2021-03-09','Not Done','s02','ad02'),
('sa03','te03','blood analysis','Blood','2021-08-01','Not Done','s03','ad03'),
('sa04','te04','brain scanning','Scan','2022-12-20','Done','s04','ad04'),
('sa05','te05','autopsy','Dissection','2019-11-19','Done','s05','ad05'),
('sa06','te06','biopsy','dissection','2017-12-09','Done','s06','ad06'),
('sa07','te07','blood analysis','blood','2023-11-23','Not Done','s07','ad07');
select * from laboratory;
 
CREATE TABLE Room
(
  room_id VARCHAR(5),
  room_type VARCHAR(10),
  room_cost VARCHAR(6),
  staff_id VARCHAR(5),
  admission_id VARCHAR(5),
  PRIMARY KEY (room_id),
  FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
  FOREIGN KEY (admission_id) REFERENCES patient(admission_id)
);
insert into room values
('r01','standard','1000','s01','ad01'),
('r02','premium','8000','s02','ad02'),
('r03','deluxe','3000','s03','ad03'),
('r04','deluxe','3000','s04','ad04'),
('r05','standard','1000','s05','ad05'),
('r06','standard','1000','s06','ad06'),
('r07','premium','8000','s07','ad07');
select * from room;

CREATE TABLE consults
(
  doctor_id VARCHAR(5),
  admission_id VARCHAR(5),
  PRIMARY KEY (doctor_id, admission_id),
  FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
  FOREIGN KEY (admission_id) REFERENCES patient(admission_id)
);
insert into consults values
('D01','ad01'),
('D02','ad02'),
('D03','ad03'),
('D04','ad04'),
('D05','ad05'),
('D06','ad06'),
('D07','ad07');
select * from consults;

CREATE TABLE facility
(
  service_id VARCHAR(5),
  admission_id VARCHAR(5),
  PRIMARY KEY (service_id, admission_id),
  FOREIGN KEY (service_id) REFERENCES service(service_id),
  FOREIGN KEY (admission_id) REFERENCES patient(admission_id)
);
insert into facility values
('se01','ad01'),
('se02','ad02'),
('se03','ad03'),
('se04','ad04'),
('se05','ad05'),
('se06','ad06'),
('se07','ad07');
select * from facility;

CREATE TABLE patient_phone_number
(
  phone_number VARCHAR(13),
  admission_id VARCHAR(5) NOT NULL,
  PRIMARY KEY (phone_number, admission_id),
  FOREIGN KEY (admission_id) REFERENCES patient(admission_id)
);
insert into patient_phone_number values
('+919873625130','ad01'),
('+919270394769','ad02'),
('+918990227366','ad03'),
('+910298337764','ad04'),
('+919902837466','ad05'),
('+919273892099','ad06'),
('+910273649201','ad07');

select * from patient_phone_number;

SELECT med_name, SUM(quantity) AS total_quantity 
FROM medical 
GROUP BY med_name;

SELECT doctor_name, specialization FROM doctor;

SELECT * FROM medical WHERE exp_date > '2025-01-01';

SELECT staff_name FROM staff WHERE designation = 'emergency';

SELECT doctor_name FROM doctor
JOIN provides ON doctor.doctor_id = provides.doctor_id
JOIN service ON provides.service_id = service.service_id
WHERE service.service_name = 'sonography';

SELECT doctor_name 
FROM doctor 
WHERE specialization = 'radiologist';

SELECT * 
FROM service 
WHERE cost < 1000;

SELECT gender, COUNT(*) 
FROM patient 
GROUP BY gender;

SELECT * 
FROM staff 
WHERE designation='nurse';

SELECT patient_name 
FROM patient 
WHERE admission_date >= '2022-01-01';

SELECT COUNT(*) AS insured_count 
FROM patient_bill 
WHERE insurance_availability = '1';

SELECT staff_name 
FROM staff 
WHERE salary>'15000';

SELECT patient_name 
FROM patient LEFT JOIN patient_bill ON patient.admission_id=patient_bill.admission_id
 WHERE patient_bill.admission_id IS NULL;


SELECT doctor_name 
FROM doctor LEFT JOIN provides ON doctor.doctor_id=provides.doctor_id 
WHERE provides.doctor_id IS NULL;

