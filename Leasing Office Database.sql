IF OBJECT_ID (N'dbo.applicant', N'U') IS NOT NULL
DROP TABLE dbo.applicant;
GO

CREATE TABLE dbo.applicant
(
app_id SMALLINT not null identity(1,1),
app_ssn INT NOT NULL check (app_ssn > 0 and app_ssn <=999999999),
app_state_id VARCHAR(45) NOT NULL,
app_fname VARCHAR (45) NOT NULL,
app_lname VARCHAR(30) NOT NULL,
app_street VARCHAR(30) NOT NULL,
app_city VARCHAR(30) NOT NULL,
app_state CHAR(2) NOT NULL DEFAULT 'FL',
app_zip int NOT NULL check (app_zip >0 and app_zip <= 999999999),
app_email VARCHAR(100) NOT NULL,
app_dob DATE NOT NULL,
app_gender CHAR(1) NOT NULL CHECK (app_gender IN('m', 'f')),
app_bckgd_check CHAR(1) NOT NULL CHECK (app_bckgd_check IN('n', 'y')),
app_notes VARCHAR(45) NULL,
PRIMARY KEY(app_id),

CONSTRAINT ux_app_ssn unique nonclustered (app_ssn ASC),
CONSTRAINT ux_app_state_id unique nonclustered (app_state_id ASC)
);

IF OBJECT_ID (N'dbo.property', N'U') IS NOT NULL
DROP TABLE dbo.property;
GO

CREATE TABLE dbo.property
(
	prp_id SMALLINT NOT NULL identity(1,1),
	prp_street VARCHAR(30) NOT NULL,
	prp_city VARCHAR(30) NOT NULL,
	prp_state CHAR(2) NOT NULL DEFAULT 'FL',
	prp_zip int NOT NULL check (prp_zip >0 and prp_zip <= 999999999),
	prp_type VARCHAR(15) NOT NULL CHECK
		(prp_type IN('house', 'condo', 'townhouse', 'duplex', 'apt', 'mobile home', 'room')),
	prp_rental_rate DECIMAL(7,2) NOT NULL CHECK (prp_rental_rate > 0),
	prp_status CHAR(1) NOT NULL CHECK (prp_status IN('a','u')),
	prp_notes VARCHAR(255) NULL,
	PRIMARY KEY (prp_id),
)
IF OBJECT_ID (N'dbo.agreement', N'U') IS NOT NULL
DROP TABLE dbo.agreement;
GO

