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
        FROM "Fire_Stations" f1
    )
WHERE 
    ST_Distance(s.geom, f.geom) <= 100000 -- 100 km
ORDER BY 
    ST_Distance(s.geom, f.geom)
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
        FROM "Fire_Stations" f1
    )
WHERE 
    ST_Distance(s.geom, f.geom) <= 100000
ORDER BY 
    ST_Distance(s.geom, f.geom) DESC
LIMIT 1;


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
        FROM "Law_Enforcement" l1
    )
WHERE 
    ST_Distance(s.geom, l.geom) <= 100000
ORDER BY 
    ST_Distance(s.geom, l.geom)
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
        FROM "Law_Enforcement" l1
    )
WHERE 
    ST_Distance(s.geom, l.geom) <= 100000
ORDER BY 
    ST_Distance(s.geom, l.geom) DESC
LIMIT 1;


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
        FROM "Hospitals" h1
    )
WHERE 
    ST_Distance(s.geom, h.geom) <= 100000
ORDER BY 
    ST_Distance(s.geom, h.geom)
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
        FROM "Hospitals" h1
    )
WHERE 
    ST_Distance(s.geom, h.geom) <= 100000
ORDER BY 
    ST_Distance(s.geom, h.geom) DESC
LIMIT 1;


--Ratio of schools to amenities
SELECT 
    (SELECT COUNT(s.id) FROM "Schools" s) 
    / 
    (SELECT COUNT(l.id) FROM "Law_Enforcement" l) 
    AS schools_to_police_stations_ratio,
    
    (SELECT COUNT(s.id) FROM "Schools" s) 
    / 
    (SELECT COUNT(f.id) FROM "Fire_Stations" f) 
    AS schools_to_fire_stations_ratio,

    (SELECT COUNT(s.id) FROM "Schools" s) 
    / 
    (SELECT COUNT(h.id) FROM "Hospitals" h) 
    AS schools_to_hospitals_ratio;


SELECT COUNT(*) AS total_schools_gbr
FROM public."Schools" s
WHERE ST_Within(s.geom, ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326));


SELECT ST_AsText(ST_MakeEnvelope(-70.0, 40.0, -69.0, 41.0, 4326)) AS bounding_box;
