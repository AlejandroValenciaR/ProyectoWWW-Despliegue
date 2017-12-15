--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

-- Started on 2017-12-15 02:31:10 COT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12655)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2627 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 192 (class 1259 OID 90236)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 90234)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO postgres;

--
-- TOC entry 2628 (class 0 OID 0)
-- Dependencies: 191
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- TOC entry 194 (class 1259 OID 90246)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 90244)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO postgres;

--
-- TOC entry 2629 (class 0 OID 0)
-- Dependencies: 193
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- TOC entry 190 (class 1259 OID 90228)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 90226)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO postgres;

--
-- TOC entry 2630 (class 0 OID 0)
-- Dependencies: 189
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- TOC entry 196 (class 1259 OID 90254)
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 90264)
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 90262)
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO postgres;

--
-- TOC entry 2631 (class 0 OID 0)
-- Dependencies: 197
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- TOC entry 195 (class 1259 OID 90252)
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO postgres;

--
-- TOC entry 2632 (class 0 OID 0)
-- Dependencies: 195
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- TOC entry 200 (class 1259 OID 90272)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 90270)
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- TOC entry 2633 (class 0 OID 0)
-- Dependencies: 199
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- TOC entry 202 (class 1259 OID 90332)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 90330)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO postgres;

--
-- TOC entry 2634 (class 0 OID 0)
-- Dependencies: 201
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- TOC entry 188 (class 1259 OID 90218)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 90216)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO postgres;

--
-- TOC entry 2635 (class 0 OID 0)
-- Dependencies: 187
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- TOC entry 186 (class 1259 OID 90207)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 90205)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO postgres;

--
-- TOC entry 2636 (class 0 OID 0)
-- Dependencies: 185
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- TOC entry 215 (class 1259 OID 90470)
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 90363)
-- Name: eventos_actividad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE eventos_actividad (
    id integer NOT NULL,
    nombre character varying(200) NOT NULL,
    descripcion character varying(5000) NOT NULL,
    estado character varying(10) NOT NULL,
    fecha_creacion timestamp with time zone NOT NULL,
    hora_inicio time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    evento_id integer NOT NULL,
    dia_actividad integer NOT NULL
);


ALTER TABLE eventos_actividad OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 90361)
-- Name: eventos_actividad_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE eventos_actividad_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eventos_actividad_id_seq OWNER TO postgres;

--
-- TOC entry 2637 (class 0 OID 0)
-- Dependencies: 203
-- Name: eventos_actividad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE eventos_actividad_id_seq OWNED BY eventos_actividad.id;


--
-- TOC entry 206 (class 1259 OID 90374)
-- Name: eventos_evento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE eventos_evento (
    id integer NOT NULL,
    nombre character varying(200) NOT NULL,
    fecha_creacion timestamp with time zone NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    estado boolean NOT NULL,
    ubicacion character varying(200) NOT NULL,
    banner character varying(100) NOT NULL,
    descripcion character varying(10000) NOT NULL,
    valor_inscripcion bigint NOT NULL
);


ALTER TABLE eventos_evento OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 90372)
-- Name: eventos_evento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE eventos_evento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eventos_evento_id_seq OWNER TO postgres;

--
-- TOC entry 2638 (class 0 OID 0)
-- Dependencies: 205
-- Name: eventos_evento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE eventos_evento_id_seq OWNED BY eventos_evento.id;


--
-- TOC entry 208 (class 1259 OID 90385)
-- Name: eventos_inscripcion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE eventos_inscripcion (
    id integer NOT NULL,
    fecha_inscripcion timestamp with time zone NOT NULL,
    estado character varying(50) NOT NULL,
    evento_id integer NOT NULL,
    inscrito bigint NOT NULL,
    celular bigint NOT NULL,
    direccion_inscrito character varying(100) NOT NULL,
    nombre_inscrito character varying(50) NOT NULL,
    telefono bigint NOT NULL,
    pais character varying(10) NOT NULL,
    sexo character varying(10) NOT NULL,
    correo character varying(254) NOT NULL
);


ALTER TABLE eventos_inscripcion OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 90383)
-- Name: eventos_inscripcion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE eventos_inscripcion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eventos_inscripcion_id_seq OWNER TO postgres;

--
-- TOC entry 2639 (class 0 OID 0)
-- Dependencies: 207
-- Name: eventos_inscripcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE eventos_inscripcion_id_seq OWNED BY eventos_inscripcion.id;