CREATE TABLE dbo.agreement
(

	agr_id SMALLINT NOT NULL identity (1,1),
	prp_id SMALLINT NOT NULL,
	app_id SMALLINT NOT NULL,
	agr_signed DATE NOT NULL,
	agr_start DATE NOT NULL,
	agr_end DATE NOT NULL,
	agr_amt DECIMAL(7,2) NOT NULL CHECK (agr_amt >0),
	agr_notes VARCHAR(255) NULL,
	PRIMARY KEY (agr_id),

	CONSTRAINT ux_prp_id_app_id_agr_signed unique nonclustered 
	(prp_id ASC, app_id ASC, agr_signed ASC),

	CONSTRAINT fk_agreement_property
	FOREIGN KEY (prp_id)
	REFERENCES dbo.property (prp_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,

	CONSTRAINT fk_agreement_applicant
	FOREIGN KEY (app_id)
	REFERENCES dbo.applicant (app_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE

);

IF OBJECT_ID (N'dbo.feature', N'U') IS NOT NULL
DROP TABLE dbo.feature;
GO

CREATE TABLE dbo.feature
(
	ftr_id TINYINT NOT NULL identity(1,1),
	ftr_type VARCHAR(45) NOT NULL,
	ftr_notes VARCHAR(255) NULL,
	PRIMARY KEY (ftr_id)

);

IF OBJECT_ID (N'dbo.prop_feature', N'U') IS NOT NULL
DROP TABLE dbo.prop_feature;
GO

CREATE TABLE dbo.prop_feature
(
	pft_id SMALLINT NOT NULL identity (1,1),
	prp_id SMALLINT NOT NULL,
	ftr_id TINYINT NOT NULL,
	PRIMARY KEY (pft_id),

	CONSTRAINT ux_prp_id_ftr_id unique nonclustered (prp_id ASC, ftr_id ASC),

	CONSTRAINT fk_prop_feat_property
	FOREIGN KEY (prp_id)
	REFERENCES dbo.property (prp_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,

	CONSTRAINT fk_prop_feature
	FOREIGN KEY (ftr_id)
	REFERENCES dbo.feature (ftr_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE

);

IF OBJECT_ID (N'dbo.occupant', N'U') IS NOT NULL
DROP TABLE dbo.occupant;
GO

CREATE TABLE dbo.occupant
(
	ocp_id SMALLINT NOT NULL identity (1,1),
	app_id SMALLINT NOT NULL,
	ocp_ssn INT NOT NULL check (ocp_ssn > 0 and ocp_ssn <= 999999999),
	ocp_state_id VARCHAR(45) NULL,
	ocp_fname VARCHAR(15) NOT NULL,
	ocp_lname VARCHAR(30) NOT NULL,
	ocp_email VARCHAR(100) NULL,
	ocp_dob DATE NOT NULL,
	ocp_gender CHAR(1) NOT NULL CHECK (ocp_gender IN('m', 'f')),
	ocp_bckgd_check CHAR(1) NOT NULL CHECK (ocp_bckgd_check IN('n','y')),
	ocp_notes VARCHAR(45) NULL,
	PRIMARY KEY (ocp_id),

	CONSTRAINT ux_ocp_ssn unique nonclustered (ocp_ssn ASC),
	CONSTRAINT ux_ocp_state_id unique nonclustered (ocp_state_id ASC),

	CONSTRAINT fk_occupant_applicant
	FOREIGN KEY (app_id)
	REFERENCES dbo.applicant (app_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,

);

IF OBJECT_ID (N'dbo.phone', N'U') IS NOT NULL
DROP TABLE dbo.phone;
GO

CREATE TABLE dbo.phone
(
	phn_id SMALLINT NOT NULL identity(1,1),
	app_id SMALLINT NOT NULL,
	ocp_id SMALLINT NULL,
	phn_num BIGINT NOT NULL CHECK (phn_num > 0 and phn_num <=9999999999),
	phn_type CHAR(1) NOT NULL CHECK (phn_type IN ('c','h','w','f')),
	phn_notes VARCHAR(45) NULL,
	PRIMARY KEY (phn_id),

	CONSTRAINT ux_app_id_phn_num unique nonclustered (app_id ASC, phn_num ASC),

	CONSTRAINT ux_ocp_id_phn_num unique nonclustered (ocp_id ASC, phn_num ASC),

	CONSTRAINT fk_phone_applicant
	FOREIGN KEY (app_id)
	REFERENCES dbo.applicant (app_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,


	CONSTRAINT fk_phone_occupant
	FOREIGN KEY (ocp_id)
	REFERENCES dbo.occupant (ocp_id)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
);

IF OBJECT_ID (N'dbo.room_type', N'U') IS NOT NULL
DROP TABLE dbo.room_type;
GO

CREATE TABLE dbo.room_type
(

	rtp_id TINYINT NOT NULL identity(1,1),
	rtp_name VARCHAR(45) NOT NULL,
	rtp_notes VARCHAR(45) NULL
	PRIMARY KEY(rtp_id)

);

IF OBJECT_ID (N'dbo.room', N'U') IS NOT NULL
DROP TABLE dbo.room;
GO

CREATE TABLE dbo.room
(
	rom_id SMALLINT NOT NULL identity (1,1),
	prp_id SMALLINT NOT NULL,
	rtp_id TINYINT NOT NULL,
	rom_size VARCHAR(45) NOT NULL,
	rom_notes VARCHAR(255) NULL,
	PRIMARY KEY (rom_id),

	CONSTRAINT fk_room_property
	FOREIGN KEY (prp_id)
	REFERENCES dbo.property(prp_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,

	CONSTRAINT fk_room_type
	FOREIGN KEY (rtp_id)
	REFERENCES dbo.room_type(rtp_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE

);
