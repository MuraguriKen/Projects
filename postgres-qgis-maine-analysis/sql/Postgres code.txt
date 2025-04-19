--Total number of each amenity:

SELECT 'Schools' AS amenity, COUNT(*) AS total
FROM "Schools"
UNION ALL
SELECT 'Fire Stations' AS amenity, COUNT(*) AS total
FROM "Fire_Stations"
UNION ALL
SELECT 'Police Stations' AS amenity, COUNT(*) AS total
FROM "Law_Enforcement"
UNION ALL
SELECT 'Hospitals' AS amenity, COUNT(*) AS total
FROM "Hospitals";

-- Number of amenities per county:

SELECT c.county, 'Schools' AS amenity, COUNT(*) AS total
FROM "Schools" s
JOIN "Maine_Counties" c ON ST_Within(s.geom, c.geom)
GROUP BY c.county
UNION ALL
SELECT c.county, 'Fire Stations' AS amenity, COUNT(*) AS total
FROM "Fire_Stations" f
JOIN "Maine_Counties" c ON ST_Within(f.geom, c.geom)
GROUP BY c.county
UNION ALL
SELECT c.county, 'Police Stations' AS amenity, COUNT(*) AS total
FROM "Law_Enforcement" l
JOIN "Maine_Counties" c ON ST_Within(l.geom, c.geom)
GROUP BY c.county
UNION ALL
SELECT c.county, 'Hospitals' AS amenity, COUNT(*) AS total
FROM "Hospitals" h
JOIN "Maine_Counties" c ON ST_Within(h.geom, c.geom)
GROUP BY c.county
ORDER BY county, amenity;



--Average number of schools per county:

SELECT
(SELECT COUNT(*) FROM "Schools") * 1.0 / (SELECT COUNT(DISTINCT county) FROM "Maine_Counties") AS average_schools_per_county;



-- Max and Min School count

(SELECT c.county, COUNT(*) AS total_schools
FROM "Schools" s
JOIN "Maine_Counties" c ON ST_Within(s.geom, c.geom)
GROUP BY c.county
ORDER BY total_schools DESC
LIMIT 1)
UNION ALL
(SELECT c.county, COUNT(*) AS total_schools
FROM "Schools" s
JOIN "Maine_Counties" c ON ST_Within(s.geom, c.geom)
GROUP BY c.county
ORDER BY total_schools ASC
LIMIT 1);

-- Max and Min Fire Stations count

(SELECT c.county, COUNT(*) AS total_fire_stations
FROM "Fire_Stations" f
JOIN "Maine_Counties" c ON ST_Within(f.geom, c.geom)
GROUP BY c.county
ORDER BY total_fire_stations DESC
LIMIT 1)
UNION ALL
(SELECT c.county, COUNT(*) AS total_fire_stations
FROM "Fire_Stations" f
JOIN "Maine_Counties" c ON ST_Within(f.geom, c.geom)
GROUP BY c.county
ORDER BY total_fire_stations ASC
LIMIT 1);

-- Max and Min Police Stations count
(SELECT c.county, COUNT(*) AS total_police_stations
FROM "Law_Enforcement" l
JOIN "Maine_Counties" c ON ST_Within(l.geom, c.geom)
GROUP BY c.county
ORDER BY total_police_stations DESC
LIMIT 1)
UNION ALL
(SELECT c.county, COUNT(*) AS total_police_stations
FROM "Law_Enforcement" l
JOIN "Maine_Counties" c ON ST_Within(l.geom, c.geom)
GROUP BY c.county
ORDER BY total_police_stations ASC
LIMIT 1);

-- Max and Min Hospitals count

(SELECT c.county, COUNT(*) AS total_hospitals
FROM "Hospitals" h
JOIN "Maine_Counties" c ON ST_Within(h.geom, c.geom)
GROUP BY c.county
ORDER BY total_hospitals DESC
LIMIT 1)
UNION ALL
(SELECT c.county, COUNT(*) AS total_hospitals
FROM "Hospitals" h
JOIN "Maine_Counties" c ON ST_Within(h.geom, c.geom)
GROUP BY c.county
ORDER BY total_hospitals ASC
LIMIT 1);



--Number of facilities in Bangor
SELECT
(SELECT COUNT(*) AS total_schools
FROM "Schools" s
WHERE ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))),

(SELECT COUNT(*) AS bangor_area_fire_stations
FROM "Fire_Stations" f
WHERE ST_Within(f.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))),