--
-- TOC entry 210 (class 1259 OID 90393)
-- Name: eventos_inscripcion_operador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE eventos_inscripcion_operador (
    id integer NOT NULL,
    fecha_validacion timestamp with time zone NOT NULL,
    inscripcion_id integer NOT NULL,
    operador_id integer NOT NULL
);


ALTER TABLE eventos_inscripcion_operador OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 90391)
-- Name: eventos_inscripcion_operador_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE eventos_inscripcion_operador_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eventos_inscripcion_operador_id_seq OWNER TO postgres;

--
-- TOC entry 2640 (class 0 OID 0)
-- Dependencies: 209
-- Name: eventos_inscripcion_operador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE eventos_inscripcion_operador_id_seq OWNED BY eventos_inscripcion_operador.id;


--
-- TOC entry 212 (class 1259 OID 90401)
-- Name: eventos_noticia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE eventos_noticia (
    id integer NOT NULL,
    nombre character varying(200) NOT NULL,
    fecha_creacion timestamp with time zone NOT NULL,
    fecha_publicacion date NOT NULL,
    contenido text NOT NULL,
    estado boolean NOT NULL,
    autor_id integer NOT NULL,
    evento_id integer NOT NULL,
    banner character varying(100) NOT NULL
);


ALTER TABLE eventos_noticia OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 90399)
-- Name: eventos_noticia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE eventos_noticia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eventos_noticia_id_seq OWNER TO postgres;

--
-- TOC entry 2641 (class 0 OID 0)
-- Dependencies: 211
-- Name: eventos_noticia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE eventos_noticia_id_seq OWNED BY eventos_noticia.id;


--
-- TOC entry 214 (class 1259 OID 90412)
-- Name: eventos_perfiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE eventos_perfiles (
    id integer NOT NULL,
    cedula bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    celular bigint NOT NULL,
    telefono bigint NOT NULL,
    email character varying(254) NOT NULL,
    direccion character varying(200) NOT NULL,
    pais character varying(200) NOT NULL,
    ciudad character varying(200) NOT NULL,
    sexo character varying(2) NOT NULL,
    tipo character varying(30) NOT NULL,
    session character varying(1) NOT NULL,
    usuario_id integer NOT NULL,
    estado character varying(10) NOT NULL
);


ALTER TABLE eventos_perfiles OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 90410)
-- Name: eventos_perfiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE eventos_perfiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE eventos_perfiles_id_seq OWNER TO postgres;

--
-- TOC entry 2642 (class 0 OID 0)
-- Dependencies: 213
-- Name: eventos_perfiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE eventos_perfiles_id_seq OWNED BY eventos_perfiles.id;


--
-- TOC entry 217 (class 1259 OID 106498)
-- Name: pago_pagobancoabc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pago_pagobancoabc (
    id integer NOT NULL,
    cedula bigint NOT NULL,
    valor bigint NOT NULL,
    cardnumber bigint NOT NULL,
    cardowner character varying(50) NOT NULL,
    cvcode bigint NOT NULL,
    expiration date NOT NULL,
    numeropago bigint NOT NULL
);


ALTER TABLE pago_pagobancoabc OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 106496)
-- Name: pago_pagobancoabc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pago_pagobancoabc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pago_pagobancoabc_id_seq OWNER TO postgres;

--
-- TOC entry 2643 (class 0 OID 0)
-- Dependencies: 216
-- Name: pago_pagobancoabc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pago_pagobancoabc_id_seq OWNED BY pago_pagobancoabc.id;


--
-- TOC entry 2372 (class 2604 OID 90239)
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- TOC entry 2373 (class 2604 OID 90249)
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- TOC entry 2371 (class 2604 OID 90231)
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- TOC entry 2374 (class 2604 OID 90257)
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- TOC entry 2375 (class 2604 OID 90267)
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- TOC entry 2376 (class 2604 OID 90275)
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- TOC entry 2377 (class 2604 OID 90335)
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- TOC entry 2370 (class 2604 OID 90221)
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- TOC entry 2369 (class 2604 OID 90210)
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- TOC entry 2379 (class 2604 OID 90366)
-- Name: eventos_actividad id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_actividad ALTER COLUMN id SET DEFAULT nextval('eventos_actividad_id_seq'::regclass);


--
-- TOC entry 2380 (class 2604 OID 90377)
-- Name: eventos_evento id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_evento ALTER COLUMN id SET DEFAULT nextval('eventos_evento_id_seq'::regclass);


--
-- TOC entry 2381 (class 2604 OID 90388)
-- Name: eventos_inscripcion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_inscripcion ALTER COLUMN id SET DEFAULT nextval('eventos_inscripcion_id_seq'::regclass);


