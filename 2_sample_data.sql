-- Insert into Location
INSERT INTO Location VALUES
(1, 'Metro City', 28.60, 77.25, 1000),
(2, 'City North', 28.65, 77.20, 700),
(3, 'Sector 22', 28.62, 77.30, 500),
(4, 'West Center', 28.58, 77.15, 300);

-- Insert into Facility
INSERT INTO Facility VALUES
(1, 'Hospital', 50, 1),
(2, 'Fire Station', 30, 2),
(3, 'Relief Camp', 100, 3),
(4, 'Hospital', 0, 2),
(5, 'Relief Camp', 25, 4),
(6, 'Hospital', 80, 4),
(7, 'Fire Station', 20, 3);

-- Insert into Resource
INSERT INTO Resource VALUES
(101, 'Ambulance', 'available', 1),
(102, 'Fire Truck', 'available', 2),
(103, 'Medical Kit', 'used', 3),
(104, 'Tent', 'available', 5),
(105, 'Rescue Team', 'available', 1);

-- Insert into Incident
INSERT INTO Incident VALUES
(201, 'earthquake', 8, 28.60, 77.25, '2025-05-01 10:00:00'),
(202, 'flood', 6, 28.65, 77.20, '2025-05-02 14:00:00');

-- Insert into Response_Log
INSERT INTO Response_Log VALUES
(301, 201, 1, 15, 3),
(302, 201, 2, 20, 2),
(303, 201, 3, 10, 1),
(304, 202, 4, 12, 4),
(305, 202, 6, 9, 1);

-- Insert into Evacuation_Zone
INSERT INTO Evacuation_Zone VALUES
(401, 1, 800, 9),
(402, 2, 600, 7),
(403, 3, 400, 5);
