-- Create Location Table
CREATE TABLE Location (
    location_id INT PRIMARY KEY,
    name VARCHAR(100),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    population_density INT
);

-- Create Facility Table
CREATE TABLE Facility (
    facility_id INT PRIMARY KEY,
    type VARCHAR(50),
    capacity INT,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

-- Create Incident Table
CREATE TABLE Incident (
    incident_id INT PRIMARY KEY,
    type VARCHAR(50),
    severity INT,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    timestamp DATETIME
);

-- Create Response_Log Table
CREATE TABLE Response_Log (
    response_id INT PRIMARY KEY,
    incident_id INT,
    facility_id INT,
    response_time INT,
    resources_used INT,
    FOREIGN KEY (incident_id) REFERENCES Incident(incident_id),
    FOREIGN KEY (facility_id) REFERENCES Facility(facility_id)
);

-- Create Resource Table
CREATE TABLE Resource (
    resource_id INT PRIMARY KEY,
    type VARCHAR(50),
    status VARCHAR(20),
    facility_id INT,
    FOREIGN KEY (facility_id) REFERENCES Facility(facility_id)
);

-- Create Evacuation_Zone Table
CREATE TABLE Evacuation_Zone (
    zone_id INT PRIMARY KEY,
    location_id INT,
    safe_capacity INT,
    risk_rating INT,
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);