--
-- TOC entry 2382 (class 2604 OID 90396)
-- Name: eventos_inscripcion_operador id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_inscripcion_operador ALTER COLUMN id SET DEFAULT nextval('eventos_inscripcion_operador_id_seq'::regclass);


--
-- TOC entry 2383 (class 2604 OID 90404)
-- Name: eventos_noticia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_noticia ALTER COLUMN id SET DEFAULT nextval('eventos_noticia_id_seq'::regclass);


--
-- TOC entry 2384 (class 2604 OID 90415)
-- Name: eventos_perfiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_perfiles ALTER COLUMN id SET DEFAULT nextval('eventos_perfiles_id_seq'::regclass);


--
-- TOC entry 2385 (class 2604 OID 106501)
-- Name: pago_pagobancoabc id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pago_pagobancoabc ALTER COLUMN id SET DEFAULT nextval('pago_pagobancoabc_id_seq'::regclass);


--
-- TOC entry 2595 (class 0 OID 90236)
-- Dependencies: 192
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2644 (class 0 OID 0)
-- Dependencies: 191
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- TOC entry 2597 (class 0 OID 90246)
-- Dependencies: 194
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2645 (class 0 OID 0)
-- Dependencies: 193
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 2593 (class 0 OID 90228)
-- Dependencies: 190
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_permission VALUES (1, 'Can add perfiles', 1, 'add_perfiles');
INSERT INTO auth_permission VALUES (2, 'Can change perfiles', 1, 'change_perfiles');
INSERT INTO auth_permission VALUES (3, 'Can delete perfiles', 1, 'delete_perfiles');
INSERT INTO auth_permission VALUES (4, 'Can add inscripcion', 2, 'add_inscripcion');
INSERT INTO auth_permission VALUES (5, 'Can change inscripcion', 2, 'change_inscripcion');
INSERT INTO auth_permission VALUES (6, 'Can delete inscripcion', 2, 'delete_inscripcion');
INSERT INTO auth_permission VALUES (7, 'Can add actividad', 3, 'add_actividad');
INSERT INTO auth_permission VALUES (8, 'Can change actividad', 3, 'change_actividad');
INSERT INTO auth_permission VALUES (9, 'Can delete actividad', 3, 'delete_actividad');
INSERT INTO auth_permission VALUES (10, 'Can add inscripcion_operador', 4, 'add_inscripcion_operador');
INSERT INTO auth_permission VALUES (11, 'Can change inscripcion_operador', 4, 'change_inscripcion_operador');
INSERT INTO auth_permission VALUES (12, 'Can delete inscripcion_operador', 4, 'delete_inscripcion_operador');
INSERT INTO auth_permission VALUES (13, 'Can add evento', 5, 'add_evento');
INSERT INTO auth_permission VALUES (14, 'Can change evento', 5, 'change_evento');
INSERT INTO auth_permission VALUES (15, 'Can delete evento', 5, 'delete_evento');
INSERT INTO auth_permission VALUES (16, 'Can add noticia', 6, 'add_noticia');
INSERT INTO auth_permission VALUES (17, 'Can change noticia', 6, 'change_noticia');
INSERT INTO auth_permission VALUES (18, 'Can delete noticia', 6, 'delete_noticia');
INSERT INTO auth_permission VALUES (19, 'Can add log entry', 7, 'add_logentry');
INSERT INTO auth_permission VALUES (20, 'Can change log entry', 7, 'change_logentry');
INSERT INTO auth_permission VALUES (21, 'Can delete log entry', 7, 'delete_logentry');
INSERT INTO auth_permission VALUES (22, 'Can add group', 8, 'add_group');
INSERT INTO auth_permission VALUES (23, 'Can change group', 8, 'change_group');
INSERT INTO auth_permission VALUES (24, 'Can delete group', 8, 'delete_group');
INSERT INTO auth_permission VALUES (25, 'Can add permission', 9, 'add_permission');
INSERT INTO auth_permission VALUES (26, 'Can change permission', 9, 'change_permission');
INSERT INTO auth_permission VALUES (27, 'Can delete permission', 9, 'delete_permission');
INSERT INTO auth_permission VALUES (28, 'Can add user', 10, 'add_user');
INSERT INTO auth_permission VALUES (29, 'Can change user', 10, 'change_user');
INSERT INTO auth_permission VALUES (30, 'Can delete user', 10, 'delete_user');
INSERT INTO auth_permission VALUES (31, 'Can add content type', 11, 'add_contenttype');
INSERT INTO auth_permission VALUES (32, 'Can change content type', 11, 'change_contenttype');
INSERT INTO auth_permission VALUES (33, 'Can delete content type', 11, 'delete_contenttype');
INSERT INTO auth_permission VALUES (34, 'Can add session', 12, 'add_session');
INSERT INTO auth_permission VALUES (35, 'Can change session', 12, 'change_session');
INSERT INTO auth_permission VALUES (36, 'Can delete session', 12, 'delete_session');
INSERT INTO auth_permission VALUES (37, 'Can add pago banco abc', 13, 'add_pagobancoabc');
INSERT INTO auth_permission VALUES (38, 'Can change pago banco abc', 13, 'change_pagobancoabc');
INSERT INTO auth_permission VALUES (39, 'Can delete pago banco abc', 13, 'delete_pagobancoabc');


