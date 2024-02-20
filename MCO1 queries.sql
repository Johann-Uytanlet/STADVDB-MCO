-- with optimization code

CREATE INDEX idx_clinics_clinicid ON clinics(clinicid);
CREATE INDEX idx_appointments_clinicid ON appointments(clinicid);
CREATE INDEX idx_appointments_queue_date ON appointments(QueueDate);
CREATE INDEX idx_appointments_doctorid ON appointments(doctorid);
CREATE INDEX idx_appointments_pxid ON appointments(pxid);
CREATE INDEX idx_doctors_doctorid ON doctors(doctorid);
CREATE INDEX idx_px_pxid ON px(pxid);

-- end of optimization code
CREATE INDEX idx_doctors_doctorid ON doctors(doctorid);

-- Roll-Up: Count of appointments per region, province, city
SELECT
    c.RegionName,
    c.Province,
    c.City,
    COUNT(*) AS appointment_count
FROM appointments a
JOIN clinics c ON a.clinicid = c.clinicid
GROUP BY c.RegionName, c.Province, c.City WITH ROLLUP;

-- Slice: Count of appointments per given specific location/within a time period
-- pandemic
SELECT
    c.City,
    c.Province,
    a.QueueDate,
    COUNT(*) AS appointment_count
FROM appointments a
JOIN clinics c ON a.clinicid = c.clinicid
WHERE c.City = 'Manito'  -- Replace 'YourCity' with the desired city
   AND a.QueueDate BETWEEN '2019-01-01 00:0:00' AND '2022-12-31 00:00:00'  -- Replace with the desired time period
	GROUP BY c.City, c.Province, a.QueueDate
	ORDER BY appointment_count DESC;


-- Drill Down and Aggregation: Count of appointments per specialty per region
SELECT
    d.mainspecialty,
    c.RegionName,
    COUNT(*) AS appointment_count
FROM appointments a
JOIN doctors d ON a.doctorid = d.doctorid
JOIN clinics c ON a.clinicid = c.clinicid
GROUP BY d.mainspecialty, c.RegionName;

-- Dice: Count of appointments for Male patients aged 60 and above per doctor's main specialty
SELECT
    px.gender,
    d.mainspecialty,
    COUNT(*) AS appointment_count
FROM appointments a
JOIN px ON a.pxid = px.pxid
JOIN doctors d ON a.doctorid = d.doctorid
WHERE px.gender = 'Male'
   AND px.age >= 60
GROUP BY px.gender, d.mainspecialty
ORDER BY appointment_count DESC;

-- Dice: Count of appointments for Female patients aged 60 and above per doctor's main specialty

SELECT
    px.gender,
    d.mainspecialty,
    COUNT(*) AS appointment_count
FROM appointments a
JOIN px ON a.pxid = px.pxid
JOIN doctors d ON a.doctorid = d.doctorid
WHERE px.gender = 'Female'
   AND px.age >= 60
GROUP BY px.gender, d.mainspecialty
ORDER BY appointment_count DESC;





-- Roll-Up: Count of appointments per region, province, city
CREATE INDEX idx_clinicid ON appointments (clinicid);
CREATE INDEX idx_region_province_city ON clinics (RegionName, Province, City);

SELECT
    c.RegionName,
    c.Province,
    c.City,
    COUNT(*) AS appointment_count
FROM appointments a
JOIN clinics c ON a.clinicid = c.clinicid
GROUP BY ROLLUP(c.RegionName, c.Province, c.City);

-- Slice: Count of appointments per given specific location/within a time period
CREATE INDEX idx_city_province ON clinics (City, Province);
CREATE INDEX idx_appointments_queue_date ON appointments (QueueDate);

SELECT
    c.City,
    c.Province,
    a.QueueDate,
    COUNT(*) AS appointment_count
FROM appointments a
JOIN clinics c ON a.clinicid = c.clinicid
WHERE c.City = 'YourCity'
   AND a.QueueDate BETWEEN 'StartDate' AND 'EndDate'
