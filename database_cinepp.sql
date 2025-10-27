--
-- PostgreSQL database dump
--

\restrict PFF41qHjF3JwDvUzMzX6FlZCtonUUtQCXmkli2bwVALhQNkfa9HR5RFHw1PwDl7

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-10-27 08:40:54

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 228 (class 1259 OID 16481)
-- Name: actores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.actores (
    actor_id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    biografia text,
    foto_url character varying(500),
    esta_activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.actores OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16480)
-- Name: actores_actor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.actores_actor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actores_actor_id_seq OWNER TO postgres;

--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 227
-- Name: actores_actor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.actores_actor_id_seq OWNED BY public.actores.actor_id;


--
-- TOC entry 224 (class 1259 OID 16422)
-- Name: calificaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calificaciones (
    calificacion_id integer NOT NULL,
    usuario_id integer NOT NULL,
    pelicula_id integer NOT NULL,
    puntuacion smallint NOT NULL,
    fecha_calificacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT calificaciones_puntuacion_check CHECK (((puntuacion >= 1) AND (puntuacion <= 5)))
);


ALTER TABLE public.calificaciones OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16421)
-- Name: calificaciones_calificacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.calificaciones_calificacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.calificaciones_calificacion_id_seq OWNER TO postgres;

--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 223
-- Name: calificaciones_calificacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.calificaciones_calificacion_id_seq OWNED BY public.calificaciones.calificacion_id;


--
-- TOC entry 226 (class 1259 OID 16447)
-- Name: comentarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comentarios (
    comentario_id integer NOT NULL,
    usuario_id integer NOT NULL,
    pelicula_id integer NOT NULL,
    texto_comentario text NOT NULL,
    fecha_comentario timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.comentarios OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16446)
-- Name: comentarios_comentario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comentarios_comentario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comentarios_comentario_id_seq OWNER TO postgres;

--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 225
-- Name: comentarios_comentario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comentarios_comentario_id_seq OWNED BY public.comentarios.comentario_id;


--
-- TOC entry 229 (class 1259 OID 16494)
-- Name: pelicula_actores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pelicula_actores (
    pelicula_id integer NOT NULL,
    actor_id integer NOT NULL
);


ALTER TABLE public.pelicula_actores OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16390)
-- Name: peliculas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.peliculas (
    pelicula_id integer NOT NULL,
    titulo character varying(255) NOT NULL,
    genero character varying(100),
    anio_estreno integer,
    director character varying(255),
    descripcion text,
    fecha_creacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    portada_url character varying(500),
    esta_activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.peliculas OWNER TO postgres;

--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN peliculas.portada_url; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.peliculas.portada_url IS 'URL o ruta del archivo de la portada de la película';


--
-- TOC entry 219 (class 1259 OID 16389)
-- Name: peliculas_pelicula_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.peliculas_pelicula_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.peliculas_pelicula_id_seq OWNER TO postgres;

--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 219
-- Name: peliculas_pelicula_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.peliculas_pelicula_id_seq OWNED BY public.peliculas.pelicula_id;


--
-- TOC entry 222 (class 1259 OID 16402)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    usuario_id integer NOT NULL,
    nombre_usuario character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    contrasena_hash character varying(255) NOT NULL,
    tipo_usuario character varying(20) NOT NULL,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    esta_activo boolean DEFAULT true NOT NULL,
    CONSTRAINT usuarios_tipo_usuario_check CHECK (((tipo_usuario)::text = ANY ((ARRAY['Administrador'::character varying, 'Usuario Final'::character varying])::text[])))
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16401)
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_usuario_id_seq OWNER TO postgres;

--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_usuario_id_seq OWNED BY public.usuarios.usuario_id;


--
-- TOC entry 4890 (class 2604 OID 16484)
-- Name: actores actor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actores ALTER COLUMN actor_id SET DEFAULT nextval('public.actores_actor_id_seq'::regclass);


--
-- TOC entry 4886 (class 2604 OID 16425)
-- Name: calificaciones calificacion_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calificaciones ALTER COLUMN calificacion_id SET DEFAULT nextval('public.calificaciones_calificacion_id_seq'::regclass);


--
-- TOC entry 4888 (class 2604 OID 16450)
-- Name: comentarios comentario_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios ALTER COLUMN comentario_id SET DEFAULT nextval('public.comentarios_comentario_id_seq'::regclass);


--
-- TOC entry 4880 (class 2604 OID 16393)
-- Name: peliculas pelicula_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas ALTER COLUMN pelicula_id SET DEFAULT nextval('public.peliculas_pelicula_id_seq'::regclass);


--
-- TOC entry 4883 (class 2604 OID 16405)
-- Name: usuarios usuario_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuarios_usuario_id_seq'::regclass);


--
-- TOC entry 5083 (class 0 OID 16481)
-- Dependencies: 228
-- Data for Name: actores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.actores (actor_id, nombre, biografia, foto_url, esta_activo) FROM stdin;
1	Dylan O'Brien	\N	https://image.tmdb.org/t/p/w500/xN3GdvIlqsR838gDoblhPH0numP.jpg	t
2	Kaya Scodelario	\N	https://image.tmdb.org/t/p/w500/uVp7VarM5GX08hfCEGt63OM5c5c.jpg	t
3	Aml Ameen	\N	https://image.tmdb.org/t/p/w500/46V5p1lIsWu1A1nCiJAFJ5dOiPq.jpg	t
4	Thomas Brodie-Sangster	\N	https://image.tmdb.org/t/p/w500/ovfgjgaE7aAXKYaemABX6pJFwRk.jpg	t
5	Ki Hong Lee	\N	https://image.tmdb.org/t/p/w500/96zkB3e07LB1hw2segekZS1PlQb.jpg	t
6	Will Poulter	\N	https://image.tmdb.org/t/p/w500/9blYMaj79VGC6BHTLmJp3V5S8r3.jpg	t
7	Patricia Clarkson	\N	https://image.tmdb.org/t/p/w500/rHHM9G83fpBAcFathbSyV4Tot5j.jpg	t
8	Blake Cooper	\N	https://image.tmdb.org/t/p/w500/mFGnJZk83mOEF7duAi4uiaCcYvw.jpg	t
9	Dexter Darden	\N	https://image.tmdb.org/t/p/w500/4Io5JOdl17GtCaXt0ZBv0p6IEEk.jpg	t
10	Jacob Latimore	\N	https://image.tmdb.org/t/p/w500/8bdhpFXGJpXYsOB6Jn8o85VJItz.jpg	t
11	Jason Momoa	\N	https://image.tmdb.org/t/p/w500/3troAR6QbSb6nUFMDu61YCCWLKa.jpg	t
12	Jack Black	\N	https://image.tmdb.org/t/p/w500/59IhgCtiWI5yTfzPhsjzg7GjCjm.jpg	t
13	Sebastian Eugene Hansen	\N	https://image.tmdb.org/t/p/w500/40HNkoB3RKPMPgLhTyKQU6kG0sc.jpg	t
14	Emma Myers	\N	https://image.tmdb.org/t/p/w500/v1Y8RP39135ZOary9M4MbkrCAdn.jpg	t
15	Danielle Brooks	\N	https://image.tmdb.org/t/p/w500/pPSG2Vmq24cwAL5XGK1NLs3KEoZ.jpg	t
16	Jennifer Coolidge	\N	https://image.tmdb.org/t/p/w500/hcpbV0dY4ZJxmZi1WcAWe8euqV2.jpg	t
17	Rachel House	\N	https://image.tmdb.org/t/p/w500/2LCQF7Bn0I91o17GGkox0ZhhbE7.jpg	t
18	Allan Henry	\N	https://image.tmdb.org/t/p/w500/iZKNvaQutjb5Otlb7IyYqdfWJ7d.jpg	t
19	Bram Scott-Breheny	\N	https://image.tmdb.org/t/p/w500/kI51jREZQm4Gvlh4A0PzNmroU6M.jpg	t
20	Moana Williams	\N	https://image.tmdb.org/t/p/w500/xJnJYBEu2ATZetA6eqEDEDhNFUn.jpg	t
21	Christian Bale	\N	https://image.tmdb.org/t/p/w500/7Pxez9J8fuPd2Mn9kex13YALrCQ.jpg	t
22	Heath Ledger	\N	https://image.tmdb.org/t/p/w500/p2z2bURSg7nuMsN9P2s61e2RvNz.jpg	t
23	Aaron Eckhart	\N	https://image.tmdb.org/t/p/w500/u5JjnRMr9zKEVvOP7k3F6gdcwT6.jpg	t
24	Michael Caine	\N	https://image.tmdb.org/t/p/w500/bVZRMlpjTAO2pJK6v90buFgVbSW.jpg	t
25	Maggie Gyllenhaal	\N	https://image.tmdb.org/t/p/w500/vsfkWdYWmA9CpzMHTJzrFxlDnEZ.jpg	t
26	Gary Oldman	\N	https://image.tmdb.org/t/p/w500/2v9FVVBUrrkW2m3QOcYkuhq9A6o.jpg	t
27	Morgan Freeman	\N	https://image.tmdb.org/t/p/w500/jPsLqiYGSofU4s6BjrxnefMfabb.jpg	t
28	Monique Gabriela Curnen	\N	https://image.tmdb.org/t/p/w500/lJgLQs7cfM49m8VzVviwxIByz76.jpg	t
29	Ron Dean	\N	https://image.tmdb.org/t/p/w500/mgqdr4VFrTVZatkki2suNLYxeDG.jpg	t
30	Cillian Murphy	\N	https://image.tmdb.org/t/p/w500/llkbyWKwpfowZ6C8peBjIV9jj99.jpg	t
31	Yonas Kibreab	\N	https://image.tmdb.org/t/p/w500/vp7wBIQ4MkfJJ5KfN8bMOLxdSJE.jpg	t
32	Remy Edgerly	\N	https://image.tmdb.org/t/p/w500/ik41sbEMHnoAT3LMIv7f0krXRwB.jpg	t
33	Zoe Saldaña	\N	https://image.tmdb.org/t/p/w500/iOVbUH20il632nj2v01NCtYYeSg.jpg	t
34	Brad Garrett	\N	https://image.tmdb.org/t/p/w500/aOg1ce7mo85UThW9aSmBTDR7Lbt.jpg	t
35	Brandon Moon	\N	https://image.tmdb.org/t/p/w500/ocSrdXMrKNMLSJZLTrIxMaU53ie.jpg	t
36	Jameela Jamil	\N	https://image.tmdb.org/t/p/w500/jDtj84p40xmZ8jAua4wUw0JN6Ih.jpg	t
37	Young Dylan	\N	https://image.tmdb.org/t/p/w500/5o563nn5z5YSLo09oK4bhG2ENxj.jpg	t
38	Jake T. Getman	\N	https://image.tmdb.org/t/p/w500/aBDawwQUOqKMCyGzrXcU1d0zNzX.jpg	t
39	Matthias Schweighöfer	\N	https://image.tmdb.org/t/p/w500/i4c5JjvC5EpecZbp4J96mFmtm0Z.jpg	t
40	Ana de la Reguera	\N	https://image.tmdb.org/t/p/w500/hE8W86SKgIzoVsukTnL0VeGeYwB.jpg	t
41	마동석	\N	https://image.tmdb.org/t/p/w500/zt1vx7FesNA4x6mTZtyzu2uco8E.jpg	t
42	서현	\N	https://image.tmdb.org/t/p/w500/4FeVieGVZEfvwvFuz2lrrFr1529.jpg	t
43	이다윗	\N	https://image.tmdb.org/t/p/w500/qWGDFlr47d2AJLtJsOEmfmaC21l.jpg	t
44	경수진	\N	https://image.tmdb.org/t/p/w500/5gdThWkpzuNkNyQ6Cw29oOefvXO.jpg	t
45	Hyun Seung-min	\N	https://image.tmdb.org/t/p/w500/jsUPFmY1HlML92ubVtSE8L8ovz6.jpg	t
46	최광일	\N	https://image.tmdb.org/t/p/w500/6vkA8s4XDPwZBRzNhN9xSLzb3II.jpg	t
47	류승수	\N	https://image.tmdb.org/t/p/w500/x9XcfwqcXNpk2hIrP6qeR0DDkOs.jpg	t
48	전익령	\N	https://image.tmdb.org/t/p/w500/aBfBZ4JqmFBoLSDah860sEX5ggE.jpg	t
49	송요셉	\N	https://image.tmdb.org/t/p/w500/x3Cq8BGfRVxProIlpgSJniqbfWs.jpg	t
50	박옥출	\N	https://image.tmdb.org/t/p/w500/sQJ9nn0akUylBQGtDGYUA8S0Zh4.jpg	t
51	Adriane McLean	\N	https://image.tmdb.org/t/p/w500/wEegpatGIk1Z8fRqdNksS96NCKu.jpg	t
52	Sarah French	\N	https://image.tmdb.org/t/p/w500/t3lIXo0y7os0A5lIOBwrORiNLPs.jpg	t
53	Gigi Gustin	\N	https://image.tmdb.org/t/p/w500/iEI0ssWGEx1CsE53yc235QyLXlN.jpg	t
54	Dazelle Yvette	\N	https://image.tmdb.org/t/p/w500/cRXbG5ceorwjh87yvMFQVT6TTs2.jpg	t
55	Adam Bucci	\N	https://image.tmdb.org/t/p/w500/w7uIugwzZtFmdwvceKg3LcN39At.jpg	t
56	Mark Justice	\N	https://image.tmdb.org/t/p/w500/8QEynj64MxUBYWQpsyNOpwcH7At.jpg	t
57	Jed Rowen	\N	https://image.tmdb.org/t/p/w500/gQbls0bZuOqT9DskZhleqHlkx9s.jpg	t
58	Ben Kaplan	\N	\N	t
59	Bishop Stevens	\N	https://image.tmdb.org/t/p/w500/e7sPcKUdzeakGHllbNRKXFpWpmO.jpg	t
60	Alex Dundas	\N	\N	t
61	Jeremy Piven	\N	https://image.tmdb.org/t/p/w500/pBD1jcAZiDrHWcFpJtBtqLRD4gR.jpg	t
62	Tricia Helfer	\N	https://image.tmdb.org/t/p/w500/cXwa8yT2Qv7EmCI8yjs5ldvMHmw.jpg	t
63	Ryan Kwanten	\N	https://image.tmdb.org/t/p/w500/vvbEabUWIeaHMBA2wrUChiLTjch.jpg	t
64	Nick Wechsler	\N	https://image.tmdb.org/t/p/w500/vUkfhJc2x3jrO9WY7D1405g4amE.jpg	t
65	Anthony Ingruber	\N	https://image.tmdb.org/t/p/w500/fUTCd1jGGQHn912czglHg28v4gR.jpg	t
66	Aaron Glenane	\N	https://image.tmdb.org/t/p/w500/4JjTJIgJ0GDTo4egADEn3nW79Zk.jpg	t
67	Carlos Sanson Jr.	\N	https://image.tmdb.org/t/p/w500/cta9cAYDh46lfDdt2sAtWD7GBmH.jpg	t
68	Ana Thu Nguyen	\N	https://image.tmdb.org/t/p/w500/cwGOgAoVgtEUVDeqW0OoPpcAYvU.jpg	t
69	Adolphus Waylee	\N	https://image.tmdb.org/t/p/w500/14jyy1SCiM2xQnG017gFCgyIaEI.jpg	t
70	Marcus Johnson	\N	https://image.tmdb.org/t/p/w500/fqAZqGw6fm6R3uBRSyCi0OvVWWO.jpg	t
71	Keira Knightley	\N	https://image.tmdb.org/t/p/w500/bRC1B2VwV0wK3ElciFAK6QZf2wD.jpg	t
72	Guy Pearce	\N	https://image.tmdb.org/t/p/w500/vTqk6Nh3WgqPubkS23eOlMAwmwa.jpg	t
73	David Ajala	\N	https://image.tmdb.org/t/p/w500/aug1B4J5UjL1Z7iHQRF7WXdIZLk.jpg	t
74	Gitte Witt	\N	https://image.tmdb.org/t/p/w500/1jDqBQHcCeWXNrjurxeOcqKVLVH.jpg	t
75	Art Malik	\N	https://image.tmdb.org/t/p/w500/4jHV8loqE7u6Sh8RItyHbrY7u6q.jpg	t
76	Gugu Mbatha-Raw	\N	https://image.tmdb.org/t/p/w500/sHAnv0kw5JHzWBOP7gAezwqgl8J.jpg	t
77	Hannah Waddingham	\N	https://image.tmdb.org/t/p/w500/eHAICyhvjiRZCgzKyJCk9hWnnjr.jpg	t
78	David Morrissey	\N	https://image.tmdb.org/t/p/w500/gj7ENB9pBobXA3wMfw6uKcWr2GM.jpg	t
79	Daniel Ings	\N	https://image.tmdb.org/t/p/w500/cvufKTYL4AUyNBeLiQKxe2lqZAA.jpg	t
80	Tom Cruise	\N	https://image.tmdb.org/t/p/w500/3mShHjSQR7NXOVbdTu5rT2Qd0MN.jpg	t
81	Hayley Atwell	\N	https://image.tmdb.org/t/p/w500/yaJv2qrKHBw5Txo5ds0wOb03PXi.jpg	t
82	Ving Rhames	\N	https://image.tmdb.org/t/p/w500/4gpLVNKPZlVucc4fT2fSZ7DksTK.jpg	t
83	Simon Pegg	\N	https://image.tmdb.org/t/p/w500/jw8bEEoTOithyNf0qxu4Zt1yaKp.jpg	t
84	Esai Morales	\N	https://image.tmdb.org/t/p/w500/cNYciYzUzxraGlw0BPql1QePi5H.jpg	t
85	Pom Klementieff	\N	https://image.tmdb.org/t/p/w500/hfUKAI2kXTMMWjno0i4sLPJud5N.jpg	t
86	Henry Czerny	\N	https://image.tmdb.org/t/p/w500/zOWZzRmliKf9032IOOq0a3jXhVv.jpg	t
87	Holt McCallany	\N	https://image.tmdb.org/t/p/w500/nHZgHsBc8P69LFTGsDSrZYt2PmS.jpg	t
88	Janet McTeer	\N	https://image.tmdb.org/t/p/w500/kl8cHLOQbwLrBfMWtAwtP4hUXFk.jpg	t
89	Nick Offerman	\N	https://image.tmdb.org/t/p/w500/f6z3mPVtaF40ewfdmZydprAjmYd.jpg	t
90	Liam Neeson	\N	https://image.tmdb.org/t/p/w500/sRLev3wJioBgun3ZoeAUFpkLy0D.jpg	t
91	Pamela Anderson	\N	https://image.tmdb.org/t/p/w500/sk15ch2IQ6k6vWu07Jr77yw4oj5.jpg	t
92	Paul Walter Hauser	\N	https://image.tmdb.org/t/p/w500/nmBdzJpfHMRHsT3VrjyXAxMFLZA.jpg	t
93	Danny Huston	\N	https://image.tmdb.org/t/p/w500/7Wdh73SltnllH4KVd64PvqKQ5NJ.jpg	t
94	CCH Pounder	\N	https://image.tmdb.org/t/p/w500/vJ5Swy2WDBC46zJrbJmwsGgTPJ2.jpg	t
95	Kevin Durand	\N	https://image.tmdb.org/t/p/w500/Aajju2i04laxJl02FM5cSTRCKvq.jpg	t
96	Liza Koshy	\N	https://image.tmdb.org/t/p/w500/pPu4TYkuNGmPEykWzFwCz55pAWB.jpg	t
97	Eddie Yu	\N	https://image.tmdb.org/t/p/w500/jWALEHujE35CHyB31DqFuEv4nMh.jpg	t
98	Michael Beasley	\N	https://image.tmdb.org/t/p/w500/w1sqMMzBG4M5K9b4Wrhejh0LS5a.jpg	t
99	Moses Jones	\N	https://image.tmdb.org/t/p/w500/4Dd8AaxTcXSSmZJEoUOO3rxiru2.jpg	t
100	Dhruva Sarja	\N	https://image.tmdb.org/t/p/w500/eGRgr3Ek4iCGpzInpjV5DKbEjEH.jpg	t
101	Vaibhavi Shandilya	\N	https://image.tmdb.org/t/p/w500/jVWMGmmOhRfwW4dvCBrkIFoKp6G.jpg	t
102	Anveshi Jain	\N	https://image.tmdb.org/t/p/w500/7l2h5QyFc0dloUTlsIOPoSHz1ZM.jpg	t
103	Giorgia Andriani	\N	https://image.tmdb.org/t/p/w500/2NF0vzA8hUDTUu09agvhnboJnys.jpg	t
104	Chikkanna	\N	https://image.tmdb.org/t/p/w500/v4QpNWbElJtYrS9yUVXLgpYT7iE.jpg	t
105	Malavika Avinash	\N	https://image.tmdb.org/t/p/w500/1D3J1HIRP4gm0bYzrOdF2AmreV5.jpg	t
106	Achyuth Kumar	\N	https://image.tmdb.org/t/p/w500/zO1MoCgaz0RxILjga8VYXguROMp.jpg	t
107	Nikitin Dheer	\N	https://image.tmdb.org/t/p/w500/gAHNWVtStTGsqf2uxCegxvn6ILe.jpg	t
108	Nawab Shah	\N	https://image.tmdb.org/t/p/w500/mx168p9eqjrGyaAc3TM6viLIG4L.jpg	t
109	Rohit Pathak	\N	https://image.tmdb.org/t/p/w500/j2tcAbQxjtErT6gtnWgmh2VQdUt.jpg	t
110	Colin Farrell	\N	https://image.tmdb.org/t/p/w500/lZ3dU4uFEV4BccAEvjJUBIY2OaB.jpg	t
111	Margot Robbie	\N	https://image.tmdb.org/t/p/w500/euDPyqLnuwaWMHajcU3oZ9uZezR.jpg	t
112	Jennifer Grant	\N	https://image.tmdb.org/t/p/w500/yC5EggWQNsP2QzG4goe0Izj7YIo.jpg	t
113	Hamish Linklater	\N	https://image.tmdb.org/t/p/w500/hByas1g3htnZFWIbCBdbxC7vGeS.jpg	t
114	Phoebe Waller-Bridge	\N	https://image.tmdb.org/t/p/w500/ppRIfUYcl0RWlxp5gSmdzIFFLAS.jpg	t
115	Kevin Kline	\N	https://image.tmdb.org/t/p/w500/ArH5dACd9AmWNNMnI6bGEkiFYIM.jpg	t
116	Jodie Turner-Smith	\N	https://image.tmdb.org/t/p/w500/801hOIFSiYfakVDkX0U3vEAHAMt.jpg	t
117	Lily Rabe	\N	https://image.tmdb.org/t/p/w500/u54mVF2vcjymvLhyImxzInq4Y3o.jpg	t
118	Billy Magnussen	\N	https://image.tmdb.org/t/p/w500/ugyx7Wn2uAWsNlR5eX4yWFsGV2Y.jpg	t
119	Chloe East	\N	https://image.tmdb.org/t/p/w500/yAJZ883uLsfY4yHncUC9rTvKVQ9.jpg	t
120	Cooper Hoffman	\N	https://image.tmdb.org/t/p/w500/8Y0AfdcpgzL4SHpKjspkDFBd6zN.jpg	t
121	David Jonsson	\N	https://image.tmdb.org/t/p/w500/2ZZNGZw57KKMrVIr27g7W16G0jV.jpg	t
122	Garrett Wareing	\N	https://image.tmdb.org/t/p/w500/fGitxzQzJWgWqEYiDECJIB8pavW.jpg	t
123	Tut Nyuot	\N	https://image.tmdb.org/t/p/w500/nnQCY629iCcf5veJ7pJVG6onMgC.jpg	t
124	Charlie Plummer	\N	https://image.tmdb.org/t/p/w500/u2ig0kkgxq36BMbFQ4DEWfu5G3A.jpg	t
125	Ben Wang	\N	https://image.tmdb.org/t/p/w500/5A6JgNR9nlFVjuzJ1oOXyj2hfJo.jpg	t
126	Roman Griffin Davis	\N	https://image.tmdb.org/t/p/w500/jEox6Bq4TlINrnp5EUjqSlDK3eP.jpg	t
127	Jordan Gonzalez	\N	https://image.tmdb.org/t/p/w500/moEGDOzrAkWs9W5C25RlxirroTq.jpg	t
128	Joshua Odjick	\N	https://image.tmdb.org/t/p/w500/7z9RXNGcxTaZc1jZlk6uszvktkX.jpg	t
129	Josh Hamilton	\N	https://image.tmdb.org/t/p/w500/7nuAUPd7E8iOE5lhUcNpogS2akP.jpg	t
130	Madelaine Petsch	\N	https://image.tmdb.org/t/p/w500/mfZo30YgMx7vhAUajM8OG6I6VM8.jpg	t
131	Jacob Scipio	\N	https://image.tmdb.org/t/p/w500/gcZSJy9LZ8DUDP480Q2K1OhL1Ct.jpg	t
132	Katy O'Brian	\N	https://image.tmdb.org/t/p/w500/lEz7WmJPrBGSsIkEiAA10t5nDDM.jpg	t
133	Madison Bailey	\N	https://image.tmdb.org/t/p/w500/3jBI3nS68RIlCCnwEpnaSEz6e3n.jpg	t
134	Matteo Lane	\N	https://image.tmdb.org/t/p/w500/hTAhOWqdP5jBDOKQhRi6Yf7A1JX.jpg	t
135	Jim Gaffigan	\N	https://image.tmdb.org/t/p/w500/dhguhHxIrb26jvPznBt8y25Fb2U.jpg	t
136	Naomi J. Ogawa	\N	https://image.tmdb.org/t/p/w500/iTPXpPNtJMv32Xnh2E4OUnBGoAE.jpg	t
137	Inanna Sarkis	\N	https://image.tmdb.org/t/p/w500/up8etOETeYTwuGFr9yL0gYf5ZKW.jpg	t
138	Kerim Hassan	\N	https://image.tmdb.org/t/p/w500/b1LNPysqfX5XmCkF8En67RR3aPI.jpg	t
139	Rob Rausch	\N	https://image.tmdb.org/t/p/w500/x1dpaIiTvaZJ6R3VCkwQoCczAm1.jpg	t
140	Cillian O'Sullivan	\N	https://image.tmdb.org/t/p/w500/8uazSJXtTzvtCDYNeLouHQGhyIc.jpg	t
141	Gary Dourdan	\N	https://image.tmdb.org/t/p/w500/xsxjlW98I8ml4FCHV040b3XaBOi.jpg	t
142	Robert Knepper	\N	https://image.tmdb.org/t/p/w500/lRncjvgCIm1muIkK94zJSH2i3d6.jpg	t
143	Soraya Azzabi	\N	https://image.tmdb.org/t/p/w500/5IVdou5twW5S9SFfsU8JpOgHK0T.jpg	t
144	Eric Roberts	\N	https://image.tmdb.org/t/p/w500/NiWg1TaUcal7xn1ZQeyA2dLd5F.jpg	t
145	Irma Lake	\N	https://image.tmdb.org/t/p/w500/77zQmazdv5b2GWVmvzR5a2kzvxL.jpg	t
146	Luka Peroš	\N	https://image.tmdb.org/t/p/w500/lfh7959EpR9gAvrjObNGXaUg2qF.jpg	t
147	Kacey Mottet Klein	\N	https://image.tmdb.org/t/p/w500/ggOHPk5DHQzf9t4Qm4sohmtcNVf.jpg	t
148	Mourad Zaoui	\N	https://image.tmdb.org/t/p/w500/4IM7T4JVW1VWuvvJFZGuLt9DexG.jpg	t
149	Julian Mileta	\N	\N	t
150	Simon Haines	\N	https://image.tmdb.org/t/p/w500/xQPp2rHJ9pKHkCslBI6Hszv6HaQ.jpg	t
151	Tim Faraday	\N	https://image.tmdb.org/t/p/w500/rsvGQ50FcCJg2yfcZV3mTbgXoYL.jpg	t
152	Celine Arden	\N	https://image.tmdb.org/t/p/w500/y92LgwfSljAKyx2uZ35sIPpDXfX.jpg	t
153	Tara Hoyos-Martinez	\N	https://image.tmdb.org/t/p/w500/1UXw4dRVnNaqshMBUipFKDSQIQt.jpg	t
154	Fredi 'Kruga' Nwaka	\N	https://image.tmdb.org/t/p/w500/41ZIIraCX5DxEeSshTDjFLorSu.jpg	t
155	Ray Whelan	\N	https://image.tmdb.org/t/p/w500/isPM6LslVwFVnDvE8esxAqNJWJR.jpg	t
156	Bradley Turner	\N	https://image.tmdb.org/t/p/w500/uNGwedKHlaEpF085amWVO9xuOLZ.jpg	t
157	Shantelle Rochester	\N	\N	t
158	Jon Wennington	\N	https://image.tmdb.org/t/p/w500/byRz4RqpS6bcedpTjUyN8kgl33R.jpg	t
159	Jim Belushi	\N	https://image.tmdb.org/t/p/w500/wIvFYH110ER7ukwR0qryQJJDQYH.jpg	t
160	Martin Kove	\N	https://image.tmdb.org/t/p/w500/cuRi6YRaCrXOFU8cmqf5uTk0sUV.jpg	t
161	Eric Johnson	\N	https://image.tmdb.org/t/p/w500/oSwKvCo9duqcOfUAYPLdNHyXnna.jpg	t
162	Ennis Esmer	\N	https://image.tmdb.org/t/p/w500/1hMc79NC8bqJ5OWxLU2d2dlnrBr.jpg	t
163	Chuck Liddell	\N	https://image.tmdb.org/t/p/w500/b25J1y0cgHcemktz3bgtRlOUZMp.jpg	t
164	Ken Kilpatrick	\N	https://image.tmdb.org/t/p/w500/5cfh5ByLYRcEw2dyA5Ap9XpKXNf.jpg	t
165	Finn McCager Higgins	\N	https://image.tmdb.org/t/p/w500/nWvzmUc3xkh6dJTPgmkHc7OHJk7.jpg	t
166	Christina Ochoa	\N	https://image.tmdb.org/t/p/w500/nFMeBHHTGhrB34qeZG9DUTd08m7.jpg	t
167	Michael Bisping	\N	https://image.tmdb.org/t/p/w500/stYzWc8WJHe2Te8ZzbSSnthvdtP.jpg	t
168	Nicolas Grimes	\N	https://image.tmdb.org/t/p/w500/PmNf8Dx695QzaUHMFieQzeB3DT.jpg	t
169	Jessica Clement	\N	https://image.tmdb.org/t/p/w500/nqD72rIXeRhq1k94GHBVfmRX4L5.jpg	t
170	Ryan Robbins	\N	https://image.tmdb.org/t/p/w500/kZrq5a760JU1kHuxQ7Q8YCgsOr6.jpg	t
171	Summer H. Howell	\N	https://image.tmdb.org/t/p/w500/oQkO781FBdjG0qrc019SYAqzLOa.jpg	t
172	Keegan Connor Tracy	\N	https://image.tmdb.org/t/p/w500/lP5rlqK8YIqobtFghURPbNdN5zw.jpg	t
173	Matty Finochio	\N	https://image.tmdb.org/t/p/w500/7I2iawz7YHZDbH15V4Om0Tdep9c.jpg	t
174	Max Christensen	\N	\N	t
175	Ben Cockell	\N	https://image.tmdb.org/t/p/w500/hNjQ2hYN9dKdYSAq3ffXXICIR28.jpg	t
176	David Feehan	\N	https://image.tmdb.org/t/p/w500/bHVHoeO6XjgFdw99wgHWIWPtXGd.jpg	t
177	Bryn Samuel	\N	https://image.tmdb.org/t/p/w500/53ccjjj9eRVp6f81mBRKRncT6tV.jpg	t
178	Savannah Miller	\N	https://image.tmdb.org/t/p/w500/8jYBL6tuZY0d90IPeOJCIypuV94.jpg	t
179	Daniel Radcliffe	\N	https://image.tmdb.org/t/p/w500/iPg0J9UzAlPj1fLEJNllpW9IhGe.jpg	t
180	Rupert Grint	\N	https://image.tmdb.org/t/p/w500/q2KZZ0ltTEl7Sf8volNFV1JDEP4.jpg	t
181	Emma Watson	\N	https://image.tmdb.org/t/p/w500/A14lLCZYDhfYdBa0fFRpwMDiwRN.jpg	t
182	Richard Harris	\N	https://image.tmdb.org/t/p/w500/lCvcVMuxrg1f5A8OMqY9AqkkcZR.jpg	t
183	Tom Felton	\N	https://image.tmdb.org/t/p/w500/4fO0PjiBbNFEnYLPe55xUUP7Wgf.jpg	t
184	Alan Rickman	\N	https://image.tmdb.org/t/p/w500/nKl8ZRYjBJya7aj7phJUyrtSll6.jpg	t
185	Robbie Coltrane	\N	https://image.tmdb.org/t/p/w500/jOHs3xvlwRiiG2CLtso5zzmGCXg.jpg	t
186	Maggie Smith	\N	https://image.tmdb.org/t/p/w500/tcGV3eHqEa6clTFjeBDec3qb9ak.jpg	t
187	Richard Griffiths	\N	https://image.tmdb.org/t/p/w500/4H4uQfMzvgs11RCLaoSMQsyElw8.jpg	t
188	Ian Hart	\N	https://image.tmdb.org/t/p/w500/xMC8aPDwhEZcjRHEFcgytSr3BzM.jpg	t
189	Olga Solo	\N	\N	t
190	Abigail Huxley	\N	\N	t
191	Jimmy Roberts	\N	\N	t
192	Robson Medler	\N	\N	t
193	Julian Amos	\N	\N	t
194	Flex Singh	\N	\N	t
195	Craig Rees	\N	\N	t
196	Scott Adkins	\N	https://image.tmdb.org/t/p/w500/9NRr2a1riIn5CWn5McZLJlk4vxR.jpg	t
197	Peter Shinkoda	\N	https://image.tmdb.org/t/p/w500/lCQl28poQr4bLwqZjhryGkV73jO.jpg	t
198	Michael Copon	\N	https://image.tmdb.org/t/p/w500/i3k6kmAA3LLlPFEzkOs5hRIfwg6.jpg	t
199	Donald Cerrone	\N	https://image.tmdb.org/t/p/w500/yHRgWTQuKr5tAMeR3qTtsOQU0Jb.jpg	t
200	Michael Rene Walton	\N	https://image.tmdb.org/t/p/w500/t7yY3Cyei6hH5CVI7y2TtG1oJVX.jpg	t
201	Gary Cairns	\N	https://image.tmdb.org/t/p/w500/2J26NSBfmtborzz32ZqRpCkmr15.jpg	t
202	Shane Kosugi	\N	https://image.tmdb.org/t/p/w500/5ePVKMbW8aaI6oBtFoClJOZGpMl.jpg	t
203	三元雅芸	\N	https://image.tmdb.org/t/p/w500/koSSsi2LU6gJm3S6o0OgJaxJExx.jpg	t
204	Gabbi Garcia	\N	https://image.tmdb.org/t/p/w500/ymGQhMZaNoCyXY4rNb2vDl4mKNT.jpg	t
205	Sol Eugenio	\N	https://image.tmdb.org/t/p/w500/gb7PMq9wZPM3WJJup5fWAkEOnFC.jpg	t
206	David Corenswet	\N	https://image.tmdb.org/t/p/w500/qB0hBMu4wU1nPrqtdUQP3sQeN5t.jpg	t
207	Rachel Brosnahan	\N	https://image.tmdb.org/t/p/w500/1f9NK43gWrXN2uMmYMlennB7jCC.jpg	t
208	Nicholas Hoult	\N	https://image.tmdb.org/t/p/w500/laeAYQVBV9U3DkJ1B4Cn1XhpT8P.jpg	t
209	Edi Gathegi	\N	https://image.tmdb.org/t/p/w500/dt8yMyycDlzxkjhmuuJJ4tXDbp4.jpg	t
210	Nathan Fillion	\N	https://image.tmdb.org/t/p/w500/q31mXXgnN5PsuIjEqaaAPvBDvHc.jpg	t
211	Isabela Merced	\N	https://image.tmdb.org/t/p/w500/5R1oi4PH7GXWETJS8SbSo673gJt.jpg	t
212	María Gabriela de Faría	\N	https://image.tmdb.org/t/p/w500/joKXt8ai99udROK7VEFCDsBEm3Y.jpg	t
213	Skyler Gisondo	\N	https://image.tmdb.org/t/p/w500/vyalCuJUUP7Ht1vMWZQzhOrscXV.jpg	t
214	Alan Tudyk	\N	https://image.tmdb.org/t/p/w500/jUuUbPuMGonFT5E2pcs4alfqaCN.jpg	t
215	Grace Chan	\N	https://image.tmdb.org/t/p/w500/vs6aMdkXkR8A0sOCXK6AGIrVeHb.jpg	t
216	Kate Beckinsale	\N	https://image.tmdb.org/t/p/w500/nUZuC2chd5PVw2tLxePZ6uaLbhx.jpg	t
217	Scott Eastwood	\N	https://image.tmdb.org/t/p/w500/hBqXeKe2Z7VnAYe7tLTzIvr8po4.jpg	t
218	Arvin Kananian	\N	https://image.tmdb.org/t/p/w500/hcjxh1ouEnWgDGiiW7ihcEXE8ba.jpg	t
219	Matt Craven	\N	https://image.tmdb.org/t/p/w500/tWF8B3Dj7zvKRmkTplp7ice6Wo9.jpg	t
220	Ana Golja	\N	https://image.tmdb.org/t/p/w500/nAbK9EeAXXzlbABwBeVTBzEQPPE.jpg	t
221	Talia Asseraf	\N	https://image.tmdb.org/t/p/w500/qO9bluzeNVtHqVeF5x8vc7QxfPP.jpg	t
222	Robert Farrior	\N	https://image.tmdb.org/t/p/w500/e6oe7eswcUTYfeq2otaIgAtfzor.jpg	t
223	Alejandra Howard	\N	https://image.tmdb.org/t/p/w500/uQyvQlzqsBCe7t0SuLF6zYtRtCd.jpg	t
224	Jordan Duvigneau	\N	https://image.tmdb.org/t/p/w500/radXw5TVvfcKLRptZTKewHXshdz.jpg	t
225	Nowar Yusuf	\N	\N	t
226	Natsuki Hanae	\N	https://image.tmdb.org/t/p/w500/alTb0DlcPIbcwM08WSmxFai58sd.jpg	t
227	Hiro Shimono	\N	https://image.tmdb.org/t/p/w500/yrSDcgFefHtWkFmLnTrcw2t0MV.jpg	t
228	Takahiro Sakurai	\N	https://image.tmdb.org/t/p/w500/8s8owcKmpRAuhzEGjSdRpztthUg.jpg	t
229	Akira Ishida	\N	https://image.tmdb.org/t/p/w500/jnW2Gn2NlR2uwOCeyOuzypnTmkH.jpg	t
230	Yoshitsugu Matsuoka	\N	https://image.tmdb.org/t/p/w500/ugDwdWEXnmv43jcbnfAi4XwiQ8C.jpg	t
231	Toshihiko Seki	\N	https://image.tmdb.org/t/p/w500/7jUPvx4hxWZWZJgyiCwd8KxWuvI.jpg	t
232	Reina Ueda	\N	https://image.tmdb.org/t/p/w500/hlzrvBzeSYejeaTSZDvEWE44Qjj.jpg	t
233	Nobuhiko Okamoto	\N	https://image.tmdb.org/t/p/w500/7s1K2yQVF5iIWILaOfG7QrMZkXA.jpg	t
234	Katsuyuki Konishi	\N	https://image.tmdb.org/t/p/w500/nYM5cH6U7cp4x9dIzW0enmEKmeV.jpg	t
235	Akari Kito	\N	https://image.tmdb.org/t/p/w500/AoRQOZRC0yINB0WeKnM569rV1wF.jpg	t
236	Unni Mukundan	\N	https://image.tmdb.org/t/p/w500/7Pn9GASysyTG6ZnPhsuRq4ESArC.jpg	t
237	Siddique	\N	https://image.tmdb.org/t/p/w500/tMv7QsmYlXAXtP75D3eIxXHpgTv.jpg	t
238	Ishan Shoukath	\N	https://image.tmdb.org/t/p/w500/xJicLr2st7kQT7fzPC2xAZnzGUx.jpg	t
239	Jagadish	\N	https://image.tmdb.org/t/p/w500/ml3XX5bWPIdHUPvqhW2MYYZ8H7Y.jpg	t
240	Abhimanyu Thilakan	\N	https://image.tmdb.org/t/p/w500/6X1X5aJi9JkF9nhNuy1bEY8RD05.jpg	t
241	Kabir Duhan Singh	\N	https://image.tmdb.org/t/p/w500/lAVAxFARP63oTHMYWpwHrWsXPWa.jpg	t
242	Anson Paul	\N	https://image.tmdb.org/t/p/w500/tuuQTQFh4qMY7EOP9rgVlz0Y57y.jpg	t
243	Ajith Koshy	\N	https://image.tmdb.org/t/p/w500/qR765VN5mOHfosx23NBMTxWuw6h.jpg	t
244	Durva Thaker	\N	https://image.tmdb.org/t/p/w500/2TR9HIa4CwMIHPhzN4YCOqSeT4V.jpg	t
245	Yukti Thareja	\N	https://image.tmdb.org/t/p/w500/2hESBWJy0cgvY36mMf9i4FK26wW.jpg	t
246	설경구	\N	https://image.tmdb.org/t/p/w500/teD7AMzfNl4qhQO2b6MAWwLtPVn.jpg	t
247	홍경	\N	https://image.tmdb.org/t/p/w500/3jvC6tDT1QZg6uSkKzhbfe90Si4.jpg	t
248	류승범	\N	https://image.tmdb.org/t/p/w500/bf8EtXv3QUBehLdCLtn7FB50ahD.jpg	t
249	山田孝之	\N	https://image.tmdb.org/t/p/w500/jnz1GRkUbTjSbWSM4a6HfgyqbVp.jpg	t
250	椎名桔平	\N	https://image.tmdb.org/t/p/w500/l4rKG2zW2xpe6XoyrCfJQHK7h6K.jpg	t
251	김성오	\N	https://image.tmdb.org/t/p/w500/bvwsF0l3f2qs19GCUyHtAqGDL5P.jpg	t
252	Show Kasamatsu	\N	https://image.tmdb.org/t/p/w500/tDASDMyIZQFooUQimqrVCd4rN5I.jpg	t
253	山本奈衣瑠	\N	https://image.tmdb.org/t/p/w500/z9OhXhlGLbUGlDDXPXa919ZPePw.jpg	t
254	전도연	\N	https://image.tmdb.org/t/p/w500/ev2tT7ZbReE06rZy7SX0Mv8evZ7.jpg	t
255	박해수	\N	https://image.tmdb.org/t/p/w500/hFt7Cj8sx1VYIwm18lYmq5kS7Pw.jpg	t
256	Leonardo DiCaprio	\N	https://image.tmdb.org/t/p/w500/wo2hJpn04vbtmh0B9utCFdsQhxM.jpg	t
257	Sean Penn	\N	https://image.tmdb.org/t/p/w500/9glqNTVpFpdN1nFklKaHPUyCwR6.jpg	t
258	Chase Infiniti	\N	https://image.tmdb.org/t/p/w500/2goENGgg9OCz7qjMmm0HNxV9Kjj.jpg	t
259	Benicio del Toro	\N	https://image.tmdb.org/t/p/w500/cVh4UgCMu6aAkZ2BqymTLV86FzZ.jpg	t
260	Regina Hall	\N	https://image.tmdb.org/t/p/w500/jiFZ4xNrvUUZLBHnJu71CvdN4kj.jpg	t
261	Teyana Taylor	\N	https://image.tmdb.org/t/p/w500/wVHbluUvjKl0NucSeuAhAJAr2oc.jpg	t
262	Wood Harris	\N	https://image.tmdb.org/t/p/w500/v3puIl2KncqUd6amDyD1Y0crzkF.jpg	t
263	Tony Goldwyn	\N	https://image.tmdb.org/t/p/w500/A3hXimbzDtFxQ1PXNo8gG7RZeN4.jpg	t
264	D.W. Moffett	\N	https://image.tmdb.org/t/p/w500/7lcIxTqarAgkdLiNlc7Ad57vcP1.jpg	t
265	Paul Grimstad	\N	https://image.tmdb.org/t/p/w500/maPuaFdSLnz3br46Ar2GptK4okK.jpg	t
266	Gabriela Andrada	\N	https://image.tmdb.org/t/p/w500/h8cAdDqbDK2ayGIuxQQdNCzyCsb.jpg	t
267	Mario Ermito	\N	https://image.tmdb.org/t/p/w500/9HlLY9yECyYwCIaMxdaJQ5RH4FL.jpg	t
268	Celia Freijeiro	\N	https://image.tmdb.org/t/p/w500/l32Ys5nQptZLJFRtlVJXKbK704U.jpg	t
269	David Solans	\N	https://image.tmdb.org/t/p/w500/j0aKkDMqevgdXGZB8ciu9KMqE0K.jpg	t
270	Alba Ribas	\N	https://image.tmdb.org/t/p/w500/zfASs4kqXPL7CmRWmqjJovwjfsu.jpg	t
271	Joel Bosqued	\N	https://image.tmdb.org/t/p/w500/pTCPqrbf9dtHUf4be3TANv6hRSL.jpg	t
272	Alicia Bercan	\N	\N	t
273	Anna Karinvinge	\N	\N	t
274	Fernando Oyagüez	\N	\N	t
275	Paco Tous	\N	https://image.tmdb.org/t/p/w500/uDGKTKKv9v2JRutCZJjKwpJVKOs.jpg	t
276	Fabrizio Sansone	\N	https://image.tmdb.org/t/p/w500/cmu6Xy61ZJhHHeThjL65GRfOt31.jpg	t
277	Federico Sansone	\N	https://image.tmdb.org/t/p/w500/x6z7QX5iHz1d3JPslELzVHbHbPD.jpg	t
278	Donatella Finocchiaro	\N	https://image.tmdb.org/t/p/w500/zAcHyOB6O3vN0hKs8PwxOyw2Ngd.jpg	t
279	Paola Minaccioni	\N	https://image.tmdb.org/t/p/w500/n7RsnZJ2k9eCRZzK0OgnfA4eUr4.jpg	t
280	Ester Pantano	\N	https://image.tmdb.org/t/p/w500/ps6YI48klrB4poMFmUmB9N7qLnl.jpg	t
281	Paride Benassai	\N	https://image.tmdb.org/t/p/w500/l2kgp33bf2EwPsPqRIIKSRRMi0u.jpg	t
282	Domenico Centamore	\N	https://image.tmdb.org/t/p/w500/mulhhtWNtlkj8qEEkwdCDEYD8Vi.jpg	t
283	Maurizio Bologna	\N	https://image.tmdb.org/t/p/w500/lwwUV97vHcET0eQHyYr8QgBu3Bu.jpg	t
284	Gabriele Cicirello	\N	https://image.tmdb.org/t/p/w500/2wWyWDePkXNqbeVfk5DbGAuIh4d.jpg	t
285	Sergio Vespertino	\N	https://image.tmdb.org/t/p/w500/f7vE4buvkZnmUL4nmsueeaEBmtx.jpg	t
286	Indy	\N	https://image.tmdb.org/t/p/w500/pLuhIFBlhkEjfl8AZKroGbs5AdT.jpg	t
287	Shane Jensen	\N	https://image.tmdb.org/t/p/w500/8BNJL3MwvYEUTg187SmhQACVq3Z.jpg	t
288	Larry Fessenden	\N	https://image.tmdb.org/t/p/w500/imQGskBT7IjqHLVJDQFLR1h1UPH.jpg	t
289	Arielle Friedman	\N	\N	t
290	Stuart Rudin	\N	https://image.tmdb.org/t/p/w500/2jhEJ2zLnRL0iuG5i3fYw4FObgl.jpg	t
291	Anya Krawcheck	\N	https://image.tmdb.org/t/p/w500/ffP9mfsovkmgqnsUYKwbVejtG5q.jpg	t
292	Max	\N	\N	t
293	Hunter Goetz	\N	\N	t
294	Noah Manzoor	\N	https://image.tmdb.org/t/p/w500/72X2vD3v3tjAvmtyjjglbTnMuxS.jpg	t
295	Laila Lockhart Kraner	\N	https://image.tmdb.org/t/p/w500/3hGsO4pNH9UfuPvmo2nHbWqCUVl.jpg	t
296	Gloria Estefan	\N	https://image.tmdb.org/t/p/w500/alS75LDLaXopWcWxUVZ2Q70Mlm5.jpg	t
297	Kristen Wiig	\N	https://image.tmdb.org/t/p/w500/N517EQh7j4mNl3BStMmjMN6hId.jpg	t
298	Logan Bailey	\N	\N	t
299	Eduardo Franco	\N	https://image.tmdb.org/t/p/w500/mbGv6DB2JR4DbmoTwfvy5wKToRo.jpg	t
300	Juliet Donenfeld	\N	https://image.tmdb.org/t/p/w500/sogJreLmv2bjJhouyRWuYQpTCys.jpg	t
301	Donovan Patton	\N	https://image.tmdb.org/t/p/w500/nxhYW1Q3I4EjsKymgZnqTInf5gi.jpg	t
302	Sainty Nelsen	\N	https://image.tmdb.org/t/p/w500/7XklsT4fkiBOOIUjUb09OZUNjJT.jpg	t
303	Maggie Lowe	\N	https://image.tmdb.org/t/p/w500/pptRjIdZVdmy4CRn3fkESdBqULk.jpg	t
304	Carla Tassara	\N	https://image.tmdb.org/t/p/w500/j9fVEGQp65vXGKhlXQyyfRMzXWO.jpg	t
305	Nick Biskupek	\N	https://image.tmdb.org/t/p/w500/gKWK5huSwlZwqmUdhGGkHavubGZ.jpg	t
306	Michael Swatton	\N	https://image.tmdb.org/t/p/w500/28SXx8CtFWNCeIjMIcgjiPtnjqK.jpg	t
307	Sam Huntsman	\N	\N	t
308	Hollie Kennedy	\N	\N	t
309	Corgand Janeway-Svendsen	\N	\N	t
310	Miguel Cortez	\N	\N	t
311	Mark Templin	\N	https://image.tmdb.org/t/p/w500/3ASlzNpwn19eOInQxl0DhyqwdZJ.jpg	t
312	Dave Coleman	\N	\N	t
313	Dan Molson	\N	\N	t
314	Alyssa Ingram	\N	\N	t
315	Olivia Colman	\N	https://image.tmdb.org/t/p/w500/lawJUdbLb1YW0niaYjiVGR9IBG8.jpg	t
316	Benedict Cumberbatch	\N	https://image.tmdb.org/t/p/w500/wz3MRiMmoz6b5X3oSzMRC9nLxY1.jpg	t
317	Kate McKinnon	\N	https://image.tmdb.org/t/p/w500/2cNetzianFcxPQbyOQnkAIkKUZE.jpg	t
318	Andy Samberg	\N	https://image.tmdb.org/t/p/w500/jMXU5oG3i93SH1yhkpbBGskFiJl.jpg	t
319	Ncuti Gatwa	\N	https://image.tmdb.org/t/p/w500/vLFh9kdB2G06ugwYmRNpxiXhbN0.jpg	t
320	Sunita Mani	\N	https://image.tmdb.org/t/p/w500/xQo4rkMEphSAt8F9D1OyWv0GBLx.jpg	t
321	Zoë Chao	\N	https://image.tmdb.org/t/p/w500/p8KqD4o4F17wQ8nJYky0DHzKYcn.jpg	t
322	Jamie Demetriou	\N	https://image.tmdb.org/t/p/w500/nRhjzDgxQ8PzdUX1MTGhSmWwm8D.jpg	t
323	Delaney Quinn	\N	https://image.tmdb.org/t/p/w500/2CkgPdKVFfgeRCro4Hmvkqo4fB7.jpg	t
324	Hala Finley	\N	https://image.tmdb.org/t/p/w500/9tU0kFjCGNiEe55KAxXkExBVMPC.jpg	t
325	Maia Kealoha	\N	https://image.tmdb.org/t/p/w500/jqsKbBF28V2Oq5tKPR5USkNufwC.jpg	t
326	Sydney Agudong	\N	https://image.tmdb.org/t/p/w500/3K5hJ3meeClHWsPKetqd9qgyveJ.jpg	t
327	Chris Sanders	\N	https://image.tmdb.org/t/p/w500/6CtrIOCxggJ5eIAWeFQqd4Hs9FP.jpg	t
328	Zach Galifianakis	\N	https://image.tmdb.org/t/p/w500/qsDfoUlRnXHUiqZeBPWHzmgmKGX.jpg	t
329	Courtney B. Vance	\N	https://image.tmdb.org/t/p/w500/6ci3wf6oecjz875QRwryOsapW0Y.jpg	t
330	Amy Hill	\N	https://image.tmdb.org/t/p/w500/x5vR2MXZiWGHkppRXlXYj7y7611.jpg	t
331	Tia Carrere	\N	https://image.tmdb.org/t/p/w500/rnHioNQkSmBAMgEBseu9bu6vw9l.jpg	t
332	Kaipo Dudoit	\N	https://image.tmdb.org/t/p/w500/5U20b5I3gTKAK5nN3VeWxlXDu6W.jpg	t
333	Froy Gutierrez	\N	https://image.tmdb.org/t/p/w500/8sCm6Jl8jDUwRBin6k7CIFIm0yg.jpg	t
334	Gabriel Basso	\N	https://image.tmdb.org/t/p/w500/6jHYQf6Y37BEouavp03WWpWpFyR.jpg	t
335	Ema Horvath	\N	https://image.tmdb.org/t/p/w500/4YindT5cKhekpAilc6q0scQeUQx.jpg	t
336	Brooke Lena Johnson	\N	https://image.tmdb.org/t/p/w500/gcidhYtCeH19FdpMjbVgjvBhbtA.jpg	t
337	Richard Brake	\N	https://image.tmdb.org/t/p/w500/JwsiErANShzPSdYsNoiNYdrSg1.jpg	t
338	Pedro Leandro	\N	https://image.tmdb.org/t/p/w500/2mqNYfAKoazh2cWwPmSKLUuqzuV.jpg	t
339	Rachel Shenton	\N	https://image.tmdb.org/t/p/w500/AuFmd6sNQWA5CHYx8cRbVApBaKs.jpg	t
340	Florian Clare	\N	https://image.tmdb.org/t/p/w500/tIc7RUBajP2ALxNQ53osDeLLaDm.jpg	t
341	Janis Ahern	\N	\N	t
342	Horacio Camandulle	\N	https://image.tmdb.org/t/p/w500/yQTJ0wQp6ICATzHbIDG1PmBtTS7.jpg	t
343	Marc Clotet	\N	https://image.tmdb.org/t/p/w500/sbO12BzVBcz6sfyc9eAmT7ZHPgX.jpg	t
344	China Suárez	\N	https://image.tmdb.org/t/p/w500/ygB2MjjM1ceGxU1eCh5lwOvX5dH.jpg	t
345	Rafael Spregelburd	\N	https://image.tmdb.org/t/p/w500/lAFPZatnVqGjB4NRfVFxdk033ZT.jpg	t
346	Sydney Sweeney	\N	https://image.tmdb.org/t/p/w500/lkEC9xM133h2f8wmp8CpyLr3JNq.jpg	t
347	Jude Law	\N	https://image.tmdb.org/t/p/w500/6UadpSbfC39WMChAcdnNunzwDxv.jpg	t
348	Daniel Brühl	\N	https://image.tmdb.org/t/p/w500/3YlmTfiy5qZXkrdKGjaM1uMjGKP.jpg	t
349	Vanessa Kirby	\N	https://image.tmdb.org/t/p/w500/a8a9U00KL2JJkkekzhNnueIGKKF.jpg	t
350	Ana de Armas	\N	https://image.tmdb.org/t/p/w500/5Qne374OM0ewMM7uSN9eq9jNrWq.jpg	t
351	Felix Kammerer	\N	https://image.tmdb.org/t/p/w500/9YfDc3yccNQK4rziqb9S3sSzoOL.jpg	t
352	Toby Wallace	\N	https://image.tmdb.org/t/p/w500/asGIAIa5T7pH4KEgwEXYF52MsWf.jpg	t
353	Jonathan Tittel	\N	https://image.tmdb.org/t/p/w500/6gTiZeZfH9nipkyuQBShouQutxf.jpg	t
354	Ignacio Gasparini	\N	\N	t
355	Richard Roxburgh	\N	https://image.tmdb.org/t/p/w500/de1XpxnOuW4v4fFWFEjmBqmHaRf.jpg	t
356	Bob Odenkirk	\N	https://image.tmdb.org/t/p/w500/rF0Lb6SBhGSTvjRffmlKRSeI3jE.jpg	t
357	Connie Nielsen	\N	https://image.tmdb.org/t/p/w500/lvQypTfeH2Gn2PTbzq6XkT2PLmn.jpg	t
358	John Ortiz	\N	https://image.tmdb.org/t/p/w500/tMDPYhpc9nqIJAK3vtMroEH9qho.jpg	t
359	Colin Hanks	\N	https://image.tmdb.org/t/p/w500/iljyDSiJRcwJL8QXQZ2WTyU1wh5.jpg	t
360	RZA	\N	https://image.tmdb.org/t/p/w500/2PVYCKXb1X3PLawJNoYGLN1x0In.jpg	t
361	Colin Salmon	\N	https://image.tmdb.org/t/p/w500/mLlAU6Zl2MIL5znp5UHdX3sVTN7.jpg	t
362	Christopher Lloyd	\N	https://image.tmdb.org/t/p/w500/nxVjpyb3UrfbPZnEyDNlQVlFAs5.jpg	t
363	Sharon Stone	\N	https://image.tmdb.org/t/p/w500/AqwJtz1uoXVbYBfPq1vT3dLL0ce.jpg	t
364	Daniel Bernhardt	\N	https://image.tmdb.org/t/p/w500/b59qhg5VJOCypx9eMXrXHAjauLd.jpg	t
365	Paisley Cadorath	\N	https://image.tmdb.org/t/p/w500/4fbnxs6x5I2f4lSkegDP021ISTJ.jpg	t
366	Michael Sheffield	\N	https://image.tmdb.org/t/p/w500/746gVMQooBk3oXYME0zP0BTEF6j.jpg	t
367	Kaitlyn Trentham	\N	\N	t
368	Dingani Beza	\N	\N	t
369	Hassen Kacem	\N	\N	t
370	Jessica Ambuehl	\N	\N	t
371	Charles Mckee	\N	\N	t
372	Patrick Loree	\N	\N	t
373	Idris Elba	\N	https://image.tmdb.org/t/p/w500/be1bVF7qGX91a6c5WeRPs5pKXln.jpg	t
374	Rebecca Ferguson	\N	https://image.tmdb.org/t/p/w500/lJloTOheuQSirSLXNA3JHsrMNfH.jpg	t
375	Jared Harris	\N	https://image.tmdb.org/t/p/w500/r9nIq0jPz1oBm4WwtlZhqlsX8p0.jpg	t
376	Tracy Letts	\N	https://image.tmdb.org/t/p/w500/pLNlJhogyILFhWscdXtEMmAb9NN.jpg	t
377	Anthony Ramos	\N	https://image.tmdb.org/t/p/w500/seFm2fKh6reyZaaCg7DmRpodLCw.jpg	t
378	Moses Ingram	\N	https://image.tmdb.org/t/p/w500/u7I5f4Bgz7CI8G7fUOJDbFtd0qf.jpg	t
379	Jonah Hauer-King	\N	https://image.tmdb.org/t/p/w500/yXGsk9UtOV9tprU5ZSuhwdFtaBB.jpg	t
380	Greta Lee	\N	https://image.tmdb.org/t/p/w500/6SydTis4XUcovlwIGskT59JowLX.jpg	t
381	Jason Clarke	\N	https://image.tmdb.org/t/p/w500/jGMOmi7LxpSO6842gJOZKt1gs9N.jpg	t
382	Anna-Maria Sieklucka	\N	https://image.tmdb.org/t/p/w500/6ZqAE1XTtspfshatfNaBVHSu1fx.jpg	t
383	Michele Morrone	\N	https://image.tmdb.org/t/p/w500/u5rcmO7b7ypl5ybJl1wfcIFOih9.jpg	t
384	Simone Susinna	\N	https://image.tmdb.org/t/p/w500/ave6292vdlcySUKee9T3oMUVhvY.jpg	t
385	Magdalena Lamparska	\N	https://image.tmdb.org/t/p/w500/miJQ7KIOIkANmQ957Ujfe4xL5cz.jpg	t
386	Otar Saralidze	\N	https://image.tmdb.org/t/p/w500/fqY7p0kotc9uuwB7UF3aYXXmY0R.jpg	t
387	Natasza Urbańska	\N	https://image.tmdb.org/t/p/w500/56Nc4WIey8Qhkf6QUgv1VnmRJJr.jpg	t
388	Ramón Langa	\N	https://image.tmdb.org/t/p/w500/xqF6bJrJOOac88IVgPVVl3fX869.jpg	t
389	Ewa Kasprzyk	\N	https://image.tmdb.org/t/p/w500/hNqsUYiFNYZrKKG9mXlEl3EfuPY.jpg	t
390	Dariusz Jakubowski	\N	https://image.tmdb.org/t/p/w500/bVsDOkPEBGUitIfvWIGoiZufWke.jpg	t
391	Tomasz Mandes	\N	https://image.tmdb.org/t/p/w500/wmYwPfWSXfjXpwvljvXEX8h0wfC.jpg	t
392	N.T. Rama Rao Jr.	\N	https://image.tmdb.org/t/p/w500/5ycQgZ3SPUa12bq0yn1jpToBq9X.jpg	t
393	Hrithik Roshan	\N	https://image.tmdb.org/t/p/w500/5O7WrWe84WDFj7td64NVsobtHf3.jpg	t
394	Kiara Advani	\N	https://image.tmdb.org/t/p/w500/ubsQYjr0hPDyGEKqHNzRPbYcPSz.jpg	t
395	Ashutosh Rana	\N	https://image.tmdb.org/t/p/w500/jFlhAoEP3KGEXO3SXCA4YLM2Goc.jpg	t
396	Anil Kapoor	\N	https://image.tmdb.org/t/p/w500/6RcrXGFzO50Tazqc8tbDlzYKvTd.jpg	t
397	Bobby Deol	\N	https://image.tmdb.org/t/p/w500/2npVa3PduichY8e7qBiE54m9VVP.jpg	t
398	K.C. Shankar	\N	https://image.tmdb.org/t/p/w500/fbxJMM6YZGl3OLHhnqISzPjbSpB.jpg	t
399	Varun Badola	\N	https://image.tmdb.org/t/p/w500/dzSBwofeP4dh3bP8TG6VxkHSjLy.jpg	t
400	Hearty Singh	\N	\N	t
401	Soni Razdan	\N	https://image.tmdb.org/t/p/w500/yOkPrW9Dnut5FqePGz34PdTpF2s.jpg	t
402	Emma Thompson	\N	https://image.tmdb.org/t/p/w500/xr8Ki3CIqweWWqS5q0kUYdiK6oQ.jpg	t
403	Judy Greer	\N	https://image.tmdb.org/t/p/w500/j5fyC7BdkhheN9A93ryEvHAP4Nl.jpg	t
404	Marc Menchaca	\N	https://image.tmdb.org/t/p/w500/fL0LmdBwau30M4AFPVJrpLRXXsU.jpg	t
405	Laurel Marsden	\N	https://image.tmdb.org/t/p/w500/kcm6kl68eERw0tpRrI3DXv6LJCD.jpg	t
406	Gaia Wise	\N	https://image.tmdb.org/t/p/w500/vyjUZOrhto3PKq4PuHG7270cum5.jpg	t
407	Cúán Hosty-Blaney	\N	https://image.tmdb.org/t/p/w500/tTcsqKO19XiboPUc2UmxxoeTgwU.jpg	t
408	Paul Hamilton	\N	\N	t
409	Dalton Leeb	\N	\N	t
410	Lloyd Hutchinson	\N	https://image.tmdb.org/t/p/w500/69PcFSBJgfDPWiMwW5Pwy1fTJZI.jpg	t
411	Brían F. O'Byrne	\N	https://image.tmdb.org/t/p/w500/9obqr2sZ0cf4z2ZsZoaHslSx45V.jpg	t
412	Nicole Wallace	\N	https://image.tmdb.org/t/p/w500/xlvq6OYCN6yQef4fpJQtwVyQxqr.jpg	t
413	Gabriel Guevara	\N	https://image.tmdb.org/t/p/w500/pviRYKEEmoPUfLYwP1VHJ6LQcRg.jpg	t
414	Marta Hazas	\N	https://image.tmdb.org/t/p/w500/1dbeTFRCbWBt70dIGjYHKVLnpaG.jpg	t
415	Iván Sánchez	\N	https://image.tmdb.org/t/p/w500/woVz8D7t1VUKjFJnsTAdc8tyz5C.jpg	t
416	Eva Ruiz	\N	https://image.tmdb.org/t/p/w500/bcu0nmQvhxwTzh4csc4kuxJsQee.jpg	t
417	Víctor Varona	\N	https://image.tmdb.org/t/p/w500/lcwFAjHjhJXkxf59TXGSjGGOlLj.jpg	t
418	Alex Bejar	\N	https://image.tmdb.org/t/p/w500/kPeFa6xX57IyhAfoT8dtgfPMgmX.jpg	t
419	Goya Toledo	\N	https://image.tmdb.org/t/p/w500/ygZpmXYB1fDSnpeJx1PadEQLgA5.jpg	t
420	Javier Morgade	\N	https://image.tmdb.org/t/p/w500/hcDV10bTZlm1rTi0NRhoGIpdicw.jpg	t
421	Felipe Londoño	\N	https://image.tmdb.org/t/p/w500/gUKu2bla3ZKtwuzfymMbyzUsobC.jpg	t
422	Fran Berenguer	\N	https://image.tmdb.org/t/p/w500/uYi3MOwqtNdfZt82DdvzKCZku50.jpg	t
423	呂良偉	\N	https://image.tmdb.org/t/p/w500/vAWHhBCWZwBKLsujgEKusfMLmCO.jpg	t
424	Ming Wang	\N	\N	t
425	吕艳婷	\N	https://image.tmdb.org/t/p/w500/vKpOzPutTaPf03rWXiLuK8R2K3B.jpg	t
426	囧森瑟夫	\N	https://image.tmdb.org/t/p/w500/58Ytg6PBGpqB2s7DkHB82dRvdFO.jpg	t
427	瀚墨	\N	https://image.tmdb.org/t/p/w500/6Ueom0Y4pjIG9B6zjQlfIbgcGhH.jpg	t
428	陈浩	\N	https://image.tmdb.org/t/p/w500/eBZJW1NCBFDh3U3xImf0vCCnDpy.jpg	t
429	绿绮	\N	https://image.tmdb.org/t/p/w500/eGoSeaM1c6KCLiRIqM8LJq5S5L5.jpg	t
430	张珈铭	\N	https://image.tmdb.org/t/p/w500/nFPxvqQLuDUpYgFiKRFkH0sX20P.jpg	t
431	Yang Wei	\N	https://image.tmdb.org/t/p/w500/rTi0M7yePiL3NqEGg5pTL7x56De.jpg	t
432	王德顺	\N	https://image.tmdb.org/t/p/w500/3DhZ0Z5lLrlifKIRP6lCYU1PhFj.jpg	t
433	雨辰	\N	https://image.tmdb.org/t/p/w500/zZ15ZOUpH7yNZ5Rz71l7YUhveMN.jpg	t
434	李南	\N	https://image.tmdb.org/t/p/w500/oHz2xKSBwNddOuOr8oylMlo6LL5.jpg	t
435	Matthew McConaughey	\N	https://image.tmdb.org/t/p/w500/lCySuYjhXix3FzQdS4oceDDrXKI.jpg	t
436	America Ferrera	\N	https://image.tmdb.org/t/p/w500/7F84Lh2lKpvkM3EiOvqqvlOmw93.jpg	t
437	Yul Vazquez	\N	https://image.tmdb.org/t/p/w500/chAxqgeJVoRoQukw7zRYgtlo4KI.jpg	t
438	Ashlie Atkinson	\N	https://image.tmdb.org/t/p/w500/hM5baaucl7UzeRozzTlTr4fPkw5.jpg	t
439	Kimberli Flores	\N	https://image.tmdb.org/t/p/w500/n7KNFY1Y76mStkNEiT4QilJASsL.jpg	t
440	Levi McConaughey	\N	\N	t
441	Kay McConaughey	\N	https://image.tmdb.org/t/p/w500/hXnLntSlUWk3PhiXe3tFmMssHji.jpg	t
442	John Messina	\N	\N	t
443	Kate Wharton	\N	https://image.tmdb.org/t/p/w500/huQbdrFJLJ42QNAW1ebwR44Gfau.jpg	t
444	Danny McCarthy	\N	https://image.tmdb.org/t/p/w500/jTYHl6SGo6hrHrezVCNHvEr4a5g.jpg	t
445	Allison Williams	\N	https://image.tmdb.org/t/p/w500/5Jy9HELKS1OYg7moRl8870OSfJq.jpg	t
446	Violet McGraw	\N	https://image.tmdb.org/t/p/w500/d1KMeeKURTUED3zPfu9le4R1jlr.jpg	t
447	Amie Donald	\N	https://image.tmdb.org/t/p/w500/dHnCD1oGVFEtnjskNQYO6sB5uSS.jpg	t
448	Jenna Davis	\N	https://image.tmdb.org/t/p/w500/mgmikHYAzJdirtPzxn9Dhsb71QQ.jpg	t
449	Brian Jordan Alvarez	\N	https://image.tmdb.org/t/p/w500/fKOHVfG2TCmzcRdJhjkUgL2LJcz.jpg	t
450	Jen Van Epps	\N	https://image.tmdb.org/t/p/w500/pI18BVf1c6frUMoXj2bV82NEiLE.jpg	t
451	Ivanna Sakhno	\N	https://image.tmdb.org/t/p/w500/vYlE7CUEeIa99NYZZWnnwn95Jo1.jpg	t
452	Aristotle Athari	\N	https://image.tmdb.org/t/p/w500/cFpP5axhjJ2Y4OhKrzPma9lEliO.jpg	t
453	Timm Sharp	\N	https://image.tmdb.org/t/p/w500/128ZwAdX38RmPIfouZo5fZrPSqE.jpg	t
454	Jemaine Clement	\N	https://image.tmdb.org/t/p/w500/6eiNbeurpHb2fxIeT0RrJ0wRI25.jpg	t
455	Pedro Pascal	\N	https://image.tmdb.org/t/p/w500/oKcMbVn0NJTNzQt0ClKKvVXkm60.jpg	t
456	Ebon Moss-Bachrach	\N	https://image.tmdb.org/t/p/w500/xD8GVNayMpiTZxLfahy2DseYcQq.jpg	t
457	Joseph Quinn	\N	https://image.tmdb.org/t/p/w500/zshhuioZaH8S5ZKdMcojzWi1ntl.jpg	t
458	Ralph Ineson	\N	https://image.tmdb.org/t/p/w500/sn3ONJw2pJxMHiCqPwvkaiWr5mc.jpg	t
459	Julia Garner	\N	https://image.tmdb.org/t/p/w500/ud1RXbvW70J89iqeic7no8olxvb.jpg	t
460	Natasha Lyonne	\N	https://image.tmdb.org/t/p/w500/2QJoTBEIeYyjGSDot9qxv2ayPH3.jpg	t
461	Sarah Niles	\N	https://image.tmdb.org/t/p/w500/ySelhnmCCX9VnlPvceO9c5XOelK.jpg	t
462	Mark Gatiss	\N	https://image.tmdb.org/t/p/w500/rkZKKDRbnGqqg2fjd5iPYDS4syy.jpg	t
463	Brad Pitt	\N	https://image.tmdb.org/t/p/w500/9OfnD7lxgIj3BNQpJFnwxnwl6w5.jpg	t
464	Damson Idris	\N	https://image.tmdb.org/t/p/w500/4jKOg4jCqNwXyrYd3coqgmCqkMy.jpg	t
465	Javier Bardem	\N	https://image.tmdb.org/t/p/w500/eCBiiPvBfIY7exDQwH0vEM6Bf3c.jpg	t
466	Kerry Condon	\N	https://image.tmdb.org/t/p/w500/8RO25vJxQSoNdhsVbiAHOsiGfvl.jpg	t
467	Tobias Menzies	\N	https://image.tmdb.org/t/p/w500/hGhAw2obMEOu1K0ed9b3jds9thf.jpg	t
468	Kim Bodnia	\N	https://image.tmdb.org/t/p/w500/koWU6vb82cuCDLeYE1erqnQ39cW.jpg	t
469	Will Merrick	\N	https://image.tmdb.org/t/p/w500/3IVuzHqE8FIBV679o4VGrZInpsE.jpg	t
470	Joseph Balderrama	\N	https://image.tmdb.org/t/p/w500/8BwRFsXzWD25dPih6IePcRD3EjT.jpg	t
471	Abdul Salis	\N	https://image.tmdb.org/t/p/w500/2gDH3kNzUr4IUZLbCiYR9OCTjGa.jpg	t
472	กรณิศ เล้าสุบินประเสริฐ	\N	https://image.tmdb.org/t/p/w500/eahGYvizpj5QX6uLZNxu9DF105o.jpg	t
473	ณิชภาลักษณ์ ทองคำ	\N	https://image.tmdb.org/t/p/w500/kwx6ARhwnVhuaVetqsvtBMEtNsL.jpg	t
474	เพิร์ธ วีริณฐ์ศรา ตั้งกิจสุวานิช	\N	https://image.tmdb.org/t/p/w500/fWMCviCsg3P4lZcGgji94gLezpG.jpg	t
475	Nuttawatt Thanathaveeprasert	\N	https://image.tmdb.org/t/p/w500/eFou96PXyf5PyMltjHFzQ97Mwxa.jpg	t
476	Tarisa Preechatangkit	\N	https://image.tmdb.org/t/p/w500/vvk3dvDH1TPoZCztpKCxUhEYwie.jpg	t
477	รมิตา รัตนภักดี	\N	https://image.tmdb.org/t/p/w500/YP0fM0QvLt5ETdycSTKSQWoSfQ.jpg	t
478	องอาจ เจียมเจริญพรกุล	\N	https://image.tmdb.org/t/p/w500/i3e4IuDngcByoViRZ8HMwNMNdRw.jpg	t
479	Watchara Tangkaprasert	\N	https://image.tmdb.org/t/p/w500/mO9TWrva19rIo6DLLHhWwpWdMRd.jpg	t
480	Kumron Jivachat	\N	https://image.tmdb.org/t/p/w500/e0AqdUj1D3xmtW6B42tDXRiifWk.jpg	t
481	Patchanok Iamsa-Ard	\N	https://image.tmdb.org/t/p/w500/xHQghPWr8FntsWW3jS84bN0pCMs.jpg	t
482	Dave Bautista	\N	https://image.tmdb.org/t/p/w500/snk6JiXOOoRjPtHU5VMoy6qbd32.jpg	t
483	Ольга Куриленко	\N	https://image.tmdb.org/t/p/w500/ei6eYUhQFw2AaV6U5fyPptBaPF0.jpg	t
484	Kristofer Hivju	\N	https://image.tmdb.org/t/p/w500/bACL39GihNmBnFRay78rS3PUHsH.jpg	t
485	Samuel L. Jackson	\N	https://image.tmdb.org/t/p/w500/AiAYAqwpM5xmiFrAIeQvUXDCVvo.jpg	t
486	Eden Epstein	\N	https://image.tmdb.org/t/p/w500/6ZYbrwHUR3VyGeWx7obPKDASGCJ.jpg	t
487	George Somner	\N	https://image.tmdb.org/t/p/w500/9FocanO4wogWLjxxNiLk3dP84Aa.jpg	t
488	Sergio Freijo	\N	\N	t
489	Lukáš Frlajs	\N	https://image.tmdb.org/t/p/w500/3JMimJWhNPNlpg86Wew4xuqqqsE.jpg	t
490	Phil Zimmerman	\N	https://image.tmdb.org/t/p/w500/9kYoNUQ1Gb9cZ8JfN2IsiW9KHH8.jpg	t
491	Claudio Del Falco	\N	https://image.tmdb.org/t/p/w500/ojjonAKO38RN7fzWPfzXOPcMPrt.jpg	t
492	Tomas Arana	\N	https://image.tmdb.org/t/p/w500/qMuQWxUQ2sXDiN2d9EDVT5VXHo2.jpg	t
493	Michael Segal	\N	https://image.tmdb.org/t/p/w500/aaaeTvSHHKhYkLqNwtHhZpQwQ6s.jpg	t
494	Ottaviano Dell'Acqua	\N	https://image.tmdb.org/t/p/w500/tvx3Sl2qYAtaZSylS4NfkPuVg19.jpg	t
495	Clara Guggiari	\N	https://image.tmdb.org/t/p/w500/v9aKtdbfiWlyFIEIxZqkbWzIpA7.jpg	t
496	Anna Rita Del Piano	\N	https://image.tmdb.org/t/p/w500/bdCp7itNbahpU99cPb6SMpQq1oS.jpg	t
497	Massimiliano Buzzanca	\N	https://image.tmdb.org/t/p/w500/2F4TFgN75mg91BmRQRqMV6ALGWs.jpg	t
498	Mauro Aversano	\N	https://image.tmdb.org/t/p/w500/5uw14Lh7yKHs0Dmfn5x9SJ5QtLM.jpg	t
499	Fabio Romagnolo	\N	https://image.tmdb.org/t/p/w500/6eoMRhCU0rH4PXdKhpeJ1eo4uJB.jpg	t
500	Stefano Tricarico	\N	\N	t
501	Vin Diesel	\N	https://image.tmdb.org/t/p/w500/nZdVry7lnUkE24PnXakok9okvL4.jpg	t
502	Asia Argento	\N	https://image.tmdb.org/t/p/w500/dYbYNxMnqhNyAJyrPU7e2C9jcRz.jpg	t
503	Marton Csokas	\N	https://image.tmdb.org/t/p/w500/gmeUY7FR0bFLdu7Ma5kvpH3Gt6B.jpg	t
504	Michael Roof	\N	https://image.tmdb.org/t/p/w500/qhP35tsTTuAPUFcKYMGOxaw1s4j.jpg	t
505	Richy Müller	\N	https://image.tmdb.org/t/p/w500/69W9VO478asbTZJrhqOfHddyunF.jpg	t
506	Werner Daehn	\N	https://image.tmdb.org/t/p/w500/7AVQ2pesALZjo5J0KsYADzoms9Z.jpg	t
507	Petr Jákl	\N	https://image.tmdb.org/t/p/w500/8zi7MXdHXWBIP6IuMFZB1HdWnGX.jpg	t
508	Jan Filipenský	\N	https://image.tmdb.org/t/p/w500/lQtE0gsFf6T7QXFnq3InuIG9WE9.jpg	t
509	Tom Everett	\N	https://image.tmdb.org/t/p/w500/lJIlLkadJ62eRai5BRgmmyObeiC.jpg	t
510	Asha Banks	\N	https://image.tmdb.org/t/p/w500/9McWYJPSySGOcNr5KuFWyW2bLe7.jpg	t
511	Matthew Broome	\N	https://image.tmdb.org/t/p/w500/nSjPuDG5IVQfyMU8TkZl0ZQkLu6.jpg	t
512	Eve Macklin	\N	https://image.tmdb.org/t/p/w500/2LaLgZbTBwLy1KojJ8UQivli4fF.jpg	t
513	Ray Fearon	\N	https://image.tmdb.org/t/p/w500/ou2cqhqdhfQoKVEBpIh0P3sKZti.jpg	t
514	Enva Lewis	\N	https://image.tmdb.org/t/p/w500/hFBuqi7NFiFgHho2J2IM43nZcrG.jpg	t
515	Jason Flemyng	\N	https://image.tmdb.org/t/p/w500/nYl0180ACnLzVlGbaAfuPtdGr9K.jpg	t
516	Sam Buchanan	\N	https://image.tmdb.org/t/p/w500/au5WjiUcUjheDEJ8BEXRFXhsIS8.jpg	t
517	Amelia Kenworthy	\N	https://image.tmdb.org/t/p/w500/3QgUXGc7iOEHDlK7MQhTBmkKpP.jpg	t
518	Harry Gilby	\N	https://image.tmdb.org/t/p/w500/4rORd6r6Ts4eYWVhbP9iIsE4CEo.jpg	t
519	Kate Winslet	\N	https://image.tmdb.org/t/p/w500/cPRq7uH3PIFcHilP15BrMKunink.jpg	t
520	Billy Zane	\N	https://image.tmdb.org/t/p/w500/wr4fuwLzQvW1G0MS7cmQ3ObFjvL.jpg	t
521	Kathy Bates	\N	https://image.tmdb.org/t/p/w500/nP7zRmXJyMyj2OohclSSo6JAEbD.jpg	t
522	Frances Fisher	\N	https://image.tmdb.org/t/p/w500/3iNDgd54IIj8g8hGqhhUjM6TeWd.jpg	t
523	Gloria Stuart	\N	https://image.tmdb.org/t/p/w500/9aG7UUX3PWIGGf1KRY5TsBSoNz9.jpg	t
524	Bill Paxton	\N	https://image.tmdb.org/t/p/w500/vbrgcMsy7m7Pc0O0glRZugfZgoK.jpg	t
525	Bernard Hill	\N	https://image.tmdb.org/t/p/w500/5i8bj2nsTrFU2ddSynleOjapxor.jpg	t
526	David Warner	\N	https://image.tmdb.org/t/p/w500/sJ5NyKkTmFGyiTrpCnZ1v0DSnQG.jpg	t
527	Victor Garber	\N	https://image.tmdb.org/t/p/w500/zPkpRPdW7rEm4fjgoJNz8hAZ6av.jpg	t
528	Johnny Depp	\N	https://image.tmdb.org/t/p/w500/wcI594cwM4ArPwvRd2IU0Z0yLuh.jpg	t
529	Helena Bonham Carter	\N	https://image.tmdb.org/t/p/w500/hJMbNSPJ2PCahsP3rNEU39C8GWU.jpg	t
530	Emily Watson	\N	https://image.tmdb.org/t/p/w500/bd0qiJXHoLNpkCqABsh67AKRtjC.jpg	t
531	Tracey Ullman	\N	https://image.tmdb.org/t/p/w500/cmug3uUXKBo9fhCcJk3pkgt1nvM.jpg	t
532	Paul Whitehouse	\N	https://image.tmdb.org/t/p/w500/4aacb6fRghFwrT636cYmAYqQ35o.jpg	t
533	Joanna Lumley	\N	https://image.tmdb.org/t/p/w500/k9SDy0lQ4hQdXZz1RMnFLntMVg5.jpg	t
534	Albert Finney	\N	https://image.tmdb.org/t/p/w500/8WCFO9lMHel1bHVYl5lj8pYEw2s.jpg	t
535	Richard E. Grant	\N	https://image.tmdb.org/t/p/w500/6UXv8E4WWvRCKMQx1FQ0FJVyu0a.jpg	t
536	Christopher Lee	\N	https://image.tmdb.org/t/p/w500/4zPu5YaRPbhrcp9aVjXQDjpfwPC.jpg	t
537	Michael Gough	\N	https://image.tmdb.org/t/p/w500/yoxoYUnySjL0Ccyle91AkPTxXbC.jpg	t
538	Jason Statham	\N	https://image.tmdb.org/t/p/w500/whNwkEQYWLFJA8ij0WyOOAD5xhQ.jpg	t
539	Merab Ninidze	\N	https://image.tmdb.org/t/p/w500/jnJ4lQULt6Ga3lXkIqAhMR7xYdE.jpg	t
540	Maximilian Osinski	\N	https://image.tmdb.org/t/p/w500/wMRtFsZSR9FvYj1wzsziKQqpZ0C.jpg	t
541	Cokey Falkow	\N	https://image.tmdb.org/t/p/w500/2VEMBUOHKZbpypEuso8jyxSo3Yc.jpg	t
542	Michael Peña	\N	https://image.tmdb.org/t/p/w500/ft9e3EX4JG9MwK9pXwgbJ8ZvFoV.jpg	t
543	David Harbour	\N	https://image.tmdb.org/t/p/w500/qMFtMWlYVtFVyBoBhX5IoA5sN5a.jpg	t
544	Noemi Gonzalez	\N	https://image.tmdb.org/t/p/w500/9BXgDrNRYy6wp0gxFP5qpqc6B5x.jpg	t
545	Arianna Rivas	\N	https://image.tmdb.org/t/p/w500/a4dRvxh2csK8pnMVz5Xrh8MrE8X.jpg	t
546	Isla Gie	\N	https://image.tmdb.org/t/p/w500/ebVVBTpJFiEyKoMwKnbPqLSbSUb.jpg	t
547	Mark Wahlberg	\N	https://image.tmdb.org/t/p/w500/bTEFpaWd7A6AZVWOqKKBWzKEUe8.jpg	t
548	LaKeith Stanfield	\N	https://image.tmdb.org/t/p/w500/x3k0HCpMNqEtVf2VKQrSCol1ia2.jpg	t
549	Rosa Salazar	\N	https://image.tmdb.org/t/p/w500/f8MITeVNUrP9mMiXcPnCEZTIW56.jpg	t
550	Keegan-Michael Key	\N	https://image.tmdb.org/t/p/w500/vAR5gVXRG2Cl6WskXT99wgkAoH8.jpg	t
551	Chukwudi Iwuji	\N	https://image.tmdb.org/t/p/w500/5JILtFNmAmA8T4gRQrO5sn8krDv.jpg	t
552	Nat Wolff	\N	https://image.tmdb.org/t/p/w500/g9noCweddwSb3VBSRpX3vo7TbuP.jpg	t
553	Gretchen Mol	\N	https://image.tmdb.org/t/p/w500/e3C1D1I09gtSGy4Ej1ewW2FFoew.jpg	t
554	Thomas Jane	\N	https://image.tmdb.org/t/p/w500/9frnlc2zoDcoeqZALB6aeYSQddl.jpg	t
555	Tony Shalhoub	\N	https://image.tmdb.org/t/p/w500/1zfBSuAmOr1xXjNg4WzFWPm5B0Z.jpg	t
556	Hemky Madera	\N	https://image.tmdb.org/t/p/w500/net1kEEpSrr9QC9be6YRhLGuM0k.jpg	t
557	Haley Bishop	\N	https://image.tmdb.org/t/p/w500/fTEvA8Nw3c22bo6fLl1o9ADkeVi.jpg	t
558	Jemma Moore	\N	https://image.tmdb.org/t/p/w500/8yaYuI0oors3S1FtMzwTLX50JzK.jpg	t
559	Emma Louise Webb	\N	https://image.tmdb.org/t/p/w500/z1xL9Ox8fdHHupLtzuzqMXvWTBR.jpg	t
560	Radina Drandova	\N	https://image.tmdb.org/t/p/w500/lgq2TlQu10lqRINSHg4HmKE69gf.jpg	t
561	Caroline Ward	\N	https://image.tmdb.org/t/p/w500/bHknMPDSpiymkkGJiOCpf0QcmPA.jpg	t
562	Edward Linard	\N	https://image.tmdb.org/t/p/w500/wolMNiNEFWfYJr5ioGBp9FycBNf.jpg	t
563	Seylan Baxter	\N	https://image.tmdb.org/t/p/w500/4DeuZiNsaYIN3VztxIyYorUCTKh.jpg	t
564	Alan Emrys	\N	https://image.tmdb.org/t/p/w500/twzSRDbL76JZMq359iMWv8AMugn.jpg	t
565	Jinny Lofthouse	\N	https://image.tmdb.org/t/p/w500/iInpwHTw1UFX79Q4OEe7dKal89m.jpg	t
566	James Swanton	\N	https://image.tmdb.org/t/p/w500/n7FXBEY2B56wiCR9IgqGOSNZjn1.jpg	t
567	Danny Elfman	\N	https://image.tmdb.org/t/p/w500/bcpur9bF56nLxzFzZowipA2wZhy.jpg	t
568	Chris Sarandon	\N	https://image.tmdb.org/t/p/w500/jP92Lq3JHl8mbdxzcZ6PyCQDwa5.jpg	t
569	Catherine O'Hara	\N	https://image.tmdb.org/t/p/w500/xjthrsXA31PVX91ByIQzORKSD0E.jpg	t
570	William Hickey	\N	https://image.tmdb.org/t/p/w500/sqqmvSkDK6vDNrmEgUAjzWztg9c.jpg	t
571	Glenn Shadix	\N	https://image.tmdb.org/t/p/w500/zTu0Fh0ohLIvFnEXiRvhe91T3Wg.jpg	t
572	Paul Reubens	\N	https://image.tmdb.org/t/p/w500/ybp9v90mrHtYVQkgHcf5lSAkt76.jpg	t
573	Ken Page	\N	https://image.tmdb.org/t/p/w500/pF2kpxQ9ycQyw3LvhmE5oJ4XQf1.jpg	t
574	Edward Ivory	\N	\N	t
575	Susan McBride	\N	\N	t
576	Debi Durst	\N	https://image.tmdb.org/t/p/w500/eyciVzqLaB7qDxBJ20c0OaNBUSc.jpg	t
577	Mikha Tambayong	\N	https://image.tmdb.org/t/p/w500/k0xaKf0dZakJERxVxQjKjKSgif7.jpg	t
578	Eva Celia	\N	https://image.tmdb.org/t/p/w500/pQGDOn24fKHxNdOuIZMKhhKFixW.jpg	t
579	Marthino Lio	\N	https://image.tmdb.org/t/p/w500/ryEJo0p2W09GyiGfcvKeDTfjHCC.jpg	t
580	Dimas Anggara	\N	https://image.tmdb.org/t/p/w500/8el1hnOXmVOTSi13Abq3FqXV5BL.jpg	t
581	Varen Arianda Calief	\N	\N	t
582	Ardit Erwandha	\N	https://image.tmdb.org/t/p/w500/pUdaMEo4S9EyPy5PFxOTpI5Js6m.jpg	t
583	Claresta Taufan Kusumarina	\N	https://image.tmdb.org/t/p/w500/u1AwIDPu9KOAcxqXtgvnLXuAqAZ.jpg	t
584	Donny Damara	\N	https://image.tmdb.org/t/p/w500/yba82o1poixDe9jK7o7LskbGyZo.jpg	t
585	Kiki Narendra	\N	https://image.tmdb.org/t/p/w500/5NQPn3HukEpRic0W9SSpz89X1ZO.jpg	t
586	Vonny Anggraini	\N	https://image.tmdb.org/t/p/w500/f9zlzGTsR9hq4yICjYf77FuaSbM.jpg	t
587	Florence Pugh	\N	https://image.tmdb.org/t/p/w500/6Sjz9teWjrMY9lF2o9FCo4XmoRh.jpg	t
588	Sebastian Stan	\N	https://image.tmdb.org/t/p/w500/nKZgixTbHFXpkzzIpMFdLX98GYh.jpg	t
589	Julia Louis-Dreyfus	\N	https://image.tmdb.org/t/p/w500/sXpjQoFoYqNehfWhlkScF8lo9vc.jpg	t
590	Lewis Pullman	\N	https://image.tmdb.org/t/p/w500/axcp6FswcSS1YPzO43BbyXIh2B2.jpg	t
591	Wyatt Russell	\N	https://image.tmdb.org/t/p/w500/zIldBzXdBWskPZB7x35G2hYEVDo.jpg	t
592	Hannah John-Kamen	\N	https://image.tmdb.org/t/p/w500/V8P9EVelewGVXbuyEylqrzF6iG.jpg	t
593	Geraldine Viswanathan	\N	https://image.tmdb.org/t/p/w500/mZ1dKqL2ymRipGEudzr8TQliB52.jpg	t
594	Wendell Pierce	\N	https://image.tmdb.org/t/p/w500/r6yKahL6Z8l9aUX5qvWxTmWl8Nm.jpg	t
595	Ice Cube	\N	https://image.tmdb.org/t/p/w500/9EghwabQ1wIQT4oN69qtPlzqGn4.jpg	t
596	Eva Longoria	\N	https://image.tmdb.org/t/p/w500/1u26GLWK1DE7gBugyI9P3OMFq4A.jpg	t
597	Clark Gregg	\N	https://image.tmdb.org/t/p/w500/mq686D91XoZpqkzELn0888NOiZW.jpg	t
598	Iman Benson	\N	https://image.tmdb.org/t/p/w500/6s8Cyc4rxDRpX1vYnczU52RM4IM.jpg	t
599	Henry Hunter Hall	\N	https://image.tmdb.org/t/p/w500/qZEv8RIGC9yLwY29Vo4KQzpO9Dt.jpg	t
600	Devon Bostick	\N	https://image.tmdb.org/t/p/w500/gTHfbDzeuzwrfpHrOxgFmuOjImY.jpg	t
601	Andrea Savage	\N	https://image.tmdb.org/t/p/w500/dh2prcwPU9U1PBdCNu5SSd4Of9j.jpg	t
602	Nicole Pulliam	\N	https://image.tmdb.org/t/p/w500/XcJAw0P7bPE9ET52P4fZ2hdokk.jpg	t
603	Michael O'Neill	\N	https://image.tmdb.org/t/p/w500/u9Ejl9iS4ZJ36Y653UCe8huLaOn.jpg	t
604	Jim Meskimen	\N	https://image.tmdb.org/t/p/w500/18eXUo8DfTwannhq8FOwgVdFs9Y.jpg	t
605	Susana Abaitua	\N	https://image.tmdb.org/t/p/w500/v9BA3YRPkEBpfL3ogKkn2Phag6m.jpg	t
606	Andrés Gertrúdix	\N	https://image.tmdb.org/t/p/w500/qR9EyorWi9Z8WnoFcY5AskYBW4B.jpg	t
607	Iraia Elias	\N	https://image.tmdb.org/t/p/w500/sqtUzaP1hwLkEkMQ8JoZZbjqtNr.jpg	t
608	Ariadna Gil	\N	https://image.tmdb.org/t/p/w500/4g5IyK6br9UCRqLLlW8z5ZLFtYf.jpg	t
609	Raúl Arévalo	\N	https://image.tmdb.org/t/p/w500/npWhiRnqlbqku6mNnk5RTgGvnj2.jpg	t
610	Anartz Zuazua	\N	https://image.tmdb.org/t/p/w500/abQ9nXis7hqVjAW7VKNDRYkbgzy.jpg	t
611	Jaime Chávarri	\N	https://image.tmdb.org/t/p/w500/7W1ax4s7l31seVqSndufvcdjulS.jpg	t
612	Cris Iglesias	\N	https://image.tmdb.org/t/p/w500/qJeRU4ToSc57diLsHlCx2fkWl1G.jpg	t
613	Mikel Losada	\N	https://image.tmdb.org/t/p/w500/uCL4nq9WZUU708By82SOk0D7jxr.jpg	t
614	Ander Lacalle	\N	https://image.tmdb.org/t/p/w500/1RzK5asw7lm6fTfDrNgTkqGagwu.jpg	t
615	范冰冰	\N	https://image.tmdb.org/t/p/w500/pV2wYJiiPd6cgHK580PKD0GM4Dc.jpg	t
616	Marcus Thomas	\N	https://image.tmdb.org/t/p/w500/gMRYZQZ1TZxgjb8yWpkVTs0BIdm.jpg	t
617	Grace O'Sullivan	\N	https://image.tmdb.org/t/p/w500/ifgurjdagUpyw9Dyh4yYtN0p3R7.jpg	t
618	Saksham Sharma	\N	https://image.tmdb.org/t/p/w500/vjyz2K6mqfw3T2X8uWv19Xlrqvd.jpg	t
619	Bernard Curry	\N	https://image.tmdb.org/t/p/w500/tSZTKbE0TkU0CbZxzgeixqlyoTq.jpg	t
620	Geoff Morrell	\N	https://image.tmdb.org/t/p/w500/zdbbOZPOb1VeAXh1idj9fKeHE87.jpg	t
621	Mahesh Jadu	\N	https://image.tmdb.org/t/p/w500/pugsskE62XbyYRruJk8KGk3JVdC.jpg	t
622	Amelia Bishop	\N	https://image.tmdb.org/t/p/w500/9PETfDjcqwfOJEPTuv6xrRVcHQy.jpg	t
623	Shapoor Batliwalla	\N	https://image.tmdb.org/t/p/w500/s0Bu0S4k3PaPWIZQiAhmyo7KvlC.jpg	t
624	Josh Brolin	\N	https://image.tmdb.org/t/p/w500/7QpneI3HoZCCDVPyWx3p3t7yeo7.jpg	t
625	Alden Ehrenreich	\N	https://image.tmdb.org/t/p/w500/bx86TPUmeHp0QkijQb16r2qIwEr.jpg	t
626	Austin Abrams	\N	https://image.tmdb.org/t/p/w500/9pSpSAk9NsYC5puqAVsmSK3OSeu.jpg	t
627	Benedict Wong	\N	https://image.tmdb.org/t/p/w500/yYfLyrC2CE6vBWSJfkpuVKL2POM.jpg	t
628	Amy Madigan	\N	https://image.tmdb.org/t/p/w500/xgtQOuPAmQZXWUO2PXetNpXm08A.jpg	t
629	Cary Christopher	\N	https://image.tmdb.org/t/p/w500/id5UrEyjXvr1KgQB4pnmD8JpSUR.jpg	t
630	Toby Huss	\N	https://image.tmdb.org/t/p/w500/dUqygHlDDnOBZLnE51MPJHkHWvQ.jpg	t
631	Whitmer Thomas	\N	https://image.tmdb.org/t/p/w500/ivz8rehM5WFKsUpDSULUFgPYyze.jpg	t
632	Callie Schuttera	\N	https://image.tmdb.org/t/p/w500/rStZupJY2T9bRr8Y1kg4CEgnHUX.jpg	t
633	Marilú Marini	\N	https://image.tmdb.org/t/p/w500/7vlHa5CglnVQO1LVphSySCgXO4i.jpg	t
634	Daniel Hendler	\N	https://image.tmdb.org/t/p/w500/8Q36TGfbnm4CjuKVWz1XGmTiZtk.jpg	t
635	Humberto Tortonese	\N	https://image.tmdb.org/t/p/w500/tw6JIrl0kscOcKZJrXHCO4zm2lb.jpg	t
636	Julieta Zylberberg	\N	https://image.tmdb.org/t/p/w500/5U0DhTO4N9Vg2c7QMGDcqrtcsW6.jpg	t
637	Paula Grinszpan	\N	https://image.tmdb.org/t/p/w500/qCxGAO5LrAWUL2VJ1cW9aoJUcwP.jpg	t
638	Carla Peterson	\N	https://image.tmdb.org/t/p/w500/wzu3UNvxIlk1i9uWjcFi8ANrAyl.jpg	t
639	Germán de Silva	\N	https://image.tmdb.org/t/p/w500/h8VzQUosN3LCPd6vkk7GQOrlapC.jpg	t
640	Roberto Suárez	\N	https://image.tmdb.org/t/p/w500/tblIKBRP4R8yBF5YWJBY43Akjts.jpg	t
641	Alejandra Flechner	\N	https://image.tmdb.org/t/p/w500/e9lwUZ09yysS6wOVVIe6tJDy2o2.jpg	t
642	Mariana Chaud	\N	https://image.tmdb.org/t/p/w500/6W18246FoJ5Hd86hmeqS0ixi5nq.jpg	t
643	Kaitlyn Santa Juana	\N	https://image.tmdb.org/t/p/w500/75Tdc3wg9mklJHy5LEj8OMjcPw8.jpg	t
644	Teo Briones	\N	https://image.tmdb.org/t/p/w500/cyykbm4Xht2Pi7brr88FcmS1LPb.jpg	t
645	Rya Kihlstedt	\N	https://image.tmdb.org/t/p/w500/86ysgxNPkckt8jp715X79CdopB7.jpg	t
646	Richard Harmon	\N	https://image.tmdb.org/t/p/w500/OMc1TCt9GEJddnVI1o5BPIAoLV.jpg	t
647	Owen Patrick Joyner	\N	https://image.tmdb.org/t/p/w500/eTZiPEsHZmmgQKEhC8HDf28sFmY.jpg	t
648	Anna Lore	\N	https://image.tmdb.org/t/p/w500/zNurGVtAxvVGnpgyG9kvBUG4nVf.jpg	t
649	Alex Zahara	\N	https://image.tmdb.org/t/p/w500/8T6k1sBrWyLI368Mk9iyYuwpqv2.jpg	t
650	April Telek	\N	https://image.tmdb.org/t/p/w500/2D80ewwe0KVbsyXRFIVoyzKbIe.jpg	t
651	Andrew Tinpo Lee	\N	https://image.tmdb.org/t/p/w500/hod73YmXiv3ZfDCMoJwBYXPqPzZ.jpg	t
652	Tony Todd	\N	https://image.tmdb.org/t/p/w500/5fZ0hKcRtFIFdgBFSL40LVFylfW.jpg	t
653	Dakota Fanning	\N	https://image.tmdb.org/t/p/w500/6bNiiHnZZfA7YYIxO5FszvNFBlI.jpg	t
654	Kathryn Hunter	\N	https://image.tmdb.org/t/p/w500/ni98cNE8kOAj6kcpEVmIfi8iAsw.jpg	t
655	Mary McCormack	\N	https://image.tmdb.org/t/p/w500/kVVttyq0cuTvDE4l5wEBqgjCBnf.jpg	t
656	Rachel Blanchard	\N	https://image.tmdb.org/t/p/w500/l8vUgOu1xVE1BKVCyrBf4M5PCBG.jpg	t
657	Devyn Nekoda	\N	https://image.tmdb.org/t/p/w500/82E8JHjsPSU6znvoYWNDs6xnItT.jpg	t
658	Klea Scott	\N	https://image.tmdb.org/t/p/w500/HdChlo9bawU9MgKHC11YNOSNAj.jpg	t
659	Emily Mitchell	\N	https://image.tmdb.org/t/p/w500/ehxuJhPwCo0M84SdD6k6cYsKFfs.jpg	t
660	Karen Cliche	\N	https://image.tmdb.org/t/p/w500/fVXdJyDRVDo7C5tTHauDm9zDvi9.jpg	t
661	Bauston Camilleri	\N	\N	t
662	Drew Moore	\N	https://image.tmdb.org/t/p/w500/lovZsvnY7YjUMsIfHBba4dZ6sF9.jpg	t
663	Lea Mathilde Skar-Myren	\N	https://image.tmdb.org/t/p/w500/wRsFFN1lhGcVM5kQFnLRW0wlQXR.jpg	t
664	Ane Dahl Torp	\N	https://image.tmdb.org/t/p/w500/t3hvq05o8oz9qJSI3KelxSkGXXO.jpg	t
665	Thea Sofie Loch Næss	\N	https://image.tmdb.org/t/p/w500/fzd0RI8Vnsw1LoG81YthvdnaeJD.jpg	t
666	Flo Fagerli	\N	https://image.tmdb.org/t/p/w500/yem43JCCG9xpjTT1IuosGtmZVNA.jpg	t
667	Isac Calmroth	\N	https://image.tmdb.org/t/p/w500/doyeUwvMsSkNuNzak9kBt26fNuP.jpg	t
668	Malte Gårdinger	\N	https://image.tmdb.org/t/p/w500/vDtILRvipBzF2bVqZBiqMQ1HehP.jpg	t
669	Ralph Carlsson	\N	https://image.tmdb.org/t/p/w500/iTvT8uyyVrWbyczhSGRYHeOmb9Z.jpg	t
670	Cecilia Forss	\N	https://image.tmdb.org/t/p/w500/mutGaRS2YbySqxyUvGQNYWLeJKX.jpg	t
671	Katarzyna Herman	\N	https://image.tmdb.org/t/p/w500/yD23VXf4IGH89jSBrOfJYY4Q7GW.jpg	t
672	Adam Lundgren	\N	https://image.tmdb.org/t/p/w500/hB62780sPK5HpHBylShEsrtfIh1.jpg	t
673	Rihanna	\N	https://image.tmdb.org/t/p/w500/piXUA7L0gWQNtnDPXtBe24C9FF6.jpg	t
674	James Corden	\N	https://image.tmdb.org/t/p/w500/xGB0gfZ48M27gQjjL7inJIh1Pqj.jpg	t
675	JP Karliak	\N	https://image.tmdb.org/t/p/w500/7Rc3n8KmKUaztqfsIpddO1a2ggn.jpg	t
676	Dan Levy	\N	https://image.tmdb.org/t/p/w500/2O9KqgCLHHMw5xmUpNexfWr2QVA.jpg	t
677	Amy Sedaris	\N	https://image.tmdb.org/t/p/w500/iQClumvSfTHgysxSofFmcLXmkCc.jpg	t
678	Sandra Oh	\N	https://image.tmdb.org/t/p/w500/zU8vjebHxcP60ESEL5Ok68KWZvj.jpg	t
679	Jimmy Kimmel	\N	https://image.tmdb.org/t/p/w500/wVVvvIwDtCgArdp0fsmjcM2tYyr.jpg	t
680	Octavia Spencer	\N	https://image.tmdb.org/t/p/w500/35SOy4yQZ9xRSJ0q1L5RLhXfhqN.jpg	t
681	Chase Stokes	\N	https://image.tmdb.org/t/p/w500/okoMZYMICceGRrca6jhCVkDxVxi.jpg	t
682	Lana Condor	\N	https://image.tmdb.org/t/p/w500/vWn27Fk2GLwH7o9fBG9hBWZI6OR.jpg	t
683	Desmin Borges	\N	https://image.tmdb.org/t/p/w500/9tF2giXqRiSJc2lkZG9R3G8FPjv.jpg	t
684	Callan Mulvey	\N	https://image.tmdb.org/t/p/w500/wJ8P1yNVmkx1PS1mc6Pi48tphfG.jpg	t
685	Diana Tsoy	\N	https://image.tmdb.org/t/p/w500/AfiqfFRPchrL0x5ifUeU4v0bFll.jpg	t
686	Daniel Jun	\N	https://image.tmdb.org/t/p/w500/xEuWQDSnIYUQRGH7mYjF3ckardG.jpg	t
687	Jonathan Whitesell	\N	https://image.tmdb.org/t/p/w500/aU1Tsj7PW4DPJf47CCNZLAkDlKP.jpg	t
688	Stephen Adekolu	\N	https://image.tmdb.org/t/p/w500/kgPVIwFPEFhUJBLJDffNsClkz0q.jpg	t
689	Ronald Patrick Thompson	\N	https://image.tmdb.org/t/p/w500/8mObNyDvc2ohr436Q1iQXpMAhMr.jpg	t
690	Leo Chiang	\N	https://image.tmdb.org/t/p/w500/tuMNenYBajmM4YHxzhvBnm7ZQ6V.jpg	t
691	Robert Downey Jr.	\N	https://image.tmdb.org/t/p/w500/5qHNjhtjMD4YWH3UP0rm4tKwxCL.jpg	t
692	Chris Evans	\N	https://image.tmdb.org/t/p/w500/3bOGNsHlrswhyW79uvIHH1V43JI.jpg	t
693	Chris Hemsworth	\N	https://image.tmdb.org/t/p/w500/piQGdoIQOF3C1EI5cbYZLAW1gfj.jpg	t
694	Mark Ruffalo	\N	https://image.tmdb.org/t/p/w500/5GilHMOt5PAQh6rlUKZzGmaKEI7.jpg	t
695	Scarlett Johansson	\N	https://image.tmdb.org/t/p/w500/mjReG6rR7NPMEIWb1T4YWtV11ty.jpg	t
696	Don Cheadle	\N	https://image.tmdb.org/t/p/w500/oZ1u1GmudvUGpbMfi9Hxonzp3lF.jpg	t
697	Tom Holland	\N	https://image.tmdb.org/t/p/w500/nIJj91naJI4biogqIKLSglKNfCM.jpg	t
698	Chadwick Boseman	\N	https://image.tmdb.org/t/p/w500/nL16SKfyP1b7Hk6LsuWiqMfbdb8.jpg	t
699	Amy Poehler	\N	https://image.tmdb.org/t/p/w500/rwmvRonpluV6dCPiQissYrchvSD.jpg	t
700	Maya Hawke	\N	https://image.tmdb.org/t/p/w500/wzRfh5JMZcSRV7Oc7GtfrYSBrGU.jpg	t
701	Kensington Tallman	\N	https://image.tmdb.org/t/p/w500/tBqawwg2VJq1V4mZjAOFQ7fnXNW.jpg	t
702	Liza Lapira	\N	https://image.tmdb.org/t/p/w500/o3jvQAGWtxi5rEycslhC6CY8BWX.jpg	t
703	Tony Hale	\N	https://image.tmdb.org/t/p/w500/ar4uapp4w5wMkThZcqWUNMSTO8z.jpg	t
704	Lewis Black	\N	https://image.tmdb.org/t/p/w500/1Yvp5dwnJ1UI0KtXGNhZ384wTgv.jpg	t
705	Phyllis Smith	\N	https://image.tmdb.org/t/p/w500/h9w9pQbiderRWAC2mi7spjzuIGz.jpg	t
706	Ayo Edebiri	\N	https://image.tmdb.org/t/p/w500/V9TNVjNkAJIiCHLTzcnHLktnPf.jpg	t
707	Lilimar	\N	https://image.tmdb.org/t/p/w500/cRerzbUsq0TiWe6z0VGtLHz4JOa.jpg	t
708	Grace Lu	\N	https://image.tmdb.org/t/p/w500/iRHUHXADcEgUBAAjixnVnAH6MLt.jpg	t
709	Demi Moore	\N	https://image.tmdb.org/t/p/w500/wApParZYBDi4yxekjfxjKEifJYh.jpg	t
710	Margaret Qualley	\N	https://image.tmdb.org/t/p/w500/jStNyMj3acpLuH48awLVLqqlyaV.jpg	t
711	Dennis Quaid	\N	https://image.tmdb.org/t/p/w500/lMaDAJHzsKH7U3dln2B3kY3rOhE.jpg	t
712	Edward Hamilton-Clark	\N	https://image.tmdb.org/t/p/w500/q1EWL2z2xMcbf84TpOTqGs6Csxs.jpg	t
713	Gore Abrams	\N	https://image.tmdb.org/t/p/w500/bKMTqbl0FYlzIC6aTMKQZNAhhXK.jpg	t
714	Oscar Lesage	\N	https://image.tmdb.org/t/p/w500/8N31SCzlmRBEHRXD7AIE50Wh7Fs.jpg	t
715	Christian Erickson	\N	https://image.tmdb.org/t/p/w500/cpEzQNW1EsRmK8SMj4y5xwevXwM.jpg	t
716	Robin Greer	\N	https://image.tmdb.org/t/p/w500/6oAOwJt2LywrGqkB8fGjvAbkLB.jpg	t
717	Tom Morton	\N	https://image.tmdb.org/t/p/w500/aOdP4niQX4ckaFwPQmbf0mlYTC5.jpg	t
718	Hugo Diego Garcia	\N	https://image.tmdb.org/t/p/w500/mC0Aly8hHgNIYvZSa1SZmYU47pn.jpg	t
719	Teri Hatcher	\N	https://image.tmdb.org/t/p/w500/ySmnfZm8ZGabcwp4UwaMDeSzXqx.jpg	t
720	Jennifer Saunders	\N	https://image.tmdb.org/t/p/w500/pTgxwHcz9L8SNVYvPJS0o0lgHya.jpg	t
721	Dawn French	\N	https://image.tmdb.org/t/p/w500/eLFCJSTEeh7CDRw50RzowKz4h7V.jpg	t
722	Keith David	\N	https://image.tmdb.org/t/p/w500/jJLJuR7FNHYL1fB5igjj7IXzOel.jpg	t
723	John Hodgman	\N	https://image.tmdb.org/t/p/w500/xlgpI6x1OECW6V7uB70DG7BirUa.jpg	t
724	Robert Bailey Jr.	\N	https://image.tmdb.org/t/p/w500/2CVKz4PSWBXv2IIIX54DW8MVza2.jpg	t
725	Ian McShane	\N	https://image.tmdb.org/t/p/w500/qh9RTLbnr128TZLdGuXwUH9mdBM.jpg	t
726	Aankha Neal	\N	\N	t
727	George Selick	\N	\N	t
728	Abby Trott	\N	https://image.tmdb.org/t/p/w500/ot5RwJzqN0U7oC5zoMIj7uNLdwB.jpg	t
729	Danielle Bisutti	\N	https://image.tmdb.org/t/p/w500/ddB51VdCjrgfUBBBw9SJawY5oJD.jpg	t
730	Stephen J. Anderson	\N	https://image.tmdb.org/t/p/w500/csdeskOXUe9iHQBe7OqZwpQ2lRk.jpg	t
731	Jake Green	\N	https://image.tmdb.org/t/p/w500/3bfUpMgBCJw1Serr18Qm8tDJQvE.jpg	t
732	Matt Lowe	\N	https://image.tmdb.org/t/p/w500/u137BVOu2worxWBIWNkwW35b60X.jpg	t
733	Paul Briggs	\N	https://image.tmdb.org/t/p/w500/9kzPCzw7U47F9jvrZ7gStGQrtZ9.jpg	t
734	Marta Svetek	\N	https://image.tmdb.org/t/p/w500/8z6m4jODbzAunsDNPLWY73PZ1jn.jpg	t
735	Ayvianna Snow	\N	https://image.tmdb.org/t/p/w500/yrxGM3SAdfxzirfxpzcTBxzjpad.jpg	t
736	Ben Manning	\N	https://image.tmdb.org/t/p/w500/qEMOKGGoqlPBl1tdbuCUHWOH1pj.jpg	t
737	Charlie Bond	\N	https://image.tmdb.org/t/p/w500/htDMnq99nRcEgYFOw3xw4RDie7Z.jpg	t
738	Ciaron Davies	\N	https://image.tmdb.org/t/p/w500/uPHdbYBZ12zOKC9k95Ryb9UtXjD.jpg	t
739	Jasmine Sumner	\N	\N	t
740	Annabella Rich	\N	https://image.tmdb.org/t/p/w500/akOozx7fe0otFsFsdyInvNj0Wzl.jpg	t
741	Morgan Rees-Davies	\N	\N	t
742	Justin Long	\N	https://image.tmdb.org/t/p/w500/7TGXeHw4o86IBm6xknQotpludXK.jpg	t
743	Mila Harris	\N	https://image.tmdb.org/t/p/w500/10BSVhLPqosSBsOgp0L7qaU0Uhi.jpg	t
744	Brittany Allen	\N	https://image.tmdb.org/t/p/w500/kGLQeglfbdEbD5IursaYRutmRx0.jpg	t
745	Kate Bosworth	\N	https://image.tmdb.org/t/p/w500/ezaM2jsyrxXWVFN1SbH3UfAgZaG.jpg	t
746	Norbert Leo Butz	\N	https://image.tmdb.org/t/p/w500/2SMyLebGOemP26yL9pp7IFKfqG5.jpg	t
747	Kevin Glynn	\N	https://image.tmdb.org/t/p/w500/jIQk6lFQ0FOg5piKabufRHfSxNc.jpg	t
748	Katherine McNamara	\N	https://image.tmdb.org/t/p/w500/cuGVMcnpi6HjobaGADo1xtaDglR.jpg	t
749	Norma Nivia	\N	https://image.tmdb.org/t/p/w500/oqTkTd5kY1Ca7T4zTANTmNql5Zj.jpg	t
750	Judith O'Dea	\N	https://image.tmdb.org/t/p/w500/nihfq3xdU22xnxHKmqA0Mv9rUvv.jpg	t
751	Keir O'Donnell	\N	https://image.tmdb.org/t/p/w500/3s08QlRwgqhd2YWLHzTfnjlLNlv.jpg	t
752	Jared Leto	\N	https://image.tmdb.org/t/p/w500/ca3x0OfIKbJppZh8S1Alx3GfUZO.jpg	t
753	Evan Peters	\N	https://image.tmdb.org/t/p/w500/n4yb5deDWPsvSQ9KLm0WR2Q2elC.jpg	t
754	Gillian Anderson	\N	https://image.tmdb.org/t/p/w500/60fOJNhmfEmyskQDmHStSMHRjgK.jpg	t
755	Jeff Bridges	\N	https://image.tmdb.org/t/p/w500/xms1RAY6q7Lzp7wNeRCB0kzhucn.jpg	t
756	Hasan Minhaj	\N	https://image.tmdb.org/t/p/w500/6vHHhLnbKBCPmYc90qAV2Cde95F.jpg	t
757	Arturo Castro	\N	https://image.tmdb.org/t/p/w500/pbLoDCfjm3fLtGHVqQcnbM2d0cu.jpg	t
758	Cameron Monaghan	\N	https://image.tmdb.org/t/p/w500/gegD6j2xaDCTFByssg8PDbuUbjR.jpg	t
759	Sarah Desjardins	\N	https://image.tmdb.org/t/p/w500/cj9Ztgkc45lUB83u7iK3mvq5G3q.jpg	t
760	Dave Franco	\N	https://image.tmdb.org/t/p/w500/2diSplvpzCE5CrIKvTaplCKvwPq.jpg	t
761	Mckenna Grace	\N	https://image.tmdb.org/t/p/w500/sjnnfJyhUJ6t4yLJRrM8yApjVT.jpg	t
762	Mason Thames	\N	https://image.tmdb.org/t/p/w500/kPVWuKlDR0wkCSvv5iHLkaEQS0L.jpg	t
763	Willa Fitzgerald	\N	https://image.tmdb.org/t/p/w500/hXvCqRAtmrfjozHtVNrBgXFzzao.jpg	t
764	Clancy Brown	\N	https://image.tmdb.org/t/p/w500/1JeBRNG7VS7r64V9lOvej9bZXW5.jpg	t
765	Sam Morelos	\N	https://image.tmdb.org/t/p/w500/nmrCwmyVB7BdwNrx1cvvxGY0Ci2.jpg	t
766	Ethan Costanilla	\N	https://image.tmdb.org/t/p/w500/dsdFTHLLdqFpipyPX7bWNBRk7hE.jpg	t
767	Luke Pierre Roness	\N	https://image.tmdb.org/t/p/w500/mA41dGhmhznIJZGOyxheZWWozmu.jpg	t
768	Vishwak Sen	\N	https://image.tmdb.org/t/p/w500/ffWsFHwde7M3W2IiIfn01htpALX.jpg	t
769	Akansha Sharma	\N	https://image.tmdb.org/t/p/w500/aqPeJiZLSTDQnNmQPvchS1FlBVA.jpg	t
770	Babloo Prithiveeraj	\N	https://image.tmdb.org/t/p/w500/lnRXcRebSmfJaSaRqTt91o1vkhE.jpg	t
771	Abhimanyu Singh	\N	https://image.tmdb.org/t/p/w500/ucGZIeHvG9SsW9B94InteMyOlpD.jpg	t
772	Vineet Kumar	\N	https://image.tmdb.org/t/p/w500/qAOIqG6kjysnSDlhkueQ7XaLc7t.jpg	t
773	Kamakshi Bhaskarla	\N	https://image.tmdb.org/t/p/w500/rS6eRKX0ZldriYdZjx6zf8faoHH.jpg	t
774	Surabhi Prabhavathi	\N	\N	t
775	Ravi Mariya	\N	https://image.tmdb.org/t/p/w500/2OKPiv0HobYPSrFMM6LZPxuLMgc.jpg	t
776	Prudhviraj	\N	https://image.tmdb.org/t/p/w500/fF5zEdi65qeyClLhjIuCmT5LdFb.jpg	t
777	Sunisith	\N	https://image.tmdb.org/t/p/w500/3fdfMFnJNJPQ6jyhLLUNpCiwZhg.jpg	t
778	Daniel Day-Lewis	\N	https://image.tmdb.org/t/p/w500/3kNA9VcmymoEwT0btQ4bvMYxzcP.jpg	t
779	Sean Bean	\N	https://image.tmdb.org/t/p/w500/kTjiABk3TJ3yI0Cto5RsvyT6V3o.jpg	t
780	Samantha Morton	\N	https://image.tmdb.org/t/p/w500/v84b7MENeD9rwX6xTD7fSdhSOC9.jpg	t
781	Samuel Bottomley	\N	https://image.tmdb.org/t/p/w500/8ZocaRIa2sqH14LyoIeA2vCVO16.jpg	t
782	Safia Oakley-Green	\N	https://image.tmdb.org/t/p/w500/k4JrjdSIfwWF1Qd5KHChDfnXpF2.jpg	t
783	Lewis Ian Bray	\N	\N	t
784	Paul Butterworth	\N	https://image.tmdb.org/t/p/w500/xtyvuOxKxsp8vbRx5kKxAqJrs3L.jpg	t
785	Karl Cam	\N	\N	t
786	JP Conway	\N	\N	t
787	Angus Cooper	\N	https://image.tmdb.org/t/p/w500/oyB5JeN7XRb6xi7alp7jiy9mJfH.jpg	t
788	Oscar Isaac	\N	https://image.tmdb.org/t/p/w500/dW5U5yrIIPmMjRThR9KT2xH6nTz.jpg	t
789	Jacob Elordi	\N	https://image.tmdb.org/t/p/w500/lC9pK3ADyPpH4dRo2BKZBaTZPfu.jpg	t
790	Mia Goth	\N	https://image.tmdb.org/t/p/w500/jlxfhuAiNpPEAsyswSfY3njn36m.jpg	t
791	Christoph Waltz	\N	https://image.tmdb.org/t/p/w500/jMvLGCVXLaBqjRLf5olyvEucZob.jpg	t
792	Charles Dance	\N	https://image.tmdb.org/t/p/w500/3xHwq5lchAI6mfW0aGQOEijexv6.jpg	t
793	David Bradley	\N	https://image.tmdb.org/t/p/w500/znpkwHitb3pcaJbUmgDqG0YenYp.jpg	t
794	Lars Mikkelsen	\N	https://image.tmdb.org/t/p/w500/xw3bJxjf8yT8TS8zigEGWQYSaXH.jpg	t
795	Christian Convery	\N	https://image.tmdb.org/t/p/w500/hmfUY4lhSEc0qq065X34aR9CjzC.jpg	t
796	Nikolaj Lie Kaas	\N	https://image.tmdb.org/t/p/w500/zRu68e0GSwHJC7QOcbO77xIAM9J.jpg	t
797	Sam Rockwell	\N	https://image.tmdb.org/t/p/w500/vYpWxV0bnUgKo7SdasfGP9HttUq.jpg	t
798	Marc Maron	\N	https://image.tmdb.org/t/p/w500/wlMurVOngmGhwpHQsRkMv6plvBq.jpg	t
799	Awkwafina	\N	https://image.tmdb.org/t/p/w500/l5AKkg3H1QhMuXmTTmq1EyjyiRb.jpg	t
800	Craig Robinson	\N	https://image.tmdb.org/t/p/w500/mTyTrOWUSOBJMOlDpnd4OYx7FlJ.jpg	t
801	Zazie Beetz	\N	https://image.tmdb.org/t/p/w500/xDOXOWgflBi8xAdxiAusrynHdAk.jpg	t
802	Мария Бакалова	\N	https://image.tmdb.org/t/p/w500/vCz0ycZr1PgJVOAeS29fIiZE8pN.jpg	t
803	Alex Borstein	\N	https://image.tmdb.org/t/p/w500/evbCnRe5Yfuy0B41PONLTIcvbem.jpg	t
804	Kate Mara	\N	https://image.tmdb.org/t/p/w500/xZYD8wYHMmN9dMMPiohnKEFoTGx.jpg	t
805	Laurence Fishburne	\N	https://image.tmdb.org/t/p/w500/2GbXERENPpl5MmlqOLlPVaVtifD.jpg	t
806	Gabriel Luna	\N	https://image.tmdb.org/t/p/w500/2NNNl3od5K7HXOLUqlK3tzdxKkD.jpg	t
807	Ivana Miličević	\N	https://image.tmdb.org/t/p/w500/3bWPeAnqRwuCAoYBDig3E3cFx5m.jpg	t
808	Macy Gray	\N	https://image.tmdb.org/t/p/w500/sKgKxFF49EdIGknA8Z0yLnrGTFU.jpg	t
809	Reza Diako	\N	https://image.tmdb.org/t/p/w500/z3f2f2Pl2Uw4JZLPhFnwosNR4sV.jpg	t
810	Anthony Gonzalez	\N	https://image.tmdb.org/t/p/w500/WF7bn6t0LkxwBWyDMWvomVujn7.jpg	t
811	Gael García Bernal	\N	https://image.tmdb.org/t/p/w500/7uEO29wtdyY9bjt2JN43gVpE6vt.jpg	t
812	Benjamin Bratt	\N	https://image.tmdb.org/t/p/w500/hBenHPT4iJEG2kt5z2TOGnkRZwh.jpg	t
813	Alanna Ubach	\N	https://image.tmdb.org/t/p/w500/ffyBAEoW3bDgVJQV3GaHsZ9x29W.jpg	t
814	Renée Victor	\N	https://image.tmdb.org/t/p/w500/wAVDqwFhQsRQgO6VIYq6T9Wbbx8.jpg	t
815	Jaime Camil	\N	https://image.tmdb.org/t/p/w500/njvdXEGN3bSSXpsyVnyKQTXdf1V.jpg	t
816	Alfonso Arau	\N	https://image.tmdb.org/t/p/w500/5ishPim5akWXSnMbwOWSc3KxDx8.jpg	t
817	Herbert Siguenza	\N	https://image.tmdb.org/t/p/w500/aVLX3sRMZp1qIfqCRHgjjy2NfGI.jpg	t
818	Gabriel Iglesias	\N	https://image.tmdb.org/t/p/w500/8Bjy3RZ5TfNs3oUOUpxTv84G01f.jpg	t
819	Lombardo Boyar	\N	https://image.tmdb.org/t/p/w500/wwWs0u2QDz1XOakR05C0BYJCfM1.jpg	t
820	Caleb Landry Jones	\N	https://image.tmdb.org/t/p/w500/8M5lPHrERwAIfWK56RkH30FOjhV.jpg	t
821	Zoë Bleu Sidel	\N	https://image.tmdb.org/t/p/w500/n1IKYQWhxQFpHOa8mwbyk2cUb3I.jpg	t
822	Guillaume de Tonquédec	\N	https://image.tmdb.org/t/p/w500/mDPeqkKJgFMiH60gH32VTwgOHSp.jpg	t
823	Matilda De Angelis	\N	https://image.tmdb.org/t/p/w500/xL6Ky35uDDz9L4qWkMF2cTjGkbn.jpg	t
824	Ewens Abid	\N	https://image.tmdb.org/t/p/w500/5zGcQkoSsg1AdkcvYuqnLuslMuv.jpg	t
825	David Shields	\N	https://image.tmdb.org/t/p/w500/k7E0Pctzyx1ML8M9nnxVhnKIFtz.jpg	t
826	Bertrand-Xavier Corbi	\N	https://image.tmdb.org/t/p/w500/bY4kNFV0O9pQD0XAW9McD7t6X0W.jpg	t
827	Raphael Luce	\N	https://image.tmdb.org/t/p/w500/68OEaQZYvgGKbzzQHi9PQE8Gnt9.jpg	t
828	Liviu Bora	\N	\N	t
829	Arielle Raycene	\N	https://image.tmdb.org/t/p/w500/nhCNfUJzAP74KHWc1ZCDnbks8w8.jpg	t
830	Ellie Gonsalves	\N	https://image.tmdb.org/t/p/w500/g7MFtBgdHohaZao9wpM4DNBt94o.jpg	t
831	Kane Hodder	\N	https://image.tmdb.org/t/p/w500/avMGd9rA2ys1pJok1EGOa46MEQX.jpg	t
832	Danielle Mathers	\N	https://image.tmdb.org/t/p/w500/xUBg2o9I2qYYXoPkmHERBkXGXVt.jpg	t
833	Monica Sims	\N	https://image.tmdb.org/t/p/w500/1LX09bCuGVcw9JrDEPkkkLRdNiv.jpg	t
834	Amberleigh West	\N	https://image.tmdb.org/t/p/w500/rvf5z0kw8TuAWaF7UYJ27yB3Ckn.jpg	t
835	Colleen Hagerty	\N	\N	t
836	Skyler Seymour	\N	\N	t
837	Sam Worthington	\N	https://image.tmdb.org/t/p/w500/mflBcox36s9ZPbsZPVOuhf6axaJ.jpg	t
838	Sigourney Weaver	\N	https://image.tmdb.org/t/p/w500/wTSnfktNBLd6kwQxgvkqYw6vEon.jpg	t
839	Stephen Lang	\N	https://image.tmdb.org/t/p/w500/hdRiM73H2mpJws559TWHCAia7qJ.jpg	t
840	Cliff Curtis	\N	https://image.tmdb.org/t/p/w500/3D6qz8vL6DWHAO3HeXeaSuwxq3s.jpg	t
841	Joel David Moore	\N	https://image.tmdb.org/t/p/w500/mMVhVglj6BZFuvqAXnEibce08k7.jpg	t
842	Edie Falco	\N	https://image.tmdb.org/t/p/w500/jS2Hnr5OmntpX0J7EpH70zAG0mz.jpg	t
843	Agnes Albright	\N	https://image.tmdb.org/t/p/w500/39laAb3lRSVQv4NtXzIwuowuFry.jpg	t
844	Jeremy Holm	\N	https://image.tmdb.org/t/p/w500/cOOu1DOY6s59oAMMjtXJ70RicNU.jpg	t
845	Maisie Merlock	\N	https://image.tmdb.org/t/p/w500/3JWMsPvZd2bVA5LKr2V8YuyPZis.jpg	t
846	Caito Aase	\N	https://image.tmdb.org/t/p/w500/1UEAhfUfY9owZKgtdJniC84Z3LN.jpg	t
847	Andrew Bailes	\N	\N	t
848	Cate Rio	\N	\N	t
849	Leslie Lux	\N	\N	t
850	Shannon McInnis	\N	\N	t
851	Anne Hathaway	\N	https://image.tmdb.org/t/p/w500/s6tflSD20MGz04ZR2R1lZvhmC4Y.jpg	t
852	Jessica Chastain	\N	https://image.tmdb.org/t/p/w500/xRvRzxiiHhgUErl0yf9w8WariRE.jpg	t
853	Casey Affleck	\N	https://image.tmdb.org/t/p/w500/304ilSygaCRWykoBWAL67TOw8g9.jpg	t
854	Wes Bentley	\N	https://image.tmdb.org/t/p/w500/voD93lzFZrr9xfAggwFcPRBi84i.jpg	t
855	Topher Grace	\N	https://image.tmdb.org/t/p/w500/oJQxl4DG0KSCtOGrpWNhYz9gUZA.jpg	t
856	Mackenzie Foy	\N	https://image.tmdb.org/t/p/w500/wzH60SrqWp2XMkBfLgdBhx5EJ82.jpg	t
857	Ellen Burstyn	\N	https://image.tmdb.org/t/p/w500/uEHZoAtCnGCXvQDHe3s3DWW2G1c.jpg	t
858	John Lithgow	\N	https://image.tmdb.org/t/p/w500/8Y1sjBdnVR483S8PrnAQzlESwhx.jpg	t
859	Mateusz Damięcki	\N	https://image.tmdb.org/t/p/w500/bJTVPMPVpYts0g5klIiCgttMWWj.jpg	t
860	Szymon Bobrowski	\N	https://image.tmdb.org/t/p/w500/tqtEbh3LZL2MTBOpmDQTwP8JLFq.jpg	t
861	Pola Gonciarz	\N	https://image.tmdb.org/t/p/w500/g7KXyzwxPtkkyB3zoWDgOsNNgUa.jpg	t
862	Weronika Książkiewicz-Nathaniel	\N	https://image.tmdb.org/t/p/w500/ltNynTRFPGfSZOwStrowGOmfRTq.jpg	t
863	Łukasz Simlat	\N	https://image.tmdb.org/t/p/w500/m1CH1TFVkSfHmwzZcZNtoa1GXzG.jpg	t
864	Mateusz Banasiuk	\N	https://image.tmdb.org/t/p/w500/htagP1QvjTuSEeenZp1P04vwNzk.jpg	t
865	Cezary Łukaszewicz	\N	https://image.tmdb.org/t/p/w500/8ASklhZgDAllY4iWqhfRMaRuipz.jpg	t
866	Wojciech Zieliński	\N	https://image.tmdb.org/t/p/w500/yt48QlTQm123yfk2y4R20d8r4ay.jpg	t
867	Konrad Eleryk	\N	https://image.tmdb.org/t/p/w500/q1pfFnOYGUysIpFES0MHrVnDe7S.jpg	t
868	Paulina Gałązka	\N	https://image.tmdb.org/t/p/w500/diQYiFu59qhDrLNmt5F0aYNTeK.jpg	t
869	Lawson Greyson	\N	https://image.tmdb.org/t/p/w500/4w1cAv3QS5T1cEprQqrTZ5pI6Cg.jpg	t
870	Sarah Nicklin	\N	https://image.tmdb.org/t/p/w500/p8xTRBrL5Z1WOqogSledn3kUnkY.jpg	t
871	Jenna Hogan	\N	https://image.tmdb.org/t/p/w500/7sn4NbuHElo8TxDGnp2BusqZQTT.jpg	t
872	Isabella Feliciana	\N	https://image.tmdb.org/t/p/w500/nevQhLo0JYFezHo3ZxguJdKNACf.jpg	t
873	Sean Berube	\N	https://image.tmdb.org/t/p/w500/ciQLIjnhkaQYOkWpYuUbFDDFjfA.jpg	t
874	Riley Nottingham	\N	https://image.tmdb.org/t/p/w500/pMwFSCt222VNWLfKUc7otY2ygHV.jpg	t
875	Lily Speiser	\N	https://image.tmdb.org/t/p/w500/d9iih1EnGgV88Jzi8xGpxmljIfU.jpg	t
876	Samantha Cochran	\N	https://image.tmdb.org/t/p/w500/xrdmIo9818mmYBwJds4Sq3L4fCM.jpg	t
877	Stephen Gurewitz	\N	\N	t
878	Miles Emanuel	\N	https://image.tmdb.org/t/p/w500/e0IfEAoJsKOv8BviGRqPexhiPTq.jpg	t
879	Ethan Hawke	\N	https://image.tmdb.org/t/p/w500/2LoTr6x0TEM7L5em4kSx1VmGDgG.jpg	t
880	Madeleine McGraw	\N	https://image.tmdb.org/t/p/w500/57eZDQuZr695X8pnAbPDVAZztCU.jpg	t
881	Demián Bichir	\N	https://image.tmdb.org/t/p/w500/dur9tX8tbDDJE5mSOZkuW2VDGz4.jpg	t
882	Miguel Mora	\N	https://image.tmdb.org/t/p/w500/yVjtjXQ4WWlN8XiDYsHKdwcBRXU.jpg	t
883	Jeremy Davies	\N	https://image.tmdb.org/t/p/w500/tNtcpQnMxzl0OqVDsyA63oAgPbI.jpg	t
884	Maev Beaty	\N	https://image.tmdb.org/t/p/w500/xu1NcOTmT3gNPgjcIu1UJxLaNPD.jpg	t
885	Graham Abbey	\N	https://image.tmdb.org/t/p/w500/6xLpD2Ap69mphaqCKPirRLNPf1l.jpg	t
886	James Ransone	\N	https://image.tmdb.org/t/p/w500/n1O0RnxKPfxvVJUh13Gr0pPGlvd.jpg	t
887	Peter Dinklage	\N	https://image.tmdb.org/t/p/w500/9CAd7wr8QZyIN0E7nm8v1B6WkGn.jpg	t
888	Jacob Tremblay	\N	https://image.tmdb.org/t/p/w500/h8CXDp86Y36CUENF4SXJq5ZRTsf.jpg	t
889	Taylour Paige	\N	https://image.tmdb.org/t/p/w500/kCSH5Ihy22arcQFUBzSsMVnguBX.jpg	t
890	Julia Davis	\N	https://image.tmdb.org/t/p/w500/wsUNCSKoNQTgSdlr9FIeIR6hRAd.jpg	t
891	Jonny Coyne	\N	https://image.tmdb.org/t/p/w500/6PSW0qaoY3KSnWUUv6f54NOuPC0.jpg	t
892	Elijah Wood	\N	https://image.tmdb.org/t/p/w500/7UKRbJBNG7mxBl2QQc5XsAh6F8B.jpg	t
893	Kevin Bacon	\N	https://image.tmdb.org/t/p/w500/rjX2Oz3tCZMfSwOoIAyEhdtXnTE.jpg	t
894	David Yow	\N	https://image.tmdb.org/t/p/w500/rbL8wH5G8gBd93RjOcfcFLC3e2l.jpg	t
895	Shaun Dooley	\N	https://image.tmdb.org/t/p/w500/uWiw28ARiLkvL6xUjKDLDlSsfkY.jpg	t
896	Maddie Hasson	\N	https://image.tmdb.org/t/p/w500/eH6SnpMGDC9CQScmIchSnKkZAbc.jpg	t
897	Alex Roe	\N	https://image.tmdb.org/t/p/w500/n3EVRACN3XEuOzrWK3TTn791gWo.jpg	t
898	Marco Pigossi	\N	https://image.tmdb.org/t/p/w500/2Rixkot6LFwxTfxASYjqJgEnQwZ.jpg	t
899	Andra Nechita	\N	https://image.tmdb.org/t/p/w500/gQ4LiGLpsKToQITMGLbzzQUu3uB.jpg	t
900	Eliane Reis	\N	https://image.tmdb.org/t/p/w500/s0m5qJ5CNTPitpPYWUkI5de07Go.jpg	t
901	Clayton Spencer	\N	\N	t
902	Auliʻi Cravalho	\N	https://image.tmdb.org/t/p/w500/vEroqcnM2g6yY7qXDAie7hx2Cyp.jpg	t
903	Dwayne Johnson	\N	https://image.tmdb.org/t/p/w500/5QApZVV8FUFlVxQpIK3Ew6cqotq.jpg	t
904	Hualālai Chung	\N	https://image.tmdb.org/t/p/w500/x2g5fdHqETY9dZgL4aB0QDP0boR.jpg	t
905	Rose Matafeo	\N	https://image.tmdb.org/t/p/w500/zQa39fMjbOTIsovbh1TBTJVlToz.jpg	t
906	David Fane	\N	https://image.tmdb.org/t/p/w500/tcozyaTgAa8rRmzc5qeht0loni6.jpg	t
907	Awhimai Fraser	\N	https://image.tmdb.org/t/p/w500/276OUDPl2iIsz772HQw3tiz2JN2.jpg	t
908	Khaleesi Lambert-Tsuda	\N	https://image.tmdb.org/t/p/w500/3LHXDjy9UijbtR7X2EReX5H57kk.jpg	t
909	Temuera Morrison	\N	https://image.tmdb.org/t/p/w500/AvtSC0f9QW7fMyFFNXEWDeQyfUk.jpg	t
910	Nicole Scherzinger	\N	https://image.tmdb.org/t/p/w500/kKG7zJvVReTipBYDD3aqHj4uPBe.jpg	t
911	Tim Robbins	\N	https://image.tmdb.org/t/p/w500/djLVFETFTvPyVUdrd7aLVykobof.jpg	t
912	Bob Gunton	\N	https://image.tmdb.org/t/p/w500/ulbVvuBToBN3aCGcV028hwO0MOP.jpg	t
913	William Sadler	\N	https://image.tmdb.org/t/p/w500/xC9sijoDnjS3oDZ5eszcGKHKAOp.jpg	t
914	Gil Bellows	\N	https://image.tmdb.org/t/p/w500/eCOIv2nSGnWTHdn88NoMyNOKWyR.jpg	t
915	James Whitmore	\N	https://image.tmdb.org/t/p/w500/nYMAbkfwFIgKK84vnLoQctI6vHg.jpg	t
916	Mark Rolston	\N	https://image.tmdb.org/t/p/w500/hcrNRIptYMRXgkJ9k76BlQu6DQp.jpg	t
917	Jeffrey DeMunn	\N	https://image.tmdb.org/t/p/w500/70bkLdlkBB7x2NztuJAh4pjdyxy.jpg	t
918	Larry Brandenburg	\N	https://image.tmdb.org/t/p/w500/y13c1a4keaLnoTbi3dERwolQXWP.jpg	t
919	Emily Alatalo	\N	https://image.tmdb.org/t/p/w500/u9Ir0RZ9czYik7luqZ8cn4YRs9Z.jpg	t
920	Tim Rozon	\N	https://image.tmdb.org/t/p/w500/i43AGRDzYoMPqhTyRKL96H3PSxx.jpg	t
921	Patrick Garrow	\N	https://image.tmdb.org/t/p/w500/gWu8E3zYnwBVa5zTZzQP3JO1uLI.jpg	t
922	Jon McLaren	\N	https://image.tmdb.org/t/p/w500/qqwkwlLaXcevLJdscwrnTNn8ROx.jpg	t
923	Milton Barnes	\N	https://image.tmdb.org/t/p/w500/qCP3CVoEQmLopSHuHLOUooP1RDY.jpg	t
924	Mikaël Conde	\N	https://image.tmdb.org/t/p/w500/zjg10lLfFsKxi8MWVokUBtMxgWg.jpg	t
925	Greg Bryk	\N	https://image.tmdb.org/t/p/w500/1I3SxKFvQSam6KOMT4j5f0nFxRg.jpg	t
926	Eman Ayaz	\N	https://image.tmdb.org/t/p/w500/9OGuopTnmxUxvS1NBz3fet1hL4r.jpg	t
927	Khalid Karim	\N	https://image.tmdb.org/t/p/w500/hbITlhVxW8Vu6b0ohkyk53MY6lo.jpg	t
928	Alex Jade	\N	https://image.tmdb.org/t/p/w500/b4475ZB4wTOA55DH3ArQvZXH6VU.jpg	t
929	Ivana Baquero	\N	https://image.tmdb.org/t/p/w500/pMF10VVHG4ksp7MEzYmNzaDDX18.jpg	t
930	Sergi López	\N	https://image.tmdb.org/t/p/w500/n3HcmUflYYaHUiQmzaayi0yqcRf.jpg	t
931	Maribel Verdú	\N	https://image.tmdb.org/t/p/w500/xfpNy6z0eN2jwhv8NQnUxUYGq2P.jpg	t
932	Doug Jones	\N	https://image.tmdb.org/t/p/w500/rpvvWATYWHGjedJea0G97XufOwU.jpg	t
933	Álex Angulo	\N	https://image.tmdb.org/t/p/w500/jyigKF2y1lTsrA0Et41TJ08Tmn6.jpg	t
934	Roger Casamajor	\N	https://image.tmdb.org/t/p/w500/1UQozr5Y4C9HlFAWvsjsLPvThLF.jpg	t
935	Manolo Solo	\N	https://image.tmdb.org/t/p/w500/hp422wUkCWW2lsitzJrANv4N92u.jpg	t
936	César Vea	\N	https://image.tmdb.org/t/p/w500/u081b37HYVdASt3logKXzSFdfdB.jpg	t
937	Ivan Massagué	\N	https://image.tmdb.org/t/p/w500/dmnJo2sGlfFjtKb8FDPlNjRhfyc.jpg	t
938	Keanu Reeves	\N	https://image.tmdb.org/t/p/w500/8RZLOyYGsoRe9p44q3xin9QkMHv.jpg	t
939	Anjelica Huston	\N	https://image.tmdb.org/t/p/w500/6hnYeHa7Rc1w1MmQ3JsLSIb7yCX.jpg	t
940	Gabriel Byrne	\N	https://image.tmdb.org/t/p/w500/9r9oDGENg92VYYFMkV4C09IUlrb.jpg	t
941	Catalina Sandino Moreno	\N	https://image.tmdb.org/t/p/w500/78V4H40NXJ6dzqFZaEe1fBelw56.jpg	t
942	Ava McCarthy	\N	https://image.tmdb.org/t/p/w500/9HcCr2p1ofBHPb9uuTNBAsxtj0T.jpg	t
943	Juliet Doherty	\N	https://image.tmdb.org/t/p/w500/pKZjcSanPllyEiHe3rac6OfeQ9a.jpg	t
944	Norman Reedus	\N	https://image.tmdb.org/t/p/w500/ozHPdO5jAt7ozzdZUgyRAMNPSDW.jpg	t
945	Lance Reddick	\N	https://image.tmdb.org/t/p/w500/22mVtEXZbpt0J7S0LhIhdkfRrZV.jpg	t
946	Arden Cho	\N	https://image.tmdb.org/t/p/w500/uPtfAFoEYeNGRl6n0GdxLPxdM9u.jpg	t
947	May Hong	\N	https://image.tmdb.org/t/p/w500/hnWIn2hxnJt16j0rDTiqdbG5LQo.jpg	t
948	Ji-young Yoo	\N	https://image.tmdb.org/t/p/w500/4jgtqpNWhMx8XOKQ9qQJvDdzbxG.jpg	t
949	Ahn Hyo Seop	\N	https://image.tmdb.org/t/p/w500/ynu1x6RQnpKvsOLTvB2WhDo26D9.jpg	t
950	김윤진	\N	https://image.tmdb.org/t/p/w500/xS7eco56mUiZGJGWDZ0pwzrUAei.jpg	t
951	Ken Jeong	\N	https://image.tmdb.org/t/p/w500/dfuDZ2m2A8nBb0TdyeqmlPOobJA.jpg	t
952	Lee Byung-hun	\N	https://image.tmdb.org/t/p/w500/j7SUd9Qi8iOxgrQGb3nQyEYcXur.jpg	t
953	Daniel Dae Kim	\N	https://image.tmdb.org/t/p/w500/AtKRWsC4UhEjzorWlL2eguzZ9XM.jpg	t
954	Joel Kim Booster	\N	https://image.tmdb.org/t/p/w500/gKJHnWnnEoN85aC9UzAlg7XFnSG.jpg	t
955	Kikunosuke Toya	\N	https://image.tmdb.org/t/p/w500/tSAHe7tjN7luUD1Tx5yPSCuCnuD.jpg	t
956	Shiori Izawa	\N	https://image.tmdb.org/t/p/w500/f9V38OeDvRGevWuKc4dN6LB62TH.jpg	t
957	Tomori Kusunoki	\N	https://image.tmdb.org/t/p/w500/t5aBzyYiJZDE6DWeTcGMrcQpiI5.jpg	t
958	Shogo Sakata	\N	https://image.tmdb.org/t/p/w500/fRRPNBz3OCNRdmLdUTdpq7dGqxM.jpg	t
959	Fairouz Ai	\N	https://image.tmdb.org/t/p/w500/coFu6WOVBZvqd1fw89vbHkiC0zB.jpg	t
960	高橋花林	\N	https://image.tmdb.org/t/p/w500/40eynav2SoYcfd0McfiF46Hu16o.jpg	t
961	Yuuya Uchida	\N	https://image.tmdb.org/t/p/w500/4xLLQGEDWtmLWUapo0UnfvCdsXp.jpg	t
962	Maaya Uchida	\N	https://image.tmdb.org/t/p/w500/rq4glg2SZwGyt3TIxR3ElalKmhH.jpg	t
963	Paolo Gallina	\N	https://image.tmdb.org/t/p/w500/kzwZuHZ0vBx8NLRp4Z5tgpBR0tA.jpg	t
964	Matteo Radaelli	\N	\N	t
965	Alessandro Calì Ventura	\N	https://image.tmdb.org/t/p/w500/8YjFTgMnGE0yyASkFSkX6AmMyXF.jpg	t
966	Marco Antonini	\N	\N	t
967	Salvatore Torrisi	\N	\N	t
968	Angelo Thomann	\N	\N	t
969	Alessandro Ambrosini	\N	\N	t
970	Tony Jaa	\N	https://image.tmdb.org/t/p/w500/anBSs0nh4n4cpiwRl5QmjT5zRrt.jpg	t
971	洪浚嘉	\N	https://image.tmdb.org/t/p/w500/tAuACGpzSJcBcK4F4u0ZYLW3uSz.jpg	t
972	释行宇	\N	https://image.tmdb.org/t/p/w500/tsbmvldckYiFPeDfFSvgzNrJsUK.jpg	t
973	姜皓文	\N	https://image.tmdb.org/t/p/w500/sy07oaWguC4Q4c45dRkFuRTYld0.jpg	t
974	陈朵怡	\N	https://image.tmdb.org/t/p/w500/tUz8flw4bFUcBbgU6i6isFoBUZZ.jpg	t
975	彭渤	\N	https://image.tmdb.org/t/p/w500/iC4jHUEFIvfn8lBR7pamBTYQkdg.jpg	t
976	于柏林	\N	https://image.tmdb.org/t/p/w500/hHGBPgc5K134wuxgp9R0Zt2v0qb.jpg	t
977	Mao Fan	\N	https://image.tmdb.org/t/p/w500/mM07Oh9XREBoGBrPoB2PLGQrphT.jpg	t
978	Ge Shuai	\N	https://image.tmdb.org/t/p/w500/4OiuNELA9Ae1UOSVoZynnAJlDv3.jpg	t
979	Zhao Leiqi	\N	https://image.tmdb.org/t/p/w500/tTU0bvfi2aG5xQwweMn4k3JKte5.jpg	t
980	Sean Cronin	\N	https://image.tmdb.org/t/p/w500/nj3ptvRuVB0wHlLeMDq0g39JRdh.jpg	t
981	Ewen Weatherburn	\N	https://image.tmdb.org/t/p/w500/oKW0yxxTBO7TC8fRiQEpF4yo95K.jpg	t
982	Cameron Ashplant	\N	https://image.tmdb.org/t/p/w500/7J8YluqxL2DlrFMmxFoPmxSrRpl.jpg	t
983	Richard Rowden	\N	https://image.tmdb.org/t/p/w500/dhPqtrWbwCGW7a63uRRzj4i0LsW.jpg	t
984	Destiny Viva	\N	https://image.tmdb.org/t/p/w500/iU1M2y0iU6wAuIp6HSCBM0DRs5W.jpg	t
985	Brandon Ashplant	\N	\N	t
986	Dean Marshall	\N	https://image.tmdb.org/t/p/w500/che3C6ZnOAGQimCgXWIZwnf56iW.jpg	t
987	Dave Hyett	\N	\N	t
988	John Craggs	\N	https://image.tmdb.org/t/p/w500/7WlvLJ56v15onRnd3CmdRkl7yjr.jpg	t
989	Mahershala Ali	\N	https://image.tmdb.org/t/p/w500/9ZmSejm5lnUVY5IJ1iNx2QEjnHb.jpg	t
990	Jonathan Bailey	\N	https://image.tmdb.org/t/p/w500/kMtZtavkXIXYA0CnhaWqbNo6uFV.jpg	t
991	Rupert Friend	\N	https://image.tmdb.org/t/p/w500/a3HeMHmlXnoRlHLX9h31ZdZgCXM.jpg	t
992	Manuel Garcia-Rulfo	\N	https://image.tmdb.org/t/p/w500/54Rk1hKfNdNKGHQMnONDGmNtUv3.jpg	t
993	Luna Blaise	\N	https://image.tmdb.org/t/p/w500/y4GIzipFLyC90WcA27XRrokggYR.jpg	t
994	David Iacono	\N	https://image.tmdb.org/t/p/w500/3QTinnl70cvU3a22fLKCLk4Wpbx.jpg	t
995	Audrina Miranda	\N	https://image.tmdb.org/t/p/w500/nkKWtafw6r7ekbjbHr3AmKNlybZ.jpg	t
996	Philippine Velge	\N	https://image.tmdb.org/t/p/w500/gqTkAEIlcDisOnfuyusqZtBb1IG.jpg	t
997	Bechir Sylvain	\N	https://image.tmdb.org/t/p/w500/wpZZVoUR9IrtsdxsX6A7Rth6AXz.jpg	t
998	Margo Martindale	\N	https://image.tmdb.org/t/p/w500/6ANuYnZZJTuQLL4bbt8vH1qDYje.jpg	t
999	Johnny Vegas	\N	https://image.tmdb.org/t/p/w500/8OSpG0BrJGtIWXpIlYMryVve2iK.jpg	t
1000	Maitreyi Ramakrishnan	\N	https://image.tmdb.org/t/p/w500/jBFqjwvngaz6ZXEhNd6dMeZ0W6c.jpg	t
1001	Ryan Anderson Lopez	\N	https://image.tmdb.org/t/p/w500/iFadWNebbBsvZ0F1KfcHkiG60I1.jpg	t
1002	Emilia Clarke	\N	https://image.tmdb.org/t/p/w500/iFY6t7Ux9r70WB7Sp0TTVz6eGtm.jpg	t
1003	Natalie Portman	\N	https://image.tmdb.org/t/p/w500/edPU5HxncLWa1YkgRPNkSd68ONG.jpg	t
1004	Timothy Simons	\N	https://image.tmdb.org/t/p/w500/upav8HyWsF6ksAkvogEhR9sBlNN.jpg	t
1005	Nicole Byer	\N	https://image.tmdb.org/t/p/w500/o3duseUY15axuEOAQ31pJneOKLa.jpg	t
1006	Jason Mantzoukas	\N	https://image.tmdb.org/t/p/w500/vv6ULb4DMMctAWBAWguwvDgzi7Q.jpg	t
1007	Robb Guinto	\N	https://image.tmdb.org/t/p/w500/dtqU7iZ3QouBCAkRARiOtFGcFab.jpg	t
1008	Ali Asistio	\N	https://image.tmdb.org/t/p/w500/cd97k2S9f1c56lJHfr9If93gWNM.jpg	t
1009	JC Tan	\N	https://image.tmdb.org/t/p/w500/sSjBEtpEsMd5nHNaeum8R7450IO.jpg	t
1010	Rash Flores	\N	https://image.tmdb.org/t/p/w500/2Dax8oWjedXgUdtQUqaKLrzay8P.jpg	t
1011	Jodi Garcia	\N	https://image.tmdb.org/t/p/w500/bYq7IQRCrVm8hVTlir1qKqll6ja.jpg	t
1012	Damien Ferrette	\N	https://image.tmdb.org/t/p/w500/iW6zIP5wGMTI4RS4JKn2QjaKcxG.jpg	t
1013	Hervé Jolly	\N	https://image.tmdb.org/t/p/w500/qzOzE27xrOEAMogrLxYmCDKwqlr.jpg	t
1014	Kaycie Chase	\N	https://image.tmdb.org/t/p/w500/tis8Xvy8ALtFc9Kt7JBma0ze3Xp.jpg	t
1015	Frantz Confiac	\N	\N	t
1016	Emmanuel Garijo	\N	https://image.tmdb.org/t/p/w500/ept2JUdN35WonXZgLLkA1Mr4uSL.jpg	t
1017	Nicolas Marié	\N	https://image.tmdb.org/t/p/w500/qbfZbRhyAi3rgerGmxoXAvQbQN8.jpg	t
1018	Stéphane Ronchewski	\N	https://image.tmdb.org/t/p/w500/ch1Y70vg5vPYIyheMPuh0f2uYWZ.jpg	t
1019	Sébastien Desjours	\N	https://image.tmdb.org/t/p/w500/dbddLLnPiJKY9ot4CvBeaUFppXM.jpg	t
1020	Nico Parker	\N	https://image.tmdb.org/t/p/w500/gt0NJClVSCPCEfcPgcLj3f85uLa.jpg	t
1021	Gerard Butler	\N	https://image.tmdb.org/t/p/w500/rTO5opVC3Gs6hPYAxWSP9eEjogi.jpg	t
1022	Nick Frost	\N	https://image.tmdb.org/t/p/w500/2CHS4t6miNGLgMQAjhFqb4fFuKS.jpg	t
1023	Gabriel Howell	\N	https://image.tmdb.org/t/p/w500/u3PTI9FlrpGFZVMoHXZZBiYWMCl.jpg	t
1024	Julian Dennison	\N	https://image.tmdb.org/t/p/w500/pP9tymIRkOEEQqetcC1Yby5rGbi.jpg	t
1025	Bronwyn James	\N	https://image.tmdb.org/t/p/w500/mSaZaVNsAVU70VH5go2D2oS8OIL.jpg	t
1026	Harry Trevaldwyn	\N	https://image.tmdb.org/t/p/w500/uYHekOiCHZoob1tW11vTceplA2e.jpg	t
1027	Murray McArthur	\N	https://image.tmdb.org/t/p/w500/aW9Ib3PzKuWuSd0YrTIbFLGX877.jpg	t
1028	Peter Serafinowicz	\N	https://image.tmdb.org/t/p/w500/atXOX0UQzIZkcnpNj1cluBdHwAE.jpg	t
1029	Miles Teller	\N	https://image.tmdb.org/t/p/w500/cg3LW0xX6RKr8dmescxq1bepcb5.jpg	t
1030	Anya Taylor-Joy	\N	https://image.tmdb.org/t/p/w500/qYNofOjlRke2MlJVihmJmEdQI4v.jpg	t
1031	Ṣọpẹ́ Dìrísù	\N	https://image.tmdb.org/t/p/w500/24Se9voPxrO200Ae8GQRbMkE55B.jpg	t
1032	William Houston	\N	https://image.tmdb.org/t/p/w500/4J4TG1dbyJcSs78hP9fU2x8jrJs.jpg	t
1033	Kobna Holdbrook-Smith	\N	https://image.tmdb.org/t/p/w500/6KNQjNWVdosnKAehV7FHpxQV2dD.jpg	t
1034	James Marlowe	\N	https://image.tmdb.org/t/p/w500/grKtqA62ni9yBqGekfq3Aw1GM1o.jpg	t
1035	Julianna Kurokawa	\N	https://image.tmdb.org/t/p/w500/fObnbEVsnhyWiaXYbaA6JA86r01.jpg	t
1036	Ruta Gedmintas	\N	https://image.tmdb.org/t/p/w500/ArRuSKwJJwr3venBPjwoukApa8j.jpg	t
1037	Oliver Trevena	\N	https://image.tmdb.org/t/p/w500/j0ejU7vdE7lRxYKKrhA5aWw1zCT.jpg	t
1038	Rafael Vitti	\N	https://image.tmdb.org/t/p/w500/13665Z5mw7pqcTx97Nfx4f5oxoG.jpg	t
1039	Amendoim	\N	https://image.tmdb.org/t/p/w500/zD8TxZTY6GQta9LX3EXxSZa2FBV.jpg	t
1040	Arianne Botelho	\N	https://image.tmdb.org/t/p/w500/oT6awna46xqykeDE6IIMK5neHsf.jpg	t
1041	Kelzy Ecard	\N	https://image.tmdb.org/t/p/w500/RltIjtLpjRVVv8nM0FvVylFWbD.jpg	t
1042	Bruno Vinicius	\N	https://image.tmdb.org/t/p/w500/rJWCMYEkJ2Ie8b5XgnYO7FLZPh.jpg	t
1043	Ademara Barros	\N	https://image.tmdb.org/t/p/w500/p5iARYXSvqrpqSZQaaczZZkdywF.jpg	t
1044	Noemia Oliveira	\N	https://image.tmdb.org/t/p/w500/95yO42O7K3smHhKwiWbXc2Zxwwe.jpg	t
1045	Carolina Ferraz	\N	https://image.tmdb.org/t/p/w500/2dup1uh3zpY2S9pjksivkXIQxcN.jpg	t
1046	Cristina Pereira	\N	https://image.tmdb.org/t/p/w500/FjBsbgaOpYbS1mpXIBnEkN6g1V.jpg	t
1047	Paola Carosella	\N	https://image.tmdb.org/t/p/w500/hJZFLzfNRMMHcNzPPLDmZxFyK2q.jpg	t
1048	Avaryana Rose	\N	\N	t
1049	Michael Ashley McKeever	\N	\N	t
1050	Destiny Leilani Brown	\N	https://image.tmdb.org/t/p/w500/sT1Rf0Opd3FDqRdPYznC5A0eDMc.jpg	t
1051	Michael Hargrove	\N	https://image.tmdb.org/t/p/w500/f8qOXxjA1qs0pqZPzqRtY3HyKKV.jpg	t
1052	Tim O'Hearn	\N	https://image.tmdb.org/t/p/w500/1VtGRhQ0Ov1xxykeozD1koLt5DC.jpg	t
1053	Anthony Nathanial	\N	\N	t
1054	Nicholas Scott	\N	\N	t
1055	Maika Monroe	\N	https://image.tmdb.org/t/p/w500/x4yiKkMnCdf8g4eOrDoqla9FYEA.jpg	t
1056	Mary Elizabeth Winstead	\N	https://image.tmdb.org/t/p/w500/i1RjhPH8XypvR0W7zKCLrFxph4D.jpg	t
1057	Raúl Castillo	\N	https://image.tmdb.org/t/p/w500/wyxl5HtyjeJRXkE89LtsItQhPHN.jpg	t
1058	Mileiah Vega	\N	\N	t
1059	Nora Contreras	\N	\N	t
1060	Lola Contreras	\N	\N	t
1061	Martin Starr	\N	https://image.tmdb.org/t/p/w500/3CCLTJL5EQ7nuvpeXvZwTGXFVtE.jpg	t
1062	Yvette Lu	\N	\N	t
1063	Riki Lindhome	\N	https://image.tmdb.org/t/p/w500/kJAGFp0ZW5sY0NoysFZcfSRykZa.jpg	t
1064	Shannon Cochran	\N	https://image.tmdb.org/t/p/w500/4Som3LsajmNzQNrzVs1t6dsuEog.jpg	t
1065	E. Roger Mitchell	\N	https://image.tmdb.org/t/p/w500/tKvwSO725HZ6cHdL2FzYCobPDzu.jpg	t
1066	Troy Rudeseal	\N	https://image.tmdb.org/t/p/w500/uZsJqXf9qGMhxwO0FmWKQxnPzQm.jpg	t
1067	Rebecca Clarke	\N	https://image.tmdb.org/t/p/w500/zlE4SjkUQetgvpJFVmIPQi24jni.jpg	t
1068	J. Gaven Wilde	\N	https://image.tmdb.org/t/p/w500/ysLRYuM5SZjN8S7aD5eHFRPayW6.jpg	t
1069	Roxanne McKee	\N	https://image.tmdb.org/t/p/w500/6yIEG1guFsPIHTT3UsagYVrG6Am.jpg	t
1070	Tom Mulheron	\N	https://image.tmdb.org/t/p/w500/fI7KCUQMOoRpclBtpNx30wDTWak.jpg	t
1071	Adrian Relph	\N	https://image.tmdb.org/t/p/w500/smi8jwXC31HMozEnYlCQRGOZcnm.jpg	t
1072	Nicola Wright	\N	https://image.tmdb.org/t/p/w500/5FsJ2Oq0l6E8aB6n7PYl4zUyVT5.jpg	t
1073	Alex Cooke	\N	https://image.tmdb.org/t/p/w500/wpIdUbpsLx88EuaioQpAzXATnVx.jpg	t
1074	Ewan Borthwick	\N	https://image.tmdb.org/t/p/w500/82VxrlMpkN4d0x79CHCmOAKwPvr.jpg	t
1075	Big Tobz	\N	https://image.tmdb.org/t/p/w500/2u3o3ImXlBXdj7CZq07PIocv6oj.jpg	t
1076	Joseph Greenwood	\N	https://image.tmdb.org/t/p/w500/7uo8tAYMXTv4qr4OqawbRZJvvW.jpg	t
1077	Russell Geoffrey Banks	\N	https://image.tmdb.org/t/p/w500/t7sIei9gwN3iqiD0pkjfm9XcRgn.jpg	t
1078	Samira Mighty	\N	https://image.tmdb.org/t/p/w500/wNSEbr9qhXKiMqDFREK87irY5X5.jpg	t
1079	Adriana Ubani	\N	https://image.tmdb.org/t/p/w500/7TlpwffkqeTu1mQNZW3OG0IdTFm.jpg	t
1080	Mariano Venancio	\N	https://image.tmdb.org/t/p/w500/aZT4jP35s7hwOspb4nW1wqKZpmE.jpg	t
1081	Damian Chapa	\N	https://image.tmdb.org/t/p/w500/MAJFUqA0FP3wbRqMSw9ALEuSgP.jpg	t
1082	Sal Lopez	\N	https://image.tmdb.org/t/p/w500/8m7m6qGjYz8TD3NhP8hGfbhgL8f.jpg	t
1083	Emilio Rivera	\N	https://image.tmdb.org/t/p/w500/pHgPJSoZVgmt4FQ8zyMVqwovpRb.jpg	t
1084	Jennifer Tilly	\N	https://image.tmdb.org/t/p/w500/jrWj0LKOLGyn8BjxCPfwxX3BXC4.jpg	t
1085	Faye Dunaway	\N	https://image.tmdb.org/t/p/w500/bwHJPkiDOjTslgrl0mri1Ndvx2V.jpg	t
1086	Joanna Pacuła	\N	https://image.tmdb.org/t/p/w500/oGzAZY8L1KjsFtFoLpsqUwvBA4k.jpg	t
1087	Ismael 'East' Carlo	\N	https://image.tmdb.org/t/p/w500/nbvlR1qmZ6MryzmY0AJfeqkTVK4.jpg	t
1088	Robert Wagner	\N	https://image.tmdb.org/t/p/w500/dgIN3MrOfX8Q4pzchO58dhMgrFb.jpg	t
1089	Gary Busey	\N	https://image.tmdb.org/t/p/w500/8H7Hlv6b7ZoK4jZKeLnc2i4pfPL.jpg	t
1090	Stacy Keach	\N	https://image.tmdb.org/t/p/w500/gtYepb7Vu9bXcdZ62PXm56KalNl.jpg	t
1091	Bolek Polívka	\N	https://image.tmdb.org/t/p/w500/gQ40joDui2BoDrMplvGERa1WVQC.jpg	t
1092	Miroslav Krobot	\N	https://image.tmdb.org/t/p/w500/8xq3PCCUBXjJDqF9Kz0abOmo9eg.jpg	t
1093	Karel Heřmánek	\N	https://image.tmdb.org/t/p/w500/zOeRUuWXRFeRr7PQ4nBVzTR8AAv.jpg	t
1094	Marián Geišberg	\N	https://image.tmdb.org/t/p/w500/v9i30AFRSIrglaGL9J48QcP5Y3s.jpg	t
1095	Jenovéfa Boková	\N	https://image.tmdb.org/t/p/w500/nBswYnMu0nq0sIqlEoVY5fo2THG.jpg	t
1096	Vojtěch Dyk	\N	https://image.tmdb.org/t/p/w500/iZSCwsHIlugbo8puYwqsx4ayBc2.jpg	t
1097	Richard Genzer	\N	https://image.tmdb.org/t/p/w500/n9MmOTnCwVL7K3dVuykOKbJXtfi.jpg	t
1098	Zuzana Bydžovská	\N	https://image.tmdb.org/t/p/w500/lNX2K7dOOuO5VcQJnagyQRVpHWc.jpg	t
1099	Lucie Žáčková	\N	https://image.tmdb.org/t/p/w500/fYHMZHjAam6mHHy0Js3WGXQDXks.jpg	t
1100	Jana Hubinská	\N	https://image.tmdb.org/t/p/w500/y99OsKri7LfJmpwKRoCWcdXsyjV.jpg	t
1101	Vera Farmiga	\N	https://image.tmdb.org/t/p/w500/5Vs7huBmTKftwlsc2BPAntyaQYj.jpg	t
1102	Patrick Wilson	\N	https://image.tmdb.org/t/p/w500/oym6H2QD9esk4yABjCHaUoNAOa8.jpg	t
1103	Mia Tomlinson	\N	https://image.tmdb.org/t/p/w500/9OoCftD6TAImFAUnvSC445toavW.jpg	t
1104	Ben Hardy	\N	https://image.tmdb.org/t/p/w500/s8UEIomgY5AaEmPHkcPAScp68Fw.jpg	t
1105	Rebecca Calder	\N	https://image.tmdb.org/t/p/w500/A43USnarLnfWXDvWimT24cPVfEm.jpg	t
1106	Tilly Walker	\N	https://image.tmdb.org/t/p/w500/wd9La2PfiSP9CsU4BwlNHqXfDn6.jpg	t
1107	Elliot Cowan	\N	https://image.tmdb.org/t/p/w500/zxewsfDGYuCqV7gsZjMQct6BXMJ.jpg	t
1108	Shannon Kook	\N	https://image.tmdb.org/t/p/w500/gBJmrtY2fBFfkQRfosLv2MNWx2J.jpg	t
1109	Steve Coulter	\N	https://image.tmdb.org/t/p/w500/ng01ren9pCYPIsIwRqC1xHzD5IG.jpg	t
1110	Kíla Lord Cassidy	\N	https://image.tmdb.org/t/p/w500/7vUPASAuPkgfXzS9DQhOo9uTLJc.jpg	t
1111	Tyriq Withers	\N	https://image.tmdb.org/t/p/w500/lwdIoyA2V9cAQf8rWDijINLsA9O.jpg	t
1112	Marlon Wayans	\N	https://image.tmdb.org/t/p/w500/q1EtfxvhHZsDQmPDEkdWBkC8D1e.jpg	t
1113	Julia Fox	\N	https://image.tmdb.org/t/p/w500/cuRGm9ySxto57ifv3tSAYhOLAYA.jpg	t
1114	Tim Heidecker	\N	https://image.tmdb.org/t/p/w500/69VjM9RFHtRemMwXW2OXOhIGUbj.jpg	t
1115	Jim Jefferies	\N	https://image.tmdb.org/t/p/w500/nUt41YMX6tHcyrHHlH6UMs2tZ9n.jpg	t
1116	Maurice Greene	\N	\N	t
1117	Indira G. Wilson	\N	https://image.tmdb.org/t/p/w500/gyeCcXt7PClDMdSCWhY5fbbZfvX.jpg	t
1118	Geron McKinley	\N	https://image.tmdb.org/t/p/w500/skKXiAXVfmA3QvQokIvmitIER0R.jpg	t
1119	Heather Lynn Harris	\N	https://image.tmdb.org/t/p/w500/qs69xPdHT7J6aidniRQy2Lo6ree.jpg	t
1120	Don Benjamin	\N	https://image.tmdb.org/t/p/w500/2b2ucpNuiTxFfPAWk2DDjyP79gL.jpg	t
1121	Jeremy Renner	\N	https://image.tmdb.org/t/p/w500/yB84D1neTYXfWBaV0QOE9RF2VCu.jpg	t
1122	Tom Hiddleston	\N	https://image.tmdb.org/t/p/w500/mclHxMm8aPlCPKptP67257F5GPo.jpg	t
1123	Cobie Smulders	\N	https://image.tmdb.org/t/p/w500/1b0mYokcGsfFRge4bjXlS5ihtek.jpg	t
1124	Stellan Skarsgård	\N	https://image.tmdb.org/t/p/w500/x78BtYHElirO7Iw8bL4m8CnzRDc.jpg	t
1125	Ryan Reynolds	\N	https://image.tmdb.org/t/p/w500/trzgptffGvAlAT6MEu01fz47cLW.jpg	t
1126	Hugh Jackman	\N	https://image.tmdb.org/t/p/w500/4Xujtewxqt6aU0Y81tsS9gkjizk.jpg	t
1127	Emma Corrin	\N	https://image.tmdb.org/t/p/w500/wqGOVOsHzZaHeHymIS40elGCnY0.jpg	t
1128	Matthew Macfadyen	\N	https://image.tmdb.org/t/p/w500/wjzFvujqF5KuHoIGLOjk6FCiSYJ.jpg	t
1129	Dafne Keen	\N	https://image.tmdb.org/t/p/w500/g325OIjIHrFr0te8ewPfhKQ2SKj.jpg	t
1130	Jon Favreau	\N	https://image.tmdb.org/t/p/w500/tnx7iMVydPQXGOoLsxXl84PXtbA.jpg	t
1131	Morena Baccarin	\N	https://image.tmdb.org/t/p/w500/Hiv9zroKS0LhjAbKFQoz0BpzCe.jpg	t
1132	Rob Delaney	\N	https://image.tmdb.org/t/p/w500/xirfT1znRkkughLiPemKu3NhkKQ.jpg	t
1133	Leslie Uggams	\N	https://image.tmdb.org/t/p/w500/peLaqLcs3y2WY4TbrLOXQGt9I8S.jpg	t
1134	Jennifer Garner	\N	https://image.tmdb.org/t/p/w500/ftymEXqdTnXfaI6dGd9qrJoFOSE.jpg	t
1135	Horacio García Rojas	\N	https://image.tmdb.org/t/p/w500/75Yo3FmhEOZhMzP0ImYQIoalurn.jpg	t
1136	Álvaro Morte	\N	https://image.tmdb.org/t/p/w500/2TGPhdpRC5wjdFEJqnLYiN5kbwg.jpg	t
1137	Omar Chaparro	\N	https://image.tmdb.org/t/p/w500/fAIDrbtyHBcDDbRdRZ3bvNesKU7.jpg	t
1138	Humberto Busto	\N	https://image.tmdb.org/t/p/w500/uFFwrUoVjd2jpcx0Wu4CP1xy5fu.jpg	t
1139	Jorge R. Gutierrez	\N	https://image.tmdb.org/t/p/w500/dhL3pHR1WkbONH9dD4Sya9DbrXq.jpg	t
1140	Jesús Guzmán	\N	https://image.tmdb.org/t/p/w500/m3bbEELSWpZaF4bbyQT8e0BkF7w.jpg	t
1141	José Carlos Illanes	\N	https://image.tmdb.org/t/p/w500/ixMmAMSzs5XiGzeKfC58dZpNWYM.jpg	t
1142	Maya Zapata	\N	https://image.tmdb.org/t/p/w500/8waYezV2WB1xqS09HfNrjxnXdWE.jpg	t
1143	Teresa Ruiz	\N	https://image.tmdb.org/t/p/w500/OFOWiJXGx5958WiOuYq7YO4lst.jpg	t
1144	Matilda Lutz	\N	https://image.tmdb.org/t/p/w500/yqeYvGgDvrhvn5lP6fuRE1ImQXv.jpg	t
1145	Robert Sheehan	\N	https://image.tmdb.org/t/p/w500/1lCAN0FZeUhXZo5goabMxk5mYDl.jpg	t
1146	Wallis Day	\N	https://image.tmdb.org/t/p/w500/e4l3KndNgzjdVWfZs3T3rniHZxs.jpg	t
1147	Luke Pasqualino	\N	https://image.tmdb.org/t/p/w500/egwyqohJ3KLag4GUyTzXGngwTc1.jpg	t
1148	Martyn Ford	\N	https://image.tmdb.org/t/p/w500/uO7T7QiiUZT9PDXo5MKfEnbxTPk.jpg	t
1149	Eliza Matengu	\N	https://image.tmdb.org/t/p/w500/eTlEoKGkaczAzmEyQMmliHGcVUh.jpg	t
1150	Danica Davis	\N	\N	t
1151	Joana Nwamerue	\N	\N	t
1152	Manal El-Feitury	\N	https://image.tmdb.org/t/p/w500/zRs4USVkkKInhI1ZRcrkuKIfAM3.jpg	t
1153	Paul Kircher	\N	https://image.tmdb.org/t/p/w500/nHScigi0COVtSHKqxx4MQF6WyzZ.jpg	t
1154	Vincent Lacoste	\N	https://image.tmdb.org/t/p/w500/upqVzTnXiIwONCzzfT4CZkwvZ08.jpg	t
1155	Juliette Binoche	\N	https://image.tmdb.org/t/p/w500/llNGfF2gNBa1l39iqmjhZuDDzn6.jpg	t
1156	Erwan Kepoa Falé	\N	https://image.tmdb.org/t/p/w500/71M7IhJjEZTWFedeVOv1LMZlvyC.jpg	t
1157	Christophe Honoré	\N	https://image.tmdb.org/t/p/w500/vhRdx5xeSjlB6lPfXsnc0L3g02g.jpg	t
1158	Adrien Casse	\N	\N	t
1159	Pascal Cervo	\N	https://image.tmdb.org/t/p/w500/cAQMLCj6fA8WzffHKhdxu7GQFAR.jpg	t
1160	Anne Kessler	\N	https://image.tmdb.org/t/p/w500/8uQwzp7p9cXduFJ1TdQ4jC0THGA.jpg	t
1161	Elliot Jenicot	\N	\N	t
1162	Isabelle Thevenoux	\N	\N	t
1163	Jackie Chan	\N	https://image.tmdb.org/t/p/w500/nraZoTzwJQPHspAVsKfgl3RXKKa.jpg	t
1164	Joshua Jackson	\N	https://image.tmdb.org/t/p/w500/mH2a5YFd8J7upjjWwEzM75vitA2.jpg	t
1165	Sadie Stanley	\N	https://image.tmdb.org/t/p/w500/zfjr9nkUTWJ2EekyiWmYdxscrSJ.jpg	t
1166	Ming-Na Wen	\N	https://image.tmdb.org/t/p/w500/eqCzFF83It56cUdjpskzvg8jgq.jpg	t
1167	Wyatt Oleff	\N	https://image.tmdb.org/t/p/w500/9i2EuZz7Oh2zOV6Y2ijThW94MeM.jpg	t
1168	Aramis Knight	\N	https://image.tmdb.org/t/p/w500/l1w7atqr6aJuxwzcM4soZ9ZWBJc.jpg	t
1169	Ralph Macchio	\N	https://image.tmdb.org/t/p/w500/AoqqL9UlyPrcTLnpzbQvKXPvXrz.jpg	t
1170	Olivia Yang Avis	\N	https://image.tmdb.org/t/p/w500/pivh0T464SptIRJnioEUmv2331P.jpg	t
1171	Aaron Wang	\N	\N	t
1172	Hugo Kovács	\N	\N	t
1173	Tatiana Dyková	\N	https://image.tmdb.org/t/p/w500/3JYxGajhsu6oIjnZHVMvAhxGnPk.jpg	t
1174	David Novotný	\N	https://image.tmdb.org/t/p/w500/ugtOkVgF2y3QDZ1prEDNJLZ39BQ.jpg	t
1175	Eliška Křenková	\N	https://image.tmdb.org/t/p/w500/a7FhXyFanqx6oPNg7kCtsFk2YoP.jpg	t
1176	Jiří Bartoška	\N	https://image.tmdb.org/t/p/w500/vCA91vwuwBm7KaFO6Mh21iuiWOt.jpg	t
1177	Simona Babčáková	\N	https://image.tmdb.org/t/p/w500/scXZKeJ0GJn7smzggmjMn6Dp1Rt.jpg	t
1178	Klára Melíšková	\N	https://image.tmdb.org/t/p/w500/pYYZDi6oJZI9UQPkaYT5i4KSj48.jpg	t
1179	Martha Issová	\N	https://image.tmdb.org/t/p/w500/7FT9hHhtFyeNkVMzXwNim7A1Rry.jpg	t
1180	Jiří Macháček	\N	https://image.tmdb.org/t/p/w500/lHRSWb6WEwC3HXzI5iFILguiBUB.jpg	t
1181	Prokop Zach	\N	https://image.tmdb.org/t/p/w500/lcC3BFvYomJfUMXRVTOfSch7aO.jpg	t
1182	Michelle Rodríguez	\N	https://image.tmdb.org/t/p/w500/wVcbrae4eRqGMFZz8Eh52Dl1biP.jpg	t
1183	Giovanni Ribisi	\N	https://image.tmdb.org/t/p/w500/nABPeuB360wvWnVMqgpJHq6wHFz.jpg	t
1184	Wes Studi	\N	https://image.tmdb.org/t/p/w500/dAO2bY2NCceYLZiJaBjBdY19Hox.jpg	t
1185	Laz Alonso	\N	https://image.tmdb.org/t/p/w500/nmgOd3X2Xn3jIp9OLCRJzLExRWN.jpg	t
1186	Joseph Gordon-Levitt	\N	https://image.tmdb.org/t/p/w500/4U9G4YwTlIEbAymBaseltS38eH4.jpg	t
1187	Ken Watanabe	\N	https://image.tmdb.org/t/p/w500/w2t30L5Cmr34myAaUobLoSgsLfS.jpg	t
1188	Tom Hardy	\N	https://image.tmdb.org/t/p/w500/d81K0RH8UX7tZj49tZaQhZ9ewH.jpg	t
1189	Elliot Page	\N	https://image.tmdb.org/t/p/w500/eCeFgzS8dYHnMfWQT0oQitCrsSz.jpg	t
1190	Dileep Rao	\N	https://image.tmdb.org/t/p/w500/jRNn8SZqFXuI5wOOlHwYsWh0hXs.jpg	t
1191	Tom Berenger	\N	https://image.tmdb.org/t/p/w500/zLxzAdAfu7y02yEx29JSLDgXJZ4.jpg	t
1192	Marion Cotillard	\N	https://image.tmdb.org/t/p/w500/biitzOF0GffIqFYLyOPkoiaOngQ.jpg	t
1193	Pete Postlethwaite	\N	https://image.tmdb.org/t/p/w500/4RxwgdF1WXKjXaaAXIWeFqtMWfD.jpg	t
1194	Craig T. Nelson	\N	https://image.tmdb.org/t/p/w500/rMh8qdexFKmc7mq7oLzsLLvCCjs.jpg	t
1195	Holly Hunter	\N	https://image.tmdb.org/t/p/w500/kC7KX03VAWvogOCuwKbMo4V6TuU.jpg	t
1196	Sarah Vowell	\N	https://image.tmdb.org/t/p/w500/dP1hMYTk2q4voIUxtgmvD81nMty.jpg	t
1197	Spencer Fox	\N	https://image.tmdb.org/t/p/w500/vMyWK5qZWEG0GZh4FXCDXx4Jqfm.jpg	t
1198	Jason Lee	\N	https://image.tmdb.org/t/p/w500/64tEXo3xR9IFXsIJKSlJ2LUrrEA.jpg	t
1199	Elizabeth Peña	\N	https://image.tmdb.org/t/p/w500/uyUrPmtbwiGFOq8pIfYVQYgmBmK.jpg	t
1200	Eli Fucile	\N	https://image.tmdb.org/t/p/w500/pcNfD0mIB9KrQMaXP0rN82VbiHY.jpg	t
1201	Maeve Andrews	\N	\N	t
1202	Brad Bird	\N	https://image.tmdb.org/t/p/w500/z73rItPBDoRUowY5kuWDMlue3DB.jpg	t
1203	Josephine Langford	\N	https://image.tmdb.org/t/p/w500/p0vn5FK4JZpfIC0DrtFCqDsV7nB.jpg	t
1204	Hero Fiennes Tiffin	\N	https://image.tmdb.org/t/p/w500/2pse7PE43N14daytdOKxyNyvar0.jpg	t
1205	Shane Paul McGhie	\N	https://image.tmdb.org/t/p/w500/xrW5ioE8lihmmuu1ov1wWBpOWYp.jpg	t
1206	Khadijha Red Thunder	\N	https://image.tmdb.org/t/p/w500/AggU4kVZ04OjKYM4ZZg1pqVVu8F.jpg	t
1207	Dylan Arnold	\N	https://image.tmdb.org/t/p/w500/aeEErE7FcRbGkpxRRkGVdObB7j1.jpg	t
1208	Samuel Larsen	\N	https://image.tmdb.org/t/p/w500/a9AQOsvl0IUHe23sz7wYsgHFBn4.jpg	t
1209	Selma Blair	\N	https://image.tmdb.org/t/p/w500/2rO5eN6hDB0JxMMZHxNKEuMRm1m.jpg	t
1210	Pia Mia	\N	https://image.tmdb.org/t/p/w500/4klv1dkVPxwWoUVcKa4NBOAEJvl.jpg	t
1211	Swen Temmel	\N	https://image.tmdb.org/t/p/w500/z6zLmf3PBsTGMU3RBnguAqfHUn3.jpg	t
1212	Billy Barratt	\N	https://image.tmdb.org/t/p/w500/h8XlTs26su2Rg3oLtShERYEnVc6.jpg	t
1213	Sally Hawkins	\N	https://image.tmdb.org/t/p/w500/1dtDq82dM2YQ17lBL4ZKPJo5LKw.jpg	t
1214	Mischa Heywood	\N	https://image.tmdb.org/t/p/w500/j2UwxVdyhK7q58A3fdTFalQB7jf.jpg	t
1215	Jonah Wren Phillips	\N	https://image.tmdb.org/t/p/w500/zBy4aBLg10Qz8di9P12mBpnf97F.jpg	t
1216	Stephen Phillips	\N	https://image.tmdb.org/t/p/w500/cHHJDSm18g18s5t44nKBmq6FQtF.jpg	t
1217	Sally-Anne Upton	\N	https://image.tmdb.org/t/p/w500/iwaFfln6gKuedwF5FjgAO60KJDd.jpg	t
1218	Sora Wong	\N	https://image.tmdb.org/t/p/w500/lh2fvJyAn5pX9EQU1jMUMxUl5d1.jpg	t
1219	Kathryn Adams	\N	\N	t
1220	Brian Godfrey	\N	\N	t
1221	Brendan Bacon	\N	https://image.tmdb.org/t/p/w500/uTBjeGPq3JJKbVyWYR5XtEkotvU.jpg	t
1222	Steve Carell	\N	https://image.tmdb.org/t/p/w500/ULqKHMosznI7U2JyRZYMvSxUvq.jpg	t
1223	Will Ferrell	\N	https://image.tmdb.org/t/p/w500/vL1QjMdMtuM2f8fQZzei6WAvicZ.jpg	t
1224	Sofía Vergara	\N	https://image.tmdb.org/t/p/w500/l79eVtn6bSOaiq7R0UGu60foMrK.jpg	t
1225	Miranda Cosgrove	\N	https://image.tmdb.org/t/p/w500/qIGeoyXEVu1LxTH34TWx1YSHyQr.jpg	t
1226	Dana Gaier	\N	https://image.tmdb.org/t/p/w500/hw3Ou8cj22MLXl8QKrL8vcidcCB.jpg	t
1227	Madison Polan	\N	https://image.tmdb.org/t/p/w500/rFlA9iYyefyFTWv1YIMdMoUFgfZ.jpg	t
1228	Pierre Coffin	\N	https://image.tmdb.org/t/p/w500/eAA9uWRqHlm1LT3nZfXb7UuPfVb.jpg	t
1229	Chris Renaud	\N	https://image.tmdb.org/t/p/w500/sumBJgBqRkK4XEJ2JYXpad3MTJs.jpg	t
1230	Steve Coogan	\N	https://image.tmdb.org/t/p/w500/tT7OXc2qA6hlREHXdwGLp0XihzA.jpg	t
1231	Michael B. Jordan	\N	https://image.tmdb.org/t/p/w500/515xNvaMC6xOEOlo0sFqW69ZqUH.jpg	t
1232	Hailee Steinfeld	\N	https://image.tmdb.org/t/p/w500/3Zfp2akzycKEgUotP4DEJgOPqVj.jpg	t
1233	Miles Caton	\N	https://image.tmdb.org/t/p/w500/5uG9uoRn6THwZpEN4EHawdIf9uX.jpg	t
1234	Jack O'Connell	\N	https://image.tmdb.org/t/p/w500/9RrqnB1BRaWWHEjlWVVAna0sdBB.jpg	t
1235	Wunmi Mosaku	\N	https://image.tmdb.org/t/p/w500/yWM19CjCv66MqNkwHBp6Dpvtn9x.jpg	t
1236	Jayme Lawson	\N	https://image.tmdb.org/t/p/w500/ntwbhdUeW8K5KYJENqyiSZcsIj9.jpg	t
1237	Omar Benson Miller	\N	https://image.tmdb.org/t/p/w500/adlrkEpxDIcpxF7bpzMGErLxeHP.jpg	t
1238	Delroy Lindo	\N	https://image.tmdb.org/t/p/w500/kLwUBBmEIdchrLqwsYzgLB2B6q5.jpg	t
1239	Li Jun Li	\N	https://image.tmdb.org/t/p/w500/n0Pys3SLZ56nM9FmBQYMVCbf9Jf.jpg	t
1240	Yao	\N	https://image.tmdb.org/t/p/w500/hRMKy14F6zvDnwM3nRGOCVMTDmQ.jpg	t
1241	Jodie Comer	\N	https://image.tmdb.org/t/p/w500/ye7rdpq4KY7c0OqfRqeWMUZaneb.jpg	t
1242	Alfie Williams	\N	https://image.tmdb.org/t/p/w500/wqfyAhZH6uCu5J4THsz2gJxsizB.jpg	t
1243	Aaron Taylor-Johnson	\N	https://image.tmdb.org/t/p/w500/pFtHhih2XEaFaD3qOFyQW6q83br.jpg	t
1244	Ralph Fiennes	\N	https://image.tmdb.org/t/p/w500/u29BOqiV5GCQ8k8WUJM50i9xlBf.jpg	t
1245	Edvin Ryding	\N	https://image.tmdb.org/t/p/w500/bzecSnoxJJrax5PjdDupdPivt1F.jpg	t
1246	Christopher Fulford	\N	https://image.tmdb.org/t/p/w500/2n73aEyiU4fJprC2vHIf0M7YJ62.jpg	t
1247	Stella Gonet	\N	https://image.tmdb.org/t/p/w500/cUmDfX4fNvtAl5199HUc29ZDsAc.jpg	t
1248	Chi Lewis-Parry	\N	https://image.tmdb.org/t/p/w500/eS5mcqDMYtwHJ8lnwXkIjkz88WO.jpg	t
1249	Rocco Haynes	\N	\N	t
1250	Mary Mendum	\N	https://image.tmdb.org/t/p/w500/uaXtudO7PzqmPfONg7Zpw5uFy77.jpg	t
1251	Eric Edwards	\N	https://image.tmdb.org/t/p/w500/nNVKkGKBw3XJ4tw4KYV6OTBElix.jpg	t
1252	Cathja Graff	\N	\N	t
1253	Anita Ericsson	\N	https://image.tmdb.org/t/p/w500/uRKp8NODk3RZsYIhS4LrPg6rPoQ.jpg	t
1254	Anita Redling	\N	\N	t
1255	Anna Haarla	\N	\N	t
1256	Håkan Sjöberg	\N	\N	t
1257	Maj Bodingh	\N	\N	t
1258	John Cena	\N	https://image.tmdb.org/t/p/w500/rgB2eIOt7WyQjdgJCOuESdDlrjg.jpg	t
1259	Priyanka Chopra Jonas	\N	https://image.tmdb.org/t/p/w500/stEZxIVAWFlrifbWkeULsD4LHnf.jpg	t
1260	Paddy Considine	\N	https://image.tmdb.org/t/p/w500/rui7HJUi2TzqMh2GQJ1bcQzr8M0.jpg	t
1261	Carla Gugino	\N	https://image.tmdb.org/t/p/w500/7lSH5LOexOHwvt9lOTsLTbXdU1G.jpg	t
1262	Stephen Root	\N	https://image.tmdb.org/t/p/w500/2Zwi6AydqQQ9InVdhjYcfJXNzkp.jpg	t
1263	Jack Quaid	\N	https://image.tmdb.org/t/p/w500/320qW5yEbxpmyxQ3evmClJbtKag.jpg	t
1264	Richard Coyle	\N	https://image.tmdb.org/t/p/w500/pW7dJLmR3PuL4T1eVGa5iixPHGZ.jpg	t
1265	Александр Кузнецов	\N	https://image.tmdb.org/t/p/w500/hFrl2Sp1tOcNIpfIpP6M2QMDjyp.jpg	t
1266	Rodolfo Sancho	\N	https://image.tmdb.org/t/p/w500/cZyfkakNsGpB0S2aAoWkBB8M14H.jpg	t
1267	Tábata Cerezo	\N	https://image.tmdb.org/t/p/w500/lQaLeSkFMrFL2EGjEFsss9C4ALr.jpg	t
1268	Natalia Verbeke	\N	https://image.tmdb.org/t/p/w500/szL5HDE6s1mmGyuLBxcvTiMYZnA.jpg	t
1269	Ruth Gabriel	\N	https://image.tmdb.org/t/p/w500/uA7GCIIrf3kcYEli59c2vxWNXi6.jpg	t
1270	Roque Ruiz	\N	https://image.tmdb.org/t/p/w500/gFqTohsGfgXcx2Vhghuir9eYBTR.jpg	t
1271	Lluís Oliver	\N	\N	t
1272	Chase Sui Wonders	\N	https://image.tmdb.org/t/p/w500/e89eEhNUIfMawLNdJ3jXft8AAMF.jpg	t
1273	Madelyn Cline	\N	https://image.tmdb.org/t/p/w500/5bn1dx7IyOZpy6g1T9M4E7jXr9E.jpg	t
1274	Sarah Pidgeon	\N	https://image.tmdb.org/t/p/w500/wMj4WykLKTc6iHIYiXnho6jeYN1.jpg	t
1275	Jennifer Love Hewitt	\N	https://image.tmdb.org/t/p/w500/kRySMLtckE7tl6136y0yzFYpUfE.jpg	t
1276	Freddie Prinze Jr.	\N	https://image.tmdb.org/t/p/w500/8V9yNBjCNRBKROyjCLKLJGcCBdG.jpg	t
1277	Sarah Michelle Gellar	\N	https://image.tmdb.org/t/p/w500/mr74lbU9MLcYV4aQDsfHp7rnwS4.jpg	t
1278	Gabbriette	\N	https://image.tmdb.org/t/p/w500/ej4Hp5WWwjWFeexvDyOKr2Aaz2k.jpg	t
1279	Joshua Orpin	\N	https://image.tmdb.org/t/p/w500/AxiM2M1lWIG95ThDkT3hM1FzoA.jpg	t
1280	Elle Fanning	\N	https://image.tmdb.org/t/p/w500/e8CUyxQSE99y5IOfzSLtHC0B0Ch.jpg	t
1281	Dimitrius Schuster-Koloamatangi	\N	https://image.tmdb.org/t/p/w500/rmIZTT1AZK3C9fYhEOtGKtSrF8E.jpg	t
1282	Michael Homick	\N	https://image.tmdb.org/t/p/w500/a7IFYVtmNvBMJ7c20BVMc0LX6PT.jpg	t
1283	Alison Brie	\N	https://image.tmdb.org/t/p/w500/uu16GiwYblS6IJV3o4qFSLWKXOC.jpg	t
1284	Damon Herriman	\N	https://image.tmdb.org/t/p/w500/wMCYFY8qzKEvg9Jq6cQmLnHHyLl.jpg	t
1285	Mia Morrissey	\N	https://image.tmdb.org/t/p/w500/ml23SclsBZ5rUWTp6lI6thCiIyW.jpg	t
1286	Karl Richmond	\N	https://image.tmdb.org/t/p/w500/zQ32YJZzMwAQrZ8F1Cjqc6560gh.jpg	t
1287	Jack Kenny	\N	https://image.tmdb.org/t/p/w500/v3A8RFnCNVloc7GIptPfSuJkhdp.jpg	t
1288	Francesca Waters	\N	https://image.tmdb.org/t/p/w500/z0zXS5qNuts4sJmf1KFNhmDWMIZ.jpg	t
1289	Aljin Abella	\N	https://image.tmdb.org/t/p/w500/mAsuTXH9xflaBUBYo3roUuV2bss.jpg	t
1290	Sarah Lang	\N	\N	t
1291	Rob Brown	\N	\N	t
1292	Jim Carrey	\N	https://image.tmdb.org/t/p/w500/u0AqTz6Y7GHPCHINS01P7gPvDSb.jpg	t
1293	Ben Schwartz	\N	https://image.tmdb.org/t/p/w500/lJVYjPj0P6uvVxNrTy4xO2645D0.jpg	t
1294	Colleen O'Shaughnessey	\N	https://image.tmdb.org/t/p/w500/y3Kl5tCX1XD6uyL9wefTRbEXTwj.jpg	t
1295	James Marsden	\N	https://image.tmdb.org/t/p/w500/lf7OnfKZnMgNh9b98764tqSocGK.jpg	t
1296	Tika Sumpter	\N	https://image.tmdb.org/t/p/w500/1zTXufyuQFPXVthryH7KVoZAfb7.jpg	t
1297	Lee Majdoub	\N	https://image.tmdb.org/t/p/w500/vpF3R2YRCGHseGevmDAhftmOPkO.jpg	t
1298	Krysten Ritter	\N	https://image.tmdb.org/t/p/w500/d39VsFGyWq7f5fkUrCI9k3XpZl2.jpg	t
1299	Adam Pally	\N	https://image.tmdb.org/t/p/w500/yY13PEaVbPoXT5MkitVxTfdAZnU.jpg	t
1300	Ian McKellen	\N	https://image.tmdb.org/t/p/w500/5cnnnpnJG6TiYUSS7qgJheUZgnv.jpg	t
1301	Viggo Mortensen	\N	https://image.tmdb.org/t/p/w500/vH5gVSpHAMhDaFWfh0Q7BG61O1y.jpg	t
1302	Sean Astin	\N	https://image.tmdb.org/t/p/w500/ywH1VvdwqlcnuwUVr0pV0HUZJQA.jpg	t
1303	Ian Holm	\N	https://image.tmdb.org/t/p/w500/cOJDgvgj4nMec6Inzj1H5nugTO5.jpg	t
1304	Liv Tyler	\N	https://image.tmdb.org/t/p/w500/aYlqS4wYuNCiN9wmvDwKRAE9BQ9.jpg	t
1305	Billy Boyd	\N	https://image.tmdb.org/t/p/w500/uiWlsIOakNnUgda21PJF9wswzEJ.jpg	t
1306	Dominic Monaghan	\N	https://image.tmdb.org/t/p/w500/lOWmAvBu6evsj9MCcIHqy7Sg3iZ.jpg	t
1307	Susan Lorincz	\N	\N	t
1308	Ajike Owens	\N	\N	t
1309	Ron Livingston	\N	https://image.tmdb.org/t/p/w500/pr5CjWnkaf5WKTIYh8wtNufjmyb.jpg	t
1310	Lili Taylor	\N	https://image.tmdb.org/t/p/w500/vWcMUi3QyvCr3QuFbjtwyPx7WtU.jpg	t
1311	Joey King	\N	https://image.tmdb.org/t/p/w500/jUuKlP1hjPJ6R0d6MhUytr85oRL.jpg	t
1312	Shanley Caswell	\N	https://image.tmdb.org/t/p/w500/yySEoaskedLZKKHSAOOZ5cr7HHo.jpg	t
1313	Hayley McFarland	\N	https://image.tmdb.org/t/p/w500/x2JAEC10XI6Ie2sArUzMbe4l2Mh.jpg	t
1314	John Brotherton	\N	https://image.tmdb.org/t/p/w500/9LX6rRtiCjkTMT30PJh1dg1jx56.jpg	t
1315	Ginnifer Goodwin	\N	https://image.tmdb.org/t/p/w500/xOCA2WN5MRfXmJmlzEbFEhIbfIQ.jpg	t
1316	Jason Bateman	\N	https://image.tmdb.org/t/p/w500/8e6mt0vGjPo6eW52gqRuXy5YnfN.jpg	t
1317	Jenny Slate	\N	https://image.tmdb.org/t/p/w500/hqLygFKiylb1hchgu113NP5r7iM.jpg	t
1318	Nate Torrence	\N	https://image.tmdb.org/t/p/w500/yT9o149xPygdY0NsF9sNgiQwuru.jpg	t
1319	Bonnie Hunt	\N	https://image.tmdb.org/t/p/w500/tT9C6uLztgN8OxJULq6F9iEzqlA.jpg	t
1320	Don Lake	\N	https://image.tmdb.org/t/p/w500/zVcMF2Jtv1W3mvzYDE3JiFfw2PG.jpg	t
1321	Tommy Chong	\N	https://image.tmdb.org/t/p/w500/4jCJpbssCSGc5jhmrBMoGvWNQDf.jpg	t
1322	J.K. Simmons	\N	https://image.tmdb.org/t/p/w500/ScmKoJ9eiSUOthAt1PDNLi8Fkw.jpg	t
1323	Tyrese Gibson	\N	https://image.tmdb.org/t/p/w500/jxoy4fbXNKFQtBdK73cLXEz3ufS.jpg	t
1324	Ludacris	\N	https://image.tmdb.org/t/p/w500/erkJijujhe48vhJ8iCEtVpNEeVn.jpg	t
1325	Nathalie Emmanuel	\N	https://image.tmdb.org/t/p/w500/uh8EIhxKJxK7xsJlWcIgBkqyAKq.jpg	t
1326	Jordana Brewster	\N	https://image.tmdb.org/t/p/w500/ceL0zxeVbWfCfhoIDZIE1NYqBWb.jpg	t
1327	Sung Kang	\N	https://image.tmdb.org/t/p/w500/ox4ti0WmpJoN19n3iYJ2T2vHP5f.jpg	t
1328	William Moseley	\N	https://image.tmdb.org/t/p/w500/6HTpmCaGhtLEY6OUhRaXYgldb0x.jpg	t
1329	Anna Popplewell	\N	https://image.tmdb.org/t/p/w500/ooYeKc28Ayqo9KW8gOacDXDghVL.jpg	t
1330	Skandar Keynes	\N	https://image.tmdb.org/t/p/w500/pIdgY16c6AzmCD31pXlCR9SjLlM.jpg	t
1331	Georgie Henley	\N	https://image.tmdb.org/t/p/w500/dW7ZQfrm2A4rVtZrIPbWOUXNvsJ.jpg	t
1332	Tilda Swinton	\N	https://image.tmdb.org/t/p/w500/9FPPOP8KEWD3PTNXJcZJYN4quU4.jpg	t
1333	James McAvoy	\N	https://image.tmdb.org/t/p/w500/vB6qYlFXgONGVwwxWXE4gf0F8SQ.jpg	t
1334	Jim Broadbent	\N	https://image.tmdb.org/t/p/w500/jTyvGwwR1NFpvgDhcmuWZCM241w.jpg	t
1335	Ray Winstone	\N	https://image.tmdb.org/t/p/w500/kDShEv6zPfArgcwXliGWKR65Mmo.jpg	t
1336	Ayushmann Khurrana	\N	https://image.tmdb.org/t/p/w500/qbdclvnDkJxPX7OQqmMY7w9ekBP.jpg	t
1337	Rashmika Mandanna	\N	https://image.tmdb.org/t/p/w500/c1wQq0OAzU9nFhGYn4iOoi7dmqD.jpg	t
1338	Nawazuddin Siddiqui	\N	https://image.tmdb.org/t/p/w500/mnHjlcI0CpkrBN9c3njfJtuLDKZ.jpg	t
1339	Paresh Rawal	\N	https://image.tmdb.org/t/p/w500/haRliZNMm04QXItBGScbFh4bHSJ.jpg	t
1340	Faisal Malik	\N	https://image.tmdb.org/t/p/w500/eztI7Y1VUqHz7OYZ4ytoyEz0amz.jpg	t
1341	गीता अग्रवाल शर्मा	\N	https://image.tmdb.org/t/p/w500/5Jrwb9zWG2Hjmf8PQLuDmCKnMHG.jpg	t
1342	Rachit Singh	\N	\N	t
1343	Raj Premi	\N	https://image.tmdb.org/t/p/w500/u1jaLBcB6DHqzPYHjTdcAxuOHnR.jpg	t
1344	Varun Dhawan	\N	https://image.tmdb.org/t/p/w500/gvvXYTpvO0Tu7naCDLL3tInyN2R.jpg	t
1345	Sathyaraj	\N	https://image.tmdb.org/t/p/w500/lnlBZ7V3K3Z3OIsjCd0zkKx26L3.jpg	t
1346	Michael Jai White	\N	https://image.tmdb.org/t/p/w500/YPoHYuzR37wFpPpwEXZYQlhLln.jpg	t
1347	Louis Mandylor	\N	https://image.tmdb.org/t/p/w500/skvNBR83wxjbFj6XuLxWAhCZTmh.jpg	t
1348	Gillian White	\N	https://image.tmdb.org/t/p/w500/sMeG4f1Opc2ivxOFehTHikWyCZl.jpg	t
1349	Gabriella Quezada	\N	https://image.tmdb.org/t/p/w500/fmZGEU6se9WkX4DD3ymCcAvMVJC.jpg	t
1350	Luca Oriel	\N	https://image.tmdb.org/t/p/w500/5MV9x5AbSk0oD9CnoQXZknLez5d.jpg	t
1351	Roberto 'Sanz' Sanchez	\N	https://image.tmdb.org/t/p/w500/9uRNiMcxueGxmPKqvAv6I3JEP20.jpg	t
1352	Mauricio Mendoza	\N	https://image.tmdb.org/t/p/w500/fsNHqoQ1UAS2VnSoCfh5tqMP4Bu.jpg	t
1353	Guillermo Iván	\N	https://image.tmdb.org/t/p/w500/zH8BOepVqv3l1uQvHfRyPSX65OJ.jpg	t
1354	Andy Serkis	\N	https://image.tmdb.org/t/p/w500/eNGqhebQ4cDssjVeNFrKtUvweV5.jpg	t
1355	John Noble	\N	https://image.tmdb.org/t/p/w500/t9dB8uU27sQDaEEFMiQvp5sbrXU.jpg	t
1356	David Wenham	\N	https://image.tmdb.org/t/p/w500/F7CWSqUE75HtrcdqIQ7UMZ9aTX.jpg	t
1357	Miranda Otto	\N	https://image.tmdb.org/t/p/w500/lVkzCNNGwesZjOmwrDjro6ZPar.jpg	t
1358	Geoffrey Rush	\N	https://image.tmdb.org/t/p/w500/4zQuC1j0p7HkJlfuT8aJoyZAgQm.jpg	t
1359	Orlando Bloom	\N	https://image.tmdb.org/t/p/w500/lwQoA0qJTCZ6l2FH6PjmhRQjiaB.jpg	t
1360	Jack Davenport	\N	https://image.tmdb.org/t/p/w500/shGH0YWJBfiJznidS0f2ZfN056c.jpg	t
1361	Jonathan Pryce	\N	https://image.tmdb.org/t/p/w500/zwSv5uXzPTtmitFe39UdqnVwmdL.jpg	t
1362	Lee Arenberg	\N	https://image.tmdb.org/t/p/w500/sjv8tdXzLwC8lZi6Ou6i6z5RbrW.jpg	t
1363	Mackenzie Crook	\N	https://image.tmdb.org/t/p/w500/lN96i9ez4FUrQgpYdLMYr0l3Ggy.jpg	t
1364	Damian O'Hare	\N	https://image.tmdb.org/t/p/w500/bO6TMDYluACYKy7zWEloym1SUa5.jpg	t
1365	Giles New	\N	https://image.tmdb.org/t/p/w500/e0Ap9fkLAFcxLVHpK8KH2TQV3wI.jpg	t
1366	Cynthia Erivo	\N	https://image.tmdb.org/t/p/w500/gIAXqZwZCBqkh2ppfAV4xcnMxki.jpg	t
1367	Ariana Grande	\N	https://image.tmdb.org/t/p/w500/ojr2zF46BmPe7EALds7WQf6Ro4O.jpg	t
1368	Michelle Yeoh	\N	https://image.tmdb.org/t/p/w500/nrbHNzSMydpWK9um5VqWIFJihB5.jpg	t
1369	Ethan Slater	\N	https://image.tmdb.org/t/p/w500/xIgqyrM78FPt7Pb2Vv3IvJcnOWS.jpg	t
1370	Marissa Bode	\N	https://image.tmdb.org/t/p/w500/3ZoBNPpXsM35HrGMkRxU9Ez5YR0.jpg	t
1371	Jeff Goldblum	\N	https://image.tmdb.org/t/p/w500/ceSmXnD0FUSTaq2WIrnZu9caL0t.jpg	t
1372	Andy Nyman	\N	https://image.tmdb.org/t/p/w500/9bN9RVoPWmsmV3VBI7hp4VKD9Kg.jpg	t
1373	Courtney Mae-Briggs	\N	https://image.tmdb.org/t/p/w500/ofOEXvhJpbFV7v8ZnH0ztTPGKkr.jpg	t
1374	Ben Affleck	\N	https://image.tmdb.org/t/p/w500/aTcqu8cI4wMohU17xTdqmXKTGrw.jpg	t
1375	Jon Bernthal	\N	https://image.tmdb.org/t/p/w500/o0t6EVkJOrFAjESDilZUlf46IbQ.jpg	t
1376	Cynthia Addai-Robinson	\N	https://image.tmdb.org/t/p/w500/fgXXRWLRDprVH9Bf2et0zRLk7HQ.jpg	t
1377	Allison Robertson	\N	https://image.tmdb.org/t/p/w500/77b8MAHwK2RXBO5fC4nNayqo1X2.jpg	t
1378	Alison Wright	\N	https://image.tmdb.org/t/p/w500/yVdCk5eWk5syRrBdxjrnJ1O2Rpg.jpg	t
1379	Daniella Pineda	\N	https://image.tmdb.org/t/p/w500/o8h5qbyy8A0zKTRN57YOlQOafyQ.jpg	t
1380	Robert Morgan	\N	https://image.tmdb.org/t/p/w500/dZhqn7yOmgetvM2mAWU7sEMmzu7.jpg	t
1381	Grant Harvey	\N	https://image.tmdb.org/t/p/w500/sThJJbhgjQOZNvCkHVO0g3qy78j.jpg	t
1382	Andrew Howard	\N	https://image.tmdb.org/t/p/w500/kba1JeCUYHufjB933G5xPRhO8lV.jpg	t
1383	Lexi Venter	\N	https://image.tmdb.org/t/p/w500/9QiHn5peV6eMSQwANy15zIt9sYB.jpg	t
1384	Embeth Davidtz	\N	https://image.tmdb.org/t/p/w500/nwsdu9lOsKJ5v9RwOCc7kAiuxSO.jpg	t
1385	Zikhona Bali	\N	https://image.tmdb.org/t/p/w500/9Z4O5scp8qzImhXWN4gLqMcpWBM.jpg	t
1386	Fumani Shilubana	\N	https://image.tmdb.org/t/p/w500/ilROHJrLHvjeV07YE3LSBBgOQuD.jpg	t
1387	Rob van Vuuren	\N	https://image.tmdb.org/t/p/w500/anR18fOVYc2kx3Mhk37cMldlIS5.jpg	t
1388	Anina Reed	\N	\N	t
1389	Andreas Damm	\N	https://image.tmdb.org/t/p/w500/1IOmfQgCV5BaokDws17Us2KMsHE.jpg	t
1390	Tessa Jubber	\N	https://image.tmdb.org/t/p/w500/242z5k2QUkkwyrNYXjKvK8q4eFM.jpg	t
1391	Kara du Toit	\N	\N	t
1392	Albert Pretorius	\N	https://image.tmdb.org/t/p/w500/2kOCpuPGiAD4DhOYnBlgHT6kMZ8.jpg	t
1393	Chiwetel Ejiofor	\N	https://image.tmdb.org/t/p/w500/kq5DDnqqofoRI0t6ddtRlsJnNPT.jpg	t
1394	Juno Temple	\N	https://image.tmdb.org/t/p/w500/ntBw3aUZmIw9ObmsmvPgk1UKMd8.jpg	t
1395	Rhys Ifans	\N	https://image.tmdb.org/t/p/w500/1D670EEsbky3EtO7XLG32A09p92.jpg	t
1396	Stephen Graham	\N	https://image.tmdb.org/t/p/w500/1m9RWRRkQzJEAphJm9kQhMk1r1Q.jpg	t
1397	Peggy Lu	\N	https://image.tmdb.org/t/p/w500/ng5eaDcOf9kSwIYGNmwF9wEfIHp.jpg	t
1398	Clark Backo	\N	https://image.tmdb.org/t/p/w500/d24KKFxfoql6PBsBPsejFgzhSlH.jpg	t
1399	Cristo Fernández	\N	https://image.tmdb.org/t/p/w500/irx5BVVLSQWY9m5NrhqyxPekwIY.jpg	t
1400	Jared Abrahamson	\N	https://image.tmdb.org/t/p/w500/3hShByAdCj1Qom9mXeeqJL9zu8d.jpg	t
1401	Lindsay Lohan	\N	https://image.tmdb.org/t/p/w500/9orbe4F0T16K8P0hWqn6vd6czMj.jpg	t
1402	Jamie Lee Curtis	\N	https://image.tmdb.org/t/p/w500/eWKubKAAssRzmFwCZKh1mdYqGCH.jpg	t
1403	Julia Butters	\N	https://image.tmdb.org/t/p/w500/uWwwXvhcQDULR2zyi4Np5T10Viz.jpg	t
1404	Sophia Hammons	\N	https://image.tmdb.org/t/p/w500/bKu8YUtHzQRYm2IqLD7HwgIh9ZI.jpg	t
1405	Manny Jacinto	\N	https://image.tmdb.org/t/p/w500/8PENhKW8wG7LwBaJfGvskOXtlKR.jpg	t
1406	Mark Harmon	\N	https://image.tmdb.org/t/p/w500/jDRXlmBItH9IyXk9UhafpOSBIq7.jpg	t
1407	Chad Michael Murray	\N	https://image.tmdb.org/t/p/w500/jIkzUQUVLkgn3HFMFRJBDAD0OLj.jpg	t
1408	Vanessa Bayer	\N	https://image.tmdb.org/t/p/w500/8IUjlVY8l7S7BEVhfHzKNgVGpUX.jpg	t
1409	Lucille Soong	\N	https://image.tmdb.org/t/p/w500/3PBNmz6zcUWtCEdENMvzhHWtZaz.jpg	t
1410	Julien Ernwein	\N	\N	t
1411	Marie Masala	\N	\N	t
1412	Marina Foïs	\N	https://image.tmdb.org/t/p/w500/dLPo5cyKoH4Y8TNRkl2GIrd4Oae.jpg	t
1413	Louise Bourgoin	\N	https://image.tmdb.org/t/p/w500/n83zu056tAm0wXHVrNk3khr8Gm4.jpg	t
1414	Souleymane Cissé	\N	\N	t
1415	Sophie Guillemin	\N	https://image.tmdb.org/t/p/w500/vbvNjRqzLTvBdQxVVnfuBNgp0FZ.jpg	t
1416	Hedi Zada	\N	\N	t
1417	Micha Lescot	\N	https://image.tmdb.org/t/p/w500/sKEi3DKXvgKVUObbAEQpYqo5L1l.jpg	t
1418	Emmanuel Salinger	\N	https://image.tmdb.org/t/p/w500/fc9sL0ZOLOu57Rc6i3qdK14JxTb.jpg	t
1419	Saadia Bentaïeb	\N	https://image.tmdb.org/t/p/w500/tQXSCqgjJdAC9eXrnjZ4BFJWSr7.jpg	t
1420	Dakota Johnson	\N	https://image.tmdb.org/t/p/w500/qFek0KqpaPV5mVyHHNfAapDE9Tj.jpg	t
1421	Jamie Dornan	\N	https://image.tmdb.org/t/p/w500/dPCjxgq4YsqkcZ3fsE84Ifq0Wxv.jpg	t
1422	Jennifer Ehle	\N	https://image.tmdb.org/t/p/w500/rmHaDj5xQu3ZPoI5XWgA5BZj3zH.jpg	t
1423	Eloise Mumford	\N	https://image.tmdb.org/t/p/w500/qSZvYfSDO6hyecInknWpcyrQ7Hz.jpg	t
1424	Victor Rasuk	\N	https://image.tmdb.org/t/p/w500/1vh2Yzp9bhmaxLfpNCrO7DVoURd.jpg	t
1425	Luke Grimes	\N	https://image.tmdb.org/t/p/w500/q8PqzidRZhcztUF2d0oWfvjBQdL.jpg	t
1426	Marcia Gay Harden	\N	https://image.tmdb.org/t/p/w500/5vxcHIHABJxqhweAsTiXVOhT4SE.jpg	t
1427	Rita Ora	\N	https://image.tmdb.org/t/p/w500/o1DMrW8vsTYnCcvVTZy6hEvlk4f.jpg	t
1428	Max Martini	\N	https://image.tmdb.org/t/p/w500/gehOxb2cgNjcRnbAxaCUnFFJvAY.jpg	t
1429	Callum Keith Rennie	\N	https://image.tmdb.org/t/p/w500/zOeA4IR4xYde2VlDsHZy2SoPZkc.jpg	t
1430	Kenneth Branagh	\N	https://image.tmdb.org/t/p/w500/AbCqqFxNi5w3nDUFdQt0DGMFh5H.jpg	t
1431	Toby Jones	\N	https://image.tmdb.org/t/p/w500/1qNisdp4f1KstdfvAgYXMdrhwfk.jpg	t
1432	Jason Isaacs	\N	https://image.tmdb.org/t/p/w500/s6XRFjqUsrDJfDQuXPOoExAYPmb.jpg	t
1433	Garrett Hedlund	\N	https://image.tmdb.org/t/p/w500/9zec61HuFJgiUEzPSt0NfPIj0Xv.jpg	t
1434	Olivia Wilde	\N	https://image.tmdb.org/t/p/w500/9O6qumSwb4eFZcOvwSqdEFAZOOj.jpg	t
1435	Bruce Boxleitner	\N	https://image.tmdb.org/t/p/w500/1x99F4oJTFAFY2HR4PbQdxiGyMH.jpg	t
1436	James Frain	\N	https://image.tmdb.org/t/p/w500/1KnxsxRbVZkh5bdY3gA8v4YKhKR.jpg	t
1437	Beau Garrett	\N	https://image.tmdb.org/t/p/w500/vuslFsEffLIDskn5ikyrPvTby7x.jpg	t
1438	Michael Sheen	\N	https://image.tmdb.org/t/p/w500/iKHKWahPQYuxJSjXf8ZEmEZD9wZ.jpg	t
1439	Serinda Swan	\N	https://image.tmdb.org/t/p/w500/mA4qtNZnn0A2oT1s4IIHseO8oiu.jpg	t
1440	Yaya DaCosta	\N	https://image.tmdb.org/t/p/w500/nbkbw9fjaAxFPscnY8xcqAi5TCs.jpg	t
1441	Elizabeth Mathis	\N	https://image.tmdb.org/t/p/w500/20JIjwt09fOzcN9LjVOGdWLrgqP.jpg	t
1442	Bill Nighy	\N	https://image.tmdb.org/t/p/w500/acbigDOU1L1vMWAL3Wf0r8h8qLA.jpg	t
1443	Kevin McNally	\N	https://image.tmdb.org/t/p/w500/1QvG7MbfeWxb4LlZrlR4OtwvB8v.jpg	t
1444	Brendan Gleeson	\N	https://image.tmdb.org/t/p/w500/ctPPJu5ZYDZr1IPmzoNpezczrm0.jpg	t
1445	Michael Gambon	\N	https://image.tmdb.org/t/p/w500/3jdWkDKf4IODbG4JKTeaC7AzxZH.jpg	t
1446	Robert Pattinson	\N	https://image.tmdb.org/t/p/w500/8A4PS5iG7GWEAVFftyqMZKl3qcr.jpg	t
1447	David Tennant	\N	https://image.tmdb.org/t/p/w500/pQHLJEOEcKpPpyiIheh47AJ5INS.jpg	t
1448	Satoshi Hino	\N	https://image.tmdb.org/t/p/w500/8ZJIiwIVF2zDyyFr7oXewj0eEuu.jpg	t
1449	Saori Hayami	\N	https://image.tmdb.org/t/p/w500/gLv9lO7dlUbIsmyJUvgegqAAXki.jpg	t
1450	Kenichi Suzumura	\N	https://image.tmdb.org/t/p/w500/vFqjmIjxfgBkh3ZmUin7QETV0sy.jpg	t
1451	Tomokazu Seki	\N	https://image.tmdb.org/t/p/w500/jGQC9KkfNMh2wBgizw81GLX2KN2.jpg	t
1452	James McArdle	\N	https://image.tmdb.org/t/p/w500/4zvZYJqiF4ZZ0AYmTVL3ucyNB11.jpg	t
1453	Fionnula Flanagan	\N	https://image.tmdb.org/t/p/w500/ee3vqFhrmKMRsqqHFLm1rcwGE93.jpg	t
1454	Dearbhla Molloy	\N	https://image.tmdb.org/t/p/w500/rSIjxmrIz05AdZqtwMaKzu4ZGzc.jpg	t
1455	Paddy Glynn	\N	\N	t
1456	Stella McCusker	\N	https://image.tmdb.org/t/p/w500/yNbn5ibb3FxdUm8iYh5ixJK5Rzi.jpg	t
1457	Niamh Cusack	\N	https://image.tmdb.org/t/p/w500/nfSWB8Ek9X9kjUtjD6PzWxVM5Xd.jpg	t
1458	Gaëtan Garcia	\N	\N	t
1459	Rory O'Neill	\N	\N	t
1460	Gearoid Farrelly	\N	\N	t
1461	Gordon Hickey	\N	https://image.tmdb.org/t/p/w500/cMFG9x1OhYOgMprHWBnor5wMCXI.jpg	t
1462	Bill Skarsgård	\N	https://image.tmdb.org/t/p/w500/xBXLx1m0uzhXIbY3wN8lmPGeUHl.jpg	t
1463	Bill Hader	\N	https://image.tmdb.org/t/p/w500/8LiP5wHNq3QpwoARquhkGcPSgjM.jpg	t
1464	Isaiah Mustafa	\N	https://image.tmdb.org/t/p/w500/tnwz9bf0bplixzyaqyu4iAI9lLj.jpg	t
1465	Jay Ryan	\N	https://image.tmdb.org/t/p/w500/oN7Fix6XhwLGrWFN0lmGbsAe5Rp.jpg	t
1466	Teach Grant	\N	https://image.tmdb.org/t/p/w500/18UPpMgudrgvZlKE5HWcM80JKdS.jpg	t
1467	Andy Bean	\N	https://image.tmdb.org/t/p/w500/4BiltJsO0KO7E9Mgyj8wMekbEBA.jpg	t
1468	Joan Gregson	\N	https://image.tmdb.org/t/p/w500/2YoaROKaZzezyK0o9nwkFl2Lqo5.jpg	t
1469	Samara Weaving	\N	https://image.tmdb.org/t/p/w500/aMD5SVh0Zb0n5jOdbIfqbAjVNHd.jpg	t
1470	Karl Glusman	\N	https://image.tmdb.org/t/p/w500/mTpLq73gepoX1fCLCtTunCxWYp5.jpg	t
1471	Andy García	\N	https://image.tmdb.org/t/p/w500/9EivXoBlczZcFBet96WOoFbDsfF.jpg	t
1472	Steve Zahn	\N	https://image.tmdb.org/t/p/w500/rwrPdKGwXnByxUVMxMf8Y7oswi3.jpg	t
1473	Jermaine Fowler	\N	https://image.tmdb.org/t/p/w500/tUovrCcFKncccMY7yarqeLBeVPk.jpg	t
1474	Marshawn Lynch	\N	https://image.tmdb.org/t/p/w500/ze8ZCRhiXGfYHmSCyBbA77gqr74.jpg	t
1475	Randall Park	\N	https://image.tmdb.org/t/p/w500/5bDlNgwsSKAFjBdSWOwRzyMdJ0E.jpg	t
1476	Mike O'Malley	\N	https://image.tmdb.org/t/p/w500/q5T34bdF9BhQ6N95I8b6pzUM8KQ.jpg	t
1477	Elle Graham	\N	https://image.tmdb.org/t/p/w500/U9aSAgn4ym7pzcKcKvEUFKF1pf.jpg	t
1478	Kyanna Simone Simpson	\N	https://image.tmdb.org/t/p/w500/lFNbS3Y7S6kjo0YDPiVcmwzfSYq.jpg	t
1479	Emily Blunt	\N	https://image.tmdb.org/t/p/w500/zpJ7pupuNF3W0zTxm6yioGIoxbd.jpg	t
1480	Matt Damon	\N	https://image.tmdb.org/t/p/w500/4KAxONjmVq7qcItdXo38SYtnpul.jpg	t
1481	Josh Hartnett	\N	https://image.tmdb.org/t/p/w500/8nTEioiir92fGHcASarPxkjF6kG.jpg	t
1482	Rami Malek	\N	https://image.tmdb.org/t/p/w500/ewr46CGOdsx5NzAJdIzEBz2yIQh.jpg	t
1483	Benny Safdie	\N	https://image.tmdb.org/t/p/w500/9tp4PLNyYPNfCJOWBXPPalWIpnq.jpg	t
1484	Lupita Nyong'o	\N	https://image.tmdb.org/t/p/w500/y40Wu1T742kynOqtwXASc5Qgm49.jpg	t
1485	Kit Connor	\N	https://image.tmdb.org/t/p/w500/ut64CyBwiRudb3DxOgUa2j9Wxep.jpg	t
1486	Stephanie Hsu	\N	https://image.tmdb.org/t/p/w500/8gb3lfIHKQAGOQyeC4ynQPsCiHr.jpg	t
1487	Matt Berry	\N	https://image.tmdb.org/t/p/w500/1UCAuXgzQfeANlLnZFVSuq0OFhR.jpg	t
1488	Mark Hamill	\N	https://image.tmdb.org/t/p/w500/2ZulC2Ccq1yv3pemusks6Zlfy2s.jpg	t
1489	Boone Storm	\N	https://image.tmdb.org/t/p/w500/kn5JY9C0oHq09MFLB5vFpoqgop7.jpg	t
1490	Mike Myers	\N	https://image.tmdb.org/t/p/w500/gjfDl52Kk02MPgUYFjs9bOy33OY.jpg	t
1491	Eddie Murphy	\N	https://image.tmdb.org/t/p/w500/qgjMfefsKwSYsyCaIX46uyOXIpy.jpg	t
1492	Cameron Diaz	\N	https://image.tmdb.org/t/p/w500/d4f4cQ9EiYuvNMjT1IB2h06KoRx.jpg	t
1493	Vincent Cassel	\N	https://image.tmdb.org/t/p/w500/KxzpJXyzVnqfouInWLypAND0gL.jpg	t
1494	Peter Dennis	\N	https://image.tmdb.org/t/p/w500/A2lPsbLYrhXcKL82byfU8FAfaMY.jpg	t
1495	Clive Pearse	\N	https://image.tmdb.org/t/p/w500/aRwEqA2YmmymjuJ0lheFKLE6gwU.jpg	t
1496	Jim Cummings	\N	https://image.tmdb.org/t/p/w500/c0sQPRCM5Ri3F4gVyxPr4AcPmIq.jpg	t
1497	Bobby Block	\N	https://image.tmdb.org/t/p/w500/l4ktDZmixDQIhXfDsyLvTGANXiy.jpg	t
1498	Chris Miller	\N	https://image.tmdb.org/t/p/w500/qKdbhP9amIRlydcoivWlTx3szuS.jpg	t
1499	Eric Bauza	\N	https://image.tmdb.org/t/p/w500/afOlsVPQxbtkom604MeCemjlwEV.jpg	t
1500	Candi Milo	\N	https://image.tmdb.org/t/p/w500/fCgxSGGGF6m8YhrIE7Irs1ueh3W.jpg	t
1501	Peter MacNicol	\N	https://image.tmdb.org/t/p/w500/8gizugTP8hykdfBkOY0Qg0aqpiP.jpg	t
1502	Fred Tatasciore	\N	https://image.tmdb.org/t/p/w500/cKMuclPblMvQ4JQMN0nYKvb5ylu.jpg	t
1503	Laraine Newman	\N	https://image.tmdb.org/t/p/w500/wlc9dpH0GdWiXBRDzGMuUQcoPKe.jpg	t
1504	Wayne Knight	\N	https://image.tmdb.org/t/p/w500/l5nD2XV6boxUk7bftceRUIi0ulW.jpg	t
1505	Ruth Clampett	\N	\N	t
1506	Andrew Kishino	\N	https://image.tmdb.org/t/p/w500/dnQ6GYWWfogRnzapjzz7qgi5wPe.jpg	t
1507	Kimberly Brooks	\N	https://image.tmdb.org/t/p/w500/iPlCk1VQ8fnAtsMow6HlCZoQc0w.jpg	t
1508	Keith Ferguson	\N	https://image.tmdb.org/t/p/w500/8EvTlmOhP34EZFEGsznqjbr4o4q.jpg	t
1509	Lindsay LaVanchy	\N	https://image.tmdb.org/t/p/w500/izTspHKOpOAslVtlOsMv89o0rNe.jpg	t
1510	Louis Ozawa	\N	https://image.tmdb.org/t/p/w500/hPND74J7MQFUFCMS1zsDO7LSWzC.jpg	t
1511	Rick Gonzalez	\N	https://image.tmdb.org/t/p/w500/pVHDPq1a2oCZktgI3VumMRzGBd3.jpg	t
1512	Michael Biehn	\N	https://image.tmdb.org/t/p/w500/9oFLsADWQm2TvU8XzLIzBbjdMkU.jpg	t
1513	Doug Cockle	\N	https://image.tmdb.org/t/p/w500/sQGrr2Sjn5o9hrKvcFEnCyTuNw4.jpg	t
1514	Damien C. Haas	\N	https://image.tmdb.org/t/p/w500/gOOCnM2q0bsY8FvjrLxCY4FlMGI.jpg	t
1515	Lauren Holt	\N	https://image.tmdb.org/t/p/w500/2dPQDpa9Q3tWUOlFiGspxFAOw6l.jpg	t
1516	Jeff Leach	\N	\N	t
1517	Cherami Leigh	\N	https://image.tmdb.org/t/p/w500/4Vko4QYXn3K8dhxbgAYGSwo8jjT.jpg	t
1518	Alessa Luz Martinez	\N	\N	t
1519	Luisa Ranieri	\N	https://image.tmdb.org/t/p/w500/4io9vmxUwdfWvgg6EAncYsbgQYr.jpg	t
1520	Jasmine Trinca	\N	https://image.tmdb.org/t/p/w500/idxRGFkuTwxKZZNtDBTY84UzAPd.jpg	t
1521	Elena Sofia Ricci	\N	https://image.tmdb.org/t/p/w500/6SKKF1MWQXydnPJPQwrRE6WO0oW.jpg	t
1522	Lunetta Savino	\N	https://image.tmdb.org/t/p/w500/3ZKTuTGF2QoFLrUvQLZ6mRSjtTE.jpg	t
1523	Vanessa Scalera	\N	https://image.tmdb.org/t/p/w500/kwkp4W8iypN1Xqp8AoLYJ5Bwhrt.jpg	t
1524	Kasia Smutniak	\N	https://image.tmdb.org/t/p/w500/t7pf7Lsfxzt0QqILBB1mmCbf81U.jpg	t
1525	Milena Vukotić	\N	https://image.tmdb.org/t/p/w500/k4dsiarmq3s5kryz7MxSIQcrPRR.jpg	t
1526	Anna Ferzetti	\N	https://image.tmdb.org/t/p/w500/4i70JDgSCCadRA0T0jE2ct7jJcE.jpg	t
1527	Geppi Cucciari	\N	https://image.tmdb.org/t/p/w500/yGegfb4u9ErBReNRQpHxe5gOANj.jpg	t
1528	Mara Venier	\N	https://image.tmdb.org/t/p/w500/offh2VeyKKGPBRhRVkehVT2e5Hv.jpg	t
1529	Ke Huy Quan	\N	https://image.tmdb.org/t/p/w500/iestHyn7PLuVowj5Jaa1SGPboQ4.jpg	t
1530	Fortune Feimster	\N	https://image.tmdb.org/t/p/w500/aCV6S7Tuh9iUmF9on6EwaXC3rCI.jpg	t
1531	Maurice LaMarche	\N	https://image.tmdb.org/t/p/w500/qCiL3EYAhLcNo0rNj5pczWo9MwG.jpg	t
1532	Shakira	\N	https://image.tmdb.org/t/p/w500/2qKDxGoGge1eRnESMDPxKz9B3Gd.jpg	t
1533	Quinta Brunson	\N	https://image.tmdb.org/t/p/w500/50gY1qgG5ddSLPY77K8zAq9TwJo.jpg	t
1534	Naomi Scott	\N	https://image.tmdb.org/t/p/w500/knSGMaEaH6CZaYw7GQpvxyJcsz7.jpg	t
1535	Rosemarie DeWitt	\N	https://image.tmdb.org/t/p/w500/44sxIdGtYN24R14OmnZbCpcd8J8.jpg	t
1536	Lukas Gage	\N	https://image.tmdb.org/t/p/w500/sftjB0MjD92meZqnL9OLtcTI02d.jpg	t
1537	Miles Gutierrez-Riley	\N	https://image.tmdb.org/t/p/w500/22JmiXEKoIHTKAdZaxOiS5wVHnM.jpg	t
1538	Peter Jacobson	\N	https://image.tmdb.org/t/p/w500/pGi9CnzEG4cLa2viUP89yvlPCyR.jpg	t
1539	Ray Nicholson	\N	https://image.tmdb.org/t/p/w500/f0MRbGIyTEJLJgHedJS8pRFhGn4.jpg	t
1540	Dylan Gelula	\N	https://image.tmdb.org/t/p/w500/nqXd0gVNlma8knaykJh5ArXSYqy.jpg	t
1541	Kyle Gallner	\N	https://image.tmdb.org/t/p/w500/wfdywrw6K3ti1uW1IYDWbUtU8se.jpg	t
1542	Drew Barrymore	\N	https://image.tmdb.org/t/p/w500/9xMu2GLC5otUcC11sEWC5aEAERQ.jpg	t
1543	张子枫	\N	https://image.tmdb.org/t/p/w500/3S8yEnTVqH8T3bTVf9FmtXxWcu2.jpg	t
1544	梁家輝	\N	https://image.tmdb.org/t/p/w500/n5XtznlOfGSfYvckuxCiTapG4tB.jpg	t
1545	此沙	\N	https://image.tmdb.org/t/p/w500/eWytg5M0VUCb0aHEKpUDijQ7JxF.jpg	t
1546	文俊辉	\N	https://image.tmdb.org/t/p/w500/z1seXrQQWG7nsQVHqSWKefJQ8DO.jpg	t
1547	周政杰	\N	https://image.tmdb.org/t/p/w500/9n4vnXt6SIrfUfDDXxz4ewxhbSf.jpg	t
1548	王紫逸	\N	https://image.tmdb.org/t/p/w500/6xOEI8NnQuvRwe6nSDXYGAamKzO.jpg	t
1549	郎月婷	\N	https://image.tmdb.org/t/p/w500/1Cb35zqOHyfwaqljbSJo3Fi6Jdo.jpg	t
1550	Lin Qiunan	\N	\N	t
1551	李哲坤	\N	\N	t
1552	Timothée Chalamet	\N	https://image.tmdb.org/t/p/w500/dFxpwRpmzpVfP1zjluH68DeQhyj.jpg	t
1553	Stephen McKinley Henderson	\N	https://image.tmdb.org/t/p/w500/z2weSPo4sdMNj47tP5o0me41r2z.jpg	t
1554	Sharon Duncan-Brewster	\N	https://image.tmdb.org/t/p/w500/gp5h6rOrqBrIGgID4AMd58O6Ow6.jpg	t
1555	張震	\N	https://image.tmdb.org/t/p/w500/7GHGozSsjERpQwvVwIhd1i6Yl7Y.jpg	t
1556	Theo James	\N	https://image.tmdb.org/t/p/w500/lSC4cMhcQeCjPFkK6qCjSGDSeR3.jpg	t
1557	Tatiana Maslany	\N	https://image.tmdb.org/t/p/w500/x8lBkm9CBJbIlLpqjEwkQydZ2or.jpg	t
1558	Colin O'Brien	\N	https://image.tmdb.org/t/p/w500/qF38oBiO1b7nEua71FY2XfIayZl.jpg	t
1559	Adam Scott	\N	https://image.tmdb.org/t/p/w500/b82C29R6fGiPoqIglQ4lzS6q2YX.jpg	t
1560	Rohan Campbell	\N	https://image.tmdb.org/t/p/w500/52LIlmT5Pv7sqhlKBRHCkBkl1qT.jpg	t
1561	Sarah Levy	\N	https://image.tmdb.org/t/p/w500/l37vAd4fkzv9EH8r9eChuzrSPxu.jpg	t
1562	Osgood Perkins	\N	https://image.tmdb.org/t/p/w500/sshAqrQ2DV2TUsgBAr1XaYqqxkm.jpg	t
1563	Nicco Del Rio	\N	https://image.tmdb.org/t/p/w500/c9UyLuVDwwrInDQt2BiDWRXKTOw.jpg	t
1564	Austin Butler	\N	https://image.tmdb.org/t/p/w500/atdAs4pFGjUQ4m2W8kJYly7N6cC.jpg	t
1565	Regina King	\N	https://image.tmdb.org/t/p/w500/fEIz0ljk9CBrp3AitM5nwjfoGVu.jpg	t
1566	Zoë Kravitz	\N	https://image.tmdb.org/t/p/w500/hJKmhbuzDjmfw2nPBDWGbLagj16.jpg	t
1567	Matt Smith	\N	https://image.tmdb.org/t/p/w500/xr2GSp8Pm6fT5VGm0I9tsWVcZ8q.jpg	t
1568	Liev Schreiber	\N	https://image.tmdb.org/t/p/w500/26G7QjSb5ZazgWb9XB2X6SwcILQ.jpg	t
1569	Vincent D'Onofrio	\N	https://image.tmdb.org/t/p/w500/qkyiLolEqYMGH25xD4sFIXAjZQB.jpg	t
1570	Griffin Dunne	\N	https://image.tmdb.org/t/p/w500/oZeAznfOHgK1Kvy9TknkQhag1Um.jpg	t
1571	Никита Кукушкин	\N	https://image.tmdb.org/t/p/w500/ccybonINeI0h0SZF3TX2u1VTOCy.jpg	t
1572	Юрий Колокольников	\N	https://image.tmdb.org/t/p/w500/77g4exFoU4FvCWoWVgn6aXR01rA.jpg	t
1573	Bad Bunny	\N	https://image.tmdb.org/t/p/w500/9W0wolhRLqKBpL8afcZnp2Xseu0.jpg	t
1574	Zendaya	\N	https://image.tmdb.org/t/p/w500/3WdOloHpjtjL96uVOhFRRCcYSwq.jpg	t
1575	Jacob Batalon	\N	https://image.tmdb.org/t/p/w500/53YhaL4xw4Sb1ssoHkeSSBaO29c.jpg	t
1576	Jamie Foxx	\N	https://image.tmdb.org/t/p/w500/zD8Nsy4Xrghp7WunwpCj5JKBPeU.jpg	t
1577	Willem Dafoe	\N	https://image.tmdb.org/t/p/w500/ui8e4sgZAwMPi3hzEO53jyBJF9B.jpg	t
1578	Alfred Molina	\N	https://image.tmdb.org/t/p/w500/nJo91Czesn6z0d0pkfbDoVZY3sg.jpg	t
1579	Tony Revolori	\N	https://image.tmdb.org/t/p/w500/tSF6XmXDikrKZbFUeoDnafXxKjT.jpg	t
1580	Viola Davis	\N	https://image.tmdb.org/t/p/w500/xDssw6vpYNRjsybvMPRE30e0dPN.jpg	t
1581	Dustin Hoffman	\N	https://image.tmdb.org/t/p/w500/yFjTzJHE6AFbwQifOlnNDzmiwlq.jpg	t
1582	Bryan Cranston	\N	https://image.tmdb.org/t/p/w500/7Jahy5LZX2Fo8fGJltMreAI49hC.jpg	t
1583	James Hong	\N	https://image.tmdb.org/t/p/w500/v3lfw5aHOy0paOCx6WHiSnwzbH0.jpg	t
1584	Ronny Chieng	\N	https://image.tmdb.org/t/p/w500/nn1y0te102CvakOJ0rSJ7rYPLDF.jpg	t
1585	Lori Tan Chinn	\N	https://image.tmdb.org/t/p/w500/i0pvjYbtcGZzVKfqknkA2eBLy1S.jpg	t
1586	Rumi Hiiragi	\N	https://image.tmdb.org/t/p/w500/zITaVtFyc4xSM3mxSoPRWHbqgJI.jpg	t
1587	Miyu Irino	\N	https://image.tmdb.org/t/p/w500/8qEEhHUObNvGQr4e6eqLu5z4qTz.jpg	t
1588	Mari Natsuki	\N	https://image.tmdb.org/t/p/w500/MIFzUc77Sx57FQOZsoiGWEbpH2.jpg	t
1589	Takashi Naito	\N	https://image.tmdb.org/t/p/w500/xwsm0ygjG79jLIogutwo6r64igy.jpg	t
1590	Yasuko Sawaguchi	\N	https://image.tmdb.org/t/p/w500/rWspusb13VeJowmctnniXYYTcqq.jpg	t
1591	Tatsuya Gashûin	\N	https://image.tmdb.org/t/p/w500/fLqIdkShknsJmZy4EfBWuWyHN4C.jpg	t
1592	Ryunosuke Kamiki	\N	https://image.tmdb.org/t/p/w500/ut7ewXjdgUmgkhJ1EtbOo9tbc7s.jpg	t
1593	Yumi Tamai	\N	https://image.tmdb.org/t/p/w500/x9Td7e5F21cK9S1FCkobfqiJZ1c.jpg	t
1594	Yo Oizumi	\N	https://image.tmdb.org/t/p/w500/qw5KLuww2AEAk6JEssEkJY3wBn1.jpg	t
1595	Koba Hayashi	\N	https://image.tmdb.org/t/p/w500/ceQ58tRgqMZ9gePHg8xkKarZm0M.jpg	t
1596	Ariana DeBose	\N	https://image.tmdb.org/t/p/w500/8HTSA2iVTsDN83OncAvFTcqxsAr.jpg	t
1597	Fred Hechinger	\N	https://image.tmdb.org/t/p/w500/dLFy4KFR556j4Z9WstsslhJCwyZ.jpg	t
1598	Alessandro Nivola	\N	https://image.tmdb.org/t/p/w500/53wfpjSwPTMwhfuOSdgGgojMI8m.jpg	t
1599	Christopher Abbott	\N	https://image.tmdb.org/t/p/w500/qWmlTycQb3yXaGhxPb6LCyaDjqh.jpg	t
1600	Russell Crowe	\N	https://image.tmdb.org/t/p/w500/rsxGCRtPu42uKDJZlz7qknvz8h6.jpg	t
1601	Levi Miller	\N	https://image.tmdb.org/t/p/w500/5ovVnN2ffAWzwhZQKZWZWUgf6tZ.jpg	t
1602	Tom Reed	\N	https://image.tmdb.org/t/p/w500/gDvNQXHOQNBM5HyK9GfKu0tzPP1.jpg	t
1603	Michael J. Fox	\N	https://image.tmdb.org/t/p/w500/2JB4FMgQmnhbBlQ4SxWFN9EIVDi.jpg	t
1604	Crispin Glover	\N	https://image.tmdb.org/t/p/w500/imBnLpSXvg61qDDdEfvL6R4ITKt.jpg	t
1605	Lea Thompson	\N	https://image.tmdb.org/t/p/w500/85E9NTEfkRdUdK4kTrrnk5of25w.jpg	t
1606	Claudia Wells	\N	https://image.tmdb.org/t/p/w500/2VOsPvoV2vmEUd1O2KjW3kcN8JD.jpg	t
1607	Thomas F. Wilson	\N	https://image.tmdb.org/t/p/w500/mVhm65ZVBIRIptWGiMIvoUy0Khi.jpg	t
1608	Marc McClure	\N	https://image.tmdb.org/t/p/w500/uscpMlkuwi3sgGJ6Hz8FhwvsrRk.jpg	t
1609	Wendie Jo Sperber	\N	https://image.tmdb.org/t/p/w500/dufqiCvSBQUxuHmMXcH6U8fZG4k.jpg	t
1610	George DiCenzo	\N	https://image.tmdb.org/t/p/w500/8L9fr5601BbUs3UzoCEELnxEKVm.jpg	t
1611	Frances Lee McCain	\N	https://image.tmdb.org/t/p/w500/cpG16FA90mQ4xC6xxTsUu1p2yRr.jpg	t
1612	Masaya Fukunishi	\N	https://image.tmdb.org/t/p/w500/8paIbTobS6266x57pIhJCq3mBJh.jpg	t
1613	Wataru Katoh	\N	https://image.tmdb.org/t/p/w500/7PUe94Ju0klZfEutSSbdOJyaV0y.jpg	t
1614	Tessyo Genda	\N	https://image.tmdb.org/t/p/w500/7eJeYv2OCHKAadeFVdabVkpWldo.jpg	t
1615	Kengo Kawanishi	\N	https://image.tmdb.org/t/p/w500/u59FdPSHlA7JCWNnX1m10neLfT.jpg	t
1616	Keisuke Komoto	\N	https://image.tmdb.org/t/p/w500/iFObjSKN6ZXQ4qD2BeaDwVjRtuL.jpg	t
1617	Kenta Miyake	\N	https://image.tmdb.org/t/p/w500/7YL8vM2KYzPMeQqTpHWmNj6s1AP.jpg	t
1618	Sayaka Senbongi	\N	https://image.tmdb.org/t/p/w500/yLRKX9DPDGgTRKBQRFTUh3pvbU0.jpg	t
1619	Asami Seto	\N	https://image.tmdb.org/t/p/w500/iKKCPgKrNd4pJ0iBOC1SBZy2Y4Y.jpg	t
1620	Yuuki Shin	\N	https://image.tmdb.org/t/p/w500/pyOAlLSA9ZabbVy5HD8j9QuUdV8.jpg	t
1621	Katie Douglas	\N	https://image.tmdb.org/t/p/w500/jM1dCWdjt7aVhhPPTKJuy8Snwwc.jpg	t
1622	Aaron Abrams	\N	https://image.tmdb.org/t/p/w500/JBmN6Byyo1QSKIagjbCrTFX96I.jpg	t
1623	Carson MacCormac	\N	https://image.tmdb.org/t/p/w500/jRCd3axr0kZhGJaYE3ksACdi42a.jpg	t
1624	Vincent Muller	\N	https://image.tmdb.org/t/p/w500/8ksY6nR75SI8xJYCmw8ZGdK6Tk8.jpg	t
1625	Will Sasso	\N	https://image.tmdb.org/t/p/w500/4F8p9Dg32WJl12ras7CzQzLFy2i.jpg	t
1626	Cassandra Potenza	\N	https://image.tmdb.org/t/p/w500/2yDpYdJRoF6TFUgyCbJfKSNutBY.jpg	t
1627	Verity Marks	\N	https://image.tmdb.org/t/p/w500/talMbdr17VcIWayyPeeIcUCX4wK.jpg	t
1628	Ayo Solanke	\N	https://image.tmdb.org/t/p/w500/aJSKswDUTCMjwniKRTbVy44hDDC.jpg	t
1629	Alexandre Martin Deakin	\N	https://image.tmdb.org/t/p/w500/jFvhSqOg3EajV2ebYLwLGKiKhhc.jpg	t
1630	Idina Menzel	\N	https://image.tmdb.org/t/p/w500/eGsyJmAZNV5tUU4RYy2DIRlFVpW.jpg	t
1631	Kristen Bell	\N	https://image.tmdb.org/t/p/w500/rP74dJXl7EjinGM0shQtUOlH5s2.jpg	t
1632	Jonathan Groff	\N	https://image.tmdb.org/t/p/w500/3kmnYKAzSc3Lp7iK5pcj97Hx9Cm.jpg	t
1633	Josh Gad	\N	https://image.tmdb.org/t/p/w500/bgRWcrD9hfaa2f7RUWJzxmJaWuD.jpg	t
1634	Livvy Stubenrauch	\N	https://image.tmdb.org/t/p/w500/13BqIDnKbVt43SVvVxXa0glwzWw.jpg	t
1635	Santino Fontana	\N	https://image.tmdb.org/t/p/w500/3EtNGPVBN5bBamV817n43kFd4MB.jpg	t
1636	Eva Bella	\N	https://image.tmdb.org/t/p/w500/8XmnkpEEEtXYXTQ9PFBBtIUAaBR.jpg	t
1637	Maia Wilson	\N	https://image.tmdb.org/t/p/w500/fqKBpJsMaGFFU5PlOD1TY3ivogK.jpg	t
1638	Ciarán Hinds	\N	https://image.tmdb.org/t/p/w500/d8wLIX9VYgwXRGSp1gmUdUxmApv.jpg	t
1639	Jake Gyllenhaal	\N	https://image.tmdb.org/t/p/w500/rJdYHYNhlcOBwbPvDZVvt1xw7bi.jpg	t
1640	Travis Van Winkle	\N	https://image.tmdb.org/t/p/w500/t1hkmekr1WcaNq9C0Ou0Lf3rSZy.jpg	t
1641	Darren Barnet	\N	https://image.tmdb.org/t/p/w500/z3hQP19QgHsKZ4j0sXNzrhScDMO.jpg	t
1642	Daniela Melchior	\N	https://image.tmdb.org/t/p/w500/zLqPkfenHtuHSrXmEVmQ8Piqjdp.jpg	t
1643	Jessica Williams	\N	https://image.tmdb.org/t/p/w500/n7fP2YluY2jmQPGbPWu3It1BNd.jpg	t
1644	Conor McGregor	\N	https://image.tmdb.org/t/p/w500/aEamMRQTl1P6fgvQnrEHGfd07El.jpg	t
1645	Joaquim de Almeida	\N	https://image.tmdb.org/t/p/w500/muXJn8kTEPxJaetkgCyS8RPEzTC.jpg	t
1646	Hannah Love Lanier	\N	https://image.tmdb.org/t/p/w500/9Jwa7ko0GoMi1TPRgwmrPUXWRuO.jpg	t
1647	J. D. Pardo	\N	https://image.tmdb.org/t/p/w500/uS616imhPsa4kt8veloLGQffx6f.jpg	t
1648	Lucy Liu	\N	https://image.tmdb.org/t/p/w500/9nbtjqsx3De7hO2XDtrBQ7M9VCH.jpg	t
1649	Kiernan Shipka	\N	https://image.tmdb.org/t/p/w500/t2FWVLTIhVRIa398mQAfN4thO5R.jpg	t
1650	Mary Elizabeth Ellis	\N	https://image.tmdb.org/t/p/w500/8tf8w69Bl6MO5P8r8Vk6dFnHKxx.jpg	t
1651	Wesley Kimmel	\N	https://image.tmdb.org/t/p/w500/lN3VfrQiYmU9ldZRHie8PQtnOe2.jpg	t
1652	Nick Kroll	\N	https://image.tmdb.org/t/p/w500/vdgpGtSXqTBnIKrKNMZocdFu7pX.jpg	t
1653	Brianna Hildebrand	\N	https://image.tmdb.org/t/p/w500/8lGwV4rMQReWMlsXhLBYMRTYzTA.jpg	t
1654	LaMonica Garrett	\N	https://image.tmdb.org/t/p/w500/yE5TBZ2qC5LAPDduBQAERo7EF3r.jpg	t
1655	Michael Irby	\N	https://image.tmdb.org/t/p/w500/9cX8pKujyAlOyqGSAgvKNdA3qRj.jpg	t
1656	Linda Hamilton	\N	https://image.tmdb.org/t/p/w500/7FNn9Z5xkRS9EFbGL2tpmpph9xV.jpg	t
1657	Stanley White Jr.	\N	https://image.tmdb.org/t/p/w500/eXdsJsy7hmzDJH6k90M0OOL3M6l.jpg	t
1658	Tyler Galpin	\N	https://image.tmdb.org/t/p/w500/6QMB9rvGQnXVTloCEAs5yMdTfKI.jpg	t
1659	Linds Edwards	\N	https://image.tmdb.org/t/p/w500/xCUqvvOWLJ2KZzJ52SRRuuD5uyV.jpg	t
1660	Dawson Towery	\N	\N	t
1661	David B. Meadows	\N	https://image.tmdb.org/t/p/w500/2kWOtDlmXi76UDVTd5GYFnejhgW.jpg	t
1662	Lauren LaVera	\N	https://image.tmdb.org/t/p/w500/jNlRSIw8oYbIN7oi4rV8db6XZMm.jpg	t
1663	David Howard Thornton	\N	https://image.tmdb.org/t/p/w500/9nYijs4ACzjg93zKezLiLmuRGvp.jpg	t
1664	Samantha Scaffidi	\N	https://image.tmdb.org/t/p/w500/jwd0XXuc4ibXAXjOxmhsFP0fQEO.jpg	t
1665	Elliott Fullam	\N	https://image.tmdb.org/t/p/w500/dNsFLihmWfA2KCENbZCtq9AjSob.jpg	t
1666	Margaret Anne Florence	\N	https://image.tmdb.org/t/p/w500/c2EqBueLCrn6XEnmfutylUd1icl.jpg	t
1667	Bryce Johnson	\N	https://image.tmdb.org/t/p/w500/iyHjMvKijZZDVZkK681JAio4nAh.jpg	t
1668	Alexa Blair Robertson	\N	https://image.tmdb.org/t/p/w500/yHqudNe4X6sFceaSgVLAfmsJEbk.jpg	t
1669	Antonella Rose	\N	https://image.tmdb.org/t/p/w500/sdqM1qQEjRuo460AuUOjFAH7kCm.jpg	t
1670	Mason Mecartea	\N	https://image.tmdb.org/t/p/w500/W1GmVVCGp0v3new7YnywhyhfDd.jpg	t
1671	Krsy Fox	\N	https://image.tmdb.org/t/p/w500/6bRT5c4MoP7yP3yza5HFdV9ajra.jpg	t
1672	Chris Messina	\N	https://image.tmdb.org/t/p/w500/l9DbQTK5pI6SOGpmfbADGLhdOYS.jpg	t
1673	John Gallagher Jr.	\N	https://image.tmdb.org/t/p/w500/e4eEg5lH6Yk0OkpieUoUYdzl2Ui.jpg	t
1674	Мария Машкова	\N	https://image.tmdb.org/t/p/w500/akv5uUaBnS8KkqsM91aHx1HtlYd.jpg	t
1675	Costa Ronin	\N	https://image.tmdb.org/t/p/w500/6PjUNZ6HYCT5PlQdXFI1ue2tOls.jpg	t
1676	Pilou Asbæk	\N	https://image.tmdb.org/t/p/w500/hUJAtjbYG7rqm54aoWtNWeeKjTY.jpg	t
1677	Mikey Madison	\N	https://image.tmdb.org/t/p/w500/b0HZr4Xa4pIR7MzTPXfIWvUZELx.jpg	t
1678	Марк Эйдельштейн	\N	https://image.tmdb.org/t/p/w500/7t3IHfpcgMDw5Q88Tr587I4o73v.jpg	t
1679	Юра Борисов	\N	https://image.tmdb.org/t/p/w500/zLcD2UmXJG6m3qOQhNZs13SQRIp.jpg	t
1680	Karren Karagulian	\N	https://image.tmdb.org/t/p/w500/rxyx8OFgShe0Kolptm5LpbsOUJj.jpg	t
1681	Vache Tovmasyan	\N	https://image.tmdb.org/t/p/w500/cKHEEer9V0zK96f1gE0gvQ5IvZq.jpg	t
1682	Luna Sofía Miranda	\N	https://image.tmdb.org/t/p/w500/eSEfNzd7f3Eg6LxWkiA1hjN51YN.jpg	t
1683	Lindsey Normington	\N	https://image.tmdb.org/t/p/w500/hgPwq6MBIlSMO4zmx9cLMndSITc.jpg	t
1684	Дарья Екамасова	\N	https://image.tmdb.org/t/p/w500/dfZXPxLvWy8OSi3FyQPhc3VWvFX.jpg	t
1685	Aleksey Serebryakov	\N	https://image.tmdb.org/t/p/w500/ch67oszo5D7lK64xnDp9JFcmGLp.jpg	t
1686	Anton Bitter	\N	https://image.tmdb.org/t/p/w500/iWmPlBzc0RQ2XnHQc2tgLJbELlQ.jpg	t
1687	Michelle Monaghan	\N	https://image.tmdb.org/t/p/w500/c6xYsN4NPGkU50l2Lu2fbgZPjI1.jpg	t
1688	Maggie Q	\N	https://image.tmdb.org/t/p/w500/1Z0A8axunWqZrskGkfANv6W5qCl.jpg	t
1689	Zoe Colletti	\N	https://image.tmdb.org/t/p/w500/swHewbIvYx7EVVURww6BkZJVncM.jpg	t
1690	Van Crosby	\N	https://image.tmdb.org/t/p/w500/6KkrTzx6mIZxvI4My7vuL2gDDH9.jpg	t
1691	Kellen Boyle	\N	https://image.tmdb.org/t/p/w500/bR53ypX16z5dvf1186Q7p5mKft2.jpg	t
1692	Saïd Taghmaoui	\N	https://image.tmdb.org/t/p/w500/kuxI08YpwQFGweIXK7TELknwexr.jpg	t
1693	Felicia Pearson	\N	https://image.tmdb.org/t/p/w500/bCa9RlpNJo7CHsFZWWTsuUWGNCx.jpg	t
1694	Lateef Crowder	\N	https://image.tmdb.org/t/p/w500/mhGArPyh3N97t3PU4YnvLZTzHjl.jpg	t
1695	Sophie Thatcher	\N	https://image.tmdb.org/t/p/w500/qVvPofENJI6czod3cFXjjEPUwsG.jpg	t
1696	Megan Suri	\N	https://image.tmdb.org/t/p/w500/krZBtMPTqVvteqYFXbAU6nnQShy.jpg	t
1697	Harvey Guillén	\N	https://image.tmdb.org/t/p/w500/yiNBonobPwqMVweB02JWufzp2l9.jpg	t
1698	Jaboukie Young-White	\N	https://image.tmdb.org/t/p/w500/8OYI8OqsMUpBZica4lM2odjgVH6.jpg	t
1699	Matthew J. McCarthy	\N	https://image.tmdb.org/t/p/w500/eHKjDZPdHTz5lV1UySfMdRqMrH6.jpg	t
1700	Woody Fu	\N	https://image.tmdb.org/t/p/w500/305m52CIr9Jtb1whdc5i1Lx2iEd.jpg	t
1701	Sergio Podeley	\N	https://image.tmdb.org/t/p/w500/e45vWB2INf2cGiGNVzdgCVjlOOa.jpg	t
1702	Julieta Díaz	\N	https://image.tmdb.org/t/p/w500/nFurIb8TGBINrru5ITrmTtzN4Nq.jpg	t
1703	Ramiro Blas	\N	https://image.tmdb.org/t/p/w500/dvK9IRC7wrTd9wxpMLzVxYVRpvP.jpg	t
1704	Maite Lanata	\N	https://image.tmdb.org/t/p/w500/aQa21YwxwgnHQhaedoILCNG6iIO.jpg	t
1705	Mariano Torre	\N	https://image.tmdb.org/t/p/w500/7doLzpSQLCU3TMaZeVRrxXZAkq2.jpg	t
1706	Matías Desiderio	\N	https://image.tmdb.org/t/p/w500/ieN7UA2d619tIKGF30WEnwDh8Ih.jpg	t
1707	Gonzalo Gravano	\N	\N	t
1708	Bianca Di Pasquale	\N	\N	t
1709	Susana Varela	\N	https://image.tmdb.org/t/p/w500/9FtcKSHZyoAZsVkoRpLzzJZmvhY.jpg	t
1710	Carolina Saade	\N	\N	t
1711	David Thewlis	\N	https://image.tmdb.org/t/p/w500/sNuYyT8ocLlQr3TdAW9CoKVbCU8.jpg	t
1712	Timothy Spall	\N	https://image.tmdb.org/t/p/w500/dEhBrDYNVpfWMDx8vpcrp4pXDwl.jpg	t
1713	Penélope Cruz	\N	https://image.tmdb.org/t/p/w500/mSUUioSTuECMiyRR1DabK6leTdg.jpg	t
1714	Sam Claflin	\N	https://image.tmdb.org/t/p/w500/e5CU4tjCNZFfm7ITmZfzjZse2Bb.jpg	t
1715	Astrid Bergès-Frisbey	\N	https://image.tmdb.org/t/p/w500/2mcTwrg61M7beQv05YQFPLWADmc.jpg	t
1716	Keith Richards	\N	https://image.tmdb.org/t/p/w500/t1oa5UsJMmrhNqCIks4jQnAYSQT.jpg	t
1717	Cailee Spaeny	\N	https://image.tmdb.org/t/p/w500/yl3YeRSHlDVArfgMdHh2v7Ui9zO.jpg	t
1718	Archie Renaux	\N	https://image.tmdb.org/t/p/w500/uTd18t2VJovN2jSJyhuG8Yy3PV6.jpg	t
1719	Spike Fearn	\N	https://image.tmdb.org/t/p/w500/o1WcXkDdlN5wdL5WIuGXNpNouZ9.jpg	t
1720	Aileen Wu	\N	https://image.tmdb.org/t/p/w500/gjW0BFkxowjzOVFyVMfgpCTkyl0.jpg	t
1721	Rosie Ede	\N	https://image.tmdb.org/t/p/w500/h6HTwvixLAq9HMGVyoAlWwahuA0.jpg	t
1722	Soma Simon	\N	\N	t
1723	Bence Okeke	\N	\N	t
1724	Viktor Orizu	\N	\N	t
1725	STEPINSTONE	\N	\N	t
1726	E.KHANDMAA	\N	\N	t
1727	E.BATKHULEG	\N	\N	t
1728	Joel Kinnaman	\N	https://image.tmdb.org/t/p/w500/iVTh89rxgPhZSuijVo467WNsvUw.jpg	t
1729	Sylvester Stallone	\N	https://image.tmdb.org/t/p/w500/gn3pDWthJqR0VDYGViGD3048og7.jpg	t
1730	David Dastmalchian	\N	https://image.tmdb.org/t/p/w500/eLafwcpL64CqzwjjSgKpO7Rv4ae.jpg	t
1731	Michael Rooker	\N	https://image.tmdb.org/t/p/w500/ngOuHNIAGrKyY1O7F0f9C5Q9ONg.jpg	t
1732	Jai Courtney	\N	https://image.tmdb.org/t/p/w500/6vEaNwbOKov6yzQx15CdtrqfK3L.jpg	t
1733	Emma Stone	\N	https://image.tmdb.org/t/p/w500/cZ8a3QvAnj2cgcgVL6g4XaqPzpL.jpg	t
1734	Jesse Plemons	\N	https://image.tmdb.org/t/p/w500/og4I51GsuwohdPgoELOHVMMqMre.jpg	t
1735	Aidan Delbis	\N	https://image.tmdb.org/t/p/w500/cM1I9bAUlkxSxAvtjnSOu3cICt6.jpg	t
1736	Stavros Halkias	\N	https://image.tmdb.org/t/p/w500/9QB7YGMk6O7hRgGWvK0OimTVzl7.jpg	t
1737	Alicia Silverstone	\N	https://image.tmdb.org/t/p/w500/pyxqkP4i0ubVdoRe5hoiiiwkHkb.jpg	t
1738	J. Carmen Galindez Barrera	\N	https://image.tmdb.org/t/p/w500/2ktCkWgexsBTbh0UFsbdKoHX4D1.jpg	t
1739	Marc T. Lewis	\N	https://image.tmdb.org/t/p/w500/zXLqVGK0VxmnJj7KFBMjFx1mJeD.jpg	t
1740	Vanessa Eng	\N	https://image.tmdb.org/t/p/w500/3HYU97U1wKR9byRBvu5SVpvifeH.jpg	t
1741	Cedric Dumornay	\N	\N	t
1742	Charita Momma Cherri Jones	\N	\N	t
1743	Tom Hanks	\N	https://image.tmdb.org/t/p/w500/eKF1sGJRrZJbfBG1KirPt1cfNd3.jpg	t
1744	Tim Allen	\N	https://image.tmdb.org/t/p/w500/woWhZzFILVhYMAvsPL171HjMY0y.jpg	t
1745	Don Rickles	\N	https://image.tmdb.org/t/p/w500/iJLQV4dcbTUgxlWJakjDldzlMXS.jpg	t
1746	Jim Varney	\N	https://image.tmdb.org/t/p/w500/zvBFmvKUrPvE6FW35O3RP4i1ZPp.jpg	t
1747	Wallace Shawn	\N	https://image.tmdb.org/t/p/w500/wVaM1WlFKDce4esThwL4XtNLhOe.jpg	t
1748	John Ratzenberger	\N	https://image.tmdb.org/t/p/w500/oRtDEOuIO1yDhTz5dORBdxXuLMO.jpg	t
1749	Annie Potts	\N	https://image.tmdb.org/t/p/w500/hWIzkAH7jkSkxBfwdudxbSPxeno.jpg	t
1750	John Morris	\N	https://image.tmdb.org/t/p/w500/lSdNMhN3DoXEQJ37IeOD5mTMUQK.jpg	t
1751	Erik von Detten	\N	https://image.tmdb.org/t/p/w500/v0ruIqUUZqXRWTsuui5irfsHMJe.jpg	t
1752	Laurie Metcalf	\N	https://image.tmdb.org/t/p/w500/ypAppMZ1Q99cBjtX4BAnZmWjVXe.jpg	t
1753	Robin Wright	\N	https://image.tmdb.org/t/p/w500/d3rIv0y2p0jMsQ7ViR7O1606NZa.jpg	t
1754	Gary Sinise	\N	https://image.tmdb.org/t/p/w500/olRjiV8ZhBixQiTvrGwXhpVXxsV.jpg	t
1755	Sally Field	\N	https://image.tmdb.org/t/p/w500/5fBK36MdmdwQQMuP0W70rXADXih.jpg	t
1756	Mykelti Williamson	\N	https://image.tmdb.org/t/p/w500/dR16zD9AjnHWbeN5OVmJWE0vSax.jpg	t
1757	Michael Conner Humphreys	\N	https://image.tmdb.org/t/p/w500/irYRs3COggVHg91jL3CrlCIWmnx.jpg	t
1758	Hanna Hall	\N	https://image.tmdb.org/t/p/w500/xkZ2Hwz1QLXvQCgGlWgVgx00Rtd.jpg	t
1759	Haley Joel Osment	\N	https://image.tmdb.org/t/p/w500/2rnMTQB9Q3vLtmRyyUaenVwSgfY.jpg	t
1760	Siobhan Fallon Hogan	\N	https://image.tmdb.org/t/p/w500/5OExagnRsUcOYLMPTSrv4x2G95R.jpg	t
1761	Rebecca Williams	\N	\N	t
1762	Tabatha Zimiga	\N	https://image.tmdb.org/t/p/w500/SEf6SRdZkhP98zwUPBRUv2RNUc.jpg	t
1763	Porshia Zimiga	\N	https://image.tmdb.org/t/p/w500/xNKBbG7vEVJ52zU6WO82caeEGBC.jpg	t
1764	Scoot McNairy	\N	https://image.tmdb.org/t/p/w500/oP2LJEqupxVZ2XdEW1lN5Q5LF3M.jpg	t
1765	Jesse Thorson	\N	\N	t
1766	Chancey Ryder Witt	\N	\N	t
1767	Clay Pateneaude	\N	\N	t
1768	Leanna Shumpert	\N	\N	t
1769	Brynn Darling	\N	\N	t
1770	Wyatt Mansfield	\N	\N	t
1771	Anthony Mackie	\N	https://image.tmdb.org/t/p/w500/9r3bvl2pBZwZMN3KUg43Sp8c7ZU.jpg	t
1772	Harrison Ford	\N	https://image.tmdb.org/t/p/w500/zVnHagUvXkR2StdOtquEwsiwSVt.jpg	t
1773	Danny Ramirez	\N	https://image.tmdb.org/t/p/w500/1CMMfxwMYOme8AOrl4kZS12nJpM.jpg	t
1774	Shira Haas	\N	https://image.tmdb.org/t/p/w500/eZRs79ZMoctjDk0SbPhzMNcs34a.jpg	t
1775	Tim Blake Nelson	\N	https://image.tmdb.org/t/p/w500/rWuTGiAMaaHIJ30eRkQS23LbRSW.jpg	t
1776	Carl Lumbly	\N	https://image.tmdb.org/t/p/w500/ew1URcenWNl1Uclsz9ADiRb0uBD.jpg	t
1777	Giancarlo Esposito	\N	https://image.tmdb.org/t/p/w500/rcXnr82TwDzU4ZGdBeNXfG0ZQnZ.jpg	t
1778	Xosha Roquemore	\N	https://image.tmdb.org/t/p/w500/k596seeX26xKN8bZ3Uir9zFJ2gS.jpg	t
1779	Jóhannes Haukur Jóhannesson	\N	https://image.tmdb.org/t/p/w500/oqZftP0WS1rD5NFpR7vLp6JU52I.jpg	t
1780	Kristen Stewart	\N	https://image.tmdb.org/t/p/w500/ryhCjTGqS6G6OprbR0qUEH355lA.jpg	t
1781	Billy Burke	\N	https://image.tmdb.org/t/p/w500/AoyN5a1TNRa4OCeylcXusQM1bD4.jpg	t
1782	Peter Facinelli	\N	https://image.tmdb.org/t/p/w500/mmha3A5INmromiCsN8FBSLScVpZ.jpg	t
1783	Ashley Greene	\N	https://image.tmdb.org/t/p/w500/7crsfr0klw5iaYvZ3n9ps6RCIhp.jpg	t
1784	Jackson Rathbone	\N	https://image.tmdb.org/t/p/w500/qgjLFneFtjidc4Flx8dAOWECnRw.jpg	t
1785	Nikki Reed	\N	https://image.tmdb.org/t/p/w500/bNI7QwlApXpWIXA8bhazvaF5TvL.jpg	t
1786	Kellan Lutz	\N	https://image.tmdb.org/t/p/w500/pLzdFABlU6oS2BvlHlAN990woY1.jpg	t
1787	Elizabeth Reaser	\N	https://image.tmdb.org/t/p/w500/tx2shpuofbAmmIoUXpXxqQ9exZM.jpg	t
1788	Taylor Lautner	\N	https://image.tmdb.org/t/p/w500/mxersUkPKcpcHDtyJUmP8G5HDBk.jpg	t
1789	Manfredi Marini	\N	https://image.tmdb.org/t/p/w500/n7vYLi7cRufvnoTwx7uqe2pudrn.jpg	t
1790	Vittoria Planeta	\N	\N	t
1791	Dana Giuliano	\N	https://image.tmdb.org/t/p/w500/bu2EQzFg7Ghfrvj1bQMxNWS1wiv.jpg	t
1792	Zackari Delmas	\N	\N	t
1793	Luca Lazzareschi	\N	\N	t
1794	Sergio Benvenuto	\N	\N	t
1795	Maria Pia Ferlazzo	\N	\N	t
1796	Samuel Wilberding	\N	\N	t
1797	Defne Yilmaz	\N	\N	t
1798	Nicolas L'helgoualch	\N	\N	t
1799	Donald Pleasence	\N	https://image.tmdb.org/t/p/w500/eVJGFCd8ikP6w0XjkuiTbsm65eD.jpg	t
1800	Nancy Kyes	\N	https://image.tmdb.org/t/p/w500/9LbRSE8soWZgkcHDLE6s8MSW6lG.jpg	t
1801	P. J. Soles	\N	https://image.tmdb.org/t/p/w500/1f8uZoN3oLGmsoEOmOiaorxWoMt.jpg	t
1802	Charles Cyphers	\N	https://image.tmdb.org/t/p/w500/cfDwWOFY9xOGiRxUwjIHhZ7U6lh.jpg	t
1803	Kyle Richards	\N	https://image.tmdb.org/t/p/w500/dGzz3al33Q99G8Bcr9vQH7hlI7P.jpg	t
1804	Brian Andrews	\N	https://image.tmdb.org/t/p/w500/7epiFWpYOSdjkCHyGz1162XbLuN.jpg	t
1805	John Michael Graham	\N	https://image.tmdb.org/t/p/w500/p67XshUxGdMtUW0bDhtrbZnV3bn.jpg	t
1806	Nancy Stephens	\N	https://image.tmdb.org/t/p/w500/6oS5nCeHAqszh2HgxoHXbmmnamB.jpg	t
1807	Arthur Malet	\N	https://image.tmdb.org/t/p/w500/AbmKxci3EZMG2rBmFLQiUdNsySL.jpg	t
1808	Oona Chaplin	\N	https://image.tmdb.org/t/p/w500/tT7QQOrumeGRquaLmWNZk2DyL3Z.jpg	t
1809	Britain Dalton	\N	https://image.tmdb.org/t/p/w500/asX3eJr9oHNs1ZgRYGwsZRAntqS.jpg	t
1810	Trinity Bliss	\N	https://image.tmdb.org/t/p/w500/a3WQPKhMHOZ5TjdnqStTfquzVB7.jpg	t
1811	Jack Champion	\N	https://image.tmdb.org/t/p/w500/8PXFKzhjFJ0oYP60Bj1kA44XBjY.jpg	t
1812	Bailey Bass	\N	https://image.tmdb.org/t/p/w500/2l5UJZb1EaM7J3MvsP6iLlopJ93.jpg	t
1813	Michael Keaton	\N	https://image.tmdb.org/t/p/w500/baeHNv3qrVsnApuKbZXiJOhqMnw.jpg	t
1814	Marisa Tomei	\N	https://image.tmdb.org/t/p/w500/f68nmyE9we5ABfa3YVvv9rZSrq4.jpg	t
1815	Gwyneth Paltrow	\N	https://image.tmdb.org/t/p/w500/alLfgUJcSm2USn7BnG6Y7e9Znpr.jpg	t
1816	Donald Glover	\N	https://image.tmdb.org/t/p/w500/jqVkQfeeEmdga1G0jpBwwXXwwSK.jpg	t
1817	Laura Harrier	\N	https://image.tmdb.org/t/p/w500/dcQiRB0EoGqP7LKFVeyY1g6uJmP.jpg	t
1818	Carrie-Anne Moss	\N	https://image.tmdb.org/t/p/w500/gc7JwuLDD0kXHUlGx5vWzdlqSIT.jpg	t
1819	Hugo Weaving	\N	https://image.tmdb.org/t/p/w500/t4ScpYIHlXVD41scEyiGdQDYflX.jpg	t
1820	Gloria Foster	\N	https://image.tmdb.org/t/p/w500/AriGXtC9fjBOia9Zr8CZjn4o3rx.jpg	t
1821	Joe Pantoliano	\N	https://image.tmdb.org/t/p/w500/3OHUI3nX4SYGGItDk3xqeIvWtIf.jpg	t
1822	Marcus Chong	\N	https://image.tmdb.org/t/p/w500/q9HQttibTj2MoXVtLjq2kKqmPrE.jpg	t
1823	Julian Arahanga	\N	https://image.tmdb.org/t/p/w500/g2YkF3PWSJU1vTKuURBH0DOMblm.jpg	t
1824	Matt Doran	\N	https://image.tmdb.org/t/p/w500/4HtMShAbsZ2AyFtq5z3bOVrvw2s.jpg	t
1825	Belinda McClory	\N	https://image.tmdb.org/t/p/w500/wfTCwkIDJjH5k5DtuvcjP52PrLc.jpg	t
1826	Denzel Washington	\N	https://image.tmdb.org/t/p/w500/393wX9AGWpseVqojQDPLy3bTBia.jpg	t
1827	Jeffrey Wright	\N	https://image.tmdb.org/t/p/w500/yGcuHGW4glqRpOPxgiCvjcren7F.jpg	t
1828	Ilfenesh Hadera	\N	https://image.tmdb.org/t/p/w500/esa2Y2tE3TsoGZtN449IsGK3ZeG.jpg	t
1829	Elijah Wright	\N	https://image.tmdb.org/t/p/w500/tjZcxfS8l2LII1PNdjYxFBj2zN4.jpg	t
1830	Aubrey Joseph	\N	https://image.tmdb.org/t/p/w500/cUdkKvjf9JzgRKvA4snH2sdTbhP.jpg	t
1831	A$AP Rocky	\N	https://image.tmdb.org/t/p/w500/gL0NFnIrqLosSbdxAHExOHAMkFH.jpg	t
1832	John Douglas Thompson	\N	https://image.tmdb.org/t/p/w500/ieN9RkPSnsdaXWjarOhXkl4Jofm.jpg	t
1833	LaChanze	\N	https://image.tmdb.org/t/p/w500/u1JSaJ3joDqiNXXa1Dy73PSwpqv.jpg	t
1834	Dean Winters	\N	https://image.tmdb.org/t/p/w500/zxgOZAYGxa2qmiZkJKGRIhwbGhG.jpg	t
1835	Huck Milner	\N	https://image.tmdb.org/t/p/w500/OnucCCKkO0tmBDfH6uDEoeThAb.jpg	t
1836	Catherine Keener	\N	https://image.tmdb.org/t/p/w500/n4CTwGszs6cwS1wJRlDQ5Mlh7Ex.jpg	t
1837	Michael Bird	\N	https://image.tmdb.org/t/p/w500/noR9ttzwjSIISRTjC1KIVbbzMDD.jpg	t
1838	Sophia Bush	\N	https://image.tmdb.org/t/p/w500/qG326QqyYmniKnmCVCnRPKQ8eFI.jpg	t
1839	Jaeden Martell	\N	https://image.tmdb.org/t/p/w500/29lQhfMR4nLUJROKq76x93NXPw1.jpg	t
1840	Sophia Lillis	\N	https://image.tmdb.org/t/p/w500/ulrUfGnMP8sYFnj3mCiwmSdaEUc.jpg	t
1841	Jeremy Ray Taylor	\N	https://image.tmdb.org/t/p/w500/czfmzjsDrGqIvDA3kkq62h9RCA1.jpg	t
1842	Finn Wolfhard	\N	https://image.tmdb.org/t/p/w500/5OVmquAk0W5BIsRlVKslEP497JD.jpg	t
1843	Jack Dylan Grazer	\N	https://image.tmdb.org/t/p/w500/cZdGLa78UP7VzMgNbDRnoaSkZm1.jpg	t
1844	Chosen Jacobs	\N	https://image.tmdb.org/t/p/w500/uMmg0hSYO65B4m0fJN3aDvXw8tw.jpg	t
1845	Nicholas Hamilton	\N	https://image.tmdb.org/t/p/w500/6XB730yU5XKJfEhV5W2zV8B9Fmh.jpg	t
1846	Jackson Robert Scott	\N	https://image.tmdb.org/t/p/w500/9TUjEFyHfqnVLzExlKGv26RSFAn.jpg	t
1847	Vince Romo	\N	\N	t
1848	Dinero100k	\N	\N	t
1849	Carlos Carrasco	\N	https://image.tmdb.org/t/p/w500/a9SwtLdCPYu8TRdnieWsUrUsilG.jpg	t
1850	Wilfred Lopez	\N	\N	t
1851	Lou Pizarro	\N	\N	t
1852	Loretta Vampz	\N	\N	t
1853	Brian Eric Johnson	\N	\N	t
1854	Melissa Barrera	\N	\N	t
1855	Gurl BayBee	\N	\N	t
1856	Jonah Hill	\N	https://image.tmdb.org/t/p/w500/cymlWttB83MsAGR2EkTgANtjeRH.jpg	t
1857	Kyle Chandler	\N	https://image.tmdb.org/t/p/w500/66n7XNj1dyYkzCBWR3Lq8Vz4PJ1.jpg	t
1858	Rob Reiner	\N	https://image.tmdb.org/t/p/w500/rcmPU3YlhHQVzZlV197qhmRsgEL.jpg	t
1859	Jean Dujardin	\N	https://image.tmdb.org/t/p/w500/iPtSWWoO8vajj6fIUQLQeuGOCsk.jpg	t
1860	Edward Norton	\N	https://image.tmdb.org/t/p/w500/8nytsqL59SFJTVYVrN72k6qkGgJ.jpg	t
1861	Meat Loaf	\N	https://image.tmdb.org/t/p/w500/7gKLR1u46OB8WJ6m06LemNBCMx6.jpg	t
1862	Zach Grenier	\N	https://image.tmdb.org/t/p/w500/fSyQKZO39sUsqY283GXiScOg3Hi.jpg	t
1863	Eion Bailey	\N	https://image.tmdb.org/t/p/w500/3DW13W47cKk4LQZwS4EvRaNBoVu.jpg	t
1864	Richmond Arquette	\N	https://image.tmdb.org/t/p/w500/7byGiVac0GjBSVD1h6ylZlVXZK6.jpg	t
1865	David Andrews	\N	https://image.tmdb.org/t/p/w500/36LEerIIN7gpG52mM3Ier7YWDbh.jpg	t
1866	Aaron Pierre	\N	https://image.tmdb.org/t/p/w500/z2cMMZyWzv5ztT6pFdAAjB3u7CQ.jpg	t
1867	Kelvin Harrison, Jr.	\N	https://image.tmdb.org/t/p/w500/uRViX11fZQGmO9p91ZH7QVh2l5y.jpg	t
1868	Tiffany Boone	\N	https://image.tmdb.org/t/p/w500/9LwqRFdSzxVtnutDUg98YLq0bSz.jpg	t
1869	Kagiso Lediga	\N	https://image.tmdb.org/t/p/w500/nfqx3CqFVsAMelk6ry560SuN7Y0.jpg	t
1870	Preston Nyman	\N	https://image.tmdb.org/t/p/w500/eidKvLDCRw68tG3CN6fGhvHUnW.jpg	t
1871	Blue Ivy Carter	\N	https://image.tmdb.org/t/p/w500/mnaFedkdW9TFCkky7fiiT5dfXye.jpg	t
1872	John Kani	\N	https://image.tmdb.org/t/p/w500/g7tqg3q128a5O2qXMCwVnXsow9I.jpg	t
1873	Mads Mikkelsen	\N	https://image.tmdb.org/t/p/w500/ntwPvV4GKGGHO3I7LcHMwhXfsw9.jpg	t
1874	Seth Rogen	\N	https://image.tmdb.org/t/p/w500/nYl9bvQzaPQLzlf0wf75clLN6Hi.jpg	t
1875	Billy Eichner	\N	https://image.tmdb.org/t/p/w500/kScO4moqNlDbyCTZuIoBqyaml4l.jpg	t
1876	Gloria Guida	\N	https://image.tmdb.org/t/p/w500/3h6Qwrp1OOhtUWTka4MhclTOvTa.jpg	t
1877	Lino Banfi	\N	https://image.tmdb.org/t/p/w500/j7ZOhttsQ6SeDS2c5hgxEOjlRrp.jpg	t
1878	Alvaro Vitali	\N	https://image.tmdb.org/t/p/w500/6Lel88DA599JZfxYGSBn1s1sOnM.jpg	t
1879	Leo Colonna	\N	https://image.tmdb.org/t/p/w500/dTgyKJwTOgct8CTzJCKAj0Du85x.jpg	t
1880	Mario Carotenuto	\N	https://image.tmdb.org/t/p/w500/xr7zoHY4fnmvn3ZwUoybvbSpdRG.jpg	t
1881	Annamaria Clementi	\N	https://image.tmdb.org/t/p/w500/1fVKrA4ko4DzJrlq3Z4C6A8icvx.jpg	t
1882	Lucio Montanaro	\N	https://image.tmdb.org/t/p/w500/zCJclgTAafgTgml3a2W04xgs9sG.jpg	t
1883	Francesca Romana Coluzzi	\N	https://image.tmdb.org/t/p/w500/xY0qnTCvgPXircEL8jG9bLOqc93.jpg	t
1884	Paola Senatore	\N	https://image.tmdb.org/t/p/w500/eANM2JEGMjvkJ9xPyNdxy1VWEeS.jpg	t
1885	Ermelinda De Felice	\N	https://image.tmdb.org/t/p/w500/mKfqFWTjo1AMqB3c0kFB89toHs7.jpg	t
1886	Song Kang-ho	\N	https://image.tmdb.org/t/p/w500/7dw9wIpFZ5nJZ3zqrue8t7hUUgQ.jpg	t
1887	Lee Sun-kyun	\N	https://image.tmdb.org/t/p/w500/nHFBbSFohzOUOvMxPVwe3Es2nJw.jpg	t
1888	Cho Yeo-jeong	\N	https://image.tmdb.org/t/p/w500/5MgWM8pkUiYkj9MEaEpO0Ir1FD9.jpg	t
1889	Choi Woo-shik	\N	https://image.tmdb.org/t/p/w500/hRDiuKWwe156zRjEu826eci7H3r.jpg	t
1890	Park So-dam	\N	https://image.tmdb.org/t/p/w500/fGVOikpvivopeATDy6ZzLdKYXDu.jpg	t
1891	Lee Jung-eun	\N	https://image.tmdb.org/t/p/w500/4r3K47UpSmzZ5t9cyTRRqRl9rdz.jpg	t
1892	Jang Hye-jin	\N	https://image.tmdb.org/t/p/w500/pZiQXSWwo9F4gncHfa1yw0CQjxk.jpg	t
1893	Park Myung-hoon	\N	https://image.tmdb.org/t/p/w500/5SucrxkigHss7UuJKrkfAZX5MXz.jpg	t
1894	Jung Hyeon-jun	\N	https://image.tmdb.org/t/p/w500/vZadA6ip6V2kh0VZW9RwnLcYFgW.jpg	t
1895	Rachel Zegler	\N	https://image.tmdb.org/t/p/w500/ycseVLFDnnTQ9QubleZjdbrGl4r.jpg	t
1896	Gal Gadot	\N	https://image.tmdb.org/t/p/w500/g55dgcZQkLMolkKqgP7OD2yfGXu.jpg	t
1897	Andrew Burnap	\N	https://image.tmdb.org/t/p/w500/SEFcP5hIIsmOE8G3SZxa2v8pyO.jpg	t
1898	Andrew Barth Feldman	\N	https://image.tmdb.org/t/p/w500/17rLE4Q4gKejJp1TsByGnzMpK00.jpg	t
1899	Jeremy Swift	\N	https://image.tmdb.org/t/p/w500/muRh4WbyEE4S2763bv777ywpKP3.jpg	t
1900	Jason Kravits	\N	https://image.tmdb.org/t/p/w500/kTaZGtOP3SR6kosdRLyeQayfjcF.jpg	t
1901	Martin Klebba	\N	https://image.tmdb.org/t/p/w500/schnhMaXtfv5EC7EJODTgMcfzPe.jpg	t
1902	George Salazar	\N	https://image.tmdb.org/t/p/w500/cWBFQH0r2SPGTQKskEHIA8WK1T6.jpg	t
1903	Tituss Burgess	\N	https://image.tmdb.org/t/p/w500/aSgNPpLPp8Ou1X6qHdSP6Sq7Gju.jpg	t
1904	Andy Grotelueschen	\N	https://image.tmdb.org/t/p/w500/hYlCG3IJtXZ6ajqwmEQePwMwZde.jpg	t
1905	Ryan Gosling	\N	https://image.tmdb.org/t/p/w500/asoKC7CLCqpZKZDL6iovNurQUdf.jpg	t
1906	Ariana Greenblatt	\N	https://image.tmdb.org/t/p/w500/bg9ysIhsdygPpVx2rnKDtzylfRv.jpg	t
1907	Issa Rae	\N	https://image.tmdb.org/t/p/w500/uFjimuDgBv8kckApr19t8DykxPH.jpg	t
1908	Alexandra Shipp	\N	https://image.tmdb.org/t/p/w500/98AfO5NSqWnlhIxjSg08gGYdxUG.jpg	t
1909	Emma Mackey	\N	https://image.tmdb.org/t/p/w500/l4JOGnGOAeZr3BQvAerFyvakrU0.jpg	t
1910	Hari Nef	\N	https://image.tmdb.org/t/p/w500/nNeLyxpeagY1fvbkciwp4zaat79.jpg	t
1911	Sharon Rooney	\N	https://image.tmdb.org/t/p/w500/aMsYxadSBZ2dIlULmpHZCJyL9VF.jpg	t
1912	Luciana Grasso	\N	https://image.tmdb.org/t/p/w500/htH1VAG7UFj2oNDDkoV2f9nrPeb.jpg	t
1913	Inés Estévez	\N	https://image.tmdb.org/t/p/w500/zV57im2AguAXx42YzIscEXtuaB1.jpg	t
1914	David Zoela	\N	\N	t
1915	Estefanía Nicoló	\N	\N	t
1916	Carlos Resta	\N	\N	t
1917	Mariano Raimondi	\N	\N	t
1918	Ofelia Castillo	\N	\N	t
1919	Rosamund Pike	\N	https://image.tmdb.org/t/p/w500/8ObNklHDi2hjdz0ayzJFB9jtqzm.jpg	t
1920	Neil Patrick Harris	\N	https://image.tmdb.org/t/p/w500/qZwbo23uaJU87NxE5RubbeeLTYh.jpg	t
1921	Tyler Perry	\N	https://image.tmdb.org/t/p/w500/8KU0OizemVLrERXt5HJIa0PAkIN.jpg	t
1922	Carrie Coon	\N	https://image.tmdb.org/t/p/w500/vWChiHhXFjZVKC6HbACyyRFmdW4.jpg	t
1923	Kim Dickens	\N	https://image.tmdb.org/t/p/w500/yr6kstI1hdLP6LXz2xyBB4ovduj.jpg	t
1924	Patrick Fugit	\N	https://image.tmdb.org/t/p/w500/bsONcodcqRKV97p1Oo1jcPkEnDA.jpg	t
1925	David Clennon	\N	https://image.tmdb.org/t/p/w500/jLOf8nYolcb4P8LUDOW7QK5Y9pH.jpg	t
1926	Lisa Banes	\N	https://image.tmdb.org/t/p/w500/1e3RUVpgdeDXB42c3H0ZRc1Pjk8.jpg	t
1927	Missi Pyle	\N	https://image.tmdb.org/t/p/w500/lKMPTI0PbPv6kGQiublwHOp73Ff.jpg	t
1928	Zoë Winters	\N	https://image.tmdb.org/t/p/w500/3Ej5luqqvdD3hZXAzFZbdRxj7CQ.jpg	t
1929	Marin Ireland	\N	https://image.tmdb.org/t/p/w500/jAIOQNraHjvIAdqk81QDV5Phupp.jpg	t
1930	Louisa Jacobson	\N	https://image.tmdb.org/t/p/w500/7SM6mv5zuPr99prZ5jiFEidtW4T.jpg	t
1931	Dasha Nekrasova	\N	https://image.tmdb.org/t/p/w500/iEWg6G96sOtzRphRlJCVjw7TQOt.jpg	t
1932	Emmy Wheeler	\N	https://image.tmdb.org/t/p/w500/wChh4Xns8E395lXFdXloIq6utZN.jpg	t
1933	Eddie Cahill	\N	https://image.tmdb.org/t/p/w500/duEjKuDs0UAMknHrKzQF2FcWcYC.jpg	t
1934	Sawyer Spielberg	\N	https://image.tmdb.org/t/p/w500/lntpmCf2ePFwSYC1qdfI31IFUob.jpg	t
1935	K.J. Apa	\N	https://image.tmdb.org/t/p/w500/idpwm8ZdFnndjeQ3mKleF20hvRo.jpg	t
1936	Sofia Wylie	\N	https://image.tmdb.org/t/p/w500/bH7Qo3rRCJ2gLrcYZj9xS50rg5.jpg	t
1937	Madison Thompson	\N	https://image.tmdb.org/t/p/w500/pjuUkAsn1bivbjw5XvTzQuxzIkP.jpg	t
1938	Orlando Norman	\N	https://image.tmdb.org/t/p/w500/hWnjuDPmT0YpeWIo9JKUPmz7UIM.jpg	t
1939	Josh Lucas	\N	https://image.tmdb.org/t/p/w500/ueR4CH32f22DGjFxuhnW1o3YKB3.jpg	t
1940	JR Esposito	\N	https://image.tmdb.org/t/p/w500/zPlXdFuXUz7TP6IBgQh5IdEXfbc.jpg	t
1941	Marilyn Cutts	\N	https://image.tmdb.org/t/p/w500/wKrQcMQlGhTLh7IbQOxH5A1l5VU.jpg	t
1942	Joseph William Evans	\N	\N	t
1943	Diego Ross	\N	\N	t
1944	Kim Basinger	\N	https://image.tmdb.org/t/p/w500/iqQ4o2sRna7J1Z9KkB9Avp9CIsk.jpg	t
1945	Tony Gibson	\N	\N	t
1946	Lauren Lox	\N	https://image.tmdb.org/t/p/w500/xtjVzlureRMlG59qrsGSiEURCXd.jpg	t
1947	Alexis Arnold	\N	\N	t
1948	David D. Ford	\N	\N	t
1949	Anna Faris	\N	https://image.tmdb.org/t/p/w500/y3YKNr4qPPJZ9w4lR2a3yySKotd.jpg	t
1950	Jon Abrahams	\N	https://image.tmdb.org/t/p/w500/1gQkeDCmoJ3gjq7VbwvlYKKTKTz.jpg	t
1951	Shawn Wayans	\N	https://image.tmdb.org/t/p/w500/Cat25uXhB680QLmvg9Tu16W563.jpg	t
1952	Shannon Elizabeth	\N	https://image.tmdb.org/t/p/w500/1H99EVPLMQx3C0DKrVCiFKPpDB5.jpg	t
1953	Cheri Oteri	\N	https://image.tmdb.org/t/p/w500/A56szuLpt2yttvnHB49KNUZmD4b.jpg	t
1954	Carmen Electra	\N	https://image.tmdb.org/t/p/w500/wpSCUNmxRMxHOhXJDZGCMxyMidb.jpg	t
1955	Tanja Reichert	\N	https://image.tmdb.org/t/p/w500/umFRFg5mhiLuDvvqhVxfMlOWrkm.jpg	t
1956	Lochlyn Munro	\N	https://image.tmdb.org/t/p/w500/iyEKTi04DSYLAGLLBGuqCQD5wKe.jpg	t
1957	John Cassini	\N	https://image.tmdb.org/t/p/w500/kn2Rtn0I8ivCR7ydZTY74XUBh1K.jpg	t
1958	Peter Crombie	\N	https://image.tmdb.org/t/p/w500/pMvhE1wwQo3eTSp4vwq8Hb22CwN.jpg	t
1959	Reg E. Cathey	\N	https://image.tmdb.org/t/p/w500/cgyJJQUdbK4S7ihkL9hgIIwutk3.jpg	t
1960	R. Lee Ermey	\N	https://image.tmdb.org/t/p/w500/aXFJlEGHlQT7bwxkKwq6Sx7PeEp.jpg	t
1961	Daniel Zacapa	\N	https://image.tmdb.org/t/p/w500/85Ve9cyC2RG3cY20HHv1JrtMqdC.jpg	t
1962	Andrew Kevin Walker	\N	https://image.tmdb.org/t/p/w500/t7O6bNRscxOYadGNB1EWvBaSC0d.jpg	t
1963	George Christy	\N	https://image.tmdb.org/t/p/w500/8kmZnMFtItkqASxsRtsSBZbbBBl.jpg	t
1964	Craig Fairbrass	\N	https://image.tmdb.org/t/p/w500/z5WnSqwkM0Ax0Z47etVNmcew5Pn.jpg	t
1965	Thomas Turgoose	\N	https://image.tmdb.org/t/p/w500/3PsCUvclNzVrjDGg69Q3blw83ei.jpg	t
1966	Nick Moran	\N	https://image.tmdb.org/t/p/w500/kfWebCAm72JBZLXcNbA2Myr950E.jpg	t
1967	Kierston Wareing	\N	https://image.tmdb.org/t/p/w500/lcPlix0o1cQxOWG0YbeshdvGzfj.jpg	t
1968	Leo Gregory	\N	https://image.tmdb.org/t/p/w500/hntA25YHbPiNaq8Hcx7Fw07NQsu.jpg	t
1969	Beau Fowler	\N	https://image.tmdb.org/t/p/w500/hm0p4amoCaB3ulCoIwFwCuuYSrg.jpg	t
1970	Terence Maynard	\N	https://image.tmdb.org/t/p/w500/5KQ4MOCw5fdGaaOQD4VCOfp44ww.jpg	t
1971	Ross O'Hennessy	\N	https://image.tmdb.org/t/p/w500/puxkY3ou0PJwyz1J57TZgsPpxX3.jpg	t
1972	Ruairí O'Connor	\N	https://image.tmdb.org/t/p/w500/lSnYC598qzvh20VfSDOa3tpcLBo.jpg	t
1973	Sarah Catherine Hook	\N	https://image.tmdb.org/t/p/w500/7hYMXYq70cd8DlQjZZCRrbXy9Jy.jpg	t
1974	Julian Hilliard	\N	https://image.tmdb.org/t/p/w500/lp1IJliBZb9OFP5KK09HjSGOsau.jpg	t
1975	Charlene Amoia	\N	https://image.tmdb.org/t/p/w500/8hJNPw3XCErifcZZPOfd20JmiTC.jpg	t
1976	Sterling Jerins	\N	https://image.tmdb.org/t/p/w500/10kkqqbO8Ct58DqsBPSQIsG9ve4.jpg	t
1977	Eugenie Bondurant	\N	https://image.tmdb.org/t/p/w500/9ULAELEKNha7VCJhRWoer58NcJe.jpg	t
1978	Danny Sapani	\N	https://image.tmdb.org/t/p/w500/h6goTpKA74Z6ePB2BAEEyQnGtCF.jpg	t
1979	Michael Stuhlbarg	\N	https://image.tmdb.org/t/p/w500/aYB3SQm3h6ZyAdlbGyiNfakjx56.jpg	t
1980	Julianne Nicholson	\N	https://image.tmdb.org/t/p/w500/2RJ30pPSQQxteuoMjhN1FWTwxlZ.jpg	t
1981	Caitríona Balfe	\N	https://image.tmdb.org/t/p/w500/4KQRDj74lKwU52Ewmzz7sVIakgn.jpg	t
1982	Adrian Martinez	\N	https://image.tmdb.org/t/p/w500/id70SLEpj9jelZZepJlapaXH8lR.jpg	t
1983	Jeremy Allen White	\N	https://image.tmdb.org/t/p/w500/42RGIJh7fPvJcq7eFrZ8cJ2rLwB.jpg	t
1984	Jeremy Strong	\N	https://image.tmdb.org/t/p/w500/jcMhXWICSi4QjQttJVhFSiKVvpF.jpg	t
1985	Odessa Young	\N	https://image.tmdb.org/t/p/w500/h8DtNiDJkITrsHTFMRgzoelqBJU.jpg	t
1986	David Krumholtz	\N	https://image.tmdb.org/t/p/w500/2vaimzfyPQVxZGHbQS5M3z3tZw0.jpg	t
1987	Gaby Hoffmann	\N	https://image.tmdb.org/t/p/w500/bMdxuHqCJkf4dAFKleYRs2GXDN9.jpg	t
1988	Harrison Gilbertson	\N	https://image.tmdb.org/t/p/w500/qlB00ZkN8LCReIje5PGDJ2UeCAg.jpg	t
1989	Grace Gummer	\N	https://image.tmdb.org/t/p/w500/zjkPOqC81TXDfcag90y6miEOF7M.jpg	t
1990	Al Pacino	\N	https://image.tmdb.org/t/p/w500/2dGBb1fOcNdZjtQToVPFxXjm4ke.jpg	t
1991	Robert Duvall	\N	https://image.tmdb.org/t/p/w500/ybMmK25h4IVtfE7qrnlVp47RQlh.jpg	t
1992	Diane Keaton	\N	https://image.tmdb.org/t/p/w500/tnx7pJqisfAzvXOR5wHQsbnH9XH.jpg	t
1993	Robert De Niro	\N	https://image.tmdb.org/t/p/w500/cT8htcckIuyI1Lqwt1CvD02ynTh.jpg	t
1994	John Cazale	\N	https://image.tmdb.org/t/p/w500/7uKBc2BVbLlAiHuSdfioe1OUnCX.jpg	t
1995	Talia Shire	\N	https://image.tmdb.org/t/p/w500/oktJmlLeyYKBCWPNjHskDwAfjct.jpg	t
1996	Lee Strasberg	\N	https://image.tmdb.org/t/p/w500/niSM7ejzddgaTcxjgJMYEFCr9Y2.jpg	t
1997	Michael V. Gazzo	\N	https://image.tmdb.org/t/p/w500/cTY2Hlf6sIR9xLI95bBir7eI0N.jpg	t
1998	G. D. Spradlin	\N	https://image.tmdb.org/t/p/w500/pWNa9H3ABB3Ug9CwTfVNtHsCFjV.jpg	t
1999	Richard Bright	\N	https://image.tmdb.org/t/p/w500/potMaJ2u5PRjXZb7qF9lSW1ldNZ.jpg	t
2000	유정	\N	https://image.tmdb.org/t/p/w500/gJy2W6dGndkaqrffN4LdmyHJmvv.jpg	t
2001	Han Seo-ah	\N	https://image.tmdb.org/t/p/w500/hfcHoS3o2sCLkZHJpqcnSIDaEav.jpg	t
2002	김지아	\N	https://image.tmdb.org/t/p/w500/kTBZUhZRnyKgpHJDBj68M3WOANa.jpg	t
2003	민도윤	\N	https://image.tmdb.org/t/p/w500/bHHn3krbHyxQIWb4JbHkPlV6Uu1.jpg	t
2004	Han Seok-bong	\N	https://image.tmdb.org/t/p/w500/5ABOVmENCwpAC1uXrK16luzW5g9.jpg	t
2005	Christopher Walken	\N	https://image.tmdb.org/t/p/w500/ApgDL7nudR9T2GpjCG4vESgymO2.jpg	t
2006	Léa Seydoux	\N	https://image.tmdb.org/t/p/w500/2ZyK2a1fKvUXlhKBORpqcMd4Uot.jpg	t
2007	Omar Sy	\N	https://image.tmdb.org/t/p/w500/ftoP3CMC4ob8VJAu1gEHSC714K5.jpg	t
2008	Sara Giraudeau	\N	https://image.tmdb.org/t/p/w500/tPjI1YgAgWMYRHpPfyqpRrOynbL.jpg	t
2009	Pascale Arbillot	\N	https://image.tmdb.org/t/p/w500/sFLTfpEqhkEYwYKWxrWlGW2CVXt.jpg	t
2010	Alban Ivanov	\N	https://image.tmdb.org/t/p/w500/mqOnSEZb3hkq973YyQnFEaBm9mN.jpg	t
2011	Cindy Bruna	\N	https://image.tmdb.org/t/p/w500/Ae6e2WwMJwVLofxOZ4xbHnamABE.jpg	t
2012	Benoît Crou	\N	https://image.tmdb.org/t/p/w500/yvq6C3L3KxQWxDzH8ImR7h5rd5j.jpg	t
2013	Agnès Hurstel	\N	https://image.tmdb.org/t/p/w500/f1mq1z7L6uz1O0nAXOMOf8rQCqf.jpg	t
2014	Xavier Lacaille	\N	https://image.tmdb.org/t/p/w500/oBqXWHrPi48D9tVIgPGnsfzJAlv.jpg	t
2015	Amaury de Crayencour	\N	https://image.tmdb.org/t/p/w500/jmyKusA9ETzSzajpppC440GBlEp.jpg	t
2016	Isabelle Candelier	\N	https://image.tmdb.org/t/p/w500/sR3AtjW3DywjyOSlk09rwi1hTOU.jpg	t
2017	Val Kilmer	\N	https://image.tmdb.org/t/p/w500/sWH9jTD0bC5gWhhceUlzfNiNup0.jpg	t
2018	Jennifer Connelly	\N	https://image.tmdb.org/t/p/w500/slHm9S8ngBOUwbUoip5iNFjNRBc.jpg	t
2019	Bashir Salahuddin	\N	https://image.tmdb.org/t/p/w500/ZL5MRzjd6kWkvQXqh5mgPY1CKP.jpg	t
2020	Jon Hamm	\N	https://image.tmdb.org/t/p/w500/mrXE5fZbEDPc7BEE5G21J6qrwzi.jpg	t
2021	Charles Parnell	\N	https://image.tmdb.org/t/p/w500/wLywO5xtR97YKtkYb57hXEFpL7j.jpg	t
2022	Monica Barbaro	\N	https://image.tmdb.org/t/p/w500/hiOYXzSkkuKyCEcjLxBoAc4bLZS.jpg	t
2023	Jay Ellis	\N	https://image.tmdb.org/t/p/w500/78JH7CfMrWrI3Vx2XLbx0GW4c2X.jpg	t
2024	Mickey Rourke	\N	https://image.tmdb.org/t/p/w500/i6vXukUwRsJa7S9yhZgoKt9xLDv.jpg	t
2025	John Slattery	\N	https://image.tmdb.org/t/p/w500/aIjTxEWo7SmRR8iBCFfZIhylSul.jpg	t
2026	Garry Shandling	\N	https://image.tmdb.org/t/p/w500/zGjPMqSqtZtP3npd5fhm7MYqxIU.jpg	t
2027	Emmy Raver-Lampman	\N	https://image.tmdb.org/t/p/w500/cBkHUBzqoqrnkxDXWlqQmm91pD2.jpg	t
2028	Josh Hutcherson	\N	https://image.tmdb.org/t/p/w500/f0eosZ1Fx0VBUyspq8K2f8sUSBn.jpg	t
2029	Jeremy Irons	\N	https://image.tmdb.org/t/p/w500/w8Ct1q02Ht3sWdOSqfp3B85TzT.jpg	t
2030	Bobby Naderi	\N	https://image.tmdb.org/t/p/w500/3jfEwF7vyCTIDPPm2OFoFlEEVA0.jpg	t
2031	David Witts	\N	https://image.tmdb.org/t/p/w500/kqelxzQqffd1Qcz8VKOYSpoP7p8.jpg	t
2032	Michael Epp	\N	https://image.tmdb.org/t/p/w500/3Nz3sX7QISm5e6mWNvJDKUD2Qyd.jpg	t
2033	Taylor James	\N	https://image.tmdb.org/t/p/w500/sMMCf0O7GcbJZoxmyWAbU6CsN6B.jpg	t
2034	Phylicia Rashād	\N	https://image.tmdb.org/t/p/w500/orbTpG0jaYkPR167TNiEg0AKG3M.jpg	t
2035	Jemma Redgrave	\N	https://image.tmdb.org/t/p/w500/1Lgtd9zpwwuyKqjmd5ME2lN9FUq.jpg	t
2036	John Malkovich	\N	https://image.tmdb.org/t/p/w500/bAvm8SQrYBkjy31tPh3QWkeqtII.jpg	t
2037	Juliette Lewis	\N	https://image.tmdb.org/t/p/w500/vvitS2sZSM9RupCf5B0sZYNS6wT.jpg	t
2038	Murray Bartlett	\N	https://image.tmdb.org/t/p/w500/eN20zfcRB2F51bmUbTK9byQCpb9.jpg	t
2039	Melissa Chambers	\N	https://image.tmdb.org/t/p/w500/1d2rGqa7lDmHDxAIYiVqPPe3mgn.jpg	t
2040	Stephanie Suganami	\N	https://image.tmdb.org/t/p/w500/5ekTR5ZNxglymhMiGd8nuYoWZuv.jpg	t
2041	Mark Sivertsen	\N	https://image.tmdb.org/t/p/w500/MXbRFhkhmu1qpAD2vqyPaAfuNt.jpg	t
2042	Amber Midthunder	\N	https://image.tmdb.org/t/p/w500/f8VWGyaIS38NkDIzQ2hapXKt0N5.jpg	t
2043	Tatanka Means	\N	https://image.tmdb.org/t/p/w500/Aq7VrwQeUeDNn0y74m7bxDBOAGj.jpg	t
2044	高捷	\N	https://image.tmdb.org/t/p/w500/i8YxYsAxMKAq6xUgMLS6sAxMCaM.jpg	t
2045	蔡振南	\N	https://image.tmdb.org/t/p/w500/5PCVlObA9bt4kHagfoEN5SF2NW9.jpg	t
2046	太保	\N	https://image.tmdb.org/t/p/w500/4AtGJBlRvgzRHzYUZxkZk9kUE61.jpg	t
2047	金介文	\N	https://image.tmdb.org/t/p/w500/lZWdwrjVBlkWoRcm9PrNUBQgmLX.jpg	t
2048	龍天翔	\N	https://image.tmdb.org/t/p/w500/nVJu60ttp83lx5mvMFT8IQhTB4c.jpg	t
2049	崔浩然	\N	https://image.tmdb.org/t/p/w500/zVt0kf3R0C8NbmtymOUYigIJE9c.jpg	t
2050	王識賢	\N	https://image.tmdb.org/t/p/w500/hZMiRV1xZ5xJU6toqzWhknSReW3.jpg	t
2051	夏靖庭	\N	https://image.tmdb.org/t/p/w500/cmoioYTVZo7PEOoLIcuw098DAV3.jpg	t
2052	孫鵬	\N	https://image.tmdb.org/t/p/w500/y1aqaTJA5yIcdMVQCknmyanTr24.jpg	t
2053	Tender Huang	\N	https://image.tmdb.org/t/p/w500/7Q25uTpAuAdGF82N53FG5Jmajeq.jpg	t
2054	Carlo Aquino	\N	https://image.tmdb.org/t/p/w500/zS6iKXz8HKIozguTi3KzN3OUZn1.jpg	t
2055	Bing Pimentel	\N	https://image.tmdb.org/t/p/w500/fJQ88MiwK1n9z5PEKpwEMtYnaFN.jpg	t
2056	Beauty Gonzalez	\N	https://image.tmdb.org/t/p/w500/3idu5IUTSEfJQ6usqyYmtrvzjld.jpg	t
2057	Jasmine Curtis-Smith	\N	https://image.tmdb.org/t/p/w500/kcjYTBjf7q7pdFEBe1L9UxriPGY.jpg	t
2058	Erin Rose Espiritu	\N	https://image.tmdb.org/t/p/w500/rgER8Jca5WmRP1pyXrc5yxUDaBA.jpg	t
2059	Cristine Reyes	\N	https://image.tmdb.org/t/p/w500/jHv8apcyAJLsZQdN3id2iGzGvvi.jpg	t
2060	Rita Avila	\N	https://image.tmdb.org/t/p/w500/dFVun5vzDw9dOUTnHeiuvepcopM.jpg	t
2061	Archie Adamos	\N	https://image.tmdb.org/t/p/w500/p6Ix8lZJHy5SASjQ4cqbDyrI1HG.jpg	t
2062	Allan Paule	\N	https://image.tmdb.org/t/p/w500/hzsUDaCiDI3IwRMN6H5ucdtNr5N.jpg	t
2063	Bembol Roco	\N	https://image.tmdb.org/t/p/w500/kqNUAdvCZkarhCpMrM7INHcygxm.jpg	t
2064	ธีรเดช วงศ์พัวพันธ์	\N	https://image.tmdb.org/t/p/w500/pKcJU0RBTo7LZYPIwpA5Xg8niE7.jpg	t
2065	วชิรวิชญ์ อรัญธนวงศ์	\N	https://image.tmdb.org/t/p/w500/f56RHtAKa31opj17YJ1Nmz8WRKm.jpg	t
2066	จุลจักร จักรพงษ์	\N	https://image.tmdb.org/t/p/w500/kxbaHbvigI7vDYLNtfbzOQ86plr.jpg	t
2067	ฟาติมา เดชะวลีกุล	\N	https://image.tmdb.org/t/p/w500/6Re8Sd6YTwgybN1fxDcClagp6ZO.jpg	t
2068	กุลณัฐ กุลปรียาวัฒน์	\N	https://image.tmdb.org/t/p/w500/yrzRhwM8oFdD8gUJQiGmpGkfH36.jpg	t
2069	จิรายุทธ ผโลประการ	\N	https://image.tmdb.org/t/p/w500/7dAQFum5Cs5s2wgoCGu79tTnuto.jpg	t
2070	ปีติภัทร คูตระกูล	\N	https://image.tmdb.org/t/p/w500/fDjN8dL3SvKOsAGhNHztd4ajEkA.jpg	t
2071	Alisa Intusmith	\N	https://image.tmdb.org/t/p/w500/ftGwLTMeVJ4ar17322NuhnOQDym.jpg	t
2072	คมสัน นันทจิต	\N	\N	t
2073	Naracha Chanthasin	\N	\N	t
2074	Neve Campbell	\N	https://image.tmdb.org/t/p/w500/eojcMcfl7fZbvElRSg89r7zyFfY.jpg	t
2075	David Arquette	\N	https://image.tmdb.org/t/p/w500/8J68lAEKjx5z2Aj7hhDtQ2YQffv.jpg	t
2076	Courteney Cox	\N	https://image.tmdb.org/t/p/w500/yA8dicwtcVuxG3gh94QsaRb5gNb.jpg	t
2077	Rose McGowan	\N	https://image.tmdb.org/t/p/w500/x8sHWjQ7cWVcHKhqGR09x0Y0tsP.jpg	t
2078	Matthew Lillard	\N	https://image.tmdb.org/t/p/w500/auUbijDzR9xpSgQtLsYDvNatloj.jpg	t
2079	Skeet Ulrich	\N	https://image.tmdb.org/t/p/w500/moyTBJUTl82PaAhm8aHGwlvKr7r.jpg	t
2080	Jamie Kennedy	\N	https://image.tmdb.org/t/p/w500/ipfv0IU3VYGOz5OBmi9WJi5autF.jpg	t
2081	Joseph Whipp	\N	https://image.tmdb.org/t/p/w500/1ZRu1apOXYDvNjhci0wzXdtlOlW.jpg	t
2082	W. Earl Brown	\N	https://image.tmdb.org/t/p/w500/oBHcJc65nUmopx6lVc9ZvYYARZz.jpg	t
2083	Antoine Bertrand	\N	https://image.tmdb.org/t/p/w500/uVVAjRMb7eVOehWRkE6shiMspuK.jpg	t
2084	Marguerite Laurence	\N	https://image.tmdb.org/t/p/w500/5XsbkeE6N3B9v8HXHFhQNGiGZFe.jpg	t
2085	Mateo Laurent Membreño Daigle	\N	https://image.tmdb.org/t/p/w500/qr1VzWooUZI9DdZBrRNesRZESFF.jpg	t
2086	Mani Soleymanlou	\N	https://image.tmdb.org/t/p/w500/smyJHRcsF3tFJQpQkzG2fldcTSl.jpg	t
2087	Marilyn Castonguay	\N	https://image.tmdb.org/t/p/w500/k7X3ojSMfmhgwGIpCSthuzNzVbA.jpg	t
2088	Ellen David	\N	https://image.tmdb.org/t/p/w500/kODfwKI8AD5ZI3Yb9IcAeOxxMKQ.jpg	t
2089	François Chénier	\N	https://image.tmdb.org/t/p/w500/A0OulG52q8vJmfA12ichwcduPiE.jpg	t
2090	Benoît Gouin	\N	https://image.tmdb.org/t/p/w500/gk9ATIRu5EeMoK0VYNK7TOS7XDc.jpg	t
2091	Jean-François Provençal	\N	https://image.tmdb.org/t/p/w500/stB9jXKbqH9x2BqF9hje8IEhV9Y.jpg	t
2092	Louise Turcot	\N	https://image.tmdb.org/t/p/w500/iju8cFb9rZGCLq7AaJq1zaLL9Ad.jpg	t
2093	Michelle Dockery	\N	https://image.tmdb.org/t/p/w500/pgPJGf2wAPgoC6Bp5PBJYQV7IVt.jpg	t
2094	Joanne Froggatt	\N	https://image.tmdb.org/t/p/w500/vT9YPjgqJ2CRAkhvsbZlI0i5h4M.jpg	t
2095	Elizabeth McGovern	\N	https://image.tmdb.org/t/p/w500/e69zJZNlRMDGaXuYaybnCPiJ8Cy.jpg	t
2096	Laura Carmichael	\N	https://image.tmdb.org/t/p/w500/ab4ATHYMzFzxfF2VdpoXwqkrfqR.jpg	t
2097	Dominic West	\N	https://image.tmdb.org/t/p/w500/6y2M3EWslBPwPlugEFg8XDHfSJ0.jpg	t
2098	Paul Giamatti	\N	https://image.tmdb.org/t/p/w500/kn7LAbFYP5RPC2r61tDx2CRUeuw.jpg	t
2099	Hugh Bonneville	\N	https://image.tmdb.org/t/p/w500/skbxj8MUuNiI39ZkP38uEirU0bC.jpg	t
2100	Allen Leech	\N	https://image.tmdb.org/t/p/w500/cJZSyKNUKwdNPEgkt2ocXohtUBH.jpg	t
2101	Michael Fox	\N	https://image.tmdb.org/t/p/w500/rXMf9BWNuIRr5FcFncQz7HPJBOy.jpg	t
2102	Shameik Moore	\N	https://image.tmdb.org/t/p/w500/mGF5ihrMt1MCxDvEOK2MO6YcNLt.jpg	t
2103	Brian Tyree Henry	\N	https://image.tmdb.org/t/p/w500/1UgDnFt3OteCJQPiUelWzIR5bvT.jpg	t
2104	Luna Lauren Velez	\N	https://image.tmdb.org/t/p/w500/98BvmTJCZHx0jPv0oNcv04Jkmfb.jpg	t
2105	Jake Johnson	\N	https://image.tmdb.org/t/p/w500/3UNfW2qZgRkW81neNVfQvaRC92K.jpg	t
2106	Jason Schwartzman	\N	https://image.tmdb.org/t/p/w500/gCjMdmW1DiPAClHVl4zHEIffIsE.jpg	t
2107	Daniel Kaluuya	\N	https://image.tmdb.org/t/p/w500/jj2kZqJobjom36wlhlYhc38nTwN.jpg	t
2108	Karan Soni	\N	https://image.tmdb.org/t/p/w500/t3eNrzRKy3wTVCUiEp002UXbjxX.jpg	t
2109	Chloë Grace Moretz	\N	https://image.tmdb.org/t/p/w500/yjvE3aovyTvebAOalNaI3t6KkjQ.jpg	t
2110	Haley Bennett	\N	https://image.tmdb.org/t/p/w500/8HRgGypSwHeI27ffmcAELNoxIOw.jpg	t
2111	Bill Pullman	\N	https://image.tmdb.org/t/p/w500/AlLhgmcX5zh3frPT82OSPY9gqXO.jpg	t
2112	Melissa Leo	\N	https://image.tmdb.org/t/p/w500/tKNTvhmuO7FZMYYgRrZB6k8FT5K.jpg	t
2113	David Meunier	\N	https://image.tmdb.org/t/p/w500/8gLRTQxeTUVtgGGb302f80peoMq.jpg	t
2114	Johnny Skourtis	\N	https://image.tmdb.org/t/p/w500/4TjXylYMTEUbAqavF6cuP3QhnBb.jpg	t
2115	Alex Veadov	\N	https://image.tmdb.org/t/p/w500/bpJKpwpYSgnSkjAA5SX50Wwr0Qa.jpg	t
2116	Ray Romano	\N	https://image.tmdb.org/t/p/w500/zWT03QvuVYySlrjmHCojKrNYjoC.jpg	t
2117	John Leguizamo	\N	https://image.tmdb.org/t/p/w500/kwYCdxTlDh9zauUCg4mp2XTCQTw.jpg	t
2118	Denis Leary	\N	https://image.tmdb.org/t/p/w500/9pMR9QhURdJ3xxdHeNVOKF5M81b.jpg	t
2119	Goran Višnjić	\N	https://image.tmdb.org/t/p/w500/2jFpq46QPjCbRmmGYdW9WSVC47W.jpg	t
2120	Cedric the Entertainer	\N	https://image.tmdb.org/t/p/w500/s6UrY5uofyxXsU5PydWBoLFReK0.jpg	t
2121	Diedrich Bader	\N	https://image.tmdb.org/t/p/w500/z7CctykPTuXDfAs7pkAA7vW4b3T.jpg	t
2122	Lorri Bagley	\N	https://image.tmdb.org/t/p/w500/73ZDCsvbvScwlYA26sAvYqAkOjI.jpg	t
2123	Sophie Turner	\N	https://image.tmdb.org/t/p/w500/8ur4aHFakVCinWk0cvrGO8qAUhv.jpg	t
2124	Rhys Coiro	\N	https://image.tmdb.org/t/p/w500/pjPbrZHU0kJUiMOPYfxK8FeBwWQ.jpg	t
2125	Billy Campbell	\N	https://image.tmdb.org/t/p/w500/hMNmtQK3a6mqIQRyXn9G5bbheJV.jpg	t
2126	Peter Mensah	\N	https://image.tmdb.org/t/p/w500/72L6LbeF5ZqRdLmhibNqysQNQRg.jpg	t
2127	Forrest Goodluck	\N	https://image.tmdb.org/t/p/w500/bJk2atLajV2o4GnwkJgMpq5WPXN.jpg	t
2128	Gianni Paolo	\N	https://image.tmdb.org/t/p/w500/kOnw2g6peFQ8H8Rpj0h1LNglotF.jpg	t
2129	Renata Vaca	\N	https://image.tmdb.org/t/p/w500/zsa1B7cOTa1o7inR2zmoznxL9Hm.jpg	t
2130	Katey Sagal	\N	https://image.tmdb.org/t/p/w500/jdnBWdXlQG2Q2F6v9MPJkaWQ9Vd.jpg	t
2131	Milton Darnell Smith	\N	\N	t
2132	Victor Oliveira	\N	\N	t
2133	Paul Dano	\N	https://image.tmdb.org/t/p/w500/zEJJsm0z07EPNl2Pi1h67xuCmcA.jpg	t
2134	John Turturro	\N	https://image.tmdb.org/t/p/w500/6O9W9cJW0kCqMzYeLupV9oH0ftn.jpg	t
2135	Peter Sarsgaard	\N	https://image.tmdb.org/t/p/w500/jOc4VjxPaOkWOqnLCxd8BJy9g5i.jpg	t
2136	Barry Keoghan	\N	https://image.tmdb.org/t/p/w500/15xPjrzSbtXlbQUhmLpQUil4tCN.jpg	t
2137	Imogen Poots	\N	https://image.tmdb.org/t/p/w500/7uMFX0ecPZT2tc8L5DFFNbUckc9.jpg	t
2138	Brett Goldstein	\N	https://image.tmdb.org/t/p/w500/xYdFNE7EkncE8uiPJzT3RrkqcAQ.jpg	t
2139	Zawe Ashton	\N	https://image.tmdb.org/t/p/w500/zbxVfvhPhCfgpgmWTdtHWurNqYu.jpg	t
2140	Steven Cree	\N	https://image.tmdb.org/t/p/w500/oH9uSQMJPdFHeVggqvMwheW7nZl.jpg	t
2141	Jenna Coleman	\N	https://image.tmdb.org/t/p/w500/pylSrUkaLzDvfflyMnU32eY0vrN.jpg	t
2142	Éva Magyar	\N	https://image.tmdb.org/t/p/w500/r6l5CydyL3nQebzhYWlUomzlPMV.jpg	t
2143	Alara-Star Khan	\N	\N	t
2144	Tariq Rasheed	\N	https://image.tmdb.org/t/p/w500/bXsrJgaV6Uu0wImwZPHOlCkGNfs.jpg	t
2145	Nadia Albina	\N	https://image.tmdb.org/t/p/w500/zFIWlR7ubAAl59jWGAMoCWmGKL9.jpg	t
2146	Ieva Andrejevaitė	\N	https://image.tmdb.org/t/p/w500/az662GSz0j8LQaVbJMdBekicJjZ.jpg	t
2147	Tiger Shroff	\N	https://image.tmdb.org/t/p/w500/kgvll1RBCcDTs6KJZFDb291AuZb.jpg	t
2148	Sanjay Dutt	\N	https://image.tmdb.org/t/p/w500/oq4pnvWhl1HxKpp0KVlSfAr3Tiu.jpg	t
2149	Sonam Bajwa	\N	https://image.tmdb.org/t/p/w500/tWLa5BvZ62MaJNoyqflzByx7WCt.jpg	t
2150	Harnaaz Kaur Sandhu	\N	https://image.tmdb.org/t/p/w500/Aiiqemy0G8WDKtDw1fWHqfR50Yx.jpg	t
2151	Shabbir Ahluwalia	\N	https://image.tmdb.org/t/p/w500/yDuCNtLaE7auA11GUKeGmRxl7Ig.jpg	t
2152	Sunny Hinduja	\N	https://image.tmdb.org/t/p/w500/8x08qf2ESUpU5aVh1m4PfLdqBkG.jpg	t
2153	Raj Zutshi	\N	https://image.tmdb.org/t/p/w500/aJmWL08uj2oVGd2cJmBuzNSO2LY.jpg	t
2154	Sai Ketan Rao	\N	https://image.tmdb.org/t/p/w500/m9xIlFJOGpvON52NA2xEu4u7WFr.jpg	t
2155	Mahesh Thakur	\N	https://image.tmdb.org/t/p/w500/a25tark0IJAKTo8mPYswshy7hWR.jpg	t
2156	Pankaj Tripathi	\N	https://image.tmdb.org/t/p/w500/f3Vxz0QB7PHeyPcXrfJX14Xkxnu.jpg	t
2157	Bette Midler	\N	https://image.tmdb.org/t/p/w500/ooPKeoLvwacY6BRj99u7uvZCYlF.jpg	t
2158	Sarah Jessica Parker	\N	https://image.tmdb.org/t/p/w500/tEhHY7Uyn8VktwLhawBRuR0tdaJ.jpg	t
2159	Kathy Najimy	\N	https://image.tmdb.org/t/p/w500/pwzkG00mjA6meR4uyZL0oaT5kbO.jpg	t
2160	Omri Katz	\N	https://image.tmdb.org/t/p/w500/wY3NxTyXhzJ8BkmBZcQuSE7WtoC.jpg	t
2161	Thora Birch	\N	https://image.tmdb.org/t/p/w500/m0D1wqgQeVCr7gWY7GVej7lZlwY.jpg	t
2162	Vinessa Shaw	\N	https://image.tmdb.org/t/p/w500/qqSpAMH1lYMNxnHkDHB1JpNa086.jpg	t
2163	Tobias Jelinek	\N	https://image.tmdb.org/t/p/w500/rGHghEJ13ez2uvTQ3SNPB7LoW75.jpg	t
2164	Larry Bagby	\N	https://image.tmdb.org/t/p/w500/43N0fBlRV7NFnggRsIQ1s7McFMO.jpg	t
2165	Amanda Shepherd	\N	https://image.tmdb.org/t/p/w500/aJmRnDlGqO76hwDzPeg9QnyVmEk.jpg	t
2166	Shia LaBeouf	\N	https://image.tmdb.org/t/p/w500/ljlpaXEManszxIcshYQoqo4au03.jpg	t
2167	Logan Lerman	\N	https://image.tmdb.org/t/p/w500/wEte1WtpzwNzhA9adib1rJGbTvb.jpg	t
2168	Jim Parrack	\N	https://image.tmdb.org/t/p/w500/kojTolzA20itC8zd82QVaeTfQsJ.jpg	t
2169	Brad William Henke	\N	https://image.tmdb.org/t/p/w500/ynte6cntUQ87iZcbWMxesf7mD59.jpg	t
2170	Kevin Vance	\N	https://image.tmdb.org/t/p/w500/w0CsNlqcGxBhIuJ94vEDMY7gcRz.jpg	t
2171	Xavier Samuel	\N	https://image.tmdb.org/t/p/w500/gHvKqCXfpzaGp46gqsy9MVDfmSf.jpg	t
2172	Tom Skerritt	\N	https://image.tmdb.org/t/p/w500/xP2BNCa5NixphQOpFCl44B0HWgW.jpg	t
2173	Veronica Cartwright	\N	https://image.tmdb.org/t/p/w500/wIqQnSU4HJLYS2JE4S6jjyb2jMP.jpg	t
2174	Harry Dean Stanton	\N	https://image.tmdb.org/t/p/w500/sTOaAZ2CecGYa1DRTDDaqi70Mus.jpg	t
2175	John Hurt	\N	https://image.tmdb.org/t/p/w500/bjNSzt1d7uK3q5PbtFXUJrRt4qg.jpg	t
2176	Yaphet Kotto	\N	https://image.tmdb.org/t/p/w500/f0jquWLj22hvYf6PTIggdolhiDx.jpg	t
2177	Bolaji Badejo	\N	https://image.tmdb.org/t/p/w500/7ddxWlDIOVKBK6TjP66vb9Qp3MW.jpg	t
2178	Helen Horton	\N	https://image.tmdb.org/t/p/w500/ghK0UV1cMPThtRmx5vn9dbDwRYb.jpg	t
2179	Sadie Katz	\N	https://image.tmdb.org/t/p/w500/ucIe5yGkVVoyLqSkQMpPZaA7B4y.jpg	t
2180	Christian Howard	\N	https://image.tmdb.org/t/p/w500/xhNcDeMzgUxSdiyzcDCCRljeu0w.jpg	t
2181	Mike Ferguson	\N	https://image.tmdb.org/t/p/w500/20R1lPw9vqfiv9iyegYoI7ifofW.jpg	t
2182	Katarina Leigh Waters	\N	https://image.tmdb.org/t/p/w500/t7GK8S8qlRXynmHf9aBL9BnvflF.jpg	t
2183	Jazlyn Nicolette Sward	\N	https://image.tmdb.org/t/p/w500/p3CzKK3vVE8SYmv3AJWj3gcJlhR.jpg	t
2184	Alex Rinehart	\N	https://image.tmdb.org/t/p/w500/hLPAKNtutEA4iMNMJTj3ynsJtZJ.jpg	t
2185	Shannon Ritch	\N	https://image.tmdb.org/t/p/w500/mXFyY3iizM2zKjgSwi1ydBl5Hgq.jpg	t
2186	Baker Chase Powell	\N	https://image.tmdb.org/t/p/w500/sEqFcESUZqeWIkMfmeBSq8kQZvj.jpg	t
2187	Abigail Spear	\N	\N	t
2188	Tank Jones	\N	https://image.tmdb.org/t/p/w500/cUMseyEe7JxY0uAZm76PyCX4hm8.jpg	t
2189	Sophie Cookson	\N	https://image.tmdb.org/t/p/w500/3HrHnpDFjHIdHNeEyhEdzh6L6jd.jpg	t
2190	Claes Bang	\N	https://image.tmdb.org/t/p/w500/fqSBUq2UEoQYuqjjKNMQzDVxZv2.jpg	t
2191	Alba August	\N	https://image.tmdb.org/t/p/w500/jokW9fcmlEIGyDegZCNIYM8LXQS.jpg	t
2192	Mikkel Boe Følsgaard	\N	https://image.tmdb.org/t/p/w500/oKC5KLsbj0npfRJA3j9nEIMglmg.jpg	t
2193	Jakob Oftebro	\N	https://image.tmdb.org/t/p/w500/ypyMSXwABVXHjTOfpEHW008cw1A.jpg	t
2194	Ulrich Thomsen	\N	https://image.tmdb.org/t/p/w500/2D4ZA0QtTmuAgzzZfZdHdYJJf5x.jpg	t
2195	Emily Beecham	\N	https://image.tmdb.org/t/p/w500/12zgj8SvKEUML1kRC0CUlyxpJ6r.jpg	t
2196	Thomas Chaanhing	\N	https://image.tmdb.org/t/p/w500/zGYtPCqOn2OsFRAOTXYUV0f01Sq.jpg	t
2197	Kate Ashfield	\N	https://image.tmdb.org/t/p/w500/rtuYpo9W4AsCvI1I6brIdHe7qi.jpg	t
2198	Adam Pålsson	\N	https://image.tmdb.org/t/p/w500/sdBaRl4pG3qUGOyASo3lcLll1p4.jpg	t
2199	Lily Tomlin	\N	https://image.tmdb.org/t/p/w500/eoFMSqRykiaXMGCiz7Kxehfqy1W.jpg	t
2200	John Mulaney	\N	https://image.tmdb.org/t/p/w500/i3dGv3WoIONVLSlOpW4NIaT8Fs2.jpg	t
2201	Kimiko Glenn	\N	https://image.tmdb.org/t/p/w500/6QnVIyHKbzx0ZsUr3BmIwnZxujL.jpg	t
2202	Donnie Yen	\N	https://image.tmdb.org/t/p/w500/hTlhrrZMj8hZVvD17j4KyAFWBHc.jpg	t
2203	Hiroyuki Sanada	\N	https://image.tmdb.org/t/p/w500/SOwDxhGnRccP2lAtssQ7TxCzOe.jpg	t
2204	Rina Sawayama	\N	https://image.tmdb.org/t/p/w500/yoo4ZcHjF4G51UDBj7omUQrClYI.jpg	t
2205	肖战	\N	https://image.tmdb.org/t/p/w500/468n73j2sSJIbfZvsIZvDpvUaS8.jpg	t
2206	Zhuang Dafei	\N	https://image.tmdb.org/t/p/w500/fDmUWKtYKudny2xUr7EwTF77GQv.jpg	t
2207	张文昕	\N	https://image.tmdb.org/t/p/w500/qQ4NgIWCY9lXKMsgp88uCXcpE2J.jpg	t
2208	巴雅尔图	\N	\N	t
2209	阿如那	\N	https://image.tmdb.org/t/p/w500/loohGJbdGzpqdRRAKqkGym9t5x.jpg	t
2210	蔡少芬	\N	https://image.tmdb.org/t/p/w500/z1EVQ4junnBDj5ySqwq9nqogXq1.jpg	t
2211	胡军	\N	https://image.tmdb.org/t/p/w500/3RXwZKvACtHdnrmOvQbJWJa718W.jpg	t
2212	吳興國	\N	https://image.tmdb.org/t/p/w500/u5IK5de0GkwYwyYeub1K3IXCDqx.jpg	t
2213	元彬	\N	https://image.tmdb.org/t/p/w500/d2QGOaucb7QLovnAQaRxnT7heCK.jpg	t
2214	Winona Ryder	\N	https://image.tmdb.org/t/p/w500/dlffgYbqr1BllWacVLhAFw23nLl.jpg	t
2215	Dianne Wiest	\N	https://image.tmdb.org/t/p/w500/axqtFLgJNNz0N9i443USHCOvrmY.jpg	t
2216	Anthony Michael Hall	\N	https://image.tmdb.org/t/p/w500/nLthzoCuNxxd3KteIrnnMg1066G.jpg	t
2217	Kathy Baker	\N	https://image.tmdb.org/t/p/w500/34zuI0qWTD5jdqmJRtPwaW70JcQ.jpg	t
2218	Robert Oliveri	\N	https://image.tmdb.org/t/p/w500/nVQaZ3cBGPXYzPheCoYpCV2Vz7I.jpg	t
2219	Conchata Ferrell	\N	https://image.tmdb.org/t/p/w500/1CuSudlDbvrhFSpXPckzlMfzLiJ.jpg	t
2220	Caroline Aaron	\N	https://image.tmdb.org/t/p/w500/7nnic1Dao3XoScrwX7Ac39N2BC1.jpg	t
2221	Dick Anthony Williams	\N	https://image.tmdb.org/t/p/w500/bmbeMlCaH2FIO7ahDsrOrOJIzMh.jpg	t
2222	O-Lan Jones	\N	https://image.tmdb.org/t/p/w500/wtedyve8ATBen9YSuEe2Q2ytt1P.jpg	t
2223	Simon McBurney	\N	https://image.tmdb.org/t/p/w500/h0J9UH1g1C0c8T8x1mjvfUv5X5f.jpg	t
2224	Azi Acosta	\N	https://image.tmdb.org/t/p/w500/ANDA47GMfwbCtHfKafl09rcv6c.jpg	t
2225	Apple Dy	\N	https://image.tmdb.org/t/p/w500/QMETB1ypQs7rGgdCDwcTW0hCxR.jpg	t
2226	Rinoa Halili	\N	https://image.tmdb.org/t/p/w500/eEEKU8yEDerClctEXWozWP7XBkp.jpg	t
2227	Julianne Richards	\N	https://image.tmdb.org/t/p/w500/6PJajsIRlmBsnr9euVJzBxqVHmU.jpg	t
2228	Jackie Lyn Barcebal	\N	https://image.tmdb.org/t/p/w500/2rT2KeqDrOXoagbh070sWsN0TEy.jpg	t
2229	Maria Denice Valeda	\N	https://image.tmdb.org/t/p/w500/2im0WE48A48MErCbsMwzode9Go7.jpg	t
2230	Bobby Bonifacio	\N	https://image.tmdb.org/t/p/w500/ilVvkXRj4On7lPslEIDaUD8PuxM.jpg	t
2231	Lily James	\N	https://image.tmdb.org/t/p/w500/o40Uh2rfFWSqNN6heOWHkuxvjAd.jpg	t
2232	Ben Schnetzer	\N	https://image.tmdb.org/t/p/w500/drpFFDyWj2jeoX5I1D1WhUfcCCx.jpg	t
2233	Myha'la	\N	https://image.tmdb.org/t/p/w500/hRc3igngt5dkpM08i0a3z7gkYWa.jpg	t
2234	Jackson White	\N	https://image.tmdb.org/t/p/w500/dXTJFTkti0mpssgsYvMa00W59jB.jpg	t
2235	Dan Stevens	\N	https://image.tmdb.org/t/p/w500/fFsgginZKH527o38ZfdDxuzx7Ew.jpg	t
2236	Ian Colletti	\N	\N	t
2237	Mary Neely	\N	https://image.tmdb.org/t/p/w500/wpr7XNQnYkyPHzNfhgAmlHM4gSl.jpg	t
2238	Ana Yi Puig	\N	https://image.tmdb.org/t/p/w500/5udYjUOB1y3PzjpgMTggvul5Klz.jpg	t
2239	Aidan Laprete	\N	https://image.tmdb.org/t/p/w500/ipfzLeDycmV9qqpiyN4yzGj8Ure.jpg	t
2240	Pedro Correa	\N	https://image.tmdb.org/t/p/w500/vxM1aSGAY5hLDdi1siCD3OqaBNG.jpg	t
2241	Nicholas Galitzine	\N	https://image.tmdb.org/t/p/w500/hG4rH7eBMs117746bBOd8fUa4PA.jpg	t
2242	Ella Rubin	\N	https://image.tmdb.org/t/p/w500/8AKz6wWvokDM4N4tMGIoyv0wYsl.jpg	t
2243	Annie Mumolo	\N	https://image.tmdb.org/t/p/w500/wkdmu4w0cBweYoyaqQQSgaEYoKD.jpg	t
2244	Reid Scott	\N	https://image.tmdb.org/t/p/w500/kBAeDUDA7XJRXFLGNALlpE5d3lA.jpg	t
2245	Perry Mattfeld	\N	https://image.tmdb.org/t/p/w500/7oM81wmfkM185bivpMx95HMWeQ7.jpg	t
2246	Jordan Aaron Hall	\N	https://image.tmdb.org/t/p/w500/70wXromowEycW1SN88xzzwuzwk7.jpg	t
2247	Mathilda Gianopoulos	\N	\N	t
2248	Meg Millidge	\N	https://image.tmdb.org/t/p/w500/roPUbUXROyIGMUptmA7QvU3ey0l.jpg	t
2249	Cheech Manohar	\N	https://image.tmdb.org/t/p/w500/AsvQFmZtSioAF1dWgAN88Dmpf6y.jpg	t
2250	黄渤	\N	https://image.tmdb.org/t/p/w500/bkUJ85MGkdENzMENyCj23fMcZx.jpg	t
2251	于适	\N	https://image.tmdb.org/t/p/w500/xIzHhuScL4wbm2zmHxtnfpBFqcs.jpg	t
2252	那尔那茜	\N	https://image.tmdb.org/t/p/w500/i2oD8NEMmCSXDVtJq0bxOF0cJ4V.jpg	t
2253	陈牧驰	\N	https://image.tmdb.org/t/p/w500/cu7k1HTLpNNNKZ2WdxVIUGXiPVF.jpg	t
2254	Kris Phillips	\N	https://image.tmdb.org/t/p/w500/gh6dlF5SkVKfNrRaHVseBwiTbUA.jpg	t
2255	Нарана Эрдынеева	\N	https://image.tmdb.org/t/p/w500/vkwTS9sov0HasgVE8A4BH3NSV9N.jpg	t
2256	韩鹏翼	\N	https://image.tmdb.org/t/p/w500/t2EfHBYgHqUuaU4vIn8BFt0qN6c.jpg	t
2257	武亚凡	\N	https://image.tmdb.org/t/p/w500/ttqgiYdy8oLu5xOLet4eXmPQvOl.jpg	t
2258	Scott Adsit	\N	https://image.tmdb.org/t/p/w500/vbbuugUWrZhxA7ASWYiGqdZ6Dtf.jpg	t
2259	Ryan Potter	\N	https://image.tmdb.org/t/p/w500/3Hdip1zNYrea3V7uzJQYxTps5Ne.jpg	t
2260	Daniel Henney	\N	https://image.tmdb.org/t/p/w500/elAolohpUG5nS99EZxHZjd44DsS.jpg	t
2261	T.J. Miller	\N	https://image.tmdb.org/t/p/w500/rRrVvBxOkyYM5XdLXimShHR1Itn.jpg	t
2262	Jamie Chung	\N	https://image.tmdb.org/t/p/w500/5KS919slWvKwK2fcE3jpkEodlxs.jpg	t
2263	Damon Wayans Jr.	\N	https://image.tmdb.org/t/p/w500/f6gNg71Js9XqCiXUtyFyXXbJ9ni.jpg	t
2264	Genesis Rodriguez	\N	https://image.tmdb.org/t/p/w500/gUI9KADVjfHiI8nMc87hkeaWEF3.jpg	t
2265	James Cromwell	\N	https://image.tmdb.org/t/p/w500/17AIez58rJyk7EzU5a9L2r6Tn3u.jpg	t
2266	Maya Rudolph	\N	https://image.tmdb.org/t/p/w500/9QTtEfAmQOQcGhD12zzxdouLRh4.jpg	t
2267	Imelda Staunton	\N	https://image.tmdb.org/t/p/w500/96LYLMnUOWZ4DFXEeQPItNsxzEP.jpg	t
2268	David Morse	\N	https://image.tmdb.org/t/p/w500/A6zGbkFjM3uajIakgsSeNTmSKqY.jpg	t
2269	Michael Clarke Duncan	\N	https://image.tmdb.org/t/p/w500/3RX8OBqt3gbvFwKYZqiom4O3Ta6.jpg	t
2270	Michael Jeter	\N	https://image.tmdb.org/t/p/w500/pNBf8X56wCOHH7cArsMYJuke4fO.jpg	t
2271	Graham Greene	\N	https://image.tmdb.org/t/p/w500/ubX9pwrzQqnR41gAGyY1GoSZr1G.jpg	t
2272	Doug Hutchison	\N	https://image.tmdb.org/t/p/w500/afAENhxoHikCAKFaILFdSwVdkCw.jpg	t
2273	Barry Pepper	\N	https://image.tmdb.org/t/p/w500/eu27Dlfemyor0AP1ZTPVRLBx8Mv.jpg	t
2274	John Rhys-Davies	\N	https://image.tmdb.org/t/p/w500/bfn4WvhGo2QKYtv5ynk7tKu7NnL.jpg	t
2275	Tye Sheridan	\N	https://image.tmdb.org/t/p/w500/d5ZS2fjqC98cIGkhEGX0fRYhku4.jpg	t
2276	Sarah Dumont	\N	https://image.tmdb.org/t/p/w500/lW6Qxv5OYfHxdwy7UIalIjpdL07.jpg	t
2277	Logan Miller	\N	https://image.tmdb.org/t/p/w500/xa62ZRSMFUUk4KS9kkKYZkNDlKi.jpg	t
2278	Joey Morgan	\N	https://image.tmdb.org/t/p/w500/56BmgVznw18DdJIoBzAJuvuT4qD.jpg	t
2279	David Koechner	\N	https://image.tmdb.org/t/p/w500/fpTTe1ow3EdfRJ8PZgBJmpeghMS.jpg	t
2280	Hiram A. Murray	\N	https://image.tmdb.org/t/p/w500/neUNR39ZqUIBhBguSL7GdrXt8Gy.jpg	t
2281	Cloris Leachman	\N	https://image.tmdb.org/t/p/w500/o8pnV9urjuHZDAR2u4UjPy2CR1u.jpg	t
2282	Halston Sage	\N	https://image.tmdb.org/t/p/w500/zLjeZvflHIy4BoG4zS5OrdPdYbh.jpg	t
2283	Blake Anderson	\N	https://image.tmdb.org/t/p/w500/6CAisTFUOPulSKZvDSSptZ6D299.jpg	t
2284	Sara Malakul Lane	\N	https://image.tmdb.org/t/p/w500/ppW3Isiimrrw48Xl5mgl8SPPhlv.jpg	t
2285	Chris Pine	\N	https://image.tmdb.org/t/p/w500/d8hGMH1igEFnpNFEEFdP3yFHV3U.jpg	t
2286	Ewen Bremner	\N	https://image.tmdb.org/t/p/w500/kPz9fySywEH9npKnkWE6cvNoItO.jpg	t
2287	Eugene Brave Rock	\N	https://image.tmdb.org/t/p/w500/27RL3pfNTBTu2zeNvFQTLFvCrJv.jpg	t
2288	Lucy Davis	\N	https://image.tmdb.org/t/p/w500/A1ymILbxQA5w5TduCNaU0xD9C5a.jpg	t
2289	Taskya Namya	\N	https://image.tmdb.org/t/p/w500/cBlyNw0Ys8wlBOu1CGCfo8k0dGt.jpg	t
2290	Yasamin Jasem	\N	https://image.tmdb.org/t/p/w500/2nZntBT1kMn7OpBKJ6UaaTahZQO.jpg	t
2291	Arya Saloka	\N	https://image.tmdb.org/t/p/w500/ioRwfjaRoPls96kKN91IdsDipvD.jpg	t
2292	Anna Jobling	\N	https://image.tmdb.org/t/p/w500/4YO4Kt3cMTQExUzcvIJBPselP5Y.jpg	t
2293	Daffa Wardhana	\N	https://image.tmdb.org/t/p/w500/QV8krRWRKwOPARa4UPP4CWYr7n.jpg	t
2294	Oka Antara	\N	https://image.tmdb.org/t/p/w500/hxa27iexJSLga0x1NNxmpzQLh8V.jpg	t
2295	Tio Pakusadewo	\N	https://image.tmdb.org/t/p/w500/uAbKPJPbXVg1pi1bAEEkaMxc0Br.jpg	t
2296	Paula Verhoeven	\N	https://image.tmdb.org/t/p/w500/usVuFzhK1vwWd8NxQCLcjPAHoqP.jpg	t
2297	Mario Maulana	\N	https://image.tmdb.org/t/p/w500/7PNmdAaEC6CwKH2ZnR0BItZMxXH.jpg	t
2298	Dayu Wijanto	\N	https://image.tmdb.org/t/p/w500/n3UD9W4Rm4XNdgLIMpw0zT3ZJr4.jpg	t
2299	Carrie Fisher	\N	https://image.tmdb.org/t/p/w500/8DOzF5eQMWdFwkVIevaEfrYXtLx.jpg	t
2300	Peter Cushing	\N	https://image.tmdb.org/t/p/w500/if5g03wn6uvHx7F6FxXHLebKc0q.jpg	t
2301	Alec Guinness	\N	https://image.tmdb.org/t/p/w500/gplGgl6XERpvYdluiwY8GlxSdpi.jpg	t
2302	Anthony Daniels	\N	https://image.tmdb.org/t/p/w500/7kR4kwXtvXtvrsxWeX3QLX5NS5V.jpg	t
2303	Kenny Baker	\N	https://image.tmdb.org/t/p/w500/kWwso57V7fr0jWnHfknlxxq7XXy.jpg	t
2304	Peter Mayhew	\N	https://image.tmdb.org/t/p/w500/bWv4RHLhjH6Ujrfhzm6ZC8ms3f2.jpg	t
2305	David Prowse	\N	https://image.tmdb.org/t/p/w500/xTocYiKHlRYN8tfh8vyQFsRXC0K.jpg	t
2306	James Earl Jones	\N	https://image.tmdb.org/t/p/w500/oqMPIsXrl9SZkRfIKN08eFROmH6.jpg	t
2307	Patton Oswalt	\N	https://image.tmdb.org/t/p/w500/ljQvjbPmcIAl205Lb2Mu4CW8WO7.jpg	t
2308	Lou Romano	\N	https://image.tmdb.org/t/p/w500/1qOuqRzlp5BghzTkYSN3MsaEXgF.jpg	t
2309	Brian Dennehy	\N	https://image.tmdb.org/t/p/w500/cg7CwS1vMJXCzZ0FUm4RbrjAJ2t.jpg	t
2310	Peter Sohn	\N	https://image.tmdb.org/t/p/w500/8cQGViF2lXlcsAIvFUMWboXYXIu.jpg	t
2311	Peter O'Toole	\N	https://image.tmdb.org/t/p/w500/bk2AIN5yjqkthDUxUH0Q4U2ekRH.jpg	t
2312	Janeane Garofalo	\N	https://image.tmdb.org/t/p/w500/cdNooT0otUf5QVHDPm9bkGN7gNu.jpg	t
2313	Will Arnett	\N	https://image.tmdb.org/t/p/w500/nFRUYCfw34wTvLJe9xdhFrm0jIU.jpg	t
2314	Julius Callahan	\N	https://image.tmdb.org/t/p/w500/ggEnMBpO6K77TgGiXYVQA32ksQ6.jpg	t
2315	Rebecca Hall	\N	https://image.tmdb.org/t/p/w500/mpWtqob1BRKz4bpX8h8a9hdmIPv.jpg	t
2316	Kaylee Hottle	\N	https://image.tmdb.org/t/p/w500/xpQQZgptOUI6duMMBDyCiaJ4JUv.jpg	t
2317	Alex Ferns	\N	https://image.tmdb.org/t/p/w500/3V3L7MJGURXU6lVaqai80zFT4Wa.jpg	t
2318	Fala Chen	\N	https://image.tmdb.org/t/p/w500/nsucfzPlPHeYVXhIS2b8ZtKr4wJ.jpg	t
2319	Ron Smyck	\N	https://image.tmdb.org/t/p/w500/a1KEvCRpoeWbmDM13C9qCGtopkD.jpg	t
2320	Chantelle Jamieson	\N	https://image.tmdb.org/t/p/w500/dQMkUVkCcKFKVPjZRuSHPwuTK8N.jpg	t
2321	Greg Hatton	\N	https://image.tmdb.org/t/p/w500/j0jioHCWjJJEr41Vr2vHgRRtEMx.jpg	t
2322	Martin Freeman	\N	https://image.tmdb.org/t/p/w500/amUYpgHEn2evMo3QfRIoy0ATQza.jpg	t
2323	Richard Armitage	\N	https://image.tmdb.org/t/p/w500/oNoKjTOUNUiJ01UNQSCQDkt5EHi.jpg	t
2324	Evangeline Lilly	\N	https://image.tmdb.org/t/p/w500/pJHX2jd7ytre3NQbF9nlyWUqxH3.jpg	t
2325	Luke Evans	\N	https://image.tmdb.org/t/p/w500/qUkYJcrDc4M0LHNYASs30luFvw0.jpg	t
2326	Lee Pace	\N	https://image.tmdb.org/t/p/w500/9fhFAGZxnQZlqDdf3cyzkGi3Bag.jpg	t
2327	Ken Stott	\N	https://image.tmdb.org/t/p/w500/yzF2h7xhwtCkQ6T556pHSE7F1k4.jpg	t
2328	Aidan Turner	\N	https://image.tmdb.org/t/p/w500/owWJR9RCq7FcOw9R9yX70TKNsvQ.jpg	t
2329	Pete Davidson	\N	https://image.tmdb.org/t/p/w500/f3kubnZu3KgMniExcq9nJy8RwjW.jpg	t
2330	Keke Palmer	\N	https://image.tmdb.org/t/p/w500/f5i3WzdMt02mlfm9I9LHKRJtZ4J.jpg	t
2331	Jack Kesy	\N	https://image.tmdb.org/t/p/w500/lQ8nUYK6InbCFk2TWNnXjjvG9IY.jpg	t
2332	Ismael Cruz Cordova	\N	https://image.tmdb.org/t/p/w500/oXcrsQGndk60iFkNB8qFnMHlNzL.jpg	t
2333	Andrew Dice Clay	\N	https://image.tmdb.org/t/p/w500/xwNn8mJrhww89P2pIVkWnaTlqHw.jpg	t
2334	Joe Anoa'i	\N	https://image.tmdb.org/t/p/w500/6BKc77eAUBQdL9MmgBorBc4SMdE.jpg	t
2335	Jef Holbrook	\N	https://image.tmdb.org/t/p/w500/huB6TwdSCsF18wuuM3rlbNNpDW2.jpg	t
2336	Natalia Siwiec	\N	https://image.tmdb.org/t/p/w500/mSqUf3osymu6okOKaxDrUk5MxpD.jpg	t
2337	趙又廷	\N	https://image.tmdb.org/t/p/w500/vww9G6WMEaXqWl5cVxPfV4T1Y6n.jpg	t
2338	冯绍峰	\N	https://image.tmdb.org/t/p/w500/tSn5BIRw3Xdj3XYKIycjyNTgl49.jpg	t
2339	劉嘉玲	\N	https://image.tmdb.org/t/p/w500/5Va4jk69gkdAcABtkTtcUz85RLA.jpg	t
2340	林更新	\N	https://image.tmdb.org/t/p/w500/71pkSNjj7SUjDkW05sJSiqDgOOn.jpg	t
2341	马思纯	\N	https://image.tmdb.org/t/p/w500/lBaMftRfwBOoKeEg76ooqfffZTw.jpg	t
2342	阮經天	\N	https://image.tmdb.org/t/p/w500/vDiFcca1TYcFssxjU9efGjIAWN4.jpg	t
2343	Tiger Xu	\N	https://image.tmdb.org/t/p/w500/s0t0cz9kRTZn2tvb0D4OyeYAeAP.jpg	t
2344	孙蛟龙	\N	https://image.tmdb.org/t/p/w500/bcHHWhh1YCZqKxFXPXL7eNqJld4.jpg	t
2345	Chen Weiran	\N	https://image.tmdb.org/t/p/w500/4Ru4Dv1a0SKemdh6tK2ayCfzj56.jpg	t
2346	Zhang Aoyue	\N	https://image.tmdb.org/t/p/w500/peVp9OBcjHr9JFriS2byLcR67az.jpg	t
2347	John Travolta	\N	https://image.tmdb.org/t/p/w500/ap8eEYfBKTLixmVVpRlq4NslDD5.jpg	t
2348	Uma Thurman	\N	https://image.tmdb.org/t/p/w500/sBgAZWi3o4FsnaTvnTNtK6jpQcF.jpg	t
2349	Bruce Willis	\N	https://image.tmdb.org/t/p/w500/2jbMZCksnFlEdCZhEvh6GmU4GQl.jpg	t
2350	Harvey Keitel	\N	https://image.tmdb.org/t/p/w500/7P30hza1neYWW3r7rSQOC736K2Z.jpg	t
2351	Eric Stoltz	\N	https://image.tmdb.org/t/p/w500/idFuM00MeVmwGAiqvDaJcBiLAmD.jpg	t
2352	Tim Roth	\N	https://image.tmdb.org/t/p/w500/qSizF2i9gz6c6DbAC5RoIq8sVqX.jpg	t
2353	Amanda Plummer	\N	https://image.tmdb.org/t/p/w500/wEwyajjePFVVn2wFdH1NH7z9Qn5.jpg	t
2354	Maria de Medeiros	\N	https://image.tmdb.org/t/p/w500/v53G55qSYaVRvbgUZ2uch4gVHT6.jpg	t
2355	김민희	\N	https://image.tmdb.org/t/p/w500/zZ41nW0GJqesHB75hFP6qllPS9y.jpg	t
2356	김태리	\N	https://image.tmdb.org/t/p/w500/gFofVUeVlIvBJMUv7maHQwWdfsk.jpg	t
2357	하정우	\N	https://image.tmdb.org/t/p/w500/9KINm0XIwbt4Qql4oZX55krzKxg.jpg	t
2358	조진웅	\N	https://image.tmdb.org/t/p/w500/r3o7eKsqVCQu0ppIY88d16VLCsj.jpg	t
2359	김해숙	\N	https://image.tmdb.org/t/p/w500/dt5bmKeG7qbvDwHrxFZFxiGc9fZ.jpg	t
2360	문소리	\N	https://image.tmdb.org/t/p/w500/iXfIsmrzohNAAf2gyPCE06rJM1N.jpg	t
2361	이용녀	\N	https://image.tmdb.org/t/p/w500/q4t4bs0nm6rjIbRm58SBJAChAf4.jpg	t
2362	곽은진	\N	https://image.tmdb.org/t/p/w500/tYbmsI4Wzt2fv5PWSZJg1SjkC2t.jpg	t
2363	이동휘	\N	https://image.tmdb.org/t/p/w500/dqGCVaJ5yuGgKTPUEqCJNk8Nzbs.jpg	t
2364	Jo Eun-hyung	\N	https://image.tmdb.org/t/p/w500/k72sQ6tq60e8vk2R8sFTe1fHV1H.jpg	t
2365	Arnold Schwarzenegger	\N	https://image.tmdb.org/t/p/w500/2marNcjIfCUE5Z2HyrcEiJHPbsA.jpg	t
2366	Carl Weathers	\N	https://image.tmdb.org/t/p/w500/9Tot1ywxTQA3vFCcAjyK6h9Dao3.jpg	t
2367	Kevin Peter Hall	\N	https://image.tmdb.org/t/p/w500/wdW2sUAQPonZcQo8oDY1j60h7DP.jpg	t
2368	Elpidia Carrillo	\N	https://image.tmdb.org/t/p/w500/u8ZEUAUdVjUE8DTddv81rE1Qer7.jpg	t
2369	Bill Duke	\N	https://image.tmdb.org/t/p/w500/hZrYPwer5PeK77OEILkNWHVb3ss.jpg	t
2370	Jesse Ventura	\N	https://image.tmdb.org/t/p/w500/j1OaAOYJbelxGrFMzlwz6wfGaXA.jpg	t
2371	Sonny Landham	\N	https://image.tmdb.org/t/p/w500/873kBnyYgm8xYyeb26EXdCGDgnv.jpg	t
2372	Richard Chaves	\N	https://image.tmdb.org/t/p/w500/leJa0My0VtHINCpmose619KXupp.jpg	t
2373	R.G. Armstrong	\N	https://image.tmdb.org/t/p/w500/wDsIQBOtNZotwMEi2QJLSNrLEXc.jpg	t
2374	Shane Black	\N	https://image.tmdb.org/t/p/w500/fafBg8LjtQqsXyFg8ZgW7DHQXKt.jpg	t
2375	Madison Wolfe	\N	https://image.tmdb.org/t/p/w500/ir4dNcm1mmTuK4knqT8XivkwJPo.jpg	t
2376	Frances O'Connor	\N	https://image.tmdb.org/t/p/w500/tWGMS7DciV43tlxA6UEc2UqxrhL.jpg	t
2377	Lauren Esposito	\N	https://image.tmdb.org/t/p/w500/baHUTkriO7xY7HBZM5bYphTQIWJ.jpg	t
2378	Benjamin Haigh	\N	https://image.tmdb.org/t/p/w500/9PKwxJfYOgxAkZurTTY17EdIPGY.jpg	t
2379	Patrick McAuley	\N	https://image.tmdb.org/t/p/w500/41HQu8aQPMcNi9kbiCpUCGHcX95.jpg	t
2380	Maria Doyle Kennedy	\N	https://image.tmdb.org/t/p/w500/dlZ5METJ8AKFjjlA6tjQiA9yfK3.jpg	t
2381	Antonio Banderas	\N	https://image.tmdb.org/t/p/w500/fce7zl6elUzsv7wudHFc7RgFtjD.jpg	t
2382	Walt Dohrn	\N	https://image.tmdb.org/t/p/w500/tGWQRNz8T5VNPZgNU2LafpNt2Jn.jpg	t
2383	Julie Andrews	\N	https://image.tmdb.org/t/p/w500/kTXM2KfsXh2vSav0s9vaDKfs4lR.jpg	t
2384	John Cleese	\N	https://image.tmdb.org/t/p/w500/dhDw43v7EY52GG3Z4H8B9mr2s9p.jpg	t
2385	Jane Lynch	\N	https://image.tmdb.org/t/p/w500/nye6D17ZfCHQzr9faYZYyz1CPsZ.jpg	t
2386	Matthew Broderick	\N	https://image.tmdb.org/t/p/w500/2Pq8pwOX5ZFfT2p5pNLGfvUi9Pp.jpg	t
2387	Moira Kelly	\N	https://image.tmdb.org/t/p/w500/3yQRnGSfbPWQDInZHTzzXsrAhUR.jpg	t
2388	Nathan Lane	\N	https://image.tmdb.org/t/p/w500/nEYS0KO1qVO3y0RAt8V8pFxnPb7.jpg	t
2389	Ernie Sabella	\N	https://image.tmdb.org/t/p/w500/dBit6gkZfxXqdxO0Ic8CsnLpxyQ.jpg	t
2390	Robert Guillaume	\N	https://image.tmdb.org/t/p/w500/prqxpeFeyyarRxxfaMHrqCKVyhV.jpg	t
2391	Rowan Atkinson	\N	https://image.tmdb.org/t/p/w500/wxTgS4SFanVKbnvu9xqOzNJWJwz.jpg	t
2392	Jonathan Taylor Thomas	\N	https://image.tmdb.org/t/p/w500/lv1ZNrdFGMa8lYjwQyJqePONaDY.jpg	t
2393	Niketa Calame-Harris	\N	https://image.tmdb.org/t/p/w500/nH34QlGneoVleFr6Zafl95kFMxt.jpg	t
2394	Aimee Stolte	\N	https://image.tmdb.org/t/p/w500/wvk3Doqn4DsQGFbksPBNPBbqjUt.jpg	t
2395	Dawn Olivieri	\N	https://image.tmdb.org/t/p/w500/tet7ZVbzhLWwT44m9j94folyl5N.jpg	t
2396	Aleks Paunovic	\N	https://image.tmdb.org/t/p/w500/k8j9Nr0xS2vEUMV8Wl0y5cC2NeB.jpg	t
2397	Benjamin Joel Arcé	\N	https://image.tmdb.org/t/p/w500/oFpxfa7YFfdvSv1QGuaSblBQmvq.jpg	t
2398	Alex Mallari Jr.	\N	https://image.tmdb.org/t/p/w500/7rypBTal9cGPhExAzLpYSALJ3Px.jpg	t
2399	Damon Runyan	\N	https://image.tmdb.org/t/p/w500/74HBlulH9QcYN0CFQrGPv7oS2Gm.jpg	t
2400	Sala Baker	\N	https://image.tmdb.org/t/p/w500/zn0kwgQ6IT847uMxz73w7ofHwyp.jpg	t
2401	Ana Sarem	\N	\N	t
2402	Mike Gassaway	\N	https://image.tmdb.org/t/p/w500/xkalRZmZbwhzYwbkmkgP2RW1vok.jpg	t
2403	Michael Ironside	\N	https://image.tmdb.org/t/p/w500/mzHmxtKcMJjDqWxKd67mKQJFW1B.jpg	t
2404	Billy MacLellan	\N	https://image.tmdb.org/t/p/w500/9ObnhjbbeVEhk8g941FrLq4W0r7.jpg	t
2405	Araya Mengesha	\N	https://image.tmdb.org/t/p/w500/3LS410gDb1DI5x9SjMytPgByJZc.jpg	t
2406	Gage Munroe	\N	https://image.tmdb.org/t/p/w500/9IIuzYiVroMxZPEPNWU40GLWJGt.jpg	t
2407	Mélanie Laurent	\N	https://image.tmdb.org/t/p/w500/i99ogEo4gQyanCmHWYYoS6hsUqL.jpg	t
2408	Eli Roth	\N	https://image.tmdb.org/t/p/w500/qQTkpxzh1FlBGL1HD5hzdUMxv49.jpg	t
2409	Michael Fassbender	\N	https://image.tmdb.org/t/p/w500/e7SxBHtAxTyNE4GdOrHD7kqkukm.jpg	t
2410	Diane Kruger	\N	https://image.tmdb.org/t/p/w500/o5gVowcjVw4ThYi0L3883Y4X7kH.jpg	t
2411	Til Schweiger	\N	https://image.tmdb.org/t/p/w500/3Jk7y4sKgckrN9RzAAt0drlR0QG.jpg	t
2412	Gedeon Burkhard	\N	https://image.tmdb.org/t/p/w500/oC2C7AEh5WUa7XShz7SMpuNwheP.jpg	t
2413	Jacky Ido	\N	https://image.tmdb.org/t/p/w500/qvPeXby2lTt0bHCk6diaUY0pmdv.jpg	t
2414	Barbara Niven	\N	https://image.tmdb.org/t/p/w500/dqLkAlpIMlJsI6tN95kqGHUxtBK.jpg	t
2415	Jessica Clark	\N	https://image.tmdb.org/t/p/w500/o0qh9Nct5pKnl1EzGqUHPRFpz1b.jpg	t
2416	John Heard	\N	https://image.tmdb.org/t/p/w500/zjhcxrCFK4q0C1gtVmeN8FeqCw0.jpg	t
2417	Morgan Fairchild	\N	https://image.tmdb.org/t/p/w500/k0tQuMliATnRyrbuWyl7jPZqOPE.jpg	t
2418	Kerry Knuppe	\N	https://image.tmdb.org/t/p/w500/fJGFRIcMiVyyxoSXs3zfBDjcjht.jpg	t
2419	Imelda Corcoran	\N	https://image.tmdb.org/t/p/w500/qUKhamo0T8BrDM3BzCOYqjHJb42.jpg	t
2420	Mary Jane Wells	\N	https://image.tmdb.org/t/p/w500/4iMMTlMdZb3DDcAkpEr5A4BHBQp.jpg	t
2421	Rebecca Staab	\N	https://image.tmdb.org/t/p/w500/AavKqTvgAjqoJHFc4xOipmZJXiV.jpg	t
2422	Michael Adam Hamilton	\N	https://image.tmdb.org/t/p/w500/dLo4bFS6WNVwXQhul4CmBWDNA6W.jpg	t
2423	Bryan Mordechai Jackson	\N	\N	t
2424	Svenja Jung	\N	https://image.tmdb.org/t/p/w500/j8x2jGFNf3gDDhIKqmrgAt4S6kH.jpg	t
2425	Theo Trebs	\N	https://image.tmdb.org/t/p/w500/skAPMfC60KHM17oDlcyq2RhuTuf.jpg	t
2426	Tijan Marei	\N	https://image.tmdb.org/t/p/w500/lyWf9M0tnKSRVy4dNbXclkP8Hpk.jpg	t
2427	Antje Traue	\N	https://image.tmdb.org/t/p/w500/enfmTZlaXBoaVL1T5XVNe55WbOp.jpg	t
2428	Thomas Kretschmann	\N	https://image.tmdb.org/t/p/w500/kBnPu1KREhckuPpnAUppm24kkVX.jpg	t
2429	Lucía Barrado	\N	https://image.tmdb.org/t/p/w500/tPJgQSyjnCZCJRtn2OT1Ot3F8Jc.jpg	t
2430	Victor Meutelet	\N	https://image.tmdb.org/t/p/w500/zROH5MBP1XCjLUaeBSmCyVi27i9.jpg	t
2431	Anton Kostov	\N	\N	t
2432	Sienna Fournet Hoeltschi	\N	\N	t
2433	Félix Maestro	\N	\N	t
2434	Tobey Maguire	\N	https://image.tmdb.org/t/p/w500/s6PwSvq6gC7PGEjIku69tPbvR8M.jpg	t
2435	Kirsten Dunst	\N	https://image.tmdb.org/t/p/w500/5dI5s8Oq2Ook5PFzTWMW6DCXVjm.jpg	t
2436	James Franco	\N	https://image.tmdb.org/t/p/w500/bjmAntHGiibLZixH8nTNVBzaFQn.jpg	t
2437	Cliff Robertson	\N	https://image.tmdb.org/t/p/w500/8pH2RWCPtXKzT9P33MbzgnzPlF0.jpg	t
2438	Rosemary Harris	\N	https://image.tmdb.org/t/p/w500/naoQk2SXT4nAAI7bP3C2mtDcVZh.jpg	t
2439	Joe Manganiello	\N	https://image.tmdb.org/t/p/w500/mTdACmitdrwor0Nrv5sr0u123vZ.jpg	t
2440	Gerry Becker	\N	https://image.tmdb.org/t/p/w500/il1r1Iym5WFJyo8SQon60aqu4nC.jpg	t
2441	Bill Nunn	\N	https://image.tmdb.org/t/p/w500/trxNvS6g5yvwbXzx2LK6JqutE5z.jpg	t
2442	Tom Burke	\N	https://image.tmdb.org/t/p/w500/4IHlAZ9bJ82VAd6HUOWFgo81SDq.jpg	t
2443	Alyla Browne	\N	https://image.tmdb.org/t/p/w500/tcAQAzqk1z0PsVXqi8HODOVPQoY.jpg	t
2444	George Shevtsov	\N	https://image.tmdb.org/t/p/w500/cuOoCZShfvNrOvrWqH2dPyBfrZS.jpg	t
2445	Lachy Hulme	\N	https://image.tmdb.org/t/p/w500/z6ZEqpIkh1LYQXgSNMcc8akW3ZR.jpg	t
2446	John Howard	\N	https://image.tmdb.org/t/p/w500/2XwZDmoeoSiLKDjmmXxQK4m5kHM.jpg	t
2447	Angus Sampson	\N	https://image.tmdb.org/t/p/w500/aFmRmydMoTDwR3l1Re1T5XtQE3s.jpg	t
2448	Charlee Fraser	\N	https://image.tmdb.org/t/p/w500/lFxpl1F961ORKoNX6F62iEa419m.jpg	t
2449	Elsa Pataky	\N	https://image.tmdb.org/t/p/w500/fsA7hxz70SVvCm8dZuAGvBHtVDF.jpg	t
2450	Pete Ploszek	\N	https://image.tmdb.org/t/p/w500/9ZFxQLUQzfMNEHVqYjwK346vaCK.jpg	t
2451	Alan Ritchson	\N	https://image.tmdb.org/t/p/w500/92YNEEpCyugkTzPprJwZpvVtvuK.jpg	t
2452	Jeremy Howard	\N	https://image.tmdb.org/t/p/w500/tkZNfmlNkiH7UZxYDaDqO9z1TuV.jpg	t
2453	Noel Fisher	\N	https://image.tmdb.org/t/p/w500/rBD5Iwt9WITaUKGk1oxSPLjjpm2.jpg	t
2454	Megan Fox	\N	https://image.tmdb.org/t/p/w500/9khvk5svs81TLqIGlI3ZJqYtqaY.jpg	t
2455	William Fichtner	\N	https://image.tmdb.org/t/p/w500/wWtJOoaNAwPparpzMNuRBjvxwEf.jpg	t
2456	Danny Woodburn	\N	https://image.tmdb.org/t/p/w500/wmxPxtUWPr7Vux9nsYpFPRGDlWM.jpg	t
2457	Johnny Knoxville	\N	https://image.tmdb.org/t/p/w500/7XDKsHsLC4uNYaGsuWG1tQXWRnu.jpg	t
2458	Joaquin Phoenix	\N	https://image.tmdb.org/t/p/w500/u38k3hQBDwNX0VA22aQceDp9Iyv.jpg	t
2459	Oliver Reed	\N	https://image.tmdb.org/t/p/w500/dWfotc1X71wNCGyPO9hXpv8U9Gw.jpg	t
2460	Derek Jacobi	\N	https://image.tmdb.org/t/p/w500/htc4eCYmNlVotcu8AFTbDiLBzsJ.jpg	t
2461	Djimon Hounsou	\N	https://image.tmdb.org/t/p/w500/tpvtxxvCx2Mb5DV632hmuYlHoiY.jpg	t
2462	David Schofield	\N	https://image.tmdb.org/t/p/w500/2Dlxu9pqbjKA0dbfy4yMUFjiqeW.jpg	t
2463	John Shrapnel	\N	https://image.tmdb.org/t/p/w500/A4Wmltbkz3sz79GcBkLeTqwfkvE.jpg	t
2464	Deirdre O'Connell	\N	https://image.tmdb.org/t/p/w500/14e0AZOZafenduP7O6oMLSL92RP.jpg	t
2465	Micheal Ward	\N	https://image.tmdb.org/t/p/w500/fnVDz5q9Vtocm2VY5tU3voP6RxG.jpg	t
2466	Cameron Mann	\N	https://image.tmdb.org/t/p/w500/3sc89h2GBEM7DfhXtohc0nIgPCU.jpg	t
2467	Matt Gomez Hidaka	\N	https://image.tmdb.org/t/p/w500/uUDDMSYqNydNrmbELg8ZdUvFB1s.jpg	t
2468	Amélie Hoeferle	\N	https://image.tmdb.org/t/p/w500/2xhCQuVq2Vl9HiuZYdmBmL9Q0Dr.jpg	t
2469	Clifton Collins Jr.	\N	https://image.tmdb.org/t/p/w500/qG3doVXFax1EmYR1EqMvLbx5wwz.jpg	t
2470	Rupert Everett	\N	https://image.tmdb.org/t/p/w500/7t77pzlJnSLSXTzQLUey3YAzaxQ.jpg	t
2471	Aron Warner	\N	https://image.tmdb.org/t/p/w500/xufgIi9MJIuLmn3q4qi3AMmFtkM.jpg	t
2472	Kelly Asbury	\N	https://image.tmdb.org/t/p/w500/fzHQFYLc1zVVn3dUjr6pMuKdE0U.jpg	t
2473	John Goodman	\N	https://image.tmdb.org/t/p/w500/yyYqoyKHO7hE1zpgEV2XlqYWcNV.jpg	t
2474	Billy Crystal	\N	https://image.tmdb.org/t/p/w500/3Uuxfg1UorAdJRPgWWhdt3iZgKJ.jpg	t
2475	Mary Gibbs	\N	https://image.tmdb.org/t/p/w500/nqYOXIaf8ztfacrludRtS1Bytzz.jpg	t
2476	Steve Buscemi	\N	https://image.tmdb.org/t/p/w500/lQKdHMxfYcCBOvwRKBAxPZVNtkg.jpg	t
2477	James Coburn	\N	https://image.tmdb.org/t/p/w500/9GApjInyrVvjnTAr652C1aViPqZ.jpg	t
2478	Bob Peterson	\N	https://image.tmdb.org/t/p/w500/dJe3nTCIToebjj1WHFHP7LmZKyk.jpg	t
2479	Frank Oz	\N	https://image.tmdb.org/t/p/w500/mb2JbT8s6LIgaxj6QTph0NW1pmI.jpg	t
2480	Daniel Gerson	\N	https://image.tmdb.org/t/p/w500/amOuK3ytWV7KXeWrpl9joCglRlF.jpg	t
2481	Christian Mikkelsen	\N	https://image.tmdb.org/t/p/w500/fxE4TkpAgmxxE38plZsloNM6yfd.jpg	t
2482	Nasrin Khusrawi	\N	https://image.tmdb.org/t/p/w500/kD6wHXQnYYiyfc8ksZdtRgmwQNB.jpg	t
2483	Aksel Hennie	\N	https://image.tmdb.org/t/p/w500/sceuNjVXtsHOS3cn0MsLfZRkAQx.jpg	t
2484	Mathilde Storm	\N	https://image.tmdb.org/t/p/w500/zn3R4uRFvck7cZKPfMrfPpIWFKB.jpg	t
2485	Christian Rubeck	\N	https://image.tmdb.org/t/p/w500/gZ7f4zkmX8hluHkP6OCLpiofQNC.jpg	t
2486	Bjørn Sundquist	\N	https://image.tmdb.org/t/p/w500/c4BQFatz6Tm84iGAEwibm53b3Gk.jpg	t
2487	John Brungot	\N	https://image.tmdb.org/t/p/w500/etJW3FIzFKHIjXkTdFhXrICIYDB.jpg	t
2488	Gustav Nilsen	\N	https://image.tmdb.org/t/p/w500/7GLyvwtlk5sUNjQ2nFMaHkr3GmY.jpg	t
2489	Silya Nymoen	\N	https://image.tmdb.org/t/p/w500/t4sTCBJkf6CyIWbomZq9yOkMEtO.jpg	t
2490	Jakob Schøyen Andersen	\N	https://image.tmdb.org/t/p/w500/crNzDh3rtP7OmoXPLOlTe755t0N.jpg	t
2491	Janusz Chabior	\N	https://image.tmdb.org/t/p/w500/2FqjGdNKEiAFpfn8GbZQVV9Vg9R.jpg	t
2492	Sebastian Stankiewicz	\N	https://image.tmdb.org/t/p/w500/hLN0Ca09KwQOFLZLPIEzgTIbqqg.jpg	t
2493	Joyena Sun	\N	https://image.tmdb.org/t/p/w500/lhx8as19gDStrb1WJA5lGnOmKqJ.jpg	t
2494	Jess Hong	\N	https://image.tmdb.org/t/p/w500/Jh43zseZl6S0k7NYk8HqR4TZ6n.jpg	t
2495	Eden Hart	\N	https://image.tmdb.org/t/p/w500/kV2gj2zeXUskWRtjC0h34ErZGgY.jpg	t
2496	Jared Turner	\N	https://image.tmdb.org/t/p/w500/hwiA2W4XUiMJuVKwoExDHPircL1.jpg	t
2497	Sepi Toa	\N	https://image.tmdb.org/t/p/w500/6mJNS4AOxDaaAdremY1FUwO4rb7.jpg	t
2498	Xiao Hu	\N	\N	t
2499	Gideon Smith	\N	\N	t
2500	Ginette McDonald	\N	https://image.tmdb.org/t/p/w500/4QeqsV3POQ9rcV8gOWDvjVfwMqJ.jpg	t
2501	Mark Mitchinson	\N	https://image.tmdb.org/t/p/w500/dBnuglswEEKSQk6kxbSd6D1uS5j.jpg	t
2502	Sam Wang	\N	https://image.tmdb.org/t/p/w500/lREr9ZAXsaaPgM4TpKo4MftIIXd.jpg	t
2503	Jack Nicholson	\N	https://image.tmdb.org/t/p/w500/hBHcQIEa6P48HQAlLZkh0eKSSkG.jpg	t
2504	Shelley Duvall	\N	https://image.tmdb.org/t/p/w500/zwscEWl7QLiOsfsvzGXFjAQCVp3.jpg	t
2505	Danny Lloyd	\N	https://image.tmdb.org/t/p/w500/5pEmugZ6m25RB0cXbL4t5D4kZAO.jpg	t
2506	Scatman Crothers	\N	https://image.tmdb.org/t/p/w500/jf2ooubjE5tjBJwDI9Nla0M57m2.jpg	t
2507	Barry Nelson	\N	https://image.tmdb.org/t/p/w500/fSrHmvOxZJbeKpNM0uWGvha1aK9.jpg	t
2508	Philip Stone	\N	https://image.tmdb.org/t/p/w500/eRYDsJJPfFuOpZ8dTrk9qo5hnXK.jpg	t
2509	Joe Turkel	\N	https://image.tmdb.org/t/p/w500/rqpNzjLFCoMrvGSf6SIL5JnWwMT.jpg	t
2510	Anne Jackson	\N	https://image.tmdb.org/t/p/w500/tRXdd8JVhClmM0LsuyD7lWbbw4a.jpg	t
2511	Tony Burton	\N	https://image.tmdb.org/t/p/w500/iG51d1Ck1doZNGseRMqGTnNC8t8.jpg	t
2512	Lia Beldam	\N	https://image.tmdb.org/t/p/w500/cMqC8geIBmTnKRN2AhBtYbA5fT4.jpg	t
2513	Abigail Cowen	\N	https://image.tmdb.org/t/p/w500/a5AZqqBkRZzHUeQAWDurZXcueDU.jpg	t
2514	Patricia Heaton	\N	https://image.tmdb.org/t/p/w500/1iQoh3R98mC16WzMMZCru9ZcssK.jpg	t
2515	Patrick Fabian	\N	https://image.tmdb.org/t/p/w500/bbsYGlnvGUTTExcabKL1OIhcKyZ.jpg	t
2516	María Camila Giraldo	\N	https://image.tmdb.org/t/p/w500/lXAL1DTMYJo4JWH3sKaGm80X1fs.jpg	t
2517	Meadow Williams	\N	https://image.tmdb.org/t/p/w500/iECIpEM4BWt94kvOMKFJqv5uJEU.jpg	t
2518	Enrico Natale	\N	https://image.tmdb.org/t/p/w500/dPYAwb23gZwbAyC0CUMC0IuxQSE.jpg	t
2519	Ritchie Montgomery	\N	https://image.tmdb.org/t/p/w500/yjbcg32p42Hschjkeytim5yp6dA.jpg	t
2520	Chris Pratt	\N	https://image.tmdb.org/t/p/w500/cRH6HPAQ98PlOwwEvhYO4CM9lwu.jpg	t
2521	Charlie Day	\N	https://image.tmdb.org/t/p/w500/c0HNhjChGybnHa4eoLyqO4dDu1j.jpg	t
2522	Fred Armisen	\N	https://image.tmdb.org/t/p/w500/nLMCRlt0MV2uu4KPbDPDNsPWfBG.jpg	t
2523	Sebastian Maniscalco	\N	https://image.tmdb.org/t/p/w500/8TvA9HEwURJmY9MkkUruB4Sl0lR.jpg	t
2524	Charles Martinet	\N	https://image.tmdb.org/t/p/w500/3IP5hH7697STIaU006WzQaI2phR.jpg	t
2525	Kevin Michael Richardson	\N	https://image.tmdb.org/t/p/w500/xXt9Nh7RAT5bOen66TaXreNYmCl.jpg	t
2526	Paul Mescal	\N	https://image.tmdb.org/t/p/w500/vrzZ41TGNAFgfmZjC2sOJySzBLd.jpg	t
2527	ליאור רז	\N	https://image.tmdb.org/t/p/w500/bl3KLFUQ4Q0zC9lCU4qP1Jf4qHS.jpg	t
2528	Matt Lucas	\N	https://image.tmdb.org/t/p/w500/2OhGLJqiknaWlbTkG2KDwT935km.jpg	t
2529	Sybil Danning	\N	https://image.tmdb.org/t/p/w500/3BIF03EVJMxD7dOPhqlG0Z5RyoI.jpg	t
2530	Rick Hill	\N	https://image.tmdb.org/t/p/w500/xgM1ZlMAYjaZLGVl2hjM7q6Ax7h.jpg	t
2531	Josephine Jacqueline Jones	\N	https://image.tmdb.org/t/p/w500/nXJroJxRZ4z8ZSqb82AA5LTMHHK.jpg	t
2532	Tally Chanel	\N	https://image.tmdb.org/t/p/w500/xlu2DZJUsbTKPjkiprT79OoObpM.jpg	t
2533	Samantha Fox	\N	https://image.tmdb.org/t/p/w500/u9XzOUHcrFYM3ayORpMtUjRr4NY.jpg	t
2534	Suzanna Smith	\N	https://image.tmdb.org/t/p/w500/gZUDfpgJvUzwEPsBCddsHi4RRu8.jpg	t
2535	David Brandon	\N	https://image.tmdb.org/t/p/w500/1IWSdp0umsgNq5odGRQp3Q4PR7B.jpg	t
2536	Mario Cruciani	\N	\N	t
2537	Marco Tullio Cau	\N	\N	t
2538	Hiroshi Kamiya	\N	https://image.tmdb.org/t/p/w500/u2r0u8tOa0cyh7nawcEOPpcEZr1.jpg	t
2539	Rie Takahashi	\N	https://image.tmdb.org/t/p/w500/aeB7z0cBTASdjKOjQriBAO6hYq4.jpg	t
2540	Taku Yashiro	\N	https://image.tmdb.org/t/p/w500/eVdB6myaNJ4h38UU9hHHlsaCWHn.jpg	t
2541	安野希世乃	\N	https://image.tmdb.org/t/p/w500/n9TvLOSIqi6Pi4GlvH3fddNNsEG.jpg	t
2542	Ayane Sakura	\N	https://image.tmdb.org/t/p/w500/yPbTmntASE9psPIMhNGU5oo6vIH.jpg	t
2543	Ayumu Murase	\N	https://image.tmdb.org/t/p/w500/3aGM6KpcCIEKOXP9510tzaKc8uw.jpg	t
2544	Rikiya Koyama	\N	https://image.tmdb.org/t/p/w500/hsZm87BORLpzhaycBaWOD5xpjVC.jpg	t
2545	Manami Numakura	\N	https://image.tmdb.org/t/p/w500/eDbMXgeTCA2D6i7894Ag43RADrk.jpg	t
2546	Ari Ozawa	\N	https://image.tmdb.org/t/p/w500/jrj6cIjnkk1FwJiSLIpGtUf8hWd.jpg	t
2547	Christine Bermas	\N	https://image.tmdb.org/t/p/w500/zdFbplqeZbzgCJEJfnj1pPqVVH2.jpg	t
2548	Gold Aceron	\N	https://image.tmdb.org/t/p/w500/u1PRnWHIfI7A0KkDXJk5200CFBp.jpg	t
2549	VR Relosa	\N	https://image.tmdb.org/t/p/w500/mbsIqmnrrBsAUb0y4ZHfV7zTfMm.jpg	t
2550	Josh Ivan Morales	\N	https://image.tmdb.org/t/p/w500/baQ9ew113fS7PrE1ZAjEemO1put.jpg	t
2551	Sahil Khan	\N	https://image.tmdb.org/t/p/w500/AnLVLGKVfCbKQ9NyT5ofMP75hvC.jpg	t
2552	Amabella De Leon	\N	https://image.tmdb.org/t/p/w500/FMphrdXk79cKD7msxCAkfLKRkf.jpg	t
2553	Hassie Harrison	\N	https://image.tmdb.org/t/p/w500/cUu16UFtcmAJwyge5g5sbMstZCc.jpg	t
2554	Josh Heuston	\N	https://image.tmdb.org/t/p/w500/31d2Hs4KixBj15CokgKlMaBcRlv.jpg	t
2555	Rob Carlton	\N	https://image.tmdb.org/t/p/w500/kv1KHqQw1ekhpFJW6vRYW3oitRQ.jpg	t
2556	Ella Newton	\N	https://image.tmdb.org/t/p/w500/qu6BQ51nvSYW5gxY6QX1bdtQlzl.jpg	t
2557	Liam Greinke	\N	https://image.tmdb.org/t/p/w500/qGbbF24LAPQFbFmpHlSKw0CZA5r.jpg	t
2558	Ali Basoka	\N	\N	t
2559	Mike Goldman	\N	https://image.tmdb.org/t/p/w500/bNsl86sEg125dHQS2aUzME1opKK.jpg	t
2560	Carla Haynes	\N	https://image.tmdb.org/t/p/w500/z8Zeq9hK98al3LQOWuWSL50uMkI.jpg	t
2561	Dylan Eastland	\N	\N	t
2562	Dafa Wahyu Lutfi Faqih	\N	\N	t
2563	Fahrur Rojikin	\N	\N	t
2564	Randa Achmad Surbakti	\N	\N	t
2565	Matthew Modine	\N	https://image.tmdb.org/t/p/w500/z974QEHL12qUvLyk6hlWGAmDgom.jpg	t
2566	Alon Aboutboul	\N	https://image.tmdb.org/t/p/w500/ja0vix3b43U5whDTYZascbeXlQo.jpg	t
2567	Cate Blanchett	\N	https://image.tmdb.org/t/p/w500/mXpe59YDxcvAJS6EtshsvsRvLZP.jpg	t
2568	Richard Madden	\N	https://image.tmdb.org/t/p/w500/9QQFfVZ6PLe3WVmOL56wGNOnbGL.jpg	t
2569	Holliday Grainger	\N	https://image.tmdb.org/t/p/w500/fHveeGXgEfTZ9slB5OvHDG4LAPw.jpg	t
2570	Sophie McShera	\N	https://image.tmdb.org/t/p/w500/kfUN0RGq08SUCl988JT3csh5leb.jpg	t
2571	Nonso Anozie	\N	https://image.tmdb.org/t/p/w500/5V5EGRRftkAMPAwRP3a0tu0Nlwe.jpg	t
2572	Ben Chaplin	\N	https://image.tmdb.org/t/p/w500/oJc9gA7cRvRg1v4tgeAmpkaqFxO.jpg	t
2573	Maria Bello	\N	https://image.tmdb.org/t/p/w500/it1f5mxiGIWO0DzTBfwtLTjphZb.jpg	t
2574	Terrence Howard	\N	https://image.tmdb.org/t/p/w500/wXWt2NSY23v7DHe2yZQ1C8TikBp.jpg	t
2575	Dylan Minnette	\N	https://image.tmdb.org/t/p/w500/xSB7K3TpGzOvF3PFTIQG3IAgHMx.jpg	t
2576	Zoë Soul	\N	https://image.tmdb.org/t/p/w500/6gOYJPZevqSYP5MKxUl2f0B0zZY.jpg	t
2577	Erin Gerasimovich	\N	https://image.tmdb.org/t/p/w500/cB29vVWFdsRVO3wWrRBkaeVHZ0f.jpg	t
2578	Bonnie Wright	\N	https://image.tmdb.org/t/p/w500/1O3bVJp2geFCqlDkOCJuTeSuqx.jpg	t
2579	Jessie Cave	\N	https://image.tmdb.org/t/p/w500/vVfGAQuqWKS768bFw9sxtHAQAiz.jpg	t
2580	Evanna Lynch	\N	https://image.tmdb.org/t/p/w500/mebDQC5FnPVYYRxqmhCVVdl8fVM.jpg	t
2581	Richard Kind	\N	https://image.tmdb.org/t/p/w500/yWmuVQeQUzb5OSMVDoWkR0IylCK.jpg	t
2582	Mindy Kaling	\N	https://image.tmdb.org/t/p/w500/7ySdirSfk8U55nAXLiKBBbxyvvM.jpg	t
2583	Kaitlyn Dias	\N	https://image.tmdb.org/t/p/w500/dYSYUSOMxFfgfxkPqjk96KTwPZp.jpg	t
2584	Diane Lane	\N	https://image.tmdb.org/t/p/w500/o9pPS52JrleScO4Qq6q1nYlaxWz.jpg	t
2585	Kyle MacLachlan	\N	https://image.tmdb.org/t/p/w500/7gNyx8fYAUdOp2jpCEH3dyFbeV.jpg	t
2586	Paula Poundstone	\N	https://image.tmdb.org/t/p/w500/jfu3LSX48WbvcJ4NXmrdI48epLJ.jpg	t
2587	Tarusuke Shingaki	\N	https://image.tmdb.org/t/p/w500/j7SwP6CgYYFiNZA4o4tv1mWs2ii.jpg	t
2588	Wataru Hatano	\N	https://image.tmdb.org/t/p/w500/i1meHlOXLP2ubJZkmyGJONrxikQ.jpg	t
2589	Hiroki Yasumoto	\N	https://image.tmdb.org/t/p/w500/vNIGLl0wFmdhdnulMssQ1qyNeBs.jpg	t
2590	Yuki Ono	\N	https://image.tmdb.org/t/p/w500/oEx13CbNLsHzURdYafkFJYXDjfm.jpg	t
2591	Tōru Ōkawa	\N	https://image.tmdb.org/t/p/w500/dkVP18qK730qbki25nogZzBbfuM.jpg	t
2592	Akimitsu Takase	\N	https://image.tmdb.org/t/p/w500/inig8K8xyeA6L4zG55tgSfz532w.jpg	t
2593	Kazuyuki Okitsu	\N	https://image.tmdb.org/t/p/w500/vgyaK5dAxhvzAi6LJM3ZyaJd4mJ.jpg	t
2594	Takuya Sato	\N	https://image.tmdb.org/t/p/w500/xZgoTs6DOSneHkoOWL751pQzLru.jpg	t
2595	三宅貴大	\N	https://image.tmdb.org/t/p/w500/r3dGX0TlNwHV5et1GhF70B0H1Qo.jpg	t
2596	Will Smith	\N	https://image.tmdb.org/t/p/w500/8TlKqbXYgHmmaEoPBJ7djJ8Rxxa.jpg	t
2597	Martin Lawrence	\N	https://image.tmdb.org/t/p/w500/y3SQzIPUPJpdueb1DkbTYph68nk.jpg	t
2598	Vanessa Hudgens	\N	https://image.tmdb.org/t/p/w500/ssFXWN5li5OWJLgUoFlUDY0ZyPc.jpg	t
2599	Alexander Ludwig	\N	https://image.tmdb.org/t/p/w500/jXixkOwQ62hpsCr8xhWS9rik8SE.jpg	t
2600	Paola Nuñez	\N	https://image.tmdb.org/t/p/w500/5k8tBBvoV43iK6u0k2YUSVXPmuK.jpg	t
2601	Eric Dane	\N	https://image.tmdb.org/t/p/w500/lSs2O89BDyEwi8p0VhqX2jU90Hk.jpg	t
2602	Ioan Gruffudd	\N	https://image.tmdb.org/t/p/w500/h2pg2XwJPcOWotHgiohXjEZUBLa.jpg	t
2603	Melanie Liburd	\N	https://image.tmdb.org/t/p/w500/diWkE87OnBDaXZkRLLkT78lTcI9.jpg	t
2604	Tasha Smith	\N	https://image.tmdb.org/t/p/w500/viJnHL3BjQ5oqisXklQWGlh29Hx.jpg	t
2605	Lily-Rose Depp	\N	https://image.tmdb.org/t/p/w500/fulxfCO2UjDTVX3lhy4mup4wXqM.jpg	t
2606	Adéla Hesová	\N	https://image.tmdb.org/t/p/w500/1NjXfv0mDYVwMFMMDUL3IDpNAYr.jpg	t
2607	Milena Konstantinova	\N	https://image.tmdb.org/t/p/w500/xNItoG70iefVtBVHpqmfNXh0fni.jpg	t
2608	Leslie Bibb	\N	https://image.tmdb.org/t/p/w500/g3a1O9lOTZvrwQupUtg4Fc3CdTd.jpg	t
2609	Shaun Toub	\N	https://image.tmdb.org/t/p/w500/6fuJ9D50bYuMAhrlEgVqzgqF0LU.jpg	t
2610	Faran Tahir	\N	https://image.tmdb.org/t/p/w500/dMsD7h6KiZ5dM0f9MegXUOKnqb0.jpg	t
2611	Bill Smitrovich	\N	https://image.tmdb.org/t/p/w500/yzZUYnAdX0MMA8eZMTVsXufRCfU.jpg	t
2612	Sayed Badreya	\N	https://image.tmdb.org/t/p/w500/sVvwmMsjXd5YqyZEfWcWQEkBScu.jpg	t
2613	Forest Whitaker	\N	https://image.tmdb.org/t/p/w500/4w7l5JUwnwFNBy7J93ZwYN1nihm.jpg	t
2614	Maggie Grace	\N	https://image.tmdb.org/t/p/w500/fEZSGno4ooPgFjuGzE7ogsWEHsh.jpg	t
2615	Dougray Scott	\N	https://image.tmdb.org/t/p/w500/1fBd7n7s1Furk4kXN4YIcOD6mZb.jpg	t
2616	Famke Janssen	\N	https://image.tmdb.org/t/p/w500/nt4fpE3cerdDWyZFiRkYRDcOYh4.jpg	t
2617	Sam Spruell	\N	https://image.tmdb.org/t/p/w500/mV62no6D4yYtYS4A6dkHCGPTugZ.jpg	t
2618	Don Harvey	\N	https://image.tmdb.org/t/p/w500/dc10W0hRNxrO0IcwgKOcsUajtOG.jpg	t
2619	Dylan Bruno	\N	https://image.tmdb.org/t/p/w500/xRO78p1UyVlr5iPpsg8tC43O6Qd.jpg	t
2620	Leland Orser	\N	https://image.tmdb.org/t/p/w500/vvVcWhActW8k2gQz95UatVP4Duf.jpg	t
2621	David Warshofsky	\N	https://image.tmdb.org/t/p/w500/pLABX1wyaVE4CcEZVmoM2Y5XbQU.jpg	t
2622	Diana Hoyos	\N	https://image.tmdb.org/t/p/w500/fjyHzQHJb9O43vXagG4WVzzPtK7.jpg	t
2623	Juan A. Baptista	\N	https://image.tmdb.org/t/p/w500/nXlaqQWT7nzLYhoE08VAJBX5XJ6.jpg	t
2624	Juliana Galvis	\N	https://image.tmdb.org/t/p/w500/4rqyXzwu2xt5z517KAg3qCig5aW.jpg	t
2625	Carlos-Manuel Vesga	\N	https://image.tmdb.org/t/p/w500/crm5YcUTtb5pXhZbJsATA8EAoPD.jpg	t
2626	Andrés Castañeda	\N	https://image.tmdb.org/t/p/w500/epQCqExic4Jqp3DONrkfbL2tpXe.jpg	t
2627	Marilyn Patiño	\N	https://image.tmdb.org/t/p/w500/lCsCHdQZKnzSZcVJPnv8pUnfMb0.jpg	t
2628	Harald Baerow	\N	\N	t
2629	Ulrike Butz	\N	https://image.tmdb.org/t/p/w500/oVIYITuJ65WBvStR4yWqTK1SzIU.jpg	t
2630	Elke Deuringer	\N	\N	t
2631	Sonja Embriz	\N	\N	t
2632	Marisa Feldy	\N	https://image.tmdb.org/t/p/w500/vpHOMhutk1zXnlBCWTSv4IkCify.jpg	t
2633	Rosl Mayr	\N	https://image.tmdb.org/t/p/w500/pGtr1BaTO47109i3c8oOlLOnOju.jpg	t
2634	Enzi Fuchs	\N	https://image.tmdb.org/t/p/w500/zZQFQa5XA3mYwhtIY7oSx2upPJs.jpg	t
2635	Rinaldo Talamonti	\N	https://image.tmdb.org/t/p/w500/kYyPOFQCbZwU3iwzAxDfVSiX1Vm.jpg	t
2636	Marlene Rahn	\N	https://image.tmdb.org/t/p/w500/aHGs4RjQtzNcarVFOZm1mI1ndcU.jpg	t
2637	Erich Padalewski	\N	https://image.tmdb.org/t/p/w500/7LOEuI9eJe3PnoNxNRVpX9ESLHs.jpg	t
2638	Sylvia Hoeks	\N	https://image.tmdb.org/t/p/w500/wKC9LgqgJRCXuzs1kUKaK7Uicv.jpg	t
2639	Mackenzie Davis	\N	https://image.tmdb.org/t/p/w500/CEpYCoD6erYRYekmFHuQAULLD5.jpg	t
2640	Carla Juri	\N	https://image.tmdb.org/t/p/w500/7Tu9PCmTyLD1wWP8PGCzZpuImre.jpg	t
2641	Hiam Abbass	\N	https://image.tmdb.org/t/p/w500/hkzC5aJKTiuCchBpybaHDVngYZW.jpg	t
2642	Tom McGrath	\N	https://image.tmdb.org/t/p/w500/83lSBvaRShYObPvhE89UDUkUfWo.jpg	t
2643	Christopher Knights	\N	https://image.tmdb.org/t/p/w500/fsdaXx2ytNx2KEW438mlFfSSzkc.jpg	t
2644	Conrad Vernon	\N	https://image.tmdb.org/t/p/w500/2fhutx4eTBE6UR3eIRfYozKsUjk.jpg	t
2645	Annet Mahendru	\N	https://image.tmdb.org/t/p/w500/p5P8dycDpN7O9e6xR3SSb37gc2H.jpg	t
2646	Peter Stormare	\N	https://image.tmdb.org/t/p/w500/1rtpuUqBV29jDc1huUhtjGDbEwn.jpg	t
2647	Andy Richter	\N	https://image.tmdb.org/t/p/w500/qazhLkyKOsPmdOQSaUWWbbUjs9q.jpg	t
2648	Andrew Garfield	\N	https://image.tmdb.org/t/p/w500/5ydZ6TluPtxlz5G8nlWMB7SGmow.jpg	t
2649	Vince Vaughn	\N	https://image.tmdb.org/t/p/w500/A9fJ88dfXZGpgFTnQIK0bOtjMrj.jpg	t
2650	Teresa Palmer	\N	https://image.tmdb.org/t/p/w500/sjSiLSCp9LS1Z0nyGpmquTBuUyr.jpg	t
2651	Luke Bracey	\N	https://image.tmdb.org/t/p/w500/ot2h7IrXpC8XSnIZDSVsj2FQ5cx.jpg	t
2652	Rachel Griffiths	\N	https://image.tmdb.org/t/p/w500/n7rKwLjZmbkBKWBwhj9SYzsRaF6.jpg	t
2653	Ryan Corr	\N	https://image.tmdb.org/t/p/w500/iVV9HFbI562kqMOkvw0js7nzoK8.jpg	t
2654	Goran D. Kleut	\N	https://image.tmdb.org/t/p/w500/vsN8BI3t4c8JHLoLznCZxO9gZ6r.jpg	t
2655	Thomas Haden Church	\N	https://image.tmdb.org/t/p/w500/74NK9HCYvNafMggSp1PAK5Nwkpe.jpg	t
2656	Bryce Dallas Howard	\N	https://image.tmdb.org/t/p/w500/fmXhf4rJOrzc3QWwxVbNd7kP8wy.jpg	t
2657	Dylan Baker	\N	https://image.tmdb.org/t/p/w500/4mw6xj8Aj3ixjjeUj9pZdZPTbvz.jpg	t
2658	Ben Kingsley	\N	https://image.tmdb.org/t/p/w500/vQtBqpF2HDdzbfXHDzR4u37i1Ac.jpg	t
2659	James Badge Dale	\N	https://image.tmdb.org/t/p/w500/lnm8Jm11btONDU7dzPk9liuMibk.jpg	t
2660	Stephanie Szostak	\N	https://image.tmdb.org/t/p/w500/ejqFLxGCQ2CTRr63P4qgqVTpAFP.jpg	t
2661	Paul Bettany	\N	https://image.tmdb.org/t/p/w500/oNrDowF5cRtK5lJJuCAh0KeFizy.jpg	t
2662	Fabiula Nascimento	\N	https://image.tmdb.org/t/p/w500/1ZQwrmoX1tU3T5rEg0BC9kYlT1H.jpg	t
2663	Camila Queiroz	\N	https://image.tmdb.org/t/p/w500/vI7soPfMSHoPokcB4VNfrdjH9UN.jpg	t
2664	Samuel de Assis	\N	https://image.tmdb.org/t/p/w500/sNOPY6VBL1P77wMA7e4qda3M1SI.jpg	t
2665	Júlia Rabello	\N	https://image.tmdb.org/t/p/w500/2IaO3dJkD1qOat4tmJLFn47TUvP.jpg	t
2666	Caito Mainier	\N	https://image.tmdb.org/t/p/w500/ifSSjwJgRWIADsHoBR1V2IWTBfi.jpg	t
2667	Emílio Dantas	\N	https://image.tmdb.org/t/p/w500/xCiS1H0D3ljgp64dWDoRcKTzlfq.jpg	t
2668	Polly Marinho	\N	https://image.tmdb.org/t/p/w500/nUeeBUpv8ecTko6pY3QjqO3nTKe.jpg	t
2669	Patrícia Ramos	\N	https://image.tmdb.org/t/p/w500/6uwMcPBijqL1iJLWtCZFZg1mxM5.jpg	t
2670	Luana Martau	\N	https://image.tmdb.org/t/p/w500/r7YGW11skamhx8Pjn5BWRF6X1N8.jpg	t
2671	Enzo Campeão	\N	https://image.tmdb.org/t/p/w500/qqNFpIOVW2M4CFkslNDNAiwRYpM.jpg	t
2672	ฉันทวิชช์ ธนะเสวี	\N	https://image.tmdb.org/t/p/w500/sfRXVNSXQIvj9ADVgvSfjQ1fuRs.jpg	t
2673	กัญญาวีร์ สองเมือง	\N	https://image.tmdb.org/t/p/w500/hdpEJvNZ9gPQ590MOAZPlyzEnQt.jpg	t
2674	พิทยา แซ่ฉั่ว	\N	https://image.tmdb.org/t/p/w500/kQXUQhTwHYIjXjea15xSpTLdaAC.jpg	t
2675	สุภทัต โอภาส	\N	https://image.tmdb.org/t/p/w500/cKKI0NwldZgePRCoVETkBQDD4Ge.jpg	t
2676	ชูเกียรติ เอี่ยมสุข	\N	https://image.tmdb.org/t/p/w500/nc5dxSwXOEHn5ouUrJaQkPdAIwE.jpg	t
2677	ปวีณ์นุช แพ่งนคร	\N	https://image.tmdb.org/t/p/w500/bdUFa1z1R9fYAo98Dtu7rT9LOJ1.jpg	t
2678	นันทนัท ฐกัดกุล	\N	https://image.tmdb.org/t/p/w500/ooMcf4cxiicg4Wwk2nMhBXBNjjC.jpg	t
2679	พงศธร จงวิลาส	\N	https://image.tmdb.org/t/p/w500/yNatemxogO9JJ8pFXLLMMbBZxGE.jpg	t
2680	ณภัทร วิกัยรุ่งโรจน์	\N	https://image.tmdb.org/t/p/w500/1e8o5LCbm5lbDoKjg23BGmK4WnJ.jpg	t
2681	Uyển Ân	\N	https://image.tmdb.org/t/p/w500/vOgAPBWOVGYop90Bm4RWuMP7cQC.jpg	t
2682	Sarah Voigt	\N	https://image.tmdb.org/t/p/w500/7OR1UUn0DrDykNcxakYkpxW5I1Z.jpg	t
2683	Kailey Hyman	\N	https://image.tmdb.org/t/p/w500/aiREJkXiIT2GIzZcl6M9LPOFbuI.jpg	t
2684	Casey Hartnett	\N	https://image.tmdb.org/t/p/w500/jR87afncFCLivW82l2tlk3CkY5Y.jpg	t
2685	Charlie McElveen	\N	https://image.tmdb.org/t/p/w500/rxUa628mOE5XSsAHzAGO5bqw8oU.jpg	t
2686	Amelie McLain	\N	https://image.tmdb.org/t/p/w500/yPNGBOum5WNylB2cCmZMfQBuUJp.jpg	t
2687	Johnath Davis	\N	https://image.tmdb.org/t/p/w500/6vWkGc5MUpEORdelXjsW7u3LDC1.jpg	t
2688	Bradley Cooper	\N	https://image.tmdb.org/t/p/w500/sQq0nft6YZmJ7EMQwPcbaxym3AL.jpg	t
2689	Ed Helms	\N	https://image.tmdb.org/t/p/w500/gPZ8tZaNQGAc3KZRIPp9rgGbEnN.jpg	t
2690	Justin Bartha	\N	https://image.tmdb.org/t/p/w500/pv6DpCzZVNZIposxZfZJ1pDeAlL.jpg	t
2691	Heather Graham	\N	https://image.tmdb.org/t/p/w500/avYdNkeg1oTvmrNJbFDcTlBCkKs.jpg	t
2692	Sasha Barrese	\N	https://image.tmdb.org/t/p/w500/4SGcSiC46h86mdChDj0taF5eHSl.jpg	t
2693	Jeffrey Tambor	\N	https://image.tmdb.org/t/p/w500/9ucM3QueyM3uHdRVQE8mZqG7j1.jpg	t
2694	Rachael Harris	\N	https://image.tmdb.org/t/p/w500/opgx6hYjg8OhrNjOBHJfzcfEVZa.jpg	t
2695	Mike Tyson	\N	https://image.tmdb.org/t/p/w500/w0Bp2fWbL9C7KtciF56Qey8iY00.jpg	t
2696	Warwick Davis	\N	https://image.tmdb.org/t/p/w500/vUwjgAYcBEcCv0OVAN00qUUXX3V.jpg	t
2697	Matthew Lewis	\N	https://image.tmdb.org/t/p/w500/aPQCLK2gxWOallsFoEwjb1p9lWE.jpg	t
2698	Mia Wasikowska	\N	https://image.tmdb.org/t/p/w500/xOYlAZsLwFZ0gNHLnt1Hzuo2yqN.jpg	t
2699	Stephen Fry	\N	https://image.tmdb.org/t/p/w500/dH7GuUZ8QPM9RN99ak9KKOkSkdS.jpg	t
2700	Gregg Edelman	\N	https://image.tmdb.org/t/p/w500/jvdye1mZkBb5x4xjjtmtuLRmXzy.jpg	t
2701	Sadie Goldstein	\N	https://image.tmdb.org/t/p/w500/nZO5GLS8W4icYGZBqQUso7Pf8cz.jpg	t
2702	Ty Simpkins	\N	https://image.tmdb.org/t/p/w500/8FyJcMFmPdCSfz2Zc5ZcAKrIorj.jpg	t
2703	Noah Emmerich	\N	https://image.tmdb.org/t/p/w500/qwPPHYWJ3a9yRwFXicbbHsf60Nm.jpg	t
2704	Jackie Earle Haley	\N	https://image.tmdb.org/t/p/w500/xDPeiyklN8f9Ilowsti4lGVbioj.jpg	t
2705	Phyllis Somerville	\N	https://image.tmdb.org/t/p/w500/iJluejDgRqwxypQo0ac8DxqvC9h.jpg	t
2706	Helen Carey	\N	https://image.tmdb.org/t/p/w500/dO38ToWOtBH87fpAxjdQFDCasep.jpg	t
2707	Albert Brooks	\N	https://image.tmdb.org/t/p/w500/8iDSGu5l93N7benjf6b3AysBore.jpg	t
2708	Ellen DeGeneres	\N	https://image.tmdb.org/t/p/w500/z8IEEid4z63CBlJtxrTKEfsW7NA.jpg	t
2709	Alexander Gould	\N	https://image.tmdb.org/t/p/w500/fe4mUSp0XotA6Ku4Bs69Q9o2lqU.jpg	t
2710	Allison Janney	\N	https://image.tmdb.org/t/p/w500/hpBKWV1jjoXQbr1s0iUZTSvw582.jpg	t
2711	Austin Pendleton	\N	https://image.tmdb.org/t/p/w500/nrXfqtXDDYzSFNLPQnfLkus4I7s.jpg	t
2712	Vicki Lewis	\N	https://image.tmdb.org/t/p/w500/dwTjtleLh1uu8n9AvUCv0n3mi2R.jpg	t
2713	Frankie Faison	\N	https://image.tmdb.org/t/p/w500/bNHMANGaSqcki768UVAdYiYdawZ.jpg	t
2714	Terrence Alan	\N	https://image.tmdb.org/t/p/w500/pxTY4SglLo5hFcMH00MxPeC5u55.jpg	t
2715	Faune Chambers Watkins	\N	https://image.tmdb.org/t/p/w500/iP1x9TsE9RzluXQjTtY0Ujxhp9r.jpg	t
2716	Rochelle Aytes	\N	https://image.tmdb.org/t/p/w500/wn2555ynBlXnBd6jyFuW0bedcng.jpg	t
2717	Busy Philipps	\N	https://image.tmdb.org/t/p/w500/7UUe7IgetfpyhNSSpoyaC9iWF7C.jpg	t
2718	Jennifer Carpenter	\N	https://image.tmdb.org/t/p/w500/haxhKRJoWl71dAUWMLlDIaSd5bN.jpg	t
2719	Paul Rudd	\N	https://image.tmdb.org/t/p/w500/6jtwNOLKy0LdsRAKwZqgYMAfd5n.jpg	t
2720	Luke Baines	\N	https://image.tmdb.org/t/p/w500/n3A657S33fGH73lT6cr7dqFiToN.jpg	t
2721	Gwen Van Dam	\N	https://image.tmdb.org/t/p/w500/hZMfoxcIj8SOLi38nWxsAYbom4i.jpg	t
2722	Tatjana Marjanovic	\N	https://image.tmdb.org/t/p/w500/zZ3Vyk3iXqiMruDgVR7V6zqblN3.jpg	t
2723	Audrey Neal	\N	https://image.tmdb.org/t/p/w500/7aJxBm5c0vHzRh3EnkUXJV2oKy9.jpg	t
2724	Gabriella Westwood	\N	\N	t
2725	Erik Fellows	\N	https://image.tmdb.org/t/p/w500/836Cs0zBWEZVCQzpvSvBdT9sE6W.jpg	t
2726	Princess Elmore	\N	https://image.tmdb.org/t/p/w500/nySrx66WF1nYUmA25LTjedNwQIt.jpg	t
2727	Gary Kasper	\N	https://image.tmdb.org/t/p/w500/yg5Gni5tKzcYejavyvsYzOEtZF0.jpg	t
2728	Kathy Butler Sandvoss	\N	\N	t
2729	Michelle Pokopac	\N	https://image.tmdb.org/t/p/w500/oghWXIPMwSdrraQWYUHHMgUADu6.jpg	t
2730	John Candy	\N	https://image.tmdb.org/t/p/w500/uvLWbMDE6UfWNF5tfrsrC9NqeEA.jpg	t
2731	Steve Martin	\N	https://image.tmdb.org/t/p/w500/d0KthX8hVWU9BxTCG1QUO8FURRm.jpg	t
2732	Martin Short	\N	https://image.tmdb.org/t/p/w500/vWoZIOk7K8TSKu1IN90akswsWjZ.jpg	t
2733	Eugene Levy	\N	https://image.tmdb.org/t/p/w500/y4CexxKSI6qR5A6PDaD8mSrEhYC.jpg	t
2734	Macaulay Culkin	\N	https://image.tmdb.org/t/p/w500/5lSoFnWb4HmxEREqcFvBGgXu5H.jpg	t
2735	Bill Murray	\N	https://image.tmdb.org/t/p/w500/nnCsJc9x3ZiG3AFyiyc3FPehppy.jpg	t
2736	Conan O'Brien	\N	https://image.tmdb.org/t/p/w500/deRbViPut0t80miscBpP2DhBJU5.jpg	t
2737	Mel Brooks	\N	https://image.tmdb.org/t/p/w500/c21qNcMJlHnRolfhQhZOVacjtwI.jpg	t
2738	Owen Teague	\N	https://image.tmdb.org/t/p/w500/tgCkGE0LIggyjMmgSwHhpZAkfJs.jpg	t
2739	Freya Allan	\N	https://image.tmdb.org/t/p/w500/8RuLG2mePw8YgFNUjWROBuxMrwT.jpg	t
2740	Peter Macon	\N	https://image.tmdb.org/t/p/w500/jF4jzgtWB2NAJ6BfVTSDQOlOHLr.jpg	t
2741	William H. Macy	\N	https://image.tmdb.org/t/p/w500/hdVEGSrP8qWlJnt0v5vSVcGOjy7.jpg	t
2742	Eka Darville	\N	https://image.tmdb.org/t/p/w500/7tNdST92WSTGHmEJbExaRlQHWcW.jpg	t
2743	Travis Jeffery	\N	https://image.tmdb.org/t/p/w500/picKz6F5ZNpZeDF1oRXHpSR8V8w.jpg	t
2744	Lydia Peckham	\N	https://image.tmdb.org/t/p/w500/tcBJklZSsP2JuQIYataJHW3pJXE.jpg	t
2745	Neil Sandilands	\N	https://image.tmdb.org/t/p/w500/ehl64LZJ9jnlYNhoIfNDzKaO2kX.jpg	t
2746	Ras-Samuel Welda'abzgi	\N	https://image.tmdb.org/t/p/w500/pZhLFFEjzbg5fEl53TgagusDGp1.jpg	t
2747	Julia Roberts	\N	https://image.tmdb.org/t/p/w500/fQacAdIa1WUNChQ6FgEko13eqOA.jpg	t
2748	Chloë Sevigny	\N	https://image.tmdb.org/t/p/w500/nC9jDliEnqbwSKhioUBd9gObDnr.jpg	t
2749	Lio Mehiel	\N	https://image.tmdb.org/t/p/w500/mZqH6QPvtsyQAy2mq1sk4HnYuJY.jpg	t
2750	David Leiber	\N	\N	t
2751	Thaddea Graham	\N	https://image.tmdb.org/t/p/w500/oSt2cyZ8zroCvdDg5AzO6LUu9zQ.jpg	t
2752	Will Price	\N	https://image.tmdb.org/t/p/w500/7Gv2bTLOxuPSkcIMRuPpEXcHFn4.jpg	t
2753	Christine Dye	\N	https://image.tmdb.org/t/p/w500/dVR7464nWiofEH2bgIUXdOK0mQJ.jpg	t
2754	Karen Gillan	\N	https://image.tmdb.org/t/p/w500/rWx8u4F4aYIqmjJDeMK78ysPsu0.jpg	t
2755	Sean Gunn	\N	https://image.tmdb.org/t/p/w500/vpU13iCGqCpCd3LH4Tem6sVr7it.jpg	t
2756	上白石萌音	\N	https://image.tmdb.org/t/p/w500/cPydoy2sSqFDsbXeBPmzQGPmq0R.jpg	t
2757	成田凌	\N	https://image.tmdb.org/t/p/w500/f42OXn4J7cM62wtykL196YW7x85.jpg	t
2758	Aoi Yuki	\N	https://image.tmdb.org/t/p/w500/4kHNZSUIux52UU2BD3H6b5c5ymZ.jpg	t
2759	Nobunaga Shimazaki	\N	https://image.tmdb.org/t/p/w500/qke5rZusHsjSlvB0NKlJ5dQF5D.jpg	t
2760	Kaito Ishikawa	\N	https://image.tmdb.org/t/p/w500/fzjIkotjUHHs3wgftM9tqdsG8ph.jpg	t
2761	谷花音	\N	https://image.tmdb.org/t/p/w500/udR4Cax2EecH3ZkATE4h6ejiGD9.jpg	t
2762	Masaki Terasoma	\N	https://image.tmdb.org/t/p/w500/eol7Ul4buAam9SmJDuFIWln0Cd3.jpg	t
2763	Sayaka Ohara	\N	https://image.tmdb.org/t/p/w500/4lAqrOmkOP3U9Owwijtvc8PaCDx.jpg	t
2764	Kazuhiko Inoue	\N	https://image.tmdb.org/t/p/w500/3BpYtYRiLAmTNbCm2LXlXnkMRit.jpg	t
2765	Caroline Goodall	\N	https://image.tmdb.org/t/p/w500/4cagGtMqACvkuw6Llq8Li8UJ1AR.jpg	t
2766	Jonathan Sagall	\N	https://image.tmdb.org/t/p/w500/waxNDsgfw7CXXO3LH8EdKi8z7VV.jpg	t
2767	Malgorzata Gebel	\N	\N	t
2768	שמוליק לוי	\N	https://image.tmdb.org/t/p/w500/eZDmJaS0Z0Fj2377wBul9xmm27S.jpg	t
2769	Mark Ivanir	\N	https://image.tmdb.org/t/p/w500/1kxGAsP4YRiR7LgmlM9KgtekMLk.jpg	t
2770	Béatrice Macola	\N	https://image.tmdb.org/t/p/w500/dXdt4Ti4mbJilnsm0wtvwb13eny.jpg	t
2771	Florence Guérin	\N	https://image.tmdb.org/t/p/w500/5gPHDvy5IZf1g07veiuE0pW2RX4.jpg	t
2772	Trine Michelsen	\N	https://image.tmdb.org/t/p/w500/i3wSnDtNYQ3vQH3SyT8Iwg00RUE.jpg	t
2773	Cyrus Elias	\N	https://image.tmdb.org/t/p/w500/uxVul7Ik93qpgbtyy76nYGJLmY5.jpg	t
2774	Benito Artesi	\N	https://image.tmdb.org/t/p/w500/28yN1jsK8PMMsqjuTfNllVkuvh7.jpg	t
2775	Ida Eccher	\N	https://image.tmdb.org/t/p/w500/nRobb44SlOszIuVgtsbKf4DYdYF.jpg	t
2776	Rita Savagnone	\N	https://image.tmdb.org/t/p/w500/yQBZMoZt5dzlRW185VI2WyE7WFf.jpg	t
2777	Silvio Anselmo	\N	https://image.tmdb.org/t/p/w500/bS1BNnqhYVwTOIZ7B1ZqdsLY1OE.jpg	t
2778	Lorenzo Lena	\N	\N	t
2779	Clara Bertuzzo	\N	\N	t
2780	Antonia Cazzola	\N	\N	t
2781	Siena Agudong	\N	https://image.tmdb.org/t/p/w500/yztIHfFmlKpJnMtFlq5aAfsXQvp.jpg	t
2782	Noah Beck	\N	https://image.tmdb.org/t/p/w500/67BJ1o03CpMbRj40jjiAG13TqPe.jpg	t
2783	Drew Ray Tanner	\N	https://image.tmdb.org/t/p/w500/hEDc4uUmrx0pE93bwYoUWE6jvSB.jpg	t
2784	James Van Der Beek	\N	https://image.tmdb.org/t/p/w500/5CzRqYzRMNevIu6rB8gUFKpsKZL.jpg	t
2785	Deborah Cox	\N	https://image.tmdb.org/t/p/w500/1gP8DmE0Tp2TrbHaE6WUu692pdT.jpg	t
2786	Asia Lizardo	\N	https://image.tmdb.org/t/p/w500/rGLPjtx9Z5t541c0ZgQ6blBLJXu.jpg	t
2787	Jake Foy	\N	https://image.tmdb.org/t/p/w500/zGdd4rmmyab9YXcsI6un06kzbJ9.jpg	t
2788	Jason Fernandes	\N	https://image.tmdb.org/t/p/w500/uNO3t6ePWj8ELXTXOMNmvrFRPpm.jpg	t
2789	Kendall Cross	\N	https://image.tmdb.org/t/p/w500/97d4hAGHcgExV1QR3nTXdChu7Ll.jpg	t
2790	Josh Zaharia	\N	https://image.tmdb.org/t/p/w500/jiPVcr2zLOwapACbkxPl3YzccrM.jpg	t
2791	Ezra Miller	\N	https://image.tmdb.org/t/p/w500/6wmTpbYpmhthaxzM5ss3377F9IV.jpg	t
2792	Sasha Calle	\N	https://image.tmdb.org/t/p/w500/yLZY25AQOC2xKzsWqteyJTcWPK3.jpg	t
2793	Michael Shannon	\N	https://image.tmdb.org/t/p/w500/6mMczfjM8CiS1WuBOgo5Xom1TcR.jpg	t
2794	Kiersey Clemons	\N	https://image.tmdb.org/t/p/w500/iZD6EzMGnuHFjFgmO8G1wyiLrTy.jpg	t
2795	Saoirse-Monica Jackson	\N	https://image.tmdb.org/t/p/w500/5CSLLbQS59BlUPOqaxABQKfnnkz.jpg	t
2796	Rudy Mancuso	\N	https://image.tmdb.org/t/p/w500/7jP4syZQ4ccpd8H2HvyubRLHQcI.jpg	t
2797	James Clayton	\N	https://image.tmdb.org/t/p/w500/ldNgu7JuEt58hTxXHBBpycOcVZ3.jpg	t
2798	Lou Diamond Phillips	\N	https://image.tmdb.org/t/p/w500/yqGZwaGe8XgoxfO7zmx7weGBaXZ.jpg	t
2799	Fei Ren	\N	https://image.tmdb.org/t/p/w500/jukcIX4bNi95T8dCiRtyOnPduMH.jpg	t
2800	Alisha Ahamed	\N	https://image.tmdb.org/t/p/w500/zBnenP9hJr8VTsv2KsIcHLpG9HW.jpg	t
2801	Philip Granger	\N	https://image.tmdb.org/t/p/w500/bkrnrtSiUnumWVpAOy5QDcOePiA.jpg	t
2802	James Hutson	\N	\N	t
2803	Elan Ross Gibson	\N	https://image.tmdb.org/t/p/w500/pYwKO2Ox38IEvd47VsgoNFXNvnb.jpg	t
2804	Suleiman Abutu	\N	\N	t
2805	Michael Matic	\N	\N	t
2806	Katie Holmes	\N	https://image.tmdb.org/t/p/w500/gDhc9rLbhpXdY8lISD7yPiIhvp4.jpg	t
2807	Tom Wilkinson	\N	https://image.tmdb.org/t/p/w500/xSUohQDXuepOU2nSqtDj2us5RZo.jpg	t
2808	Rutger Hauer	\N	https://image.tmdb.org/t/p/w500/3Lly7qwOrESdFcwyaiEOfPlB76l.jpg	t
2809	Mark Boone Junior	\N	https://image.tmdb.org/t/p/w500/swWzGOTX3SQ2udv7NQhAE1DlZsb.jpg	t
2810	Connor Swindells	\N	https://image.tmdb.org/t/p/w500/12mK65Y0oLnJWgTK6jeI6q8p1xE.jpg	t
2811	Golshifteh Farahani	\N	https://image.tmdb.org/t/p/w500/lbsd2lAIQq4egOUXDIfjhte12vv.jpg	t
2812	Ellie Bamber	\N	https://image.tmdb.org/t/p/w500/7hWOxGSLeIbCrcwBT83NRJNK6p3.jpg	t
2813	Rafe Spall	\N	https://image.tmdb.org/t/p/w500/5tGhC9MGT4FGaJHr2LGYcRV4rbJ.jpg	t
2814	Solly McLeod	\N	https://image.tmdb.org/t/p/w500/6aMA4kUV1ji4uu3zzBzQ9fwgUDO.jpg	t
2815	Taylor Zakhar Perez	\N	https://image.tmdb.org/t/p/w500/hLJo1a0Ca49QRQjUvq2c07wSVTN.jpg	t
2816	Rachel Hilson	\N	https://image.tmdb.org/t/p/w500/nweHoDB305tViP7998kI14QjCK3.jpg	t
2817	Sarah Shahi	\N	https://image.tmdb.org/t/p/w500/crKD1ax5wRRZ4QM7nQyH8K2deaA.jpg	t
2818	Thomas Flynn	\N	https://image.tmdb.org/t/p/w500/neN8aknq1f8oYcWeDuNhNyHF9IZ.jpg	t
2819	Malcolm Atobrah	\N	https://image.tmdb.org/t/p/w500/6fZfZZunS7bcKDRlIjifTzDmXq1.jpg	t
2820	Bowen Yang	\N	https://image.tmdb.org/t/p/w500/lrebxaz4BGJucBW79cakZ0HsSa1.jpg	t
2821	Mandy Moore	\N	https://image.tmdb.org/t/p/w500/1Z5yJ6FUsEtlVZzpyzOpfzvcpcm.jpg	t
2822	Zachary Levi	\N	https://image.tmdb.org/t/p/w500/1W8L3kEMMPF9umT3ZGaNIiCYKfZ.jpg	t
2823	Donna Murphy	\N	https://image.tmdb.org/t/p/w500/tmre2oZkIHGqnLhWeldpX2Ujgl0.jpg	t
2824	Ron Perlman	\N	https://image.tmdb.org/t/p/w500/pOgMRdJhbBsvwGLRFXPRASTfcay.jpg	t
2825	M.C. Gainey	\N	https://image.tmdb.org/t/p/w500/nM82se0lOFbOhhj3J6tRFcdEydO.jpg	t
2826	Paul F. Tompkins	\N	https://image.tmdb.org/t/p/w500/nWAfT0mY4uTzQpZnPcMxRHnICCy.jpg	t
2827	Richard Kiel	\N	https://image.tmdb.org/t/p/w500/wop4KV2ywl6gdYnCUs1OthtGylM.jpg	t
2828	Delaney Rose Stein	\N	https://image.tmdb.org/t/p/w500/fivjClC0riAPwL9esdOAkAHWdS3.jpg	t
2829	Ben Stiller	\N	https://image.tmdb.org/t/p/w500/scgpxhI05JpdNXXfmpK6z0rPOWN.jpg	t
2830	Chris Rock	\N	https://image.tmdb.org/t/p/w500/cqI8yQ00GNDV3PAAz5UeLj7vOX0.jpg	t
2831	David Schwimmer	\N	https://image.tmdb.org/t/p/w500/XtKzJ9lM5Xwa7vCmE4xNHy6Owf.jpg	t
2832	Jada Pinkett Smith	\N	https://image.tmdb.org/t/p/w500/vt1Z1Fsu7gjp4L0OHey9Aa79lWj.jpg	t
2833	Sacha Baron Cohen	\N	https://image.tmdb.org/t/p/w500/irirhgOX0siCyqvMrt2hoJpXfOG.jpg	t
2834	Debbie Ash	\N	https://image.tmdb.org/t/p/w500/z22P1jpbRoAsRQ18gLtBo81TSR2.jpg	t
2835	Carolyne Argyle	\N	https://image.tmdb.org/t/p/w500/6p84KXLEx9llGI1UR2LfNG7EzlF.jpg	t
2836	Beryl Reid	\N	https://image.tmdb.org/t/p/w500/ro1P6veYZMON2P6LIrnWha61p0S.jpg	t
2837	John Le Mesurier	\N	https://image.tmdb.org/t/p/w500/2rElQQzZXkxPj2UnqsDSCkFHQxk.jpg	t
2838	Arthur Askey	\N	https://image.tmdb.org/t/p/w500/nlvwsSvzXaN22nOAnxlvtXLcJCt.jpg	t
2839	Liz Fraser	\N	https://image.tmdb.org/t/p/w500/q112oabhl6IPm00pKKrD8HCiG2F.jpg	t
2840	John Junkin	\N	https://image.tmdb.org/t/p/w500/d224PCAmBldQ98JFRmdEVaWaDP5.jpg	t
2841	Lance Percival	\N	https://image.tmdb.org/t/p/w500/rTpL9LlCd61UszTMqNRxfrZ9FpZ.jpg	t
2842	Bob Todd	\N	https://image.tmdb.org/t/p/w500/wsbJt5OFV7OA4OKqNGr31LXmhdP.jpg	t
2843	Christopher Ellison	\N	https://image.tmdb.org/t/p/w500/zrfpZgJBN7eVA09g4AOYpx69bLT.jpg	t
2844	二宮和也	\N	https://image.tmdb.org/t/p/w500/4mxogZeEPZiVrnJ4L8ICvOJONfs.jpg	t
2845	河内大和	\N	https://image.tmdb.org/t/p/w500/8CUS41LVMlBH5Am2uZC3F44yyDw.jpg	t
2846	Naru Asanuma	\N	https://image.tmdb.org/t/p/w500/orV4an2sD7PgLpHCulgCBDgs1bl.jpg	t
2847	花瀬琴音	\N	https://image.tmdb.org/t/p/w500/xSimDM5cdwBtVAa7FJ36gFyMC0p.jpg	t
2848	小松菜奈	\N	https://image.tmdb.org/t/p/w500/sBVCeJ9hLDCdOenLzwzmVtFfws6.jpg	t
2849	Cindy Morgan	\N	https://image.tmdb.org/t/p/w500/7VRUz6w2PDN75gOM12cRAREWu5f.jpg	t
2850	Barnard Hughes	\N	https://image.tmdb.org/t/p/w500/1QwqpJ37wE5cjrDxHoTWfZk4oVs.jpg	t
2851	Dan Shor	\N	https://image.tmdb.org/t/p/w500/xsdNaTwcqogHFKBipxtiAZJFAlX.jpg	t
2852	Peter Jurasik	\N	https://image.tmdb.org/t/p/w500/7zqyg8kDaYHyXZfabxQ5M6tq5Fp.jpg	t
2853	Tony Stephano	\N	https://image.tmdb.org/t/p/w500/lG1jxmF21jgPV34WCVSqcRfovec.jpg	t
2854	Craig Chudy	\N	\N	t
2855	Vince Deadrick Jr.	\N	https://image.tmdb.org/t/p/w500/sC1sdK5wObOuwtjHhMXKjg42FoJ.jpg	t
2856	Jesse Eisenberg	\N	https://image.tmdb.org/t/p/w500/8BMnXLVJDysMO1E8JCAyOFv2QAb.jpg	t
2857	Woody Harrelson	\N	https://image.tmdb.org/t/p/w500/igxYDQBbTEdAqaJxaW6ffqswmUU.jpg	t
2858	Isla Fisher	\N	https://image.tmdb.org/t/p/w500/zNKTzzuyMYaCGEZKhwhqV1K8ffo.jpg	t
2859	Justice Smith	\N	https://image.tmdb.org/t/p/w500/htJrcOzYkLVcnF4ExT4O1bDN5e5.jpg	t
2860	Dominic Sessa	\N	https://image.tmdb.org/t/p/w500/cTYdhJrye7oTREIkQaLAuLoJ8Rt.jpg	t
2861	Patra Au Ga-Man	\N	https://image.tmdb.org/t/p/w500/eHXhCsS20XPri5Du56GAhdrkWaI.jpg	t
2862	Maggie Li Lin-Lin	\N	https://image.tmdb.org/t/p/w500/3aNVa4MRrLz9s1x3PMFSOKE0hWI.jpg	t
2863	Hui So-Ying	\N	https://image.tmdb.org/t/p/w500/65zyA9AqDuWVJCq2Oml786k4usw.jpg	t
2864	Leung Chung-Hang	\N	https://image.tmdb.org/t/p/w500/k9GRTwp86GGOkQZ0HIZ4sm7Eiy8.jpg	t
2865	Fish Liew	\N	https://image.tmdb.org/t/p/w500/wouDO99Pw2tCjhRYCbck9qPuGo1.jpg	t
2866	梁雍婷	\N	https://image.tmdb.org/t/p/w500/frTVaV1U4KqPeHwSnoeB1JorUtw.jpg	t
2867	Lai Chai Ming	\N	\N	t
2868	Luna Shaw	\N	https://image.tmdb.org/t/p/w500/yGqWSbEHW9MYBUCzeYPUHQaP2YP.jpg	t
2869	李麗霞	\N	\N	t
2870	Kim Young-sam	\N	https://image.tmdb.org/t/p/w500/pb9SlxZToNmezFYEGfLqS8DL7k6.jpg	t
2871	Ah Ri	\N	https://image.tmdb.org/t/p/w500/8VbXDAHDuHbrOHIgUDDjIwrUidh.jpg	t
2872	Kim Hae-jin	\N	https://image.tmdb.org/t/p/w500/jYuQvi5RVwRq5dr9U0OT7zQD3cG.jpg	t
2873	Park Cho-hyeon	\N	https://image.tmdb.org/t/p/w500/ktAzF54Zrj4h5PbjwdJZvPghFDQ.jpg	t
2874	김재록	\N	https://image.tmdb.org/t/p/w500/esGLG5p5tlnP7VNFSRyertWeMVS.jpg	t
2875	Lee Jeong-gil	\N	https://image.tmdb.org/t/p/w500/eiV7V9fY0RoQuaKdnlnAktkpBG8.jpg	t
2876	Kim Dae-Beom	\N	https://image.tmdb.org/t/p/w500/o5cqyTvGwj6lpjmKD16Qx3uhcHM.jpg	t
2877	Yvonne Strahovski	\N	https://image.tmdb.org/t/p/w500/giUmbTd2Kw5BSWHHSFLgVjJqIGl.jpg	t
2878	Betty Gilpin	\N	https://image.tmdb.org/t/p/w500/hBOviIHCVqbWyyPUoIxZohDl5SL.jpg	t
2879	Sam Richardson	\N	https://image.tmdb.org/t/p/w500/hUN7IIbegvL7aSqQI5KRWoqqJLm.jpg	t
2880	Edwin Hodge	\N	https://image.tmdb.org/t/p/w500/lkouUtGzfgUPUj1LP8cEk8yvKXo.jpg	t
2881	Jasmine Mathews	\N	https://image.tmdb.org/t/p/w500/zxm5F8jUkzbJBOTTzgj2kiuwK8Y.jpg	t
2882	Ryan Kiera Armstrong	\N	https://image.tmdb.org/t/p/w500/yc59dX19baAR9wHF6035EjkUFUr.jpg	t
2883	Keith Powers	\N	https://image.tmdb.org/t/p/w500/weKSlGfDRU3RR883Tv6L22Gg4SE.jpg	t
2884	Mary Lynn Rajskub	\N	https://image.tmdb.org/t/p/w500/oi94VPrp5Ur0nkIqyk6jRu8Eayz.jpg	t
2885	Cecily Strong	\N	https://image.tmdb.org/t/p/w500/g1WbsojbgQAB72UfUJnNWPaB4b5.jpg	t
2886	Snoop Dogg	\N	https://image.tmdb.org/t/p/w500/rbxBK2m6fEq0oHeMoBUMVYkJEdJ.jpg	t
2887	Henry Cavill	\N	https://image.tmdb.org/t/p/w500/kN3A5oLgtKYAxa9lAkpsIGYKYVo.jpg	t
2888	Amy Adams	\N	https://image.tmdb.org/t/p/w500/lub0nBRhsCu2pByvfvxt5DcW86d.jpg	t
2889	Kevin Costner	\N	https://image.tmdb.org/t/p/w500/bykmxJHLfbFM3NT05RZXhx8YTzF.jpg	t
2890	Ayelet Zurer	\N	https://image.tmdb.org/t/p/w500/ea3MLLgsIdDhDLkjUCmkR0ZxjDC.jpg	t
2891	Christopher Meloni	\N	https://image.tmdb.org/t/p/w500/nHlFFbRTh85vkohBBtRQjYnWEtb.jpg	t
2892	Richard Schiff	\N	https://image.tmdb.org/t/p/w500/oFDka3Y5H3DBiZRqbdPabtX8ncP.jpg	t
2893	Clara Galle	\N	https://image.tmdb.org/t/p/w500/ipZQNX8KECqeCHoD4dmbb883lzP.jpg	t
2894	Julio Peña	\N	https://image.tmdb.org/t/p/w500/9kXGecZrQp5DKlok1p7N73CmiiB.jpg	t
2895	Guillermo Lasheras	\N	https://image.tmdb.org/t/p/w500/hZMMrFZRzEQdcmYrahZAwYalAYO.jpg	t
2896	Natalia Azahara	\N	https://image.tmdb.org/t/p/w500/ccsb7gTOsUcWLctzT9bfSBj7OkW.jpg	t
2897	Hugo Arbues	\N	https://image.tmdb.org/t/p/w500/7AcFfeIjcK6aVLQYfvIfqOZa0J7.jpg	t
2898	Eric Masip	\N	https://image.tmdb.org/t/p/w500/2JmF1hJ40a3k3oyeiAoITiX1CKI.jpg	t
2899	Pilar Castro	\N	https://image.tmdb.org/t/p/w500/4IK4i5pRkuTDVnmB9A7kMS7dbz7.jpg	t
2900	Abel Folk	\N	https://image.tmdb.org/t/p/w500/o3C9XMDjsUwrX6pq5J7QfV5Tzbh.jpg	t
2901	Rachel Lascar	\N	https://image.tmdb.org/t/p/w500/dwk9VqbdpYzB2jc2QSVoHYbrCcs.jpg	t
2902	Emilia Lazo	\N	https://image.tmdb.org/t/p/w500/b5xHIrNg4G2gJuqEClJFbzfugps.jpg	t
2903	James Spader	\N	https://image.tmdb.org/t/p/w500/uET0mbf2bMkUXbRb1Oxi8Qjqcw3.jpg	t
2904	Kelly Macdonald	\N	https://image.tmdb.org/t/p/w500/k0yVocTnTMWlNdaeOO7YRViCdhO.jpg	t
2905	Billy Connolly	\N	https://image.tmdb.org/t/p/w500/imqsEA1EPet7OvHx80VfTYfFcWf.jpg	t
2906	Julie Walters	\N	https://image.tmdb.org/t/p/w500/bCTkV2OUgzbJdQEoCk3GesE4DXq.jpg	t
2907	Kevin McKidd	\N	https://image.tmdb.org/t/p/w500/KtmEKOSehmQ35JfGjEjpqlypbP.jpg	t
2908	Craig Ferguson	\N	https://image.tmdb.org/t/p/w500/mBxNrOxdQeM7bVBveE47Syj9ES6.jpg	t
2909	Peigi Barker	\N	https://image.tmdb.org/t/p/w500/xwlTiTmOTvyhRYjAeYHOdxMgeZQ.jpg	t
2910	Steve Purcell	\N	https://image.tmdb.org/t/p/w500/8wdCJVDq7v4g5N9Qkv8D87B3Xne.jpg	t
2911	Patrick Doyle	\N	https://image.tmdb.org/t/p/w500/w7ZWMi75p0a6ElIbZw9mfkmjGPs.jpg	t
2912	Ruby Rose	\N	https://image.tmdb.org/t/p/w500/djhT0A2hZxpYKPnCeRtim8qUdPi.jpg	t
2913	Deepika Padukone	\N	https://image.tmdb.org/t/p/w500/sXgEh0z6NzyvmEeBeLPK1ON7NBY.jpg	t
2914	Toni Collette	\N	https://image.tmdb.org/t/p/w500/lzXRh16qe4HHeBN6tMyw0DHvaMn.jpg	t
2915	Rory McCann	\N	https://image.tmdb.org/t/p/w500/xcM4iZ6DAZ6P5LuJpx0fJn7sKqO.jpg	t
2916	Nina Dobrev	\N	https://image.tmdb.org/t/p/w500/dDRGIMt9qHgaaGoDuzwO0XDfOBS.jpg	t
2917	Seann William Scott	\N	https://image.tmdb.org/t/p/w500/mKc2YXdh8d4U2jYDwpLWaOY6Jwg.jpg	t
2918	Johnny Simmons	\N	https://image.tmdb.org/t/p/w500/51LZiAAI3ZW4vabNOQnd3weYgUm.jpg	t
2919	Lovi Poe	\N	https://image.tmdb.org/t/p/w500/1DxKNVTkSb89UA9kHMTZ9uG7G8t.jpg	t
2920	Rob Riggle	\N	https://image.tmdb.org/t/p/w500/hQgOp8vWxl6KPZbqzKSSL4k6G1j.jpg	t
2921	Chance Perdomo	\N	https://image.tmdb.org/t/p/w500/xRRDtdHhTewrKMj5cpcmEkPNmuP.jpg	t
2922	Ethan Suplee	\N	https://image.tmdb.org/t/p/w500/gGSb8P9nQdDNu0JC65zyAyMUFhS.jpg	t
2923	Jack Conley	\N	https://image.tmdb.org/t/p/w500/78bceHx2BdTJLhhomIbpQKm15TR.jpg	t
2924	Marcelle LeBlanc	\N	https://image.tmdb.org/t/p/w500/tJqu8Qo38oY0uVsYCOv6BaCHU6G.jpg	t
2925	Andre Hyland	\N	https://image.tmdb.org/t/p/w500/47bApEaHjt7q793rWJqndMe6kwR.jpg	t
2926	John Patrick Jordan	\N	https://image.tmdb.org/t/p/w500/zjqNGyZwURh1FagXWREy3hOwxKa.jpg	t
2927	Frances Conroy	\N	https://image.tmdb.org/t/p/w500/aJRQAkO24L6bH8qkkE5Iv1nA3gf.jpg	t
2928	Brett Cullen	\N	https://image.tmdb.org/t/p/w500/4P6TsRcnr9MRbXlCdHitulGM5LT.jpg	t
2929	Shea Whigham	\N	https://image.tmdb.org/t/p/w500/qsKe5oze7fdS96BrXDTc5bcxyEl.jpg	t
2930	Bill Camp	\N	https://image.tmdb.org/t/p/w500/wxYyJSltCHwU0MTg838SllOlvNT.jpg	t
2931	Glenn Fleshler	\N	https://image.tmdb.org/t/p/w500/x1Cef2yPZS7bJTwxI7DX3q0HNcv.jpg	t
2932	Leigh Gill	\N	https://image.tmdb.org/t/p/w500/bn9h4ovCuMj01OybjIoTrakOL2z.jpg	t
2933	Josh Pais	\N	https://image.tmdb.org/t/p/w500/uH90fGfLLzYCX02yOW3kH4LMO7n.jpg	t
2934	Ramy Youssef	\N	https://image.tmdb.org/t/p/w500/uLQWOoq11TKqnLfJBu90aKEGj8O.jpg	t
2935	Suzy Bemba	\N	https://image.tmdb.org/t/p/w500/1JT97VgV2l6jNpFeYXZ8SQu3BOr.jpg	t
2936	Jerrod Carmichael	\N	https://image.tmdb.org/t/p/w500/v1i5xodXbPw3blXYg4v0HmH3PGK.jpg	t
2937	Vicki Pepperdine	\N	https://image.tmdb.org/t/p/w500/kosVS1yJJ60fG1rZRfGpgJmJt4n.jpg	t
2938	Hanna Schygulla	\N	https://image.tmdb.org/t/p/w500/hAZVxNCVzYBq3ToWzE01LXK6Oum.jpg	t
2939	Keir Gilchrist	\N	https://image.tmdb.org/t/p/w500/vFrziqS1PDoHYFs2Vn9ro3577Ry.jpg	t
2940	Daniel Zovatto	\N	https://image.tmdb.org/t/p/w500/gV0qvvMrNPXjDfsjgzLNNayaemj.jpg	t
2941	Jake Weary	\N	https://image.tmdb.org/t/p/w500/vDzRYoPsLN3wW9QqeHVQkWnUXRw.jpg	t
2942	Olivia Luccardi	\N	https://image.tmdb.org/t/p/w500/ziFOKDl9PPPteadAPkcyR3etcjq.jpg	t
2943	Lili Sepe	\N	https://image.tmdb.org/t/p/w500/tCYChRaEijJ3RhEYn9mi1W7Qlmw.jpg	t
2944	Bailey Spry	\N	https://image.tmdb.org/t/p/w500/bW1suPa3OnoPoAygpYHhR8BFhk5.jpg	t
2945	Carollette Phillips	\N	https://image.tmdb.org/t/p/w500/oeCgHp1Ixm8szwcTn0kLWjJecI5.jpg	t
2946	Loren Bass	\N	\N	t
2947	Charles Gertner	\N	\N	t
2948	Peter Riegert	\N	https://image.tmdb.org/t/p/w500/yPgaRZBMVy9eoNNuiPIm0wzG9sD.jpg	t
2949	Peter Greene	\N	https://image.tmdb.org/t/p/w500/kPnF9rK6ULrIycK7n0ewYjInMZG.jpg	t
2950	Amy Yasbeck	\N	https://image.tmdb.org/t/p/w500/5BbyiBjp5T8pKUcauVTweRcvLJJ.jpg	t
2951	Richard Jeni	\N	https://image.tmdb.org/t/p/w500/fyGOCHDImuNP9KDbGCQdkmg94vO.jpg	t
2952	Orestes Matacena	\N	https://image.tmdb.org/t/p/w500/kBN6pmgyLs4LZ2IUAcxSQ8SsE13.jpg	t
2953	Tim Bagley	\N	https://image.tmdb.org/t/p/w500/l00IDn897RHTbTB7GcU1Pm9dKsO.jpg	t
2954	Nancy Fish	\N	https://image.tmdb.org/t/p/w500/4hsbpX8MaxXDQBh9T4IJZD3wGza.jpg	t
2955	Johnny Williams	\N	https://image.tmdb.org/t/p/w500/mQNhYK7SCzj6TY6m764ROposuRY.jpg	t
2956	Jennifer Lawrence	\N	https://image.tmdb.org/t/p/w500/nSWSc3pAQEw0lPAmAk4d9GFMv6k.jpg	t
2957	Liam Hemsworth	\N	https://image.tmdb.org/t/p/w500/7UIm9RoBnlqS1uLlbElAY8urdWD.jpg	t
2958	Elizabeth Banks	\N	https://image.tmdb.org/t/p/w500/zrkI1dYucpTM8Qydtrtro9MgQPb.jpg	t
2959	Julianne Moore	\N	https://image.tmdb.org/t/p/w500/3YF19rWusxWfEI59ZM33dFhasRq.jpg	t
2960	Philip Seymour Hoffman	\N	https://image.tmdb.org/t/p/w500/50rqDkmvXwjwVhFH7q6ph2Rkw7S.jpg	t
2961	Stanley Tucci	\N	https://image.tmdb.org/t/p/w500/q4TanMDI5Rgsvw4SfyNbPBh4URr.jpg	t
2962	Donald Sutherland	\N	https://image.tmdb.org/t/p/w500/yM8WO2BYqFvgQXAvf4CIuCYnY4j.jpg	t
2963	Ed Asner	\N	https://image.tmdb.org/t/p/w500/uj5TQBVb1jdPrvSEdwjzT6DRmqi.jpg	t
2964	Christopher Plummer	\N	https://image.tmdb.org/t/p/w500/iZh3s9Vy9vYD4DYnAda6C1kdeco.jpg	t
2965	Jordan Nagai	\N	https://image.tmdb.org/t/p/w500/j1kVS2sI3wWIHCCzzYD1buXAP9e.jpg	t
2966	Jerome Ranft	\N	https://image.tmdb.org/t/p/w500/76XFeM9FdbGkd0mxkEMstQu6na2.jpg	t
2967	David Kaye	\N	https://image.tmdb.org/t/p/w500/izxtFSio5twcVA1oJWPvobxpcZj.jpg	t
2968	Elie Docter	\N	https://image.tmdb.org/t/p/w500/zTOUIqYx0ip4XaYcbTaxCxVY2Xf.jpg	t
2969	Jeremy Leary	\N	https://image.tmdb.org/t/p/w500/yYBprLIwXLt1stCGmrPTYLaiZyW.jpg	t
2970	Serayah	\N	https://image.tmdb.org/t/p/w500/32mndDboRoyiIzXWfyWgF00h1j9.jpg	t
2971	Tyler Lepley	\N	https://image.tmdb.org/t/p/w500/i0acVycILja1zU3HVH6PqwAzZtp.jpg	t
2972	Walnette Marie Santiago	\N	https://image.tmdb.org/t/p/w500/9DWzsnImaHYIMzCMSGhFNm6mMAC.jpg	t
2973	Nijah Brenea	\N	https://image.tmdb.org/t/p/w500/yRPkVQvwjEXpzbM5DrfMhEZ7ozt.jpg	t
2974	James Lee Thomas	\N	https://image.tmdb.org/t/p/w500/2K9xips6H7e5RL5lKqHZSXsETOV.jpg	t
2975	Babyface	\N	https://image.tmdb.org/t/p/w500/xEizznOVxJ4UVanZcRSNupyQgB6.jpg	t
2976	Jermaine Dupri	\N	https://image.tmdb.org/t/p/w500/9hwNmJBCsHE5otFYRLUZQg1o2J8.jpg	t
2977	Lecrae	\N	https://image.tmdb.org/t/p/w500/8HMZBuIoug3wsiD74GaboywbbRN.jpg	t
2978	Gregory Alan Williams	\N	https://image.tmdb.org/t/p/w500/3IM9qtI4c4zgraPNtRI3kCPivAo.jpg	t
2979	Dane DeHaan	\N	https://image.tmdb.org/t/p/w500/8asHTI9I2Xz0ki018r7b0LuLWf4.jpg	t
2980	Colm Feore	\N	https://image.tmdb.org/t/p/w500/jeotIVor4fH3oqxkRZ6qyUbgrJ3.jpg	t
2981	Felicity Jones	\N	https://image.tmdb.org/t/p/w500/35KdWSfTldNEdsn4MUGFIRoxJEu.jpg	t
2982	Campbell Scott	\N	https://image.tmdb.org/t/p/w500/lJCxZpQru76zBeuZGxc0Gm5Pm9y.jpg	t
2983	Robin Williams	\N	https://image.tmdb.org/t/p/w500/iYdeP6K0qz44Wg2Nw9LPJGMBkQ5.jpg	t
2984	Robert Sean Leonard	\N	https://image.tmdb.org/t/p/w500/nlDEfUE4GH6UVEQS5v7NG9sXY8X.jpg	t
2985	Josh Charles	\N	https://image.tmdb.org/t/p/w500/hedIAse3q3w1Pz7BhrGnzKcmYX8.jpg	t
2986	Gale Hansen	\N	https://image.tmdb.org/t/p/w500/gVZ9TFvseA3I0fLLJiXKInzBygp.jpg	t
2987	Dylan Kussman	\N	https://image.tmdb.org/t/p/w500/33V8NdkLrpSCEVeIiKk5DoGRthx.jpg	t
2988	Allelon Ruggiero	\N	https://image.tmdb.org/t/p/w500/sSjaviVlBCnZYipURQY5o9rvPl7.jpg	t
2989	James Waterston	\N	https://image.tmdb.org/t/p/w500/7IPxmwB7f2CqCJvxAea0BjwI5Fz.jpg	t
2990	Norman Lloyd	\N	https://image.tmdb.org/t/p/w500/z7jg1zuFfC5jqn4kI40OGAOrD5U.jpg	t
2991	Kurtwood Smith	\N	https://image.tmdb.org/t/p/w500/7dqsk4NYbNZNnmppv2zPuf1hKBn.jpg	t
2992	Michelle Williams	\N	https://image.tmdb.org/t/p/w500/b6mHfqOsf7zS7HzQL6dOfzbdmy7.jpg	t
2993	Riz Ahmed	\N	https://image.tmdb.org/t/p/w500/1uP9RaX7BGVx7XGTEmwObBJJzsC.jpg	t
2994	Scott Haze	\N	https://image.tmdb.org/t/p/w500/6cd3Jt8Vo52j8cRKbNf1j7cERhs.jpg	t
2995	Melora Walters	\N	https://image.tmdb.org/t/p/w500/FSxiDBekrKgmzow1j3UhmNHOhI.jpg	t
2996	Malcolm C. Murray	\N	https://image.tmdb.org/t/p/w500/1TkiBdgPv0AmKFXyB1dINzd4GJ8.jpg	t
2997	Aamir Khan	\N	https://image.tmdb.org/t/p/w500/6uiZSwi2kvd1jZ7X7Xz9W9VGuV4.jpg	t
2998	Genelia D'Souza	\N	https://image.tmdb.org/t/p/w500/q4g6maGv227VuxGQdtNfyJ1SKXR.jpg	t
2999	Dolly Ahluwalia	\N	https://image.tmdb.org/t/p/w500/cZDDdr59pQGrjHrRH5THBJkbzp1.jpg	t
3000	Brijendra Kala	\N	https://image.tmdb.org/t/p/w500/wogG1hX0EHzAhnfnGpN3tY3Ch6n.jpg	t
3001	Happy Ranajit	\N	https://image.tmdb.org/t/p/w500/6sN350Yp85ggomS5Cy98K2o7G3x.jpg	t
3002	Deepraj Rana	\N	https://image.tmdb.org/t/p/w500/iwcSbYrvzo7crjtMQwMSqB9gvqv.jpg	t
3003	Gurpal Singh	\N	\N	t
3004	Aroush Datta	\N	\N	t
3005	Gopi Krishna Varma	\N	\N	t
3006	Samvit Desai	\N	\N	t
3007	Max von Sydow	\N	https://image.tmdb.org/t/p/w500/fOzSDFqMx84NR7PSv36P7j0Qf1q.jpg	t
3008	Emily Mortimer	\N	https://image.tmdb.org/t/p/w500/oZ4CZW2eW8lL2alD1mwZrFkfACI.jpg	t
3009	Ted Levine	\N	https://image.tmdb.org/t/p/w500/451KSkowLW6M2Au0wBKZZcidgGm.jpg	t
3010	John Carroll Lynch	\N	https://image.tmdb.org/t/p/w500/i6xsWIgo3kW5Dc4A6VhQ17G9nuy.jpg	t
3011	Toby Kebbell	\N	https://image.tmdb.org/t/p/w500/mlYytYJvoEHmhDH2enLtES1098Q.jpg	t
3012	Adi Bielski	\N	https://image.tmdb.org/t/p/w500/8BvlIvM8IcDWogCKmFzD4lChTwQ.jpg	t
3013	Brian Cox	\N	https://image.tmdb.org/t/p/w500/scSjbFCTRngXlkJRoKptM5kQGw7.jpg	t
3014	Tony Curran	\N	https://image.tmdb.org/t/p/w500/3jDsskeIzbCNKuqu2WIxmtmv8mG.jpg	t
3015	Ashley Thomas	\N	https://image.tmdb.org/t/p/w500/rdNgke4IL7x3mORHKE8HtbOAF8F.jpg	t
3016	Tom Brooke	\N	https://image.tmdb.org/t/p/w500/pUQ3KyfTLPLkBP8KvCcwEyHUMB7.jpg	t
3017	Ivanno Jeremiah	\N	https://image.tmdb.org/t/p/w500/95zIYxkcpWUowhsHfIOgnjG7xlp.jpg	t
3018	Mem Ferda	\N	https://image.tmdb.org/t/p/w500/cOnmdM0ItlMW8S5TXt9nZoNIoV.jpg	t
3019	Selva Rasalingam	\N	https://image.tmdb.org/t/p/w500/d9N8PWdMqE5gl8oooH5iHbMwCbw.jpg	t
3020	Conrad Peters	\N	\N	t
3021	Steven Bauer	\N	https://image.tmdb.org/t/p/w500/bdBfcd6cFKYPdWfeJ6X7tCpuKfu.jpg	t
3022	Michelle Pfeiffer	\N	https://image.tmdb.org/t/p/w500/oGUmQBU87QXAsnaGleYaAjAXSlj.jpg	t
3023	Mary Elizabeth Mastrantonio	\N	https://image.tmdb.org/t/p/w500/vbZ1E557K5oj34xLHR5ErO8wPCi.jpg	t
3024	Robert Loggia	\N	https://image.tmdb.org/t/p/w500/mRSUgJnfprCNw83pyVfpfW7ryfK.jpg	t
3025	Miriam Colon	\N	https://image.tmdb.org/t/p/w500/9jnz7htVMCTDNRDmoi2mdOKv6Pj.jpg	t
3026	F. Murray Abraham	\N	https://image.tmdb.org/t/p/w500/p2RYVGdrcP0m70BkkiKcwyrDeim.jpg	t
3027	Paul Shenar	\N	https://image.tmdb.org/t/p/w500/kc0I4h9fTY8WP3wyQbwVWEzbmil.jpg	t
3028	Harris Yulin	\N	https://image.tmdb.org/t/p/w500/3W758yxhdphzblpgDz4wKgLCriB.jpg	t
3029	Ángel Salazar	\N	https://image.tmdb.org/t/p/w500/lZQXjnIHxFa2DjaStlYZcW7GqES.jpg	t
3030	D'Pharaoh Woon-A-Tai	\N	https://image.tmdb.org/t/p/w500/ozEGeNK9r2EFn4rNU0DSuNQaia0.jpg	t
3031	Cosmo Jarvis	\N	https://image.tmdb.org/t/p/w500/1kgghZ558CxZCJip5ufO6BAqUGp.jpg	t
3032	Finn Bennett	\N	https://image.tmdb.org/t/p/w500/p4ya77nmLlhS2cyPKUZi9zVD4Mu.jpg	t
3033	Taylor John Smith	\N	https://image.tmdb.org/t/p/w500/6dXZRf8ePa1oxQN9a5hFGEjDoI0.jpg	t
3034	Michael Gandolfini	\N	https://image.tmdb.org/t/p/w500/28b4ER8m7AJ40vsgocFIhwTKkzp.jpg	t
3035	Adain Bradley	\N	https://image.tmdb.org/t/p/w500/qPe2AgBrIIOOv4uLK984dxgGzxE.jpg	t
3036	Noah Centineo	\N	https://image.tmdb.org/t/p/w500/kXLuzSWRqM2P45uNcgb0v3H8dnE.jpg	t
3037	Evan Holtzman	\N	https://image.tmdb.org/t/p/w500/6bMtNQloX5g4d1xNa4QLKaQKL0z.jpg	t
3038	夏若妍	\N	https://image.tmdb.org/t/p/w500/lwrHEhClNqpCX5TBWecbDkspqDf.jpg	t
3039	尹子維	\N	https://image.tmdb.org/t/p/w500/oMM2WF0hqqel4OJJMyUHZW9feT6.jpg	t
3040	王星辰	\N	https://image.tmdb.org/t/p/w500/cyraTe5jvCHnko5MNMg9vEn9mhO.jpg	t
3041	駱達華	\N	https://image.tmdb.org/t/p/w500/j1omPKdvfWNnDEoRc8Or7e8Zw1J.jpg	t
3042	車保羅	\N	https://image.tmdb.org/t/p/w500/qDiFHuBJtIyq2bWkctvu87L4pWc.jpg	t
3043	Wang Zirun	\N	https://image.tmdb.org/t/p/w500/1XHuFKPtm81oZHzzDudGvFYa8tC.jpg	t
3044	Xu Shao-Hang	\N	https://image.tmdb.org/t/p/w500/rWNPw4WOyGRbKeudmxWj3182K85.jpg	t
3045	Jiu Kong	\N	https://image.tmdb.org/t/p/w500/eGk2ixDt6db9vIdUc0P8TB3tvbJ.jpg	t
3046	Wang Gang	\N	https://image.tmdb.org/t/p/w500/99M0PCRpjFn4wQMtmBzsuvubEpU.jpg	t
3047	Charlize Theron	\N	https://image.tmdb.org/t/p/w500/ie1KbeYFG5E0GVr1QP7tDNuXvga.jpg	t
3048	Jeffrey Jones	\N	https://image.tmdb.org/t/p/w500/jJ8mLfwxqmpCdT2vMkEaGjZZUM8.jpg	t
3049	Judith Ivey	\N	https://image.tmdb.org/t/p/w500/yaeKvc55qRoE3snY5axr86dQnHp.jpg	t
3050	Tamara Tunie	\N	https://image.tmdb.org/t/p/w500/1KM30uSzeB27UEY7ICtTVDf16CQ.jpg	t
3051	Ruben Santiago-Hudson	\N	https://image.tmdb.org/t/p/w500/tNuO8MO2jFwKo1VlQiq0tLH2rCz.jpg	t
3052	Debra Monk	\N	https://image.tmdb.org/t/p/w500/qdb43ggK8PhAoQO357hE5f5Gw3O.jpg	t
3053	Arah Alonzo	\N	https://image.tmdb.org/t/p/w500/6vr74nOxcAUb4u2xvy8luQvuIdT.jpg	t
3054	Nico Locco	\N	https://image.tmdb.org/t/p/w500/5mWKE2MAhdzpX6haB8734z1sisl.jpg	t
3055	Rica Gonzales	\N	https://image.tmdb.org/t/p/w500/9S879EnTdS8zjMca8YQEVwksKIg.jpg	t
3056	Racquel Enriquez	\N	https://image.tmdb.org/t/p/w500/g4kjebP4rGkkNj1OH2kzs4i2jcn.jpg	t
3057	Zsa Zsa Zobel	\N	https://image.tmdb.org/t/p/w500/3TELsmekQd8PFjsdxPxELFTIhEM.jpg	t
3058	Ayra Salvador	\N	https://image.tmdb.org/t/p/w500/cBz7YxFkc2AQPEbswVtyHh5hfEi.jpg	t
3059	Johnloyd Gabiano	\N	\N	t
3060	Lou Castolome	\N	\N	t
3061	Justin Ann Agullo	\N	\N	t
3062	Janine Depano	\N	\N	t
3063	Taraji P. Henson	\N	https://image.tmdb.org/t/p/w500/jUU2X9mDwJaAniEmJOfvImBS9qb.jpg	t
3064	Sherri Shepherd	\N	https://image.tmdb.org/t/p/w500/lFh8mUlf0ajtWKE80qVt1xec64C.jpg	t
3065	Sinbad	\N	https://image.tmdb.org/t/p/w500/fxvKYnwFYjglBfWScjydrChRvwZ.jpg	t
3066	Rockmond Dunbar	\N	https://image.tmdb.org/t/p/w500/gim7zIrYkbKWsp2Kod7fp74fWyI.jpg	t
3067	Ashley Versher	\N	https://image.tmdb.org/t/p/w500/35y3tRQG5T0sY4ab51EizwGNccI.jpg	t
3068	Mike Merrill	\N	https://image.tmdb.org/t/p/w500/s3Ssbi7CdfJnAFSYNNkMPtID85Q.jpg	t
3069	Glynn Turman	\N	https://image.tmdb.org/t/p/w500/ac5gjylih4RTCGf2HWuSnoZWDus.jpg	t
3070	Shalèt Monique	\N	https://image.tmdb.org/t/p/w500/qgDOowBMY4NCapJXXkQKTwvmx9n.jpg	t
3071	Diva Tyler	\N	https://image.tmdb.org/t/p/w500/vY8dQOeOLN2VIBjP0HGDqhz7Eqm.jpg	t
3072	Taito Ban	\N	https://image.tmdb.org/t/p/w500/pSExEOVmjAujKUyJJJSxC1WEzOM.jpg	t
3073	Genta Nakamura	\N	https://image.tmdb.org/t/p/w500/bl3pu2fsaNfHqnZQSDugY4V1CE0.jpg	t
3074	Haruna Mikawa	\N	https://image.tmdb.org/t/p/w500/nsrFjmDDzo4FDMhxyvuVk4mPEH3.jpg	t
3075	Daisuke Hirakawa	\N	https://image.tmdb.org/t/p/w500/8uDi5NxFdxFvfVyo4n5CeOSLWEf.jpg	t
3076	Hiroki Touchi	\N	https://image.tmdb.org/t/p/w500/bU2vogWmnTWiQEwUADWlnBqAPhJ.jpg	t
3077	Banjo Ginga	\N	https://image.tmdb.org/t/p/w500/qiXnKaZheMiVyA1U2mX9tPdNA3T.jpg	t
3078	Makoto Furukawa	\N	https://image.tmdb.org/t/p/w500/inLmBZhrqXeE9wlViyK28ocKJSw.jpg	t
3079	Shan Xin	\N	https://image.tmdb.org/t/p/w500/fm3Hpzr4Fb8g43Oo8TvDfv7O3O1.jpg	t
3080	劉朙月	\N	https://image.tmdb.org/t/p/w500/kqh1vBsQ35b617dvd9jtvQ2ii7l.jpg	t
3081	朱婧	\N	https://image.tmdb.org/t/p/w500/iabuS4GIc1kazBv9uAoVfWy5gP6.jpg	t
3082	栾立胜	\N	https://image.tmdb.org/t/p/w500/bIAe0VVT0jwsykp77CiCs0Wkywq.jpg	t
3083	傅晨阳	\N	https://image.tmdb.org/t/p/w500/zOofprWXZVL7baezLtYMhAivrlO.jpg	t
3084	言灵	\N	https://image.tmdb.org/t/p/w500/bLbsOUI1xAzQKyBwwLl7fwhsCEe.jpg	t
3085	陈啟刚	\N	https://image.tmdb.org/t/p/w500/5rANZap1ttETUqYGnjmDEL5tdXA.jpg	t
3086	王祯	\N	https://image.tmdb.org/t/p/w500/oeioRSGj9HaCAjqYZvGa26f7YC.jpg	t
3087	李璐	\N	https://image.tmdb.org/t/p/w500/1QKNEnBQV3kdwkQ8DBgbS6TY52H.jpg	t
3088	陈思宇	\N	https://image.tmdb.org/t/p/w500/mCUJU1qQb79BeI5Ke76PbOj34HV.jpg	t
3089	Martin Sheen	\N	https://image.tmdb.org/t/p/w500/m2Y3Q0uyuW6htrn2W9UWCWMkpZu.jpg	t
3090	Irrfan Khan	\N	https://image.tmdb.org/t/p/w500/qkA9PpWJRw3rNjVkWfNZdwLvRZx.jpg	t
3091	Chris Zylka	\N	https://image.tmdb.org/t/p/w500/8ctswPqjqNpDPxW792xnHEZnWwA.jpg	t
3092	倍賞千恵子	\N	https://image.tmdb.org/t/p/w500/h4RXDxmSOhjlJsb1BY20RXZ9bSR.jpg	t
3093	木村拓哉	\N	https://image.tmdb.org/t/p/w500/sswCg8kvFsgSaVJwcIKKe4K7jOe.jpg	t
3094	美輪明宏	\N	https://image.tmdb.org/t/p/w500/pCfBeLJigKnUWOAy7hsdBR7K0UV.jpg	t
3095	伊崎充則	\N	https://image.tmdb.org/t/p/w500/qg7TOjxWW2UMvUJglQ7fyLlE3gI.jpg	t
3096	Akio Otsuka	\N	https://image.tmdb.org/t/p/w500/uH9oiqOOgrsz2zNnouVZ1qPzDyb.jpg	t
3097	原田大二郎	\N	https://image.tmdb.org/t/p/w500/i1r0vuDmUgz7LgqR1qXkP0vO9MH.jpg	t
3098	加藤治子	\N	https://image.tmdb.org/t/p/w500/WyeP5PbPEDeQI83Mq1NYwB87mk.jpg	t
3099	Leah Remini	\N	https://image.tmdb.org/t/p/w500/19QpURecs6wDY9G46AmT7JnTchS.jpg	t
3100	Maaz Ali	\N	https://image.tmdb.org/t/p/w500/o9vhi2B5f0XfwYPNAG49nrhzDFW.jpg	t
3101	Paul Ben-Victor	\N	https://image.tmdb.org/t/p/w500/qhxGWVppbnwF4YuzQQtIym5z99E.jpg	t
3102	Eilise Patton	\N	https://image.tmdb.org/t/p/w500/2QPmKLkfs56ca7Qp4OaAUwdxUsk.jpg	t
3103	Savanah Joeckel	\N	https://image.tmdb.org/t/p/w500/yMTCTH5F0U8o8GIItR6hGJVmavx.jpg	t
3104	Monib Abhat	\N	https://image.tmdb.org/t/p/w500/pxpDoJBaRAKHplTIFzTOuBdZ4JW.jpg	t
3105	Senor Pablo	\N	\N	t
3106	Maia Mitchell	\N	https://image.tmdb.org/t/p/w500/4gxrYpXlUyHebEEouwLT6BgPo65.jpg	t
3107	Michael Cimino	\N	https://image.tmdb.org/t/p/w500/psYPI9wXvKJP0CRXBYXLy4aitfM.jpg	t
3108	Odessa A'zion	\N	https://image.tmdb.org/t/p/w500/meS7AUhkbybFiDtQyeczQ6rxO0F.jpg	t
3109	Belmont Cameli	\N	https://image.tmdb.org/t/p/w500/yJwjcWwDdHkCeTLGgbKkSJdXXVc.jpg	t
3110	Zsófia Temesvári	\N	https://image.tmdb.org/t/p/w500/taN3JTo9LacpllSA3pEw43U5Drk.jpg	t
3111	Tibor Szauerwein	\N	\N	t
3112	Lotta Losten	\N	https://image.tmdb.org/t/p/w500/k6C2tAU9EvFpBlLx9O2fKEVRFwx.jpg	t
3113	Tallie Medel	\N	https://image.tmdb.org/t/p/w500/8IiG5GcOfYr9tz2uC9DyFTgm8uZ.jpg	t
3114	Harry Shum Jr.	\N	https://image.tmdb.org/t/p/w500/xFQsThmdyuOk9jt3zgZL08ixf2b.jpg	t
3115	Biff Wiff	\N	https://image.tmdb.org/t/p/w500/hfXXxpwugRUHX4sxEP7njAnYXTy.jpg	t
3116	Laura Linney	\N	https://image.tmdb.org/t/p/w500/ztQXGmNLzhDV22rAvcXzCG4d0cy.jpg	t
3117	Natascha McElhone	\N	https://image.tmdb.org/t/p/w500/9pxaoasotR1pdCXYSfN1pkm0geO.jpg	t
3118	Holland Taylor	\N	https://image.tmdb.org/t/p/w500/jt9yFB3nLfZQ0c1DcnvvcfA11gB.jpg	t
3119	Ed Harris	\N	https://image.tmdb.org/t/p/w500/aAu9lJ02jlg0GAvv2vVnpJSDV1Y.jpg	t
3120	Brian Delate	\N	https://image.tmdb.org/t/p/w500/rydDYe4VHjZsJZPWOus4KGkhroG.jpg	t
3121	Peter Krause	\N	https://image.tmdb.org/t/p/w500/4p42emuJrU8fFxbBuOhYFFdzmN6.jpg	t
3122	Blair Slater	\N	https://image.tmdb.org/t/p/w500/oB59kmZNfez3Nm3biShW2L1ntJq.jpg	t
3123	Selena Gómez	\N	https://image.tmdb.org/t/p/w500/kEGPpTVNBFD25cgyEEsoOZSmaMv.jpg	t
3124	Kathryn Hahn	\N	https://image.tmdb.org/t/p/w500/9sVllAKfEls3SJD3GoPm2JEZoa5.jpg	t
3125	Molly Shannon	\N	https://image.tmdb.org/t/p/w500/5ZTbNpJtDRU4ZCH24nJvFRxaqAD.jpg	t
3126	David Spade	\N	https://image.tmdb.org/t/p/w500/8tv638lAMLmYh8bSLICqPzbW3tv.jpg	t
3127	Brian Hull	\N	https://image.tmdb.org/t/p/w500/mLq5C8100kjFad6AMLNUXX3kcPf.jpg	t
3128	Fran Drescher	\N	https://image.tmdb.org/t/p/w500/kQzvZ4ksLunfs3QZQtzRhzLJPBY.jpg	t
3129	Ray Liotta	\N	https://image.tmdb.org/t/p/w500/rhaCUi04uEXDFvuPM5Drj1AprE6.jpg	t
3130	Joe Pesci	\N	https://image.tmdb.org/t/p/w500/1WHLXwT0TDZDWFVRcFve1B0EjNK.jpg	t
3131	Lorraine Bracco	\N	https://image.tmdb.org/t/p/w500/tAtpCzN4sTOy1RHpMpJj52zTO4S.jpg	t
3132	Paul Sorvino	\N	https://image.tmdb.org/t/p/w500/1gF0UskusEdDcNaBDJ2CMsz5Agi.jpg	t
3133	Frank Sivero	\N	https://image.tmdb.org/t/p/w500/eqvhj0iNtcsN6EJhd21Goqi1DSq.jpg	t
3134	Tony Darrow	\N	https://image.tmdb.org/t/p/w500/kc6cGKm2yYx5ekHo4zGizhMLBge.jpg	t
3135	Mike Starr	\N	https://image.tmdb.org/t/p/w500/hJGhV91dSUiFJ8GwGDTEEri79LX.jpg	t
3136	Frank Vincent	\N	https://image.tmdb.org/t/p/w500/fa1gikNsPKvX1roWUo2bBmixnvp.jpg	t
3137	Chuck Low	\N	https://image.tmdb.org/t/p/w500/zaw5Tyk2K6aawV13fQ4tSPdbEUp.jpg	t
3138	Leah Lewis	\N	https://image.tmdb.org/t/p/w500/4TTwg4Wrpe6qa1NrGKP508v2j3A.jpg	t
3139	Mamoudou Athie	\N	https://image.tmdb.org/t/p/w500/ycUbhfZRKC8MtNK9oMwscRsl3uM.jpg	t
3140	Ronnie del Carmen	\N	https://image.tmdb.org/t/p/w500/lPCmkQK76DOgkmcRjg9394QPyAu.jpg	t
3141	Shila Ommi	\N	https://image.tmdb.org/t/p/w500/i9m2RGrANNxidj0bVKlSs0zHPNX.jpg	t
3142	Wendi McLendon-Covey	\N	https://image.tmdb.org/t/p/w500/d8VKC8Ms3u9XiW4e4jsy2grP02d.jpg	t
3143	Mason Wertheimer	\N	https://image.tmdb.org/t/p/w500/vpjZTxItJMpkjFrls2kpVnJq1H.jpg	t
3144	Ronobir Lahiri	\N	https://image.tmdb.org/t/p/w500/uZQu5zBGxE62uGP7qaGhjQ79bn3.jpg	t
3145	Wilma Bonet	\N	https://image.tmdb.org/t/p/w500/2YC8C8FXWQZ4UXv3wAkWUtmqJLY.jpg	t
3146	Joe Pera	\N	https://image.tmdb.org/t/p/w500/lzf1mnclmHo4y53ZpvtlkWgFunZ.jpg	t
3147	Brendan Fraser	\N	https://image.tmdb.org/t/p/w500/tFj5PaWWQbb8rHBBhu1EHklznph.jpg	t
3148	Rachel Weisz	\N	https://image.tmdb.org/t/p/w500/msTqKPA33ryVtcVNgOdeaJGYq16.jpg	t
3149	John Hannah	\N	https://image.tmdb.org/t/p/w500/8GzJhaZrChZpv84SU4vAsvsR3cl.jpg	t
3150	Arnold Vosloo	\N	https://image.tmdb.org/t/p/w500/o23Z1EvWEYR7PArq2w5UpreVipV.jpg	t
3151	Patricia Velásquez	\N	https://image.tmdb.org/t/p/w500/zIrzY4BmpaWcRsPt5qpUIx6YSZ3.jpg	t
3152	עודד פהר	\N	https://image.tmdb.org/t/p/w500/gcYVN3vx8tHedEz2RbVNSKs44Wm.jpg	t
3153	Kevin J. O'Connor	\N	https://image.tmdb.org/t/p/w500/9ZO0QYkxjhThd8IVqSJw7gHyQ68.jpg	t
3154	Jonathan Hyde	\N	https://image.tmdb.org/t/p/w500/iNLNW7tH8GRpCP9INLXGmwVU1hK.jpg	t
3155	Erick Avari	\N	https://image.tmdb.org/t/p/w500/aO53uKgLUCID9rCI0SRAIEdsIex.jpg	t
3156	Stephen Dunham	\N	https://image.tmdb.org/t/p/w500/6kBBjxl4QzHxHXXjvMi6BVbfLsf.jpg	t
3157	FKA twigs	\N	https://image.tmdb.org/t/p/w500/8bUUu7jPEY1aQgAtJXM2NyYpfgN.jpg	t
3158	Josette Simon	\N	https://image.tmdb.org/t/p/w500/uLvLGR6a60To8AAlj0C5124d7Xu.jpg	t
3159	Laura Birn	\N	https://image.tmdb.org/t/p/w500/kB7v18ucUoN4PInN4jewcspWh3D.jpg	t
3160	Sami Bouajila	\N	https://image.tmdb.org/t/p/w500/xq8TMMCA4RI2omGxbPtLVsBMWX8.jpg	t
3161	Karel Dobrý	\N	https://image.tmdb.org/t/p/w500/mcvTqsqIPTVZiT4saALPljNUQ5B.jpg	t
3162	Jordan Bolger	\N	https://image.tmdb.org/t/p/w500/zGSxXrllgm3MNVT0jjvnAQFacPS.jpg	t
3163	Sebastian Orozco	\N	https://image.tmdb.org/t/p/w500/rLp1vVGxKlczXKns8dfjSlGDAIU.jpg	t
3164	David Bowles	\N	https://image.tmdb.org/t/p/w500/bJFHfEI7VxmfhHw7esTIS0QVeTK.jpg	t
3165	Christopher Masterson	\N	https://image.tmdb.org/t/p/w500/hOq2XG7QNtYphFcokFpJNPv4k4q.jpg	t
3166	David Cross	\N	https://image.tmdb.org/t/p/w500/dZyQ61KLra7JpkkoSeWIUvgEA1K.jpg	t
3167	Kathleen Robertson	\N	https://image.tmdb.org/t/p/w500/vtY0dPOu7gsxN2gVcTK0j0v76qc.jpg	t
3168	Tori Spelling	\N	https://image.tmdb.org/t/p/w500/xUPnjmmMcOdAHVhZL5b88MrJi7R.jpg	t
3169	Tim Curry	\N	https://image.tmdb.org/t/p/w500/lYVYVNsPDzeLL6ReCRhh8kezu4y.jpg	t
3170	Chris Elliott	\N	https://image.tmdb.org/t/p/w500/oZFGgyDCZaanGfco1UdfxM4rHAJ.jpg	t
3171	Ed Skrein	\N	https://image.tmdb.org/t/p/w500/btJvbQbWf3ciYM4SM5tMWSJEkXX.jpg	t
3172	Gina Carano	\N	https://image.tmdb.org/t/p/w500/6K89PVbt3v2N7cqbPyZiO74yuOj.jpg	t
3173	Stefan Kapičić	\N	https://image.tmdb.org/t/p/w500/6qHO7ckiyjLNOmW0v5RZj1MpLBj.jpg	t
3174	Randal Reeder	\N	https://image.tmdb.org/t/p/w500/eJfW7w36Vl8dEnN9T2dnlkUReWG.jpg	t
3175	Jayden Aguirre	\N	\N	t
3176	Preston Best	\N	\N	t
3177	Princess Love Norwood	\N	\N	t
3178	Lanett Tachel	\N	https://image.tmdb.org/t/p/w500/23Yx5uuBLeM0mNnDbBSAHOL2Qvd.jpg	t
3179	Marques Houston	\N	https://image.tmdb.org/t/p/w500/bjGs5VCjnTU8wPK87nTqMJatOcr.jpg	t
3180	Alijah Francis	\N	\N	t
3181	Eric Bana	\N	https://image.tmdb.org/t/p/w500/xIjQVywxkymHbbSO7lD2F9f377W.jpg	t
3182	Rose Byrne	\N	https://image.tmdb.org/t/p/w500/6YauDiiTBwRGC1xnwspPmNvPWUu.jpg	t
3183	Saffron Burrows	\N	https://image.tmdb.org/t/p/w500/2qMLZh9XWquBt7TZF9wmDiOtJdm.jpg	t
3184	Ella Bruccoleri	\N	https://image.tmdb.org/t/p/w500/xVqbUOELKqxhEdqAz5IXhFYp7Uy.jpg	t
3185	Rafaella Biscayn-Debest	\N	https://image.tmdb.org/t/p/w500/1M3PUG0kwBTPjSRhxBNCSroi3VT.jpg	t
3186	공유	\N	https://image.tmdb.org/t/p/w500/ocGoFb6TrK3uWGXt4WnuibUG1vD.jpg	t
3187	김수안	\N	https://image.tmdb.org/t/p/w500/hmPZhhoeUY89Rys6LrsjpTMeoEN.jpg	t
3188	정유미	\N	https://image.tmdb.org/t/p/w500/9QB7pIW08nDcSqXbVvGw40jRtmx.jpg	t
3189	안소희	\N	https://image.tmdb.org/t/p/w500/rgaNe82JFAO07pbqj2yHy0PF4gw.jpg	t
3190	김의성	\N	https://image.tmdb.org/t/p/w500/y7T2LJyorTK2NDk10yeTINWKrWR.jpg	t
3191	예수정	\N	https://image.tmdb.org/t/p/w500/rwGPhu8Ge36eMkrOlzfdKKFargw.jpg	t
3192	Park Myung-shin	\N	https://image.tmdb.org/t/p/w500/4VXJXafwdzVMugBeTtTHf6RtDKS.jpg	t
3193	최귀화	\N	https://image.tmdb.org/t/p/w500/aYiS6jQNNmOSfzcobDs12pLOOjj.jpg	t
3194	Taissa Farmiga	\N	https://image.tmdb.org/t/p/w500/kC2Movbs6uEF8DdDhvyHizQHuru.jpg	t
3195	Bonnie Aarons	\N	https://image.tmdb.org/t/p/w500/iEtWuoXKx4ZKbIWwJp1V76Heavy.jpg	t
3196	Jonas Bloquet	\N	https://image.tmdb.org/t/p/w500/ivbElHgLKv8PaVc2A9zIZSMSPcv.jpg	t
3197	Ingrid Bisu	\N	https://image.tmdb.org/t/p/w500/q7C8VKaQMOgilncOc2gf1oMGBKE.jpg	t
3198	Charlotte Hope	\N	https://image.tmdb.org/t/p/w500/ApsyxD8gK7TFYav2LRwE68D3YEE.jpg	t
3199	Sandra Teles	\N	https://image.tmdb.org/t/p/w500/hW911uY5D0HYxe8utGvwsISEovm.jpg	t
3200	Rocci Williams	\N	https://image.tmdb.org/t/p/w500/e5GWh54fUmbupb5DKsSNU5axEx2.jpg	t
3201	Jeffrey Donovan	\N	https://image.tmdb.org/t/p/w500/wlDXfXpu6Uz32LUmbFzU8QPDoQH.jpg	t
3202	Deobia Oparei	\N	https://image.tmdb.org/t/p/w500/kcw8vNMlYgK8peuN80zhX6TqeNk.jpg	t
3203	Patrick Stewart	\N	https://image.tmdb.org/t/p/w500/3yExCGqCMfSOVVHdEYTJhXaTtFZ.jpg	t
3204	Halle Berry	\N	https://image.tmdb.org/t/p/w500/9aLI0LSi7cbieyiskOdsBaneKmp.jpg	t
3205	Anna Paquin	\N	https://image.tmdb.org/t/p/w500/5FjBCsn3kujldP8LizoCrc3hsHp.jpg	t
3206	Rosalie Chiang	\N	https://image.tmdb.org/t/p/w500/cbEWkQM0FS9vzv07JFErCk0YKkx.jpg	t
3207	Ava Morse	\N	https://image.tmdb.org/t/p/w500/e3bkf5MHPzqvSrJALr78pp0DCWt.jpg	t
3208	Hyein Park	\N	https://image.tmdb.org/t/p/w500/dDGYpMSGoo18k2xj0ydaN1JHIMR.jpg	t
3209	Orion Lee	\N	https://image.tmdb.org/t/p/w500/jHz7papyoOAFvMql64cXQVQqKYu.jpg	t
3210	Wai Ching Ho	\N	https://image.tmdb.org/t/p/w500/v6TntYigep512F6QRyeOGJ4DKkp.jpg	t
3211	Tristan Allerick Chen	\N	https://image.tmdb.org/t/p/w500/4N9OueMmNA0uggxZ6ZqYoWqkto.jpg	t
3212	Roy Scheider	\N	https://image.tmdb.org/t/p/w500/y0MTwkCm5fIKjM1xH90tZbjAHql.jpg	t
3213	Robert Shaw	\N	https://image.tmdb.org/t/p/w500/bU4IJ4J1mgrriRTdQ4BOemoHvtt.jpg	t
3214	Richard Dreyfuss	\N	https://image.tmdb.org/t/p/w500/q2BPu6zWwFtnzQfpl4fgbKqURXM.jpg	t
3215	Lorraine Gary	\N	https://image.tmdb.org/t/p/w500/6JKNdZopypnFnD9xSSlDs6YTHMC.jpg	t
3216	Murray Hamilton	\N	https://image.tmdb.org/t/p/w500/kEAXyzRQ5POdciTjAUjRW4lIslj.jpg	t
3217	Carl Gottlieb	\N	https://image.tmdb.org/t/p/w500/tXsKWTANoQLwLyXTUteuDcDIc8b.jpg	t
3218	Jeffrey Kramer	\N	https://image.tmdb.org/t/p/w500/tLlMHQtZWhR3qHXBu1RR6NanERX.jpg	t
3219	Susan Backlinie	\N	https://image.tmdb.org/t/p/w500/A0WzKdjIf7MFxyV4adJE5vMRn5J.jpg	t
3220	Jonathan Filley	\N	https://image.tmdb.org/t/p/w500/jRNhR5pXpfe8Qj7rvfSZpVMgrja.jpg	t
3221	Ted Grossman	\N	https://image.tmdb.org/t/p/w500/2L7S57LmXg1EFwVOkI06JS5oAhM.jpg	t
3222	Matthew Goode	\N	https://image.tmdb.org/t/p/w500/3XaKKl0bKswTWbJ0Lh9nZ4UdAQo.jpg	t
3223	Rory Kinnear	\N	https://image.tmdb.org/t/p/w500/8aEABMeHXOozwE5DrMxUlCM9mpG.jpg	t
3224	Matthew Beard	\N	https://image.tmdb.org/t/p/w500/qbFEcaQLnE0bU8xutnsmYzKrjn0.jpg	t
3225	Mark Strong	\N	https://image.tmdb.org/t/p/w500/3cNmatYsoifytg7TfQhI1EHow3v.jpg	t
3226	James Northcote	\N	https://image.tmdb.org/t/p/w500/7eON5XLEGFseOWhSXDh7h5JsF9H.jpg	t
3227	Tom Goodman-Hill	\N	https://image.tmdb.org/t/p/w500/3LhuG5oJ1ZBIaKdHZBVC9LFF2jK.jpg	t
3228	Tom Hulce	\N	https://image.tmdb.org/t/p/w500/sQslzbyYZr4Qjv55VseLbbjpuMY.jpg	t
3229	Aidan Quinn	\N	https://image.tmdb.org/t/p/w500/viUuUmhiGdsfoQh0IpO5N312qNd.jpg	t
3230	Richard Briers	\N	https://image.tmdb.org/t/p/w500/gNsEDp8K7dRYVxYeHNgelOiOO97.jpg	t
3231	Robert Hardy	\N	https://image.tmdb.org/t/p/w500/5FK7rDWRsbNwAMsHHpkpeGafFtu.jpg	t
3232	Cherie Lunghi	\N	https://image.tmdb.org/t/p/w500/LoIGKqUw3d58MrVsLpw22goYCK.jpg	t
3233	Callina Liang	\N	https://image.tmdb.org/t/p/w500/yiajT9WAsvuxF9uNJrkSuzVv3On.jpg	t
3234	Chris Sullivan	\N	https://image.tmdb.org/t/p/w500/gKZ9xSFrDzUPv27iAkMpH6Qf0Sk.jpg	t
3235	Eddy Maday	\N	https://image.tmdb.org/t/p/w500/b1wNDkZvwmASphyBirqX2a5Wr0g.jpg	t
3236	West Mulholland	\N	https://image.tmdb.org/t/p/w500/xbEbJY1CgvJdFMTU6iS9pC8vWoa.jpg	t
3237	Lucas Papaelias	\N	https://image.tmdb.org/t/p/w500/6RPB3aTQRj9EiIzZjyGHe7zlOpC.jpg	t
3238	Natalie Woolams-Torres	\N	https://image.tmdb.org/t/p/w500/g4aXGV6jk5v2MXwL1g3Wtopmk5a.jpg	t
3239	Benny Elledge	\N	https://image.tmdb.org/t/p/w500/bj6zPOZkRZGCrBvgEpgI22t9NU5.jpg	t
3240	Daniel Danielson	\N	https://image.tmdb.org/t/p/w500/arzWakJZUFQiD743j1dlmyEp8V1.jpg	t
\.


--
-- TOC entry 5079 (class 0 OID 16422)
-- Dependencies: 224
-- Data for Name: calificaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calificaciones (calificacion_id, usuario_id, pelicula_id, puntuacion, fecha_calificacion) FROM stdin;
1	41	7	3	2025-10-26 17:08:31.330362
2	43	5	1	2025-10-26 20:24:30.279361
\.


--
-- TOC entry 5081 (class 0 OID 16447)
-- Dependencies: 226
-- Data for Name: comentarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comentarios (comentario_id, usuario_id, pelicula_id, texto_comentario, fecha_comentario) FROM stdin;
2	43	5	Por que tantas culpas?	2025-10-26 20:24:30.30087
1	41	7	Buena	2025-10-26 17:08:37.033605
\.


--
-- TOC entry 5084 (class 0 OID 16494)
-- Dependencies: 229
-- Data for Name: pelicula_actores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pelicula_actores (pelicula_id, actor_id) FROM stdin;
106	1
106	2
106	3
106	4
106	5
106	6
106	7
106	8
106	9
106	10
120	11
120	12
120	13
120	14
120	15
120	16
120	17
120	18
120	19
120	20
119	21
119	22
119	23
119	24
119	25
119	26
119	27
119	28
119	29
119	30
101	31
101	32
101	33
101	34
101	35
101	36
101	37
101	38
101	39
101	40
20	41
20	42
20	43
20	44
20	45
20	46
20	47
20	48
20	49
20	50
82	51
82	52
82	53
82	54
82	55
82	56
82	57
82	58
82	59
82	60
25	61
25	62
25	63
25	64
25	65
25	66
25	67
25	68
25	69
25	70
26	71
26	72
26	73
26	74
26	75
26	76
26	2
26	77
26	78
26	79
27	80
27	81
27	82
27	83
27	84
27	85
27	86
27	87
27	88
27	89
93	90
93	91
93	92
93	93
93	94
93	95
93	96
93	97
93	98
93	99
11	100
11	101
11	102
11	103
11	104
11	105
11	106
11	107
11	108
11	109
135	110
135	111
135	112
135	113
135	114
135	115
135	116
135	117
135	118
135	119
39	120
39	121
39	122
39	123
39	124
39	125
39	126
39	127
39	128
39	129
131	130
131	131
131	132
131	133
131	134
131	135
131	136
131	137
131	138
131	139
17	140
17	141
17	142
17	143
17	144
17	145
17	146
17	147
17	148
17	149
66	150
66	151
66	152
66	153
66	154
66	155
66	156
66	157
66	158
89	159
89	160
89	161
89	162
89	163
89	164
89	165
89	166
89	167
89	168
33	169
33	170
33	171
33	172
33	173
33	174
33	175
33	176
33	177
33	178
109	179
109	180
109	181
109	182
109	183
109	184
109	185
109	186
109	187
109	188
57	189
57	190
57	191
57	192
57	193
57	194
57	195
31	196
31	197
31	198
31	199
31	200
31	201
31	202
31	203
31	204
31	205
34	206
34	207
34	208
34	209
34	210
34	211
34	212
34	213
34	214
34	215
12	216
12	217
12	218
12	219
12	220
12	221
12	222
12	223
12	224
12	225
10	226
10	227
10	228
10	229
10	230
10	231
10	232
10	233
10	234
10	235
18	236
18	237
18	238
18	239
18	240
18	241
18	242
18	243
18	244
18	245
98	246
98	247
98	248
98	249
98	250
98	251
98	252
98	253
98	254
98	255
64	256
64	257
64	258
64	259
64	260
64	261
64	262
64	263
64	264
64	265
104	266
104	267
104	268
104	269
104	270
104	271
104	272
104	273
104	274
104	275
102	276
102	277
102	278
102	279
102	280
102	281
102	282
102	283
102	284
102	285
71	286
71	287
71	288
71	289
71	290
71	291
71	292
71	293
71	294
72	295
72	296
72	297
72	298
72	299
72	300
72	301
72	302
72	303
72	304
47	305
47	306
47	307
47	308
47	309
47	310
47	311
47	312
47	313
47	314
46	315
46	316
46	317
46	318
46	319
46	320
46	321
46	322
46	323
46	324
83	325
83	326
83	327
83	118
83	328
83	329
83	330
83	331
15	130
83	332
83	77
15	333
15	334
15	335
15	336
15	337
15	338
15	339
15	340
15	341
125	342
125	343
125	344
125	345
77	346
77	347
77	348
77	349
77	350
77	351
77	352
77	353
77	354
77	355
73	356
73	357
73	358
73	359
73	360
73	361
73	362
73	363
73	364
73	365
56	366
56	367
56	368
56	369
56	370
56	371
56	372
40	373
40	374
40	334
40	375
40	376
40	377
40	378
40	379
40	380
40	381
123	382
123	383
123	384
123	385
123	386
123	387
123	388
123	389
123	390
123	391
13	392
13	393
13	394
13	395
13	396
13	397
13	398
13	399
13	400
13	401
91	402
91	403
91	404
91	405
91	406
91	407
91	408
91	409
91	410
91	411
21	412
21	413
21	414
21	415
21	416
21	266
21	417
21	418
21	419
21	420
5	414
5	266
5	415
5	413
5	419
5	412
5	421
5	422
5	418
5	420
112	423
112	424
96	425
96	426
96	427
96	428
96	429
96	430
96	431
96	432
96	433
96	434
107	435
107	436
107	437
107	438
107	439
107	440
107	441
107	442
107	443
107	444
108	445
108	446
108	447
108	448
108	449
108	450
108	451
108	452
108	453
108	454
19	349
19	455
19	456
19	457
19	458
19	92
19	459
19	460
19	461
19	462
65	463
65	464
65	465
65	466
65	467
65	461
65	468
65	469
65	470
65	471
52	472
52	473
52	474
52	475
52	476
52	477
52	478
52	479
52	480
52	481
37	482
37	483
37	484
37	364
37	485
37	486
37	487
37	488
37	489
37	490
85	491
85	492
85	493
85	494
85	495
85	496
85	497
85	498
85	499
85	500
32	501
32	502
32	503
32	485
32	504
32	505
32	506
32	507
32	508
32	509
78	510
78	511
78	512
78	513
78	514
78	515
78	138
78	516
78	517
78	518
133	256
133	519
133	520
133	521
133	522
133	523
133	524
133	525
133	526
133	527
100	528
100	529
100	530
100	531
100	532
100	533
100	534
100	535
100	536
100	537
113	538
113	515
113	539
113	540
113	541
113	542
113	543
113	544
113	545
113	546
24	547
24	548
24	549
24	550
24	551
24	552
24	553
24	554
24	555
24	556
55	557
55	558
55	559
55	560
55	561
55	562
55	563
55	564
55	565
68	427
68	432
68	426
55	566
68	431
68	433
68	428
68	434
68	429
68	425
68	430
128	567
128	568
128	569
128	570
128	571
128	572
128	573
128	574
128	575
128	576
38	577
38	578
38	579
38	580
38	581
38	582
38	583
38	584
38	585
38	586
129	587
129	588
129	589
129	590
129	543
129	591
129	483
129	592
129	593
129	594
8	595
8	596
8	597
8	598
8	599
8	600
8	601
8	602
8	603
8	604
110	605
110	606
110	607
110	608
110	609
110	610
110	611
110	612
110	613
110	614
99	90
99	615
99	616
99	617
99	618
99	619
99	620
99	621
99	622
99	623
48	459
48	624
48	625
48	626
48	627
48	628
48	629
48	630
48	631
48	632
28	633
28	634
28	635
28	636
28	637
28	638
28	639
28	640
28	641
28	642
94	643
94	644
94	645
94	646
94	647
94	648
94	649
94	650
94	651
94	652
30	653
30	654
30	655
30	656
30	657
30	658
30	659
30	660
30	661
30	662
95	663
95	664
95	665
95	666
95	667
95	668
95	669
95	670
95	671
95	672
122	673
122	674
122	89
122	675
122	676
122	677
122	460
122	678
122	679
122	680
62	681
62	682
62	683
62	684
62	685
62	686
62	687
62	688
62	689
62	690
127	691
127	692
127	624
127	693
127	694
127	695
127	696
127	316
127	697
127	698
117	699
117	700
117	701
117	702
117	703
117	704
117	705
117	706
117	707
117	708
97	709
97	710
97	711
97	712
97	713
97	714
97	715
97	716
97	717
97	718
114	653
114	719
114	720
114	721
114	722
114	723
114	724
114	725
114	726
114	727
126	728
126	214
126	729
126	730
126	731
126	732
126	733
132	734
132	735
132	736
132	737
132	738
132	739
132	740
132	155
132	741
67	742
67	743
67	744
67	745
67	746
67	747
67	748
67	749
67	750
67	751
50	380
50	752
50	753
50	116
50	754
50	755
50	756
50	757
50	758
51	217
50	759
51	445
51	760
51	761
51	762
51	763
51	764
51	765
51	766
51	767
76	768
76	769
76	770
76	771
76	772
76	773
76	774
76	775
76	776
76	777
69	778
69	779
69	780
69	781
69	782
69	783
69	784
69	785
69	786
69	787
81	788
81	789
81	790
81	351
81	791
81	792
81	793
81	794
81	795
81	796
79	797
79	798
79	799
79	800
79	377
79	15
79	801
79	460
79	802
79	803
42	804
42	805
42	806
42	807
42	808
42	809
90	810
90	811
90	812
90	813
90	814
90	815
90	816
90	817
90	818
90	819
134	820
134	791
134	821
134	822
134	823
134	824
134	825
134	826
134	827
134	828
59	829
59	830
59	831
59	832
59	833
59	834
59	835
59	836
116	33
116	837
116	838
116	839
116	519
116	840
116	94
116	841
116	454
116	842
84	843
84	844
84	845
84	846
84	370
84	847
84	848
84	849
84	850
74	435
74	851
74	24
74	852
74	853
74	854
74	855
74	856
74	857
74	858
6	859
6	860
6	861
6	862
6	863
6	864
6	865
6	866
6	867
6	868
29	869
29	870
29	871
29	872
29	873
29	874
29	875
29	876
29	877
29	878
41	762
41	879
41	880
41	881
41	882
41	883
41	545
41	884
41	885
41	886
16	887
16	888
16	889
16	890
16	891
16	892
16	893
16	461
16	894
16	895
54	896
54	897
54	898
54	899
54	900
54	901
103	902
103	903
103	904
103	905
103	906
103	907
103	908
103	909
103	910
103	17
115	911
115	27
115	912
115	764
115	913
115	914
115	915
115	916
115	917
115	918
36	919
36	920
36	921
36	922
36	923
36	924
36	925
36	926
36	927
36	928
53	929
53	930
53	931
53	608
53	932
53	933
53	934
53	935
53	936
92	350
53	937
92	938
92	725
92	939
92	940
92	941
92	942
92	943
92	944
92	945
23	946
23	947
23	948
23	949
23	950
23	951
23	952
23	953
23	96
23	954
44	232
44	955
44	956
44	957
44	958
44	959
44	960
44	226
44	961
44	962
58	963
58	964
58	965
58	966
58	967
58	968
58	969
111	970
111	971
111	972
111	973
111	974
111	975
111	976
111	977
111	978
111	979
86	980
86	981
86	982
86	983
86	984
86	985
86	986
86	987
86	988
49	695
49	989
49	990
49	991
49	992
49	993
49	994
49	995
49	996
49	997
22	998
22	999
22	1000
22	1001
22	1002
22	1003
22	1004
22	1005
22	214
22	1006
70	1007
70	1008
70	1009
70	1010
70	1011
45	1012
45	1013
45	1014
45	1015
45	1016
45	1017
45	1018
45	1019
60	762
60	1020
60	1021
60	1022
60	1023
60	1024
60	1025
60	1026
60	1027
60	1028
105	1029
105	1030
105	838
105	1031
105	1032
105	1033
105	1034
105	1035
105	1036
105	1037
75	1038
75	1039
75	1040
75	1041
75	1042
75	1043
75	1044
75	1045
75	1046
75	1047
124	1048
124	1049
124	1050
124	1051
124	1052
124	1053
124	1054
43	1055
43	1056
43	1057
43	1058
43	1059
43	1060
43	1061
43	1062
43	1063
61	762
61	883
61	880
43	1064
61	879
61	1065
61	886
61	1066
61	882
61	1067
61	1068
87	1069
87	1070
87	1071
87	1072
87	1073
87	1074
87	1075
87	1076
87	1077
14	422
14	414
87	1078
14	416
14	415
14	413
14	417
14	412
14	1079
14	937
14	1080
121	1081
121	1082
121	1083
121	1084
121	1085
121	1086
121	1087
121	1088
121	1089
121	1090
63	1091
63	1092
63	1093
63	1094
63	1095
63	1096
63	1097
63	1098
63	1099
63	1100
9	1101
9	1102
9	1103
9	1104
9	1105
9	1106
9	1107
9	1108
9	1109
9	1110
118	1111
118	1112
118	1113
118	1114
118	1115
118	1116
118	1117
118	1118
118	1119
88	691
88	692
118	1120
88	695
88	693
88	694
88	1121
88	1122
88	597
88	1123
88	1124
130	1125
130	1126
130	1127
130	1128
130	1129
130	1130
130	1131
130	1132
130	1133
7	980
7	981
7	988
7	985
7	987
7	983
7	986
7	982
7	984
130	1134
136	1135
136	1136
136	1137
136	1138
136	1139
136	1140
136	1141
136	1142
136	1143
137	1144
137	1145
137	1146
137	167
137	1147
137	1148
137	1149
137	1150
137	1151
137	1152
138	1153
138	1154
138	1155
138	1156
138	1157
138	1158
138	1159
138	1160
138	1161
138	1162
139	125
139	1163
139	1164
139	1165
139	1166
139	1167
139	1168
139	1169
139	1170
139	1171
140	1172
140	1173
140	1174
140	1175
140	1176
140	1177
140	1178
140	1179
140	1180
140	1181
141	838
141	837
141	33
141	839
141	1182
141	841
141	1183
141	94
141	1184
141	1185
142	256
142	1186
142	1187
142	1188
142	1189
142	30
142	1190
142	1191
142	1192
142	1193
143	1194
143	1195
143	1196
143	1197
143	1198
143	485
143	1199
143	1200
143	1201
143	1202
144	1203
144	1204
144	1205
144	1206
144	1207
144	137
144	1208
144	1209
144	1210
144	1211
145	1212
145	1213
145	1214
145	1215
145	1216
145	1217
145	1218
145	1219
145	1220
145	1221
146	1222
146	297
146	1223
146	1224
146	1225
146	1226
146	1227
146	1228
146	1229
146	1230
147	1231
147	1232
147	1233
147	1234
147	1235
147	1236
147	1237
147	1238
147	1239
147	1240
148	1241
148	1242
148	1243
148	1244
148	1245
148	1246
148	1247
148	1248
148	1234
148	1249
149	1250
149	1251
149	1252
149	1253
149	1254
149	1255
149	1256
149	1257
150	1258
150	373
150	1259
150	1260
150	1261
150	1262
150	461
150	1263
150	1264
150	1265
151	1266
151	1267
151	1268
151	1269
151	1270
151	1271
152	1272
152	1273
152	379
152	1274
152	1111
152	1275
152	1276
152	1277
152	1278
152	1279
153	1280
153	1281
153	1282
154	760
154	1283
154	1284
154	1285
154	1286
154	1287
154	1288
154	1289
154	1290
154	1291
155	1292
155	1293
155	373
155	938
155	1294
155	1295
155	1296
155	1297
155	1298
155	1299
156	892
156	1300
156	1301
156	1302
156	1303
156	536
156	1304
156	779
156	1305
156	1306
157	1307
157	1308
158	1101
158	1102
158	1309
158	1310
158	1311
158	1312
158	1313
158	1108
158	856
158	1314
159	1315
159	1316
159	373
159	1317
159	1318
159	1319
159	1320
159	1321
159	1322
159	680
160	501
160	1182
160	1323
160	1258
160	1324
160	1325
160	1326
160	217
160	1327
160	11
161	1328
161	1329
161	1330
161	90
161	1331
161	1332
161	1333
161	1334
161	1335
161	721
162	1336
162	1337
162	1338
162	1339
162	1340
162	1341
162	1342
162	1343
162	1344
162	1345
163	1191
163	1346
163	1347
163	198
163	1348
163	1349
163	1350
163	1351
163	1352
163	1353
164	1302
164	1300
164	892
164	1301
164	1354
164	1306
164	1305
164	1355
164	1356
164	1357
165	528
165	1358
165	1359
165	71
165	1360
165	1361
165	1362
165	1363
165	1364
165	1365
166	1366
166	1367
166	1368
166	990
166	1369
166	1370
166	1371
166	887
166	1372
166	1373
167	1374
167	1375
167	1376
167	1322
167	1377
167	1378
167	1379
167	1380
167	1381
167	1382
168	1383
168	1384
168	1385
168	1386
168	1387
168	1388
168	1389
168	1390
168	1391
168	1392
169	1188
169	1393
169	1394
169	1395
169	1396
169	1397
169	1398
169	813
169	1399
169	1400
170	1401
170	1402
170	1403
170	1404
170	1405
170	1406
170	1407
170	1408
170	1000
170	1409
171	1410
171	1411
171	1412
171	1413
171	1414
171	1415
171	1416
171	1417
171	1418
171	1419
172	1420
172	1421
172	1422
172	1423
172	1424
172	1425
172	1426
172	1427
172	1428
172	1429
173	181
173	180
173	179
173	1430
173	184
173	185
173	183
173	182
173	1431
173	1432
175	1433
175	755
175	1434
175	1435
175	1436
175	1437
175	1438
175	1439
175	1440
175	1441
176	1124
176	71
176	528
176	1359
176	1442
176	1360
176	1362
176	1361
176	1443
176	1363
177	180
177	181
177	179
177	1444
177	1445
177	185
177	1446
177	184
177	1244
177	1447
178	226
178	227
178	230
178	235
178	234
178	228
178	1448
178	1449
178	1450
178	1451
179	1452
179	1453
179	1454
179	1455
179	1456
179	1457
179	1458
179	1459
179	1460
179	1461
180	852
180	1333
180	1462
180	1463
180	1464
180	886
180	1465
180	1466
180	1467
180	1468
181	1469
181	1470
181	1471
181	1472
181	1473
181	1474
181	1475
181	1476
181	1477
181	1478
182	30
182	1479
182	691
182	1480
182	587
182	853
182	1481
182	1430
182	1482
182	1483
183	455
183	1484
183	1485
183	1442
183	1486
183	1487
183	82
183	1488
183	569
183	1489
184	1490
184	1491
184	1492
184	858
184	1493
184	1494
184	1495
184	1496
184	1497
184	1498
185	1499
185	1500
185	1501
185	1502
185	1503
185	1504
185	1505
185	1506
185	1507
185	1508
186	1509
186	1510
186	1511
186	1512
186	1513
186	1514
186	1515
186	1516
186	1517
186	1518
187	1519
187	1520
187	1521
187	1522
187	1523
187	1524
187	1525
187	1526
187	1527
187	1528
188	1316
188	1315
188	1529
188	318
188	1318
188	373
188	1530
188	1531
188	1532
188	1533
189	1534
189	1535
189	1536
189	1537
189	1538
189	1539
189	1057
189	1540
189	1541
189	1542
190	1163
190	1543
190	1544
190	1545
190	1546
190	1547
190	1548
190	1549
190	1550
190	1551
191	11
191	374
191	1124
191	788
191	1552
191	624
191	1553
191	465
191	1554
191	1555
192	1556
192	1557
192	795
192	1558
192	1559
192	892
192	1560
192	1561
192	1562
192	1563
193	1564
193	1565
193	1566
193	1567
193	1568
193	1569
193	1570
193	1571
193	1572
193	1573
194	697
194	1574
194	316
194	1130
194	1575
194	1576
194	1577
194	1578
194	627
194	1579
195	799
195	12
195	1580
195	1581
195	1582
195	725
195	1583
195	1529
195	1584
195	1585
196	1586
196	1587
196	1588
196	1589
196	1590
196	1591
196	1592
196	1593
196	1594
196	1595
197	1243
197	1596
197	1597
197	1598
197	1599
197	1600
197	1572
197	1601
197	1212
197	1602
198	362
198	1603
198	1604
198	1605
198	1606
198	1607
198	1608
198	1609
198	1610
198	1611
199	1612
199	1613
199	959
199	1614
199	1615
199	1616
199	1617
199	1618
199	1619
199	1620
200	1621
200	1622
200	1623
200	1624
200	95
200	1625
200	1626
200	1627
200	1628
200	1629
201	1630
201	1631
201	1632
201	1633
201	1634
201	1635
201	1636
201	214
201	1637
201	1638
202	118
202	1639
202	1640
202	1641
202	1642
202	1643
202	1644
202	1645
202	1646
202	1647
203	903
203	692
203	1322
203	1648
203	484
203	1649
203	1319
203	1650
203	1651
203	1652
204	1428
204	1653
204	1654
204	1655
204	1656
204	1657
204	1658
204	1659
204	1660
204	1661
205	1662
205	1663
205	1664
205	1665
205	1666
205	1667
205	1668
205	1669
205	1670
205	1671
206	1596
206	1672
206	1673
206	1674
206	1675
206	1676
207	1677
207	1678
207	1679
207	1680
207	1681
207	1682
207	1683
207	1684
207	1685
207	1686
208	547
208	1687
208	1688
208	1689
208	1638
208	1690
208	1691
208	1692
208	1693
208	1694
209	1263
209	1695
209	1536
209	1696
209	1697
209	991
209	1698
209	404
209	1699
209	1700
210	1701
210	1702
210	1703
210	1704
210	1705
210	1706
210	1707
210	1708
210	1709
210	1710
211	179
211	180
211	1445
211	185
211	181
211	26
211	1711
211	184
211	1712
211	183
212	528
212	1713
212	1443
212	1358
212	725
212	1714
212	1396
212	1715
212	1716
212	187
213	1717
213	121
213	1718
213	211
213	1719
213	1720
213	1721
213	1722
213	1723
213	1724
214	1725
214	1726
214	1727
215	1258
215	111
215	373
215	1728
215	1729
215	1580
215	1730
215	1642
215	1731
215	1732
216	1733
216	1734
216	1735
216	1736
216	1737
216	1738
216	1739
216	1740
216	1741
216	1742
217	1743
217	1744
217	1745
217	1746
217	1747
217	1748
217	1749
217	1750
217	1751
217	1752
218	1743
218	1753
218	1754
218	1755
218	1756
218	1757
218	1758
218	1759
218	1760
218	1761
219	1762
219	1763
219	1422
219	1764
219	1765
219	1766
219	1767
219	1768
219	1769
219	1770
220	1771
220	1772
220	1773
220	1774
220	1775
220	1776
220	1777
220	1304
220	1778
220	1779
221	1780
221	1446
221	1781
221	1782
221	1783
221	1784
221	1785
221	1786
221	1787
221	1788
222	1789
222	1790
222	1791
222	1792
222	1793
222	1794
222	1795
222	1796
222	1797
222	1798
223	1799
223	1402
223	1800
223	1801
223	1802
223	1803
223	1804
223	1805
223	1806
223	1807
224	837
224	839
224	838
224	33
224	1808
224	840
224	1809
224	1810
224	1811
224	1812
225	697
225	1813
225	691
225	1814
225	1130
225	1574
225	1815
225	1575
225	1816
225	1817
226	805
226	938
226	1818
226	1819
226	1820
226	1821
226	1822
226	1823
226	1824
226	1825
227	1826
227	1827
227	1828
227	1829
227	1830
227	1831
227	1832
227	1833
227	1834
227	594
228	1196
228	1194
228	1195
228	1835
228	1200
228	356
228	1836
228	485
228	1837
228	1838
229	1462
229	1839
229	1840
229	1841
229	1842
229	1843
229	1167
229	1844
229	1845
229	1846
230	1847
230	1848
230	1849
230	1850
230	1851
230	1852
230	1853
230	1854
230	1855
231	256
231	435
231	111
231	1856
231	1857
231	1858
231	1130
231	1375
231	533
231	1859
232	529
232	463
232	1860
232	1861
232	752
232	87
232	1862
232	1863
232	1864
232	1865
233	1866
233	1867
233	1868
233	1869
233	1870
233	1871
233	1872
233	1873
233	1874
233	1875
234	1876
234	1877
234	1878
234	1879
234	1880
234	1881
234	1882
234	1883
234	1884
234	1885
235	1886
235	1887
235	1888
235	1889
235	1890
235	1891
235	1892
235	45
235	1893
235	1894
236	1895
236	1896
236	1897
236	1898
236	1899
236	1900
236	1901
236	1902
236	1903
236	1904
237	111
237	436
237	1905
237	1906
237	317
237	1907
237	1908
237	1909
237	1910
237	1911
238	1912
238	1913
238	1914
238	1915
238	1916
238	1917
238	1918
239	1374
239	1919
239	1920
239	1921
239	1922
239	1923
239	1924
239	1925
239	1926
239	1927
240	455
240	1420
240	692
240	1928
240	1929
240	1930
240	1931
240	1932
240	1933
240	1934
241	1273
241	1935
241	1936
241	1937
241	1938
241	1939
241	1940
241	1941
241	1942
241	1943
242	161
242	1425
242	1428
242	1424
242	1421
242	1422
242	1427
242	1420
242	1423
242	1944
243	1945
243	1946
243	1947
243	1948
244	1949
244	1112
244	1950
244	260
244	1951
244	1952
244	1953
244	1954
244	1955
244	1956
245	27
245	463
245	1815
245	1957
245	1958
245	1959
245	1960
245	1961
245	1962
245	1963
246	196
246	1964
246	1965
246	1966
246	1967
246	1968
246	1347
246	1969
246	1970
246	1971
247	1101
247	1102
247	1972
247	1973
247	1974
247	1975
247	1355
247	1976
247	1108
247	1977
248	87
248	1482
248	207
248	1978
248	1979
248	805
248	1980
248	1375
248	1981
248	1982
249	1983
249	92
249	1984
249	1396
249	1985
249	1986
249	1987
249	1988
249	1989
249	798
250	1990
250	1991
250	1992
250	1993
250	1994
250	1995
250	1996
250	1997
250	1998
250	1999
251	2000
251	2001
251	2002
251	2003
251	2004
252	624
252	374
252	465
252	1564
252	482
252	587
252	1574
252	1552
252	2005
252	2006
253	2007
253	2008
253	2009
253	2010
253	2011
253	2012
253	2013
253	2014
253	2015
253	2016
254	80
254	1029
254	2017
254	2018
254	2019
254	2020
254	2021
254	590
254	2022
254	2023
255	695
255	1815
255	691
255	696
255	797
255	597
255	2024
255	485
255	2025
255	2026
256	538
256	2027
256	2028
256	2029
256	2030
256	2031
256	2032
256	2033
256	2034
256	2035
257	706
257	2036
257	2037
257	2038
257	2039
257	703
257	2040
257	2041
257	2042
257	2043
258	2044
258	2045
258	2046
258	2047
258	2048
258	2049
258	2050
258	2051
258	2052
258	2053
259	2054
259	2055
259	2056
259	2057
259	2058
259	2059
259	2060
259	2061
259	2062
259	2063
260	2064
260	2065
260	2066
260	2067
260	2068
260	2069
260	2070
260	2071
260	2072
260	2073
261	2074
261	2075
261	2076
261	2077
261	2078
261	2079
261	1542
261	2080
261	2081
261	2082
262	2083
262	2084
262	2085
262	2086
262	2087
262	2088
262	2089
262	2090
262	2091
262	2092
263	2093
263	2094
263	2095
263	2096
263	2097
263	2098
263	2099
263	1598
263	2100
263	2101
264	1232
264	2102
264	2103
264	2104
264	2105
264	788
264	1907
264	2106
264	2107
264	2108
265	1826
265	503
265	2109
265	543
265	2110
265	2111
265	2112
265	2113
265	2114
265	2115
266	2116
266	2117
266	2118
266	2119
266	12
266	1262
266	2120
266	2121
266	214
266	2122
267	2123
267	2124
267	2125
267	2126
267	2127
267	2128
267	2129
267	2130
267	2131
267	2132
268	1446
268	1566
268	1827
268	110
268	2133
268	1354
268	2134
268	2135
268	1236
268	2136
269	2137
269	2138
269	2139
269	2140
269	2141
269	2142
269	2143
269	2144
269	2145
269	2146
270	2147
270	2148
270	2149
270	2150
270	2151
270	2152
270	2153
270	2154
270	2155
270	2156
271	2157
271	2158
271	2159
271	2160
271	2161
271	2162
271	2163
271	2164
271	932
271	2165
272	463
272	2166
272	1375
272	542
272	2167
272	2168
272	2169
272	2170
272	2171
272	1432
273	838
273	2172
273	2173
273	2174
273	1303
273	2175
273	2176
273	2177
273	2178
274	2179
274	2180
274	2181
274	2182
274	2183
274	2184
274	2185
274	2186
274	2187
274	2188
275	2189
275	2190
275	2191
275	2192
275	2193
275	2194
275	2195
275	2196
275	2197
275	2198
276	1232
276	2105
276	2102
276	989
276	2103
276	2199
276	2104
276	1566
276	2200
276	2201
277	938
277	2202
277	945
277	725
277	764
277	1462
277	805
277	2203
277	2204
277	196
278	2205
278	2206
278	1544
278	2207
278	2208
278	2209
278	2210
278	2211
278	2212
278	2213
279	528
279	2214
279	2215
279	2216
279	2217
279	2218
279	2219
279	2220
279	2221
279	2222
280	179
280	1442
280	1244
280	184
280	181
280	1431
280	180
280	529
280	1395
280	2223
281	2224
281	2225
281	2226
281	2227
281	2228
281	2229
281	2230
282	2231
282	2232
282	2233
282	2234
282	2235
282	2236
282	2237
282	2238
282	2239
282	2240
283	851
283	2241
283	2242
283	2243
283	2244
283	2245
283	2246
283	2247
283	2248
283	2249
284	2250
284	2251
284	2252
284	2253
284	2254
284	2255
284	2212
284	1545
284	2256
284	2257
285	2258
285	2259
285	2260
285	2261
285	2262
285	2263
285	2264
285	2265
285	214
285	2266
286	181
286	180
286	179
286	26
286	1445
286	2267
286	185
286	184
286	1244
286	529
287	1743
287	1319
287	2268
287	2265
287	2269
287	2270
287	2271
287	2272
287	797
287	2273
288	1354
288	892
288	1301
288	1300
288	1302
288	525
288	2274
288	1359
288	1306
288	1357
289	2275
289	2276
289	2277
289	2278
289	2279
289	2280
289	2281
289	2282
289	2283
289	2284
290	1358
290	528
290	1362
290	1443
290	1361
290	1360
290	1363
290	1359
290	1442
290	71
291	1896
291	1692
291	1711
291	93
291	1753
291	2285
291	357
291	2286
291	2287
291	2288
292	2289
292	2290
292	2291
292	2292
292	2293
292	2294
292	2295
292	2296
292	2297
292	2298
293	1488
293	1772
293	2299
293	2300
293	2301
293	2302
293	2303
293	2304
293	2305
293	2306
294	1303
294	2307
294	2308
294	2309
294	2310
294	2311
294	34
294	2312
294	2313
294	2314
295	2235
295	2315
295	2103
295	2316
295	2317
295	17
295	2318
295	2319
295	2320
295	2321
296	1300
296	2322
296	2323
296	1359
296	2324
296	2325
296	316
296	2326
296	2327
296	2328
297	1491
297	2329
297	596
297	2330
297	2331
297	2332
297	2333
297	1474
297	2334
297	2335
298	390
298	384
298	388
298	385
298	391
298	382
298	386
298	383
298	389
298	2336
299	2337
299	2338
299	2339
299	2340
299	2341
299	2342
299	2343
299	2344
299	2345
299	2346
300	2347
300	485
300	2348
300	2349
300	82
300	2350
300	2351
300	2352
300	2353
300	2354
301	2355
301	2356
301	2357
301	2358
301	2359
301	2360
301	2361
301	2362
301	2363
301	2364
302	2365
302	2366
302	2367
302	2368
302	2369
302	2370
302	2371
302	2372
302	2373
302	2374
303	1101
303	1102
303	2375
303	2376
303	2377
303	2378
303	2379
303	2223
303	1976
303	2380
304	1490
304	1491
304	1492
304	2381
304	2382
304	2383
304	2020
304	2384
304	2385
304	800
305	2386
305	2387
305	2388
305	2306
305	2029
305	2389
305	2390
305	2391
305	2392
305	2393
306	1346
306	2394
306	2395
306	2396
306	2397
306	2398
306	2399
306	2400
306	2401
306	2402
307	356
307	362
307	357
307	1685
307	2403
307	361
307	360
307	2404
307	2405
307	2406
308	463
308	2407
308	791
308	2408
308	2409
308	348
308	2410
308	2411
308	2412
308	2413
309	2414
309	2415
309	2416
309	2417
309	2418
309	2419
309	2420
309	2421
309	2422
309	2423
310	2424
310	2425
310	2426
310	2427
310	2428
310	2429
310	2430
310	2431
310	2432
310	2433
311	2434
311	1577
311	2435
311	2436
311	2437
311	2438
311	1322
311	2439
311	2440
311	2441
312	693
312	1030
312	2442
312	2443
312	2444
312	2445
312	2446
312	2447
312	2448
312	2449
313	2450
313	2451
313	2452
313	2453
313	2454
313	2313
313	2455
313	2456
313	2457
313	555
314	1600
314	2458
314	357
314	182
314	2459
314	2460
314	2461
314	2462
314	2463
314	492
315	2458
315	1733
315	2464
315	455
315	2465
315	2466
315	2467
315	1425
315	2468
315	2469
316	1491
316	1490
316	2384
316	2383
316	2381
316	1492
316	720
316	2470
316	2471
316	2472
317	2473
317	2474
317	2475
317	2476
317	2477
317	1084
317	1748
317	2478
317	2479
317	2480
318	2481
318	2482
318	2483
318	2484
318	2485
318	2486
318	2487
318	2488
318	2489
318	2490
319	863
319	860
319	864
319	859
319	862
319	866
319	2491
319	2492
319	868
319	867
320	2493
320	2494
320	2495
320	2496
320	2497
320	2498
320	2499
320	2500
320	2501
320	2502
321	2503
321	2504
321	2505
321	2506
321	2507
321	2508
321	2509
321	2510
321	2511
321	2512
322	2235
322	2513
322	1990
322	1783
322	2514
322	2515
322	2516
322	2517
322	2518
322	2519
323	1030
323	2520
323	1874
323	2521
323	12
323	550
323	2522
323	2523
323	2524
323	2525
324	457
324	357
324	1826
324	1597
324	2526
324	455
324	2460
324	2527
324	2126
324	2528
325	2529
325	1799
325	2530
325	2531
325	2532
325	2533
325	2534
325	2535
325	2536
325	2537
326	2538
326	2539
326	2540
326	2541
326	2542
326	226
326	2543
326	2544
326	2545
326	2546
327	2547
327	2548
327	2549
327	2550
327	2551
327	2552
328	2553
328	1732
328	2554
328	2555
328	2556
328	2557
328	2558
328	2559
328	2560
328	2561
329	2562
329	2563
329	2564
330	851
330	26
330	24
330	1192
330	21
330	27
330	1188
330	1186
330	2565
330	2566
331	2231
331	2567
331	1124
331	2568
331	2569
331	2570
331	529
331	2460
331	2571
331	2572
332	1639
332	1580
332	1126
332	2573
332	2574
332	2133
332	2112
332	2575
332	2576
332	2577
333	1445
333	183
333	179
333	181
333	180
333	184
333	1334
333	2578
333	2579
333	2580
334	705
334	699
334	2581
334	1463
334	704
334	2582
334	2583
334	2584
334	2585
334	2586
335	2587
335	2588
335	2589
335	2590
335	1617
335	2591
335	2592
335	2593
335	2594
335	2595
336	2596
336	2597
336	2598
336	2599
336	2600
336	2601
336	131
336	2602
336	2603
336	2604
337	2223
337	1462
337	1243
337	208
337	1577
337	2605
337	458
337	1127
337	2606
337	2607
338	755
338	1815
338	2574
338	691
338	2608
338	2609
338	2610
338	597
338	2611
338	2612
339	90
339	2613
339	2614
339	2615
339	2616
339	2617
339	2618
339	2619
339	2620
339	2621
340	2622
340	2623
340	2624
340	2625
340	2626
340	2627
341	2628
341	2629
341	2630
341	2631
341	2632
341	2633
341	2634
341	2635
341	2636
341	2637
342	350
342	1753
342	482
342	1905
342	1772
342	2638
342	752
342	2639
342	2640
342	2641
343	2642
343	1498
343	2643
343	951
343	2036
343	2644
343	316
343	2645
343	2646
343	2647
344	2648
344	837
344	2649
344	2650
344	1819
344	2651
344	2652
344	2653
344	355
344	2654
345	2435
345	2434
345	2436
345	2655
345	855
345	2438
345	2656
345	1322
345	2265
345	2657
346	1815
346	72
346	691
346	2315
346	696
346	1130
346	2658
346	2659
346	2660
346	2661
347	2662
347	2663
347	2664
347	2665
347	2666
347	2667
347	2668
347	2669
347	2670
347	2671
348	2672
348	2673
348	2674
348	2675
348	2676
348	2677
348	2678
348	2679
348	2680
348	2681
349	1665
349	1663
349	1662
349	2682
349	2683
349	2684
349	2685
349	2686
349	2687
349	1664
350	2688
350	2689
350	328
350	2690
350	2691
350	2692
350	2693
350	951
350	2694
350	2695
351	179
351	181
351	1445
351	1244
351	184
351	180
351	529
351	2696
351	1638
351	2697
352	2698
352	529
352	184
352	2528
352	1604
352	851
352	528
352	1712
352	2699
352	1438
353	1102
353	2018
353	519
353	2700
353	2701
353	2702
353	2703
353	2704
353	2705
353	2706
354	2707
354	2708
354	1358
354	2709
354	1577
354	34
354	2710
354	2711
354	1262
354	2712
355	1112
355	1951
355	2713
355	2714
355	2715
355	1956
355	2716
355	2416
355	2717
355	2718
356	694
356	1121
356	692
356	696
356	624
356	693
356	695
356	691
356	2719
356	316
357	2720
357	2721
357	2722
357	2723
357	2724
357	2725
357	2726
357	2727
357	2728
357	2729
358	1743
358	2730
358	2731
358	2732
358	2733
358	2734
358	2735
358	569
358	2736
358	2737
359	2738
359	2739
359	95
359	2740
359	2741
359	2742
359	2743
359	2744
359	2745
359	2746
360	2747
360	1979
360	706
360	2648
360	2748
360	2749
360	2750
360	2751
360	2752
360	2753
361	2520
361	33
361	482
361	85
361	501
361	2688
361	2754
361	2755
361	6
361	551
362	1592
362	2756
362	2757
362	2758
362	2759
362	2760
362	2761
362	2762
362	2763
362	2764
363	1244
363	90
363	2658
363	2765
363	2766
363	1384
363	2767
363	2768
363	2769
363	2770
364	2771
364	2772
364	2773
364	2774
364	2775
364	2776
364	2777
364	2778
364	2779
364	2780
365	2781
365	2782
365	2783
365	2784
365	2785
365	2786
365	2787
365	2788
365	2789
365	2790
366	2791
366	1813
366	2792
366	2793
366	1309
366	931
366	2794
366	2427
366	2795
366	2796
367	2797
367	2798
367	2799
367	1297
367	2800
367	2801
367	2802
367	2803
367	2804
367	2805
368	21
368	24
368	90
368	2806
368	30
368	26
368	2807
368	2808
368	1187
368	2809
369	2190
369	2810
369	379
369	2811
369	2812
369	1361
369	2813
369	2195
369	2658
369	2814
370	2348
370	2241
370	2469
370	2815
370	2816
370	2817
370	2812
370	2818
370	2699
370	2819
371	990
371	1367
371	1366
371	1371
371	887
371	1369
371	1368
371	1370
371	2820
371	1025
372	2821
372	2822
372	2823
372	2824
372	2693
372	34
372	2825
372	2826
372	2827
372	2828
373	2829
373	2830
373	2831
373	2832
373	2833
373	2642
373	2647
373	2643
373	1498
373	2120
374	2834
374	2835
374	2836
374	2837
374	2838
374	2839
374	2840
374	2841
374	2842
374	2843
375	2844
375	2845
375	2846
375	2847
375	2848
376	1435
376	526
376	755
376	2849
376	2850
376	2851
376	2852
376	2853
376	2854
376	2855
377	2856
377	2857
377	760
377	2858
377	2859
377	27
377	2860
377	1906
377	1919
377	694
378	2861
378	2862
378	2863
378	2046
378	2864
378	2865
378	2866
378	2867
378	2868
378	2869
379	2870
379	2871
379	2872
379	2873
379	2874
379	2875
379	2876
380	2520
380	2877
380	1322
380	2878
380	2879
380	2880
380	2881
380	2882
380	2883
380	2884
381	208
381	485
381	82
381	2520
381	77
381	2138
381	2820
381	1697
381	2885
381	2886
382	2887
382	2793
382	1600
382	2888
382	2889
382	2584
382	805
382	2890
382	2891
382	2892
383	2893
383	2894
383	2895
383	2896
383	2897
383	2898
383	2899
383	2900
383	2901
383	2902
384	692
384	691
384	695
384	1121
384	693
384	694
384	485
384	1243
384	696
384	2903
385	2904
385	402
385	2905
385	2906
385	185
385	2907
385	2908
385	2909
385	2910
385	2911
386	2202
386	501
386	2912
386	2913
386	485
386	2914
386	595
386	2915
386	2916
386	970
387	2917
387	2918
387	2919
387	2920
387	2921
387	2922
387	2923
387	2924
387	2925
387	2926
388	801
388	2458
388	1993
388	2927
388	2928
388	2929
388	2930
388	2931
388	2932
388	2933
389	1577
389	1733
389	694
389	1599
389	2934
389	2935
389	654
389	2936
389	2937
389	2938
390	1055
390	2939
390	2940
390	2941
390	2942
390	2943
390	2944
390	2945
390	2946
390	2947
391	1292
391	2948
391	2949
391	2950
391	2951
391	2952
391	2953
391	2954
391	2955
391	1959
392	2028
392	2956
392	2957
392	2857
392	2958
392	2959
392	2960
392	1827
392	2961
392	2962
393	2963
393	2964
393	1238
393	2965
393	2478
393	1748
393	2966
393	2967
393	2968
393	2969
394	2970
394	2034
394	2971
394	2972
394	2973
394	2974
394	2975
394	2976
394	2977
394	2978
395	2648
395	1733
395	1576
395	2979
395	2980
395	1755
395	2098
395	2981
395	1384
395	2982
396	2983
396	2984
396	879
396	2985
396	2986
396	2987
396	2988
396	2989
396	2990
396	2991
397	1188
397	2992
397	2993
397	2244
397	2994
397	1317
397	1397
397	2995
397	2857
397	2996
398	2997
398	2998
398	2999
398	3000
398	3001
398	3002
398	3003
398	3004
398	3005
398	3006
399	256
399	2658
399	694
399	3007
399	2992
399	3008
399	7
399	2704
399	3009
399	3010
400	3011
400	3012
400	3013
400	3014
400	3015
400	3016
400	3017
400	3018
400	3019
400	3020
401	1990
401	3021
401	3022
401	3023
401	3024
401	3025
401	3026
401	3027
401	3028
401	3029
402	6
402	3030
402	1485
402	3031
402	3032
402	3033
402	3034
402	3035
402	3036
402	3037
403	3038
403	3039
403	3040
403	3041
403	3042
403	3043
403	3044
403	3045
403	3046
404	1990
404	938
404	3047
404	3048
404	3049
404	357
404	1194
404	3050
404	3051
404	3052
405	3053
405	3054
405	3055
405	3056
405	3057
405	3058
405	3059
405	3060
405	3061
405	3062
406	3063
406	261
406	3064
406	3065
406	3066
406	3067
406	3068
406	3069
406	3070
406	3071
407	3072
407	3073
407	232
407	3074
407	3075
407	3076
407	3077
407	3078
408	3079
408	3080
408	3081
408	3082
408	3083
408	3084
408	3085
408	3086
408	3087
408	3088
409	1395
409	2118
409	1733
409	2648
409	3089
409	1755
409	3090
409	2982
409	1384
409	3091
410	86
410	80
410	84
410	2929
410	349
410	83
410	85
410	82
410	81
410	374
411	3092
411	3093
411	3094
411	1591
411	1592
411	3095
411	1594
411	3096
411	3097
411	3098
412	855
412	547
412	2093
412	3099
412	3100
412	3101
412	3102
412	3103
412	3104
412	3105
413	2242
413	2646
413	3106
413	3107
413	3108
413	948
413	3109
413	3110
413	3111
413	3112
414	1764
414	1374
414	1896
414	1195
414	2029
414	2856
414	2887
414	805
414	2584
414	2888
415	1368
415	1402
415	1583
415	1529
415	1486
415	1317
415	3113
415	3114
415	3115
415	320
416	1292
416	3116
416	2703
416	3117
416	3118
416	3119
416	2098
416	3120
416	3121
416	3122
417	318
417	3123
417	2476
417	3124
417	135
417	3125
417	3126
417	550
417	3127
417	3128
418	1993
418	3129
418	3130
418	3131
418	3132
418	3133
418	3134
418	3135
418	3136
418	3137
419	3138
419	3139
419	3140
419	3141
419	569
419	3142
419	3143
419	3144
419	3145
419	3146
420	3147
420	3148
420	3149
420	3150
420	3151
420	3152
420	3153
420	3154
420	3155
420	3156
421	1462
421	93
421	3157
421	3158
421	3159
421	3160
421	3161
421	3162
421	3163
421	3164
422	1112
422	1951
422	260
422	1949
422	3165
422	3166
422	3167
422	3168
422	3169
422	3170
423	1131
423	1125
423	2261
423	3171
423	1653
423	1133
423	3172
423	3173
423	2108
423	3174
424	3175
424	3176
424	1120
424	3177
424	3178
424	3179
424	3180
425	463
425	1359
425	3013
425	1444
425	3181
425	779
425	2410
425	2311
425	3182
425	3183
426	334
426	333
426	335
426	130
426	3184
426	336
426	337
426	3185
426	340
426	338
427	3186
427	3187
427	1889
427	41
427	3188
427	3189
427	3190
427	3191
427	3192
427	3193
428	881
428	3194
428	3195
428	3196
428	3197
428	1101
428	1310
428	1102
428	3198
428	3199
429	87
429	538
429	1481
429	3200
429	217
429	3201
429	1471
429	1057
429	1185
429	3202
430	1333
430	1126
430	2409
430	2956
430	3203
430	1300
430	208
430	3204
430	1189
430	3205
431	678
431	3206
431	3207
431	1000
431	3208
431	3209
431	3210
431	1585
431	3211
431	1583
432	3212
432	3213
432	3214
432	3215
432	3216
432	3217
432	3218
432	3219
432	3220
432	3221
433	316
433	71
433	3222
433	2100
433	3223
433	792
433	3224
433	3225
433	3226
433	3227
434	1993
434	1430
434	3228
434	529
434	1303
434	3229
434	3230
434	2384
434	3231
434	3232
435	1648
435	3233
435	3234
435	3235
435	1113
435	3236
435	3237
435	3238
435	3239
435	3240
\.


--
-- TOC entry 5075 (class 0 OID 16390)
-- Dependencies: 220
-- Data for Name: peliculas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.peliculas (pelicula_id, titulo, genero, anio_estreno, director, descripcion, fecha_creacion, portada_url, esta_activo) FROM stdin;
16	The Toxic Avenger Unrated	Acción, Comedia, Ciencia ficción	2025	Macon Blair	Cuando un conserje oprimido, Winston Gooze, sufre un catastrófico accidente tóxico, se transforma en un nuevo tipo de héroe: el Vengador Tóxico. Ahora, Toxie debe pasar de ser un paria a ser un salvador, enfrentándose a despiadados capos corporativos y fuerzas corruptas que amenazan a su hijo, sus amigos y su comunidad.	2025-10-21 05:21:09.776107	https://image.tmdb.org/t/p/w500/kHrWK8OPsmrUkdrOeY1LOUxrbmS.jpg	t
6	Furioza 2	Acción, Crimen, Suspense	2025	Cyprian T. Olencki	A resultas de un asesinato, el nuevo líder de Furioza, Golden, reclama el poder de su violenta banda de ultras y adopta un nuevo enfoque para actuar en el extranjero.	2025-10-21 05:21:08.780299	https://image.tmdb.org/t/p/w500/3f98fpG9s666xLcxX4rL0KRWRiE.jpg	t
7	Captain Hook - The Cursed Tides	Aventura, Acción, Terror	2025	Lars Janssen	\N	2025-10-21 05:21:08.872583	https://image.tmdb.org/t/p/w500/7SHFZKfd270y47sXN2WsURUO3ml.jpg	t
8	La guerra de los mundos	Ciencia ficción, Suspense	2025	Rich Lee	Will Radford, un destacado analista de ciberseguridad, pasa sus días rastreando posibles amenazas a la seguridad nacional a través de un programa de vigilancia masiva. Un ataque de una entidad desconocida le lleva a cuestionarse si el gobierno le está ocultando algo a él... y al resto del mundo.	2025-10-21 05:21:08.966207	https://image.tmdb.org/t/p/w500/fjgSlNGECNgVeMJaOdDAXmGh7ZM.jpg	t
9	Expediente Warren: El último rito	Terror	2025	Michael Chaves	Los investigadores de lo paranormal Ed y Lorraine Warren se enfrentan a un último caso aterrador en el que están implicadas entidades misteriosas a las que deben enfrentarse.	2025-10-21 05:21:09.063684	https://image.tmdb.org/t/p/w500/qdoqogLNR6myoRrxYFxF4UTkFne.jpg	t
10	Guardianes de la noche: Kimetsu no Yaiba La fortaleza infinita	Animación, Acción, Fantasía, Suspense	2025	Haruo Sotozaki	El Cuerpo de Cazadores de Demonios se enfrenta a los Doce Kizuki restantes antes de enfrentarse a Muzan en el Castillo del Infinito para derrotarlo de una vez por todas.	2025-10-21 05:21:09.171593	https://image.tmdb.org/t/p/w500/jl7e0hLYwIDsMlEQ28Gh30DoJRy.jpg	t
11	Martin	Acción, Drama, Suspense	2024	A. P. Arjun	El viaje de un hombre que se descubre a sí mismo, encuentra el amor y lucha por su patria. ¿Podrá mantener el fuerte en las tres puertas?	2025-10-21 05:21:09.283203	https://image.tmdb.org/t/p/w500/rmCJCFrEwPC0u0Y1smihwDo4Cf1.jpg	t
12	Sin rastro	Suspense, Acción, Aventura	2025	James Kent	El mundo de una madre decidida, Mara, se viene abajo cuando su ex marido, Karim, secuestra a su hija pequeña, Amina, y huye a Oriente Medio. Desesperada por traer a su hija a casa, Mara forma equipo con Robeson, un enigmático ex marine y especialista en secuestros de niños. Su misión les lleva a Beirut, donde se ven envueltos en una traicionera red de espionaje internacional, traición y corrupción. Cuando el tiempo se agota, Mara se enfrenta a la decisión más difícil de su vida: recuperar a su hija o dejarla atrás por su propia seguridad.	2025-10-21 05:21:09.393393	https://image.tmdb.org/t/p/w500/fFKcNfjOUbfaC8hPuiMxJ8PAudy.jpg	t
13	War 2	Acción, Aventura, Suspense	2025	Ayan Mukerji	Desde las sombras más densas, la India desata a su arma más letal: el superagente Vikram. Un oficial de las Unidades Especiales, imparable, indestructible, implacable. Cuando entra en escena, el peligro es inevitable. Un Terminator atormentado por sus propios demonios, con un único propósito: volarle la cabeza a Kabir. Dos titanes. Un destino. Una persecución sin límites. El mundo entero se convierte en su sangriento y despiadado campo de batalla. En su camino, decisiones imposibles, donde cada elección tiene un precio muy alto. Esta no es solo una guerra. Es una explosión de acción brutal y emociones que desgarran el alma	2025-10-21 05:21:09.489194	https://image.tmdb.org/t/p/w500/j8Gl3S4L7LE8GIF1J1phZ2Cbo72.jpg	t
14	Culpa mía	Drama, Romance, Suspense	2023	Domingo González	Noah debe dejar su ciudad, novio y amigos para mudarse a la mansión de William Leister, el flamante y rico marido de su madre Rafaela. Por otro lado, con 17 años, orgullosa e independiente, Noah se resiste a vivir en una mansión rodeada de lujo. Allí conoce a Nick, su nuevo hermanastro, y el choque de sus fuertes personalidades se hace evidente desde el primer momento.	2025-10-21 05:21:09.582756	https://image.tmdb.org/t/p/w500/gp31EwMH5D2bftOjscwkgTmoLAB.jpg	t
15	Strangers: Capítulo 2	Terror, Suspense	2025	Renny Harlin	De camino a su luna de miel, el vehículo de una pareja se avería, obligándoles a refugiarse en un remoto Airbnb. Al caer la noche, tres desconocidos enmascarados los aterrorizan hasta el amanecer.	2025-10-21 05:21:09.678098	https://image.tmdb.org/t/p/w500/fSRRH7UasrE6q240H00dww3vE1c.jpg	t
17	La princesa perdida	Acción, Aventura	2025	Hicham Hajji	Alec Touati es un multimillonario americano que se embarca en un viaje transformador para descubrir sus raíces. A través de una visión de ayahuasca, Alec es transportado a una sangrienta batalla y se encuentra en un castillo encantado de Marruecos. Allí conoce a Hanna, que le cuenta la trágica historia del matrimonio forzado con un príncipe saudí y su relación amorosa secreta con el cuidador del castillo. A medida que el embarazo de la princesa se hace más evidente, la historia de amor de la pareja se enfrenta a peligrosas consecuencias.	2025-10-21 05:21:09.874265	https://image.tmdb.org/t/p/w500/xXie22VAqXHMYBDTM2XpWRJWZIn.jpg	t
18	Marco	Acción, Crimen, Suspense	2024	Haneef Adeni	El hijo adoptivo de la familia Adattu, Marco, se embarca en una despiadada búsqueda de venganza después de que su hermano es brutalmente asesinado, encontrando solo traición, pérdida y una brutalidad inimaginable a cada paso.	2025-10-21 05:21:09.96889	https://image.tmdb.org/t/p/w500/6Nj8Y1A9lcReqZZvRHOSiO3iTl6.jpg	t
19	Los Cuatro Fantásticos: Primeros pasos	Ciencia ficción, Aventura	2025	Matt Shakman	Con un mundo retrofuturista inspirado en los años 60 como telón de fondo, la Primera Familia de Marvel deberá hacer frente a su mayor desafío hasta la fecha. Obligados a buscar el equilibrio entre su papel de héroes y sus fuertes vínculos familiares, tendrán que defender la Tierra de un hambriento dios espacial llamado Galactus y su intrigante heraldo, Estela Plateada.	2025-10-21 05:21:10.07537	https://image.tmdb.org/t/p/w500/ckfiXWGEMWrUP53cc6QyHijLlhl.jpg	t
20	Noche de paz: Cazadores de demonios	Acción, Fantasía, Terror, Suspense	2025	Lim Dae-hee	Un equipo de varias personas lucha contra espíritus malignos.	2025-10-21 05:21:10.166888	https://image.tmdb.org/t/p/w500/7MGnHpfhF8savUsrUJoI8Q7dTk9.jpg	t
21	Culpa tuya	Drama, Romance	2024	Domingo González	El amor entre Noah y Nick parece inquebrantable, a pesar de las maniobras de sus padres por separarles. Pero el trabajo de él y la entrada de ella en la universidad, abre sus vidas a nuevas relaciones. La aparición de una exnovia que busca venganza y de la madre Nick con intenciones poco claras, removerán los cimientos no solo de su relación, sino de la propia familia Leister. Cuando tantas personas están dispuestas a destruir una relación, ¿puede realmente acabar bien?	2025-10-21 05:21:10.264203	https://image.tmdb.org/t/p/w500/1jvCVdlgInyItAUEvvvCakm1Yxz.jpg	t
22	Los Cretinos	Animación, Comedia, Familia, Fantasía	2025	Phil Johnston	Cuando los villanos más malos y repugnantes se apoderan de la ciudad con un truquito, dos niños valientes se alían con una familia de animales mágicos para acabar con ellos.	2025-10-21 05:21:10.365426	https://image.tmdb.org/t/p/w500/izYZGeOHhPWiga8Hb5P4JYfcH8T.jpg	t
23	Las guerreras k-pop	Fantasía, Música, Comedia, Animación	2025	Maggie Kang	Cuando no están llenando estadios, las superestrellas del K-pop Rumi, Mira y Zoey usan sus poderes secretos para proteger a sus fans de una amenaza sobrenatural.	2025-10-21 05:21:10.476097	https://image.tmdb.org/t/p/w500/swQRKmW7RLhncPYHvM0RHz8b7bT.jpg	t
24	Juego sucio	Crimen	2025	Shane Black	Un experto ladrón lleva a cabo el mayor robo de su vida. Parker, junto a Grofield, Zen y un equipo experto, se ven involucrados en un golpe que los enfrenta a la mafia de Nueva York en esta arriesgada misión.	2025-10-21 05:21:10.572214	https://image.tmdb.org/t/p/w500/70Na5MXfOsFlJvoX6oKYAwOhNN9.jpg	t
25	Primitive War	Acción, Terror, Bélica	2025	Luke Sparke	Vietnam, 1968. El equipo de reconocimiento Vulture Squad se adentra en un valle aislado para investigar un pelotón de Boinas Verdes desaparecido. Su misión toma un giro oscuro cuando descubren una amenaza invisible.	2025-10-21 05:21:10.663475	https://image.tmdb.org/t/p/w500/aJc0Ej0mAIpNPoQh46oOnUQCqxE.jpg	t
26	La mujer del camarote 10	Misterio, Suspense, Crimen	2025	Simon Stone	A bordo de un lujoso yate por motivos de trabajo, una periodista ve como alguien cae al mar. Pero cuando nadie la cree, decide arriesgar su propia vida para descubrir la verdad.	2025-10-21 05:21:10.756903	https://image.tmdb.org/t/p/w500/lUJIBUjEab71fJ8U9gs0NouUJ18.jpg	t
27	Misión: Imposible - Sentencia final	Acción, Aventura, Suspense	2025	Christopher McQuarrie	El agente Ethan Hunt continúa su misión de impedir que Gabriel controle el tecnológicamente omnipotente programa de IA conocido como "the Entity".	2025-10-21 05:21:10.89974	https://image.tmdb.org/t/p/w500/haOjJGUV00dKlZaJWgjM1UD1cJV.jpg	t
28	27 noches	Comedia	2025	Daniel Hendler	Una mujer acaba en una clínica psiquiátrica por decisión de sus hijas. Un especialista debe decidir si realmente está enferma o si lo único que quiere es disfrutar de la vida.	2025-10-21 05:21:10.99246	https://image.tmdb.org/t/p/w500/vqReHIFJc1vgYLTQF768rFsRxRC.jpg	t
29	V/H/S/HALLOWEEN	Terror, Suspense, Comedia	2025	Bryan M. Ferguson	Una colección de videos con temática de Halloween desata una serie de historias retorcidas y llenas de sangre, que transforman el truco o trato en una lucha por la supervivencia.	2025-10-21 05:21:11.091437	https://image.tmdb.org/t/p/w500/bvMKSZtN8KAdtlKoYbEi1Zhyaou.jpg	t
30	Regalo maldito	Terror, Suspense	2025	Bryan Bertino	Cuando Polly recibe una misteriosa caja de una inesperada visitante nocturna, viene con la simple instrucción de colocar tres cosas dentro: algo que necesites, algo que odies y algo que ames. Lo que comienza como un extraño ritual se convierte rápidamente en una pesadilla. Atrapada en un mundo aterrador donde la realidad se tuerce y la memoria la traiciona, Polly debe tomar una serie de decisiones imposibles. A medida que el tiempo se escapa, se ve obligada a enfrentarse a la oscuridad no sólo a su alrededor, sino también en su interior, antes de que consuma todo y a todos los que ha conocido.	2025-10-21 05:21:11.18526	https://image.tmdb.org/t/p/w500/qYCA7XkLRUNS1DC7c8ehtj6W4XM.jpg	t
31	Prisionero de guerra	Acción, Bélica, Suspense, Historia	2025	Louis Mandylor	Un comandante británico, prisionero en un campo japonés, se esfuerza por sobrevivir. Su valentía inspira a otros prisioneros y lo convierte en un símbolo de dignidad ante la adversidad.	2025-10-21 05:21:11.276586	https://image.tmdb.org/t/p/w500/6paGLyOAvY95XxjfdiTcatwI7dJ.jpg	t
32	xXx	Acción, Aventura, Suspense, Crimen	2002	Rob Cohen	Xander Cage es XXX, un antiguo ganador de X-Games y atleta profesional de deportes de extremo, que sobrevive vendiendo videos de sus increíbles hazañas, las cuales hacen emitir adrenalina por todo el cuerpo. Pero después de incontables encuentros con la ley, su mundo está a punto de tomar un rumbo aún más extremo... Porque Xander no sabe que ha sido "espiado" por Augustus Gibbons, un agente veterano de la Agencia Nacional de Seguridad que se encuentra en una desesperada situación en la distante ciudad de Praga, en donde su operativo secreto ha sido asesinado por una pandilla de mafiosos con un estilo muy propio, que se llaman así mismos Anarchy 99, encabezados por el brutal ex-Comandante del Ejército Ruso Yorgi.	2025-10-21 05:21:11.386681	https://image.tmdb.org/t/p/w500/gd4hRY3pFXRY7YVbMdVBpnKV7wC.jpg	t
33	Night of the Reaper	Terror, Suspense	2025	Brandon Christensen	En un tranquilo suburbio de los 80, una niñera es asesinada por un misterioso enmascarado conocido como el “Reaper”. Años después, Deena, una joven universitaria, regresa a su pueblo y acepta cuidar al hijo del sheriff local, sin saber que el asesino ha vuelto. Mientras el sheriff recibe inquietantes cintas con pistas del pasado, Deena se convierte en el nuevo objetivo del Reaper, desatando una noche de terror y revelaciones sobre una venganza oculta.	2025-10-21 05:21:11.481392	https://image.tmdb.org/t/p/w500/HVR8cNWzBVoqbEIIqVtLpDvVKn.jpg	t
34	Superman	Ciencia ficción, Aventura, Acción	2025	James Gunn	En un mundo que ha perdido la fe en la bondad, Superman lucha por reconciliar su herencia kryptoniana con los valores humanos que moldearon su carácter. Criado en la Tierra, representa la verdad, la justicia y el estilo americano, pero debe enfrentarse a un mundo cínico que cuestiona sus ideales. Entre el deber de proteger a la humanidad y la búsqueda de su identidad, Superman demuestra que la esperanza y la bondad nunca pasan de moda, incluso en los tiempos más oscuros, inspirando a otros a creer en un futuro mejor.	2025-10-21 05:21:11.591418	https://image.tmdb.org/t/p/w500/fvUJb08yatV2b3NUSwuYdQKYoFd.jpg	t
36	Zona de caza	Acción, Suspense	2025	Derek Barnes	Una madre que huye de su marido, relacionado con la mafia, encuentra refugio en casa de un vagabundo llamado Jake, pero cuando los hombres de su marido se acercan, Jake resulta ser más peligroso que cualquiera de los que ella huye.	2025-10-26 18:01:14.766848	https://image.tmdb.org/t/p/w500/u6DNzvz4y3XS5QYqsvvauIx4Xvc.jpg	t
37	Afterburn (Zona Cero)	Ciencia ficción, Acción, Comedia	2025	J.J. Perry	Un grupo de cazadores de tesoros postapocalípticos busca reliquias antiguas en una tierra que ha quedado casi destruida por una enorme erupción solar.	2025-10-26 18:01:14.868092	https://image.tmdb.org/t/p/w500/soZdshVi2nQpCWqQkS8qumUNNqO.jpg	t
38	El elixir de la inmortalidad	Terror, Suspense	2025	Kimo Stamboel	Un elixir revive a los muertos en un pueblo. Una familia con conflictos internos deberá unir fuerzas y luchar para sobrevivir cuando su ciudad natal peligra.	2025-10-26 18:01:14.966771	https://image.tmdb.org/t/p/w500/jNBxGBNeXbG8WBKqBHtC5HjizB0.jpg	t
39	La larga marcha	Suspense, Ciencia ficción, Terror	2025	Francis Lawrence	En un futuro distópico, cien adolescentes participan en una brutal competición conocida como "La larga marcha", donde deben caminar sin descanso: si se detienen o reducen la velocidad de la marcha, mueren. Solo uno sobrevivirá. Adaptación cinematográfica de la novela de Stephen King.	2025-10-26 18:01:15.062693	https://image.tmdb.org/t/p/w500/kXIw6UiO2zANEPyStiYoEIopN0q.jpg	t
40	Una casa llena de dinamita	Bélica, Suspense	2025	Kathryn Bigelow	Cuando un misil sin identificar es lanzado contra EE. UU., se desata una carrera a contrarreloj por descubrir al responsable y decidir cómo responder.	2025-10-26 18:01:15.159308	https://image.tmdb.org/t/p/w500/ku4vTAnfTgO5oPPaHqyLtP39LrE.jpg	t
41	Black Phone 2	Terror, Suspense	2025	Scott Derrickson	La película Black Phone 2 (2025) es una secuela ambientada en 1982, cuatro años después de que Finney Blake lograra matar al secuestrador y asesino en serie conocido como "The Grabber". Finney, ahora marcado por el trauma, junto a su hermana menor Gwen, que tiene habilidades psíquicas, comienzan a tener visiones relacionadas con asesinatos ocurridos en un campamento cristiano en las Montañas Rocosas. Decididos a descubrir la verdad, viajan junto con Ernesto, un amigo, al campamento donde trabajó su madre, que también tenía dones psíquicos y fue víctima del asesino.	2025-10-26 18:01:15.254482	https://image.tmdb.org/t/p/w500/q2G2EsnMaDzcWJetfpxnqMu4smE.jpg	t
42	La Astronauta	Terror, Ciencia ficción, Suspense	2025	Jess Varley	Sam Walker (Kate Mara) regresa en extrañas circunstancias de su primera misión espacial. El general William Harris (Laurence Fishburne) la obliga a permanecer en cuarentena, bajo la estricta vigilancia de la NASA, en una casa aislada de alta seguridad. Pese a vivir en una aparente normalidad, Walker empieza a percibir sucesos inquietantes en los alrededores de la propiedad. Es entonces cuando comienza a temer que no haya vuelto sola a la Tierra.	2025-10-26 18:01:15.356183	https://image.tmdb.org/t/p/w500/wXwJw65dMa84x5TWHMtZMaiCrri.jpg	t
43	La mano que mece la cuna	Suspense, Terror	2025	Michelle Garza Cervera	Una madre de familia acomodada contrata a Polly Murphy como niñera, pero pronto descubre que esta mujer no es quien dice ser. Remake de "La mano que mece la cuna" (1992).	2025-10-26 18:01:15.457224	https://image.tmdb.org/t/p/w500/lRe1CQugJcj5ZA3WSaQnFIDPoK5.jpg	t
44	Chainsaw Man - La película: El arco de Reze	Animación, Acción, Romance, Fantasía, Terror	2025	Tatsuya Yoshihara	Denji trabajaba como cazador de demonios para la yakuza, tratando de saldar la deuda que había heredado de sus padres, pero la yakuza lo traicionó y lo mató. Antes de perder el conocimiento, Pochita, el perro-demonio motosierra de Denji, hizo un trato con él y le salvó la vida. Así se fusionaron, creando al imparable Chainsaw Man. Ahora, en medio de una brutal guerra entre demonios, cazadores y enemigos secretos, una misteriosa chica llamada Reze irrumpe en su mundo y Denji se enfrenta a su batalla más mortífera, impulsado por el amor, en un mundo donde la supervivencia no conoce reglas.	2025-10-26 18:01:15.558286	https://image.tmdb.org/t/p/w500/1CfZCb56vWjq37uXtbKNMevMzwG.jpg	t
45	Pets on a Train	Animación, Comedia, Aventura, Suspense	2025	Jean-Christian Tassy	En un tren que está a punto de salir de la estación, suena la alarma que obliga a todos los pasajeros a bajarse. Pero entonces el tren arranca de manera improvista, llevándose a bordo los viajeros que no han tenido tiempo de bajar: los animales de compañía. Asombrados, estos descubren que el tren está bajo el control de Hans, un tejón manipulador y rencoroso, que se quiere vengar de Rex, el perro policía que le puso entre rejas hace años. Como los servicios de rescate no consiguen intervenir en el trayecto montañoso del tren, que circula a toda velocidad, los animales de compañía solo pueden contar con Falcon, un mapache un poco tramposo que hará todo lo posible para salvarles.	2025-10-26 18:01:15.65638	https://image.tmdb.org/t/p/w500/dJZRImFs3jdMV1I2OzgjGz1rZv9.jpg	t
46	Los Rose	Comedia, Drama, Romance	2025	Jay Roach	La vida parece fácil para la pareja perfecta que forman Ivy y Theo: carreras de éxito, un matrimonio feliz y unos hijos estupendos. Pero detrás de la fachada de su supuesta vida ideal, se avecina una tormenta: la carrera de Theo se desploma mientras que las ambiciones de Ivy despegan, lo que desencadena una caja de Pandora de competitividad y resentimiento ocultos.	2025-10-26 18:01:15.757592	https://image.tmdb.org/t/p/w500/lXumhtgMOxA3aqocplC8YIMwOv8.jpg	t
47	Butchers Book Two: Raghorn	Terror	2024	Adrian Langley	\N	2025-10-26 18:01:15.851671	https://image.tmdb.org/t/p/w500/odZQRpXqu8t808P1nLdss9GAFkn.jpg	t
48	Weapons	Terror, Misterio	2025	Zach Cregger	Cuando todos los alumnos de una misma clase, salvo uno, desaparecen misteriosamente la misma noche y exactamente a la misma hora, la pequeña ciudad donde viven se pregunta quién o qué está detrás de su desaparición.	2025-10-26 18:01:15.950172	https://image.tmdb.org/t/p/w500/nYqEQ3ltw0hHc1kBaNWr7Rb8WNZ.jpg	t
49	Jurassic World: El renacer	Ciencia ficción, Aventura, Acción	2025	Gareth Edwards	Cinco años después de los eventos de "Dominion", la ecología del planeta ha demostrado ser insoportable para los dinosaurios, donde los pocos que quedan viven aislados en las regiones ecuatoriales. Zora Bennett es contratada para dirigir a un equipo de especialistas cuyo objetivo es conseguir el material genético de las tres criaturas más grandes, las cuales tienen en su ADN la clave para fabricar un medicamento que aportará grandes beneficios a la humanidad. Pero la operación se cruzará con una familia cuyo barco volcó y todos acabarán en una isla prohibida ocupada por dinosaurios de numerosas especies, donde tendrán que hacer lo imposible para sobrevivir.	2025-10-26 18:01:16.101671	https://image.tmdb.org/t/p/w500/2sbGd7kDhMicDkT097FR9a2JyGU.jpg	t
50	TRON: Ares	Ciencia ficción, Aventura, Acción	2025	Joachim Rønning	La historia de Ares, un programa muy sofisticado que se envía desde el mundo digital al mundo real en una misión peligrosa y que va a representar el primer encuentro de la humanidad con seres creados por la IA.	2025-10-26 18:01:16.203341	https://image.tmdb.org/t/p/w500/qShQABLVRMZKnv5mWOPXWniBeB3.jpg	t
51	A pesar de ti	Romance, Drama	2025	Josh Boone	Morgan es una madre joven que intenta evitar que su hija Clara, de 16 años, cometa los mismos errores que ella, que se quedó embarazada y se casó demasiado joven, teniendo que aparcar sus propios sueños. La única persona que trae paz a la tensa relación madre-hija es Chris, su marido y padre de Clara. Pero esa paz se rompe cuando un trágico y extraño accidente trae desgarradoras consecuencias para ellas. Mientras lucha por reconstruir sus vidas, Morgan encuentra consuelo en la última persona que esperaba, mientras Clara se vuelve hacia el único chico que le han prohibido ver.	2025-10-26 18:01:16.299569	https://image.tmdb.org/t/p/w500/4lBPiTShr6vHvtnO7UBr35BarWs.jpg	t
52	Attack 13	Terror, Suspense	2025	Taweewat Wantha	Jin es la nueva de la escuela y no teme enfrentarse a su despiadada capitana de voleibol. Pero cuando la chica aparece muerta, su espíritu regresa para ajustar cuentas.	2025-10-26 18:01:16.403728	https://image.tmdb.org/t/p/w500/eq9MejualTf0lBWi1ZoJmwwqpPd.jpg	t
53	El laberinto del fauno	Fantasía, Drama, Bélica	2006	Guillermo del Toro	En la España falangista de 1944, una joven aficionada a los libros e hijastra de un sádico oficial del ejército huye a un misterioso pero cautivador mundo de fantasía.	2025-10-26 18:01:16.505781	https://image.tmdb.org/t/p/w500/953ZprqPxXSfhHvjBVRiIv7fSP6.jpg	t
54	Bone Lake	Terror, Suspense, Misterio	2025	Mercedes Bryce Morgan	\N	2025-10-26 18:01:16.601829	https://image.tmdb.org/t/p/w500/sGo5ti82LlydAZrvcsaj31iPuEI.jpg	t
55	Host	Terror	2025	ไพรัช คุ้มวัน	Host sigue a Ing, una joven enviada a un reformatorio en una isla remota donde la obediencia es la única norma. El colegio funciona bajo una estricta jerarquía, con la alumna favorita del director en lo más alto e Ing en lo más bajo. Poco después de su llegada, comienzan a producirse una serie de incidentes inquietantes. A medida que estos inquietantes sucesos se acumulan, Ing debe enfrentarse a una pregunta aterradora: ¿es simplemente una víctima de estos sucesos sobrenaturales, o podría ser ella misma su origen?	2025-10-26 18:01:16.701866	https://image.tmdb.org/t/p/w500/e8NefV41e0xxJYBFnqSPDB4QAHc.jpg	t
56	The Jester 2	Terror, Suspense, Crimen	2025	Colin Krawchuk	Cuando la maga adolescente Max se cruza con el siniestro Bufón en la noche de Halloween, debe ser más astuta que un asesino sobrenatural cuya magia es demasiado real y cuyos trucos siempre acaban en sangre.	2025-10-26 18:01:16.801936	https://image.tmdb.org/t/p/w500/giV7FS7HGyxRbwqxudXPvv1RgXD.jpg	t
57	Goldilocks and the Three Bears: Death & Porridge	Terror, Suspense	2024	Craig Rees	\N	2025-10-26 18:01:16.890417	https://image.tmdb.org/t/p/w500/w3xZSNGOCgoXOMtyhjcZM99oqOw.jpg	t
58	Mantis	Acción, Crimen, Suspense	2025	이태성	La sociedad secreta de asesinos a sueldo se sume en el caos y surge una nueva generación de asesinos. Sin las viejas reglas, ¿quién se atreverá a reclamar las sombras?	2025-10-26 18:01:16.988469	https://image.tmdb.org/t/p/w500/v1vs4RJyqzckfxPjyWN5zN1dEgH.jpg	t
59	Kill Her Goats	Terror	2023	Steve Wolsh	\N	2025-10-26 18:01:17.085414	https://image.tmdb.org/t/p/w500/w5c0QKF2dvGbsTbRdoYte5N9Fn0.jpg	t
60	Cómo entrenar a tu dragón	Fantasía, Familia, Acción, Aventura	2025	Dean DeBlois	En la escarpada isla de Mema, donde vikingos y dragones han sido enemigos acérrimos durante generaciones, Hipo se desmarca desafiando siglos de tradición cuando entabla amistad con Desdentao, un temido dragón Furia Nocturna. Su insólito vínculo revela la verdadera naturaleza de los dragones y desafía los cimientos de la sociedad vikinga.	2025-10-26 18:01:17.184429	https://image.tmdb.org/t/p/w500/kjQXYc2Abhy3TBgAZGzJRhN1JaV.jpg	t
61	Black Phone	Terror, Suspense	2022	Scott Derrickson	En una ciudad de Colorado, en los años 70, un enmascarado secuestra a Finney Shaw, un chico tímido e inteligente de 13 años, y le encierra en un sótano insonorizado donde de nada sirven sus gritos. Cuando un teléfono roto y sin conexión empieza a sonar, Finney descubre que a través de él puede oír las voces de las anteriores víctimas, las cuales están decididas a impedir que Finney acabe igual que ellas.	2025-10-26 18:01:17.284114	https://image.tmdb.org/t/p/w500/k2owpqGMjmZzA0CVzzreuCtkQs0.jpg	t
62	Valiant One	Bélica, Suspense, Acción	2025	Steve Barnett	Un helicóptero estadounidense se estrella en el lado norcoreano, ahora los supervivientes deben trabajar juntos para proteger a un civil especialista en tecnología y encontrar la salida sin la ayuda del apoyo militar estadounidense.	2025-10-26 18:01:17.426151	https://image.tmdb.org/t/p/w500/njCc9bEut22FkxoRdPzcLkSa1np.jpg	t
63	Revival	Terror, Suspense, Ciencia ficción	2024	Dario Germani	\N	2025-10-26 18:01:17.520251	https://image.tmdb.org/t/p/w500/cRVFnWIgXBqhGlVugaG4IQsmUpB.jpg	t
64	Una batalla tras otra	Acción, Suspense, Crimen	2025	Paul Thomas Anderson	Cuando su principal enemigo resurge después de 16 años, una banda de ex revolucionarios se pone de nuevo en contacto para rescatar a la hija de uno de los suyos, encarnado por Leonardo DiCaprio. Adaptación de la novela 'Vineland', de Thomas Pynchon (1990), sobre los movimientos radicales de los años sesenta.	2025-10-26 18:01:17.63807	https://image.tmdb.org/t/p/w500/zwxROLIUeEr6eFITwworjcXLAk4.jpg	t
65	F1 la película	Acción, Drama	2025	Joseph Kosinski	El mítico piloto Sonny Hayes vuelve de su retiro, persuadido para liderar un equipo de Fórmula 1 en apuros y guiar a su joven promesa, en busca de una nueva oportunidad de éxito.	2025-10-26 18:01:17.747137	https://image.tmdb.org/t/p/w500/wfpqaxoPKvcqzLy8FO0enGXBzU.jpg	t
66	Perdoname Papa	Suspense, Terror, Crimen	2024	Fredi 'Kruga' Nwaka	Una detective debe encontrar al responsable de mutilar varios cadáveres en una mansión.	2025-10-26 18:01:17.850253	https://image.tmdb.org/t/p/w500/b9FLi1lsg267ki2siw4wmXtUUHT.jpg	t
67	Coyotes	Terror, Comedia	2025	Colin Minihan	Una familia debe luchar por su vida contra una feroz manada de coyotes mientras un feroz incendio arrasa las colinas de Hollywood, creando una angustiosa situación de supervivencia en medio de la doble amenaza de los animales salvajes y las llamas descontroladas.	2025-10-26 18:01:17.949215	https://image.tmdb.org/t/p/w500/fSzs9ZXYcrln0FRrjGIPCjuB6En.jpg	t
68	Ne Zha 2	Animación, Fantasía, Aventura, Acción	2025	饺子	Cuando los cuerpos de los dos amigos, Aobing y Nezha, están a punto de ser destruidos, se les permite que sus almas sigan existiendo. Su maestro, Taiyi Zhenren, restaura sus cuerpos con la ayuda de una flor de loto. Después de esto, Nezha parte en busca de enfrentar al Rey Dragón del Mar del Este, Ao Guang.	2025-10-26 18:01:18.045643	https://image.tmdb.org/t/p/w500/jz5sGlPGf0cWZ0uJPDc8cSjjFcZ.jpg	t
69	Anemone	Drama	2025	Ronan Day-Lewis	Una exploración de las intrincadas relaciones entre padres, hijos y hermanos, así como de la dinámica de los vínculos familiares.	2025-10-26 18:01:18.149727	https://image.tmdb.org/t/p/w500/kXFHVJqZkWtkSRlLpv2clN8KP6E.jpg	t
70	Ligaw	Drama, Romance	2025	Omar Deroca	\N	2025-10-26 18:01:18.286593	https://image.tmdb.org/t/p/w500/xpGQxXQwm1zdzQ8bN98hEmojZOl.jpg	t
71	Good Boy	Terror, Suspense	2025	Ben Leonberg	Un perro leal se muda a una casa rural con su dueño Todd. Allí descubre fuerzas sobrenaturales que acechan en las sombras. Mientras oscuras entidades amenazan a su compañero humano, el valiente cachorro debe luchar para proteger a quien más quiere.	2025-10-26 18:01:18.39032	https://image.tmdb.org/t/p/w500/6rZOKB5EhGcTLaSPoyX8La44ZDT.jpg	t
72	La casa de muñecas de Gabby: La película	Familia, Comedia, Aventura, Animación	2025	Ryan Crego	El viaje por carretera de Gabby y la abuela Gigi da un giro inesperado cuando la preciada casa de muñecas de Gabby acaba en manos de la excéntrica gatera Vera. Gabby se embarca en una aventura para reunir a los Gabby Cats y recuperar su querida casa de muñecas antes de que sea demasiado tarde.	2025-10-26 18:01:18.48784	https://image.tmdb.org/t/p/w500/ruAIbycacQIIXeTf4xh1r1NjvJa.jpg	t
93	Agárralo como puedas	Comedia, Acción, Crimen	2025	Akiva Schaffer	El torpe teniente Frank Drebin Jr. intenta resolver un asesinato vinculado a un magnate tecnológico. Mientras investiga, su unidad policial corre peligro de ser cerrada. Con la ayuda de una escritora de crímenes, Frank se verá envuelto en situaciones tan absurdas como explosivas. Película reboot basada en la popular franquicia de comedia "Agárralo como puedas" y la serie de televisión "Police Squad!".	2025-10-26 18:01:20.660034	https://image.tmdb.org/t/p/w500/Mu73AnUmBpSI8W0bNCgaCVwzOa.jpg	t
73	Nadie 2	Acción, Suspense	2025	Timo Tjahjanto	Cuatro años después de enfrentarse involuntariamente a la mafia rusa, Hutch Mansell sigue intentando saldar una deuda de 30 millones de dólares con golpes a criminales internacionales. Agotado y distanciado de su familia, organiza unas vacaciones con su esposa e hijos en Plummerville, el lugar donde solía ir con su hermano de niño. Pero un pequeño altercado los convierte en el objetivo de un peligroso mafioso local y de su corrupto sheriff, poniendo en riesgo toda la familia.	2025-10-26 18:01:18.599402	https://image.tmdb.org/t/p/w500/qwdBh0102NX5fslXv3L9MSlXqKc.jpg	t
74	Interstellar	Aventura, Drama, Ciencia ficción	2014	Christopher Nolan	Un grupo de exploradores hacen uso de un agujero de gusano recientemente descubierto para superar las limitaciones de los viajes espaciales tripulados y vencer las inmensas distancias que tiene un viaje interestelar.	2025-10-26 18:01:18.721229	https://image.tmdb.org/t/p/w500/fbUwSqYIP0isCiJXey3staY3DNn.jpg	t
75	Caramelo	Comedia, Drama	2025	Diego Freitas	Tras un diagnóstico inesperado, un prometedor chef halla consuelo, risa y esperanza gracias a un entrañable amigo de cuatro patas en este emotivo drama.	2025-10-26 18:01:18.817779	https://image.tmdb.org/t/p/w500/c4ZEAah5a01cu27w7vT2IAoFogk.jpg	t
76	లైలా	Comedia, Romance	2025	Ram Narayan	\N	2025-10-26 18:01:18.912303	https://image.tmdb.org/t/p/w500/l4gsNxFPGpzbq0D6QK1a8vO1lBz.jpg	t
77	Edén	Suspense, Drama	2025	Ron Howard	En 1932, un grupo de europeos busca una nueva vida en una isla deshabitada del archipiélago de las Galápagos. Ellos y quienes les siguen creen haber encontrado el paraíso, pero descubren que el infierno son los demás.	2025-10-26 18:01:19.017839	https://image.tmdb.org/t/p/w500/tgV2ARxodyFhgrp9JW6bETMCWXB.jpg	t
78	Culpa mía: Londres	Romance, Drama	2025	Dani Girdwood	Noah, de 18 años, se traslada de Estados Unidos a Londres con su madre, que se ha enamorado recientemente de William, un adinerado hombre de negocios británico. Noah conoce al hijo de William, el malote Nick. Pese a los esfuerzos de ambos por evitarlo, se sienten atraídos. Mientras Noah pasa el verano adaptándose a su nueva vida, su doloroso pasado la irá atrapando a la vez que se va enamorando.	2025-10-26 18:01:19.112627	https://image.tmdb.org/t/p/w500/q0HxfkF9eoa6wSVnzwMhuDSK7ba.jpg	t
79	Los tipos malos 2	Familia, Comedia, Crimen, Aventura, Animación	2025	Pierre Perifel	Un genial equipo de animales que no respetan la ley, los ahora muy reformados Tipos Malos, se esfuerzan (mucho, muchísimo) en ser buenos, pero se ven envueltos involuntariamente en un golpe de envergadura mundial planeado por un inesperado grupo de criminales: las Tipas Malas.	2025-10-26 18:01:19.221546	https://image.tmdb.org/t/p/w500/mZmnKDhIS2yNmtfzde5vtdCYzBF.jpg	t
80	From Darkness	Terror, Misterio, Suspense	2024	Philip W. da Silva	Los guardabosques Angelica y Viktor investigan la desaparición de una mujer en una reserva natural sueca. Exploran cuevas encantadas, enfrentan su pasado y descubren oscuros secretos mientras luchan contra una criatura mítica.	2025-10-26 18:01:19.316348	https://image.tmdb.org/t/p/w500/zzxIUS5GFMmDVActt9IPMQ0XZde.jpg	t
81	Frankenstein	Drama, Terror, Ciencia ficción	2025	Guillermo del Toro	\N	2025-10-26 18:01:19.415899	https://image.tmdb.org/t/p/w500/zzNvTbblTCKgBiDFCO86nMaKkSt.jpg	t
82	Brute 1976	Terror	2024	Marcel Walz	\N	2025-10-26 18:01:19.516887	https://image.tmdb.org/t/p/w500/lzfqL4oBIcsfW9PRrmPsSnq5e51.jpg	t
83	Lilo y Stitch	Familia, Ciencia ficción, Comedia, Aventura	2025	Dean Fleischer Camp	La conmovedora y divertidísima historia de una solitaria niña hawaiana y el extraterrestre fugitivo que la ayuda a reparar su desestructurada familia.	2025-10-26 18:01:19.615893	https://image.tmdb.org/t/p/w500/4oLLOAT55JhAoe73VliaSKFvEEr.jpg	t
84	Black Mold	Terror, Suspense, Drama, Película de TV	2025	John Pata	Mientras explora unas instalaciones decrépitas y abandonadas, una prometedora fotógrafa se enfrenta a su traumático pasado.	2025-10-26 18:01:19.712641	https://image.tmdb.org/t/p/w500/tEN12WSxepFqZmWEknBnrXoHDvL.jpg	t
85	Django imbatible	Western	2024	Claudio Del Falco	Decidido a exigir justicia, Django se enfrenta a peligrosos desafíos y sangrientos enfrentamientos para restaurar el orden en un territorio dominado por la anarquía y la injusticia.	2025-10-26 18:01:19.806307	https://image.tmdb.org/t/p/w500/l33smCkbpVFvNxGLILrx1PEyxyw.jpg	t
86	Tide	Terror	2024	Berty Cadilhac	\N	2025-10-26 18:01:19.917782	https://image.tmdb.org/t/p/w500/47sKhC5xyh9oUYz4icO4MB8ern8.jpg	t
87	Bambi: La venganza	Terror, Suspense	2025	Dan Allen	Un grupo de jovenes van al bosque y ahi estara Bambi que los quiere ver muertos	2025-10-26 18:01:20.019577	https://image.tmdb.org/t/p/w500/i0amBD0hmCCB8Kf6t3nVHqKaSKi.jpg	t
88	Los Vengadores	Ciencia ficción, Acción, Aventura	2012	Joss Whedon	Cuando un enemigo inesperado surge como una gran amenaza para la seguridad mundial, Nick Fury, director de la Agencia SHIELD, decide reclutar a un equipo para salvar al mundo de un desastre casi seguro.	2025-10-26 18:01:20.145232	https://image.tmdb.org/t/p/w500/ugX4WZJO3jEvTOerctAWJLinujo.jpg	t
89	El luchador definitivo	Acción	2024	James Mark	En el año 2046, donde existen los viajes en el tiempo y los combates a muerte son un deporte, un multimillonario realiza improbables peleas televisadas para descubrir al luchador definitivo: samuráis vs vikingos, caballeros vs policías, cowboys vs espartanos… Un policía de los 80 deberá participar en el programa y ganar todos los combates para poder regresar a su pasado.	2025-10-26 18:01:20.245229	https://image.tmdb.org/t/p/w500/vmRtkq80lG1SO4wDscDUbuuoa3n.jpg	t
90	Coco	Familia, Animación, Música, Aventura	2017	Lee Unkrich	Un joven aspirante a músico llamado Miguel se embarca en un viaje extraordinario a la mágica tierra de sus ancestros. Allí, el encantador embaucador Héctor se convierte en su inesperado amigo y le ayuda a descubrir los misterios detrás de las historias y tradiciones de su familia.	2025-10-26 18:01:20.35051	https://image.tmdb.org/t/p/w500/vwsFGblLYxWBNjg9pdWN1Mm5YfW.jpg	t
91	Dead of Winter	Suspense	2025	Brian Kirk	Una mujer, que viaja sola por el norte nevado de Minnesota, interrumpe el secuestro de una adolescente. A horas del pueblo más cercano y sin cobertura telefónica, se da cuenta de que es la única esperanza de la joven.	2025-10-26 18:01:20.449681	https://image.tmdb.org/t/p/w500/5DcrN62sGAiRJxt8rXSRlSRLwIE.jpg	t
92	Ballerina	Acción, Suspense, Crimen	2025	Len Wiseman	Eve Macarro es una asesina entrenada por la Ruska Roma desde su infancia, la misma organización criminal encargada del adiestramiento de John Wick. En esta violenta historia de venganza, Eve intentará por todos los medios averiguar quién está detrás del asesinato de su padre. En su lucha por conocer la verdad, tendrá que atenerse a las normas de la Alta Mesa y, por supuesto, a las del Hotel Continental, donde descubrirá que existen secretos ocultos sobre su pasado.	2025-10-26 18:01:20.549736	https://image.tmdb.org/t/p/w500/gQCrYmvCK7JCLXjCGTMRF5Lzr5c.jpg	t
94	Destino final: Lazos de sangre	Terror, Misterio	2025	Adam B. Stein	Acosada por una violenta pesadilla recurrente, la estudiante universitaria Stefanie se dirige a casa para localizar a la única persona que podría ser capaz de romper el ciclo y salvar a su familia de la espeluznante muerte que inevitablemente les espera a todos.	2025-10-26 18:01:20.765296	https://image.tmdb.org/t/p/w500/frNkbclQpexf3aUzZrnixF3t5Hw.jpg	t
95	La hermanastra fea	Terror, Comedia, Fantasía, Drama	2025	Emilie Blichfeldt	Elvira lucha contra su hermosa hermanastra en un reino donde la belleza reina suprema. Ella recurre a medidas extremas para cautivar al príncipe, en medio de una despiadada competición por la perfección física.	2025-10-26 18:01:20.856575	https://image.tmdb.org/t/p/w500/4KjMMLHqKcAxNRTd5mhMDtNXW1P.jpg	t
96	Ne Zha	Animación, Fantasía, Aventura	2019	饺子	Nezha, nacido de una perla celestial con poderes únicos, pronto se encontrará exiliado, odiado y temido por la gente que cree en una profecía que indica que él traerá la destrucción del mundo. Llegará el momento en el que deberá decidir entre el bien y el mal con el propósito de romper los grilletes del destino y convertirse en un héroe. Película inspirada muy libremente en "Fengshen Yanyi" ("La Investidura de los Dioses"), una de las grandes novelas chinas escritas en la Dinastía Ming cuya autoría se atribuye a Xu Zhonglin o Lu Xixing.	2025-10-26 18:01:20.949681	https://image.tmdb.org/t/p/w500/8TpbaMAjrYm2iFB3LCTcVInwhdS.jpg	t
97	La sustancia	Drama, Terror, Ciencia ficción	2024	Coralie Fargeat	'Tú, pero mejor en todos los sentidos'. Esa es la promesa de la sustancia, un producto revolucionario basado en la división celular, que crea un alter ego más joven, más bello, más perfecto.	2025-10-26 18:01:21.054824	https://image.tmdb.org/t/p/w500/w1PiIqM89r4AM7CiMEP4VLCEFUn.jpg	t
98	Buenas noticias	Suspense, Comedia, Historia	2025	변성현	Cuando unos secuestradores toman un avión japonés y exigen volar a Pionyang, un enigmático estratega idea un disparatado plan para desviar el vuelo a Seúl.	2025-10-26 18:01:21.15399	https://image.tmdb.org/t/p/w500/zER9LQ7bWpuMRxtVeZ4toDc7PnM.jpg	t
99	Ice Road: Venganza	Acción, Suspense, Drama	2025	Jonathan Hensleigh	El camionero del hielo Mike McCann, cumpliendo el último deseo de su hermano, viaja a Nepal para esparcir sus cenizas en el monte Everest. En un autobús turístico que atraviesa el territorio de la tristemente célebre Ruta al Cielo, Mike y su guía se topan con un grupo de mercenarios y deberán luchar para salvar sus vidas.	2025-10-26 18:01:21.248319	https://image.tmdb.org/t/p/w500/5Wb1sOZvFulzzJE5JDWCnFSCvJ5.jpg	t
100	La novia cadáver	Romance, Fantasía, Animación	2005	Mike Johnson	Ambientada en un pueblecito europeo en el siglo XIX, esta película de animación fotograma a fotograma cuenta la historia de Victor, un joven que es llevado de repente al infierno, donde se casa con una misteriosa Novia Cadáver, mientras que su verdadera novia, Victoria espera en el mundo de los vivos. A pesar de que la tierra de los muertos resulta ser más colorista que su estricta educación victoriana, Victor aprende que no hay nada en este mundo, ni en el siguiente, que pueda separarle de su único y verdadero amor.	2025-10-26 18:01:21.363093	https://image.tmdb.org/t/p/w500/3ALM0VeZjGUryAqWo6pqohzbLDh.jpg	t
101	Elio	Familia, Comedia, Aventura, Animación, Ciencia ficción	2025	Madeline Sharafian	Cuenta la historia de Elio, un niño de 11 años, que lucha por encajar hasta que de repente es transportado por extraterrestres y es elegido para ser el embajador galáctico de la Tierra.	2025-10-26 18:01:21.465205	https://image.tmdb.org/t/p/w500/fqF7z5A8kFIrNtSdpEfjE539fna.jpg	t
102	Ya se verá	Comedia	2025	Giovanni Calvaruso	Tres jóvenes compiten por un puesto de letrado en el Ayuntamiento. Federico confía en su padre concejal, Fabrizio busca otra oportunidad y el privilegiado Luca se une a la carrera. Sólo uno puede ganar, hasta que se desencadenan acontecimientos inesperados.	2025-10-26 18:01:21.558889	https://image.tmdb.org/t/p/w500/qlhukyCnDmaWICbfaDE4S5J4duc.jpg	t
103	Vaiana 2	Familia, Comedia, Aventura, Animación, Fantasía	2024	David G. Derrick Jr.	Tras recibir una inesperada llamada de sus antepasados, Vaiana debe viajar a los lejanos mares de Oceanía y adentrarse en peligrosas aguas perdidas para vivir una aventura sin precedentes.	2025-10-26 18:01:21.657075	https://image.tmdb.org/t/p/w500/bit1B5F7IQydiWqdwAAD8f9TkXs.jpg	t
104	Pídeme lo que quieras	Romance, Drama	2024	Lucía Alemany	Judith Flores es una chica normal. Tiene un trabajo que le apasiona, muy buenos amigos y un padre encantador. Pero su vida cambia radicalmente cuando conoce a Eric Zimmerman, dueño de la empresa donde ella trabaja. Su relación con Eric está a punto de dinamitar su vida por completo.	2025-10-26 18:01:21.750293	https://image.tmdb.org/t/p/w500/5rtaLwyKAjbceww4J1ro8aA8BNB.jpg	t
105	El abismo secreto	Romance, Ciencia ficción, Suspense	2025	Scott Derrickson	Mandan a dos operativos de élite a vigilar lados opuestos de un misterioso abismo y allí intiman desde la distancia, pero deberán aunar fuerzas para sobrevivir al mal que esconde el abismo.	2025-10-26 18:01:21.851457	https://image.tmdb.org/t/p/w500/3s0jkMh0YUhIeIeioH3kt2X4st4.jpg	t
106	El corredor del laberinto	Acción, Misterio, Ciencia ficción, Suspense	2014	Wes Ball	Thomas abre los ojos y se da cuenta que está en un ascensor. Lo extraño es que no recuerda nada, ni dónde está, ni quién es. Lo único que aún permanece intacto en su memoria es su nombre, y ya es mucho. Antes de que le dé tiempo a cuestionarse algo sobre sí mismo las puertas se abrirán y aparecerá ante él un extraño mundo. Todo lo que ve son chicos de su edad que tienen su mismo estado de amnesia. Una aventura fantástica que pronto destapará la dura realidad bajo ese velo de incertidumbre: todos ellos están atrapados en un laberinto. Si quieren tener alguna posibilidad de salir de allí y recuperar su antigua vida y aquello que no son capaces de recordar deberán unir fuerzas para escapar. Un mundo post-apocalíptico que les acorralará e irá un paso por delante será el desafío que tengan que pasar estos jóvenes por la libertad.	2025-10-26 18:01:21.954636	https://image.tmdb.org/t/p/w500/egKi4jZKKVZzR8NaaNjEwMpEgHs.jpg	t
107	Laberinto en llamas	Drama, Misterio, Suspense	2025	Paul Greengrass	En uno de los incendios forestales más mortíferos de la historia de Estados Unidos que amenaza la ciudad de Paradise, Kevin McKay, un conductor de autobús escolar, y Mary Ludwig, una maestra infantil, luchan para salvar a 22 niños del aterrador infierno.	2025-10-26 18:01:22.055237	https://image.tmdb.org/t/p/w500/8n0kkUc4wKknqEJfq8eErWrvvUL.jpg	t
108	M3GAN 2.0	Acción, Ciencia ficción, Suspense	2025	Gerard Johnstone	Con el futuro de la existencia humana en juego, Gemma se da cuenta de que la única opción es resucitar a M3GAN y darle unas cuantas mejoras, haciéndola más rápida, más fuerte y más letal.	2025-10-26 18:01:22.16331	https://image.tmdb.org/t/p/w500/zgsdwQ6XciR0IzgeRXyKzVhzVzP.jpg	t
109	Harry Potter y la piedra filosofal	Aventura, Fantasía	2001	Chris Columbus	Harry Potter es un huérfano que vive con sus desagradables tíos, los Dursley, y su repelente primo Dudley. Se acerca su undécimo cumpleaños y tiene pocas esperanzas de recibir algún regalo, ya que nunca nadie se acuerda de él. Sin embargo, pocos días antes de su cumpleaños, una serie de misteriosas cartas dirigidas a él y escritas con una estridente tinta verde rompen la monotonía de su vida: Harry es un mago y sus padres también lo eran.	2025-10-26 18:01:22.266985	https://image.tmdb.org/t/p/w500/3MKK7vAJLtSkBTABMTjxf6TOCo3.jpg	t
110	Un fantasma en la batalla	Drama, Suspense	2025	Agustín Díaz Yanes	Una joven guardia civil lo deja todo para hacerse pasar por miembro de ETA, arriesgando su vida para localizar los zulos de los terroristas en el sur de Francia.	2025-10-26 18:01:22.365108	https://image.tmdb.org/t/p/w500/zMdJdI74PdObENl4RfU3o5lC0VM.jpg	t
111	Venganza implacable	Acción, Crimen, Suspense	2024	成思毅	Después de que su esposa e hija sean brutalmente asesinadas a manos de unos misteriosos sicarios vinculados a un sanguinario sindicato del crimen organizado, An Bai (Tony Jaa), un veterano experto en Muay Thai, se propone desentrañar la verdad e inicia una implacable misión de venganza.	2025-10-26 18:01:22.457356	https://image.tmdb.org/t/p/w500/h8DNi9XJKUS2nOzU5qEFEg7R0N6.jpg	t
112	Tiempo de asesinos	Acción	2025	\N	Shanghái, 1932. Durante un banquete del ejército japonés, el líder de la resistencia china Mubai realiza una incursión exitosa y conoce al mecenas Sr. Hu, quien lo recluta para asesinar al estratega japonés Kurokawa. Mubai y su equipo enfrentan emboscadas y traiciones en una misión que cambiará sus vidas.	2025-10-26 18:01:22.552551	https://image.tmdb.org/t/p/w500/eNriIkhQusncgc5SipEgQUtrybO.jpg	t
113	A Working Man	Acción, Crimen, Suspense	2025	David Ayer	Levon Cade dejó atrás una condecorada carrera militar en las operaciones encubiertas para vivir una vida sencilla trabajando en la construcción. Pero cuando la hija de su jefe, que para él es como de la familia, es secuestrada por traficantes de personas, su búsqueda para traerla a casa descubre un mundo de corrupción mucho mayor de lo que jamás podría haber imaginado.	2025-10-26 18:01:22.755074	https://image.tmdb.org/t/p/w500/aG50Ad3UV8cCQWpNWSHHUqgKGNB.jpg	t
114	Los mundos de Coraline	Animación, Familia, Fantasía	2009	Henry Selick	Película de animación en la que se nos cuenta la historia de Coraline, una jovencita que descubre en su nueva casa una puerta secreta y decide abrirla. Al hacerlo, descubre una segunda versión de su vida, una vida paralela a la que ella tiene. A primera vista, la realidad paralela es curiosamente parecida a su vida de verdad, aunque mucho mejor. Pero cuando su increíble y maravillosa aventura empieza a tomar un cariz peligroso, su otra madre intenta mantenerla a su lado para siempre. Coraline deberá recurrir a su determinación y coraje, a la ayuda de los vecinos y a un gato negro con el don del habla para salvar a sus auténticos padres, a unos niños fantasmas y regresar a casa.	2025-10-26 18:01:22.859376	https://image.tmdb.org/t/p/w500/xz1HjxeqpIACyPtJMqv33Z2RjRP.jpg	t
115	Cadena perpetua	Drama, Crimen	1994	Frank Darabont	Acusado del asesinato de su mujer, Andrew Dufresne, tras ser condenado a cadena perpetua, es enviado a la prisión de Shawshank. Con el paso de los años conseguirá ganarse la confianza del director del centro y el respeto de sus compañeros presidiarios, especialmente de Red, el jefe de la mafia de los sobornos.	2025-10-26 18:01:23.042801	https://image.tmdb.org/t/p/w500/uRRTV7p6l2ivtODWJVVAMRrwTn2.jpg	t
116	Avatar: El sentido del agua	Acción, Aventura, Ciencia ficción	2022	James Cameron	Más de una década después de los acontecimientos de 'Avatar', los Na'vi Jake Sully, Neytiri y sus hijos viven en paz en los bosques de Pandora hasta que regresan los hombres del cielo. Entonces comienzan los problemas que persiguen sin descanso a la familia Sully, que decide hacer un gran sacrificio para mantener a su pueblo a salvo y seguir ellos con vida.	2025-10-26 18:01:23.148693	https://image.tmdb.org/t/p/w500/ckeTumMS4G31UQ9NNkmtW2QhfMF.jpg	t
117	Del revés 2 (Inside Out 2)	Animación, Aventura, Comedia, Familia	2024	Kelsey Mann	Riley entra en la adolescencia y el Cuartel General de su cabeza sufre una repentina reforma para hacerle hueco a algo totalmente inesperado propio de la pubertad: ¡nuevas emociones! Alegría, Tristeza, Ira, Miedo y Asco, con años de impecable gestión a sus espaldas (según ellos...) no saben muy bien qué sentir cuando aparece con enorme ímpetu Ansiedad. Y no viene sola: le acompañan envidia, vergüenza y aburrimiento.	2025-10-26 18:01:23.293106	https://image.tmdb.org/t/p/w500/lE3DCRI7bQgHSiIuEPcFiXpiuGV.jpg	t
118	El mejor	Terror, Misterio	2025	Justin Tipping	Cameron Cade es un quarterback en ciernes que ha dedicado su vida y su identidad al fútbol americano. En vísperas del campeonato anual de fútbol americano profesional, Cam es atacado por un hincha desquiciado y sufre un traumatismo cerebral que podría poner fin a su carrera. Justo cuando todo parece perdido, Cam recibe un salvavidas cuando su héroe, Isaiah White, un legendario quarterback ocho veces campeón y megaestrella cultural, se ofrece a entrenar a Cam en el aislado complejo que Isaiah comparte con su esposa, Elsie White. Pero a medida que el entrenamiento de Cam se acelera, el carisma de Isaiah comienza a cuajar en algo más oscuro, enviando a su protegido a un agujero de conejo desorientador que puede costarle más de lo que jamás esperó.	2025-10-26 18:01:23.397768	https://image.tmdb.org/t/p/w500/n2xPRI0isWxKfX3UqlfnNPaPusg.jpg	t
119	El caballero oscuro	Drama, Acción, Crimen, Suspense	2008	Christopher Nolan	Batman/Bruce Wayne regresa para continuar su guerra contra el crimen. Con la ayuda del teniente Jim Gordon y del Fiscal del Distrito Harvey Dent, Batman se propone destruir el crimen organizado en la ciudad de Gotham. El triunvirato demuestra su eficacia, pero, de repente, aparece Joker, un nuevo criminal que desencadena el caos y tiene aterrados a los ciudadanos.	2025-10-26 18:01:23.505828	https://image.tmdb.org/t/p/w500/8QDQExnfNFOtabLDKqfDQuHDsIg.jpg	t
120	Una película de Minecraft	Familia, Fantasía, Comedia, Aventura, Acción	2025	Jared Hess	Cuatro inadaptados se encuentran luchando con problemas ordinarios cuando de repente se ven arrastrados a través de un misterioso portal al Mundo Exterior: un extraño país de las maravillas cúbico que se nutre de la imaginación. Para volver a casa, tendrán que dominar este mundo mientras se embarcan en una búsqueda mágica con un inesperado experto artesano, Steve.	2025-10-26 18:01:23.653938	https://image.tmdb.org/t/p/w500/rZYYmjgyF5UP1AVsvhzzDOFLCwG.jpg	t
121	El padrino	Drama, Crimen	1972	Francis Ford Coppola	Don Vito Corleone, conocido dentro de los círculos del hampa como 'El Padrino', es el patriarca de una de las cinco familias que ejercen el mando de la Cosa Nostra en Nueva York en los años cuarenta. Don Corleone tiene cuatro hijos: una chica, Connie, y tres varones; Sonny, Michael y Fredo. Cuando el Padrino reclina intervenir en el negocio de estupefacientes, empieza una cruenta lucha de violentos episodios entre las distintas familias del crimen organizado.	2025-10-26 18:01:23.752257	https://image.tmdb.org/t/p/w500/ApiEfzSkrqS4m1L5a2GwWXzIiAs.jpg	t
122	Pitufos	Animación, Familia, Fantasía	2025	Chris Miller	Película musical de animación centrada en las icónicas creaciones de Peyo. Cuando Papá Pitufo es secuestrado de forma misteriosa por los malvados brujos Razamel y Gargamel, Pitufina lleva a los Pitufos a una misión al mundo real para salvarle. Con la ayuda de nuevos amigos, los Pitufos deberán descubrir qué define su destino para salvar el universo.	2025-10-26 18:01:23.851809	https://image.tmdb.org/t/p/w500/zBdQclxQnEDOhDOjkKgKPW6jEHh.jpg	t
123	365 días: Aquel día	Romance, Drama	2022	Barbara Białowąs	Laura y Massimo vuelven más fuertes que nunca, pero las ataduras familiares de Massimo y un misterioso hombre que quiere conquistar a Laura complican su relación.	2025-10-26 18:01:23.947368	https://image.tmdb.org/t/p/w500/k3J2GdYxhR6U2RfsHZOsmHVKW7m.jpg	t
124	Bitter Souls	Terror	2024	Tom Ryan	\N	2025-10-26 18:01:24.046562	https://image.tmdb.org/t/p/w500/fBZ8eliFh5HoT7ukT6cV7W4KEzG.jpg	t
137	Red Sonja	Aventura, Acción, Fantasía	2025	MJ Bassett	Nueva adaptación del cómic Red Sonja, una guerrera vengativa conocida como "La diablesa con una espada".	2025-10-26 21:19:01.693323	https://image.tmdb.org/t/p/w500/aE3yh4y0h96CZZpLo0UDFMWZAA9.jpg	t
125	Parking	Comedia, Drama	2025	Agustín Rolandelli	Mateo, un criminal bajo arresto domiciliario, inicia su primer día de trabajo en el turno nocturno de un estacionamiento con la intención de fugarse. Sin embargo, su plan se ve alterado cuando aparece Lara, una misteriosa mujer, que abona por un espacio para pasar la noche. Seguido a esto, en el lugar comienzan a producirse hechos delictivos inesperados, por lo que Mateo rápidamente sale a buscar Lara para asegurarse de que esté a salvo. No obstante, son testigos de un homicidio sangriento y son perseguidos por el asesino y su cómplice en el laberíntico edificio. A partir de esto, Mateo y Lara, a pesar de no conocerse, luchan juntos por escapar con vida del lugar.	2025-10-26 18:01:24.142591	https://image.tmdb.org/t/p/w500/cZdZCT8PG1UYFPjk11XUUIDfKs3.jpg	t
126	LEGO Disney Frozen: La misión de los frailecillos	Animación, Familia, Fantasía	2025	Alexandru Nagy	Tras lo acontecido en "Frozen", Anna y Elsa desean empezar de cero en Arendelle y poner el castillo un poco más cómodo. Mientras se esfuerzan por liberarse de las cadenas de la tradición, el duque de Weselton, acompañado de una bandada de amenazantes frailecillos, tiene otros planes para su amado hogar.	2025-10-26 18:01:24.237042	https://image.tmdb.org/t/p/w500/jHAdS2ZslMbAeAPCsiDJe3LCxS4.jpg	t
127	Vengadores: Infinity War	Aventura, Acción, Ciencia ficción	2018	Joe Russo	El todopoderoso Thanos ha despertado con la promesa de arrasar con todo a su paso, portando el Guantelete del Infinito, que le confiere un poder incalculable. Los únicos capaces de pararle los pies son los Vengadores y el resto de superhéroes de la galaxia, que deberán estar dispuestos a sacrificarlo todo por un bien mayor. Capitán América e Ironman deberán limar sus diferencias, Black Panther apoyará con sus tropas desde Wakanda, Thor y los Guardianes de la Galaxia e incluso Spider-Man se unirán antes de que los planes de devastación y ruina pongan fin al universo. ¿Serán capaces de frenar el avance del titán del caos?	2025-10-26 18:01:24.368257	https://image.tmdb.org/t/p/w500/ksBQ4oHQDdJwND8H90ay8CbMihU.jpg	t
128	Pesadilla antes de Navidad	Fantasía, Animación, Familia	1993	Henry Selick	Cuando Jack Skellington, el Señor de Halloween, descubre la Navidad, se queda fascinado y decide mejorarla. Sin embargo, su visión de la festividad es totalmente contraria al espíritu navideño. Sus planes incluyen el secuestro de Santa Claus y la introducción de cambios bastante macabros. Sólo su novia Sally es consciente del error que está cometiendo.	2025-10-26 18:01:24.510848	https://image.tmdb.org/t/p/w500/pqFPpQ77VZ0moRgRRsxx7p39CS3.jpg	t
129	Thunderbolts*	Acción, Ciencia ficción, Aventura	2025	Jake Schreier	Un grupo de supervillanos poco convencional es reclutado para hacer misiones para el gobierno: Yelena Belova, Bucky Barnes, Red Guardian, Ghost, Taskmaster y John Walker. Después de verse atrapados en una trampa mortal urdida por Valentina Allegra de Fontaine, estos marginados deben embarcarse en una peligrosa misión que les obligará a enfrentarse a los recovecos más oscuros de su pasado.	2025-10-26 18:01:24.632015	https://image.tmdb.org/t/p/w500/yDWU8YyFkPnlVY627QXPvct8bz9.jpg	t
130	Deadpool y Lobezno	Acción, Comedia, Ciencia ficción	2024	Shawn Levy	Un apático Wade Wilson se afana en la vida civil tras dejar atrás sus días como Deadpool, un mercenario moralmente flexible. Pero cuando su mundo natal se enfrenta a una amenaza existencial, Wade debe volver a vestirse a regañadientes con un Lobezno aún más reacio a ayudar.	2025-10-26 18:01:24.752567	https://image.tmdb.org/t/p/w500/9TFSqghEHrlBMRR63yTx80Orxva.jpg	t
131	Se requiere mantenimiento	Romance, Comedia	2025	Lacey Uhlemeyer	Charlie, la independiente dueña de un taller exclusivamente femenino, se ve obligada a reevaluar su futuro cuando una gran corporación de la competencia se instala enfrente. Buscando consuelo, recurre a un confidente en internet, sin saber que es Beau, el rival que amenaza su negocio. Mientras saltan chispas, tanto en internet como fuera de ella, la verdad amenaza con desbaratarlo todo.	2025-10-26 18:01:24.914263	https://image.tmdb.org/t/p/w500/kVcoxXAPfHo58FDwOCOF8NAW4bp.jpg	t
132	St. Patrick's Day Massacre	Terror	2025	Steve Lawson	En un viaje a Dublín para celebrar el Día de San Patricio, cuatro amigos acuerdan pasar la noche en una taberna abandonada, donde son acosados por un asesino de muertos vivientes en busca de venganza por una tragedia ocurrida siglos antes.	2025-10-26 18:01:25.007372	https://image.tmdb.org/t/p/w500/roboTp6hVELXd2PDkz98vnBhWnM.jpg	t
133	Titanic	Drama, Romance	1997	James Cameron	Jack, un joven artista, gana en una partida de cartas un pasaje para viajar a América en el Titanic, el transatlántico más grande y seguro jamás construido. A bordo conoce a Rose, una joven de una buena familia venida a menos que va a contraer un matrimonio de conveniencia con Cal, un millonario engreído a quien sólo interesa el prestigioso apellido de su prometida. Jack y Rose se enamoran, pero el prometido y la madre de ella ponen todo tipo de trabas a su relación. Mientras, el gigantesco y lujoso transatlántico se aproxima hacia un inmenso iceberg.	2025-10-26 18:01:25.125795	https://image.tmdb.org/t/p/w500/VMOt5scbGmBKDvkfHjZN6Ki54i.jpg	t
134	Drácula	Terror, Fantasía, Romance	2025	Luc Besson	Tras la muerte de su esposa, un príncipe del siglo XV renuncia a Dios y se convierte en vampiro. Siglos más tarde, en el Londres del siglo XIX, ve a una mujer parecida a su difunta esposa y la persigue, sellando así su propio destino.	2025-10-26 18:01:25.230683	https://image.tmdb.org/t/p/w500/3SQVpeacrCIn3GF3BXNDoPcQxEz.jpg	t
135	Un gran viaje atrevido y maravilloso	Romance, Fantasía, Drama	2025	코고나다	Sarah y David son dos solteros que se conocen en la boda de un amigo común y, pronto, por un sorprendente giro del destino, se embarcan en Un gran viaje atrevido y maravilloso, una aventura divertida, fantástica y arrolladora en la que reviven juntos momentos importantes de sus respectivos pasados, descubriendo cómo han llegado a donde están.	2025-10-26 18:01:25.3788	https://image.tmdb.org/t/p/w500/7Ja9exbCZBl3TEHRTWPESHoiln0.jpg	t
5	Culpa nuestra	Romance, Drama	2025	Domingo González	La boda de Jenna y Lion propicia el tan deseado reencuentro entre Noah y Nick tiempo después de su ruptura. La incapacidad de Nick para perdonar a Noah se alza como una barrera insalvable. Él, heredero de las empresas de su abuelo y ella, empezando su vida laboral, se resisten a alimentar una llama que aún sigue viva. Pero una vez que sus caminos se han vuelto a cruzar, ¿será el amor más fuerte que el rencor? Secuela de "Culpa tuya".	2025-10-21 05:21:08.677269	https://image.tmdb.org/t/p/w500/6kmi6vmp6iOn4KzI7WfnVtAeJhU.jpg	t
136	Batman Azteca: Choque de imperios	Animación, Acción, Aventura, Fantasía	2025	Juan Jose Meza-Leon	En la época del Imperio Azteca, Yohualli Coatl, un joven azteca, experimenta una tragedia cuando su padre y líder de la aldea, Toltecatzin, es asesinado por los conquistadores españoles. Yohualli escapa a Tenochtitlán para advertir al rey Moctezuma y a su sumo sacerdote, Yoka, del peligro inminente. Usando el templo de Tzinacan, el dios murciélago, como guarida, Yohualli entrena con su mentor y asistente, Acatzin, desarrollando equipo y armamento para enfrentar la invasión española, proteger el templo de Moctezuma y vengar la muerte de su padre.	2025-10-26 21:19:01.566855	https://image.tmdb.org/t/p/w500/wpMaI2J3ISYZiaIWNkoA1lVb5LQ.jpg	t
138	Dialogando con la vida	Drama	2022	Christophe Honoré	A sus 17 años, Lucas ve cómo su adolescencia se hace añicos en un abrir y cerrar de ojos. Siente que su vida es una bestia salvaje que debe domar. Entre un hermano afincado en París y una madre con la que ahora vive solo, Lucas se verá obligado a luchar para reconquistar la esperanza y el amor.	2025-10-26 21:19:01.811709	https://image.tmdb.org/t/p/w500/ziGStCIES7uUMpL29rC8q0iihNP.jpg	t
139	Karate Kid: Legends	Acción, Aventura, Drama	2025	Jonathan Entwistle	Tras una tragedia familiar, el prodigio del kung fu Li Fong se ve obligado a abandonar su hogar en Pekín y trasladarse a Nueva York con su madre. Li lucha por dejar atrás su pasado mientras intenta encajar con sus nuevos compañeros de clase y, aunque no quiere pelear, los problemas parecen encontrarle en todas partes. Cuando un nuevo amigo necesita su ayuda, Li se presenta a una competición de kárate, pero sus habilidades no son suficientes. El profesor de kung fu de Li, el Sr. Han, pide ayuda al Karate Kid original, Daniel LaRusso, y Li aprende una nueva forma de luchar, fusionando sus dos estilos en uno solo para el enfrentamiento definitivo de artes marciales. Nueva película de la saga "Karate Kid", conectada al universo de "Cobra Kai".	2025-10-26 21:19:01.933177	https://image.tmdb.org/t/p/w500/bwNAjGUsHt35eqT0Aj8NHU02WPl.jpg	t
140	Mi vida a lo grande	Animación, Familia, Comedia	2024	Kristina Dufková	Un niño de 12 años sufre acoso escolar por su peso e intenta darle la vuelta a la situación haciendo dieta e intentando conquistar a la chica de sus sueños.	2025-10-26 21:19:02.086128	https://image.tmdb.org/t/p/w500/a9nrn55Kyah9Efx6bUuvpCOs8Xy.jpg	t
141	Avatar	Acción, Aventura, Fantasía, Ciencia ficción	2009	James Cameron	Año 2154. Jake Sully, un exmarine en silla de ruedas, es enviado al planeta Pandora, donde se ha creado el programa Avatar, gracias al cual los seres humanos pueden controlar de forma remota un cuerpo biológico con apariencia y genética de la especie nativa. Pronto se encontrará con la encrucijada entre seguir las órdenes de sus superiores o defender al mundo que le ha acogido y siente como suyo.	2025-10-26 21:19:02.287975	https://image.tmdb.org/t/p/w500/nn7prZXNz3dgCV5jeShqqfHcU9F.jpg	t
142	Origen	Acción, Ciencia ficción, Aventura	2010	Christopher Nolan	Dom Cobb es un ladrón hábil, el mejor de todos, especializado en el peligroso arte de extracción: el robo de secretos valiosos desde las profundidades del subconsciente durante el estado de sueño cuando la mente está más vulnerable. Esta habilidad excepcional de Cobb le ha hecho un jugador codiciado en el traicionero nuevo mundo de espionaje corporativo, pero al mismo tiempo, le ha convertido en un fugitivo internacional y ha tenido que sacrificar todo que le importaba. Ahora a Cobb se le ofrece una oportunidad para redimirse. Con un último trabajo podría recuperar su vida anterior, pero solamente si logra lo imposible.	2025-10-26 21:19:02.436354	https://image.tmdb.org/t/p/w500/tXQvtRWfkUUnWJAn2tN3jERIUG.jpg	t
143	Los Increíbles	Acción, Aventura, Animación, Familia	2004	Brad Bird	Como Mr. Increíble y Elastigirl, Bob y su esposa Helen estaban entre los mejores luchadores contra el crimen. Por fin pueden volver a la acción cuando una misteriosa llamada cita a Bob en una isla remota.	2025-10-26 21:19:02.566331	https://image.tmdb.org/t/p/w500/al1jusd4T7JPatZlj4BuYkDDOzr.jpg	t
144	After: Aquí empieza todo	Romance, Drama	2019	Jenny Gage	La joven Tessa Young cursa su primer año en la universidad. Acostumbrada a una vida estable y ordenada, su mundo cambia cuando conoce a Hardin Scott, un misterioso joven de oscuro pasado. Desde el primer momento se odian, porque pertenecen a dos mundos distintos y son completamente opuestos. Sin embargo, estos dos polos opuestos pronto se unirán y nada volverá a ser igual. Tessa y Hardin deberán enfrentarse a difíciles pruebas para estar juntos. La inocencia, el despertar a la vida, el descubrimiento sexual y las huellas de un amor tan poderoso como la fuerza del destino.	2025-10-26 21:19:02.726871	https://image.tmdb.org/t/p/w500/5kZxlS9vLExy3hZA5GfNFg8oJgZ.jpg	t
145	Devuélvemela	Terror, Drama	2025	Michael Philippou	Un hermano y su hermana descubren un aterrador ritual en la apartada casa de su nueva madre adoptiva. Lo que parece un hogar seguro pronto se convierte en una pesadilla, donde figuras siniestras, extrañas imágenes en vídeo y sucesos paranormales los rodean.	2025-10-26 21:19:02.870145	https://image.tmdb.org/t/p/w500/cl3VbcYxzWnDPetd7SbdhSxwWoL.jpg	t
146	Gru 4. Mi villano favorito	Familia, Comedia, Animación, Ciencia ficción	2024	Chris Renaud	Gru, Lucy y las niñas -Margo, Edith y Agnes- dan la bienvenida a un nuevo miembro en la familia: Gru Junior, que parece llegar con el propósito de ser un suplicio para su padre. Gru tendrá que enfrentarse en esta ocasión a su nueva némesis Maxime Le Mal y su sofisticada y malévola novia Valentina, lo que obligará a la familia a tener que darse a la fuga. Cuarta entrega de 'Gru, mi villano favorito'.	2025-10-26 21:19:02.988098	https://image.tmdb.org/t/p/w500/b6JX0fBne5yPFNBtdp4Imi3CpiE.jpg	t
147	Los pecadores	Terror, Acción, Suspense	2025	Ryan Coogler	Tratando de dejar atrás sus problemáticas vidas, dos hermanos gemelos regresan a su pueblo natal para empezar de nuevo, solo para descubrir que un mal aún mayor les espera para darles la bienvenida.	2025-10-26 21:19:03.119435	https://image.tmdb.org/t/p/w500/zdClwqpYQXBSCGGDMdtvsuggwec.jpg	t
148	28 años después	Terror, Suspense, Ciencia ficción	2025	Danny Boyle	Años transcurridos tras los sucesos de "28 semanas después", el virus de la ira ha regresado y un grupo de supervivientes debe sobrevivir en un mundo asolado por hordas de infectados. Realizada con un iPhone 15 Pro Max y con la ayuda de numerosos accesorios especializados.	2025-10-26 21:19:03.243143	https://image.tmdb.org/t/p/w500/rlqdMZRPK8IELWcI5cJXLoA18XW.jpg	t
149	Laura's Toys	Drama	1975	Joseph W. Sarno	El arqueólogo Walter y su esposa Laura están trabajando en una excavación en una pequeña isla en la costa de Suecia. Un día, Laura descubre que Walter lo intenta con su sexy asistente, Anna. Laura llama a Hanni, su vieja amiga y antigua amante lesbiana, para que la ayude a vengarse de Walter al hacer que ella y Hanni seduzcan a Anna.	2025-10-26 21:19:03.358031	https://image.tmdb.org/t/p/w500/rqzupBGrChmHG5Wl6wy5vI0V3Vz.jpg	t
150	Jefes de Estado	Acción, Suspense, Comedia	2025	Ilya Naishuller	El primer ministro del Reino Unido y el presidente de EE. UU. tienen una rivalidad pública que pone en riesgo la alianza entre sus países. Pero cuando se convierten en el blanco de un poderoso enemigo, se ven obligados a confiar el uno en el otro. Aliados con Noel, una agente del MI6, intenta frustrar una conspiración que amenaza al mundo libre.	2025-10-26 21:19:03.587837	https://image.tmdb.org/t/p/w500/2CSdwqOUMH23cEBodqAJynMFz7c.jpg	t
151	Un paseo por el Borne	Drama, Comedia	2024	Nick Igea	Un curso de cine sin importancia en una ciudad pequeña como Palma de Mallorca. Un cineasta fracasado que será el profesor que lo imparta. Y cinco alumnos de diferentes edades que, con su fuerza y pasión por hacer cine, tratarán de que éste se involucre y les ayude, algo a lo que él se negará para que no acaben convertidos en lo que es él ahora: un fracasado.	2025-10-26 21:19:03.702709	https://image.tmdb.org/t/p/w500/1joRjD8XxNoDVaefhSQbbTzmiCU.jpg	t
152	Sé lo que hicisteis el último verano	Terror, Misterio, Suspense	2025	Jennifer Kaytin Robinson	Cuando cinco amigos provocan sin querer un accidente de coche mortal, encubren su implicación y hacen un pacto para mantenerlo en secreto en lugar de afrontar las consecuencias. Un año después, su pasado vuelve para atormentarlos y se ven obligados a enfrentarse a una aterradora verdad: alguien sabe lo que hicieron el último verano... y está empeñado en vengarse. A medida que los amigos son acechados uno a uno por un asesino, descubren que esto ya ha sucedido antes, y recurren a dos supervivientes de la legendaria Masacre de Southport de 1997 en busca de ayuda.	2025-10-26 21:19:03.817474	https://image.tmdb.org/t/p/w500/iSbqO4oaXyUL17jB4YqPRpu7DeR.jpg	t
153	Predator: Badlands	Acción, Ciencia ficción	2025	Dan Trachtenberg	En un planeta hostil conocido como Kalisk, un joven Yautja llamado Dek es expulsado de su clan tras fallar en su rito de iniciación. Solo y marcado como presa, su destino cambia al encontrar a Thia, una sintética dañada de Weyland-Yutani que ha desarrollado conciencia propia. A pesar de sus orígenes opuestos, forman una alianza inquebrantable para sobrevivir en un entorno donde bandas humanas, criaturas mutantes y otros depredadores los acechan. A medida que Dek busca redimirse y escalar en la cadena alimenticia, descubre que su verdadero desafío no es solo cazar, sino enfrentar a una bestia colosal y casi invencible, un kaiju ancestral que representa el ápice del poder en este mundo destruido. La película explora temas de honor, redención y conexión entre seres marginados, ofreciendo una perspectiva inédita desde el punto de vista del Predator.	2025-10-26 21:19:03.937107	https://image.tmdb.org/t/p/w500/4HkEWfYD6stkQgDI1g5Feq6kmoZ.jpg	t
154	Together	Terror, Romance	2025	Michael Shanks	Una pareja con problemas en su relación se muda al campo, donde descubren una cueva con una fuerza sobrenatural. Al beber agua de la cueva, comienzan a experimentar transformaciones físicas y emocionales que reflejan su codependencia.	2025-10-26 21:19:04.067575	https://image.tmdb.org/t/p/w500/h38smGzOE7y7iSVTuAgFrjGT4ut.jpg	t
155	Sonic 3: La película	Acción, Ciencia ficción, Comedia, Familia	2024	Jeff Fowler	Sonic, Knuckles y Tails se reúnen para enfrentarse a un nuevo y poderoso adversario, Shadow, un misterioso villano cuyos poderes no se parecen a nada de lo que nuestros héroes han conocido hasta ahora. Con sus facultades superadas en todos los sentidos, el Equipo Sonic tendrá que establecer una insólita alianza con la esperanza de detener a Shadow y proteger el planeta.	2025-10-26 21:19:04.202429	https://image.tmdb.org/t/p/w500/3aDWCRXLYOCuxjrjiPfLd79tcI6.jpg	t
156	El señor de los anillos: La comunidad del anillo	Aventura, Fantasía, Acción	2001	Peter Jackson	En la Tierra Media, el Señor Oscuro Saurón creó los Grandes Anillos de Poder, forjados por los herreros Elfos. Tres para los reyes Elfos, siete para los Señores Enanos, y nueve para los Hombres Mortales. Secretamente, Saurón también forjó un anillo maestro, el Anillo Único, que contiene en sí el poder para esclavizar a toda la Tierra Media. Con la ayuda de un grupo de amigos y de valientes aliados, Frodo emprende un peligroso viaje con la misión de destruir el Anillo Único. Pero el Señor Oscuro Sauron, quien creara el Anillo, envía a sus servidores para perseguir al grupo. Si Sauron lograra recuperar el Anillo, sería el final de la Tierra Media.	2025-10-26 21:19:04.329782	https://image.tmdb.org/t/p/w500/9xtH1RmAzQ0rrMBNUMXstb2s3er.jpg	t
157	La vecina perfecta	Documental, Suspense, Crimen	2025	Geeta Gandbhir	Un pequeño desacuerdo entre vecinos en Florida toma un giro letal, con grabaciones de las cámaras corporales de la policía y entrevistas que indagan en las consecuencias de las leyes estatales de "stand your ground".	2025-10-26 21:19:04.448639	https://image.tmdb.org/t/p/w500/2NE7yN45zo19o4LJr6JFxDWmh2b.jpg	t
158	Expediente Warren: The Conjuring	Terror, Suspense	2013	James Wan	Basada en una historia real documentada por los reputados demonólogos Ed y Lorraine Warren. Narra los encuentros sobrenaturales que vivió la familia Perron en su casa de Rhode Island a principios de los 70. El matrimonio Warren, investigadores de renombre en el mundo de los fenómenos paranormales, acudieron a la llamada de esta familia aterrorizada por la presencia en su granja de un ser maligno.	2025-10-26 21:19:04.562882	https://image.tmdb.org/t/p/w500/sKuHxkCogdk6YWzTyXYPoo9qd9n.jpg	t
159	Zootrópolis	Animación, Aventura, Familia, Comedia	2016	Byron Howard	La moderna metrópoli mamífera de Zootrópolis es una ciudad absolutamente única. Está compuesta de barrios con diferentes hábitats como la lujosa Plaza Sahara, el Distrito Selva Tropical y el gélido Distrito Tundra. Es un crisol donde los animales de cada entorno conviven, un lugar donde no importa lo que seas. De hecho puedes ser cualquier cosa, desde un elefante enorme hasta la musaraña más diminuta. Pero cuando llega la optimista agente Judy Hopps, descubre que ser la primera conejita de un cuerpo policial compuesto de animales duros y enormes no es nada fácil. Pero está decidida a demostrar su valía y se mete de cabeza en un caso, a pesar de que eso significa trabajar con Nick Wilde, un zorro parlanchín y estafador, para resolver el misterio.	2025-10-26 21:19:04.699306	https://image.tmdb.org/t/p/w500/i3WnZpJkQYXXbSGplEGmyoyeskM.jpg	t
160	Fast & Furious X	Acción, Crimen, Suspense, Aventura, Misterio	2023	Louis Leterrier	Durante numerosas misiones más que imposibles, Dom Toretto y su familia han sido capaces de ser más listos, de tener más valor y de ir más rápido que cualquier enemigo que se cruzara con ellos. Pero ahora tendrán que enfrentarse al oponente más letal que jamás hayan conocido: Un terrible peligro que resurge del pasado, que se mueve por una sangrienta sed de venganza y que está dispuesto a destrozar a la familia y destruir para siempre todo lo que a Dom le importa.	2025-10-26 21:19:04.836191	https://image.tmdb.org/t/p/w500/3P9QvWVN02Etn4kYGC702WVoXEb.jpg	t
161	Las crónicas de Narnia: El león, la bruja y el armario	Aventura, Familia, Fantasía	2005	Andrew Adamson	La historia narra las aventuras de cuatro hermanos: Lucy, Edmund, Susan y Peter, que durante la Segunda Guerra Mundial descubren el mundo de Narnia, al que acceden a través de un armario mágico mientras juegan al escondite en la casa de campo de un viejo profesor. En Narnia descubrirán un mundo increíble habitado por animales que hablan, duendes, faunos, centauros y gigantes al que la Bruja Blanca- Jadis- ha condenado al invierno eterno. Con la ayuda del león Aslan, el noble soberano, los niños lucharán para vencer el poder que la Bruja Blanca ejerce sobre Narnia en una espectacular batalla y conseguir así liberarle de la maldición del frío.	2025-10-26 21:19:04.968994	https://image.tmdb.org/t/p/w500/2Lv2wKf2YocOcRfzmvQYOUGRhFg.jpg	t
162	थामा	Comedia, Terror	2025	Aditya Sarpotdar	\N	2025-10-26 21:19:05.09005	https://image.tmdb.org/t/p/w500/d1SbIg1r1eowrCWsxHO6BJqQQwN.jpg	t
163	As Good As Dead. Ahora más peligroso	Acción, Crimen	2022	R. Ellis Frazier	Bryant (Michael Jai White), un hombre con un pasado misterioso, se muda a un pequeño pueblo fronterizo mexicano para empezar de nuevo y vivir una vida sencilla. Mientras está allí, se hace amigo de mala gana de un adolescente local con problemas que recientemente perdió a su madre y está siendo reclutado por la pandilla callejera local.	2025-10-26 21:19:05.220936	https://image.tmdb.org/t/p/w500/niTXgu5Ydz64KkanuPqkppfW5gI.jpg	t
164	El señor de los anillos: El retorno del rey	Aventura, Fantasía, Acción	2003	Peter Jackson	Las fuerzas de Saruman han sido destruidas, y su fortaleza sitiada. Ha llegado el momento de que se decida el destino de la Tierra Media, y por primera vez en mucho tiempo, parece que hay una pequeña esperanza. La atención del señor oscuro Sauron se centra ahora en Gondor, el último reducto de los hombres, y del cual Aragorn tendrá que reclamar el trono para ocupar su puesto de rey. Pero las fuerzas de Sauron ya se preparan para lanzar el último y definitivo ataque contra el reino de Gondor, la batalla que decidirá el destino de todos. Mientras tanto, Frodo y Sam continuan su camino hacia Mordor, a la espera de que Sauron no repare en que dos pequeños Hobbits se acercan cada día más al final de su camino, el Monte del Destino.	2025-10-26 21:19:05.344344	https://image.tmdb.org/t/p/w500/mWuFbQrXyLk2kMBKF9TUPtDwuPx.jpg	t
165	Piratas del Caribe: La maldición de la Perla Negra	Aventura, Fantasía, Acción	2003	Gore Verbinski	El aventurero capitán Jack Sparrow recorre las aguas caribeñas. Pero su andanzas terminan cuando su enemigo, el capitán Barbossa le roba su barco, la Perla Negra, y ataca la ciudad de Port Royal, secuestrando a Elizabeth Swann, hija del gobernador. Will Turner, el amigo de la infancia de Elizabeth, se une a Jack para rescatarla y recuperar la Perla Negra. Pero el prometido de Elizabeth, comodoro Norrington, les persigue a bordo del HMS Impávido. Además, Barbossa y su tripulación son víctimas de un conjuro por el que están condenados a vivir eternamente, y a transformarse cada noche en esqueletos vivientes, en fantasmas guerreros.	2025-10-26 21:19:05.472244	https://image.tmdb.org/t/p/w500/bVG48kmXuLaZYgPfSCmhs6EYFbX.jpg	t
166	Wicked	Drama, Romance, Fantasía	2024	Jon M. Chu	Ambientada en la Tierra de Oz, mucho antes de la llegada de Dorothy Gale desde Kansas. Elphaba es una joven incomprendida por su inusual color verde que aún no ha descubierto su verdadero poder. Glinda es una popular joven marcada por sus privilegios y su ambición que aún no ha descubierto su verdadera pasión. Las dos se conocen como estudiantes de la Universidad Shiz, en la fantástica Tierra de Oz, y forjan una insólita pero profunda amistad. La trama abarca los acontecimientos del primer acto del musical de Broadway.	2025-10-26 21:19:05.612387	https://image.tmdb.org/t/p/w500/hDQXqvmmikekQ15uxhisBDwEA63.jpg	t
167	El contable 2	Misterio, Crimen, Suspense	2025	Gavin O'Connor	Cuando un viejo conocido es asesinado, Wolff se ve obligado a resolver el caso. Al darse cuenta de que son necesarias medidas más extremas, Wolff recluta a su hermano Brax, distanciado y muy letal, para que le ayude. En colaboración con Marybeth Medina, descubren una conspiración mortal y se convierten en objetivo de una despiadada red de asesinos que no se detendrán ante nada para mantener sus secretos enterrados.	2025-10-26 21:19:05.734667	https://image.tmdb.org/t/p/w500/jcV9YfjBRo6occxqeWtEiyWwMoG.jpg	t
168	Don't Let's Go to the Dogs Tonight	Drama	2025	Embeth Davidtz	Bobo, una niña de 8 años, en la granja familiar de Rodesia durante la fase final de la Guerra de los Bosques. El vínculo de la familia con la tierra africana y el impacto de la guerra en la región a través de la perspectiva de Bobo.	2025-10-26 21:19:05.869199	https://image.tmdb.org/t/p/w500/5V59yYkVfqrhMIcKGdJZRxqWb3H.jpg	t
169	Venom: El último baile	Acción, Ciencia ficción, Aventura	2024	Kelly Marcel	Eddie y Venom están a la fuga. Perseguidos por sus sendos mundos y cada vez más cercados, el dúo se ve abocado a tomar una decisión devastadora que hará que caiga el telón sobre el último baile de Venom y Eddie.	2025-10-26 21:19:06.007853	https://image.tmdb.org/t/p/w500/8F74DwgFxTIBNtbqSLjR7zWmnHh.jpg	t
170	Ponte en mi lugar de nuevo	Comedia, Fantasía, Familia	2025	Nisha Ganatra	Años después de que Tess y Anna atravesaran una crisis de identidad, Anna ahora tiene una hija y una futura hijastra. Mientras enfrentan los innumerables desafíos que surgen cuando dos familias se fusionan, Tess y Anna descubren que el rayo puede caer dos veces.	2025-10-26 21:19:06.126295	https://image.tmdb.org/t/p/w500/3XFHVy03Rkr7ITaznFTeVp8dMwL.jpg	t
171	El jurado	Drama	2025	Samuel Theis	A sus cuarenta años, Fabio, va por la vida sin brújula. Empleado de un centro de reciclaje en Forbach, en Lorena, encuentra consuelo en el alcohol. Y un poco con Madeleine, una mujer madura con la que mantiene una relación en secreto. Un día, recibe una citación judicial para ser miembro del jurado que tendrá que decidir la vida de un joven pirómano, acusado de homicidio involuntario.	2025-10-26 21:19:06.25548	https://image.tmdb.org/t/p/w500/5v7multPqUOZR5NJtCOMqhFWCIv.jpg	t
172	Cincuenta sombras de Grey	Drama, Romance, Suspense	2015	Sam Taylor-Johnson	Cuando la estudiante de Literatura Anastasia Steele recibe el encargo de entrevistar al exitoso y joven empresario Christian Grey, queda impresionada al encontrarse ante un hombre atractivo, seductor y también muy intimidante. La inexperta e inocente Ana intenta olvidarle, pero pronto comprende cuánto le desea. Cuando la pareja por fin inicia una apasionada relación, Ana se sorprende por las peculiares prácticas eróticas de Grey, al tiempo que descubre los límites de sus propios y más oscuros deseos.	2025-10-26 21:19:06.380527	https://image.tmdb.org/t/p/w500/mNZcZOIlTwDKd30xLnRR4p0ZELg.jpg	t
173	Harry Potter y la cámara secreta	Aventura, Fantasía	2002	Chris Columbus	Harry regresa a su segundo año a Hogwarts, pero descubre que cosas malas ocurren debido a que un sitio llamado la Cámara de los Secretos ha sido abierto por el heredero de Slytherin y hará que los hijos de muggles, los impuros, aparezcan petrificados misteriosamente por un animal monstruoso.	2025-10-26 21:19:06.505581	https://image.tmdb.org/t/p/w500/3nvGqfZE3yrsqehpF107byUdUSq.jpg	t
174	Flow, un mundo que salvar	Animación, Aventura, Fantasía, Familia	2024	Gints Zilbalodis	En un mundo al borde del colapso, un gato solitario pierde su hogar por una inundación y encuentra refugio en un barco con otras especies. Juntos, deberán superar diferencias y desafíos mientras navegan por un misterioso paisaje sumergido.	2025-10-26 21:19:06.618905	https://image.tmdb.org/t/p/w500/337MqZW7xii2evUDVeaWXAtopff.jpg	t
175	TRON: Legacy	Aventura, Acción, Ciencia ficción	2010	Joseph Kosinski	Cuando Sam Flynn (Garrett Hedlund), programador experto en tecnología de 27 años e hijo de Kevin Flynn (Jeff Bridges), investiga la desaparición de su padre, se encuentra de repente inmerso en un peligroso y salvaje mundo surreal donde existen feroces luchas a muerte, un lugar paralelo donde su padre ha estado viviendo durante 25 años. Con la ayuda de una joven (Olivia Wilde), padre e hijo se embarcarán en un viaje a vida o muerte a través de un universo cibernético, que con el tiempo se ha convertido en mucho más avanzado y peligroso... Secuela del clásico de culto de 1982.	2025-10-26 21:19:06.732323	https://image.tmdb.org/t/p/w500/zHzW7Q2zQm7THqST610u2ckWtS7.jpg	t
176	Piratas del Caribe: El cofre del hombre muerto	Aventura, Fantasía, Acción	2006	Gore Verbinski	Will Turner y Elizabeth Swann se van a casar, pero ambos son hechos prisioneros por Lord Cutler Beckett y acusados de haber liberado al capitán Jack Sparrow. Para salvar su vida, Will tendrá que encontrar a Jack y conseguir su misteriosa brújula. Esta esconde un gran poder, además de la clave de una deuda de sangre del pirata con un temible y siniestro Davy Jones, el legendario capitán del barco fantasma Holandés Errante.	2025-10-26 21:19:06.867208	https://image.tmdb.org/t/p/w500/7L7H6sHAt48EfwsqFaa0dw2NJhz.jpg	t
177	Harry Potter y el cáliz de fuego	Aventura, Fantasía	2005	Mike Newell	En el cuarto año en Hogwarts, Harry se enfrenta al mayor de los desafíos y peligros de la saga. Cuando es elegido bajo misteriosas circunstancias como el competidor que representará a Hogwarts en el Torneo Triwizard, Harry deberá competir contra los mejores jóvenes magos de toda Europa. Pero mientras se prepara, aparecen pruebas que manifiestan que Lord Voldemort ha regresado. Antes de darse cuenta, Harry no solo estará luchando por el campeonato sino también por su vida	2025-10-26 21:19:06.99398	https://image.tmdb.org/t/p/w500/5hrrncgY7GfRHz6JmnhPlvJUONe.jpg	t
178	Guardianes de la Noche: Tren infinito	Animación, Acción, Fantasía, Suspense	2020	Haruo Sotozaki	Tanjiro y sus compañeros se unen al Pilar de las Llamas Kyojuro Rengoku para investigar una misteriosa serie de desapariciones que han ocurrido dentro del “Tren Infinito”. Poco saben que Enmu, uno de los miembros de las Doce Lunas Demoníacas, también está a bordo y les ha preparado una trampa.	2025-10-26 21:19:07.126292	https://image.tmdb.org/t/p/w500/8t29MfbEkEZixjVbjRkqI5NyFR4.jpg	t
179	Cuatro madres	Comedia, Drama	2025	Darren Thornton	Un novelista en apuros se ve obligado a cuidar de tres mujeres mayores excéntricas, y de su propia madre, en el transcurso de un caótico fin de semana en Dublín.	2025-10-26 21:19:07.236137	https://image.tmdb.org/t/p/w500/x4Clc08pw5UJEzK2fM6yy6HdrKr.jpg	t
180	It: Capítulo 2	Terror, Suspense	2019	Andy Muschietti	Han pasado casi 30 años desde que el "Club de los Perdedores", formado por Bill, Beverly, Richie, Ben, Eddie, Mike y Stanley, se enfrentaran al macabro y despiadado Pennywise (Bill Skarsgård). En cuanto tuvieron oportunidad, abandonaron el pueblo de Derry, en el estado de Maine, que tantos problemas les había ocasionado. Sin embargo, ahora, siendo adultos, parece que no pueden escapar de su pasado. Todos deberán enfrentarse de nuevo al temible payaso para descubrir si de verdad están preparados para superar sus traumas de la infancia.	2025-10-26 21:19:07.378565	https://image.tmdb.org/t/p/w500/9oERKIVyTWpHNum3STVsAGD4ojz.jpg	t
181	La conductora	Suspense, Acción, Comedia	2025	Shawn Simmons	La conductora, un irreverente thriller de ritmo frenético, cuenta la historia de una mujer que, en su adolescencia, fue conductora de huidas en coche y que en el presente se ve obligada a revivir su desagradable pasado cuando un antiguo jefe le brinda la oportunidad de salvar la vida de su exnovio, quien nunca ha sido de fiar. La conductora está escrita y dirigida por Shawn Simmons y protagonizada por Samara Weaving en el papel principal de Edie, también conocida como Eenie Meanie.	2025-10-26 21:19:07.491196	https://image.tmdb.org/t/p/w500/nDNvZhJeMSwi8UH8jbpZvLMUfjp.jpg	t
182	Oppenheimer	Drama, Historia	2023	Christopher Nolan	Película sobre el físico J. Robert Oppenheimer y su papel como desarrollador de la bomba atómica. Basada en el libro 'American Prometheus: The Triumph and Tragedy of J. Robert Oppenheimer' de Kai Bird y Martin J. Sherwin.	2025-10-26 21:19:07.619857	https://image.tmdb.org/t/p/w500/5t05uhX5ULn8Um2f1ZuznVvIffU.jpg	t
183	Robot salvaje	Animación, Ciencia ficción, Familia, Drama	2024	Chris Sanders	Esta aventura épica cuenta la historia de una robot, Rozzum 7-1-3-4, "Roz" para abreviar, que naufraga en una isla inhabitada y debe aprender a adaptarse a los entornos rigurosos construyendo relaciones con los animales de la isla y convirtiéndose en la madre adoptiva de una cría de ganso huérfana.	2025-10-26 21:19:07.736952	https://image.tmdb.org/t/p/w500/a0a7RC01aTa7pOnskgJb3mCD2Ba.jpg	t
184	Shrek	Animación, Comedia, Fantasía, Aventura, Familia	2001	Andrew Adamson	Hace mucho, mucho tiempo, en una lejanísima ciénaga vivía un intratable ogro llamado Shrek. Pero de repente, un día, su absoluta soledad se ve interrumpida por una invasión de sorprendentes personajes de cuento. Hay ratoncitos ciegos en su comida, un enorme y malísimo lobo en su cama, tres cerditos sin hogar y otros muchos seres increíbles que han sido deportados de su reino por el malvado Lord Farquaad. Para conseguir salvar su terreno, y de paso a sí mismo, Shrek hace un pacto con Farquaad y emprende viaje para conseguir que la preciosa princesa Fiona sea la novia del Lord. En tan importante misión le acompañan un burro chistoso, dispuesto a hacer cualquier cosa por Shrek. Todo, menos estarse calladito. Rescatar a la princesa de una dragona enamoradiza que suelta fuego al respirar va a resultar una tontería comparado con lo que ocurre cuando el oscuro secreto que la joven guardaba es revelado.	2025-10-26 21:19:07.860478	https://image.tmdb.org/t/p/w500/5G1RjHMSt7nYONqCqSwFlP87Ckk.jpg	t
185	El día que la Tierra explotó: Una película de los Looney Tunes	Familia, Comedia, Aventura, Animación, Ciencia ficción	2024	Peter Browngardt	Porky y el Pato Lucas regresan a la gran pantalla, junto con Petunia, en una nueva y emocionante aventura animada. En esta comedia de ciencia ficción, nuestros héroes improbables descubren un plan alienígena secreto para controlar las mentes y se convierten en la última esperanza de la Tierra.	2025-10-26 21:19:07.98043	https://image.tmdb.org/t/p/w500/thBHkIs4xLlNM3EEIM62vMvuSMj.jpg	t
186	Predator: Asesino de asesinos	Animación, Acción, Ciencia ficción, Suspense	2025	Dan Trachtenberg	Esta antología original de animación narra las aventuras de tres de los guerreros más fieros de la historia de la humanidad: una saqueadora vikinga que guía a su hijo en su sangrienta búsqueda de la venganza, un ninja del Japón feudal que se enfrenta a su hermano samurái en una brutal batalla por la sucesión y un piloto de la Segunda Guerra Mundial que surca los cielos para investigar una amenaza extraterrestre contra los Aliados.	2025-10-26 21:19:08.094661	https://image.tmdb.org/t/p/w500/8upWJ1KTR1bAPqXCHAuVOhfuiAZ.jpg	t
187	Diamanti	Comedia, Drama	2024	Ferzan Özpetek	Un director convoca a todas sus actrices favoritas para rodar una película ambientada en la Roma de los años 70, que explica las vicisitudes que giran en torno a una prestigiosa sastrería.	2025-10-26 21:19:08.211961	https://image.tmdb.org/t/p/w500/h5NmlaR7LDwlh9ROEucaElP7HNZ.jpg	t
188	Zootrópolis 2	Familia, Comedia, Aventura, Animación, Misterio	2025	Jared Bush	Judy y Nick se encuentran tras la retorcida pista de un misterioso reptil que llega a Zootopia y pone patas arriba la metrópolis de los mamíferos. Para resolver el caso, Judy y Nick deben ir de incógnito a nuevas partes inesperadas de la ciudad, donde su creciente asociación se pone a prueba como nunca antes.	2025-10-26 21:19:08.328929	https://image.tmdb.org/t/p/w500/l2YcvAeBxCyzYe2Qwo2LtjsUfPL.jpg	t
189	Smile 2	Terror, Misterio	2024	Parker Finn	La estrella del pop mundial Skye Riley está a punto de embarcarse en una nueva gira mundial cuando empieza a experimentar una serie de sucesos cada vez más aterradores e inexplicables. Angustiada por la espiral de horrores y la abrumadora presión de la fama, Skye tendrá que enfrentarse a su oscuro pasado para recuperar el control de su vida antes de que sea demasiado tarde. Secuela del exitoso film de terror 'Smile' (2022).	2025-10-26 21:19:08.446128	https://image.tmdb.org/t/p/w500/aQtWauWpy5KQEHsBURDnoTD6svd.jpg	t
190	捕风追影	Acción, Crimen, Suspense	2025	Larry Yang	\N	2025-10-26 21:19:08.563332	https://image.tmdb.org/t/p/w500/o25Tk1FYQi2BLk0OEAvx2h69QvB.jpg	t
191	Dune	Ciencia ficción, Aventura	2021	Denis Villeneuve	En un lejano futuro, la galaxia conocida es gobernada mediante un sistema feudal de casas nobles bajo el mandato del Emperador. Las alianzas y la política giran entorno a un pequeño planeta, Dune,  del que extrae la 'especia melange', la materia prima que permite los viajes espaciales. La Casa Atreides, bajo el mandato del Duque Leto Atreides recibe el encargo de custodiar el planeta, relevando en la encomienda a sus históricos enemigos, los Harkonnen. Paul Atreides, hijo del duque, se verá atrapado en las intrigas políticas mientras descubre el destino que le deparan los desiertos de Dune.	2025-10-26 21:19:08.692231	https://image.tmdb.org/t/p/w500/szcew6yyjcDvaL0isaPBk2e3nkF.jpg	t
192	The Monkey	Terror, Comedia	2025	Osgood Perkins	Cuando dos hermanos gemelos encuentran un misterioso mono de cuerda, una serie de muertes atroces separan a su familia. Veinticinco años después, el mono comienza una nueva matanza que obliga a los hermanos a enfrentarse al juguete maldito.	2025-10-26 21:19:08.812446	https://image.tmdb.org/t/p/w500/eEhZyX9s15RRjDZ358GNNQRBMWs.jpg	t
193	Bala perdida	Crimen, Suspense, Comedia	2025	Darren Aronofsky	Cuando su vecino punki Russ le pide que cuide de su gato durante unos días, Hank Thompson se encuentra atrapado en medio de un variopinto grupo de gángsters amenazantes. Todos quieren algo de él; el problema es que él no sabe por qué. Mientras Hank intenta eludir sus cada vez más estrechas garras, tendrá que emplear toda su habilidad para mantenerse con vida el tiempo suficiente para averiguarlo…	2025-10-26 21:19:08.938099	https://image.tmdb.org/t/p/w500/dpEGQKgOeDo9GmmKDnEWjTLTi4u.jpg	t
194	Spider-Man: No Way Home	Acción, Aventura, Ciencia ficción	2021	Jon Watts	Peter Parker es desenmascarado y por tanto no es capaz de separar su vida normal de los enormes riesgos que conlleva ser un súper héroe. Cuando pide ayuda a Doctor Strange, los riesgos pasan a ser aún más peligrosos, obligándole a descubrir lo que realmente significa ser Spider-Man.	2025-10-26 21:19:09.069288	https://image.tmdb.org/t/p/w500/miZFgV81xG324rpUknQX8dtXuBl.jpg	t
195	Kung Fu Panda 4	Animación, Familia, Acción, Comedia, Aventura, Fantasía	2024	Mike Mitchell	Po se prepara para ser el líder espiritual del Valle de la Paz, buscando un sucesor como Guerrero Dragón. Mientras entrena a un nuevo practicante de kung fu, enfrenta al villano llamado "el Camaleón", que evoca villanos del pasado, desafiando todo lo que Po y sus amigos han aprendido.	2025-10-26 21:19:09.246701	https://image.tmdb.org/t/p/w500/7JspmokDnpm8SEg28wtstfGps0K.jpg	t
196	El viaje de Chihiro	Animación, Familia, Fantasía	2001	Hayao Miyazaki	Durante el traslado de su familia a los suburbios, una niña de 10 años de edad deambula por un mundo gobernado por dioses, brujas y espíritus, y donde los humanos se convierten en bestias.	2025-10-26 21:19:09.377327	https://image.tmdb.org/t/p/w500/laXrmaTRuroArSPfsGlvTbeWxVA.jpg	t
197	Kraven the Hunter	Acción, Aventura, Suspense	2024	J.C. Chandor	Kraven, un hombre cuya compleja relación con su despiadado padre, Nikolai Kravinoff, le hace emprender un camino de venganza con brutales consecuencias, motivándole a convertirse no sólo en el mejor cazador del mundo, sino también en uno de los más temidos.	2025-10-26 21:19:09.495885	https://image.tmdb.org/t/p/w500/gabWTSVhzltlKkmcqPoJmjKJxyb.jpg	t
198	Regreso al futuro	Aventura, Comedia, Ciencia ficción	1985	Robert Zemeckis	El adolescente Marty McFly es amigo de Doc, un científico al que todos toman por loco. Cuando Doc crea una máquina para viajar en el tiempo, un error fortuito hace que Marty llegue a 1955, año en el que sus futuros padres aún no se habían conocido. Después de impedir su primer encuentro, deberá conseguir que se conozcan y se casen; de lo contrario, su existencia no sería posible.	2025-10-26 21:19:09.619686	https://image.tmdb.org/t/p/w500/owk40tn1sFJmC7bhamEpmhdZPKa.jpg	t
199	Kaiju No. 8: Misión de reconocimiento	Animación, Acción, Ciencia ficción	2025	Shigeyuki Miya	En un Japón repleto de Kaiju, Kafka Hibino trabaja como limpiador de monstruos. Tras reencontrarse con su amiga de la infancia, Mina Ashiro, una joven promesa de las Fuerzas de Defensa que luchan contra los Kaiju, decide intentar cumplir su antiguo sueño de unirse a las Fuerzas... cuando de repente se transforma en el poderoso Kaiju nº 8. Con la ayuda de un colega más joven, Reno Ichikawa, Kafka oculta su identidad mientras lucha por cumplir el sueño de su vida: aprobar el examen de las Fuerzas de Defensa y así poder estar al lado de Mina. Pero cuando un misterioso Kaiju inteligente ataca una base de las Fuerzas de Defensa, Kafka se enfrenta a una decisión crucial en una situación desesperada... Película recopilatoria que ofrece un resumen repleto de acción de la primera temporada y un nuevo episodio original, "El día libre de Hoshina".	2025-10-26 21:19:09.737032	https://image.tmdb.org/t/p/w500/okYOor2hdF7EFjxs2TxSzwGeKEQ.jpg	t
200	Cosecha sangrienta	Terror, Misterio, Suspense	2025	Eli Craig	Quinn y su padre acaban de mudarse a la tranquila ciudad de Kettle Springs con la esperanza de empezar de cero. En su lugar, descubre una comunidad fracturada que ha atravesado tiempos difíciles tras el incendio de la preciada fábrica de sirope de maíz Baypen. Mientras los lugareños discuten entre sí y las tensiones se desbordan, una figura siniestra y sonriente emerge de los campos de maíz para limpiar el pueblo de sus cargas, víctima sangrienta a víctima. La verdadera diversión comienza cuando el payaso Frendo sale a jugar.	2025-10-26 21:19:09.860613	https://image.tmdb.org/t/p/w500/19uOwurwq6DCPzdqtxThzGZoAVV.jpg	t
201	Frozen: El reino del hielo	Animación, Familia, Aventura, Fantasía	2013	Chris Buck	Cuando una profecía condena a un reino a un invierno eterno, Anna, una joven optimista se une a un temerario montañero llamado Kristoff y a su compinche el reno Sven. Juntos emprenden un viaje épico en busca de Elsa, hermana de Anna y reina de Las Nieves para poner fin al gélido hechizo.	2025-10-26 21:19:10.003804	https://image.tmdb.org/t/p/w500/hAKhrHvzQDUHQP5zd5HFeqF2BCN.jpg	t
202	Road House (De profesión: duro)	Acción, Suspense	2024	Doug Liman	Dalton es un exluchador de la UFC en horas bajas que acepta un trabajo como portero en un conflictivo bar de carretera de los Cayos de Florida, sólo para descubrir que este paraíso no es todo lo que parece... Remake de la película de 1989 con Patrick Swayze.	2025-10-26 21:19:10.131526	https://image.tmdb.org/t/p/w500/n5af068Xoa2feazpY5MP3xcW5Mj.jpg	t
203	Red One	Acción, Comedia, Fantasía	2024	Jake Kasdan	Tras el secuestro de Papá Noel (nombre en clave: RED ONE), el Jefe de Seguridad del Polo Norte (Dwayne Johnson) debe formar equipo con el cazarrecompensas más infame del mundo (Chris Evans) en una misión trotamundos llena de acción para salvar la Navidad.	2025-10-26 21:19:10.262658	https://image.tmdb.org/t/p/w500/dpskAcm71w5v8zQ8RmPmJiP31Om.jpg	t
204	Osiris	Ciencia ficción, Acción, Terror	2025	William Kaufman	Un equipo de comandos de las Fuerzas Especiales es abducido por una misteriosa nave espacial durante una operación militar. Al despertar, los soldados desconocen su paradero y pronto descubren que están prisioneros de una despiadada raza alienígena, lo que desencadena una frenética lucha por su supervivencia.	2025-10-26 21:19:10.372032	https://image.tmdb.org/t/p/w500/3YtZHtXPNG5AleisgEatEfZOT2w.jpg	t
205	Terrifier 3	Terror, Suspense	2024	Damien Leone	El payaso Art desata el caos entre los desprevenidos habitantes del condado de Miles mientras duermen plácidamente en Nochebuena. Tras sobrevivir a la masacre de Halloween perpetrada por el peor asesino en serie desde Jack el Destripador, Sienna y su hermano se esfuerzan por reconstruir sus vidas destrozadas. A medida que se acercan las fiestas de Navidad, intentan abrazar el espíritu navideño y dejar atrás los horrores del pasado. Pero justo cuando creen que están a salvo, el payaso Art regresa, decidido a convertir su alegría navideña en una nueva pesadilla. La temporada festiva se desmorona rápidamente mientras el payaso Art desata su retorcido terror marca de la casa, demostrando que ninguna festividad es segura.	2025-10-26 21:19:10.509985	https://image.tmdb.org/t/p/w500/iaGfB2itLC8exBvfLUoadS0Q6tP.jpg	t
206	I.S.S.	Ciencia ficción, Suspense	2024	Gabriela Cowperthwaite	Cuando se produce un acontecimiento bélico mundial en la Tierra, Estados Unidos y Rusia, ambas naciones contactan en secreto con sus astronautas a bordo de la ISS y les dan instrucciones para que tomen el control de la estación por cualquier medio necesario.	2025-10-26 21:19:10.702321	https://image.tmdb.org/t/p/w500/2ZgXNi458jc7DqdAMhsHpF1sX0I.jpg	t
207	Anora	Drama, Comedia, Romance	2024	Sean Baker	Anora, una joven prostituta de Brooklyn, tiene la oportunidad de vivir una historia de Cenicienta cuando conoce e impulsivamente se casa con el hijo de un oligarca. Cuando la noticia llega a Rusia, su cuento de hadas se ve amenazado, ya que los padres parten hacia Nueva York para intentar conseguir la anulación del matrimonio.	2025-10-26 21:19:10.838242	https://image.tmdb.org/t/p/w500/n5wEFSLkm2fCtN0FVAuphrCAjf8.jpg	t
208	Plan en familia	Acción, Comedia, Familia	2023	Simon Cellan Jones	Dan Morgan es muchas cosas: un marido devoto, un padre cariñoso, un reputado vendedor de coches. También es un exasesino. Y, cuando su pasado alcanza su presente, se ve obligado a embarcar a su ingenua familia en un viaje por carretera sin igual.	2025-10-26 21:19:10.96358	https://image.tmdb.org/t/p/w500/7mEX07jWRYrjarW84sBeFghGMfa.jpg	t
209	La acompañante	Terror, Ciencia ficción, Suspense	2025	Drew Hancock	La muerte de un multimillonario desencadena una serie de acontecimientos para Iris y sus amigos durante un viaje de fin de semana a su finca junto al lago.	2025-10-26 21:19:11.081423	https://image.tmdb.org/t/p/w500/nyloao2GWttUvS7KVcEM2eSDwUn.jpg	t
210	Gatillero	Suspense, Acción	2025	Cristian Tapia Marchiori	Una cruda historia de tragedia y redención, contada a través de un único plano continuo. Rodada en la verdadera Isla Maciel, en las afueras de Buenos Aires, Argentina.	2025-10-26 21:19:11.203282	https://image.tmdb.org/t/p/w500/moiLQPK2YjritOYG674DrWHvlgp.jpg	t
211	Harry Potter y el prisionero de Azkaban	Aventura, Fantasía	2004	Alfonso Cuarón	Harry está deseando que termine el verano para comenzar un nuevo curso en Hogwarts, y abandonar lo antes posible la casa de sus despreciables tíos, los Dursley. Lo que desconoce Harry es que va a tener que abandonar Privet Drive antes de tiempo e inesperadamente después de convertir a su tía Marge en un globo gigante. Un autobús noctámbulo, y encantado por supuesto, le llevará a la taberna El Caldero Chorreante, donde le espera nada menos que Cornelius Fudge, el Ministro de Magia.	2025-10-26 21:19:11.337672	https://image.tmdb.org/t/p/w500/wF9aoo4YZmpKP4bZPSy4Zwwek6G.jpg	t
212	Piratas del Caribe: En mareas misteriosas	Aventura, Acción, Fantasía	2011	Rob Marshall	Cuando Jack Sparrow vuelve a encontrarse con una mujer a la que había conocido años atrás, no está seguro de si se trata de amor o si ella es una estafadora sin escrúpulos que lo está utilizando para encontrar la legendaria Fuente de la Juventud. A todo esto, Jack es capturado por el Venganza de la Reina Ana, el barco del temible pirata Barbanegra, que lo obliga a unirse a su tripulación, lo que le hará vivir una inesperada aventura en la que no sabe quién le inspira más miedo si Barbanegra o esa mujer que regresa del pasado.	2025-10-26 21:19:11.452453	https://image.tmdb.org/t/p/w500/2oOARbiV871kCC27FyKBmYwOM3G.jpg	t
213	Alien: Romulus	Terror, Ciencia ficción	2024	Fede Álvarez	Mientras rebuscan en las profundidades de una estación espacial abandonada, un grupo de jóvenes colonizadores del espacio se encuentra cara a cara con la forma de vida más aterradora del universo. Nueva película de la saga Alien.	2025-10-26 21:19:11.565164	https://image.tmdb.org/t/p/w500/8PYqGSd8MOm5ce8io4qNSAiSExW.jpg	t
214	Дур тачаалын эрэлд	Romance, Drama	2025	Batdelger Byambasuren	\N	2025-10-26 21:19:11.678396	https://image.tmdb.org/t/p/w500/k9FAjid8aV3oq0VJmHdaW0OaQoi.jpg	t
215	El escuadrón suicida	Acción, Comedia, Aventura	2021	James Gunn	Un grupo de super villanos se encuentran encerrados en Belle Reve, una prisión de alta seguridad con la tasa de mortalidad más alta de Estados Unidos. Para salir de allí harán cualquier cosa, incluso unirse al grupo Task Force X, dedicado a llevar a cabo misiones suicidas bajo las órdenes de Amanda Waller. Fuertemente armados son enviados a la isla Corto Maltese, una jungla repleta de enemigos.	2025-10-26 21:19:11.788463	https://image.tmdb.org/t/p/w500/fPJWlhXA2VXf4MlQ3JenVsz1iba.jpg	t
216	Bugonia	Comedia, Ciencia ficción, Suspense	2025	Giórgos Lánthimos	Un joven captura e interroga a un hombre de negocios que cree que es un invasor alienígena. El captor, su novia, el empresario y un detective privado se enzarzan en una tensa batalla psicológica. Remake del film coreano "Save the Green Planet".	2025-10-26 21:19:11.918632	https://image.tmdb.org/t/p/w500/2C5Vf9VcoXB7SFFcG8vppW5bmtX.jpg	t
217	Toy Story	Familia, Comedia, Animación, Aventura	1995	John Lasseter	Los juguetes de Andy, un niño de seis años, temen que haya llegado su hora y que un nuevo regalo de cumpleaños les sustituya en el corazón de su dueño. Woody, un vaquero que ha sido hasta ahora el juguete favorito de Andy, trata de tranquilizarlos hasta que aparece Buzz Lightyear, un héroe espacial dotado de todo tipo de avances tecnológicos. Woody es relegado a un segundo plano, pero su constante rivalidad se transformará en una gran amistad cuando ambos se pierden en la ciudad sin saber cómo volver a casa.	2025-10-26 21:19:12.048937	https://image.tmdb.org/t/p/w500/y59d8PjuFSgJJN4VRS7jDoRgSM9.jpg	t
218	Forrest Gump	Comedia, Drama, Romance	1994	Robert Zemeckis	Forrest Gump es un chico con deficiencias mentales no muy profundas y con alguna incapacidad motora que, a pesar de todo, llegará a convertirse, entre otras cosas, en un héroe durante la Guerra del Vietnam. Su persistencia y bondad le llevarán a conseguir una gran fortuna, ser objeto del clamor popular y a codearse con las más altas esferas sociales y políticas del país. Siempre sin olvidar a Jenny, su gran amor desde que era niño.	2025-10-26 21:19:12.186962	https://image.tmdb.org/t/p/w500/oiqKEhEfxl9knzWXvWecJKN3aj6.jpg	t
219	East of Wall	Drama, Western	2025	Kate Beecroft	Tras la muerte de su esposo, Tabatha, una joven entrenadora de caballos, lucha contra la inseguridad financiera y un dolor sin resolver mientras brinda refugio a unos adolescentes descarriados en su rancho en ruinas en las Tierras Baldías.	2025-10-26 21:19:12.307348	https://image.tmdb.org/t/p/w500/1OsdhvbLNLUJEi9vqQCyhAXsaRX.jpg	t
220	Capitán América: Brave New World	Acción, Suspense, Ciencia ficción	2025	Julius Onah	Tras reunirse con el recién elegido presidente de los EE. UU., Thaddeus Ross, Sam se encuentra en medio de un incidente internacional. Debe descubrir el motivo que se esconde tras un perverso complot global, antes de que su verdadero artífice enfurezca al mundo entero.	2025-10-26 21:19:12.455511	https://image.tmdb.org/t/p/w500/vUNj55xlF0pSU5FU3yDHC6L5wVX.jpg	t
221	Crepúsculo	Fantasía, Drama, Romance	2008	Catherine Hardwicke	La joven Bella Swan siempre fue una chica muy diferente ya en sus años de niña en Phoenix. Cuando su madre se volvió a casar, la mandó a vivir con su padre, a la pequeña y lluviosa ciudad de Forks, Washington, una población sin ningún aliciente para Bella. Pero entonces conoce en el instituo al misterioso y atractivo Edward Cullen, un joven distinto a los demás que esconde un secreto...	2025-10-26 21:19:12.592663	https://image.tmdb.org/t/p/w500/40ollvfwHaVF85lkkg522SIl3Qc.jpg	t
222	Diecinueve	Drama	2025	Giovanni Tortorici	Un estudiante curioso se embarca en un viaje de autodescubrimiento, aprendiendo que el camino, por desconocido o desalentador que sea, merece la pena.	2025-10-26 21:19:12.70951	https://image.tmdb.org/t/p/w500/kgtm27BC45KxVD7yJKzIRMjlo6x.jpg	t
223	La noche de Halloween	Terror, Suspense	1978	John Carpenter	Durante la noche de Halloween, Michael, un niño de seis años, asesina a su familia con un cuchillo de cocina. Es internado en un psiquiátrico del que huye quince años más tarde, precisamente la víspera de Halloween. El psicópata vuelve a su pueblo y comete una serie de asesinatos. Mientras, uno de los médicos del psiquiátrico le sigue la pista.	2025-10-26 21:19:12.829044	https://image.tmdb.org/t/p/w500/6bsDpDL312h6vEGPOPWoweaZWUG.jpg	t
224	Avatar: Fuego y ceniza	Ciencia ficción, Aventura, Fantasía	2025	James Cameron	Jake Sully y Neytiri enfrentan una nueva amenaza en Pandora: los Ash People, una tribu Na'vi violenta y sedienta de poder, liderada por la implacable Varang. Tras la devastadora guerra contra la RDA y la pérdida de su hijo mayor, la familia de Jake deberá luchar por su supervivencia y el futuro de Pandora en un conflicto que llevará a los personajes a sus límites emocionales y físicos. Con nuevos y antiguos aliados, esta épica visual y emocional redefine el destino de un mundo al borde del abismo.	2025-10-26 21:19:12.954174	https://image.tmdb.org/t/p/w500/4n1U0Mwn7djux6VKNYDRWPgS2x6.jpg	t
225	Spider-Man: Homecoming	Acción, Aventura, Ciencia ficción	2017	Jon Watts	Peter Parker comienza a experimentar su recién descubierta identidad como el superhéroe Spider-Man. Después de la experiencia vivida con los Vengadores, Peter regresa a casa, donde vive con su tía. Bajo la atenta mirada de su mentor Tony Stark, Peter intenta mantener una vida normal como cualquier joven de su edad, pero interrumpe en su rutina diaria el nuevo villano Vulture y, con él, lo más importante de la vida de Peter comenzará a verse amenazado.	2025-10-26 21:19:13.103285	https://image.tmdb.org/t/p/w500/yJfPC6pjSJ5VOsVyXhx5PXBe0mR.jpg	t
226	Matrix	Acción, Ciencia ficción	1999	Lana Wachowski	Thomas Anderson lleva una doble vida: por el día es programador en una importante empresa de software, y por la noche un hacker informático llamado Neo. Su vida no volverá a ser igual cuando unos misteriosos personajes le inviten a descubrir la respuesta a la pregunta que no le deja dormir: ¿qué es Matrix?	2025-10-26 21:19:13.231251	https://image.tmdb.org/t/p/w500/plYYSxZ9Wdq4thyVSkhJjbjYtVG.jpg	t
227	Del cielo al infierno	Suspense, Crimen, Drama	2025	Spike Lee	Cuando un poderoso empresario musical es víctima de una extorsión, se ve obligado a luchar por su familia y su legado mientras afronta un dilema ético vital.	2025-10-26 21:19:13.361362	https://image.tmdb.org/t/p/w500/b0AQYSM09AYVRKLZr6jIAP2xNq9.jpg	t
228	Los Increíbles 2	Acción, Aventura, Animación, Familia	2018	Brad Bird	Helen tiene que liderar una campaña para que los superhéroes regresen, mientras Bob vive su vida 'normal' con Violet, Dash y el bebé Jack-Jack —cuyos superpoderes descubriremos—. Su misión se va a pique cuando aparece un nuevo villano con un brillante plan que lo amenaza todo. Pero los Parr no se amedrentarán y menos teniendo a Frozone de su parte.	2025-10-26 21:19:13.495121	https://image.tmdb.org/t/p/w500/bJjc0217DuipdwJ0wyi3I4j6soR.jpg	t
229	It (Eso)	Terror, Suspense	2017	Andy Muschietti	Remake del clásico de Stephen King en el que un payaso aterroriza a los niños de un vecindario. En un pequeño pueblo de Maine, siete niños conocidos como el Club de los Perdedores se encuentran cara a cara con problemas de la vida, matones y un monstruo que toma la forma de un payaso llamado Pennywise.	2025-10-26 21:19:13.611707	https://image.tmdb.org/t/p/w500/sSrj4lnhrb113DOPEPTaO2jaDk3.jpg	t
230	Cholo Zombies	Terror, Comedia	2024	Eric Rafael Ibarra	\N	2025-10-26 21:19:13.731014	https://image.tmdb.org/t/p/w500/hvZ4maBvXuen1wTEXFx7zzMpQ3u.jpg	t
231	El lobo de Wall Street	Crimen, Drama, Comedia	2013	Martin Scorsese	Película basada en hechos reales del corredor de bolsa neoyorquino Jordan Belfort. A mediados de los años 80, Belfort era un joven honrado que perseguía el sueño americano, pero pronto en la agencia de valores aprendió que lo más importante no era hacer ganar a sus clientes, sino ser ambicioso y ganar una buena comisión. Su enorme éxito y fortuna le valió el mote de "El lobo de Wall Street". Dinero. Poder. Mujeres. Drogas. Las tentaciones abundaban y el temor a la ley era irrelevante. Jordan y su manada de lobos consideraban que la discreción era una cualidad anticuada; nunca se conformaban con lo que tenían.	2025-10-26 21:19:13.885965	https://image.tmdb.org/t/p/w500/uthRoUeTtiep5HCoySlOjQSPCbJ.jpg	t
232	El Club de la Lucha	Drama, Suspense	1999	David Fincher	Un joven sin ilusiones lucha contra su insomnio, consecuencia quizás de su hastío por su gris y rutinaria vida. En un viaje en avión conoce a Tyler Durden, un carismático vendedor de jabón que sostiene una filosofía muy particular: el perfeccionismo es cosa de gentes débiles; en cambio, la autodestrucción es lo único que hace que realmente la vida merezca la pena. Ambos deciden entonces formar un club secreto de lucha donde descargar sus frustaciones y su ira que tendrá un éxito arrollador.	2025-10-26 21:19:14.009121	https://image.tmdb.org/t/p/w500/sgTAWJFaB2kBvdQxRGabYFiQqEK.jpg	t
233	Mufasa: El rey león	Aventura, Familia, Animación	2024	Barry Jenkins	Rafiki debe transmitir la leyenda de Mufasa a la joven cachorro de león Kiara, hija de Simba y Nala, y con Timón y Pumba prestando su estilo característico. Mufasa, un cachorro huérfano, perdido y solo, conoce a un simpático león llamado Taka, heredero de un linaje real. Este encuentro casual pone en marcha un viaje de un extraordinario grupo de inadaptados que buscan su destino.	2025-10-26 21:19:14.13236	https://image.tmdb.org/t/p/w500/dmw74cWIEKaEgl5Dv3kUTcCob6D.jpg	t
234	Enfermera para todo	Comedia	1979	Mariano Laurenti	Una atractiva enfermera de noche es contratada para cuidar de un aventurero que se hace pasar por un paciente enfermo, que acaba de llegar de una expedición en África. El impostor está buscando en realidad un enorme diamante escondido en la casa, pero se da cuenta de que no hay un solo momento de paz, no solo por la compañía de su provocativa enfermera, sino por el resto de los admiradores que ésta empieza a tener merodeando por la casa.	2025-10-26 21:19:14.250438	https://image.tmdb.org/t/p/w500/yC76c09asXP1p1JGAJ93xMznodO.jpg	t
235	Parásitos	Comedia, Suspense, Drama	2019	Bong Joon-ho	Tanto Gi Taek (Song Kang-ho) como su familia están sin trabajo. Cuando su hijo mayor, Gi Woo (Choi Woo-sik), empieza a dar clases particulares en casa de Park (Lee Seon-gyun), las dos familias, que tienen mucho en común pese a pertenecer a dos mundos totalmente distintos, comienzan una interrelación de resultados imprevisibles.	2025-10-26 21:19:14.378968	https://image.tmdb.org/t/p/w500/4N55tgxDW0RRATyrZHbx0q9HUKv.jpg	t
236	Blancanieves	Familia, Fantasía	2025	Marc Webb	Tras la desaparición del benévolo Rey, la Reina Malvada dominó la otrora bella tierra con una vena cruel. La princesa Blancanieves huye del castillo cuando la Reina, celosa de su belleza interior, intenta matarla. En lo profundo del oscuro bosque, se topa con siete enanos mágicos y un joven bandido llamado Jonathan. Juntos, luchan por sobrevivir a la implacable persecución de la Reina y aspiran a recuperar el reino en el proceso.	2025-10-26 21:22:50.805585	https://image.tmdb.org/t/p/w500/sm91FNDF6OOKU4hT9BDW6EMoyDB.jpg	t
237	Barbie	Comedia, Aventura	2023	Greta Gerwig	Barbie vive en Barbieland donde todo es ideal y lleno de música y color. Un buen día decide conocer el mundo real. Cuando el CEO de Mattel se entere, tratará de evitarlo a toda costa y devolver a Barbie a una caja.	2025-10-26 21:22:50.958637	https://image.tmdb.org/t/p/w500/fNtqD4BTFj0Bgo9lyoAtmNFzxHN.jpg	t
238	Vera y el placer de los otros	Comedia, Drama	2024	Federico Actis	Vera, una adolescente de 17 años, reparte sus días entre el vóley, la escuela y un pasatiempo secreto: subalquilar por un par de horas un departamento vacío con bolsas de dormir para que otros adolescentes tengan sexo.	2025-10-26 21:22:51.071691	https://image.tmdb.org/t/p/w500/6i68SQFNy97wDiYpEJyKmlkYqC1.jpg	t
239	Perdida	Misterio, Suspense, Drama	2014	David Fincher	El día de su quinto aniversario de boda, Nick Dunne informa de que su esposa Amy ha desaparecido misteriosamente. Pronto la presión policial y mediática hace que el retrato de felicidad doméstica que ofrece Nick empiece a tambalearse. Además, su extraña conducta lo convierte en sospechoso, y todo el mundo comienza a preguntase si Nick mató a su esposa...	2025-10-26 21:22:51.228333	https://image.tmdb.org/t/p/w500/bkIhygnbv9ydlDo4SEsOcqGgQD4.jpg	t
240	Materialistas	Romance, Drama	2025	Celine Song	Lucy es una joven casamentera de Nueva York que se encarga de unir solteros para encontrar la pareja perfecta. Sin embargo, su mundo se desestabiliza al encontrarse atrapada en un triángulo amoroso con Harry, un apuesto financiero multimillonario, y su exnovio John, un actor de poco éxito.	2025-10-26 21:22:51.346728	https://image.tmdb.org/t/p/w500/u15ytqp6QmHymVVw1xxdodZ5N02.jpg	t
241	El mapa que me lleva a ti	Romance, Drama	2025	Lasse Hallström	Heather es una joven que emprende una aventura por Europa con sus mejores amigos antes de instalarse en su vida perfectamente planificada. Cuando se cruza en su camino Jack, un desconocido magnético y misterioso, su chispa instantánea enciende un viaje emocional que ninguno de los dos esperaba. A medida que su conexión se profundiza, los secretos, las decisiones vitales y las verdades ocultas pondrán a prueba su vínculo y cambiarán su vida de una forma que nunca imaginó.	2025-10-26 21:22:51.456353	https://image.tmdb.org/t/p/w500/8gzmyWZX6C29aKNLr5ol17n03nN.jpg	t
242	Cincuenta sombras liberadas	Drama, Romance	2018	James Foley	Creyendo que han dejado atrás las sombras del pasado, Christian y Anastasia disfrutan de su relación y de su vida llena de lujos. Pero justo cuando Ana empieza a relajarse, aparecen nuevas amenazas que ponen en riesgo su felicidad.	2025-10-26 21:22:51.57418	https://image.tmdb.org/t/p/w500/sM8hwgWZlmZf0h4aOkNopb3HBIo.jpg	t
243	Gypsy Moon	Fantasía, Suspense	2024	Tony Gibson	\N	2025-10-26 21:22:51.671579	https://image.tmdb.org/t/p/w500/vtQJ6ZvfOHAHWqgWRp58LlKGEEp.jpg	t
244	Scary Movie	Comedia	2000	Keenen Ivory Wayans	Tras el asesinato de una bella estudiante, un grupo de adolescentes descubren que hay un asesino entre ellas. La heroína, Cindy, y su grupo de desconcertantes amigos, serán aterrorizados por un singular psicópata enmascarado que pretende vengarse de ellos por haberlo atropellado el pasado Halloween.	2025-10-26 21:22:51.79755	https://image.tmdb.org/t/p/w500/kfAiQqJGnfbQj52Bna7Ohlu04y3.jpg	t
245	Seven	Crimen, Misterio, Suspense	1995	David Fincher	El teniente Somerset, del departamento de homicidios, está a punto de jubilarse y ser reemplazado por el ambicioso y brillante detective David Mills. Ambos tendrán que colaborar en la resolución de una serie de asesinatos cometidos por un psicópata que toma como base la relación de los siete pecados capitales: gula, pereza, soberbia, avaricia, envidia, lujuria e ira. Los cuerpos de las víctimas, sobre los que el asesino se ensaña de manera impúdica, se convertirán para los policías en un enigma que les obligará a viajar al horror y la barbarie más absoluta.	2025-10-26 21:22:51.921402	https://image.tmdb.org/t/p/w500/uVPcVz4b2hnSGrXYLdIGRXwcivs.jpg	t
246	Avengement	Crimen, Acción	2019	Jesse V. Johnson	Mientras disfruta de un permiso, un convicto logra escapar de la justicia con el objetivo de dar caza a los responsables de que se convirtiese en un asesino a sangre fría. Su batalla es tan física como espiritual, pues busca redimir su alma de todos los años que invirtió manchando de sangre una ciudad fría y austera.	2025-10-26 21:22:52.042583	https://image.tmdb.org/t/p/w500/rXPxSAYf3FdQktnOtQnvhUPMhFp.jpg	t
247	Expediente Warren: Obligado por el demonio	Terror, Misterio, Suspense	2021	Michael Chaves	Los investigadores paranormales Ed y Lorraine Warren se encuentran con lo que se convertiría en uno de los casos más sensacionales de sus archivos. La lucha por el alma de un niño los lleva más allá de todo lo que habían visto antes, para marcar la primera vez en la historia de los Estados Unidos que un sospechoso de asesinato reclamaría posesión demoníaca como defensa.	2025-10-26 21:22:52.188131	https://image.tmdb.org/t/p/w500/ghMQALCyytc6W0wlOlMIKiMSRKV.jpg	t
248	Amateur	Suspense, Acción	2025	James Hawes	Charlie Heller es un brillante pero introvertido decodificador de la CIA que trabaja en una oficina en el sótano de la sede de Langley. Su vida cambia radicalmente cuando su esposa muere en un ataque terrorista en Londres. Cuando sus supervisores se niegan a tomar cartas en el asunto, él mismo toma las riendas y se embarca en un peligroso viaje por todo el mundo para localizar a los responsables. Su inteligencia puede ser el arma definitiva para llevar a cabo su venganza.	2025-10-26 21:22:52.347606	https://image.tmdb.org/t/p/w500/9WPWF0AmklsKclrXeyKXbQ543ZA.jpg	t
249	Springsteen: Deliver Me from Nowhere	Drama, Música	2025	Scott Cooper	Sigue a Springsteen cuando era un joven músico en los albores de la fama mundial, tratando de reconciliar las presiones del éxito con los fantasmas de su pasado. Grabado en un viejo casete de cuatro pistas en su habitación en Nueva Jersey, Nebraska refleja un periodo trascendental de su vida y está lleno de personajes perdidos en busca de una razón para creer.	2025-10-26 21:22:52.459691	https://image.tmdb.org/t/p/w500/e5Gl93objIeRZp2V52kd0wNB9qR.jpg	t
267	Trust	Suspense	2025	Carlson Young	Tras un escándalo, una estrella de Hollywood se retira a una remota cabaña, pero no está sola. Traicionada por el hombre en quien más confiaba, se ve atrapada en un brutal juego de supervivencia. Puede esconderse, pero no puede huir.	2025-10-26 21:22:54.822454	https://image.tmdb.org/t/p/w500/yRzhyCIimncbPfD6h9QwP4xbhzc.jpg	t
250	El Padrino Parte II	Drama, Crimen	1974	Francis Ford Coppola	Continuación de la saga de los Corleone con dos historias paralelas: la elección de Michael Corleone como jefe de los negocios familiares y los orígenes del patriarca, el ya fallecido Don Vito, primero en Sicilia y luego en Estados Unidos, donde, empezando desde abajo, llegó a ser un poderosísimo jefe de la mafia de Nueva York.	2025-10-26 21:22:52.575447	https://image.tmdb.org/t/p/w500/mbry0W5PRylSUHsYzdiY2FSJwze.jpg	t
251	정사 : 착한 며느리들 3	Romance	2019	Lee Min-woo	\N	2025-10-26 21:22:52.697797	https://image.tmdb.org/t/p/w500/vMkZ311wQLXsICzjcAqVQivqDKs.jpg	t
252	Dune: Parte dos	Ciencia ficción, Aventura	2024	Denis Villeneuve	Sigue el viaje mítico de Paul Atreides mientras se une a Chani y los Fremen en una guerra de venganza contra los conspiradores que destruyeron a su familia. Al enfrentarse a una elección entre el amor de su vida y el destino del universo conocido, Paul se esfuerza por evitar un futuro terrible que solo él puede prever.	2025-10-26 21:22:52.817205	https://image.tmdb.org/t/p/w500/xCHmhHeO7aOCMlzcNukGH6Q7EiD.jpg	t
253	French Lover	Romance, Comedia	2025	Lisa-Nina Rives	Un actor hastiado conoce a una camarera con mala suerte en París. ¿Podrá sobrevivir esta historia de amor inesperada al destello de los focos?	2025-10-26 21:22:52.958412	https://image.tmdb.org/t/p/w500/s91yhwxBwDPfLUM7qTlJKzxzrV4.jpg	t
254	Top Gun: Maverick	Acción, Drama	2022	Joseph Kosinski	Después de más de 30 años de servicio como uno de los mejores aviadores de la Armada, Pete "Maverick" Mitchell se encuentra dónde siempre quiso estar, empujando los límites como un valiente piloto de prueba y esquivando el alcance en su rango, que no le dejaría volar emplazándolo en tierra. Cuando se encuentra entrenando a un destacamento de graduados de Top Gun para una misión especializada, Maverick se encuentra allí con el teniente Bradley Bradshaw, el hijo de su difunto amigo "Goose".	2025-10-26 21:22:53.128146	https://image.tmdb.org/t/p/w500/AlWpEpQq0RgZIXVHAHZtFhEvRgd.jpg	t
255	Iron Man 2	Aventura, Acción, Ciencia ficción	2010	Jon Favreau	El mundo sabe que el multimillonario Tony Stark es Iron Man, el superhéroe enmascarado. Sometido a presiones por parte del gobierno, la prensa y la opinión pública para que comparta su tecnología con el ejército, Tony es reacio a desvelar los secretos de la armadura de Iron Man porque teme que esa información pueda caer en manos indeseables.	2025-10-26 21:22:53.267602	https://image.tmdb.org/t/p/w500/ayyJVOV5I4MGjti7nIHC3mVCagR.jpg	t
256	Beekeeper: El protector	Acción, Crimen, Suspense	2024	David Ayer	La brutal campaña de venganza de Adam Clay adquiere tintes nacionales tras revelarse que es un antiguo agente de una poderosa organización clandestina conocida como "Beekeeper".	2025-10-26 21:22:53.392776	https://image.tmdb.org/t/p/w500/gBdhYoROX6SHE3vVnBfEHI7Ojma.jpg	t
257	La última obra	Terror, Misterio, Suspense	2025	Mark Anthony Green	Una joven escritora es invitada al remoto complejo de una legendaria estrella del pop que desapareció misteriosamente hace 30 años.	2025-10-26 21:22:53.51481	https://image.tmdb.org/t/p/w500/5KPh4GB1Vng9g9QOhvXCTtMAEc.jpg	t
258	角頭－鬥陣欸	Crimen, Acción	2025	Jui-Chih Chiang	\N	2025-10-26 21:22:53.639917	https://image.tmdb.org/t/p/w500/eoUcppppVNj8BkgBDkZTv82x3tx.jpg	t
259	El tiempo que nos queda	Drama, Romance, Fantasía	2025	Adolfo Alix Jr.	Tras una serie de muertes, una mujer mayor rememora su romance con un amante misterioso y atemporal mientras un inspector está cada vez más cerca de descubrir su oscuro secreto.	2025-10-26 21:22:53.771748	https://image.tmdb.org/t/p/w500/vuACwlwsDzsm55QFkN2fmFcx8y3.jpg	t
260	Todos te quieren cuando has muerto	Suspense, Crimen, Drama	2025	นิธิวัฒน์ ธราธร	Dos empleados de un banco roban a una clienta fallecida y, sin darse cuenta, se ven envueltos en el mundo criminal de Pattaya.	2025-10-26 21:22:53.927308	https://image.tmdb.org/t/p/w500/uimZ60ToXqVIgpX9jOTy8QEnEir.jpg	t
261	Scream	Crimen, Terror, Misterio	1996	Wes Craven	Sidney Prescott, una adolescente de la pequeña comunidad de Woodsboro, se convierte en el objetivo de un misterioso asesino en serie. Una reportera de un canal de noticias, Gale Weathers, que cubrió el asesinato un año atrás de la madre de Sidney, cubre ahora estos asesinatos, además ha escrito un libro en el que defiende al supuesto asesino de Maureen, Cotton Weary, que va a ir a la cámara de gas, alegando que cayó en una trampa, lo que hace reavivar la polémica. Los crímenes dejan de ser aislados y continúan los asesinatos. Ahora Sidney, su novio y sus amigos están en peligro, ya que el asesino quiere revivir lo sucedido un año atrás con Maureen Prescott, pero esta vez con su hija.	2025-10-26 21:22:54.047546	https://image.tmdb.org/t/p/w500/pO39MWOrEmJYthKyWT79BYCVRrO.jpg	t
262	Miss Boots	Comedia, Familia, Música	2024	Yan Lanouette Turgeon	Cuando una niña huérfana pierde a su abuela, su tío, un compositor de ópera de un solo éxito, necesita cuidarla hasta que se encuentre una familia adoptiva, mientras también lucha por terminar su próximo gran éxito.	2025-10-26 21:22:54.164188	https://image.tmdb.org/t/p/w500/mWN4yfppBmSQwYzSScAGFxV3uOF.jpg	t
263	Downton Abbey: El gran final	Drama, Romance	2025	Simon Curtis	Sigue a la familia Crawley y a su servidumbre mientras entran en la década de 1930. Cuando Mary se ve envuelta en un escándalo público y la familia enfrenta dificultades económicas, toda la casa debe lidiar con la amenaza de la deshonra social. Los Crawley deberán adaptarse al cambio, mientras el personal se prepara para un nuevo capítulo, con la próxima generación llevando a Downton Abbey hacia el futuro.	2025-10-26 21:22:54.288628	https://image.tmdb.org/t/p/w500/f474M02m9FocBhR6sr4DAkvoM2c.jpg	t
264	Spider-Man: Cruzando el Multiverso	Animación, Acción, Aventura, Ciencia ficción	2023	Justin K. Thompson	Tras reencontrarse con Gwen Stacy, el amigable vecindario de Spider-Man de Brooklyn al completo es catapultado a través del Multiverso, donde se encuentra con un equipo de Spidermans encargados de proteger su propia existencia. Pero cuando los héroes se enfrentan sobre cómo manejar una nueva amenaza, Miles se encuentra enfrentado a las otras Arañas y debe redefinir lo que significa ser un héroe para poder salvar a la gente que más quiere.	2025-10-26 21:22:54.421516	https://image.tmdb.org/t/p/w500/37WcNMgNOMxdhT87MFl7tq7FM1.jpg	t
265	The equalizer (El protector)	Suspense, Acción, Crimen	2014	Antoine Fuqua	Robert McCall, un antiguo agente de la CIA que lleva ahora una vida tranquila, abandona su retiro para ayudar a Teri, que está siendo explotada por la mafia rusa. A pesar de que aseguró no volver a ser violento, contemplar tanta crueldad despertará en Robert un implacable y renovado deseo de justicia.	2025-10-26 21:22:54.541337	https://image.tmdb.org/t/p/w500/7tiub1UB4KF9zpacEldfbWAXDi6.jpg	t
266	Ice Age: La edad de hielo	Animación, Comedia, Familia, Aventura	2002	Chris Wedge	Hace muchos, muchos años, tantos como 20.000, una pequeña ardirata de nombre Scrat quería esconder una bellota en el hielo. Pero lo que hace es provocar una semicatástrofe que provoca que todos los animales migren hacia el sur, hacia tierras más cálidas. Bueno, lo que se dice todos, todos, no. Porque hay uno que lleva la contraria: se trata del mamut Manfred, un auténtico lobo solitario vagabundo y soberbio que va hacia el norte sólo porque los demás están yendo hacia el sur.	2025-10-26 21:22:54.709983	https://image.tmdb.org/t/p/w500/9rpdhn7p7mDZW2rUXsINf9c6sR5.jpg	t
268	The Batman	Crimen, Misterio, Suspense	2022	Matt Reeves	Cuando un asesino se dirige a la élite de Gotham con una serie de maquinaciones sádicas, un rastro de pistas crípticas envía Batman a una investigación en los bajos fondos. A medida que las pruebas comienzan a acercarse a su casa y se hace evidente la magnitud de los planes del autor, Batman debe forjar nuevas relaciones, desenmascarar al culpable y hacer justicia al abuso de poder y la corrupción que durante mucho tiempo han asolado Gotham City.	2025-10-26 21:22:54.959853	https://image.tmdb.org/t/p/w500/mo7teil1qH0SxgLijnqeYP1Eb4w.jpg	t
269	Contigo, todo	Romance, Drama	2025	William Bridges	Laura y Simon son amigos desde la universidad. Con los años, comprenden que lo suyo es más que amistad. ¿Pueden arriesgarlo todo por un amor que siempre ha estado ahí?	2025-10-26 21:22:55.067594	https://image.tmdb.org/t/p/w500/6CsET5hb7y9eUYwcJJgZSwsN6qA.jpg	t
270	बाघी ४	Acción, Suspense, Drama, Crimen	2025	A. Harsha	\N	2025-10-26 21:22:55.18664	https://image.tmdb.org/t/p/w500/b7xYSULcXegbXLFA2BalqHHZcA3.jpg	t
271	El retorno de las brujas	Fantasía, Comedia, Familia	1993	Kenny Ortega	Tres brujas del siglo XII son invocadas durante la noche de Halloween en la ciudad de Salem, Massachusetts, de manera accidental por unos niños. Desterradas hace 300 años por sus prácticas de brujería, este trío prometió volver algún día para sembrar el caos. Ahora aprovecharán la ocasión para cumplir su promesa.  Una comedia realizada por la factoría Disney con vistas a su exhibición en la fiesta de Halloween.	2025-10-26 21:22:55.31406	https://image.tmdb.org/t/p/w500/hnRo1RB791GbpERgV7cnM2sek2V.jpg	t
272	Corazones de acero	Bélica, Drama, Acción	2014	David Ayer	Abril de 1945. Al mando del veterano sargento Wardaddy, un pelotón de cinco soldados americanos a bordo de un carro de combate -el Fury- ha de luchar contra un ejército nazi al borde de la desesperación, pues los alemanes saben que su derrota estaba ya cantada por aquel entonces.	2025-10-26 21:22:55.428612	https://image.tmdb.org/t/p/w500/kbtH5G8L8REzy72LkLmKYoBVaGv.jpg	t
273	Alien, el octavo pasajero	Terror, Ciencia ficción	1979	Ridley Scott	De regreso a la Tierra, la nave de carga Nostromo interrumpe su viaje y despierta a sus siete tripulantes. El ordenador central, MADRE, ha detectado la misteriosa transmisión de una forma de vida desconocida, procedente de un planeta cercano aparentemente deshabitado. La nave se dirige entonces al extraño planeta para investigar el origen de la comunicación.	2025-10-26 21:22:55.550634	https://image.tmdb.org/t/p/w500/pZ9cAe5FxexJjpCaeiETbXzz3Fs.jpg	t
274	Night Carnage	Acción, Terror, Romance	2025	Thomas J. Churchill	\N	2025-10-26 21:22:55.66147	https://image.tmdb.org/t/p/w500/w0wjPQKhlqisSbylf1sWZiNyc2h.jpg	t
275	Estocolmo 1520. El rey Tirano	Acción, Historia, Drama, Aventura, Bélica	2024	Mikael Håfström	En 1520, el rey danés Cristián II intenta arrebatar la corona sueca mientras las hermanas Freja y Anne juran vengar el asesinato de su familia. Su camino las lleva al centro de una sangrienta lucha política entre Suecia y Dinamarca que culminará en el brutal Baño de Sangre de Estocolmo.	2025-10-26 21:22:55.780031	https://image.tmdb.org/t/p/w500/8hrrdAShrWXCnZn8qRQS2h9L7vg.jpg	t
276	Spider-Man: un nuevo universo	Animación, Acción, Aventura, Ciencia ficción	2018	Bob Persichetti	En un universo paralelo donde Peter Parker ha muerto, un joven de secundaria llamado Miles Morales es el nuevo Spider-Man. Sin embargo, cuando el líder mafioso Wilson Fisk construye el 'Super Colisionador' trae a una versión alternativa de Peter Parker que tratará de enseñar a Miles como ser un mejor Spider-Man. Pero no será el único Spider Man en entrar a este universo:  cuatro versiones alternativas buscan regresar a su universo antes de que toda la realidad se colapse.	2025-10-26 21:22:55.909065	https://image.tmdb.org/t/p/w500/xRMZikjAHNFebD1FLRqgDZeGV4a.jpg	t
277	John Wick 4	Acción, Suspense, Crimen	2023	Chad Stahelski	John Wick descubre un camino para derrotar a la Alta Mesa. Pero para poder ganar su libertad, Wick deberá enfrentarse a un nuevo rival con poderosas alianzas en todo el mundo, capaz de convertir a viejos amigos en enemigos.	2025-10-26 21:22:56.028192	https://image.tmdb.org/t/p/w500/mj2Z9HnRSIEk3n7yVPoOY4Uzzfh.jpg	t
278	射雕英雄传：侠之大者	Acción, Drama, Historia	2025	Tsui Hark	\N	2025-10-26 21:22:56.137016	https://image.tmdb.org/t/p/w500/xDYngVPSl6zdepSsSxAZRvScUOM.jpg	t
279	Eduardo Manostijeras	Fantasía, Drama, Romance	1990	Tim Burton	Érase una vez... un castillo donde vivía un inventor que dedicó parte de su vida a crear una criatura perfecta a la que llamó Edward. Pero el inventor murió de repente y dejó incompleta su creación, ya que en vez de dedos tenía unas horribles manos con hojas de tijera. El pobre Edward vivía sólo en el castillo hasta que una encantadora joven, que trabajaba para la firma Avon, lo llevó a su casa junto con su familia. Pero una criatura tan especial como Edward no estaba preparada para vivir en una ciudad tan extravagante y falsa como Suburbia.	2025-10-26 21:22:56.267411	https://image.tmdb.org/t/p/w500/vd8tCekihFx82bzmENaASvbhNmx.jpg	t
280	Harry Potter y las Reliquias de la Muerte - Parte 1	Aventura, Fantasía	2010	David Yates	Una tarea casi imposible cae sobre los hombros de Harry: deberá encontrar y destruir los horrocruxes restantes para dar fin al reinado de Lord Voldemort. En el episodio final de la saga, el hechicero de 17 años parte junto con sus amigos Hermione Granger y Ron Weasley en un peligroso viaje por Inglaterra para encontrar los objetos que contienen los fragmentos del alma del Señor Tenebroso, los cuales garantizan su longevidad. Pero el camino no será fácil pues el lado oscuro adquiere más poder con cada minuto que pasa y las lealtades serán puestas a prueba. Harry deberá usar todos los conocimientos que gracias a Dumbledore ha adquirido sobre su enemigo para poder encontrar la forma de sobrevivir a esta última aventura.	2025-10-26 21:22:56.386728	https://image.tmdb.org/t/p/w500/w6wsYKdXERaXRdByPsI2O9rn20b.jpg	t
281	Sorority	Drama, Romance	2025	Sigrid Polon	\N	2025-10-26 21:22:56.489119	https://image.tmdb.org/t/p/w500/jm4CYBED9I5e8Cp7zlj8cDifUVB.jpg	t
282	Match: La reina de las apps de citas	Historia, Drama	2025	Rachel Lee Goldenberg	Inspirada en la historia real de Whitney Wolfe, fundadora de la plataforma de citas Bumble, donde nos muestra su ingenio y perseverancia para abrirse camino en la industria tecnológica, dominada por hombres.	2025-10-26 21:22:56.59376	https://image.tmdb.org/t/p/w500/3Fyouhu5GY9okg794Qy0qa03p3d.jpg	t
283	La idea de tenerte	Romance, Drama, Comedia	2024	Michael Showalter	Solène, madre soltera de 40 años, comienza un romance inesperado con Hayes Campbell, de 24 años, el cantante principal de August Moon, la banda de chicos más popular del planeta.	2025-10-26 21:22:56.70954	https://image.tmdb.org/t/p/w500/y1WpsgfBA5GywXIuqLm9D4aQHNd.jpg	t
284	La creación de los dioses 2: Fuerza demoníaca	Acción, Fantasía, Bélica	2025	乌尔善	Taishi Wen Zhong condujo a Xiqi al ejército de la dinastía Shang, incluidos Deng Chanyu y cuatro generales de la familia Mo. Con la ayuda de inmortales de Kunlun como Jiang Ziya, Ji Fa dirigió al ejército y a los civiles de Xiqi para defender su patria.	2025-10-26 21:22:56.826002	https://image.tmdb.org/t/p/w500/vM42VhcagVqVhl099en5pvMy4sq.jpg	t
285	Big Hero 6	Aventura, Familia, Animación, Acción, Comedia	2014	Chris Williams	En la metrópolis de San Fransokio (cruce de San Francisco y Tokio), vive Hiro Hamada, quien aprende a sacar provecho de su capacidad gracias a su brillante hermano Tadashi y sus también brillantes amigos: la buscadora de adrenalina GoGo Tamago, el meticuloso de la limpieza Wasabi-No-Ginger, la genio de la química Honey Lemon y el fanático de los cómics Fred. Cuando tras un devastador giro de los acontecimientos, se ven envueltos en una peligrosa conspiración que tiene lugar en las calles de San Fransokio, Hiro recurre a su amigo más íntimo: un robot llamado Baymax, y transforma al grupo en una banda de héroes de última tecnología decididos a resolver el misterio.	2025-10-26 21:22:56.94399	https://image.tmdb.org/t/p/w500/qVU0ag4i5BCmH5h4o04cdvUo0Zf.jpg	t
286	Harry Potter y la Orden del Fénix	Aventura, Fantasía	2007	David Yates	Harry Potter regresa por quinto año a Hogwarts aún sacudido por la tragedia ocurrida en el Torneo de los Tres Magos. Debido a que el Ministro de la Magia niega el regreso de Lord Voldemort, Harry se convierte en el centro de atención de la comunidad mágica. Mientras lucha con sus problemas en el colegio, incluyendo a la nueva profesora Dolores Umbridge, intentará aprender más sobre la misteriosa Orden del Fénix.	2025-10-26 21:22:57.0705	https://image.tmdb.org/t/p/w500/xxXiM2Ij7plbzibKWW9BfDk23aI.jpg	t
287	La milla verde	Fantasía, Drama, Crimen	1999	Frank Darabont	En el sur de los Estados Unidos, en plena Depresión, Paul Edgecomb es un vigilante penitenciario a cargo de la Milla Verde, un pasillo que separa las celdas de los reclusos condenados a la silla eléctrica. Esperando su ejecución está John Coffey, un gigantesco negro acusado de asesinar brutalmente a dos hermanas de nueve años. Tras una personalidad ingenua, Coffey esconde un don sobrenatural prodigioso. A medida que transcurre la historia, Paul Edgecomb aprende que los milagros ocurren... incluso en los lugares más insospechados.	2025-10-26 21:22:57.177443	https://image.tmdb.org/t/p/w500/aBQiJRxGRrX0mXFMjxyzWYFtEnf.jpg	t
288	El señor de los anillos: Las dos torres	Aventura, Fantasía, Acción	2002	Peter Jackson	La Compañía del Anillo se ha disuelto. El portador del anillo Frodo y su fiel amigo Sam se dirigen hacia Mordor para destruir el Anillo Único y acabar con el poder de Sauron. Mientras, y tras la dura batalla contra los orcos donde cayó Boromir, el hombre Aragorn, el elfo Legolas y el enano Gimli intentan rescatar a los medianos Merry y Pipin, secuestrados por los ogros de Mordor. Por su parte, Saurón y el traidor Sarumán continúan con sus planes en Mordor, en espera de la guerra contra las razas libres de la Tierra Media.	2025-10-26 21:22:57.363107	https://image.tmdb.org/t/p/w500/z632eZtXaw76ZE5mMMGOBXCpm1T.jpg	t
289	Zombie camp	Comedia, Terror	2015	Christopher Landon	Tres Scouts, en la víspera de su último campamento, descubre el verdadero significado de la amistad cuando tratan de salvar a su pueblo de un brote de zombis.	2025-10-26 21:22:57.520566	https://image.tmdb.org/t/p/w500/22GlDlg23WOSSpo96PhJW8fHoZp.jpg	t
290	Piratas del Caribe: En el fin del mundo	Aventura, Fantasía, Acción	2007	Gore Verbinski	Siguiendo la estela de lo sucedido en “Piratas del caribe: el cofre del hombre muerto”, encontramos a nuestros héroes Will Turner y Elizabeth Swann aliados con el capitán Barbossa, en una búsqueda desesperada para liberar al capitán Jack Sparrow de las manos de Davy Jones. Mientras, el terrorífico barco fantasma, el Holandés Errante, bajo el control de la Compañía de las Indias Orientales, causa estragos a lo largo de los Siete Mares. Will y Elizabeth, navegando en medio de la traición, la felonía y mares salvajes, deben seguir adelante rumbo a Singapur y enfrentarse al astuto pirata chino Sao Feng. Ahora, en los mismísimos confines de la tierra, todos ellos deben elegir un bando en la batalla final, ya que no sólo sus vidas y fortunas, sino también el futuro de la piratería clásica, pende de un hilo...	2025-10-26 21:22:57.650724	https://image.tmdb.org/t/p/w500/xHcUMez2b1QiMGQYCuQTAlqwDEe.jpg	t
291	Wonder Woman	Acción, Aventura, Fantasía	2017	Patty Jenkins	Diana, princesa de las Amazonas, entrenada para ser una guerrera invencible, fue criada en una isla paradisíaca protegida, hasta que un día, un piloto norteamericano, que tuvo un accidente y acabó en sus costas, le habló de un gran conflicto existente en el mundo, la Primera Guerra Mundial. Diana decidió salir de la isla, convencida de que podía detener la terrible amenaza. Ahora lucha como Wonder Woman, junto a los hombres, en la guerra que acabará con todas las guerras y descubre todos sus poderes y su verdadero destino.	2025-10-26 21:22:57.815158	https://image.tmdb.org/t/p/w500/yjzHtHSAPDdRQejnTyFbifX2gef.jpg	t
292	Lembayung	Terror, Suspense	2024	Baim Wong	Arum y Pica, que querían completar sus prácticas en el hospital de Lembayung, tuvieron que enfrentarse al misterioso terror de una mujer satán, sospechosa de haberse ahorcado en el cuarto de baño. La situación se volvió aún más tensa después de que pidieran ayuda a otras personas, hasta el punto de amenazar sus propias vidas y las de sus allegados.	2025-10-26 21:22:57.917975	https://image.tmdb.org/t/p/w500/5x9LrW0yvtt6S3XovIQHgXfYvLL.jpg	t
293	La guerra de las galaxias	Aventura, Acción, Ciencia ficción	1977	George Lucas	La princesa Leia, líder del movimiento rebelde que desea reinstaurar la República en la galaxia en los tiempos ominosos del Imperio, es capturada por las malévolas Fuerzas Imperiales, capitaneadas por el implacable Darth Vader, el sirviente más fiel del emperador. El intrépido Luke Skywalker, ayudado por Han Solo, capitán de la nave espacial "El Halcón Milenario", y los androides, R2D2 y C3PO, serán los encargados de luchar contra el enemigo y rescatar a la princesa para volver a instaurar la justicia en el seno de la Galaxia.	2025-10-26 21:22:58.037856	https://image.tmdb.org/t/p/w500/ahT4ObS7XKedQkOSpGr1wQ97aKA.jpg	t
294	Ratatouille	Animación, Comedia, Familia, Fantasía	2007	Brad Bird	Remy es una simpática rata que sueña con convertirse en un gran chef francés a pesar de la oposición de su familia y del problema evidente que supone ser una rata en una profesión que detesta a los roedores. El destino lleva entonces a Remy a las alcantarillas de París, pero su situación no podría ser mejor, ya que se encuentra justo debajo de un restaurante que se ha hecho famoso gracias a Auguste Gusteau, una estrella de la cuisine. A pesar del peligro que representa ser un visitante poco común (y desde luego nada deseado) en los fogones de un exquisito restaurante francés, la pasión de Remy por la cocina pone patas arriba el mundo culinario parisino en una trepidante y emocionante aventura.	2025-10-26 21:22:58.2349	https://image.tmdb.org/t/p/w500/nGUelOVetiRpY2wTBMHTbrTIGYC.jpg	t
295	Godzilla y Kong: El nuevo imperio	Acción, Aventura, Ciencia ficción	2024	Adam Wingard	Una aventura cinematográfica completamente nueva, que enfrentará al todopoderoso Kong y al temible Godzilla contra una colosal amenaza desconocida escondida dentro de nuestro mundo. La nueva y épica película profundizará en las historias de estos titanes, sus orígenes y los misterios de Isla Calavera y más allá, mientras descubre la batalla mítica que ayudó a forjar a estos seres extraordinarios y los unió a la humanidad para siempre.	2025-10-26 21:22:58.366738	https://image.tmdb.org/t/p/w500/2YqZ6IyFk7menirwziJvfoVvSOh.jpg	t
296	El hobbit: La batalla de los cinco ejércitos	Acción, Aventura, Fantasía	2014	Peter Jackson	Después de haber recuperado el reino del Dragón Smaug, la Compañía ha desencadenado, sin querer, una potencia maligna. Un Smaug enfurecido vuela hacia la Ciudad del Lago para acabar con cualquier resto de vida. Obsesionado sobre todo con el reino recuperado, Thorin sacrifica la amistad y el honor para mantenerlo mientras que Bilbo intenta frenéticamente hacerle ver la razón por la que el hobbit toma una decisión desesperada y peligrosa. Pero hay aún mayores peligros por delante. Sin la ayuda aparente del mago Gandalf, su gran enemigo Sauron ha enviado legiones de orcos hacia la Montaña Solitaria en un ataque furtivo. Cuando la oscuridad se cierna sobre ellos, las razas de los Enanos, Elfos y Hombres deben decidir si unirse o ser destruidos. Bilbo se encontrará así en la batalla épica de los Cinco Ejércitos, donde el futuro de la Tierra Media está en juego.	2025-10-26 21:22:58.484601	https://image.tmdb.org/t/p/w500/6OiNSLcRKJsBLXwb6DEi6IQ0JFk.jpg	t
297	El último encargo	Acción, Comedia, Crimen	2025	Tim Story	Una rutinaria recogida de dinero da un giro salvaje cuando dos incompatibles conductores de camión, Russell y Travis, son asaltados por despiadados criminales a las órdenes de la hábil mente maestra Zoe, cuyos planes van mucho más allá del cargamento de dinero en efectivo. Mientras el caos se desata a su alrededor, este improbable dúo tiene que enfrentarse en situaciones de alto riesgo, con personalidades que chocan continuamente y un muy mal día que no deja de empeorar.	2025-10-26 21:22:58.602519	https://image.tmdb.org/t/p/w500/lbpyI9nwzSVDjS7OnE0uC41UciP.jpg	t
298	365 días más	Romance, Drama	2022	Tomasz Mandes	La relación de Laura y Massimo pende de un hilo mientras intentan superar los problemas de confianza y los celos, mientras que un tenaz Nacho trabaja para separarlos.	2025-10-26 21:22:58.732864	https://image.tmdb.org/t/p/w500/dvKpJZUxI1Rsgvrl8HHv62CpBBh.jpg	t
299	Detective Dee y los cuatro reyes celestiales	Acción, Fantasía, Aventura, Misterio	2018	Tsui Hark	Como recompensa a sus méritos y astucia, el Emperador confía al detective Dee un mazo que da autoridad sobre cualquier persona que amenace la seguridad nacional, incluida la realeza. La Emperatriz sabe que este objeto pone en peligro el equilibrio de poder en la corte, por lo que tratará de hacerse con él, activando una red de conspiraciones que serán solamente la punta del iceberg de la aventura más espectacular del icónico Dee.	2025-10-26 21:22:58.832645	https://image.tmdb.org/t/p/w500/lVhgQfBG2B3mXtN807qqsr6ni7l.jpg	t
300	Pulp Fiction	Suspense, Crimen, Comedia	1994	Quentin Tarantino	Jules y Vincent, dos asesinos a sueldo con muy pocas luces, trabajan para Marsellus Wallace. Vincent le confiesa a Jules que Marsellus le ha pedido que cuide de Mia, su mujer. Jules le recomienda prudencia porque es muy peligroso sobrepasarse con la novia del jefe. Cuando llega la hora de trabajar, ambos deben ponerse manos a la obra. Su misión: recuperar un misterioso maletín.	2025-10-26 21:22:59.01539	https://image.tmdb.org/t/p/w500/hNcQAuquJxTxl2fJFs1R42DrWcf.jpg	t
301	La doncella	Suspense, Drama, Romance	2016	Park Chan-wook	Corea, década de 1930, durante la colonización japonesa. Una joven llamada Sookee es contratada como doncella de una rica mujer japonesa, Hideko, que vive recluida en una gran mansión bajo la influencia de un tirano. Sookee guarda un secreto y con la ayuda de un estafador que se hace pasar por un conde japonés, planea algo para Hideko.	2025-10-26 21:22:59.136744	https://image.tmdb.org/t/p/w500/1CJWo3mJwNEi0RsSZyxbgVFOj8B.jpg	t
302	Depredador	Ciencia ficción, Acción, Aventura, Suspense	1987	John McTiernan	Un comando de mercenarios es contratados por la CIA para rescatar a unos pilotos apresados por las guerrillas en la selva Centroamericana. La misión resulta satisfactoria, pero durante su viaje de regreso se dan cuenta de que algo está dándoles caza uno a uno, ese algo resulta ser un cazador alienígena que se queda con las calaveras de sus víctimas como trofeos	2025-10-26 21:22:59.253238	https://image.tmdb.org/t/p/w500/jl5Y5p2pbhgRwREWbll2RbciG5Z.jpg	t
303	Expediente Warren: El caso Enfield	Terror	2016	James Wan	Secuela de la exitosa 'Expediente Warren' (2013), que lleva de nuevo a la pantalla otro caso real de los expedientes de los renombrados demonólogos Ed y Lorraine Warren. En este caso ambos viajarán al norte de Londres para ayudar a una madre soltera que tiene a su cargo cuatro hijos y que vive sola con ellos en una casa plagada de espíritus malignos.	2025-10-26 21:22:59.37903	https://image.tmdb.org/t/p/w500/pdNW0HWw11Wn2N94VGea8O44wOA.jpg	t
304	Shrek, Felices para siempre	Comedia, Aventura, Fantasía, Animación, Familia	2010	Mike Mitchell	En lugar de espantar a los aldeanos como él solía hacerlo, un recluido Shrek ahora accede a autografiar horquillas para siembra. Anhelando los días cuando se sentía un "ogro real", Shrek es embaucado al firmar un pacto con el afable negociador Rumpelstiltskin. De pronto Shrek se encuentra en una retorcida versión alterna de Muy Muy Lejano, donde Fiona es un ogro de caza, Rumpelstiltskin es el rey, Burro nunca ha conocido a Shrek, el Gato con Botas es obeso y perezoso, y Shrek y Fiona no se conocían. Ahora, está en las manos de Shrek deshacer todo lo que hizo con la esperanza de salvar a sus amigos, restaurar su mundo y recuperar a su único y verdadero amor.	2025-10-26 21:22:59.502957	https://image.tmdb.org/t/p/w500/3MyKXb1ozCfq61tPNKpIggwvP6J.jpg	t
305	El rey león	Familia, Animación, Drama, Aventura	1994	Roger Allers	La sabana africana es el escenario en el que tienen lugar las aventuras de Simba, un pequeño león que es el heredero del trono. Sin embargo, se ve forzado a exiliarse al ser injustamente acusado de la muerte de su padre. Durante su destierro, hará buenas amistades y, finalmente, regresará para recuperar lo que legítimamente le corresponde.	2025-10-26 21:22:59.621541	https://image.tmdb.org/t/p/w500/b0MxU37dNmMwKtoPVYPKOZSIrIn.jpg	t
306	Hostile Takeover	Acción, Comedia, Suspense	2025	Michael Hamilton-Wright	\N	2025-10-26 21:22:59.785893	https://image.tmdb.org/t/p/w500/vntwlS3CAKfoLTs90GaoK6lymBC.jpg	t
307	Nadie	Acción, Suspense	2021	Ilya Naishuller	Hutch Mansell, un padre de familia que aguanta con resignación y sin defenderse los golpes de la vida. Un don nadie.  Una noche, cuando dos ladrones entran en su casa, Hutch decide no actuar y no trata de defenderse ni al él mismo ni a su familia, convencido de que solo así evitará una escalada de violencia. Tras el ataque, su hija adolescente Blake no oculta su decepción, y su esposa Becca se aleja todavía más.	2025-10-26 21:22:59.919435	https://image.tmdb.org/t/p/w500/ddO5a3tMPpQutSDQO1bESgLWadB.jpg	t
308	Malditos bastardos	Drama, Suspense, Bélica	2009	Quentin Tarantino	Segunda Guerra Mundial. Durante la ocupación de Francia por los alemanes, Shosanna Dreyfus presencia la ejecución de su familia por orden del coronel nazi Hans Landa. Ella consigue huir a París, donde adopta una nueva identidad como propietaria de un cine. En otro lugar de Europa, el teniente Aldo Raine adiestra a un grupo de soldados judíos "Los bastardos" para atacar objetivos concretos. Los hombres de Raine y una actriz alemana, que trabaja para los aliados, deben llevar a cabo una misión que hará caer a los jefes del Tercer Reich. El destino quiere que todos se encuentren bajo la marquesina de un cine donde Shosanna espera para vengarse.	2025-10-26 21:23:00.075039	https://image.tmdb.org/t/p/w500/dqu7nUtKTLdpM7DaJvD4zcSXhn1.jpg	t
309	A Perfect Ending	Drama, Romance	2012	Nicole Conn	Rebecca tiene un secreto muy inusual, uno que ni siquiera sus mejores amigos conocen. La última persona en la tierra que espera para revelarlo a un escort de alto precio llamada París. Lo que comienza como una comedia de errores termina en un viaje exclusivamente erótico. Los esfuerzos no convencionales de Rebecca por encontrarse a sí misma son crudos, evocadores, y a menudo humorísticos, pero siempre muy reales, muy humanos. A veces un final perfecto no es lo uno se espera que sea. (FILMAFFINITY)	2025-10-26 21:23:00.187138	https://image.tmdb.org/t/p/w500/mjwWEwE1xdbtFGCOgeXi5jvQnOU.jpg	t
310	Caerás	Romance, Suspense	2025	Sherry Hormann	Lilli sospecha del nuevo prometido de su hermana, pero cuando un atractivo desconocido se cruza en su camino, se distrae de repente con su propio deseo.	2025-10-26 21:23:00.306421	https://image.tmdb.org/t/p/w500/wytZFBYpkEgxsALpg5l2euGeVQz.jpg	t
311	Spider-Man	Acción, Ciencia ficción	2002	Sam Raimi	Peter Parker es un joven y tímido estudiante que vive con su tía May y su tío Ben desde la muerte de sus padres. Un día es mordido por una araña que ha sido modificada genéticamente, descubriendo al día siguiente que posee unos poderes poco habituales: tiene la fuerza y agilidad de una araña.	2025-10-26 21:23:00.444431	https://image.tmdb.org/t/p/w500/bCDaKZLRkrVVtPNyHxUfKvepW1N.jpg	t
312	Furiosa: De la saga Mad Max	Acción, Ciencia ficción, Aventura	2024	George Miller	En un mundo postapocalíptico donde todo ha perdido su valor, los pocos supervivientes se guían por la ley del más fuerte. Sin aprecio por la vida, lo único que despierta un brutal interés es la gasolina, sinónimo de poder y objetivo de bandas armadas hasta los dientes y sin escrúpulos. En este contexto conoceremos la  historia de la arrebatadoramente despiadada, salvaje y joven Furiosa, quien cae en manos de una horda de motoristas y debe sobrevivir a muchas pruebas mientras reúne los medios para encontrar el camino de vuelta a casa. Precuela de 'Mad Max: Furia en la carretera' (2015).	2025-10-26 21:23:00.565508	https://image.tmdb.org/t/p/w500/tGHUlykWn9V2IIQ4ZaATIAq9VLB.jpg	t
313	Ninja Turtles	Ciencia ficción, Acción, Aventura, Comedia	2014	Jonathan Liebesman	Nueva York está en peligro debido a que Shredder y El Clan del Pie, dominan la ciudad y ejercen un férreo control sobre todo, incluyendo policía y políticos. Pero cuatro héroes, Leonardo, Michelangelo, Donatello y Raphael, saldrán de las alcantarillas y con la ayuda de la reportera April y su compañero Vern Fenwick intentarán salvar la ciudad.	2025-10-26 21:23:00.691995	https://image.tmdb.org/t/p/w500/8n4ceqgtYeWjcvpzFAb67sG0Ksr.jpg	t
314	Gladiator	Acción, Drama, Aventura	2000	Ridley Scott	En el año 180, el Imperio Romano domina todo el mundo conocido. Tras una gran victoria sobre los bárbaros del norte, el anciano emperador Marco Aurelio decide transferir el poder a Máximo, bravo general de sus ejércitos y hombre de inquebrantable lealtad al imperio. Pero su hijo Cómodo, que aspiraba al trono, no lo acepta y trata de asesinar a Máximo.	2025-10-26 21:23:00.855952	https://image.tmdb.org/t/p/w500/90QFOG5zSN4cbrIVs4DL4ePAuA5.jpg	t
315	Eddington	Western, Comedia, Crimen	2025	Ari Aster	En mayo de 2020, la disputa entre el sheriff de un pequeño pueblo y su alcalde prende un auténtico polvorín al enfrentar a los vecinos de Eddington, Nuevo México.	2025-10-26 21:23:01.04261	https://image.tmdb.org/t/p/w500/giRUiVTcAGzV7puyxkrzQudzFyc.jpg	t
316	Shrek 2	Animación, Familia, Comedia, Fantasía, Aventura, Romance	2004	Conrad Vernon	Cuando Shrek y la princesa Fiona regresan de su luna de miel, los padres de ella los invitan a visitar el reino de Muy Muy Lejano para celebrar la boda. Para Shrek, al que nunca abandona su fiel amigo Asno, esto constituye un gran problema. Los padres de Fiona, por su parte, no esperaban que su yerno tuviera un aspecto semejante y, mucho menos, que su hija hubiera cambiado tanto. Todo esto trastoca los planes del rey respecto al futuro del reino. Pero entonces entran en escena la maquiavélica Hada Madrina, su arrogante hijo el Príncipe Encantador y un minino muy especial: el Gato con Botas, experto cazador de ogros.	2025-10-26 21:23:01.184416	https://image.tmdb.org/t/p/w500/knRt4E8KyfwEv0SVu9LsLvD28IQ.jpg	t
317	Monstruos, S.A.	Animación, Comedia, Familia	2001	Pete Docter	Monsters Inc. es la mayor empresa de miedo del mundo, y James P. Sullivan es uno de sus mejores empleados. Asustar a los niños no es un trabajo fácil, ya que todos creen que los niños son tóxicos y no pueden tener contacto con ellos. Pero un día una niña se cuela sin querer en la empresa, provocando el caos.	2025-10-26 21:23:01.356302	https://image.tmdb.org/t/p/w500/g3SgHEb5ej2MioGfYLrZVshF909.jpg	t
318	Spermageddon	Animación, Aventura, Fantasía, Comedia	2025	Tommy Wirkola	Los adolescentes Jens y Lisa están a punto de experimentar su primera relación sexual. Dentro del cuerpo de Jens, el Spermageddon se acerca, un evento para el que el espermatozoide Simon el Semen y sus amigos han estado preparándose duramente. En esta carrera donde solo puede ganar uno, deberán sortear todo tipo de obstáculos inesperados que les harán la vida imposible.	2025-10-26 21:23:01.4932	https://image.tmdb.org/t/p/w500/jYJJDtrGBAr1U9WBVuq809FyYQj.jpg	t
319	Furioza	Acción, Crimen, Drama	2021	Cyprian T. Olencki	Una policía le hace a su exnovio una oferta irrechazable: o se infiltra en un grupo de hinchas violentos para conseguir información o su hermano va a la cárcel.	2025-10-26 21:23:01.666563	https://image.tmdb.org/t/p/w500/sSIo1vG0IILxzHkLKmtFEoTbVE9.jpg	t
320	Grafted	Terror	2024	Sasha Rainbow	Una mezcla de terror corporal y comedia negra sobre cómo las mujeres cambian su apariencia para encajar en la sociedad. La historia sigue a Wei, una estudiante que consigue una beca para investigar un proyecto sobre regeneración de piel, relacionado con la misteriosa muerte de su padre.	2025-10-26 21:23:01.770538	https://image.tmdb.org/t/p/w500/rTBWjsW64E1ouo5afwRaLbUN9yb.jpg	t
321	El resplandor	Terror, Suspense	1980	Stanley Kubrick	Jack Torrance se traslada, junto a su mujer y a su hijo, al impresionante hotel Overlook, en Colorado, para encargarse del mantenimiento del mismo durante la temporada invernal, en la que permanece cerrado y aislado por la nieve. Su idea es escribir su novela al tiempo que cuida de las instalaciones durante esos largos y solitarios meses de invierno, pero desde su llegada al hotel, Jack comienza a padecer inquietantes transtornos de personalidad, al mismo tiempo que en el lugar comienzan a suceder diversos fenómenos paranormales.	2025-10-26 21:23:01.883316	https://image.tmdb.org/t/p/w500/mm003Mj2e9kJRsrxiVdPn2BSBPh.jpg	t
322	Exorcismo: El Ritual	Terror, Drama, Suspense	2025	David Midell	Cuando una joven es poseída por una entidad demoníaca, dos sacerdotes muy distintos deben unirse para salvarla. Uno carga con el peso de un exorcismo fallido y el otro con sus dudas de fe. Juntos afrontan un ritual aterrador que pondrá en juego su cordura, su creencia y hasta sus vidas.	2025-10-26 21:23:02.001989	https://image.tmdb.org/t/p/w500/8gT2cR9ETkSZbNSmQQeCUW6sYCg.jpg	t
338	Iron Man	Acción, Ciencia ficción, Aventura	2008	Jon Favreau	El multimillonario fabricante de armas Tony Stark debe enfrentarse a su turbio pasado después de sufrir un accidente con una de sus armas. Equipado con una armadura de última generación tecnológica, se convierte en 'El hombre de hierro' para combatir el mal a escala global.	2025-10-26 21:23:03.89299	https://image.tmdb.org/t/p/w500/tFCTNx7foAsUQpgu2x1KjAJD1wT.jpg	t
323	Super Mario Bros: La película	Familia, Comedia, Aventura, Animación, Fantasía	2023	Aaron Horvath	Mientras trabajan en una avería subterránea, los fontaneros de Brooklyn, Mario y su hermano Luigi, viajan por una misteriosa tubería hasta un nuevo mundo mágico. Pero, cuando los hermanos se separan, Mario deberá emprender una épica misión para encontrar a Luigi. Con la ayuda del champiñón local Toad y unas cuantas nociones de combate de la guerrera líder del Reino Champiñón, la princesa Peach, Mario descubre todo el poder que alberga en su interior.	2025-10-26 21:23:02.147467	https://image.tmdb.org/t/p/w500/zNKs1T0VZuJiVuhuL5GSCNkGdxf.jpg	t
324	Gladiator II	Acción, Aventura, Drama	2024	Ridley Scott	Dieciséis años después de la muerte de Marco Aurelio, Roma está gobernada por los despiadados emperadores gemelos Geta y Caracalla. El nieto de Aurelio, Lucio Vero, vive bajo el seudónimo de Hanno con su esposa Arishat en el reino norteafricano de Numidia. El ejército romano dirigido por el general Acacio invade y conquista el reino, esclavizando a Lucio junto con otros supervivientes. Los esclavos son llevados a Ostia, donde Lucio es comprado por el maestro de cuadra Macrinus, que le promete la oportunidad de vengarse matando a Acacio si gana suficientes combates para llegar al Coliseo.	2025-10-26 21:23:02.268791	https://image.tmdb.org/t/p/w500/fbcs5AxrdXwyj1b8bGGMgC9kXrM.jpg	t
325	La reina guerrera	Acción, Historia, Aventura	1987	Chuck Vincent	Berenice (Sybil Danníng), la esposa del emperador romano, descubre la promiscua realidad de las calles de Pompeya. Indignada, Berenice decide, a riesgo de su propia vida, luchar para acabar con tan injusta situación, que incluye la humillación a la que condenan los hombres a las mujeres, vendiéndolas en cada esquina, rebajándolas a lo más indigno. Una pelea para la que se armará con sus poderes y que iniciará con la liberación de una joven que descubre cautiva.	2025-10-26 21:23:02.374957	https://image.tmdb.org/t/p/w500/P0j17mJRpSIZOglbtPkakHSD1S.jpg	t
326	Kakushigoto: Himegoto wa Nan Desu ka	Animación, Comedia	2021	Yuta Murano	Esta comedia tiene como protagonista a Kakushi Gotou, que no quiere que su hija, Hime Gotou, se entere que él es un mangaka algo vulgar. Una historia de amor y risas entre padre e hija.	2025-10-26 21:23:02.488487	https://image.tmdb.org/t/p/w500/gkq4iIx4ParsPJ5Wn3ETbx5p9OD.jpg	t
327	Rita	Drama	2024	\N	\N	2025-10-26 21:23:02.59785	https://image.tmdb.org/t/p/w500/grIFQLXXwQmjvYYfXVXCgGTMUWw.jpg	t
328	Dangerous Animals	Terror, Suspense	2025	Sean Byrne	Zephyr, una surfista inteligente y de espíritu libre, que es secuestrada por un asesino en serie obsesionado con los tiburones. Cautiva en su barco, debe averiguar cómo escapar antes de que él lleve a cabo un ritual de alimentación a los tiburones.	2025-10-26 21:23:02.709479	https://image.tmdb.org/t/p/w500/uFtk7T6dbDgroAGWtoe0yoL4cc.jpg	t
329	Wahyu	Drama, Suspense	2024	Nada Leo Prakasa	\N	2025-10-26 21:23:02.832891	https://image.tmdb.org/t/p/w500/gpzUnXJ1DHEwfaAAp3Si93YaUQo.jpg	t
330	El caballero oscuro: La leyenda renace	Acción, Crimen, Drama, Suspense	2012	Christopher Nolan	Hace ocho años que Batman desapareció, dejando de ser un héroe para convertirse en un fugitivo. Al asumir la culpa por la muerte del fiscal del distrito Harvey Dent, el Caballero Oscuro decidió sacrificarlo todo por lo que consideraba, al igual que el Comisario Gordon, un bien mayor. La mentira funciona durante un tiempo, ya que la actividad criminal de la ciudad de Gotham se ve aplacada gracias a la dura Ley Dent. Pero todo cambia con la llegada de una astuta gata ladrona que pretende llevar a cabo un misterioso plan. Sin embargo, mucho más peligrosa es la aparición en escena de Bane, un terrorista enmascarado cuyos despiadados planes obligan a Bruce a regresar de su voluntario exilio.	2025-10-26 21:23:02.966793	https://image.tmdb.org/t/p/w500/rrS7K8tXVFUBliIKWaRuSq65nWr.jpg	t
331	Cenicienta	Romance, Fantasía, Familia, Drama	2015	Kenneth Branagh	Cuenta las andanzas de Ella, una joven cuyo padre, un comerciante, vuelve a casarse tras enviudar. Para agradar a su padre, acoge con cariño a su madrastra y a sus hijas en la casa familiar. Pero, cuando su padre muere inesperadamente, la joven queda a merced de unas mujeres celosas y malvadas que la convierten en sirvienta y la relegan a la cocina. Pero, a pesar de la crueldad con la que la tratan, está dispuesta a cumplir las últimas palabras de su madre que le dijo que debía "ser valiente y amable".	2025-10-26 21:23:03.077463	https://image.tmdb.org/t/p/w500/pEZPAykrk8ySdzjRSMfMrd0qtO0.jpg	t
332	Prisioneros	Drama, Suspense, Crimen	2013	Denis Villeneuve	Keller Dover se enfrenta a la peor de las pesadillas: Anna, su hija de seis años, ha desaparecido con su amiga Joy y, a medida que pasa el tiempo, el pánico lo va dominando. Desesperado, decide ocuparse personalmente del asunto. Pero, ¿hasta dónde está dispuesto a llegar para averiguar el paradero de su hija?	2025-10-26 21:23:03.195737	https://image.tmdb.org/t/p/w500/i6CcmOvJxBFH3mfhCHa3Njtelix.jpg	t
333	Harry Potter y el misterio del príncipe	Aventura, Fantasía	2009	David Yates	En medio de los desastres que azotan a Inglaterra, Harry y sus compañeros vuelven a Hogwarts para cursar su sexto año de estudios; y aunque las medidas de seguridad han convertido al colegio en una fortaleza, algunos estudiantes son víctimas de ataques inexplicables. Harry sospecha que Draco Malfoy es el responsable de los mismos y decide averiguar la razón. Mientras tanto, Albus Dumbledore y el protagonista exploran el pasado de Lord Voldemort mediante recuerdos que el director ha recolectado. Con esto, Dumbledore planea preparar al muchacho para el día de la batalla final.	2025-10-26 21:23:03.312804	https://image.tmdb.org/t/p/w500/nSb3nNiL6pOEDK34T0U6RKTGzlJ.jpg	t
334	Del revés (Inside Out)	Animación, Familia, Aventura, Drama, Comedia	2015	Pete Docter	Riley es una chica que disfruta o padece toda clase de sentimientos. Aunque su vida ha estado marcada por la Alegría, también se ve afectada por otro tipo de emociones. Lo que Riley no entiende muy bien es por qué motivo tiene que existir la Tristeza en su vida. Una serie de acontecimientos hacen que Alegría y Tristeza se mezclen en una peligrosa aventura que dará un vuelco al mundo de Riley.	2025-10-26 21:23:03.425952	https://image.tmdb.org/t/p/w500/sG3bHZWCMOZwhUq71WbPG9Vrrwc.jpg	t
335	Pájaro que trina no vuela : Nubes que se funden	Animación, Drama	2020	牧田佳織	Yashiro es un jefe yakuza con tendencias sexuales un tanto masoquistas, pero a pesar de todo, no se pone “caliente” fácilmente. Pero el nuevo guardaespaldas contratado, llamado Chikara Doumeki, capta su interés, y decide abandonar su política de “no intervención” con sus subordinados. Cuando todo lo que hace Yashiro para invitar a Chikara falla, el jefe yakuza descubre que su guardaespaldas tiene una razón muy personal para mantenerse a distancia.	2025-10-26 21:23:03.538198	https://image.tmdb.org/t/p/w500/k0DQtzs8D4ntKuDxnyD0NxMcXgv.jpg	t
336	Bad Boys: Ride or Die	Acción, Comedia, Crimen, Suspense, Aventura	2024	Adil El Arbi	Los policías más famosos del mundo regresan con su icónica mezcla de acción al límite y comedia escandalosa, pero esta vez con un giro inesperado: ¡Los mejores de Miami se dan a la fuga! Cuarta entrega de la saga 'Dos policías rebeldes'.	2025-10-26 21:23:03.660741	https://image.tmdb.org/t/p/w500/5jI2vEHJReAx8iFDmhC2O3yW37w.jpg	t
337	Nosferatu	Terror, Fantasía	2024	Robert Eggers	Historia gótica de obsesión entre una joven hechizada y el aterrador vampiro encaprichado de ella que causa un indescriptible terror a su paso.	2025-10-26 21:23:03.776278	https://image.tmdb.org/t/p/w500/jivUhECegXI3OYtPVflWoIDtENt.jpg	t
339	V3nganza	Suspense, Acción	2014	Olivier Megaton	Tercera entrega de la trilogía iniciada en 2008 con 'Venganza' y que cuenta con una secuela en 2012 bajo el título 'Venganza: Conexión Estambul', donde Liam Neeson ('Batman Begins') vuelve a meterse en la piel de Bryan, un espía retirado que no dudará en hacer lo necesario a favor de la justicia y la supervivencia.	2025-10-26 21:23:04.018929	https://image.tmdb.org/t/p/w500/hCffcXqpH002rvSFt8AUnIC376s.jpg	t
340	Donde tú quieras	Acción	2025	Andrés Valencia	\N	2025-10-26 21:23:04.125411	https://image.tmdb.org/t/p/w500/32kwv7gWBcIcI9mi5h5CwwLxZVw.jpg	t
341	14 and Under	Comedia, Romance	1973	Ernst Hofbauer	Esta película episódica esta estrechamente relacionada con las producciones de "Schoolgirl Report" del producto Wolf C. Hartwig, en la medida de que está hecha por la misma gente y, con un estilo y temática similar. No obstante, esta se centra especialmente en los que se llama "coming-of-age" (crecimiento psicológico y moral de la protagonista), en la medida en que también aborda cuestiones delicadas, como la pedofilia.	2025-10-26 21:23:04.230516	https://image.tmdb.org/t/p/w500/sreO7KKeh6s99jYFl9XzpxDkOeZ.jpg	t
342	Blade Runner 2049	Ciencia ficción, Drama	2017	Denis Villeneuve	Han pasado 30 años desde los acontecimientos ocurridos en Blade Runner (1982). El oficial K, un blade runner caza-replicantes del Departamento de Policía de Los Ángeles, descubre un secreto que ha estado enterrado durante mucho tiempo y que tiene el potencial de llevar a la sociedad al caos. Su investigación le conducirá a la búsqueda del legendario Rick Deckard, un antiguo blade runner en paradero desconocido, que lleva desaparecido 30 años.	2025-10-26 21:23:04.375283	https://image.tmdb.org/t/p/w500/cOt8SQwrxpoTv9Bc3kyce3etkZX.jpg	t
343	Los pingüinos de Madagascar	Familia, Animación, Aventura, Comedia	2014	Simon J. Smith	Skypper, Kowalsky, Rico y Cabo, los superagentes pingüinos, tienen que salvar el mundo en una misión para la que llevan prepárandose toda la vida. Dicha misión tendrán que realizarla junto al denominado equipo "Viento del norte", un comando de élite especializado en salvar animales que no pueden defenderse por si solos.	2025-10-26 21:23:04.500198	https://image.tmdb.org/t/p/w500/lEnUxCpQUyntm2eLBzCTv3bfplV.jpg	t
344	Hasta el último hombre	Drama, Historia, Bélica	2016	Mel Gibson	Narra la historia de Desmond Doss, un joven médico militar que participó en la sangrienta batalla de Okinawa, en el Pacífico durante la II Guerra Mundial, y se convirtió en el primer objetor de conciencia en la historia estadounidense en recibir la Medalla de Honor del Congreso. Doss quería servir a su país, pero desde pequeño se había hecho una promesa a sí mismo: no coger jamás ningún arma.	2025-10-26 21:23:04.660128	https://image.tmdb.org/t/p/w500/m3jj8IJ7uP5p4MqMzgtGW5l4ECd.jpg	t
345	Spider-Man 3	Acción, Aventura, Ciencia ficción	2007	Sam Raimi	Parece que Parker ha conseguido por fin el equilibrio entre su devoción por Mary Jane y sus deberes como superhéroe. Pero, de repente, su traje se vuelve negro y adquiere nuevos poderes; también él se transforma, mostrando el lado más oscuro y vengativo de su personalidad. Bajo la influencia del nuevo traje, Peter se convierte en un ser egoísta que sólo se preocupa por sí mismo. Tiene, pues, que afrontar un dilema: disfrutar de sus nuevos poderes o seguir siendo un héroe compasivo. Mientras tanto, sobre él se cierne la amenaza de dos temibles enemigos: Venom y el Hombre de Arena.	2025-10-26 21:23:04.784278	https://image.tmdb.org/t/p/w500/589rUff9Ai272uMudb9Dn7k88Oa.jpg	t
346	Iron Man 3	Acción, Aventura, Ciencia ficción	2013	Shane Black	El descarado y brillante empresario Tony Stark/Iron Man se enfrentará a un enemigo cuyo poder no conoce límites. Cuando Stark comprende que su enemigo ha destruido su universo personal, se embarca en una angustiosa búsqueda para encontrar a los responsables. Este viaje pondrá a prueba su entereza una y otra vez. Acorralado, Stark tendrá que sobrevivir por sus propios medios, confiando en su ingenio y su instinto para proteger a las personas que quiere.	2025-10-26 21:23:04.90588	https://image.tmdb.org/t/p/w500/cW0fOIZONkgeiMJDYzqUcgl4MUn.jpg	t
347	Una mujer sin filtro	Comedia	2025	Arthur Fontes	Una ejecutiva publicitaria sobrecargada de trabajo lidia con un jefe sexista, un marido perezoso, una amiga egocéntrica y una hermana difícil. Tras conocer a una sanadora mística, de repente pierde el control y empieza a decir lo que piensa sin tapujos.	2025-10-26 21:23:05.013128	https://image.tmdb.org/t/p/w500/irqKQvpIR1wiAj5jmB78NiA1zzt.jpg	t
348	404 สุขีนิรันดร์..Run Run	Comedia, Terror	2024	พิชย จรัสบุญประชา	\N	2025-10-26 21:23:05.127224	https://image.tmdb.org/t/p/w500/79WPryCJZj4Nh38yOZU6ud5RYz7.jpg	t
349	Terrifier 2	Terror, Suspense	2022	Damien Leone	Después de ser resucitado por una entidad siniestra, Art the Clown regresa al condado de Miles, donde debe cazar y destruir a una adolescente y a su hermano menor en la noche de Halloween.	2025-10-26 21:23:05.253846	https://image.tmdb.org/t/p/w500/1jpaJU7mqyzCWkLwakpVxlBv9lA.jpg	t
350	Resacón en Las Vegas	Comedia	2009	Todd Phillips	"The Hangover" es la historia de una desmadrada despedida de soltero en la que el futuro novio y sus tres amigos, dos días antes de la boda, se montan la juerga padre en Las Vegas. Doug viaja a la ciudad del juego con sus mejores amigos Phil y Stu, así como su futuro cuñado Alan. La juerga es de campeonato y, como era de esperar, a la mañana siguiente tienen una resaca monumental. El problema es que, siendo incapaces de recordar nada de lo ocurrido durante la noche anterior, se encuentran con que el prometido ha desaparecido, topándose en su lugar con otras dos sorpresas en la suite del hotel: un tigre y un bebé.	2025-10-26 21:23:05.368234	https://image.tmdb.org/t/p/w500/rqeim09TdaflSvPNVnCTBjUHlKu.jpg	t
351	Harry Potter y las Reliquias de la Muerte - Parte 2	Fantasía, Aventura	2011	David Yates	La segunda parte de la batalla final entre las fuerzas del bien y el mal. El juego nunca ha sido tan peligroso y nadie está a salvo. Se acerca el momento de la confrontación final entre Harry Potter y Lord Voldemort. Todo termina aquí…	2025-10-26 21:23:05.486271	https://image.tmdb.org/t/p/w500/aM1TuUiPtV8OAZyu61CTdy9Ymtk.jpg	t
352	Alicia en el País de las Maravillas	Familia, Fantasía, Aventura	2010	Tim Burton	Alicia, una joven de 19 años, asiste a una fiesta en una mansión victoriana, donde descubre que está a punto de recibir una propuesta de matrimonio frente a un montón de gente estirada de la alta sociedad. Alicia entonces se escapa, corriendo tras un conejo blanco, entra a un agujero tras él... y acaba en el país de las Maravillas, un lugar que visitó hace 10 años, pero el cual no recuerda. El país de las Maravillas era un reino pacífico hasta que la Reina Roja derrocó a su hermana, la Reina Blanca. Las criaturas del país de las maravillas, listos para la revuelta, esperan que Alicia les ayude, y éstas a su vez le ayudarán a recordar su primera visita al mágico reino.	2025-10-26 21:23:05.601178	https://image.tmdb.org/t/p/w500/sqOyCSgzLglxcR2y1boewr5Qufn.jpg	t
353	Juegos secretos	Drama, Romance	2006	Todd Field	Varias personas se cruzan de forma azarosa e incluso peligrosa en los parques, piscinas y calles de su barrio. Una madre aburrida  se hace amiga de Brad, un padre que se hace cargo de la casa mientras su mujer  trabaja. Larry, un amigo de Brad, empieza a inquietarse por la presencia en las calles de un pedófilo recién salido de la cárcel.	2025-10-26 21:23:05.703307	https://image.tmdb.org/t/p/w500/sjDvCHIVie0E6NGgWM9Ol1MoKJI.jpg	t
354	Buscando a Nemo	Animación, Familia	2003	Andrew Stanton	Nemo, un pececillo, hijo único muy querido y protegido por su padre, ha sido capturado en un arrecife australiano y ahora vive en una pecera en la oficina de un dentista de Sidney. El tímido padre de Nemo se embarcará en una peligrosa aventura para rescatar a su hijo. Pero Nemo y sus nuevos amigos tienen también un astuto plan para escapar de la pecera y volver al mar.	2025-10-26 21:23:05.856237	https://image.tmdb.org/t/p/w500/jPhak722pNGxQIXSEfeWIUqBrO5.jpg	t
355	Dos rubias de pelo en pecho	Comedia, Crimen	2004	Keenen Ivory Wayans	Dos ambiciosos -pero con poca fortuna- agentes del FBI (Shawn y Marlon Wayans) se hacen pasar por mujeres, novatas en la alta sociedad, en el exclusivo complejo Hamptons para investigar un círculo de secuestros. Pero mientras preparan su actuación en el mayor acontecimiento social del año se encuentran que irrumpir en la alta sociedad es mucho más duro de lo que parecía.	2025-10-26 21:23:05.978315	https://image.tmdb.org/t/p/w500/sgg5mR2Iz6QV4eWkqGrTgxOERaH.jpg	t
356	Vengadores: Endgame	Aventura, Ciencia ficción, Acción	2019	Joe Russo	Después de los eventos devastadores de 'Vengadores: Infinity War', el universo está en ruinas debido a las acciones de Thanos. Con la ayuda de los aliados que quedaron, los Vengadores deberán reunirse una vez más para intentar deshacer sus acciones y restaurar el orden en el universo de una vez por todas, sin importar cuáles sean las consecuencias... Cuarta y última entrega de la saga "Vengadores".	2025-10-26 21:23:06.112579	https://image.tmdb.org/t/p/w500/br6krBFpaYmCSglLBWRuhui7tPc.jpg	t
357	No Tears in Hell	Terror, Crimen, Suspense	2025	Michael Caissie	\N	2025-10-26 21:23:06.21329	https://image.tmdb.org/t/p/w500/zPI3xK4a4oXUZVrxNWLc8Rck0Cd.jpg	t
358	John Candy: Yo me gusto	Documental	2025	Colin Hanks	Del director Colin Hanks y el productor Ryan Reynolds llega John Candy: Yo me gusto. Los que mejor conocieron a John comparten su historia con sus propias palabras a través de imágenes de archivo, fotografías y entrevistas nunca vistas. Es un documental sobre la vida, la carrera y la pérdida de uno de los actores más queridos de todos los tiempos.	2025-10-26 21:23:06.329625	https://image.tmdb.org/t/p/w500/9I7SnpK2dUg3Ebpmf4DtAF0Ztac.jpg	t
359	El reino del planeta de los simios	Ciencia ficción, Aventura, Acción, Drama, Suspense	2024	Wes Ball	Ambientada varias generaciones en el futuro tras el reinado de César, en la que los simios son la especie dominante que vive en armonía y los humanos se han visto reducidos a vivir en la sombra. Mientras un nuevo y tiránico líder simio construye su imperio, un joven simio emprende un angustioso viaje que le llevará a cuestionarse todo lo que sabe sobre el pasado y a tomar decisiones que definirán el futuro de simios y humanos por igual.	2025-10-26 21:23:06.450658	https://image.tmdb.org/t/p/w500/kkFn3KM47Qq4Wjhd8GuFfe3LX27.jpg	t
360	Caza de brujas	Drama, Suspense	2025	Luca Guadagnino	Una profesora universitaria se encuentra en una encrucijada personal y profesional cuando una estudiante estrella acusa a uno de sus compañeros de trabajo y un oscuro secreto de su pasado amenaza con salir a la luz.	2025-10-26 21:23:06.567593	https://image.tmdb.org/t/p/w500/n1hrhyL2VWKilFBcUaoUdvG8QYy.jpg	t
361	Guardianes de la Galaxia: Volumen 3	Ciencia ficción, Aventura, Acción, Comedia	2023	James Gunn	La querida banda de los Guardianes se instala en Knowhere. Pero sus vidas no tardan en verse alteradas por los ecos del turbulento pasado de Rocket. Peter Quill, aún conmocionado por la pérdida de Gamora, debe reunir a su equipo en una peligrosa misión para salvar la vida de Rocket, una misión que, si no se completa con éxito, podría muy posiblemente conducir al final de los Guardianes tal y como los conocemos.	2025-10-26 21:23:06.685762	https://image.tmdb.org/t/p/w500/6GkKzdNosVAL7UGgwTtCHSxLQ67.jpg	t
362	Your Name	Animación, Romance, Drama	2016	Makoto Shinkai	Taki y Mitsuha descubren un día que durante el sueño sus cuerpos se intercambian, y comienzan a comunicarse por medio de notas. A medida que consiguen superar torpemente un reto tras otro, se va creando entre los dos un vínculo que poco a poco se convierte en algo más romántico.	2025-10-26 21:23:06.809881	https://image.tmdb.org/t/p/w500/iaiy3tg9QVkDpObm1IGqmbC9A5C.jpg	t
363	La lista de Schindler	Drama, Historia, Bélica	1993	Steven Spielberg	Oskar Schindler, un hombre de enorme astucia y talento para las relaciones públicas, organiza un ambicioso plan para ganarse la simpatía de los nazis. Después de la invasión de Polonia por los alemanes, consigue, gracias a sus relaciones con los nazis, la propiedad de una fábrica de Cracovia. Allí emplea a cientos de operarios judíos, cuya explotación le hace prosperar rápidamente. Su gerente, también judío, es el verdadero director en la sombra, pues Schindler no tiene el menor conocimiento industrial.	2025-10-26 21:23:06.937606	https://image.tmdb.org/t/p/w500/3Ho0pXsnMxpGJWqdOi0KDNdaTkT.jpg	t
364	La criada	Drama, Romance	1986	Salvatore Samperi	Anna (Guerin), la hermosa esposa de un abogado, se siente abandonada por este, por lo que decide irse unos días con su sirvienta (Michelsen) al pueblo natal de esta. A partir de este momento comenzará una extraña relación entre ellas.	2025-10-26 21:23:07.051182	https://image.tmdb.org/t/p/w500/s9pXocmKhkvLazafoL0oUGIn3Me.jpg	t
365	Sidelined: The QB and Me	Comedia, Romance	2025	Justin Wu	Dallas, una bailarina tenaz pero con problemas, está decidida a entrar en la mejor escuela de baile del país, la escuela de su difunta madre. Sin embargo, ese sueño se ve truncado de repente cuando Drayton, la estrella del fútbol americano, irrumpe en su vida con una historia única. ¿Podrán los dos hacer realidad sus sueños juntos o sus sueños quedarán en el olvido?	2025-10-26 21:23:07.1631	https://image.tmdb.org/t/p/w500/sIWv5HtDlUFvacsuA1fRNWZ5GFH.jpg	t
366	Flash	Aventura, Acción, Ciencia ficción	2023	Andy Muschietti	Cuando su intento de salvar a su familia altera sin darse cuenta el futuro, Barry Allen queda atrapado en una realidad en la que el General Zod ha regresado y no hay superhéroes a quienes recurrir. Para salvar el mundo en el que se encuentra y regresar al futuro que conoce, la única esperanza de Barry es correr por su vida. Pero, ¿será suficiente hacer el sacrificio máximo para restablecer el universo?	2025-10-26 21:23:07.284259	https://image.tmdb.org/t/p/w500/gNbZNuZ2fBferjJspfmvnskODGc.jpg	t
367	Velocidad total	Acción, Crimen, Suspense	2024	James Clayton	Cuando secuestran a su compañero de fechorías después de un robo masivo, un famoso ladrón profesional sigue la pista de los secuestradores hasta el territorio de un despiadado capo de la droga, perseguido por policías corruptos, compinches de bajo nivel y el sicario más letal del sindicato del crimen, un sociópata amante de las armas y fríamente encantador conocido como El Vaquero. Pero con millones de dólares y muchas vidas en juego, ¿cuánto durará la lealtad entre ladrones cuando empiecen a volar las balas?	2025-10-26 21:23:07.39874	https://image.tmdb.org/t/p/w500/kK0ZgJINxy50AkVbCsTRIX0DvbZ.jpg	t
383	A través de mi ventana	Romance, Drama, Comedia	2022	Marçal Forés	Raquel lleva toda la vida loca por Ares, su atractivo y misterioso vecino. Lo observa sin ser vista y es que, muy a su pesar, no han intercambiado ni una palabra. Raquel tiene muy claro su objetivo: conseguir que Ares se enamore de ella. Pero ella no es una niña inocente y no está dispuesta a perderlo todo por el camino, y mucho menos a sí misma...	2025-10-26 21:23:09.253228	https://image.tmdb.org/t/p/w500/3F5MkMadQOWiZNVaNuOuw6UaK7a.jpg	t
368	Batman Begins	Drama, Crimen, Acción	2005	Christopher Nolan	¿Cómo cambia un hombre el mundo? Es una pregunta que obsesiona a Bruce Wayne al igual que el fantasma de sus padres, muertos a tiros ante sus ojos en las calles de Gotham una noche que cambió su vida para siempre. Atormentado por la culpa y la ira, el desilusionado heredero industrial desaparece de Gotham y viaja en secreto por el mundo, buscando los medios de luchar contra la injusticia y utilizar el miedo contra los que se aprovechan de los que tienen miedo. Con la ayuda de su leal mayordomo Alfred, el detective Jim Gordon - uno de los pocos buenos policías de las fuerzas del orden público de Gotham - y Lucius Fox, su aliado en la división de Ciencias Aplicadas de Wayne Enterprises, Bruce Wayne libera a su imponente alter ego: Batman, un justiciero enmascarado que utiliza la fuerza, la inteligencia y un despliegue de artefactos de alta tecnología para combatir las fuerzas siniestras que amenazan con destruir la ciudad.	2025-10-26 21:23:07.52179	https://image.tmdb.org/t/p/w500/6yMWU1vWkOBbNRIwOxhetd2aHhO.jpg	t
369	Guillermo Tell	Acción, Aventura, Drama, Historia	2025	Nick Hamm	En el siglo XIV, las potencias europeas luchan por el dominio del Sacro Imperio Romano. El ambicioso Imperio Austríaco invade la pacífica Suiza, arrasando con todo a su paso. Guillermo Tell, un humilde cazador, se ve obligado a empuñar las armas cuando su familia y su tierra sufren la tiranía del rey austríaco y sus despiadados señores de la guerra.	2025-10-26 21:23:07.622588	https://image.tmdb.org/t/p/w500/f9JBhW0bjkfPufuyNyhcA5s7NVB.jpg	t
370	Rojo, blanco y sangre azul	Comedia, Romance	2023	Matthew López	Tras la elección de su madre como presidenta, el joven Alex Claremont-Diaz es rápidamente elegido como el equivalente estadounidense de un joven miembro de la realeza.	2025-10-26 21:23:07.746431	https://image.tmdb.org/t/p/w500/5XGt6CpWpkGnGOrrjfOMhNzDDSS.jpg	t
371	Wicked Parte II	Drama, Romance, Fantasía	2025	Jon M. Chu	Mientras la multitud alza su clamor contra la Bruja Malvada, Glinda y Elphaba deberán unirse una vez más. Con su singular amistad convertida en el punto de inflexión de su futuro, tendrán que mirarse a los ojos con honestidad y compasión para afrontar su transformación personal y cambiar el destino de todo Oz.	2025-10-26 21:23:07.854668	https://image.tmdb.org/t/p/w500/2UdeIFlCk0OlvkmQEZb0PSdNUWf.jpg	t
372	Enredados	Animación, Familia, Aventura	2010	Nathan Greno	Flynn Rider, el más buscado -y encantador- bandido del reino, se esconde en una misteriosa torre y allí se encuentra con Rapunzel, una bella y avispada adolescente con una cabellera dorada de 21 metros de largo, que vive encerrada allí desde hace años. Ambos sellan un pacto y a partir de ese momento la pareja vivirá emocionantes aventuras en compañía de un caballo superpolicía, un camaleón sobreprotector y una ruda pandilla de matones	2025-10-26 21:23:07.967308	https://image.tmdb.org/t/p/w500/z5kvXWek4smCyeWBDJQkT5sLc9T.jpg	t
373	Madagascar	Familia, Animación, Aventura, Comedia	2005	Eric Darnell	Cuenta la historia de cuatro divertidos animales del zoo de Central Park, Nueva York, (Alex el león, Marty la cebra, Gloria la hipopótamo y Melman la jirafa). Llevan toda su vida encerrados en cautividad sin poder experiemtnar el sabor de la libertad y se han propuesto idear un plan para salir de allí juntos. Un día, una serie de casualidades les llevan a lograr lo que tanto ansiaban y huyen de aquel lugar. Terminan en plena naturaleza, concretamente en la idílica isla de Madagascar. Allí descubrirán, a base de apasionantes aventuras, que la vida salvaje es muy diferente a lo que ellos pensaban y que vivir en libertad no es tan fácil como imaginaban.	2025-10-26 21:23:08.087084	https://image.tmdb.org/t/p/w500/zrV5GnfCcLWzyjrFgYTpjQPRMfl.jpg	t
374	Rosie Dixon - Night Nurse	Comedia	1978	Justin Cartwright	\N	2025-10-26 21:23:08.202404	https://image.tmdb.org/t/p/w500/9tSBdyUa2pk2FJ2Qe2kRsT3LMyo.jpg	t
375	８番出口	Terror, Misterio, Suspense	2025	Genki Kawamura	\N	2025-10-26 21:23:08.336386	https://image.tmdb.org/t/p/w500/mqlgMvy1d5jIbIE6SPlJq724htT.jpg	t
376	TRON	Ciencia ficción, Acción, Aventura	1982	Steven Lisberger	La primera película de aventuras dentro del inexplorado mundo tridimensional del inimaginado dominio de la informática. Tron deslumbra con los revolucionarios efectos visuales y las secuencias de acción. Flynn, un ordenador que inventa vídeojuegos, se encuentra a merced de la malvada fuerza humana que contesta al panel de control principal -la presencia de un poderoso corrupto ordenador que ha radiado Flynn dentro de su juego mortal. Allí, ladrones electrónicos y la imparable carrera «Cycle Lights». Con la ayuda de sus amigos, Alan y Lora, la esperanza de Flynn es activar a Tron, el valiente y fiable programa, en una heroica batalla por salvar a la humanidad!	2025-10-26 21:23:08.437934	https://image.tmdb.org/t/p/w500/mfLMawRqFSqlCJkKkTaQjrURdCI.jpg	t
377	Ahora me ves 3	Suspense, Crimen, Misterio	2025	Ruben Fleischer	Los Cuatro Jinetes regresan junto a una nueva generación de ilusionistas en una extraordinaria aventura que contiene giros asombrosos, sorpresas alucinantes y trucos de magia nunca vistos en la gran pantalla.	2025-10-26 21:23:08.553744	https://image.tmdb.org/t/p/w500/Aspr0HcItNVbgLC8cV0ZAO0EBcc.jpg	t
378	Todo saldrá bien	Drama	2024	Ray Yeung	Tras el repentino fallecimiento de su novia, Angie comienza a luchar no sólo por su propia tranquilidad ante el dolor, sino también por conservar el apartamento al que llamaban hogar, frente a los deseos de la familia de la que fue su pareja. Una de las joyas cinematográficas de esta edición que consiguió el premio Teddy Award LGBTQ+ en el Festival de Berlín y el Premio Rambal en el FICX.	2025-10-26 21:23:08.665637	https://image.tmdb.org/t/p/w500/1PEhxSctFV3BJAc8gWVXDhE7r2N.jpg	t
379	친구엄마	Drama, Romance	2015	Kong Ja-kwan	\N	2025-10-26 21:23:08.779527	https://image.tmdb.org/t/p/w500/5JDVEZN0v3e9xMzZbZ92fC7HaQi.jpg	t
380	La guerra del mañana	Acción, Ciencia ficción, Aventura	2021	Chris McKay	Unos viajeros llegan desde el año 2051 para dar un mensaje: 30 años en el futuro, la humanidad estará perdiendo la guerra contra unos alienígenas. La única esperanza para sobrevivir es que los soldados y civiles vayan al futuro y se sumen a la batalla. Decidido a salvar el mundo por su hija, Dan Forester se une a una científica brillante y a su distante padre para reescribir el destino del planeta.	2025-10-26 21:23:08.900897	https://image.tmdb.org/t/p/w500/tzp6VzED2TBc02bkYoYnQa6r2OK.jpg	t
381	Garfield: La película	Familia, Comedia, Aventura, Animación	2024	Mark Dindal	El mundialmente famoso Garfield, el gato casero que odia los lunes y que adora la lasaña, está a punto de vivir una aventura ¡en el salvaje mundo exterior! Tras una inesperada reunión con su largamente perdido padre – el desaliñado gato callejero Vic – Garfield y su amigo canino Odie se ven forzados a abandonar sus perfectas y consentidas vidas al unirse a Vic en un hilarante y muy arriesgado atraco.	2025-10-26 21:23:09.030038	https://image.tmdb.org/t/p/w500/tkdc73JiPVvzngSpbLEIfFNjll1.jpg	t
382	El hombre de acero	Acción, Aventura, Ciencia ficción	2013	Zack Snyder	Un niño descubre que posee poderes extraordinarios y que no pertenece a este planeta. En su juventud, viaja para descubrir sus orígenes y las razones por las cuales ha sido enviado a la Tierra. Pero el héroe que lleva dentro tiene que emerger para que pueda salvar al mundo de la aniquilación y convertirse en el símbolo de esperanza para la humanidad.	2025-10-26 21:23:09.146618	https://image.tmdb.org/t/p/w500/5JW44QGgpEWx4aWXM0uVSi2xtrI.jpg	t
384	Vengadores: La era de Ultrón	Acción, Aventura, Ciencia ficción	2015	Joss Whedon	Cuando Tony Stark intenta reactivar un programa caído en desuso cuyo objetivo es mantener la paz, las cosas empiezan a torcerse y los héroes más poderosos de la Tierra, incluyendo a Iron Man, Capitán América, Thor, El Increíble Hulk, Viuda Negra y Ojo de Halcón, tendrán que afrontar la prueba definitiva cuando el destino del planeta se ponga en juego. Cuando el villano Ultron emerge, le corresponderá a Los Vengadores detener sus terribles planes, que junto a incómodas alianzas llevarán a una inesperada acción que allanará el camino para una épica y única aventura.	2025-10-26 21:23:09.399197	https://image.tmdb.org/t/p/w500/71wSx6MQm8EbMNDi3vVaD8nD9SL.jpg	t
385	Indomable	Animación, Aventura, Comedia, Familia, Acción, Fantasía	2012	Mark Andrews	Mérida, la indómita hija del Rey Fergus y de la Reina Elinor, es una hábil arquera que decide romper con una antigua costumbre, que es sagrada para los señores de la tierra: el gigantesco Lord MacGuffin, el malhumorado Lord Macintosh y el cascarrabias Lord Dingwall. Las acciones de Merida desencadenan el caos y la furia en el reino. Además, pide ayuda a una sabia anciana que le concede un deseo muy desafortunado. La muchacha tendrá que afrontar grandes peligros antes de aprender qué es la auténtica valentía.	2025-10-26 21:23:09.514358	https://image.tmdb.org/t/p/w500/eVt6IKkzKqNs80TX0JVan6sjH5Z.jpg	t
386	xXx: Reactivated	Acción, Aventura, Crimen	2017	D.J. Caruso	La película gira en torno al regreso de Xander Cage, a quien todos creían muerto. Cage, alias xXx (Triple X), es un rebelde amante de los deportes extremos que adora romper las leyes y que por ello acaba siendo atrapado por las autoridades de EE.UU. Entonces se ve obligado a colaborar como agente encubierto participando en numerosos episodios de riesgo. Tras un fatídico incidente, Xander es dado por muerto. Pero ahora, vuelve a la acción de incógnita acompañado de su agente instructor Augustus Gibbons.	2025-10-26 21:23:09.632382	https://image.tmdb.org/t/p/w500/rc830XBY2h8HBtHeISpR9qb2PU6.jpg	t
387	Bad Man	Acción, Comedia, Crimen	2025	Michael Diliberti	\N	2025-10-26 21:23:09.763656	https://image.tmdb.org/t/p/w500/7vIccLLGDhCOkBUCqEEl3a1Yhc1.jpg	t
388	Joker	Crimen, Suspense, Drama	2019	Todd Phillips	Arthur Fleck es un hombre ignorado por la sociedad, cuya motivación en la vida es hacer reír. Pero una serie de trágicos acontecimientos le llevarán a ver el mundo de otra forma. Película basada en Joker, el popular personaje de DC Comics y archivillano de Batman, pero que en este film toma un cariz más realista y oscuro.	2025-10-26 21:23:09.895824	https://image.tmdb.org/t/p/w500/v0eQLbzT6sWelfApuYsEkYpzufl.jpg	t
389	Pobres criaturas	Ciencia ficción, Romance, Comedia	2023	Giórgos Lánthimos	Bella Baxter es una joven revivida por el brillante y poco ortodoxo científico Dr. Godwin Baxter. Bajo la protección de Baxter, Bella está ansiosa por aprender. Hambrienta de la mundanidad que le falta, Bella se escapa con Duncan Wedderburn, un sofisticado y perverso abogado, en una aventura vertiginosa a través de los continentes. Libre de los prejuicios de su época, Bella se vuelve firme en su propósito de defender la igualdad y la liberación.	2025-10-26 21:23:10.012225	https://image.tmdb.org/t/p/w500/9OYMVcP2zyw0zpWOTuxlDo2MsMw.jpg	t
390	It Follows	Terror, Misterio	2015	David Robert Mitchell	Jay, de 18 años, tiene su primer encuentro sexual con su novio en la parte trasera del coche. Tras el hecho, aparentemente inocente, la situación se pone algo tensa cuando su novio hace que ella se desmaye aplicándole cloroformo.  Al despertar, el novio le explica que lo hizo para ahuyentar a una serie de espíritus que lo acosan. A partir de ese momento, es Jay quien sufrirá las consecuencias de ese acoso, encontrándose sumergida en visiones y pesadillas; teniendo la sensación de que alguien o algo la observa.	2025-10-26 21:23:10.160135	https://image.tmdb.org/t/p/w500/tBdhwg4gqMzJTRvEQbFBAGrTvfB.jpg	t
391	La máscara	Romance, Comedia, Crimen, Fantasía	1994	Chuck Russell	Stanley es un ingenuo empleado de banca incapaz de enterarse de cuándo se aprovechan de él, al que su jefe mangonea, al que su casera humilla, y al que solamente su perro parece ser capaz de aguantar. Su amigo Charlie le invita a ir al cabaret Coco Bongo para intentar estimularle y conseguir que espabile, pero antes de que eso ocurra, aparece la bella Tina Carlyle, que entra en el banco para hablar con Stanley y de paso fotografiar la caja fuerte con una mini cámara. Es entonces cuando Stanley encuentra una máscara que le da grandes poderes y que también le quita todos sus miedos: ahora es libre de actuar como quiera.	2025-10-26 21:23:10.294253	https://image.tmdb.org/t/p/w500/sW0tABq2gGGzdwHKhBs2hupEK11.jpg	t
392	Los Juegos del Hambre: Sinsajo - Parte 1	Ciencia ficción, Aventura, Suspense	2014	Francis Lawrence	Katniss Everdeen se encuentra en el Distrito 13 después de destrozar los Juegos para siempre. Bajo el liderazgo de la comandante Coin y el consejo de sus amigos más leales, Katniss extiende sus alas mientras lucha por salvar a Peeta Mellark y a una nación alentada por su valentía...	2025-10-26 21:23:10.414155	https://image.tmdb.org/t/p/w500/wfLsciidZamFPeOb4FD8ywk1Q9c.jpg	t
393	Up	Animación, Comedia, Familia, Aventura	2009	Pete Docter	Tras atar miles de globos a su casa, Carl Fredricksen, un vendedor de globos jubilado, se embarca en el mundo de los sueños de la infancia. Pero sin que Carl lo sepa, Russell, un explorador de 8 años, se encuentra en el lugar equivocado en el momento equivocado: el porche delantero de la casa. El dúo más improbable conoce a fantásticos amigos como Dug, un perro con un collar especial que le permite hablar, y Kevin, un pájaro de cuatro metros de altura que no vuela. Atrapados en la selva, Carl se da cuenta de que a veces las mayores aventuras de la vida son las que menos esperabas.	2025-10-26 21:23:10.536504	https://image.tmdb.org/t/p/w500/1N0LtzUueXrlnpL466jQBJ6iAuj.jpg	t
394	Rut y Booz	Romance, Drama, Música	2025	Alanna Brown	Relato moderno de una de las historias de amor más emblemáticas de la Biblia. Una joven escapa de la escena musical de Atlanta para cuidar de una anciana viuda y, en el proceso, encuentra al amor de su vida y gana a la madre que nunca tuvo.	2025-10-26 21:23:10.645203	https://image.tmdb.org/t/p/w500/eV57POS08SAcAapjt8ZPp6iYiJE.jpg	t
395	The Amazing Spider-Man 2: El poder de Electro	Acción, Aventura, Ciencia ficción	2014	Marc Webb	Peter Parker lleva una vida muy ocupada, compaginando su tiempo entre su papel como Spider-Man, acabando con los malos, y en el instituto con la persona a la que quiere, Gwen. Peter no ve el momento de graduarse. No ha olvidado la promesa que le hizo al padre de Gwen de protegerla, manteniéndose lejos de ella, pero es una promesa que simplemente no puede cumplir. Las cosas cambiarán para Peter cuando aparece un nuevo villano, Electro, y un viejo amigo, Harry Osborn, regresa, al tiempo que descubre nuevas pistas sobre su pasado.	2025-10-26 21:23:10.78801	https://image.tmdb.org/t/p/w500/pyxjizLYG86Bxl4mntCWaWXZAko.jpg	t
396	El club de los poetas muertos	Drama	1989	Peter Weir	En un elitista y estricto colegio privado de Nueva Inglaterra, un grupo de alumnos descubrirá la poesía, el significado de "Carpe Diem" -aprovechar el momento- y la importancia de perseguir los sueños, gracias a un excéntrico profesor que despierta sus mentes por medio de métodos poco convencionales.	2025-10-26 21:23:10.904028	https://image.tmdb.org/t/p/w500/vsLcmuk8KBN73spAIEwm1nLNSjc.jpg	t
397	Venom	Ciencia ficción, Acción	2018	Ruben Fleischer	Eddie Brock es un consolidado periodista y astuto reportero que está investigando una empresa llamada Fundación Vida. Esta fundación, dirigida por el eminente científico Carlton Drake, está ejecutando secretamente experimentos ilegales en seres humanos y realizando pruebas que involucran formas de vida extraterrestres y amorfas conocidas como simbiontes. Durante una visita furtiva a la central, el periodista quedará infectado por un simbionte. Comenzará entonces a experimentar cambios en su cuerpo que no entiende, y escuchará una voz interior, la del simbionte Venom, que le dirá lo que tiene que hacer. Cuando Brock adquiera los poderes del simbionte que le usa como huésped, Venom tomará posesión de su cuerpo, convirtiéndole en un despiadado y peligroso súpervillano.	2025-10-26 21:23:11.027227	https://image.tmdb.org/t/p/w500/jMBTJQiHAyGlZR05J2sq5coA6ew.jpg	t
398	सितारे ज़मीन पर	Comedia, Drama	2025	R. S. Prasanna	\N	2025-10-26 21:23:11.144626	https://image.tmdb.org/t/p/w500/adYjCJGSNiL7CIaDW3g0Bcg7r2Z.jpg	t
399	Shutter Island	Drama, Suspense, Misterio	2010	Martin Scorsese	Verano de 1954. Los agentes judiciales Teddy Daniels y Chuck Aule son destinados a una remota isla del puerto de Boston para investigar la desaparición de una peligrosa asesina recluida en el hospital psiquiátrico Ashecliffe, un centro penitenciario para criminales perturbados dirigido por el siniestro doctor John Cawley. Pronto descubrirán que el centro guarda muchos secretos, y que la isla esconde algo más peligroso que los pacientes.	2025-10-26 21:23:11.277713	https://image.tmdb.org/t/p/w500/oemYX0Do8bxqVHtfCJA9c32Q5w5.jpg	t
400	The Veteran	Acción, Crimen, Suspense	2011	Matthew Hope	Tras combatir en la guerra de Afganistán, el soldado Robert Miller (Toby Kebbell) regresa a su casa de Inglaterra. Pronto encuentra trabajo de vigilante encubierto y empieza a obsesionarse con un grupo de gángsteres que están relacionados con una célula terrorista. Firmemente decidido a investigar por su cuenta, se verá envuelto en una situación enormemente peligrosa. (FILMAFFINITY)	2025-10-26 21:23:11.382217	https://image.tmdb.org/t/p/w500/i1gSsXTWtCmNQArmIeUpAysHEmi.jpg	t
401	El precio del poder	Acción, Crimen, Drama	1983	Brian De Palma	Un emigrante cubano frío y sanguinario, Tony Montana, llega de Cuba para instalarse en Miami, donde se propone hacerse con un nombre dentro del crimen organizado de Florida. Junto a su amigo, Manny Rivera, inicia una ascendente carrera delictiva.	2025-10-26 21:23:11.50283	https://image.tmdb.org/t/p/w500/iDABT5GD9OQmFiXM3wR0DJIxtkY.jpg	t
402	Warfare: Tiempo de guerra	Bélica, Acción	2025	Ray Mendoza	Basada en las experiencias reales del ex marine Ray Mendoza (codirector y coguionista de la película) durante la guerra de Irak. Introduce al espectador en la experiencia de un pelotón de Navy SEALs estadounidenses. Concretamente en una misión de vigilancia que se tuerce en territorio insurgente. Una historia visceral y a pie de campo sobre la guerra moderna y la hermandad, contada como nunca antes: en tiempo real y basada en los recuerdos de quienes la vivieron.	2025-10-26 21:23:11.618022	https://image.tmdb.org/t/p/w500/fkVpNJugieKeTu7Se8uQRqRag2M.jpg	t
403	Anaconda	Aventura, Terror, Suspense	2024	Xiang Qiuliang	Un equipo de circo en apuros es engañado por su ex socio, mientras se embarca en una gira por Tailandia. Durante el viaje a través de una selva tropical del sudeste asiático, se enfrentan a ataques de una pitón gigante. Conocen a un hombre misterioso llamado Jeff que se ofrece a ayudar, pero pronto se dan cuenta de que es un cazador furtivo. Mientras buscan el barco de Jeff, se enfrentan a luchas de vida o muerte con la pitón y el propio Jeff.	2025-10-26 21:23:11.727756	https://image.tmdb.org/t/p/w500/9a7URTaq1Eimlg2ZujPX9FdOeGK.jpg	t
404	Pactar con el diablo	Drama, Misterio, Terror	1997	Taylor Hackford	Kevin Lomax (Keanu Reeves) es un joven y brillante abogado que nunca ha perdido un caso. Vive en Florida y parece feliz con su esposa, Mary Ann (Charlize Theron). Un día, recibe la visita de un abogado de Nueva York, que representa a un poderoso bufete que tiene la intención de contratarlo. Al frente de la prestigiosa empresa se encuentra John Milton (Al Pacino), un hombre mundano, brillante y carismático, que alberga planes muy oscuros con respecto a Lomax.	2025-10-26 21:23:11.890982	https://image.tmdb.org/t/p/w500/rOXciqRgEXqRvvYS6Dk2im3NF7H.jpg	t
405	Kandungan	Romance, Drama	2025	Joel Ferrer	\N	2025-10-26 21:23:12.003113	https://image.tmdb.org/t/p/w500/5F5yEFbsVIygB1ztyuFZbf9lKhm.jpg	t
406	Harta	Suspense, Drama, Crimen	2025	Tyler Perry	¿Cuál será la gota que colme el vaso? Un día devastador lleva al límite a una madre soltera y trabajadora, y la empuja a cometer un impactante acto de desesperación.	2025-10-26 21:23:12.115475	https://image.tmdb.org/t/p/w500/4d2PJ6QLAVd9w66E918JSWjkgs7.jpg	t
407	Solo Leveling: ReAwakening	Acción, Aventura, Fantasía, Animación	2024	Shunsuke Nakashige	Ha pasado más de una década desde que un camino llamado "portal" que conecta este mundo con una dimensión alternativa apareció de repente, y personas con poderes sobrehumanos llamados "cazadores" han despertado. Los cazadores usan sus poderes sobrehumanos para conquistar mazmorras dentro de los portales para ganarse la vida y Sung Jinwoo, un cazador del rango más bajo, es considerado como el Cazador Más débil de Toda la Humanidad. Un día se encuentra con una mazmorra doble, una mazmorra de alto nivel oculta dentro de una de bajo nivel. Frente a un Jinwoo gravemente herido, surge una misteriosa ventana hacia una misión. Al borde de la muerte, Jinwoo decide encargarse de la misión, que le convierte en la única persona capaz de subir de nivel. Largometraje formado por una recapitulación de la primera temporada de la serie de anime homónima junto con un avance exclusivo de los dos primeros episodios de la segunda temporada.	2025-10-26 21:23:12.222944	https://image.tmdb.org/t/p/w500/diPEcLFEb1uuUpApol1Bit6ck3l.jpg	t
408	罗小黑战记 2	Animación, Fantasía, Acción	2025	顾杰	\N	2025-10-26 21:23:12.32345	https://image.tmdb.org/t/p/w500/rmdy6AVOlFEne4IM5Jj0WBOhCBP.jpg	t
409	The Amazing Spider-Man	Acción, Aventura, Ciencia ficción	2012	Marc Webb	Un estudiante de secundaria que fue abandonado por sus padres cuando era niño, dejándolo a cargo de su tío Ben y su tía May. Como la mayoría de los adolescentes de su edad, Peter trata de averiguar quién es y qué quiere llegar a ser. Peter también está encontrando su camino con su primer amor de secundaria, Gwen Stacy, y juntos luchan por su amor con compromiso. Cuando Peter descubre un misterioso maletín que perteneció a su padre, comienza la búsqueda para entender la desaparición de sus padres, una búsqueda que le lleva directamente a Oscorp, el laboratorio del Dr Curt Connors, ex-compañero de trabajo de su padre. Mientras Spider-Man se encuentra en plena colisión con el alter-ego de Connors, el Lagarto, Peter hará elecciones que alterarán sus opciones para usar sus poderes y darán forma a un destino héroico.	2025-10-26 21:23:12.454671	https://image.tmdb.org/t/p/w500/4cw1Vpp68ec518BHiS6gfa3yDoU.jpg	t
410	Misión: Imposible - Sentencia mortal parte uno	Acción, Aventura, Suspense	2023	Christopher McQuarrie	Ethan Hunt y la IMF emprenden la misión más peligrosa a la que nunca se han enfrentado: rastrear una nueva y aterradora arma que amenaza a toda la humanidad antes de que caiga en las manos de un enemigo todopoderoso y misterioso.	2025-10-26 21:23:12.565045	https://image.tmdb.org/t/p/w500/83sGKvCv2T2CulYbd40Aeduc7n2.jpg	t
411	El castillo ambulante	Fantasía, Animación, Aventura	2004	Hayao Miyazaki	Sophie, una joven sobre la que pesa una horrible maldición que le confiere el aspecto de una anciana, decide pedir ayuda al mago Howl, que vive en un castillo ambulante, pero tal vez sea Howl quien necesite la ayuda de Sophie.	2025-10-26 21:23:12.677538	https://image.tmdb.org/t/p/w500/p8EARnEw8KPZzlZg3vkseYVMczu.jpg	t
412	Amenaza en el aire	Acción, Suspense	2025	Mel Gibson	En este claustrofóbico thriller, un piloto (Mark Wahlberg) transporta en su avioneta a una agente del servicio de MARSHALS de Estados Unidos (Michelle Dockery) que custodia a un testigo (Topher Grace) que va a testificar en un juicio contra la mafia. A medida que atraviesan las montañas de Alaska, las tensiones se disparan, ya que no todo el mundo a bordo es quien parece ser. Y a 3.000 metros de altura no hay escapatoria posible.	2025-10-26 21:23:12.796665	https://image.tmdb.org/t/p/w500/8T6nkYb4W8BIeafmFffyfsRciTL.jpg	t
413	Until Dawn	Terror, Misterio	2025	David F. Sandberg	Un año después de la misteriosa desaparición de su hermana Melanie, Clover y sus amigas se dirigen al remoto valle donde desapareció en busca de respuestas. Mientras exploran un centro de visitantes abandonado, son acechadas por un asesino enmascarado que las mata una a una de forma horrible… para después despertar y encontrarse de nuevo al principio de la misma noche.	2025-10-26 21:23:12.910442	https://image.tmdb.org/t/p/w500/exgfubqSbF4veI4uXFOdbV66gEf.jpg	t
414	Batman vs Superman: El amanecer de la justicia	Acción, Aventura, Fantasía	2016	Zack Snyder	Ante el temor de las acciones que pueda llevar a cabo Superman, el vigilante de Gotham City aparece para poner a raya al superhéroe de Metrópolis, mientras que la opinión pública debate cuál es realmente el héroe que necesitan. El hombre de acero y Batman se sumergen en una contienda territorial, pero las cosas se complican cuando una nueva y peligrosa amenaza surge rápidamente, poniendo en jaque la existencia de la humanidad.	2025-10-26 21:23:13.051939	https://image.tmdb.org/t/p/w500/mS3t9puIjLKgoex82cu9d6G0835.jpg	t
415	Todo a la vez en todas partes	Acción, Aventura, Ciencia ficción	2022	Daniel Scheinert	Cuando una ruptura interdimensional altera la realidad, Evelyn, una inmigrante china en Estados Unidos, se ve envuelta en una aventura salvaje en la que sólo ella puede salvar el mundo. Perdida en los mundos infinitos del multiverso, esta heroína inesperada debe canalizar sus nuevos poderes para luchar contra los extraños y desconcertantes peligros del multiverso mientras el destino del mundo pende de un hilo.	2025-10-26 21:23:13.155565	https://image.tmdb.org/t/p/w500/9R1zEZJkIah6GuLwFZWsuygn552.jpg	t
416	El show de Truman	Comedia, Drama	1998	Peter Weir	Truman Burbank es un hombre corriente y algo ingenuo que ha vivido toda su vida en uno de esos pueblos donde nunca pasa nada. Sin embargo, de repente, unos extraños sucesos le hacen sospechar que algo anormal está ocurriendo. Todos sus amigos son actores, toda su ciudad es un plató, toda su vida está siendo filmada y emitida como el reality más ambicioso de la historia.	2025-10-26 21:23:13.274348	https://image.tmdb.org/t/p/w500/4BGVZSwv5n0hMIAWwiSjMFDQ63K.jpg	t
417	Hotel Transilvania: Transformanía	Animación, Comedia, Familia, Aventura, Fantasía	2022	Jennifer Kluska	Drac y la pandilla vuelven, como nunca los habías visto antes en Hotel Transilvania: Transformanía. Volveremos a encontrarnos con nuestros monstruos favoritos en una aventura completamente nueva en la que Drac se enfrentará a una de las situaciones más aterradoras vividas hasta el momento. Cuando el misterioso invento de Van Helsing, el "Rayo Monstrificador", se vuelve totalmente fuera de control, Drac y sus monstruosos amigos se transforman en humanos, ¡y Johnny se convierte en un monstruo!	2025-10-26 21:23:13.388854	https://image.tmdb.org/t/p/w500/xNF8AxJc966FWk4SYqXxGHaZLHZ.jpg	t
418	Uno de los nuestros	Drama, Crimen	1990	Martin Scorsese	Henry, un niño de trece años de Brooklyn, vive fascinado con el mundo de los gángsters. Su sueño se hace realidad cuando entra a formar parte de la familia Pauline, dueña absoluta de la zona, que lo educan como un miembro más de la banda convirtiéndole en un destacado mafioso.	2025-10-26 21:23:13.51145	https://image.tmdb.org/t/p/w500/3Yy0zBO9AlyAZH1cTI8Ko2ouCi.jpg	t
419	Elemental	Familia, Fantasía, Comedia, Romance, Animación	2023	Peter Sohn	En una ciudad donde los residentes del fuego, el agua, la tierra y el aire viven juntos, una joven apasionada y un chico que se deja llevar por la corriente descubrirán algo elemental: cuánto tienen en común.	2025-10-26 21:23:13.633341	https://image.tmdb.org/t/p/w500/d79DeKDCgFOM23O8Dr6MELZVooY.jpg	t
420	La momia	Aventura, Acción, Fantasía	1999	Stephen Sommers	El legionario Rick O'Connell y su socio descubren durante una batalla en Egipto las ruinas de Hamunaptra, la ciudad de los muertos. Pasado un tiempo, este descubrimiento le permitirá salvar su vida y volver al lugar con una egiptóloga y su hermano, donde coinciden con un grupo de americanos. Todos ellos, seducidos por la aventura, provocarán la resurrección de la momia de un diabólico sacerdote egipcio que intenta desesperadamente recuperar a su amada.	2025-10-26 21:23:13.757696	https://image.tmdb.org/t/p/w500/aGRMxB5ve2nSKsq8ww6PyUwhWpP.jpg	t
421	El cuervo	Acción, Fantasía, Terror	2024	Rupert Sanders	Eric Draven y Shelly Webster son brutalmente asesinados cuando los demonios de su oscuro pasado les alcanzan. Ante la oportunidad de sacrificarse para salvar a su verdadero amor, Eric se propone vengarse despiadadamente de sus asesinos, atravesando el mundo de los vivos y los muertos para saldar sus deudas.	2025-10-26 21:23:13.895074	https://image.tmdb.org/t/p/w500/uUUx4kN6uCvXnjGWOv79gUBxdYE.jpg	t
422	Scary Movie 2	Comedia	2001	Keenen Ivory Wayans	En esta ocasión los hermanos Wayans empiezan la historia con una satírica parodia de El Exorcista, mostrando a James Woods en el papel de un cura poco convencional, el padre McFelly, ocupado en salvar a una Natasha Lyonne de un espíritu de otro mundo. Entonces, retomando la historia donde la dejaron, los hermanos Wayans se vuelven a reunir de forma cómica con la heroína Cindy Campbell, convertida ahora en una buena estudiante universitaria. Un profesor loco la recluta a ella y a su grupo de compañeros deseosos de vivir aventuras y nuevas experiencias, para una salida de fin de semana bajo el pretexto de realizar un experimento científico. Mientras se desarollan las actividades del fin de semana, las continuas sorpresas mantienen la diversión siempre en marcha.	2025-10-26 21:23:14.205089	https://image.tmdb.org/t/p/w500/90G7YLxKXbEdfcRvlOSRBwbTLS6.jpg	t
423	Deadpool	Acción, Aventura, Comedia	2016	Tim Miller	Basado en el anti-héroe menos convencional de Marvel, Deadpool narra el origen de un ex agente de las fuerzas especiales llamado Wade Wilson, reconvertido a mercenario, y que tras ser sometido a un cruel experimento para curar su cáncer adquiere poderes de curación rápida, adoptando entonces el alter ego de Deadpool. Armado con sus nuevas habilidades y un oscuro y retorcido sentido del humor, Deadpool intentará dar caza al hombre que casi destruye su vida.	2025-10-26 21:23:14.337745	https://image.tmdb.org/t/p/w500/3TUYy0XvhPQBhrXJwRIaOoYFOBO.jpg	t
424	Adopted 2	Terror	2025	Chris Stokes	\N	2025-10-26 21:23:14.483089	https://image.tmdb.org/t/p/w500/ApmGXLfnw93k3vGuHuLskxIzj2h.jpg	t
425	Troya	Bélica, Acción, Historia	2004	Wolfgang Petersen	A lo largo de los tiempos, los hombres han hecho la guerra. Unos por poder, otros por gloria o por honor, y algunos por amor. En la antigua Grecia, la pasión de dos de los amantes más legendarios de la historia, Paris, príncipe de Troya y Helena, reina de Esparta, desencadena una guerra que asolará una civilización. El rapto de Helena por Paris, separándola de su esposo, el rey Menelao, es un insulto que El orgullo familiar establece que una afrenta a Menelao es una afrenta a su hermano Agamenón, el poderoso rey de Micenas, que no tarda en reunir a todas las grandes tribus de Grecia para recuperar a Helena de manos de los troyanos y defender el honor de su hermano. La verdad es que la lucha por el honor por parte de Agamenón está corrompida por su incontenible codicia ya que necesita conquistar Troya para asumir el control del mar Egeo.	2025-10-26 21:23:14.615258	https://image.tmdb.org/t/p/w500/mBiDQT28DnuYaJSL4nDD43ORE6p.jpg	t
426	Strangers: Capítulo 1	Terror, Suspense	2024	Renny Harlin	Tras sufrir una avería en su coche en un pequeño e inquietante pueblecito de Oregón, una joven pareja (Madelaine Petsch y Froy Gutiérrez) se ve obligada a pasar la noche en una aislada cabaña en medio del bosque. El pánico se apodera de ellos cuando son aterrorizados por tres extraños enmascarados que les atacan sin piedad ni motivo alguno.	2025-10-26 21:23:14.721677	https://image.tmdb.org/t/p/w500/1rTRllZNEAX30dTxYL1hONR6gPj.jpg	t
427	Train to Busan	Terror, Suspense, Acción, Aventura	2016	연상호	Un virus letal se expande por Corea del Sur, provocando violentos altercados. Los pasajeros de un tren KTX que viaja de Seúl a Busan tendrán que luchar por su supervivencia.	2025-10-26 21:23:14.828597	https://image.tmdb.org/t/p/w500/anomz7b3GQtHPFH34SODDBBIUad.jpg	t
428	La monja	Terror	2018	Corin Hardy	Cuando una joven monja se suicida en una abadía de clausura en Rumanía, un sacerdote experto en posesiones demoniacas y una novicia a punto de tomar sus votos, son enviados por el Vaticano para investigar. Juntos descubren el profano secreto de la orden. Arriesgando no solo sus propias vidas sino su fe y hasta sus almas, se enfrentan a una fuerza maléfica en forma de monja demoníaca, en una abadía que se convierte en un campo de batalla de horror entre los vivos y los condenados....	2025-10-26 21:23:14.953212	https://image.tmdb.org/t/p/w500/7fxjwtEvqI1BYkXEbGqJ3dQBgXD.jpg	t
429	Despierta la furia	Suspense, Crimen, Drama	2021	Guy Ritchie	H (Jason Statham) es el misterioso tipo que acaba de incorporarse como guardia de seguridad en una compañía de furgones blindados. Durante un intento de atraco a su camión, sorprende a sus compañeros mostrando habilidades propias de un soldado profesional, dejando al resto del equipo preguntándose quién es realmente y de dónde viene.	2025-10-26 21:23:15.073548	https://image.tmdb.org/t/p/w500/emM894kjspdQsHyTAF7sjRNlbTr.jpg	t
430	X-Men: Días del futuro pasado	Acción, Aventura, Ciencia ficción	2014	Bryan Singer	Ambientada en la década de los 70, los miembros de la famosa Patrulla X tendrán que evitar un futuro apocalíptico en el que los mutantes luchan por sobrevivir en campos de concentración controlados por los temibles Centinelas. Para ello, los héroes del universo Marvel deberán unificar sus fuerzas dejando a un lado la creciente enemistad de los bandos liderados por Charles Xavier y Magneto. Trask Industries, la empresa encargada de crear a estos gigantescos cazamutantes, será el origen de todos sus problemas. Tan sólo viajando en el tiempo podrán impedir la masacre que se avecina. ¿Serán capaces nuestros héroes de derrocar a la multinacional y evitar así el exterminio de su especie?	2025-10-26 21:23:15.182638	https://image.tmdb.org/t/p/w500/ggb9nmS5alJuA0ll0iU5YHiGbb0.jpg	t
431	Red	Animación, Familia, Comedia, Fantasía	2022	Domee Shi	Mei Lee, una niña de 13 años un poco rara pero segura de sí misma, se debate entre ser la hija obediente que su madre quiere que sea y el caos propio de la adolescencia. Ming, su protectora y ligeramente exigente madre, no se separa nunca de ella lo que es una situación poco deseable para una adolescente. Y por si los cambios en su vida y en su cuerpo no fueran suficientes, cada vez que se emociona demasiado (lo que le ocurre prácticamente todo el tiempo), se convierte en un panda rojo gigante.	2025-10-26 21:23:15.41163	https://image.tmdb.org/t/p/w500/djM4COTksd5YRIdd9uEl8eA3iaa.jpg	t
432	Tiburón	Terror, Suspense, Aventura	1975	Steven Spielberg	En la costa de un pequeño pueblo del Este de Estados Unidos, un enorme tiburón ataca a varias personas. Temiendo las fatales consecuencias que esto puede provocar en el negocio turístico, el alcalde se niega a cerrar las playas y a difundir la noticia. Pero un nuevo ataque del tiburón, en la propia playa, termina con la vida de otro bañista. El terror se ha hecho público, así que un veterano cazador de tiburones, un científico y el jefe de la policía local se unen para dar caza al temible escualo...	2025-10-26 21:23:15.521662	https://image.tmdb.org/t/p/w500/85MbaRlyfZfZGVHoFy2Am53oVYt.jpg	t
433	The Imitation Game (Descifrando Enigma)	Historia, Drama, Suspense, Bélica	2014	Morten Tyldum	Durante el invierno de 1952, las autoridades británicas entraron en el hogar del matemático, analista y héroe de guerra Alan Turing, con la intención de investigar la denuncia de un robo. Al final acabaron arrestando a Turing acusándole de indecencia grave, un cargo que le supondría una devastadora condena por una ofensa criminal: ser homosexual. Los oficiales no tenían ni idea de que en realidad estaban incriminando al pionero de la informática actual. Liderando a un heterogéneo grupo de académicos, lingüistas, campeones de ajedrez y oficiales de inteligencia, se le conoce por haber descifrado el código de la inquebrantable máquina Enigma de los alemanes durante la Segunda Guerra Mundial.	2025-10-26 21:23:15.648752	https://image.tmdb.org/t/p/w500/pdd20KgHJec4BM4sfHS8oefaDUI.jpg	t
434	Frankenstein de Mary Shelley	Drama, Terror, Ciencia ficción, Romance	1994	Kenneth Branagh	La prematura muerte de su madre durante un parto, arranca violentamente a Víctor Frankenstein de su idílica vida en Ginebra. Desde ese día, la posibilidad de vencer a la muerte será su obsesión y, por ello, decide estudiar medicina en Inglostadt. Allí conoce al siniestro profesor Waldman, de quien se rumorea que pasó su juventud estudiando la posibilidad de crear un ser humano. Víctor no sólo se interesa por sus experimentos, sino que está dispuesto a llegar hasta el fondo de la cuestión cueste lo que cueste.	2025-10-26 21:23:15.766947	https://image.tmdb.org/t/p/w500/7GfuEPctwozCMdLyX2zdbhAEW7D.jpg	t
435	Presence	Terror, Suspense, Drama	2025	Steven Soderbergh	Una pareja y sus hijos se mudan a una casa suburbana aparentemente normal. Cuando ocurren eventos extraños, comienzan a creer que hay algo más en la casa con ellos. La presencia está a punto de perturbar sus vidas de formas inimaginables.	2025-10-26 21:23:15.880645	https://image.tmdb.org/t/p/w500/8mRO5AdZ4Rn1crgjTHaUnWWhJXB.jpg	t
\.


--
-- TOC entry 5077 (class 0 OID 16402)
-- Dependencies: 222
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (usuario_id, nombre_usuario, email, contrasena_hash, tipo_usuario, fecha_registro, esta_activo) FROM stdin;
41	admin	admin@cinepp.com	$2b$12$f63eGsNQMLSG3ynxzrXFKu24FmEPJ.cmY0RqpmeuuEfI2yllyxWCS	Administrador	\N	t
43	Fabian Hurtado	fabianrojasx83@gmail.com	$2b$12$TGiFkn2Y0NawOy8vrRbf2ucnzFWwAf0DrB8HD.840t6DJ0JXfu1Fa	Usuario Final	\N	t
44	nash	nasleja1999@gmail.com	$2b$12$rlu.hLJUXBGPSFtdx7ZnM.rrVvYh0GKeDYosqvyaxYk8mBaY8T/ya	Usuario Final	\N	t
\.


--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 227
-- Name: actores_actor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.actores_actor_id_seq', 3240, true);


--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 223
-- Name: calificaciones_calificacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.calificaciones_calificacion_id_seq', 2, true);


--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 225
-- Name: comentarios_comentario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comentarios_comentario_id_seq', 2, true);


--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 219
-- Name: peliculas_pelicula_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.peliculas_pelicula_id_seq', 435, true);


--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 221
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_usuario_id_seq', 44, true);


--
-- TOC entry 4915 (class 2606 OID 16492)
-- Name: actores actores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.actores
    ADD CONSTRAINT actores_pkey PRIMARY KEY (actor_id);


--
-- TOC entry 4907 (class 2606 OID 16433)
-- Name: calificaciones calificaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calificaciones
    ADD CONSTRAINT calificaciones_pkey PRIMARY KEY (calificacion_id);


--
-- TOC entry 4909 (class 2606 OID 16435)
-- Name: calificaciones calificaciones_usuario_id_pelicula_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calificaciones
    ADD CONSTRAINT calificaciones_usuario_id_pelicula_id_key UNIQUE (usuario_id, pelicula_id);


--
-- TOC entry 4913 (class 2606 OID 16459)
-- Name: comentarios comentarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios
    ADD CONSTRAINT comentarios_pkey PRIMARY KEY (comentario_id);


--
-- TOC entry 4920 (class 2606 OID 16500)
-- Name: pelicula_actores pelicula_actores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pelicula_actores
    ADD CONSTRAINT pelicula_actores_pkey PRIMARY KEY (pelicula_id, actor_id);


--
-- TOC entry 4898 (class 2606 OID 16400)
-- Name: peliculas peliculas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peliculas
    ADD CONSTRAINT peliculas_pkey PRIMARY KEY (pelicula_id);


--
-- TOC entry 4901 (class 2606 OID 16420)
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- TOC entry 4903 (class 2606 OID 16418)
-- Name: usuarios usuarios_nombre_usuario_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_nombre_usuario_key UNIQUE (nombre_usuario);


--
-- TOC entry 4905 (class 2606 OID 16416)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usuario_id);


--
-- TOC entry 4916 (class 1259 OID 16511)
-- Name: idx_actores_nombre; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_actores_nombre ON public.actores USING btree (nombre);


--
-- TOC entry 4910 (class 1259 OID 16472)
-- Name: idx_calificaciones_pelicula; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_calificaciones_pelicula ON public.calificaciones USING btree (pelicula_id);


--
-- TOC entry 4911 (class 1259 OID 16471)
-- Name: idx_calificaciones_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_calificaciones_usuario ON public.calificaciones USING btree (usuario_id);


--
-- TOC entry 4918 (class 1259 OID 16512)
-- Name: idx_pelicula_actores_actor; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pelicula_actores_actor ON public.pelicula_actores USING btree (actor_id);


--
-- TOC entry 4894 (class 1259 OID 16470)
-- Name: idx_peliculas_busqueda; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_peliculas_busqueda ON public.peliculas USING btree (titulo, genero, director);


--
-- TOC entry 4895 (class 1259 OID 16478)
-- Name: idx_peliculas_esta_activo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_peliculas_esta_activo ON public.peliculas USING btree (esta_activo);


--
-- TOC entry 4896 (class 1259 OID 16473)
-- Name: idx_peliculas_portada; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_peliculas_portada ON public.peliculas USING btree (portada_url) WHERE (portada_url IS NOT NULL);


--
-- TOC entry 4899 (class 1259 OID 16479)
-- Name: idx_usuarios_esta_activo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_esta_activo ON public.usuarios USING btree (esta_activo);


--
-- TOC entry 4917 (class 1259 OID 16493)
-- Name: ix_actores_actor_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_actores_actor_id ON public.actores USING btree (actor_id);


--
-- TOC entry 4921 (class 2606 OID 16441)
-- Name: calificaciones calificaciones_pelicula_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calificaciones
    ADD CONSTRAINT calificaciones_pelicula_id_fkey FOREIGN KEY (pelicula_id) REFERENCES public.peliculas(pelicula_id) ON DELETE CASCADE;


--
-- TOC entry 4922 (class 2606 OID 16436)
-- Name: calificaciones calificaciones_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calificaciones
    ADD CONSTRAINT calificaciones_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(usuario_id) ON DELETE CASCADE;


--
-- TOC entry 4923 (class 2606 OID 16465)
-- Name: comentarios comentarios_pelicula_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios
    ADD CONSTRAINT comentarios_pelicula_id_fkey FOREIGN KEY (pelicula_id) REFERENCES public.peliculas(pelicula_id) ON DELETE CASCADE;


--
-- TOC entry 4924 (class 2606 OID 16460)
-- Name: comentarios comentarios_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comentarios
    ADD CONSTRAINT comentarios_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(usuario_id) ON DELETE CASCADE;


--
-- TOC entry 4925 (class 2606 OID 16506)
-- Name: pelicula_actores pelicula_actores_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pelicula_actores
    ADD CONSTRAINT pelicula_actores_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.actores(actor_id) ON DELETE CASCADE;


--
-- TOC entry 4926 (class 2606 OID 16501)
-- Name: pelicula_actores pelicula_actores_pelicula_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pelicula_actores
    ADD CONSTRAINT pelicula_actores_pelicula_id_fkey FOREIGN KEY (pelicula_id) REFERENCES public.peliculas(pelicula_id) ON DELETE CASCADE;


-- Completed on 2025-10-27 08:40:55

--
-- PostgreSQL database dump complete
--

\unrestrict PFF41qHjF3JwDvUzMzX6FlZCtonUUtQCXmkli2bwVALhQNkfa9HR5RFHw1PwDl7