--
-- TOC entry 2646 (class 0 OID 0)
-- Dependencies: 189
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_permission_id_seq', 39, true);


--
-- TOC entry 2599 (class 0 OID 90254)
-- Dependencies: 196
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO auth_user VALUES (4, 'pbkdf2_sha256$36000$PYKM8o7xiGZp$pLXKH5ywztGcwAU0oqkTjpR1Q32ysao8nwYcLeGvOEg=', NULL, false, 'adminsantiago', '', '', '', false, true, '2017-12-13 17:30:00.565504-05');
INSERT INTO auth_user VALUES (1, 'pbkdf2_sha256$36000$SZs33PGIQthq$Id2y8fBwXf5kakZGWNUvi+JidlM86XC0EabM2fkD0ZA=', '2017-12-14 19:45:12.849289-05', true, 'admin', '', '', 'valencia.alejandro@correounivalle.edu.co', true, true, '2017-11-16 17:02:24.928559-05');
INSERT INTO auth_user VALUES (2, 'pbkdf2_sha256$36000$r3SejnjywE3Y$n0Ns1+nwn3YLtBiqIP8Yvg79hKmJzKdL/Tdc9fX8j8w=', '2017-12-14 20:44:34.010295-05', false, 'operador', '', '', '', false, true, '2017-11-16 17:05:31.892504-05');
INSERT INTO auth_user VALUES (3, 'pbkdf2_sha256$36000$QzI8hjXlGJiB$WrlS/f7GgQFZJxb9yMmhzQhBSDnlGbnfjEj/EhaBkmY=', '2017-12-15 00:10:25.91859-05', false, 'gerente', '', '', '', false, true, '2017-11-17 05:20:41.696436-05');


--
-- TOC entry 2601 (class 0 OID 90264)
-- Dependencies: 198
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2647 (class 0 OID 0)
-- Dependencies: 197
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- TOC entry 2648 (class 0 OID 0)
-- Dependencies: 195
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_id_seq', 4, true);


--
-- TOC entry 2603 (class 0 OID 90272)
-- Dependencies: 200
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2649 (class 0 OID 0)
-- Dependencies: 199
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 2605 (class 0 OID 90332)
-- Dependencies: 202
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_admin_log VALUES (1, '2017-11-16 17:04:05.212417-05', '1', 'admin', 1, '[{"added": {}}]', 1, 1);


--
-- TOC entry 2650 (class 0 OID 0)
-- Dependencies: 201
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1, true);


--
-- TOC entry 2591 (class 0 OID 90218)
-- Dependencies: 188
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_content_type VALUES (1, 'eventos', 'perfiles');
INSERT INTO django_content_type VALUES (2, 'eventos', 'inscripcion');
INSERT INTO django_content_type VALUES (3, 'eventos', 'actividad');
INSERT INTO django_content_type VALUES (4, 'eventos', 'inscripcion_operador');
INSERT INTO django_content_type VALUES (5, 'eventos', 'evento');
INSERT INTO django_content_type VALUES (6, 'eventos', 'noticia');
INSERT INTO django_content_type VALUES (7, 'admin', 'logentry');
INSERT INTO django_content_type VALUES (8, 'auth', 'group');
INSERT INTO django_content_type VALUES (9, 'auth', 'permission');
INSERT INTO django_content_type VALUES (10, 'auth', 'user');
INSERT INTO django_content_type VALUES (11, 'contenttypes', 'contenttype');
INSERT INTO django_content_type VALUES (12, 'sessions', 'session');
INSERT INTO django_content_type VALUES (13, 'pago', 'pagobancoabc');


--
-- TOC entry 2651 (class 0 OID 0)
-- Dependencies: 187
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_content_type_id_seq', 13, true);