GROUP BY c.City, c.Province, a.QueueDate;

-- Drill Down and Aggregation: Count of appointments per specialty per status
CREATE INDEX idx_doctorid ON appointments (doctorid);

SELECT
    d.mainspecialty,
    a.status,
    COUNT(*) AS appointment_count
FROM appointments a
JOIN doctors d ON a.doctorid = d.doctorid
GROUP BY d.mainspecialty, a.status;


-- Dice: Total number of appointments for male patients aged 30-40 and doctors with a main specialty of _
CREATE INDEX idx_pxid ON appointments (pxid);

SELECT
    px.gender,
    px.age AS patient_age,
    d.mainspecialty,
    COUNT(*) AS appointment_count
FROM appointments a
JOIN px ON a.pxid = px.pxid
JOIN doctors d ON a.doctorid = d.doctorid
WHERE px.gender = 'Male'
   AND px.age BETWEEN 30 AND 40
   AND d.mainspecialty = 'YourSpecialty'
GROUP BY px.gender, px.age, d.mainspecialty;



-- Main Question 1
-- What are the average queuing times?
SELECT AVG(TIMESTAMPDIFF(SECOND, a.TimeQueued, a.QueueDate)) AS avg_queuing_time
FROM appointments a
JOIN doctors d ON a.doctorid = d.doctorid;


-- Subquery 1.a
-- Average queuing time per doctor’s specialty
SELECT d.mainspecialty,
       AVG(TIMESTAMPDIFF(SECOND, a.TimeQueued, a.QueueDate)) AS avg_queuing_time
FROM appointments a
JOIN doctors d ON a.doctorid = d.doctorid
GROUP BY d.mainspecialty;

-- Subquery 1.b
-- Average queuing time per appointment status
SELECT a.status,
       AVG(TIMESTAMPDIFF(SECOND, a.TimeQueued, a.QueueDate)) AS avg_queuing_time
FROM appointments a
GROUP BY a.status;

-- Subquery 1.c
-- Average queuing time per location (city, province, and region)
SELECT c.City,
       c.Province,
       c.RegionName,
       AVG(TIMESTAMPDIFF(SECOND, a.TimeQueued, a.QueueDate)) AS avg_queuing_time
FROM appointments a
JOIN clinics c ON a.clinicid = c.clinicid
GROUP BY c.City, c.Province, c.RegionName;

-- Subquery 1.d
-- Average queuing time per virtual (true or false)
SELECT a.Virtual,
       AVG(TIMESTAMPDIFF(SECOND, a.TimeQueued, a.QueueDate)) AS avg_queuing_time
FROM appointments a
GROUP BY a.Virtual;


-- Main Question 2
-- What are the average ages of patients and doctors, and how do they relate to various factors?
SELECT AVG(px.age) AS avg_patient_age
FROM px;

SELECT AVG(d.age) AS avg_doctor_age
FROM doctors d;

-- Subquery 2.a
-- Average age of patient per location
SELECT c.City,
       c.Province,
       c.RegionName,
       AVG(px.age) AS avg_patient_age
FROM appointments a
JOIN px ON a.pxid = px.pxid
JOIN clinics c ON a.clinicid = c.clinicid
GROUP BY c.City, c.Province, c.RegionName;

-- Subquery 2.b
-- Average age of patient per status
SELECT a.status,
       AVG(px.age) AS avg_patient_age
FROM appointments a
JOIN px ON a.pxid = px.pxid
GROUP BY a.status;

-- Subquery 2.c
-- Average age of patient per virtual (true or false)
SELECT a.Virtual,
       AVG(px.age) AS avg_patient_age
FROM appointments a
JOIN px ON a.pxid = px.pxid
GROUP BY a.Virtual;

-- Subquery 2.d
-- Average age of doctor per specialty
SELECT d.mainspecialty,
       AVG(d.age) AS avg_doctor_age
FROM doctors d
GROUP BY d.mainspecialty;
