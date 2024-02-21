-- Roll-Up: Count of appointments per region, province, city
SELECT
    c.RegionName,
    c.Province,
    c.City,
    COUNT(*) AS appointment_count
FROM appointments a
JOIN clinics c ON a.clinicid = c.clinicid
GROUP BY c.RegionName, c.Province, c.City WITH ROLLUP;

SELECT
    c.RegionName,
    c.Province,
    c.City,
    COUNT(*) AS appointment_count
FROM appointments_with_index a
JOIN clinics_with_index c ON a.clinicid = c.clinicid
GROUP BY c.RegionName, c.Province, c.City WITH ROLLUP;

-- Slice: Count of appointments per given specific location/within a time period
SELECT
    d.mainspecialty AS specialty,
    COUNT(*) AS total_appointments
FROM
    appointments a
    JOIN doctors d ON d.doctorid = a.doctorid
WHERE
    d.mainspecialty = 'Surgery';

SELECT
    d.mainspecialty AS specialty,
    COUNT(*) AS total_appointments
FROM
    appointments_with_index a
    JOIN doctors_with_index d ON d.doctorid = a.doctorid
WHERE
    d.mainspecialty = 'Surgery';

-- Drill Down and Aggregation: Count of appointments per specialty per region
SELECT 
YEAR(a.QueueDate) AS queue_year,
MONTHNAME(a.QueueDate) AS queue_month,
DAYNAME(a.QueueDate) AS queue_day,
COUNT(DISTINCT a.pxid) AS patients_count
FROM appointments a
JOIN doctors d ON a.doctorid = d.doctorid
JOIN clinics c ON a.clinicid = c.clinicid
JOIN px p ON a.pxid = p.pxid
WHERE YEAR(a.QueueDate) >= 2018
GROUP BY queue_year, MONTH(a.QueueDate), queue_month, queue_day
ORDER BY queue_year, MONTH(a.QueueDate), FIELD(queue_day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

SELECT 
YEAR(a.QueueDate) AS queue_year,
MONTHNAME(a.QueueDate) AS queue_month,
DAYNAME(a.QueueDate) AS queue_day,
COUNT(DISTINCT a.pxid) AS patients_count
FROM appointments_with_index a
JOIN doctors_with_index d ON a.doctorid = d.doctorid
JOIN clinics_with_index c ON a.clinicid = c.clinicid
JOIN px p ON a.pxid = p.pxid
WHERE YEAR(a.QueueDate) >= 2018
GROUP BY queue_year, MONTH(a.QueueDate), queue_month, queue_day
ORDER BY queue_year, MONTH(a.QueueDate), FIELD(queue_day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Dice: Count of appointments for Male patients aged 60 and above per doctor's main specialty
SELECT
    YEAR(a.QueueDate) as Year,
    px.gender,
    d.mainspecialty,
    COUNT(*) AS appointment_count
FROM appointments a
JOIN px ON a.pxid = px.pxid
JOIN doctors d ON a.doctorid = d.doctorid
WHERE 	(d.mainspecialty = "General Medicine" OR d.mainspecialty = "Surgery")
		AND px.age >= 60
GROUP BY YEAR(a.QueueDate), px.gender, d.mainspecialty
ORDER BY YEAR(a.QueueDate), appointment_count DESC;

SELECT
    YEAR(a.QueueDate) as Year,
    px.gender,
    d.mainspecialty,
    COUNT(*) AS appointment_count
FROM appointments_with_index a
JOIN px_with_index px ON a.pxid = px.pxid
JOIN doctors_with_index d ON a.doctorid = d.doctorid
WHERE 	(d.mainspecialty = "General Medicine" OR d.mainspecialty = "Surgery")
		AND px.age >= 60
GROUP BY YEAR(a.QueueDate), px.gender, d.mainspecialty
ORDER BY YEAR(a.QueueDate), appointment_count DESC;