--
-- TOC entry 2589 (class 0 OID 90207)
-- Dependencies: 186
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_migrations VALUES (1, 'contenttypes', '0001_initial', '2017-11-16 16:56:16.236709-05');
INSERT INTO django_migrations VALUES (2, 'auth', '0001_initial', '2017-11-16 16:56:16.306326-05');
INSERT INTO django_migrations VALUES (3, 'admin', '0001_initial', '2017-11-16 16:56:16.334805-05');
INSERT INTO django_migrations VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2017-11-16 16:56:16.35306-05');
INSERT INTO django_migrations VALUES (5, 'contenttypes', '0002_remove_content_type_name', '2017-11-16 16:56:16.389661-05');
INSERT INTO django_migrations VALUES (6, 'auth', '0002_alter_permission_name_max_length', '2017-11-16 16:56:16.401507-05');
INSERT INTO django_migrations VALUES (7, 'auth', '0003_alter_user_email_max_length', '2017-11-16 16:56:16.416606-05');
INSERT INTO django_migrations VALUES (8, 'auth', '0004_alter_user_username_opts', '2017-11-16 16:56:16.430163-05');
INSERT INTO django_migrations VALUES (9, 'auth', '0005_alter_user_last_login_null', '2017-11-16 16:56:16.455424-05');
INSERT INTO django_migrations VALUES (10, 'auth', '0006_require_contenttypes_0002', '2017-11-16 16:56:16.457764-05');
INSERT INTO django_migrations VALUES (11, 'auth', '0007_alter_validators_add_error_messages', '2017-11-16 16:56:16.495087-05');
INSERT INTO django_migrations VALUES (12, 'auth', '0008_alter_user_username_max_length', '2017-11-16 16:56:16.513206-05');
INSERT INTO django_migrations VALUES (13, 'eventos', '0001_initial', '2017-11-16 16:56:16.692667-05');
INSERT INTO django_migrations VALUES (14, 'sessions', '0001_initial', '2017-11-16 16:56:16.705631-05');
INSERT INTO django_migrations VALUES (15, 'eventos', '0002_auto_20171116_2229', '2017-11-16 17:29:22.973398-05');
INSERT INTO django_migrations VALUES (16, 'eventos', '0003_auto_20171211_1216', '2017-12-11 07:16:53.984637-05');
INSERT INTO django_migrations VALUES (17, 'pago', '0001_initial', '2017-12-13 23:05:02.772291-05');
INSERT INTO django_migrations VALUES (18, 'eventos', '0004_auto_20171214_1319', '2017-12-14 08:19:08.044067-05');
INSERT INTO django_migrations VALUES (19, 'pago', '0002_pagobancoabc_numeropago', '2017-12-14 08:19:08.061488-05');
INSERT INTO django_migrations VALUES (20, 'eventos', '0005_evento_valor_inscripcion', '2017-12-14 08:23:17.191347-05');
INSERT INTO django_migrations VALUES (21, 'eventos', '0006_inscripcion_pais', '2017-12-14 08:48:45.003027-05');
INSERT INTO django_migrations VALUES (22, 'eventos', '0007_inscripcion_sexo', '2017-12-14 08:52:22.742329-05');
INSERT INTO django_migrations VALUES (23, 'eventos', '0008_inscripcion_correo', '2017-12-14 16:23:24.071-05');
INSERT INTO django_migrations VALUES (24, 'eventos', '0009_perfiles_estado', '2017-12-14 19:48:29.502074-05');
INSERT INTO django_migrations VALUES (25, 'eventos', '0010_auto_20171215_0125', '2017-12-14 20:25:20.493365-05');


--
-- TOC entry 2652 (class 0 OID 0)
-- Dependencies: 185
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('django_migrations_id_seq', 25, true);


--
-- TOC entry 2618 (class 0 OID 90470)
-- Dependencies: 215
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO django_session VALUES ('2et1789062f4w8mgafdpar5yjidj3d11', 'ZWNiOWJiMDE4YmJiZWY0MjQ0YmQ2MzY0YTdlODM5N2Q5ZWFhMzIwYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjlmNGYwYmU3YmFkNjAzYTU5NTgyZjkyYTE4ZDc4MjZhMjU4YWYyZTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=', '2017-12-29 00:10:25.922054-05');


