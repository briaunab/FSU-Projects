-- FINAL PROJECT
-- Briauna Brown

SET ANSI_WARNINGS ON;
GO

use master;
GO

IF EXISTS(SELECT name FROM master.dbo.sysdatabases WHERE name = N'bjb14b')
DROP database bjb14b;
GO

IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'bjb14b')
CREATE database bjb14b;
GO

use bjb14b;
GO

-- TABLE ABOUT PATIENT
IF OBJECT_ID (N'dbo.patient', N'U') IS NOT NULL
DROP TABLE dbo.patient;
GO

CREATE TABLE dbo.patient
(
pat_id SMALLINT not null identity(1,1),
pat_ssn INT NOT NULL check (pat_ssn > 0 and pat_ssn <=999999999),
pat_fname VARCHAR (45) NOT NULL,
pat_lname VARCHAR(30) NOT NULL,
pat_street VARCHAR(30) NOT NULL,
pat_city VARCHAR(30) NOT NULL,
pat_state CHAR(2) NOT NULL DEFAULT 'FL',
pat_zip int NOT NULL check (pat_zip >0 and pat_zip <= 999999999),
pat_phone BIGINT not null,
pat_email VARCHAR(100) NOT NULL,
pat_dob DATE NOT NULL,
pat_gender CHAR(1) NOT NULL CHECK (pat_gender IN('m', 'f')),
pat_notes VARCHAR(45) NULL,
PRIMARY KEY(pat_id),

CONSTRAINT ux_pat_ssn unique nonclustered (pat_ssn ASC),
);

-- TABLE FOR MEDICATION
IF OBJECT_ID (N'dbo.medication', N'U') IS NOT NULL
DROP TABLE dbo.medication;

CREATE TABLE dbo.medication
(
med_id SMALLINT not null identity(1,1),
med_name VARCHAR(100) NOT NULL,
med_price DECIMAL(5,2) NOT NULL CHECK (med_price >0),
med_shelf_life DATE NOT NULL,
med_notes VARCHAR(255) NULL,
PRIMARY KEY(med_id),
);

-- TABLE FOR PRESCRIPTION
IF OBJECT_ID (N'dbo.prescription', N'U') IS NOT NULL
DROP TABLE dbo.prescription;

