--Closest school to fire station
--School
SELECT 
	ST_Distance(s.geom, f.geom) AS distance,
	f.landmark AS fire_station,
    s.*
FROM 
    public."Schools" s
JOIN 
    public."Fire_Stations" f
ON 
    ST_Distance(s.geom, f.geom) = (
        SELECT MIN(ST_Distance(s.geom, f1.geom)) 
        FROM public."Fire_Stations" f1
    )
WHERE 
    ST_Distance(s.geom, f.geom) <= 100000
ORDER BY 
    distance
LIMIT 1;

--Station
SELECT 
	ST_Distance(s.geom, f.geom) AS distance,
	f.landmark AS fire_station,
    f.*
FROM 
    public."Schools" s
JOIN 
    public."Fire_Stations" f
ON 
    ST_Distance(s.geom, f.geom) = (
        SELECT MIN(ST_Distance(s.geom, f1.geom)) 
        FROM public."Fire_Stations" f1
    )
WHERE 
    ST_Distance(s.geom, f.geom) <= 100000
ORDER BY 
    distance
LIMIT 1;


-- Furthest school from the closest fire station (within 100 km)
--School
SELECT 
	ST_Distance(s.geom, f.geom) AS distance,
	f.landmark AS fire_station,
    s.*	
FROM 
    public."Schools" s
JOIN 
    public."Fire_Stations" f
ON 
    ST_Distance(s.geom, f.geom) = (
        SELECT MIN(ST_Distance(s.geom, f1.geom)) 
        FROM public."Fire_Stations" f1
    )
WHERE 
    ST_Distance(s.geom, f.geom) <= 100000
ORDER BY 
    distance DESC
LIMIT 1;

--Station
SELECT 
	ST_Distance(s.geom, f.geom) AS distance,
	f.landmark AS fire_station,
    f.*	
FROM 
    public."Schools" s
JOIN 
    public."Fire_Stations" f
ON 
    ST_Distance(s.geom, f.geom) = (
        SELECT MIN(ST_Distance(s.geom, f1.geom)) 
        FROM public."Fire_Stations" f1
    )
WHERE 
    ST_Distance(s.geom, f.geom) <= 100000
ORDER BY 
    distance DESC
LIMIT 1;


-- Closest school to police station (within 100 km)
--School
SELECT 
	ST_Distance(s.geom, l.geom) AS distance,
	l.landmark AS police_station,
    s.*
FROM 
    public."Schools" s
JOIN 
    public."Law_Enforcement" l
ON 
    ST_Distance(s.geom, l.geom) = (
        SELECT MIN(ST_Distance(s.geom, l1.geom)) 
        FROM public."Law_Enforcement" l1
    )
WHERE 
    ST_Distance(s.geom, l.geom) <= 100000
ORDER BY 
    distance
LIMIT 1;

--Station
SELECT 
	ST_Distance(s.geom, l.geom) AS distance,
	l.landmark AS police_station,
    l.*
FROM 
    public."Schools" s
JOIN 
    public."Law_Enforcement" l
ON 
    ST_Distance(s.geom, l.geom) = (
        SELECT MIN(ST_Distance(s.geom, l1.geom)) 
        FROM public."Law_Enforcement" l1
    )
WHERE 
    ST_Distance(s.geom, l.geom) <= 100000
ORDER BY 
    distance
LIMIT 1;

-- Furthest school from the closest police station (within 100 km)
--School
SELECT 
	ST_Distance(s.geom, l.geom) AS distance,
	l.landmark AS police_station,
    s.*
FROM 
    public."Schools" s
JOIN 
    public."Law_Enforcement" l
ON 
    ST_Distance(s.geom, l.geom) = (
        SELECT MIN(ST_Distance(s.geom, l1.geom)) 
        FROM public."Law_Enforcement" l1
    )
WHERE 
    ST_Distance(s.geom, l.geom) <= 100000
ORDER BY 
    distance DESC
LIMIT 1;

--Station
SELECT 
	ST_Distance(s.geom, l.geom) AS distance,
	l.landmark AS police_station,
    l.*
FROM 
    public."Schools" s
JOIN 
    public."Law_Enforcement" l
ON 
    ST_Distance(s.geom, l.geom) = (
        SELECT MIN(ST_Distance(s.geom, l1.geom)) 
        FROM public."Law_Enforcement" l1
    )
WHERE 
    ST_Distance(s.geom, l.geom) <= 100000
ORDER BY 
    distance DESC
LIMIT 1;

-- Closest school to hospital
--School
SELECT 
	ST_Distance(s.geom, h.geom) AS distance,
	h.landmark AS hospital,
    s.*  
FROM 
    public."Schools" s
JOIN 
    public."Hospitals" h
ON 
    ST_Distance(s.geom, h.geom) = (
        SELECT MIN(ST_Distance(s.geom, h1.geom)) 
        FROM public."Hospitals" h1
    )
WHERE 
    ST_Distance(s.geom, h.geom) <= 100000
ORDER BY 
    distance
LIMIT 1;

--Hospital
SELECT 
	ST_Distance(s.geom, h.geom) AS distance,
	h.landmark AS hospital,
    h.*  
FROM 
    public."Schools" s
JOIN 
    public."Hospitals" h
ON 
    ST_Distance(s.geom, h.geom) = (
        SELECT MIN(ST_Distance(s.geom, h1.geom)) 
        FROM public."Hospitals" h1
    )
WHERE 
    ST_Distance(s.geom, h.geom) <= 100000
ORDER BY 
    distance
LIMIT 1;


-- Furthest school from the closest hospital (within 100 km)
--School
SELECT 
	ST_Distance(s.geom, h.geom) AS distance,
	h.landmark AS hospital,
    s.*  
FROM 
    public."Schools" s
JOIN 
    public."Hospitals" h
ON 
    ST_Distance(s.geom, h.geom) = (
        SELECT MIN(ST_Distance(s.geom, h1.geom)) 
        FROM public."Hospitals" h1
    )
WHERE 
    ST_Distance(s.geom, h.geom) <= 100000
ORDER BY 
    distance DESC
LIMIT 1;

--Hospital
SELECT 
	ST_Distance(s.geom, h.geom) AS distance,
	h.landmark AS hospital,
    h.*  
FROM 
    public."Schools" s
JOIN 
    public."Hospitals" h
ON 
    ST_Distance(s.geom, h.geom) = (
        SELECT MIN(ST_Distance(s.geom, h1.geom)) 
        FROM public."Hospitals" h1
    )
WHERE 
    ST_Distance(s.geom, h.geom) <= 100000
ORDER BY 
    distance DESC
LIMIT 1;


SELECT ST_SRID(geom) FROM public."Schools" LIMIT 1;


SELECT ST_SetSRID(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251),4326) AS bounding_box;


--Facilities in Bangor
--Schools
SELECT s.*
FROM public."Schools" s
WHERE ST_Within(s.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919));

--Fire Stations
SELECT f.*
FROM public."Fire_Stations" f
WHERE ST_Within(f.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919));

--Police Stations
SELECT l.*
FROM public."Law_Enforcement" l
WHERE ST_Within(l.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919));

--Hospitals
SELECT h.*
FROM public."Hospitals" h
WHERE ST_Within(h.geom, ST_Transform(ST_MakeEnvelope(-69.235756, 44.653623, -68.395480, 45.132251, 4326), 26919));