--
-- TOC entry 2607 (class 0 OID 90363)
-- Dependencies: 204
-- Data for Name: eventos_actividad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO eventos_actividad VALUES (1, 'Recepcion', 'Muchas cosas', 'INACTIVA', '2017-12-14 21:36:15.180351-05', '07:00:00', '08:30:00', 2, 1);
INSERT INTO eventos_actividad VALUES (2, 'Recepcion', 'Muchas cosas', 'INACTIVA', '2017-12-14 23:53:58.840983-05', '07:00:00', '08:30:00', 2, 1);
INSERT INTO eventos_actividad VALUES (3, 'Recepcion', 'Muchas cosas', 'ACTIVA', '2017-12-14 23:55:24.614858-05', '07:00:00', '08:30:00', 2, 1);


--
-- TOC entry 2653 (class 0 OID 0)
-- Dependencies: 203
-- Name: eventos_actividad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('eventos_actividad_id_seq', 3, true);


--
-- TOC entry 2609 (class 0 OID 90374)
-- Dependencies: 206
-- Data for Name: eventos_evento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO eventos_evento VALUES (1, 'Simposio', '2017-11-16 17:40:38.875404-05', '2017-11-16', '2017-11-17', true, 'Transversal 27 # D 29 - 46', 'eventacademic.jpg', 'Sin descripción', 0);
INSERT INTO eventos_evento VALUES (2, 'Congreso 2', '2017-11-17 08:13:47.233503-05', '2017-11-17', '2017-11-20', true, 'Cali - Hotel Spiwak', 'eventacademic_tmJmgm8.jpg', 'Evento de www', 0);
INSERT INTO eventos_evento VALUES (3, 'Congreso 3', '2017-12-11 11:40:04.014127-05', '2017-12-12', '2017-12-14', true, 'Transversal 27 # D 29 - 45', 'bioinformatica.png', 'Conteindo del evento', 0);
INSERT INTO eventos_evento VALUES (4, 'Congreso 4', '2017-12-14 17:15:19.955308-05', '2017-12-12', '2017-12-15', true, 'Transversal 27 # D 29 - 45', 'logo_congreso.png', 'Enorme y genial congreso donde todos podemos participar', 0);


--
-- TOC entry 2654 (class 0 OID 0)
-- Dependencies: 205
-- Name: eventos_evento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('eventos_evento_id_seq', 4, true);


--
-- TOC entry 2611 (class 0 OID 90385)
-- Dependencies: 208
-- Data for Name: eventos_inscripcion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO eventos_inscripcion VALUES (1, '2017-12-14 10:01:13.260639-05', 'INSCRITO', 2, 1107103519, 3177830506, '', 'Alejandro Valencia Rivera', 3266165, 'CO', 'M', 'Sin email');


--
-- TOC entry 2655 (class 0 OID 0)
-- Dependencies: 207
-- Name: eventos_inscripcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('eventos_inscripcion_id_seq', 2, true);


--
-- TOC entry 2613 (class 0 OID 90393)
-- Dependencies: 210
-- Data for Name: eventos_inscripcion_operador; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2656 (class 0 OID 0)
-- Dependencies: 209
-- Name: eventos_inscripcion_operador_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('eventos_inscripcion_operador_id_seq', 1, false);


--
-- TOC entry 2615 (class 0 OID 90401)
-- Dependencies: 212
-- Data for Name: eventos_noticia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO eventos_noticia VALUES (3, 'Prueba', '2017-12-11 11:47:32.177659-05', '2017-12-13', 'Contenido de prueba', true, 2, 2, 'bioinformatica.png');
INSERT INTO eventos_noticia VALUES (2, 'Incripciones Simpisio Abiertas', '2017-11-17 04:49:37.491233-05', '2017-11-17', 'Ya estan disponibles las inscripciones a simposio', true, 2, 1, 'bioinformatica_P4Z7HT9.png');


--
-- TOC entry 2657 (class 0 OID 0)
-- Dependencies: 211
-- Name: eventos_noticia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('eventos_noticia_id_seq', 3, true);


--
-- TOC entry 2617 (class 0 OID 90412)
-- Dependencies: 214
-- Data for Name: eventos_perfiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO eventos_perfiles VALUES (4, 1107103516, 'Santiago Giraldo', 3177830506, 3266165, 'valencia.alejandro@correounivalle.edu.co', 'transversal 27 # D 29 - 45', 'CO', 'Cali', 'M', 'usuario_registrado', '0', 4, 'ACTIVO');
INSERT INTO eventos_perfiles VALUES (1, 1107103519, 'Alejandro Valencia Rivera', 3177830506, 3266165, 'valencia.alejandro@correounivalle.edu.co', 'transversal 27 # D 29 - 45', 'CO', 'Cali', 'M', 'administrador', '0', 1, 'ACTIVO');
INSERT INTO eventos_perfiles VALUES (2, 1107103519, 'Juan Jose Varela Valencia', 3177830506, 3266165, 'valencia.alejandro@correounivalle.edu.co', 'Ninguna', 'CO', 'Cali', 'M', 'operador', '0', 2, 'ACTIVO');
INSERT INTO eventos_perfiles VALUES (3, 1107103518, 'Erik Lopez Pacheco', 3177830506, 3266165, 'valencia.alejandro@correounivalle.edu.co', 'Sin direccion', 'CO', 'Cali', 'M', 'gerente', '1', 3, 'ACTIVO');