CREATE TABLE dbo.prescription
(
pre_id SMALLINT not null identity(1,1),
pat_id SMALLINT not null,
med_id SMALLINT not null,
pre_date DATE not null,
pre_dosage VARCHAR(255) NOT NULL,
pre_num_refills VARCHAR(3) NOT NULL CHECK (pre_num_refills >0),
pre_notes VARCHAR(255)  NULL,
PRIMARY KEY(pre_id),

CONSTRAINT ux_pat_id_med_id_pre_date unique nonclustered 
	(pat_id ASC, med_id ASC, pre_date ASC),

	CONSTRAINT fk_prescription_patient
	FOREIGN KEY (pat_id)
	REFERENCES dbo.patient (pat_id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE,

	CONSTRAINT fk_prescription_medication
	FOREIGN KEY (med_id)
	REFERENCES dbo.medication (med_id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE

);

-- TABLE FOR TREATMENT

IF OBJECT_ID (N'dbo.treatment', N'U') IS NOT NULL
DROP TABLE dbo.treatment;

CREATE TABLE dbo.treatment
(
trt_id SMALLINT not null identity(1,1),
trt_name VARCHAR(255) NOT NULL,
trt_price DECIMAL(8,2) NOT NULL CHECK (trt_price >0),
trt_notes VARCHAR(255) NULL,
PRIMARY KEY(trt_id),
);

-- TABLE FOR PHYSICIAN

IF OBJECT_ID (N'dbo.physician', N'U') IS NOT NULL
DROP TABLE dbo.physician;
GO

CREATE TABLE dbo.physician
(
phy_id SMALLINT not null identity(1,1),
phy_specialty VARCHAR(25) NOT NULL,
phy_fname VARCHAR (45) NOT NULL,
phy_lname VARCHAR(30) NOT NULL,
phy_street VARCHAR(30) NOT NULL,
phy_city VARCHAR(30) NOT NULL,
phy_state CHAR(2) NOT NULL DEFAULT 'FL',
phy_zip int NOT NULL check (phy_zip >0 and phy_zip <= 999999999),
phy_phone BIGINT NOT NULL check (phy_phone >0 and phy_phone <= 9999999999),
phy_fax BIGINT NOT NULL check (phy_fax > 0 and phy_fax <= 9999999999),
phy_email VARCHAR(100) NOT NULL,
phy_url VARCHAR(100) NOT NULL,
phy_notes VARCHAR(45) NULL,
PRIMARY KEY(phy_id),
);



-- TABLE FOR PATIENT_TREATMENT

IF OBJECT_ID (N'dbo.patient_treatment', N'U') IS NOT NULL
DROP TABLE dbo.patient_treatment;

CREATE TABLE dbo.patient_treatment
(
ptr_id SMALLINT not null identity(1,1),
pat_id SMALLINT not null,
phy_id SMALLINT not null,
trt_id SMALLINT not null,
ptr_date DATE not null,
ptr_start TIME not null,
ptr_end TIME not null,
ptr_results VARCHAR(255) NOT NULL,
ptr_notes VARCHAR(255) NULL,
PRIMARY KEY(ptr_id),

CONSTRAINT ux_pat_id_phy_id_trt_id_ptr_date unique nonclustered 
	(pat_id ASC, phy_id ASC, trt_id ASC, ptr_date ASC),

	CONSTRAINT fk_patient_treatment_patient
	FOREIGN KEY (pat_id)
	REFERENCES dbo.patient (pat_id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE,

	CONSTRAINT fk_patient_treatment_physician
	FOREIGN KEY (phy_id)
	REFERENCES dbo.physician (phy_id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE,

	CONSTRAINT fk_patient_treatment_treatment
	FOREIGN KEY (trt_id)
	REFERENCES dbo.treatment (trt_id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE


);

-- ADMINISTRATION TABLE
IF OBJECT_ID (N'dbo.administration_lu', N'U') IS NOT NULL
DROP TABLE dbo.administration_lu;

CREATE TABLE dbo.administration_lu
(
	pre_id SMALLINT NOT NULL,
	ptr_id SMALLINT NOT NULL,
	PRIMARY KEY (pre_id,ptr_id),

	CONSTRAINT fk_administration_lu_prescription
	FOREIGN KEY (pre_id)
	REFERENCES dbo.prescription (pre_id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE,

	CONSTRAINT fk_administration_lu_patient_treatment
	FOREIGN KEY (ptr_id)
	REFERENCES dbo.patient_treatment(ptr_id)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION
);

select * from information_schema.tables;

EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

--patient inserts
insert into dbo.patient
(pat_ssn, pat_fname, pat_lname, pat_street, pat_city, pat_state, pat_zip, pat_phone, pat_email, pat_dob, pat_gender, pat_notes)

VALUES
('123456789','Trinity','Jackson','3rd Road','Miami','FL','30014','3058761999','trinity@aol.com','11-06-1961','F',NULL),
('123456780','Mary','Pope',' Ansel Street','Miramar','FL','30014','3058761999','maryy@aol.com','11-06-1971','F',NULL),
('123456781','Allison','Marks','Tintsworth Ave','Hollywood','FL','30014','3058761999','allison@aol.com','11-06-1981','F',NULL),
('123456782','Layla','Wright','Malay Street','Pembroke Pines','FL','30014','3058761999','laylaw@aol.com','11-06-1991','F',NULL),
('123456783','Nico','Brown','4th Road','Fort Meyers','FL','30014','3058761999','nicobrown123@aol.com','11-06-1961','F',NULL);

-- inserts for medication
INSERT INTO dbo.medication
(med_name,med_price, med_shelf_life, med_notes)

VALUES
('Sronyx', 0.00, '06-23-2012',NULL),
('Abilify',125.00, '07-07-2007',NULL),
('Actos', 300.00, '01-23-2014', NULL),
('Adacel', 66.50, '10-10-2013', NULL),
('Aciphex', 100.00, '05-05-2001',NULL);

-- prescription inserts

insert into dbo.prescription
(pat_id, med_id, pre_date, pre_dosage, pre_num_refills, pre_notes)

VALUES
(1,1,'2011-12-23','take one per day', '1', NULL),
(1,2,'2011-12-23','take two before and after dinner', '2', NULL),
(2,3,'2011-12-23','take one per day', '1', NULL),
(2,4,'2011-12-23','take one per day', '2', NULL),
(3,5,'2011-12-23','take as needed', '1', NULL);


-- inserts for physicians

insert into dbo. physician
(phy_specialty, phy_fname, phy_lname, phy_street, phy_city, phy_state, phy_zip, phy_phone, phy_fax, phy_email, phy_url, phy_notes)

VALUES
('family medicine', 'tom', 'smith', '123 Peach St', 'tampa', 'FL', '33610', '9541112345', '9546681245', 'tsmith@gmail.com', 'tsmithfamilymed.com', NULL),
('internal medicine', 'steve', 'williams', '123 Plum Lane', 'tampa', 'FL', '33110', '9541112345', '9546681245', 'tsmith@gmail.com', 'tsmithfamilymed.com', NULL),
('dermatology', 'ronald', 'burns', '123 Stadium Lane', 'miami', 'FL', '33200', '9541112345', '9546681245', 'tsmith@gmail.com', 'tsmithfamilymed.com', NULL),
('cardiovascular surgery', 'penny', 'hardaway', '123 Lava Way', 'orlando', 'FL', '33431', '9541112345', '9546681245', 'tsmith@gmail.com', 'tsmithfamilymed.com', NULL),
('cancer surgery', 'mike', 'smith', 'Wave Street', 'hialeah', 'FL', '32610', '9541112345', '9546681245', 'tsmith@gmail.com', 'tsmithfamilymed.com', NULL);

-- inserts for treatment table

insert into dbo.treatment
(trt_name, trt_price, trt_notes)
values
('knee replacement', 2000.00, NULL),
('heart transplant', 130000.00, NULL),
('hip replacement', 40000.00, NULL),
('tonsils removed', 5000.00, NULL),
('appendix removal', 3000.00, NULL);

-- inserts for patient_treatment
insert into patient_treatment(pat_id, phy_id, trt_id, ptr_date, ptr_start, ptr_end, ptr_results, ptr_notes)

VALUES
(1,10,5, '2011-12-23', '07:08:09', '11:12:15','success patient is fine',NULL),
(1,9,6, '2014-11-23', '09:08:09', '09:12:15','complications, must reschedule',NULL),
(2,8,7, '2016-02-03', '08:08:09', '11:12:15','died during surgery',NULL),
(2,4,9, '2010-01-13', '06:08:09', '09:12:15','success patient is fine',NULL),
(3,4,1, '2000-10-07', '05:08:09', '12:12:15','success patient is fine',NULL);

insert into dbo.administration_lu
(pre_id, ptr_id)
VALUES
(5,1),
(4,3),
(2,5),
(1,4),
(3,2);

select * from dbo.patient;
select * from dbo.medication;
select * from dbo.prescription;
select * from dbo.physician;
select * from dbo.treatment;
select * from dbo.patient_treatment;
select * from dbo.administration_lu;