(SELECT COUNT(*) AS bangor_area_police_stations
FROM "Law_Enforcement" l
WHERE ST_Within(l.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))),

(SELECT COUNT(*) AS bangor_area_hospitals
FROM "Hospitals" h
WHERE ST_Within(h.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919)));



--Ratio of schools to amenities
--Police Stations
SELECT 
    (SELECT COUNT(s.id) FROM "Schools" s) 
    / 
    (SELECT COUNT(l.id) FROM "Law_Enforcement" l) 
    AS schools_to_police_stations_ratio,

--Bangor
    (SELECT COUNT(s.geom) 
    FROM "Schools" s
    WHERE ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))) * 1.0
    / 
    (SELECT COUNT(l.geom) 
    FROM "Law_Enforcement" l
    WHERE ST_Within(l.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))) 
    AS bangor_schools_to_police_stations_ratio,

--Fire Stations   
    (SELECT COUNT(s.id) FROM "Schools" s) 
    / 
    (SELECT COUNT(f.id) FROM "Fire_Stations" f) 
    AS schools_to_fire_stations_ratio,

--Bangor
    (SELECT COUNT(s.geom) FROM "Schools" s
    WHERE ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))) * 1.0
    / 
   (SELECT COUNT(f.geom) FROM "Fire_Stations" f
    WHERE ST_Within(f.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))) 
    AS bangor_schools_to_fire_stations_ratio,

--Hospitals
    (SELECT COUNT(s.id) FROM "Schools" s) 
    / 
    (SELECT COUNT(h.id) FROM "Hospitals" h) 
    AS schools_to_hospitals_ratio,

--Bangor
    (SELECT COUNT(s.geom) 
    FROM "Schools" s
    WHERE ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))) * 1.0
    / 
    (SELECT COUNT(h.geom) 
    FROM "Hospitals" h
    WHERE ST_Within(h.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))) 
    AS bangor_schools_to_hospitals_ratio;



-- Closest school to fire station (within 100 km)
SELECT 
	s.name AS school,
	f.landmark AS fire_station,
	ST_Distance(s.geom, f.geom) AS distance_m
FROM 
    "Schools" s
JOIN 
    "Fire_Stations" f
ON 
    ST_Distance(s.geom, f.geom) = (
        SELECT MIN(ST_Distance(s.geom, f1.geom)) 
        FROM "Fire_Stations" f1)
WHERE 
    ST_Distance(s.geom, f.geom) <= 100000 -- 100 km
ORDER BY 
	distance_m
LIMIT 1;

--Bangor closest school to fire station
SELECT 
    s.name AS school,
    f.landmark AS fire_station,
    ST_Distance(s.geom, f.geom) AS distance_m
FROM 
    "Schools" s
JOIN 
    "Fire_Stations" f
ON 
    ST_Distance(s.geom, f.geom) = (
        SELECT MIN(ST_Distance(s.geom, f1.geom)) 
        FROM "Fire_Stations" f1)