--
-- TOC entry 2658 (class 0 OID 0)
-- Dependencies: 213
-- Name: eventos_perfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('eventos_perfiles_id_seq', 4, true);


--
-- TOC entry 2620 (class 0 OID 106498)
-- Dependencies: 217
-- Data for Name: pago_pagobancoabc; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO pago_pagobancoabc VALUES (1, 1107103519, 300000, 11234, 'Alejandro Valencia', 123, '2017-12-15', 1);


--
-- TOC entry 2659 (class 0 OID 0)
-- Dependencies: 216
-- Name: pago_pagobancoabc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pago_pagobancoabc_id_seq', 1, true);


--
-- TOC entry 2399 (class 2606 OID 90243)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 2404 (class 2606 OID 90298)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 2407 (class 2606 OID 90251)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2401 (class 2606 OID 90241)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 2394 (class 2606 OID 90284)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 2396 (class 2606 OID 90233)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 2415 (class 2606 OID 90269)
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 2418 (class 2606 OID 90313)
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 2409 (class 2606 OID 90259)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2421 (class 2606 OID 90277)
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2424 (class 2606 OID 90327)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 2412 (class 2606 OID 90356)
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 2427 (class 2606 OID 90341)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 2389 (class 2606 OID 90225)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 2391 (class 2606 OID 90223)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2387 (class 2606 OID 90215)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 2451 (class 2606 OID 90477)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 2431 (class 2606 OID 90371)
-- Name: eventos_actividad eventos_actividad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_actividad
    ADD CONSTRAINT eventos_actividad_pkey PRIMARY KEY (id);


--
-- TOC entry 2433 (class 2606 OID 90382)
-- Name: eventos_evento eventos_evento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_evento
    ADD CONSTRAINT eventos_evento_pkey PRIMARY KEY (id);


--
-- TOC entry 2440 (class 2606 OID 90398)
-- Name: eventos_inscripcion_operador eventos_inscripcion_operador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_inscripcion_operador
    ADD CONSTRAINT eventos_inscripcion_operador_pkey PRIMARY KEY (id);


--
-- TOC entry 2436 (class 2606 OID 90390)
-- Name: eventos_inscripcion eventos_inscripcion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_inscripcion
    ADD CONSTRAINT eventos_inscripcion_pkey PRIMARY KEY (id);


--
-- TOC entry 2444 (class 2606 OID 90409)
-- Name: eventos_noticia eventos_noticia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_noticia
    ADD CONSTRAINT eventos_noticia_pkey PRIMARY KEY (id);


--
-- TOC entry 2446 (class 2606 OID 90420)
-- Name: eventos_perfiles eventos_perfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_perfiles
    ADD CONSTRAINT eventos_perfiles_pkey PRIMARY KEY (id);


--
-- TOC entry 2448 (class 2606 OID 90422)
-- Name: eventos_perfiles eventos_perfiles_usuario_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_perfiles
    ADD CONSTRAINT eventos_perfiles_usuario_id_key UNIQUE (usuario_id);


--
-- TOC entry 2454 (class 2606 OID 106503)
-- Name: pago_pagobancoabc pago_pagobancoabc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pago_pagobancoabc
    ADD CONSTRAINT pago_pagobancoabc_pkey PRIMARY KEY (id);


--
-- TOC entry 2397 (class 1259 OID 90286)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 2402 (class 1259 OID 90299)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON auth_group_permissions USING btree (group_id);


--
-- TOC entry 2405 (class 1259 OID 90300)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON auth_group_permissions USING btree (permission_id);


--
-- TOC entry 2392 (class 1259 OID 90285)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON auth_permission USING btree (content_type_id);


--
-- TOC entry 2413 (class 1259 OID 90315)
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON auth_user_groups USING btree (group_id);


--
-- TOC entry 2416 (class 1259 OID 90314)
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON auth_user_groups USING btree (user_id);


--
-- TOC entry 2419 (class 1259 OID 90329)
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 2422 (class 1259 OID 90328)
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 2410 (class 1259 OID 90357)
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 2425 (class 1259 OID 90352)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON django_admin_log USING btree (content_type_id);


