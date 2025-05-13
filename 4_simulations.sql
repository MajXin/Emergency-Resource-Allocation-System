-- Simulation 1: Earthquake in Metro City
INSERT INTO Incident VALUES (501, 'earthquake', 7.5, 28.60, 77.25, '2025-05-13 10:00:00');

-- Get nearest 3 facilities
SELECT f.facility_id, l.name,
       SQRT(POW(l.latitude - 28.60, 2) + POW(l.longitude - 77.25, 2)) AS distance
FROM Facility f
JOIN Location l ON f.location_id = l.location_id
ORDER BY distance ASC
LIMIT 3;

-- Simulation 2: Cyberattack and reroute
INSERT INTO Incident VALUES (502, 'cyberattack', 8, 28.65, 77.20, '2025-05-13 14:00:00');
UPDATE Facility SET capacity = 0 WHERE facility_id = 4;

SELECT f2.facility_id, f2.type, f2.capacity, l.name AS location_name,
       SQRT(POW(l.latitude - l2.latitude, 2) + POW(l.longitude - l2.longitude, 2)) AS distance
FROM Facility f1
JOIN Location l ON f1.location_id = l.location_id
JOIN Facility f2 ON f2.type = f1.type AND f2.facility_id != f1.facility_id
JOIN Location l2 ON f2.location_id = l2.location_id
WHERE f1.facility_id = 1 -- replace with ID of offline hospital
ORDER BY distance ASC, f2.capacity DESC
LIMIT 1;

