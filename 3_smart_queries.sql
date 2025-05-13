-- 1. Facilities that handled >5 high-severity incidents last month but are under-equipped

SELECT f.facility_id, f.type, COUNT(r.incident_id) AS incidents_handled, f.capacity
FROM Facility f
JOIN Response_Log r ON f.facility_id = r.facility_id
JOIN Incident i ON r.incident_id = i.incident_id
WHERE i.severity >= 7
  AND i.timestamp >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY f.facility_id, f.type, f.capacity
HAVING incidents_handled > 5 AND f.capacity < 20;

--  2. Evacuation zones that would overload in a 7.0+ magnitude earthquake
SELECT z.zone_id, z.safe_capacity, l.population_density
FROM Evacuation_Zone z
JOIN Location l ON z.location_id = l.location_id
WHERE l.population_density > z.safe_capacity
  AND EXISTS (
    SELECT * FROM Incident i
    WHERE i.severity >= 7
      AND i.latitude BETWEEN l.latitude - 0.2 AND l.latitude + 0.2
      AND i.longitude BETWEEN l.longitude - 0.2 AND l.longitude + 0.2
  );


-- 3. Best alternate facility if one hospital goes offline
SELECT f2.facility_id, f2.type, f2.capacity, l.name AS location_name,
       SQRT(POW(l.latitude - l2.latitude, 2) + POW(l.longitude - l2.longitude, 2)) AS distance
FROM Facility f1
JOIN Location l ON f1.location_id = l.location_id
JOIN Facility f2 ON f2.type = f1.type AND f2.facility_id != f1.facility_id
JOIN Location l2 ON f2.location_id = l2.location_id
WHERE f1.facility_id = 1 -- replace with ID of offline hospital
ORDER BY distance ASC, f2.capacity DESC
LIMIT 1;


--  4. Top 3 most efficient facilities (lowest response time per resource used)
SELECT facility_id,
       ROUND(AVG(response_time/resources_used), 2) AS efficiency_score
FROM Response_Log
GROUP BY facility_id
ORDER BY efficiency_score ASC
LIMIT 3;


--  5. Total resources available per facility
SELECT facility_id, COUNT(*) AS total_resources
FROM Resource
WHERE status = 'available'
GROUP BY facility_id;


-- 6. All incidents that occurred within 5 km of an evacuation zone
SELECT i.incident_id, i.type, i.timestamp, z.zone_id
FROM Incident i
JOIN Evacuation_Zone z ON 
  SQRT(POW(i.latitude - l.latitude, 2) + POW(i.longitude - l.longitude, 2)) < 0.05
JOIN Location l ON z.location_id = l.location_id;


-- 7. Evacuation zones at risk due to high population density and risk rating
SELECT z.zone_id, z.risk_rating, l.population_density
FROM Evacuation_Zone z
JOIN Location l ON z.location_id = l.location_id
WHERE z.risk_rating >= 8 AND l.population_density > z.safe_capacity;


--  8. Facilities that responded to both earthquake and fire incidents
SELECT DISTINCT r.facility_id
FROM Response_Log r
JOIN Incident i ON r.incident_id = i.incident_id
WHERE i.type = 'earthquake'
  AND r.facility_id IN (
    SELECT r2.facility_id
    FROM Response_Log r2
    JOIN Incident i2 ON r2.incident_id = i2.incident_id
    WHERE i2.type = 'fire'
  );


-- 9. Average severity of incidents handled by each facility
SELECT f.facility_id, ROUND(AVG(i.severity), 2) AS avg_severity
FROM Facility f
JOIN Response_Log r ON f.facility_id = r.facility_id
JOIN Incident i ON r.incident_id = i.incident_id
GROUP BY f.facility_id;


--  10. Top 5 facilities by number of distinct incidents handled
SELECT facility_id, COUNT(DISTINCT incident_id) AS total_handled
FROM Response_Log
GROUP BY facility_id
ORDER BY total_handled DESC
LIMIT 5;