--
-- TOC entry 2428 (class 1259 OID 90353)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON django_admin_log USING btree (user_id);


--
-- TOC entry 2449 (class 1259 OID 90479)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON django_session USING btree (expire_date);


--
-- TOC entry 2452 (class 1259 OID 90478)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 2429 (class 1259 OID 90464)
-- Name: eventos_actividad_evento_id_ee64f528; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eventos_actividad_evento_id_ee64f528 ON eventos_actividad USING btree (evento_id);


--
-- TOC entry 2434 (class 1259 OID 90433)
-- Name: eventos_inscripcion_evento_id_cc651ed8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eventos_inscripcion_evento_id_cc651ed8 ON eventos_inscripcion USING btree (evento_id);


--
-- TOC entry 2437 (class 1259 OID 90445)
-- Name: eventos_inscripcion_operador_inscripcion_id_653e8730; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eventos_inscripcion_operador_inscripcion_id_653e8730 ON eventos_inscripcion_operador USING btree (inscripcion_id);


--
-- TOC entry 2438 (class 1259 OID 90446)
-- Name: eventos_inscripcion_operador_operador_id_566bb593; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eventos_inscripcion_operador_operador_id_566bb593 ON eventos_inscripcion_operador USING btree (operador_id);


--
-- TOC entry 2441 (class 1259 OID 90457)
-- Name: eventos_noticia_autor_id_32343f75; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eventos_noticia_autor_id_32343f75 ON eventos_noticia USING btree (autor_id);


--
-- TOC entry 2442 (class 1259 OID 90458)
-- Name: eventos_noticia_evento_id_c3911b8c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX eventos_noticia_evento_id_c3911b8c ON eventos_noticia USING btree (evento_id);


--
-- TOC entry 2457 (class 2606 OID 90292)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2456 (class 2606 OID 90287)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2455 (class 2606 OID 90278)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2459 (class 2606 OID 90307)
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2458 (class 2606 OID 90302)
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2461 (class 2606 OID 90321)
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2460 (class 2606 OID 90316)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2462 (class 2606 OID 90342)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2463 (class 2606 OID 90347)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2464 (class 2606 OID 90465)
-- Name: eventos_actividad eventos_actividad_evento_id_ee64f528_fk_eventos_evento_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_actividad
    ADD CONSTRAINT eventos_actividad_evento_id_ee64f528_fk_eventos_evento_id FOREIGN KEY (evento_id) REFERENCES eventos_evento(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2466 (class 2606 OID 90435)
-- Name: eventos_inscripcion_operador eventos_inscripcion__inscripcion_id_653e8730_fk_eventos_i; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_inscripcion_operador
    ADD CONSTRAINT eventos_inscripcion__inscripcion_id_653e8730_fk_eventos_i FOREIGN KEY (inscripcion_id) REFERENCES eventos_inscripcion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2467 (class 2606 OID 90440)
-- Name: eventos_inscripcion_operador eventos_inscripcion__operador_id_566bb593_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_inscripcion_operador
    ADD CONSTRAINT eventos_inscripcion__operador_id_566bb593_fk_auth_user FOREIGN KEY (operador_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2465 (class 2606 OID 90423)
-- Name: eventos_inscripcion eventos_inscripcion_evento_id_cc651ed8_fk_eventos_evento_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_inscripcion
    ADD CONSTRAINT eventos_inscripcion_evento_id_cc651ed8_fk_eventos_evento_id FOREIGN KEY (evento_id) REFERENCES eventos_evento(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2468 (class 2606 OID 90447)
-- Name: eventos_noticia eventos_noticia_autor_id_32343f75_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_noticia
    ADD CONSTRAINT eventos_noticia_autor_id_32343f75_fk_auth_user_id FOREIGN KEY (autor_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2469 (class 2606 OID 90452)
-- Name: eventos_noticia eventos_noticia_evento_id_c3911b8c_fk_eventos_evento_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_noticia
    ADD CONSTRAINT eventos_noticia_evento_id_c3911b8c_fk_eventos_evento_id FOREIGN KEY (evento_id) REFERENCES eventos_evento(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 2470 (class 2606 OID 90459)
-- Name: eventos_perfiles eventos_perfiles_usuario_id_685293c2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventos_perfiles
    ADD CONSTRAINT eventos_perfiles_usuario_id_685293c2_fk_auth_user_id FOREIGN KEY (usuario_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2017-12-15 02:31:10 COT

--
-- PostgreSQL database dump complete
--

