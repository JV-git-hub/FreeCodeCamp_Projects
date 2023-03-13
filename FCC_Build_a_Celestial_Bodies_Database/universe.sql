--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(25) NOT NULL,
    distance_from_earth_kpc numeric(9,3),
    ngc_id integer NOT NULL,
    description text
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(20),
    mean_radius_km numeric,
    mass_kg numeric,
    orbital_period_earth_days numeric,
    planet_id integer NOT NULL,
    parent_planet_name character varying(20)
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: moons_and_planets; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moons_and_planets (
    name character varying(20),
    planet character varying(20),
    moon_id integer NOT NULL,
    planet_id integer,
    moons_and_planets_id integer NOT NULL
);


ALTER TABLE public.moons_and_planets OWNER TO freecodecamp;

--
-- Name: moons_and_planets_moons_and_planets_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moons_and_planets_moons_and_planets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moons_and_planets_moons_and_planets_id_seq OWNER TO freecodecamp;

--
-- Name: moons_and_planets_moons_and_planets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moons_and_planets_moons_and_planets_id_seq OWNED BY public.moons_and_planets.moons_and_planets_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(20),
    in_habitable_zone boolean,
    orbital_period_days numeric,
    mass_earth_fraction numeric,
    star_id integer NOT NULL,
    parent_star_name character varying(30),
    day_length_earth_days numeric
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30),
    catalog_id character varying(40),
    distance_from_earth_ly numeric,
    mass_in_solar_masses numeric,
    type character varying(40),
    visible_unaided boolean,
    galaxy_id integer NOT NULL,
    parent_galaxy_name character varying(25),
    number_of_planets integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: stars_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.stars_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stars_star_id_seq OWNER TO freecodecamp;

--
-- Name: stars_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.stars_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: moons_and_planets moons_and_planets_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moons_and_planets ALTER COLUMN moons_and_planets_id SET DEFAULT nextval('public.moons_and_planets_moons_and_planets_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.stars_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Andromeda', 765.000, 224, 'barred spiral galaxy in Local Group');
INSERT INTO public.galaxy VALUES (2, 'Backward', 61940.000, 4622, 'spiral galaxy with leading spiral arms');
INSERT INTO public.galaxy VALUES (3, 'Condor', 66210.000, 6872, 'barred spiral galaxy in Pavo constellation');
INSERT INTO public.galaxy VALUES (4, 'Eye of Sauron', 15800.000, 4151, 'intermediate spiral Seyfert galaxy in Canes Venatici constellation');
INSERT INTO public.galaxy VALUES (5, 'Milky Way', 7.672, 0, 'Our galaxy, spiral -- distance is to center of galaxy');
INSERT INTO public.galaxy VALUES (6, 'Needle', 13100.000, 0, 'Edge-on spiral galaxy in Coma Berenices constellation');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 1737.4, 73420000000000000000000, 29.530589, 17, 'Earth');
INSERT INTO public.moon VALUES (2, 'Phobos', 11.2667, 10659000000000000, 0.31891023, 18, 'Mars');
INSERT INTO public.moon VALUES (3, 'Deimos', 6.2, 1476200000000000, 1.263, 18, 'Mars');
INSERT INTO public.moon VALUES (4, 'Ganymede', 2634.1, 148190000000000000000000, 7.15455296, 19, 'Jupiter');
INSERT INTO public.moon VALUES (5, 'Callisto', 2410.3, 107593800000000000000000, 16.6890184, 19, 'Jupiter');
INSERT INTO public.moon VALUES (6, 'Io', 1821.6, 89319380000000000000000, 1.769137786, 19, 'Jupiter');
INSERT INTO public.moon VALUES (7, 'Europa', 1560.8, 47998440000000000000000, 3.551181, 19, 'Jupiter');
INSERT INTO public.moon VALUES (8, 'Titan', 2574.73, 134520000000000000000000, 15.945, 20, 'Saturn');
INSERT INTO public.moon VALUES (9, 'Rhea', 763.8, 2306518000000000000000, 4.518212, 20, 'Saturn');
INSERT INTO public.moon VALUES (10, 'Iapetus', 734.5, 1805635000000000000000, 79.3215, 20, 'Saturn');
INSERT INTO public.moon VALUES (11, 'Dione', 561.4, 1095452000000000000000, 2.736915, 20, 'Saturn');
INSERT INTO public.moon VALUES (12, 'Tethys', 531.1, 617449000000000000000, 1.887802, 20, 'Saturn');
INSERT INTO public.moon VALUES (13, 'Enceladus', 252.1, 108022000000000000000, 1.370218, 20, 'Saturn');
INSERT INTO public.moon VALUES (14, 'Mimas', 198.2, 37493000000000000000, 0.942421959, 20, 'Saturn');
INSERT INTO public.moon VALUES (15, 'Titania', 788.4, 3400000000000000000000, 8.706234, 21, 'Uranus');
INSERT INTO public.moon VALUES (16, 'Oberon', 761.4, 3076000000000000000000, 13.463234, 21, 'Uranus');
INSERT INTO public.moon VALUES (17, 'Umbriel', 584.7, 1275000000000000000000, 4.144, 21, 'Uranus');
INSERT INTO public.moon VALUES (18, 'Ariel', 578.9, 1251000000000000000000, 2.520, 21, 'Uranus');
INSERT INTO public.moon VALUES (19, 'Miranda', 235.8, 64000000000000000000, 1.413479, 21, 'Uranus');
INSERT INTO public.moon VALUES (20, 'Proteus', 210, 44000000000000000000, 1.12231477, 22, 'Neptune');
INSERT INTO public.moon VALUES (21, 'Larissa', 97, 4200000000000000000, 0.55465332, 22, 'Neptune');
INSERT INTO public.moon VALUES (22, 'Galatea', 87.4, 2120000000000000000, 0.42874431, 22, 'Neptune');
INSERT INTO public.moon VALUES (23, 'Despina', 78, 2200000000000000000, 0.33465551, 22, 'Neptune');
INSERT INTO public.moon VALUES (24, 'Thalassa', 40.7, NULL, 0.31148444, 22, 'Neptune');
INSERT INTO public.moon VALUES (25, 'Naiad', 30.2, NULL, 0.2943958, 22, 'Neptune');


