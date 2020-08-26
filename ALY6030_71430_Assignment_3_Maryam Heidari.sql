#create schema
CREATE SCHEMA `MaryamHeidari_Week3`;

#paste the code of star schema
CREATE TABLE `MaryamHeidari_Week3`.`Business`
(
  ims_org_id VARCHAR(45) NOT NULL,
  business_name VARCHAR(45) NOT NULL,
  ttl_license_beds INT NOT NULL,
  ttl_census_beds INT NOT NULL,
  ttl_staffed_beds INT NOT NULL,
  bed_cluster_id INT NOT NULL,
  PRIMARY KEY (ims_org_id)
);

CREATE TABLE `MaryamHeidari_Week3`.`Bed_Type`
(
  bed_id INT,
  bed_code VARCHAR(2),
  bed_desc VARCHAR(45),
  PRIMARY KEY (bed_id)
);

#fill the table
INSERT INTO MaryamHeidari_Week3.Bed_Type (bed_id, bed_code, bed_desc) 
VALUES (1,'BU','Burn'),
(2,'CC','CCU'),
(3,'DE','Detox ICU'),
(4,'IC','ICU'),
(5,'MS','Med/Surg'),
(6,'NE','NeoNatal ICU'),
(7,'NU','Nursery'),
(8,'NF','Nursing Facility'),
(9,'OT','Other'),
(10,'PD','Pediatric ICU'),
(11,'PR','Premature ICU'),
(12,'PS','Psychiatric'),
(13,'PI','Psych ICU'),
(14,'RH','Rehabilitation'),
(15,'SI','SICU'),
(16,'SN','Skilled Nursing'),
(17,'SP','Special Care'),
(18,'TO','Total'),
(19,'TR','Trauma ICU'),
(20,'DD','Developmental Disability');


CREATE TABLE `MaryamHeidari_Week3`.`Bed_Fact`
(
  ims_org_id VARCHAR(45) NOT NULL,
  bed_id INT NOT NULL,
  license_beds INT NOT NULL,
  census_beds INT NOT NULL,
  staffed_beds INT NOT NULL,
 FOREIGN KEY (bed_id) REFERENCES Bed_Type(bed_id),
 FOREIGN KEY (ims_org_id) REFERENCES business(ims_org_id)
);

# make a table in part 7
#License
SELECT a.ims_org_id, c.business_name,
(CASE 
WHEN b.bed_desc like '%ICU%'  THEN (a.license_beds)
ELSE 0
END) as License_ICU,
(CASE 
WHEN b.bed_desc like '%SICU%'  THEN (a.license_beds)
ELSE 0
END) as License_SICU
FROM maryamheidari_week3.bed_fact a
left join maryamheidari_week3.bed_type b on a.bed_id = b.bed_id
left join maryamheidari_week3.business c on a.ims_org_id = c.ims_org_id
group by a.ims_org_id
order by License_ICU desc
LIMIT 10;

#census
SELECT a.ims_org_id, c.business_name,
(CASE 
WHEN b.bed_desc like '%ICU%'  THEN (a.census_beds)
ELSE 0
END) as census_ICU,
(CASE 
WHEN b.bed_desc like '%SICU%'  THEN (a.census_beds)
ELSE 0
END) as census_SICU
FROM maryamheidari_week3.bed_fact a
left join maryamheidari_week3.bed_type b on a.bed_id = b.bed_id
left join maryamheidari_week3.business c on a.ims_org_id = c.ims_org_id
group by a.ims_org_id
order by census_ICU desc
LIMIT 10;

# staffed
SELECT a.ims_org_id, c.business_name,
(CASE 
WHEN b.bed_desc like '%ICU%'  THEN (a.staffed_beds)
ELSE 0
END) as staffed_ICU,
(CASE 
WHEN b.bed_desc like '%SICU%'  THEN (a.staffed_beds)
ELSE 0
END) as staffed_SICU
FROM maryamheidari_week3.bed_fact a
left join maryamheidari_week3.bed_type b on a.bed_id = b.bed_id
left join maryamheidari_week3.business c on a.ims_org_id = c.ims_org_id
group by a.ims_org_id
order by staffed_ICU desc
LIMIT 10;


#Q1
SELECT 
sum(CASE 
WHEN b.bed_desc like '%ICU%'  THEN (a.license_beds)
ELSE 0
END) as license_ICU,
sum(CASE 
WHEN b.bed_desc like '%SICU%'  THEN (a.license_beds)
ELSE 0
END) as license_SICU
FROM maryamheidari_week3.bed_fact a
left join maryamheidari_week3.bed_type b on a.bed_id = b.bed_id
left join maryamheidari_week3.business c on a.ims_org_id = c.ims_org_id;

#Q2
SELECT 
sum(CASE 
WHEN b.bed_desc like '%ICU%'  THEN (a.census_beds)
ELSE 0
END) as census_ICU,
sum(CASE 
WHEN b.bed_desc like '%SICU%'  THEN (a.census_beds)
ELSE 0
END) as census_SICU
FROM maryamheidari_week3.bed_fact a
left join maryamheidari_week3.bed_type b on a.bed_id = b.bed_id
left join maryamheidari_week3.business c on a.ims_org_id = c.ims_org_id;

#Q3
SELECT 
sum(CASE 
WHEN b.bed_desc like '%ICU%'  THEN (a.staffed_beds)
ELSE 0
END) as staffed_ICU,
sum(CASE 
WHEN b.bed_desc like '%SICU%'  THEN (a.staffed_beds)
ELSE 0
END) as staffed_SICU
FROM maryamheidari_week3.bed_fact a
left join maryamheidari_week3.bed_type b on a.bed_id = b.bed_id
left join maryamheidari_week3.business c on a.ims_org_id = c.ims_org_id;
group by a.ims_org_id
order by census_ICU desc
LIMIT 10;