WHERE 
    ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
    AND ST_Within(f.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
ORDER BY 
	distance_m
LIMIT 1;


-- Furthest school from the closest fire station (within 100 km)
SELECT 
	s.name AS school,
	f.landmark AS fire_station,
	ST_Distance(s.geom, f.geom) AS distance_m
FROM 
    "Schools" s
JOIN 
    "Fire_Stations" f
ON 
    ST_Distance(s.geom, f.geom) = (
        SELECT MIN(ST_Distance(s.geom, f1.geom)) 
        FROM "Fire_Stations" f1)
WHERE 
    ST_Distance(s.geom, f.geom) <= 100000
ORDER BY 
    distance_m DESC
LIMIT 1;

--Bangor furthest school from closest fire station
SELECT 
    s.name AS school,
    f.landmark AS fire_station,
    ST_Distance(s.geom, f.geom) AS distance_m
FROM 
    "Schools" s
JOIN 
    "Fire_Stations" f
ON 
    ST_Distance(s.geom, f.geom) = (
        SELECT MIN(ST_Distance(s.geom, f1.geom)) 
        FROM "Fire_Stations" f1)
WHERE 
    ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
    AND ST_Within(f.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
ORDER BY 
	distance_m DESC
LIMIT 1;


-- Average min distance to fire station
SELECT 
    AVG(ST_Distance(s.geom, f.geom)) AS avg_distance_m
FROM 
    "Schools" s
JOIN 
    "Fire_Stations" f
ON 
    ST_Distance(s.geom, f.geom) = (
        SELECT MIN(ST_Distance(s.geom, f1.geom)) 
        FROM "Fire_Stations" f1
    );

-- Bangor average min distance to fire station
SELECT 
    AVG(ST_Distance(s.geom, f.geom)) AS avg_distance_m
FROM 
    "Schools" s
JOIN 
    "Fire_Stations" f
ON 
    ST_Distance(s.geom, f.geom) = (
        SELECT MIN(ST_Distance(s.geom, f1.geom)) 
        FROM "Fire_Stations" f1
    )
WHERE 
    ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
    AND ST_Within(f.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919));

-- Closest school to police station (within 100 km)
SELECT 
	s.name AS school,
	l.landmark AS police_station,
	ST_Distance(s.geom, l.geom) AS distance_m
FROM 
    "Schools" s
JOIN 
    "Law_Enforcement" l
ON 
    ST_Distance(s.geom, l.geom) = (
        SELECT MIN(ST_Distance(s.geom, l1.geom)) 
        FROM "Law_Enforcement" l1)
WHERE 
    ST_Distance(s.geom, l.geom) <= 100000
ORDER BY 
    distance_m
LIMIT 1;

--Bangor closest school to police station
SELECT 
    s.name AS school,
    l.landmark AS police_station,
    ST_Distance(s.geom, l.geom) AS distance_m
FROM 
    "Schools" s
JOIN 
    "Law_Enforcement" l
ON 
    ST_Distance(s.geom, l.geom) = (
        SELECT MIN(ST_Distance(s.geom, l1.geom)) 
        FROM "Law_Enforcement" l1)
WHERE 
    ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
    AND ST_Within(l.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
ORDER BY 
    distance_m
LIMIT 1;


-- Furthest school from the closest police station (within 100 km)
SELECT 
	s.name AS school,
	l.landmark AS police_station,
	ST_Distance(s.geom, l.geom) AS distance_m
FROM 
    "Schools" s
JOIN 
    "Law_Enforcement" l
ON 
    ST_Distance(s.geom, l.geom) = (
        SELECT MIN(ST_Distance(s.geom, l1.geom)) 
        FROM "Law_Enforcement" l1)
WHERE 
    ST_Distance(s.geom, l.geom) <= 100000
ORDER BY 
    distance_m DESC
LIMIT 1;

--Bangor furthest school from closest police station
SELECT 
    s.name AS school,
    l.landmark AS police_station,
    ST_Distance(s.geom, l.geom) AS distance_m
FROM 
    "Schools" s
JOIN 
    "Law_Enforcement" l
ON 
    ST_Distance(s.geom, l.geom) = (
        SELECT MIN(ST_Distance(s.geom, l1.geom)) 
        FROM "Law_Enforcement" l1)
WHERE 
    ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
    AND ST_Within(l.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
ORDER BY 
    distance_m DESC
LIMIT 1;

-- Average min distance to police station
SELECT 
    AVG(ST_Distance(s.geom, l.geom)) AS avg_distance_m
FROM 
    "Schools" s
JOIN 
    "Law_Enforcement" l
ON 
    ST_Distance(s.geom, l.geom) = (
        SELECT MIN(ST_Distance(s.geom, l1.geom)) 
        FROM "Law_Enforcement" l1
    );

-- Bangor average min distance to police station
SELECT 
    AVG(ST_Distance(s.geom, l.geom)) AS avg_distance_m
FROM 
    "Schools" s
JOIN 
    "Law_Enforcement" l
ON 
    ST_Distance(s.geom, l.geom) = (
        SELECT MIN(ST_Distance(s.geom, l1.geom)) 
        FROM "Law_Enforcement" l1
    )
WHERE 
    ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
    AND ST_Within(l.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919));


-- Closest school to hospital (within 100 km)
SELECT 
	s.name AS school,
	h.landmark AS hospital,
	ST_Distance(s.geom, h.geom) AS distance_m
FROM 
    "Schools" s
JOIN 
    "Hospitals" h
ON 
    ST_Distance(s.geom, h.geom) = (
        SELECT MIN(ST_Distance(s.geom, h1.geom)) 
        FROM "Hospitals" h1)
WHERE 
    ST_Distance(s.geom, h.geom) <= 100000
ORDER BY 
    distance_m
LIMIT 1;

--Bangor closest school to hospital
SELECT 
    s.name AS school,
    h.landmark AS hospital,
    ST_Distance(s.geom, h.geom) AS distance_m
FROM 
    "Schools" s
JOIN 
    "Hospitals" h
ON 
    ST_Distance(s.geom, h.geom) = (
        SELECT MIN(ST_Distance(s.geom, h1.geom)) 
        FROM "Hospitals" h1)
WHERE 
    ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
    AND ST_Within(h.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
ORDER BY 
    distance_m
LIMIT 1;


-- Furthest school from the closest hospital (within 100 km)
SELECT 
	s.name AS school,
	h.landmark AS hospital,
	ST_Distance(s.geom, h.geom) AS distance_m 
FROM 
    "Schools" s
JOIN 
    "Hospitals" h
ON 
    ST_Distance(s.geom, h.geom) = (
        SELECT MIN(ST_Distance(s.geom, h1.geom)) 
        FROM "Hospitals" h1)
WHERE 
    ST_Distance(s.geom, h.geom) <= 100000
ORDER BY 
    distance_m DESC
LIMIT 1;

--Bangor furthest school from closest hospital
SELECT 
    s.name AS school,
    h.landmark AS hospital,
    ST_Distance(s.geom, h.geom) AS distance_m 
FROM 
    "Schools" s
JOIN 
    "Hospitals" h
ON 
    ST_Distance(s.geom, h.geom) = (
        SELECT MIN(ST_Distance(s.geom, h1.geom)) 
        FROM "Hospitals" h1)
WHERE 
    ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
    AND ST_Within(h.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
ORDER BY 
    distance_m DESC
LIMIT 1;


-- Average min distance to hospital
SELECT 
    AVG(ST_Distance(s.geom, h.geom)) AS avg_distance_m
FROM 
    "Schools" s
JOIN 
    "Hospitals" h
ON 
    ST_Distance(s.geom, h.geom) = (
        SELECT MIN(ST_Distance(s.geom, h1.geom)) 
        FROM "Hospitals" h1
    );

-- Bangor min average distance to hospital
SELECT 
    AVG(ST_Distance(s.geom, h.geom)) AS avg_distance_m
FROM 
    "Schools" s
JOIN 
    "Hospitals" h
ON 
    ST_Distance(s.geom, h.geom) = (
        SELECT MIN(ST_Distance(s.geom, h1.geom)) 
        FROM "Hospitals" h1
    )
WHERE 
    ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919))
    AND ST_Within(h.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919));


--Municipality comparisons
WITH school_counts AS (
    SELECT ub.town, COUNT(s.id) AS total_schools
    FROM "Urban_Boundaries" ub
    LEFT JOIN "Schools" s ON ST_Within(s.geom, ST_Transform(ub.geom, 26919))
    GROUP BY ub.town
)
, fire_station_counts AS (
    SELECT ub.town, COUNT(f.id) AS total_fire_stations
    FROM "Urban_Boundaries" ub
    LEFT JOIN "Fire_Stations" f ON ST_Within(f.geom, ST_Transform(ub.geom, 26919))
    GROUP BY ub.town
)
, police_station_counts AS (
    SELECT ub.town, COUNT(l.id) AS total_police_stations
    FROM "Urban_Boundaries" ub
    LEFT JOIN "Law_Enforcement" l ON ST_Within(l.geom, ST_Transform(ub.geom, 26919))
    GROUP BY ub.town
)
, hospital_counts AS (
    SELECT ub.town, COUNT(h.id) AS total_hospitals
    FROM "Urban_Boundaries" ub
    LEFT JOIN "Hospitals" h ON ST_Within(h.geom, ST_Transform(ub.geom, 26919))
    GROUP BY ub.town
)
SELECT 
    sc.town,
    sc.total_schools,
    fc.total_fire_stations,
    pc.total_police_stations,
    hc.total_hospitals,
    sc.total_schools * 1.0 / fc.total_fire_stations AS schools_to_fire_stations_ratio,
    sc.total_schools * 1.0 / pc.total_police_stations AS schools_to_police_stations_ratio,
    sc.total_schools * 1.0 / NULLIF(hc.total_hospitals, 0) AS schools_to_hospitals_ratio -- Some municipalities do not have hospitals enclosed.
FROM 
    school_counts sc
JOIN 
    fire_station_counts fc ON sc.town = fc.town
JOIN 
    police_station_counts pc ON sc.town = pc.town
JOIN 
    hospital_counts hc ON sc.town = hc.town;