--
-- Data for Name: moons_and_planets; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moons_and_planets VALUES ('Moon', 'Earth', 1, 17, 1);
INSERT INTO public.moons_and_planets VALUES ('Deimos', 'Mars', 3, 18, 2);
INSERT INTO public.moons_and_planets VALUES ('Phobos', 'Mars', 2, 18, 3);
INSERT INTO public.moons_and_planets VALUES ('Europa', 'Jupiter', 7, 19, 4);
INSERT INTO public.moons_and_planets VALUES ('Io', 'Jupiter', 6, 19, 5);
INSERT INTO public.moons_and_planets VALUES ('Callisto', 'Jupiter', 5, 19, 6);
INSERT INTO public.moons_and_planets VALUES ('Ganymede', 'Jupiter', 4, 19, 7);
INSERT INTO public.moons_and_planets VALUES ('Mimas', 'Saturn', 14, 20, 8);
INSERT INTO public.moons_and_planets VALUES ('Enceladus', 'Saturn', 13, 20, 9);
INSERT INTO public.moons_and_planets VALUES ('Tethys', 'Saturn', 12, 20, 10);
INSERT INTO public.moons_and_planets VALUES ('Dione', 'Saturn', 11, 20, 11);
INSERT INTO public.moons_and_planets VALUES ('Iapetus', 'Saturn', 10, 20, 12);
INSERT INTO public.moons_and_planets VALUES ('Rhea', 'Saturn', 9, 20, 13);
INSERT INTO public.moons_and_planets VALUES ('Titan', 'Saturn', 8, 20, 14);
INSERT INTO public.moons_and_planets VALUES ('Miranda', 'Uranus', 19, 21, 15);
INSERT INTO public.moons_and_planets VALUES ('Ariel', 'Uranus', 18, 21, 16);
INSERT INTO public.moons_and_planets VALUES ('Umbriel', 'Uranus', 17, 21, 17);
INSERT INTO public.moons_and_planets VALUES ('Oberon', 'Uranus', 16, 21, 18);
INSERT INTO public.moons_and_planets VALUES ('Titania', 'Uranus', 15, 21, 19);
INSERT INTO public.moons_and_planets VALUES ('Naiad', 'Neptune', 25, 22, 20);
INSERT INTO public.moons_and_planets VALUES ('Thalassa', 'Neptune', 24, 22, 21);
INSERT INTO public.moons_and_planets VALUES ('Despina', 'Neptune', 23, 22, 22);
INSERT INTO public.moons_and_planets VALUES ('Galatea', 'Neptune', 22, 22, 23);
INSERT INTO public.moons_and_planets VALUES ('Larissa', 'Neptune', 21, 22, 24);
INSERT INTO public.moons_and_planets VALUES ('Proteus', 'Neptune', 20, 22, 25);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Tau Ceti e', true, 162.9, 3.9, 4, 'Tau Ceti', NULL);
INSERT INTO public.planet VALUES (2, 'Tau Ceti f', true, 620.5, 3.9, 4, 'Tau Ceti', NULL);
INSERT INTO public.planet VALUES (3, 'Tau Ceti g', false, 20, 1.8, 4, 'Tau Ceti', NULL);
INSERT INTO public.planet VALUES (4, 'Tau Ceti h', false, 49.41, 1.8, 4, 'Tau Ceti', NULL);
INSERT INTO public.planet VALUES (5, 'Wolf 1601 b', false, 4.8876, 1.91, 5, 'Wolf 1601', NULL);
INSERT INTO public.planet VALUES (6, 'Wolf 1601 c', true, 17.867, 3.41, 5, 'Wolf 1601', NULL);
INSERT INTO public.planet VALUES (7, 'Wolf 1601 d', false, 67.27, 7.7, 5, 'Wolf 1601', NULL);
INSERT INTO public.planet VALUES (8, 'TRAPPIST-1 b', false, 1.5109, 1.017, 6, 'TRAPPIST-1', NULL);
INSERT INTO public.planet VALUES (9, 'TRAPPIST-1 c', false, 2.4218, 1.16, 6, 'TRAPPIST-1', NULL);
INSERT INTO public.planet VALUES (10, 'TRAPPIST-1 d', false, 4.0498, 0.3, 6, 'TRAPPIST-1', NULL);
INSERT INTO public.planet VALUES (11, 'TRAPPIST-1 e', false, 6.0996, 0.77, 6, 'TRAPPIST-1', NULL);
INSERT INTO public.planet VALUES (12, 'TRAPPIST-1 f', false, 9.2065, 0.93, 6, 'TRAPPIST-1', NULL);
INSERT INTO public.planet VALUES (13, 'TRAPPIST-1 g', true, 12.3528, 1.15, 6, 'TRAPPIST-1', NULL);
INSERT INTO public.planet VALUES (14, 'TRAPPIST-1 h', true, 18.7663, 0.33, 6, 'TRAPPIST-1', NULL);
INSERT INTO public.planet VALUES (15, 'Mercury', false, 87.9691, 0.055, 7, 'SUN', 176);
INSERT INTO public.planet VALUES (16, 'Venus', true, 224.701, 0.815, 7, 'SUN', 116.75);
INSERT INTO public.planet VALUES (17, 'Earth', true, 365.256, 1, 7, 'SUN', 1);
INSERT INTO public.planet VALUES (18, 'Mars', true, 686.98, 0.107, 7, 'SUN', 1.02749125);
INSERT INTO public.planet VALUES (19, 'Jupiter', false, 4332.59, 317.8, 7, 'SUN', 0.413575);
INSERT INTO public.planet VALUES (20, 'Saturn', false, 10759.22, 95.159, 7, 'SUN', 0.4393);
INSERT INTO public.planet VALUES (21, 'Uranus', false, 30688.5, 14.536, 7, 'SUN', 0.71832);
INSERT INTO public.planet VALUES (22, 'Neptune', false, 60195, 17.147, 7, 'SUN', 0.67125);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'M31 V1', NULL, 2800000, NULL, 'Cepheid Variable', false, 1, 'Andromeda', NULL);
INSERT INTO public.star VALUES (2, 'SN 2001jx', 'Super Nova Catalogue, 2001jx', 200000000, NULL, 'Super Nova', false, 2, 'Backward', NULL);
INSERT INTO public.star VALUES (3, 'RX J1236.2+2558', 'SIMBAD, RX J1236.2+2558', 42700000, NULL, 'Intermediate-luminosty X-ray Source', false, 6, 'Needle', NULL);
INSERT INTO public.star VALUES (4, 'Tau Ceti', 'SIMBAD, tau Cet', 11.912, 0.783, 'G', true, 5, 'Milky Way', 4);
INSERT INTO public.star VALUES (5, 'Wolf 1601', 'SIMBAD BD-12 4523', 14.050, 0.304, 'M-class red dwarf', false, 5, 'Milky Way', 3);
INSERT INTO public.star VALUES (6, 'TRAPPIST-1', 'SIMBAD, TRAPPIST-1', 40.66, 0.0898, 'Ultra-cool red dwarf', false, 5, 'Milky Way', 7);
INSERT INTO public.star VALUES (7, 'SUN', 'Wikipedia, Sun', 0.000015813, 0.9986, 'G-type main sequence', true, 5, 'Milky Way', 8);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 25, true);


--
-- Name: moons_and_planets_moons_and_planets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moons_and_planets_moons_and_planets_id_seq', 25, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 22, true);


--
-- Name: stars_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.stars_star_id_seq', 7, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: moons_and_planets moons_and_planets_moon_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moons_and_planets
    ADD CONSTRAINT moons_and_planets_moon_key UNIQUE (name);


--
-- Name: moons_and_planets moons_and_planets_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moons_and_planets
    ADD CONSTRAINT moons_and_planets_pkey PRIMARY KEY (moons_and_planets_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star stars_catalog_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT stars_catalog_id_key UNIQUE (catalog_id);


--
-- Name: star stars_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT stars_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- PostgreSQL database dump complete
--

