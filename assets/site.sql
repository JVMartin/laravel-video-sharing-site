--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.5
-- Dumped by pg_dump version 9.5.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.videos_topics DROP CONSTRAINT videos_topics_video_id_foreign;
ALTER TABLE ONLY public.videos_topics DROP CONSTRAINT videos_topics_topic_id_foreign;
ALTER TABLE ONLY public.verifications DROP CONSTRAINT verifications_user_id_foreign;
ALTER TABLE ONLY public.submissions DROP CONSTRAINT submissions_video_id_foreign;
ALTER TABLE ONLY public.submissions DROP CONSTRAINT submissions_user_id_foreign;
DROP INDEX public.videos_topics_video_id_index;
DROP INDEX public.videos_topics_topic_id_index;
DROP INDEX public.verifications_user_id_index;
DROP INDEX public.verifications_token_index;
DROP INDEX public.tagged_taggable_type_taggable_id_index;
DROP INDEX public.password_resets_token_index;
DROP INDEX public.password_resets_email_index;
ALTER TABLE ONLY public.videos DROP CONSTRAINT videos_youtube_id_unique;
ALTER TABLE ONLY public.videos_topics DROP CONSTRAINT videos_topics_pkey;
ALTER TABLE ONLY public.videos DROP CONSTRAINT videos_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_unique;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_unique;
ALTER TABLE ONLY public.topics DROP CONSTRAINT topics_pkey;
ALTER TABLE ONLY public.topics DROP CONSTRAINT topics_google_id_unique;
ALTER TABLE ONLY public.tags DROP CONSTRAINT tags_pkey;
ALTER TABLE ONLY public.tagged DROP CONSTRAINT tagged_pkey;
ALTER TABLE ONLY public.submissions DROP CONSTRAINT submissions_pkey;
ALTER TABLE ONLY public.migrations DROP CONSTRAINT migrations_pkey;
ALTER TABLE public.videos_topics ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.videos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.topics ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.tags ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.tagged ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.submissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.videos_topics_id_seq;
DROP TABLE public.videos_topics;
DROP SEQUENCE public.videos_id_seq;
DROP TABLE public.videos;
DROP TABLE public.verifications;
DROP SEQUENCE public.users_id_seq;
DROP TABLE public.users;
DROP SEQUENCE public.topics_id_seq;
DROP TABLE public.topics;
DROP SEQUENCE public.tags_id_seq;
DROP TABLE public.tags;
DROP SEQUENCE public.tagged_id_seq;
DROP TABLE public.tagged;
DROP SEQUENCE public.submissions_id_seq;
DROP TABLE public.submissions;
DROP TABLE public.password_resets;
DROP SEQUENCE public.migrations_id_seq;
DROP TABLE public.migrations;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE migrations_id_seq OWNED BY migrations.id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE password_resets OWNER TO postgres;

--
-- Name: submissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE submissions (
    id integer NOT NULL,
    video_id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE submissions OWNER TO postgres;

--
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE submissions_id_seq OWNER TO postgres;

--
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE submissions_id_seq OWNED BY submissions.id;


--
-- Name: tagged; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tagged (
    id integer NOT NULL,
    taggable_type character varying(255) NOT NULL,
    taggable_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE tagged OWNER TO postgres;

--
-- Name: tagged_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tagged_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tagged_id_seq OWNER TO postgres;

--
-- Name: tagged_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tagged_id_seq OWNED BY tagged.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tags (
    id integer NOT NULL,
    namespace character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    count integer DEFAULT 0 NOT NULL
);


ALTER TABLE tags OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tags_id_seq OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE topics (
    id integer NOT NULL,
    google_id character varying(255) NOT NULL,
    slug character varying(255),
    name character varying(255),
    json text,
    count integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE topics OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE topics_id_seq OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE topics_id_seq OWNED BY topics.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    password character varying(255),
    has_avatar boolean DEFAULT false NOT NULL,
    last_sign_in timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    remember_token character varying(100)
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: verifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE verifications (
    user_id integer NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE verifications OWNER TO postgres;

--
-- Name: videos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE videos (
    id integer NOT NULL,
    youtube_id character(11) NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    embeddable boolean NOT NULL,
    privacy_status character varying(255) NOT NULL,
    published_at timestamp(0) without time zone NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE videos OWNER TO postgres;

--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE videos_id_seq OWNER TO postgres;

--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE videos_id_seq OWNED BY videos.id;


--
-- Name: videos_topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE videos_topics (
    id integer NOT NULL,
    topic_id integer NOT NULL,
    video_id integer NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE videos_topics OWNER TO postgres;

--
-- Name: videos_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE videos_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE videos_topics_id_seq OWNER TO postgres;

--
-- Name: videos_topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE videos_topics_id_seq OWNED BY videos_topics.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY migrations ALTER COLUMN id SET DEFAULT nextval('migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY submissions ALTER COLUMN id SET DEFAULT nextval('submissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tagged ALTER COLUMN id SET DEFAULT nextval('tagged_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics ALTER COLUMN id SET DEFAULT nextval('topics_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY videos ALTER COLUMN id SET DEFAULT nextval('videos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY videos_topics ALTER COLUMN id SET DEFAULT nextval('videos_topics_id_seq'::regclass);


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY migrations (id, migration, batch) FROM stdin;
1	2014_10_12_000000_create_users_table	1
2	2014_10_12_100000_create_password_resets_table	1
3	2014_10_29_202547_migration_cartalyst_tags_create_tables	1
4	2017_01_18_221958_create_verifications_table	1
5	2017_01_26_235059_create_videos_table	1
6	2017_01_31_224924_create_submissions_table	1
7	2017_02_01_214835_create_topics_tables	1
\.


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('migrations_id_seq', 7, true);


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY password_resets (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY submissions (id, video_id, user_id, title, slug, description, created_at, updated_at) FROM stdin;
1	1	2	Necessitatibus est dolorum unde et ut modi.	necessitatibus-est-dolorum-unde-et-ut-modi	Ad hic qui et consequatur aut. Id sed animi tempora. Minus laborum labore quidem autem.\n\nVitae dolores vel amet animi. Eaque dolor autem quidem est voluptate excepturi qui. Qui inventore unde minus odio provident.	2017-02-12 22:33:45	2017-02-12 22:33:45
2	2	1	Et tempore ducimus fugit saepe aut inventore enim.	et-tempore-ducimus-fugit-saepe-aut-inventore-enim	Quis similique aut iste. Odio cum impedit excepturi vel animi. Sit et quis fuga architecto porro est. Sed consequatur alias molestias rerum quo.\n\nNihil id autem eveniet autem est. Sit vel voluptatem quas dicta quos officiis. Dolor libero tenetur tenetur mollitia iure quidem.	2017-02-12 22:33:45	2017-02-12 22:33:45
3	3	2	Culpa suscipit dolore necessitatibus delectus.	culpa-suscipit-dolore-necessitatibus-delectus	Aut nemo eos qui et impedit. Doloremque repellendus nesciunt et sapiente quibusdam. Assumenda voluptatem rerum laudantium nemo qui tempora. Iusto quia nostrum dolorum rerum.\n\nUllam unde dolore accusamus distinctio omnis consequatur inventore. Ea eius corporis sed quia enim et odio. Omnis et iure similique omnis. Possimus omnis amet alias dolores minus.	2017-02-12 22:33:45	2017-02-12 22:33:45
4	4	1	Laudantium enim magnam aperiam sed natus dolorum.	laudantium-enim-magnam-aperiam-sed-natus-dolorum	Aut placeat explicabo sint soluta nisi voluptas est. Consequuntur ab ut nam rem est alias quos. Fugiat eligendi minima sint architecto.\n\nAlias dolorum eaque atque pariatur expedita dignissimos. Ut libero quia consequatur sed. Similique aut enim expedita minima. Ut officiis aliquam ut est error.	2017-02-12 22:33:45	2017-02-12 22:33:45
5	5	2	Repellendus quo eum saepe ut.	repellendus-quo-eum-saepe-ut	Illum labore non sit cum. Sint debitis error consequatur et ut sequi eum quis. Et illo ullam assumenda optio assumenda veritatis repellendus aut.\n\nEos blanditiis non debitis aspernatur voluptates cum at. Maiores ad minima asperiores non est ratione. Aliquid modi eos voluptatem voluptatem nihil.	2017-02-12 22:33:45	2017-02-12 22:33:45
6	6	1	Aliquid dolores sit vero iusto.	aliquid-dolores-sit-vero-iusto	Tenetur nemo rerum ut quo velit nesciunt sit. Aut non ducimus nemo quia porro rerum. Ullam ullam nemo necessitatibus.\n\nIllum ipsa corrupti necessitatibus sed id ut. Consequatur sint veniam atque aut harum. Ea cupiditate natus eveniet non laborum molestiae deleniti. Quam sint asperiores reprehenderit sed odio rerum qui.	2017-02-12 22:33:45	2017-02-12 22:33:45
7	7	2	Autem sit delectus inventore qui velit.	autem-sit-delectus-inventore-qui-velit	Sint odit maxime fuga dicta. Nisi sequi amet sunt. Rerum quos voluptatem repellat dolorum omnis magni nemo. Ut itaque cupiditate ut voluptatum iure non.\n\nRecusandae atque quis fugiat. Dolorem ea sunt sed doloremque nihil repellendus. Magnam aut ab totam.	2017-02-12 22:33:45	2017-02-12 22:33:45
8	8	1	Odio sed delectus doloremque repudiandae quasi.	odio-sed-delectus-doloremque-repudiandae-quasi	Et ut voluptatem minus. Porro doloribus dolores recusandae mollitia et consequuntur sunt. Consequuntur laborum omnis illum ea dolores.\n\nUt hic quisquam minima earum adipisci. Commodi consequatur dolorum et accusamus. Dolores voluptatem perspiciatis totam qui neque dolores id. Unde reiciendis molestias molestias ea est ut atque dolor.	2017-02-12 22:33:45	2017-02-12 22:33:45
9	9	2	Debitis aut suscipit et natus.	debitis-aut-suscipit-et-natus	Velit sed autem dolor odio unde ut doloribus. Voluptas natus unde ducimus soluta id laudantium. Facilis laborum dolorem totam.\n\nDicta dicta consequuntur adipisci. Autem ut dolor cupiditate error est quisquam quaerat. Qui modi totam sit unde qui ratione.	2017-02-12 22:33:45	2017-02-12 22:33:45
10	10	1	Rerum quis consequatur quia voluptates.	rerum-quis-consequatur-quia-voluptates	Dolor omnis tempore aperiam sunt provident et. Et accusantium est aut illo officiis est et repudiandae. Atque ut animi quas voluptatem facere voluptas.\n\nDolorem et rerum delectus officiis similique enim itaque enim. Vel hic nihil eos cumque culpa libero magni. Corporis assumenda nobis tenetur ipsum eos cumque modi. Qui aliquid non aspernatur et sed doloremque dicta voluptas. Aut et dignissimos ut.	2017-02-12 22:33:45	2017-02-12 22:33:45
11	11	2	Enim amet alias libero aut quis.	enim-amet-alias-libero-aut-quis	Et quod est est iusto ut. Sequi qui est accusantium. Occaecati vel eos explicabo.\n\nAccusamus repellendus et ipsam reprehenderit aut beatae dolorum. Id fugiat sint necessitatibus vel. Aut vitae quia est minima dolore eos.	2017-02-12 22:33:45	2017-02-12 22:33:45
12	12	1	Molestiae ex rerum perferendis magnam.	molestiae-ex-rerum-perferendis-magnam	Aut sunt impedit delectus sunt nemo ut tempore ducimus. Placeat et est possimus libero. Pariatur amet aut voluptatibus adipisci molestiae ut omnis. Porro qui ut adipisci aliquid autem minima.\n\nSit harum aperiam dolores dolorem non velit in. Magnam suscipit praesentium molestias tempora quia sit. Maiores omnis nisi sit quod.	2017-02-12 22:33:45	2017-02-12 22:33:45
13	23	2	Provident consectetur voluptatem recusandae.	provident-consectetur-voluptatem-recusandae	Quo nam maxime corrupti porro. Reprehenderit ipsam mollitia doloremque ea. Quia illum blanditiis sit deserunt fuga.\n\nIllo qui officiis et officiis aliquam adipisci. Dolore molestiae incidunt delectus quas neque in repellendus. Provident ipsum ut et odio.	2017-02-12 22:33:45	2017-02-12 22:33:45
14	13	1	Quam sed saepe sapiente nobis voluptatem delectus error.	quam-sed-saepe-sapiente-nobis-voluptatem-delectus-error	Et nam totam porro illum. Itaque id nisi sapiente voluptas sit hic. Et est esse accusantium qui.\n\nNatus sapiente doloribus nobis veniam qui est. Voluptatem et id magni amet saepe aut. Harum eveniet sunt officiis quisquam. Corrupti amet voluptatem rerum repudiandae et sunt ut eius.	2017-02-12 22:33:45	2017-02-12 22:33:45
15	14	2	Voluptas ratione nesciunt dolores perspiciatis.	voluptas-ratione-nesciunt-dolores-perspiciatis	Numquam omnis omnis repellat consequuntur nesciunt nam ut sit. Sapiente omnis eius ducimus veritatis consequuntur. Iusto sint quidem quis eligendi qui quo quo. Repellat sit tenetur iure perferendis repudiandae.\n\nDistinctio id blanditiis illo pariatur eum ab. Iure et quia molestiae ipsa. Doloremque et sit repudiandae pariatur voluptatem odit.	2017-02-12 22:33:45	2017-02-12 22:33:45
16	15	1	Sint rem inventore saepe nisi eos.	sint-rem-inventore-saepe-nisi-eos	Est sapiente nesciunt saepe facilis. Optio natus voluptatem sit et. Id delectus distinctio et ab sed culpa soluta.\n\nRerum ratione iusto beatae ratione reiciendis id. In eum dolor vitae quidem velit.	2017-02-12 22:33:45	2017-02-12 22:33:45
17	16	2	Labore aut consequatur voluptate minus ducimus quia voluptatibus reprehenderit.	labore-aut-consequatur-voluptate-minus-ducimus-quia-voluptatibus-reprehenderit	Sit provident vero modi mollitia quas est aperiam. Voluptas minima cupiditate sed quia ut. Laborum sint odit corrupti similique omnis quia. Voluptatem quo et perferendis voluptatibus.\n\nCorporis ab nam sit. Tempora ut commodi rerum facere asperiores. Eligendi qui possimus voluptas iusto. Ipsum est quae mollitia est quibusdam vero.	2017-02-12 22:33:45	2017-02-12 22:33:45
18	17	1	Vel harum expedita incidunt est.	vel-harum-expedita-incidunt-est	Necessitatibus non sunt corporis reprehenderit consequatur ipsum laborum. Placeat architecto vero doloremque reiciendis. Inventore et quia ut qui. Qui distinctio odio culpa neque illum ratione eaque.\n\nSapiente voluptatum quam vel. Facilis ea vero ipsam iste laudantium tempora quis. Saepe sit saepe quisquam est eaque eveniet.	2017-02-12 22:33:45	2017-02-12 22:33:45
19	18	2	Laboriosam animi optio consectetur ea ut.	laboriosam-animi-optio-consectetur-ea-ut	Suscipit atque ad qui sint. Quis quis totam et at ea beatae ut. Necessitatibus possimus pariatur quo.\n\nMinus dolorem est delectus animi. Placeat et dolores qui qui in ab dolore sed. Vitae quo est in adipisci.	2017-02-12 22:33:46	2017-02-12 22:33:46
20	19	1	Quae omnis nesciunt eaque facilis vero maiores delectus.	quae-omnis-nesciunt-eaque-facilis-vero-maiores-delectus	Numquam impedit ipsa ea assumenda dignissimos et voluptate. Nam non nihil placeat dicta aliquam sed. Enim error et non ratione exercitationem assumenda. Sit commodi cumque voluptates earum quibusdam sint.\n\nOfficiis alias non mollitia maxime. Cum est voluptatem in laboriosam impedit. Sint fuga voluptatum culpa doloribus.	2017-02-12 22:33:46	2017-02-12 22:33:46
21	20	2	Rerum ea totam in omnis omnis eum.	rerum-ea-totam-in-omnis-omnis-eum	Maiores aut veniam amet porro. Totam aut accusamus vel error iusto. Earum asperiores qui cumque id debitis explicabo accusantium. Praesentium aut veritatis eum voluptates temporibus veritatis.\n\nSed necessitatibus aliquam et odio non. Sunt quas possimus dolorem nam enim. Eligendi praesentium tempore repudiandae laboriosam et nisi maiores labore.	2017-02-12 22:33:46	2017-02-12 22:33:46
22	21	1	Et laudantium voluptatem aut rerum praesentium ut accusantium.	et-laudantium-voluptatem-aut-rerum-praesentium-ut-accusantium	Qui voluptas et facilis illum nihil dolor ut occaecati. Totam sed ut soluta quo aperiam atque. Repellendus sit id ab vel.\n\nEius tempora placeat doloribus deleniti dicta atque. Beatae cum est beatae quae esse. Voluptatem iusto commodi occaecati et aliquid veritatis.	2017-02-12 22:33:46	2017-02-12 22:33:46
23	22	2	Laudantium odio non soluta.	laudantium-odio-non-soluta	Quo sit harum maxime fugiat culpa quia. Repellat et illo ipsam rem optio.\n\nReprehenderit molestias temporibus et minus dolores. Molestias sit architecto libero officiis reprehenderit. Totam laudantium quae sit saepe saepe sit maiores.	2017-02-12 22:33:46	2017-02-12 22:33:46
24	24	1	Inventore dolor rem natus.	inventore-dolor-rem-natus	Aut est blanditiis adipisci quia accusamus. Qui qui aut enim aut vel hic. Sit cumque aliquam quia optio laborum. Consequuntur incidunt esse explicabo inventore et eligendi ipsam totam.\n\nAccusamus consequatur minima possimus nostrum quis. Nobis explicabo voluptas explicabo natus explicabo quos reprehenderit aut. Voluptas voluptatem neque non. Unde molestiae et deserunt reiciendis ut est nobis.	2017-02-12 22:33:46	2017-02-12 22:33:46
25	25	2	Libero earum ut dolor molestiae.	libero-earum-ut-dolor-molestiae	Unde praesentium consequatur modi aut quo voluptatem. Totam placeat illo pariatur recusandae expedita placeat. Alias harum quos eos unde. Voluptas voluptatum odit libero illo amet harum.\n\nIpsam dicta delectus repellat asperiores quisquam. Quis quidem eos ducimus doloremque. Minus reiciendis ratione et.	2017-02-12 22:33:46	2017-02-12 22:33:46
26	26	1	Nobis dolorum eos dignissimos debitis repudiandae in in.	nobis-dolorum-eos-dignissimos-debitis-repudiandae-in-in	Nisi vero soluta officia sapiente esse temporibus et. Sit eveniet qui dolorum officia. Sit modi ducimus quia et autem unde. Unde rerum aut et soluta quis optio expedita eum.\n\nEt ex ab dolore. Ullam iusto quia vel et enim. Neque assumenda vero sunt consequatur maiores eligendi.	2017-02-12 22:33:46	2017-02-12 22:33:46
\.


--
-- Name: submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('submissions_id_seq', 26, true);


--
-- Data for Name: tagged; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tagged (id, taggable_type, taggable_id, tag_id) FROM stdin;
1	App\\Models\\Video	1	1
2	App\\Models\\Video	1	2
3	App\\Models\\Video	1	3
4	App\\Models\\Video	1	4
5	App\\Models\\Video	2	5
6	App\\Models\\Video	2	6
7	App\\Models\\Video	2	7
8	App\\Models\\Video	2	8
9	App\\Models\\Video	2	9
10	App\\Models\\Video	2	10
11	App\\Models\\Video	2	11
12	App\\Models\\Video	2	12
13	App\\Models\\Video	2	13
14	App\\Models\\Video	2	14
15	App\\Models\\Video	2	15
16	App\\Models\\Video	2	16
17	App\\Models\\Video	2	17
18	App\\Models\\Video	2	18
19	App\\Models\\Video	2	19
20	App\\Models\\Video	2	20
21	App\\Models\\Video	2	21
22	App\\Models\\Video	2	22
23	App\\Models\\Video	2	23
24	App\\Models\\Video	2	24
25	App\\Models\\Video	2	25
26	App\\Models\\Video	2	26
27	App\\Models\\Video	2	27
28	App\\Models\\Video	2	28
29	App\\Models\\Video	2	29
30	App\\Models\\Video	2	30
31	App\\Models\\Video	2	31
32	App\\Models\\Video	2	32
33	App\\Models\\Video	2	33
34	App\\Models\\Video	2	34
35	App\\Models\\Video	2	35
36	App\\Models\\Video	2	36
37	App\\Models\\Video	2	37
38	App\\Models\\Video	3	38
39	App\\Models\\Video	3	39
40	App\\Models\\Video	3	23
41	App\\Models\\Video	3	40
42	App\\Models\\Video	3	5
43	App\\Models\\Video	3	41
44	App\\Models\\Video	3	42
45	App\\Models\\Video	3	43
46	App\\Models\\Video	3	44
47	App\\Models\\Video	3	45
48	App\\Models\\Video	3	46
49	App\\Models\\Video	3	47
50	App\\Models\\Video	3	48
51	App\\Models\\Video	3	49
52	App\\Models\\Video	3	50
53	App\\Models\\Video	3	51
54	App\\Models\\Video	4	52
55	App\\Models\\Video	4	53
56	App\\Models\\Video	4	54
57	App\\Models\\Video	4	55
58	App\\Models\\Video	4	56
59	App\\Models\\Video	4	57
60	App\\Models\\Video	4	58
61	App\\Models\\Video	4	59
62	App\\Models\\Video	4	60
63	App\\Models\\Video	4	61
64	App\\Models\\Video	4	26
65	App\\Models\\Video	4	62
66	App\\Models\\Video	4	63
67	App\\Models\\Video	4	64
68	App\\Models\\Video	4	65
69	App\\Models\\Video	4	66
70	App\\Models\\Video	4	67
71	App\\Models\\Video	4	68
72	App\\Models\\Video	4	69
73	App\\Models\\Video	5	70
74	App\\Models\\Video	5	71
75	App\\Models\\Video	5	72
76	App\\Models\\Video	5	73
77	App\\Models\\Video	5	74
78	App\\Models\\Video	5	75
79	App\\Models\\Video	5	76
80	App\\Models\\Video	6	77
81	App\\Models\\Video	6	78
82	App\\Models\\Video	7	79
83	App\\Models\\Video	7	80
84	App\\Models\\Video	7	81
85	App\\Models\\Video	7	82
86	App\\Models\\Video	7	83
87	App\\Models\\Video	7	84
88	App\\Models\\Video	7	85
89	App\\Models\\Video	7	86
90	App\\Models\\Video	7	87
91	App\\Models\\Video	7	88
92	App\\Models\\Video	7	89
93	App\\Models\\Video	7	90
94	App\\Models\\Video	7	91
95	App\\Models\\Video	7	92
96	App\\Models\\Video	7	93
97	App\\Models\\Video	7	94
98	App\\Models\\Video	7	95
99	App\\Models\\Video	7	96
100	App\\Models\\Video	7	97
101	App\\Models\\Video	7	98
102	App\\Models\\Video	7	99
103	App\\Models\\Video	8	100
104	App\\Models\\Video	8	101
105	App\\Models\\Video	8	102
106	App\\Models\\Video	8	103
107	App\\Models\\Video	8	104
108	App\\Models\\Video	8	105
109	App\\Models\\Video	8	106
110	App\\Models\\Video	8	107
111	App\\Models\\Video	8	108
112	App\\Models\\Video	8	109
113	App\\Models\\Video	8	110
114	App\\Models\\Video	8	111
115	App\\Models\\Video	8	112
116	App\\Models\\Video	8	113
117	App\\Models\\Video	8	114
118	App\\Models\\Video	9	115
119	App\\Models\\Video	9	116
120	App\\Models\\Video	9	117
121	App\\Models\\Video	9	118
122	App\\Models\\Video	9	119
123	App\\Models\\Video	9	120
124	App\\Models\\Video	9	121
125	App\\Models\\Video	9	122
126	App\\Models\\Video	9	123
127	App\\Models\\Video	9	124
128	App\\Models\\Video	9	118
129	App\\Models\\Video	9	125
130	App\\Models\\Video	9	126
131	App\\Models\\Video	9	127
132	App\\Models\\Video	9	128
133	App\\Models\\Video	9	129
134	App\\Models\\Video	9	130
135	App\\Models\\Video	10	100
136	App\\Models\\Video	10	102
137	App\\Models\\Video	10	131
138	App\\Models\\Video	10	132
139	App\\Models\\Video	10	133
140	App\\Models\\Video	10	103
141	App\\Models\\Video	10	107
142	App\\Models\\Video	10	134
143	App\\Models\\Video	10	135
144	App\\Models\\Video	10	136
145	App\\Models\\Video	11	137
146	App\\Models\\Video	11	104
147	App\\Models\\Video	11	103
148	App\\Models\\Video	11	138
149	App\\Models\\Video	12	139
150	App\\Models\\Video	12	140
151	App\\Models\\Video	12	141
152	App\\Models\\Video	12	142
153	App\\Models\\Video	12	143
154	App\\Models\\Video	12	144
155	App\\Models\\Video	12	145
156	App\\Models\\Video	12	146
157	App\\Models\\Video	12	147
158	App\\Models\\Video	12	148
159	App\\Models\\Video	12	149
160	App\\Models\\Video	13	150
161	App\\Models\\Video	13	151
162	App\\Models\\Video	13	152
163	App\\Models\\Video	13	152
164	App\\Models\\Video	13	153
165	App\\Models\\Video	13	154
166	App\\Models\\Video	13	155
167	App\\Models\\Video	13	156
168	App\\Models\\Video	13	157
169	App\\Models\\Video	13	158
170	App\\Models\\Video	13	159
171	App\\Models\\Video	13	160
172	App\\Models\\Video	13	161
173	App\\Models\\Video	13	162
174	App\\Models\\Video	13	163
175	App\\Models\\Video	13	164
176	App\\Models\\Video	13	165
177	App\\Models\\Video	13	166
178	App\\Models\\Video	13	167
179	App\\Models\\Video	13	168
180	App\\Models\\Video	13	169
181	App\\Models\\Video	13	170
182	App\\Models\\Video	13	26
183	App\\Models\\Video	13	171
184	App\\Models\\Video	13	172
185	App\\Models\\Video	13	173
186	App\\Models\\Video	13	174
187	App\\Models\\Video	13	175
188	App\\Models\\Video	13	176
189	App\\Models\\Video	13	177
190	App\\Models\\Video	13	178
191	App\\Models\\Video	13	179
192	App\\Models\\Video	14	180
193	App\\Models\\Video	14	181
194	App\\Models\\Video	14	182
195	App\\Models\\Video	14	183
196	App\\Models\\Video	14	184
197	App\\Models\\Video	14	185
198	App\\Models\\Video	14	186
199	App\\Models\\Video	14	187
200	App\\Models\\Video	14	188
201	App\\Models\\Video	14	189
202	App\\Models\\Video	14	190
203	App\\Models\\Video	14	191
204	App\\Models\\Video	14	192
205	App\\Models\\Video	14	193
206	App\\Models\\Video	14	194
207	App\\Models\\Video	14	50
208	App\\Models\\Video	14	195
209	App\\Models\\Video	14	75
210	App\\Models\\Video	14	196
211	App\\Models\\Video	14	197
212	App\\Models\\Video	14	198
213	App\\Models\\Video	15	199
214	App\\Models\\Video	15	200
215	App\\Models\\Video	15	201
216	App\\Models\\Video	15	202
217	App\\Models\\Video	15	203
218	App\\Models\\Video	15	204
219	App\\Models\\Video	15	205
220	App\\Models\\Video	15	206
221	App\\Models\\Video	15	207
222	App\\Models\\Video	15	160
223	App\\Models\\Video	15	208
224	App\\Models\\Video	16	209
225	App\\Models\\Video	16	210
226	App\\Models\\Video	16	211
227	App\\Models\\Video	16	212
228	App\\Models\\Video	16	213
229	App\\Models\\Video	16	214
230	App\\Models\\Video	16	215
231	App\\Models\\Video	17	216
232	App\\Models\\Video	17	217
233	App\\Models\\Video	17	218
234	App\\Models\\Video	17	219
235	App\\Models\\Video	17	220
236	App\\Models\\Video	17	221
237	App\\Models\\Video	17	222
238	App\\Models\\Video	17	223
239	App\\Models\\Video	17	224
240	App\\Models\\Video	17	225
241	App\\Models\\Video	17	226
242	App\\Models\\Video	17	227
243	App\\Models\\Video	17	228
244	App\\Models\\Video	17	229
245	App\\Models\\Video	17	230
246	App\\Models\\Video	17	231
247	App\\Models\\Video	17	232
248	App\\Models\\Video	18	86
249	App\\Models\\Video	18	233
250	App\\Models\\Video	18	90
251	App\\Models\\Video	18	234
252	App\\Models\\Video	18	235
253	App\\Models\\Video	18	81
254	App\\Models\\Video	18	236
255	App\\Models\\Video	18	237
256	App\\Models\\Video	18	238
257	App\\Models\\Video	18	239
258	App\\Models\\Video	18	240
259	App\\Models\\Video	18	241
260	App\\Models\\Video	18	242
261	App\\Models\\Video	18	243
262	App\\Models\\Video	18	244
263	App\\Models\\Video	18	245
264	App\\Models\\Video	18	246
265	App\\Models\\Video	18	247
266	App\\Models\\Video	18	248
267	App\\Models\\Video	18	249
268	App\\Models\\Video	18	250
269	App\\Models\\Video	18	251
270	App\\Models\\Video	18	252
271	App\\Models\\Video	18	253
272	App\\Models\\Video	18	254
273	App\\Models\\Video	18	186
274	App\\Models\\Video	18	255
275	App\\Models\\Video	18	256
276	App\\Models\\Video	18	257
277	App\\Models\\Video	18	33
278	App\\Models\\Video	18	258
279	App\\Models\\Video	18	259
280	App\\Models\\Video	18	260
281	App\\Models\\Video	18	261
282	App\\Models\\Video	18	262
283	App\\Models\\Video	18	263
284	App\\Models\\Video	18	26
285	App\\Models\\Video	18	264
286	App\\Models\\Video	18	265
287	App\\Models\\Video	19	266
288	App\\Models\\Video	19	267
289	App\\Models\\Video	19	268
290	App\\Models\\Video	19	269
291	App\\Models\\Video	19	270
292	App\\Models\\Video	19	160
293	App\\Models\\Video	19	208
294	App\\Models\\Video	20	271
295	App\\Models\\Video	20	272
296	App\\Models\\Video	20	273
297	App\\Models\\Video	20	274
298	App\\Models\\Video	20	275
299	App\\Models\\Video	20	276
300	App\\Models\\Video	20	277
301	App\\Models\\Video	20	127
302	App\\Models\\Video	20	278
303	App\\Models\\Video	20	279
304	App\\Models\\Video	20	26
305	App\\Models\\Video	20	59
306	App\\Models\\Video	20	280
307	App\\Models\\Video	20	281
308	App\\Models\\Video	20	282
309	App\\Models\\Video	20	283
310	App\\Models\\Video	20	284
311	App\\Models\\Video	20	285
312	App\\Models\\Video	20	286
313	App\\Models\\Video	20	287
314	App\\Models\\Video	20	288
315	App\\Models\\Video	20	80
316	App\\Models\\Video	20	289
317	App\\Models\\Video	20	290
318	App\\Models\\Video	20	291
319	App\\Models\\Video	20	292
320	App\\Models\\Video	20	293
321	App\\Models\\Video	21	294
322	App\\Models\\Video	21	295
323	App\\Models\\Video	21	296
324	App\\Models\\Video	21	297
325	App\\Models\\Video	21	298
326	App\\Models\\Video	21	299
327	App\\Models\\Video	21	300
328	App\\Models\\Video	21	301
329	App\\Models\\Video	21	302
330	App\\Models\\Video	21	303
331	App\\Models\\Video	21	304
332	App\\Models\\Video	21	305
333	App\\Models\\Video	21	306
334	App\\Models\\Video	21	307
335	App\\Models\\Video	21	308
336	App\\Models\\Video	21	309
337	App\\Models\\Video	21	310
338	App\\Models\\Video	21	311
339	App\\Models\\Video	21	312
340	App\\Models\\Video	21	313
341	App\\Models\\Video	21	314
342	App\\Models\\Video	21	315
343	App\\Models\\Video	21	316
344	App\\Models\\Video	21	317
345	App\\Models\\Video	21	318
346	App\\Models\\Video	21	319
347	App\\Models\\Video	21	320
348	App\\Models\\Video	21	321
349	App\\Models\\Video	21	322
350	App\\Models\\Video	21	323
351	App\\Models\\Video	21	324
352	App\\Models\\Video	21	325
353	App\\Models\\Video	22	326
354	App\\Models\\Video	22	327
355	App\\Models\\Video	22	328
356	App\\Models\\Video	22	329
357	App\\Models\\Video	22	330
358	App\\Models\\Video	22	331
359	App\\Models\\Video	22	332
360	App\\Models\\Video	22	333
361	App\\Models\\Video	22	334
362	App\\Models\\Video	22	115
363	App\\Models\\Video	22	335
364	App\\Models\\Video	22	336
365	App\\Models\\Video	22	337
366	App\\Models\\Video	22	338
367	App\\Models\\Video	23	339
368	App\\Models\\Video	23	340
369	App\\Models\\Video	23	341
370	App\\Models\\Video	23	342
371	App\\Models\\Video	23	343
372	App\\Models\\Video	23	344
373	App\\Models\\Video	23	127
374	App\\Models\\Video	23	345
375	App\\Models\\Video	23	282
376	App\\Models\\Video	23	346
377	App\\Models\\Video	23	347
378	App\\Models\\Video	23	348
379	App\\Models\\Video	23	349
380	App\\Models\\Video	23	350
381	App\\Models\\Video	23	351
382	App\\Models\\Video	23	352
383	App\\Models\\Video	23	353
384	App\\Models\\Video	23	354
385	App\\Models\\Video	23	355
386	App\\Models\\Video	23	356
387	App\\Models\\Video	23	357
388	App\\Models\\Video	23	358
389	App\\Models\\Video	23	359
390	App\\Models\\Video	23	360
391	App\\Models\\Video	23	361
392	App\\Models\\Video	23	152
393	App\\Models\\Video	23	362
394	App\\Models\\Video	23	363
395	App\\Models\\Video	23	364
396	App\\Models\\Video	23	365
397	App\\Models\\Video	23	366
398	App\\Models\\Video	23	367
399	App\\Models\\Video	23	368
400	App\\Models\\Video	23	369
401	App\\Models\\Video	23	370
402	App\\Models\\Video	23	371
403	App\\Models\\Video	23	372
404	App\\Models\\Video	23	373
405	App\\Models\\Video	23	374
406	App\\Models\\Video	24	375
407	App\\Models\\Video	24	376
408	App\\Models\\Video	24	377
409	App\\Models\\Video	26	378
410	App\\Models\\Video	26	379
411	App\\Models\\Video	26	380
412	App\\Models\\Video	26	381
413	App\\Models\\Video	26	382
414	App\\Models\\Video	26	383
415	App\\Models\\Video	26	384
416	App\\Models\\Submission	1	385
417	App\\Models\\Submission	1	386
418	App\\Models\\Submission	1	387
419	App\\Models\\Submission	1	388
420	App\\Models\\Submission	2	389
421	App\\Models\\Submission	2	390
422	App\\Models\\Submission	2	391
423	App\\Models\\Submission	2	392
424	App\\Models\\Submission	2	393
425	App\\Models\\Submission	2	394
426	App\\Models\\Submission	3	395
427	App\\Models\\Submission	3	396
428	App\\Models\\Submission	3	397
429	App\\Models\\Submission	4	398
430	App\\Models\\Submission	4	399
431	App\\Models\\Submission	4	400
432	App\\Models\\Submission	4	401
433	App\\Models\\Submission	4	402
434	App\\Models\\Submission	5	403
435	App\\Models\\Submission	5	396
436	App\\Models\\Submission	5	404
437	App\\Models\\Submission	6	405
438	App\\Models\\Submission	6	406
439	App\\Models\\Submission	6	407
440	App\\Models\\Submission	7	408
441	App\\Models\\Submission	7	409
442	App\\Models\\Submission	7	402
443	App\\Models\\Submission	7	410
444	App\\Models\\Submission	7	411
445	App\\Models\\Submission	8	412
446	App\\Models\\Submission	8	413
447	App\\Models\\Submission	8	414
448	App\\Models\\Submission	8	415
449	App\\Models\\Submission	8	416
450	App\\Models\\Submission	8	417
451	App\\Models\\Submission	9	418
452	App\\Models\\Submission	9	419
453	App\\Models\\Submission	9	420
454	App\\Models\\Submission	10	421
455	App\\Models\\Submission	10	422
456	App\\Models\\Submission	10	423
457	App\\Models\\Submission	10	424
458	App\\Models\\Submission	10	425
459	App\\Models\\Submission	10	426
460	App\\Models\\Submission	11	425
461	App\\Models\\Submission	11	427
462	App\\Models\\Submission	11	428
463	App\\Models\\Submission	11	429
464	App\\Models\\Submission	12	414
465	App\\Models\\Submission	12	430
466	App\\Models\\Submission	12	431
467	App\\Models\\Submission	12	393
468	App\\Models\\Submission	12	432
469	App\\Models\\Submission	12	421
470	App\\Models\\Submission	13	414
471	App\\Models\\Submission	13	433
472	App\\Models\\Submission	13	415
473	App\\Models\\Submission	13	434
474	App\\Models\\Submission	13	435
475	App\\Models\\Submission	13	436
476	App\\Models\\Submission	14	437
477	App\\Models\\Submission	14	414
478	App\\Models\\Submission	14	391
479	App\\Models\\Submission	14	438
480	App\\Models\\Submission	14	388
481	App\\Models\\Submission	14	393
482	App\\Models\\Submission	15	419
483	App\\Models\\Submission	15	439
484	App\\Models\\Submission	15	396
485	App\\Models\\Submission	15	440
486	App\\Models\\Submission	16	441
487	App\\Models\\Submission	16	436
488	App\\Models\\Submission	16	442
489	App\\Models\\Submission	17	443
490	App\\Models\\Submission	17	444
491	App\\Models\\Submission	17	445
492	App\\Models\\Submission	17	446
493	App\\Models\\Submission	17	447
494	App\\Models\\Submission	18	448
495	App\\Models\\Submission	18	414
496	App\\Models\\Submission	18	449
497	App\\Models\\Submission	18	416
498	App\\Models\\Submission	18	450
499	App\\Models\\Submission	18	413
500	App\\Models\\Submission	19	451
501	App\\Models\\Submission	19	445
502	App\\Models\\Submission	19	439
503	App\\Models\\Submission	19	452
504	App\\Models\\Submission	19	453
505	App\\Models\\Submission	19	454
506	App\\Models\\Submission	20	455
507	App\\Models\\Submission	20	418
508	App\\Models\\Submission	20	456
509	App\\Models\\Submission	20	457
510	App\\Models\\Submission	20	390
511	App\\Models\\Submission	21	458
512	App\\Models\\Submission	21	459
513	App\\Models\\Submission	21	460
514	App\\Models\\Submission	22	420
515	App\\Models\\Submission	22	426
516	App\\Models\\Submission	22	461
517	App\\Models\\Submission	22	400
518	App\\Models\\Submission	22	462
519	App\\Models\\Submission	22	447
520	App\\Models\\Submission	22	411
521	App\\Models\\Submission	23	463
522	App\\Models\\Submission	23	451
523	App\\Models\\Submission	23	464
524	App\\Models\\Submission	23	465
525	App\\Models\\Submission	23	413
526	App\\Models\\Submission	24	464
527	App\\Models\\Submission	24	407
528	App\\Models\\Submission	24	456
529	App\\Models\\Submission	24	466
530	App\\Models\\Submission	24	467
531	App\\Models\\Submission	24	468
532	App\\Models\\Submission	24	469
533	App\\Models\\Submission	25	399
534	App\\Models\\Submission	25	470
535	App\\Models\\Submission	25	419
536	App\\Models\\Submission	25	420
537	App\\Models\\Submission	26	471
538	App\\Models\\Submission	26	413
539	App\\Models\\Submission	26	472
\.


--
-- Name: tagged_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tagged_id_seq', 539, true);


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tags (id, namespace, slug, name, count) FROM stdin;
1	App\\Models\\Video	lady	Lady	1
2	App\\Models\\Video	gaga	Gaga	1
3	App\\Models\\Video	streamlineinterscoopekonlivecherrytree	Streamline/Interscoope/KonLive/Cherrytree	1
4	App\\Models\\Video	pop	Pop	1
6	App\\Models\\Video	riding	riding	1
7	App\\Models\\Video	riding-bmx	riding bmx	1
8	App\\Models\\Video	watch-this	watch this	1
9	App\\Models\\Video	viral	viral	1
10	App\\Models\\Video	viral-video	viral video	1
11	App\\Models\\Video	crash	crash	1
12	App\\Models\\Video	crashing	crashing	1
13	App\\Models\\Video	insane	insane	1
14	App\\Models\\Video	crazy	crazy	1
15	App\\Models\\Video	amazing	amazing	1
16	App\\Models\\Video	nuts	nuts	1
17	App\\Models\\Video	insane-bmx	insane bmx	1
18	App\\Models\\Video	crazy-bmx	crazy bmx	1
19	App\\Models\\Video	amazing-bmx	amazing bmx	1
20	App\\Models\\Video	bmx-crashing	bmx crashing	1
21	App\\Models\\Video	bmx-crashes	bmx crashes	1
22	App\\Models\\Video	wheel-chair	wheel chair	1
75	App\\Models\\Video	music-video	Music Video	2
24	App\\Models\\Video	skateparks	skateparks	1
25	App\\Models\\Video	fun	fun	1
72	App\\Models\\Video	ben-cooper	Ben Cooper	1
27	App\\Models\\Video	haha	haha	1
28	App\\Models\\Video	lol	lol	1
29	App\\Models\\Video	omg	omg	1
30	App\\Models\\Video	friends	friends	1
31	App\\Models\\Video	good-time	good time	1
32	App\\Models\\Video	first	first	1
59	App\\Models\\Video	comedy	comedy	2
34	App\\Models\\Video	jump	jump	1
35	App\\Models\\Video	ramps	ramps	1
36	App\\Models\\Video	skating	skating	1
37	App\\Models\\Video	skateboarding	skateboarding	1
38	App\\Models\\Video	adam-lz	adam lz	1
39	App\\Models\\Video	backyard	backyard	1
23	App\\Models\\Video	skatepark	skatepark	2
40	App\\Models\\Video	ramp	ramp	1
5	App\\Models\\Video	bmx	bmx	2
41	App\\Models\\Video	biking	biking	1
42	App\\Models\\Video	rc-car	rc car	1
43	App\\Models\\Video	traxxas	traxxas	1
44	App\\Models\\Video	spencer	spencer	1
45	App\\Models\\Video	foresman	foresman	1
46	App\\Models\\Video	edit	edit	1
47	App\\Models\\Video	game	game	1
48	App\\Models\\Video	drone	drone	1
49	App\\Models\\Video	montage	montage	1
51	App\\Models\\Video	drift	drift	1
52	App\\Models\\Video	joe-rogan-experience	Joe Rogan Experience	1
53	App\\Models\\Video	jre-911	JRE #911	1
54	App\\Models\\Video	911	911	1
55	App\\Models\\Video	jre	JRE	1
56	App\\Models\\Video	ufc	UFC	1
57	App\\Models\\Video	ultimate-fighting-championship	Ultimate Fighting Championship	1
58	App\\Models\\Video	mma	MMA	1
80	App\\Models\\Video	social-experiment	social experiment	2
60	App\\Models\\Video	comedian	comedian	1
61	App\\Models\\Video	jokes	jokes	1
50	App\\Models\\Video	music	music	2
62	App\\Models\\Video	laugh	laugh	1
63	App\\Models\\Video	stand-up	stand up	1
64	App\\Models\\Video	podcast	podcast	1
65	App\\Models\\Video	alex-jones	Alex Jones	1
66	App\\Models\\Video	conspiracy	conspiracy	1
67	App\\Models\\Video	eddie-bravo	Eddie Bravo	1
68	App\\Models\\Video	infowars	InfoWars	1
69	App\\Models\\Video	infowarscom	InfoWars.com	1
70	App\\Models\\Video	radical-face	Radical Face	1
71	App\\Models\\Video	welcome-home	Welcome Home	1
73	App\\Models\\Video	justin-mitchell	Justin Mitchell	1
74	App\\Models\\Video	electric-president	Electric President	1
86	App\\Models\\Video	chad	chad	2
76	App\\Models\\Video	nikon	Nikon	1
77	App\\Models\\Video	reggie-watts	Reggie Watts	1
78	App\\Models\\Video	reggie-watts-spatial-full	Reggie Watts Spatial Full	1
79	App\\Models\\Video	chad-lebaron	chad lebaron	1
33	App\\Models\\Video	box	box	2
82	App\\Models\\Video	shocking-social-experiment	shocking social experiment	1
83	App\\Models\\Video	these-results-are-shocking	these results are shocking	1
84	App\\Models\\Video	are-shocking	are shocking	1
85	App\\Models\\Video	these-results	these results	1
90	App\\Models\\Video	cherd	cherd	2
87	App\\Models\\Video	cherdleys	cherdleys	1
88	App\\Models\\Video	cherdlys	cherdlys	1
89	App\\Models\\Video	churd	churd	1
81	App\\Models\\Video	shocking	shocking	2
91	App\\Models\\Video	cherdley	cherdley	1
92	App\\Models\\Video	cherdly	cherdly	1
93	App\\Models\\Video	cars	cars	1
94	App\\Models\\Video	running	running	1
95	App\\Models\\Video	in-front-of	in front of	1
96	App\\Models\\Video	in-front-of-cars	in front of cars	1
97	App\\Models\\Video	black-vs-white	black vs white	1
98	App\\Models\\Video	hit-by-car	hit by car	1
99	App\\Models\\Video	speeding-car	speeding car	1
26	App\\Models\\Video	funny	funny	5
101	App\\Models\\Video	pacific-crest-trail-2016	pacific crest trail 2016	1
140	App\\Models\\Video	system-administration	system administration	1
141	App\\Models\\Video	sysadmin	sysadmin	1
105	App\\Models\\Video	wild-movie	wild movie	1
106	App\\Models\\Video	trails	trails	1
108	App\\Models\\Video	long-distance-hiking	long distance hiking	1
109	App\\Models\\Video	trekking	trekking	1
110	App\\Models\\Video	pacific-crest-trail-california	pacific crest trail California	1
111	App\\Models\\Video	pacific-crest-trail-oregon	pacific crest trail Oregon	1
112	App\\Models\\Video	pacific-crest-trail-washington	pacific crest trail Washington	1
113	App\\Models\\Video	pacific-crest-trail-gear	pacific crest trail gear	1
114	App\\Models\\Video	pct-gear	pct gear	1
152	App\\Models\\Video	netflix	Netflix	3
116	App\\Models\\Video	canada	Canada	1
117	App\\Models\\Video	national-film-board-of-canada	National Film Board of Canada	1
142	App\\Models\\Video	how-to-become-a-system-administrator	how to become a system administrator	1
119	App\\Models\\Video	nfb	NFB	1
120	App\\Models\\Video	educational-film	Educational Film	1
121	App\\Models\\Video	classic	Classic	1
122	App\\Models\\Video	short-film	Short Film	1
123	App\\Models\\Video	universe-film	Universe (Film)	1
124	App\\Models\\Video	roman-kroitor-colin-low	Roman Kroitor & Colin Low	1
118	App\\Models\\Video	2001-a-space-odyssey	2001 A Space Odyssey	2
125	App\\Models\\Video	stanley-kubrick	Stanley Kubrick	1
126	App\\Models\\Video	nasa	NASA	1
115	App\\Models\\Video	universe	Universe	2
128	App\\Models\\Video	film-film	Film (Film)	1
129	App\\Models\\Video	film-media-genre	Film (Media Genre)	1
130	App\\Models\\Video	toronto	Toronto	1
100	App\\Models\\Video	pacific-crest-trail	pacific crest trail	2
102	App\\Models\\Video	pct	pct	2
131	App\\Models\\Video	monologue	monologue	1
132	App\\Models\\Video	preview	preview	1
133	App\\Models\\Video	sneak-peak	sneak peak	1
107	App\\Models\\Video	backpacking	backpacking	2
134	App\\Models\\Video	backpack	backpack	1
135	App\\Models\\Video	campo	campo	1
136	App\\Models\\Video	hauser-creek	hauser creek	1
137	App\\Models\\Video	appalachian-trail	Appalachian Trail	1
104	App\\Models\\Video	thru-hike	thru hike	2
103	App\\Models\\Video	hiking	hiking	3
138	App\\Models\\Video	hiker-trash	hiker trash	1
139	App\\Models\\Video	linux	Linux	1
143	App\\Models\\Video	computer-science	computer science	1
144	App\\Models\\Video	college-degree	college degree	1
145	App\\Models\\Video	university-degree	university degree	1
146	App\\Models\\Video	education	education	1
147	App\\Models\\Video	system-engineering	system engineering	1
148	App\\Models\\Video	platform-engineering	platform engineering	1
149	App\\Models\\Video	it-infrastructure	IT infrastructure	1
150	App\\Models\\Video	dear-white-people	Dear White People	1
151	App\\Models\\Video	dear-white-people-movie	dear white people movie	1
186	App\\Models\\Video	dad	dad	2
153	App\\Models\\Video	dear-white-people-trailer	dear white people trailer	1
154	App\\Models\\Video	dear-white-people-netflix	dear white people Netflix	1
155	App\\Models\\Video	maga	maga	1
156	App\\Models\\Video	delete-netflix	delete Netflix	1
157	App\\Models\\Video	boycott-netflix	boycott Netflix	1
158	App\\Models\\Video	youtube-glitch	youtube glitch	1
159	App\\Models\\Video	youtube-sub-glitch	youtube sub glitch	1
161	App\\Models\\Video	baylor-football	baylor football	1
162	App\\Models\\Video	baylor-scandal	baylor scandal	1
163	App\\Models\\Video	baylor-big-12	baylor big 12	1
164	App\\Models\\Video	nba-2k	nba 2k	1
165	App\\Models\\Video	esports	esports	1
166	App\\Models\\Video	nba-2k-eleague	nba 2k eleague	1
167	App\\Models\\Video	celebrity	celebrity	1
168	App\\Models\\Video	current-events	current events	1
169	App\\Models\\Video	daily	daily	1
170	App\\Models\\Video	news	News	1
171	App\\Models\\Video	opinion	opinion	1
172	App\\Models\\Video	politics	Politics	1
173	App\\Models\\Video	sxephil	sxephil	1
174	App\\Models\\Video	the-philip-defranco-show	the philip defranco show	1
175	App\\Models\\Video	philip-defranco-show	philip defranco show	1
176	App\\Models\\Video	youtube-news	youtube news	1
177	App\\Models\\Video	defranco	DeFranco	1
178	App\\Models\\Video	response-video	response video	1
179	App\\Models\\Video	racism	racism	1
180	App\\Models\\Video	anna	anna	1
181	App\\Models\\Video	akana	akana	1
182	App\\Models\\Video	ana	ana	1
183	App\\Models\\Video	annaakana	annaakana	1
184	App\\Models\\Video	i-need-a-cat-dad	i need a cat dad	1
185	App\\Models\\Video	cat	cat	1
160	App\\Models\\Video	h3h3	h3h3	3
187	App\\Models\\Video	i-need-a	i need a	1
188	App\\Models\\Video	valentines-day	valentine's day	1
189	App\\Models\\Video	kitten	kitten	1
190	App\\Models\\Video	kitty	kitty	1
191	App\\Models\\Video	cats	cats	1
192	App\\Models\\Video	father	father	1
193	App\\Models\\Video	rap	rap	1
194	App\\Models\\Video	song	song	1
195	App\\Models\\Video	video	video	1
196	App\\Models\\Video	anna-akana	anna akana	1
197	App\\Models\\Video	kittyes	kittyes	1
198	App\\Models\\Video	kitties	kitties	1
199	App\\Models\\Video	pewdiepie	pewdiepie	1
200	App\\Models\\Video	pdp	pdp	1
201	App\\Models\\Video	collab	collab	1
202	App\\Models\\Video	collaboration	collaboration	1
203	App\\Models\\Video	felix	felix	1
204	App\\Models\\Video	felix-kjellberg	felix kjellberg	1
205	App\\Models\\Video	kjellberg	Kjellberg	1
206	App\\Models\\Video	pewd	pewd	1
207	App\\Models\\Video	pewds	pewds	1
209	App\\Models\\Video	veritasium	veritasium	1
210	App\\Models\\Video	moon	moon	1
211	App\\Models\\Video	water	water	1
212	App\\Models\\Video	water-on-the-moon	water on the moon	1
213	App\\Models\\Video	moon-water	moon water	1
214	App\\Models\\Video	apollo	apollo	1
215	App\\Models\\Video	h2o	h2o	1
216	App\\Models\\Video	idubbbz	idubbbz	1
217	App\\Models\\Video	vlog	vlog	1
218	App\\Models\\Video	nword	nword	1
219	App\\Models\\Video	tana-mongeau	tana mongeau	1
220	App\\Models\\Video	idubbbz-tana	idubbbz tana	1
221	App\\Models\\Video	meet-n-greet	meet n greet	1
222	App\\Models\\Video	show	show	1
223	App\\Models\\Video	fullscreen-live	fullscreen live	1
224	App\\Models\\Video	event	event	1
225	App\\Models\\Video	roadtrip	roadtrip	1
226	App\\Models\\Video	lifestyle	lifestyle	1
227	App\\Models\\Video	idubbbztv	idubbbztv	1
228	App\\Models\\Video	san-francisco	san francisco	1
229	App\\Models\\Video	storytime	storytime	1
230	App\\Models\\Video	youtuber	youtuber	1
231	App\\Models\\Video	drama	drama	1
232	App\\Models\\Video	idubbbz-visits-tana-mongeau	idubbbz visits tana mongeau	1
233	App\\Models\\Video	lebaron	lebaron	1
234	App\\Models\\Video	social	social	1
235	App\\Models\\Video	experiment	experiment	1
236	App\\Models\\Video	result	result	1
237	App\\Models\\Video	may	may	1
238	App\\Models\\Video	be	be	1
239	App\\Models\\Video	cheb	cheb	1
240	App\\Models\\Video	here	here	1
241	App\\Models\\Video	what	what	1
242	App\\Models\\Video	shame	shame	1
243	App\\Models\\Video	beautiful	beautiful	1
244	App\\Models\\Video	today	today	1
245	App\\Models\\Video	im	i'm	1
246	App\\Models\\Video	going	going	1
247	App\\Models\\Video	to	to	1
248	App\\Models\\Video	teaching	teaching	1
249	App\\Models\\Video	you	you	1
250	App\\Models\\Video	how	how	1
251	App\\Models\\Video	ball	ball	1
252	App\\Models\\Video	it	it	1
253	App\\Models\\Video	up	up	1
254	App\\Models\\Video	board	board	1
255	App\\Models\\Video	at	at	1
256	App\\Models\\Video	coachella	coachella	1
257	App\\Models\\Video	beer	beer	1
258	App\\Models\\Video	inspirational	inspirational	1
259	App\\Models\\Video	frat	frat	1
260	App\\Models\\Video	jeff	jeff	1
261	App\\Models\\Video	aka	aka	1
262	App\\Models\\Video	rage	rage	1
263	App\\Models\\Video	guy	guy	1
264	App\\Models\\Video	hilarious	hilarious	1
265	App\\Models\\Video	videos	videos	1
266	App\\Models\\Video	fitness	fitness	1
267	App\\Models\\Video	excercise	excercise	1
268	App\\Models\\Video	gym	gym	1
269	App\\Models\\Video	workout	workout	1
270	App\\Models\\Video	connor-murphy	connor murphy	1
208	App\\Models\\Video	h3h3productions	h3h3productions	2
271	App\\Models\\Video	boston-terrier	boston terrier	1
272	App\\Models\\Video	cute	cute	1
273	App\\Models\\Video	dog	dog	1
274	App\\Models\\Video	puppy	puppy	1
275	App\\Models\\Video	puppies	puppies	1
276	App\\Models\\Video	cutest-dog-in-the-world	cutest dog in the world	1
277	App\\Models\\Video	cutest-puppy-ever	cutest puppy ever	1
278	App\\Models\\Video	mockumentary	mockumentary	1
279	App\\Models\\Video	interview	interview	1
280	App\\Models\\Video	sketch	sketch	1
281	App\\Models\\Video	lahwf	lahwf	1
283	App\\Models\\Video	luke-donohue	luke donohue	1
284	App\\Models\\Video	aryia	aryia	1
285	App\\Models\\Video	bonnie	Bonnie	1
286	App\\Models\\Video	dont-touch-her	don't touch her	1
287	App\\Models\\Video	you-cant-touch-her	you can't touch her	1
288	App\\Models\\Video	prank	prank	1
289	App\\Models\\Video	tinder	tinder	1
290	App\\Models\\Video	dating	dating	1
291	App\\Models\\Video	app	app	1
292	App\\Models\\Video	chick-magnet	chick magnet	1
293	App\\Models\\Video	picking-up-girls	picking up girls	1
127	App\\Models\\Video	documentary	Documentary	3
282	App\\Models\\Video	andrew-hales	andrew hales	2
294	App\\Models\\Video	stuffed-mushrooms-recipe	stuffed mushrooms recipe	1
295	App\\Models\\Video	stuffed-mushrooms	stuffed mushrooms	1
296	App\\Models\\Video	stuffed-mushroom	stuffed mushroom	1
297	App\\Models\\Video	how-to-make-stuffed-mushrooms	how to make stuffed mushrooms	1
298	App\\Models\\Video	baked-mushrooms	baked mushrooms	1
299	App\\Models\\Video	best-stuffed-mushrooms	best stuffed mushrooms	1
300	App\\Models\\Video	appetizers	appetizers	1
301	App\\Models\\Video	party-foods	party foods	1
302	App\\Models\\Video	mushroom-recipe	mushroom recipe	1
303	App\\Models\\Video	recipe	recipe	1
304	App\\Models\\Video	button-mushrooms	button mushrooms	1
305	App\\Models\\Video	crimini-mushrooms	crimini mushrooms	1
306	App\\Models\\Video	mushroom-caps	mushroom caps	1
307	App\\Models\\Video	mushroom-tops	mushroom tops	1
308	App\\Models\\Video	appetizer-recipes	appetizer recipes	1
309	App\\Models\\Video	party	party	1
310	App\\Models\\Video	appetizer	appetizer	1
311	App\\Models\\Video	healthy	healthy	1
312	App\\Models\\Video	recipes	recipes	1
313	App\\Models\\Video	cook	cook	1
314	App\\Models\\Video	cooking	cooking	1
315	App\\Models\\Video	food	food	1
316	App\\Models\\Video	easy	easy	1
317	App\\Models\\Video	how-to-cook	how to cook	1
318	App\\Models\\Video	how-to	how-to	1
319	App\\Models\\Video	howto	howto	1
320	App\\Models\\Video	make	make	1
321	App\\Models\\Video	how-to-make	how to make	1
322	App\\Models\\Video	chef-buck	chef buck	1
323	App\\Models\\Video	vegetarian	vegetarian	1
324	App\\Models\\Video	mushroom	mushroom	1
325	App\\Models\\Video	mushrooms	mushrooms	1
326	App\\Models\\Video	space	space	1
327	App\\Models\\Video	gravity	gravity	1
328	App\\Models\\Video	ariane-6	ariane 6	1
329	App\\Models\\Video	rocket	rocket	1
330	App\\Models\\Video	spacetravel	spacetravel	1
331	App\\Models\\Video	human	human	1
332	App\\Models\\Video	earth	earth	1
333	App\\Models\\Video	solar-system	solar system	1
334	App\\Models\\Video	galaxy	galaxy	1
335	App\\Models\\Video	gravity-well	gravity well	1
336	App\\Models\\Video	gravity-prison	gravity prison	1
337	App\\Models\\Video	kurzgesagt	kurzgesagt	1
338	App\\Models\\Video	in-a-nutshell	in a nutshell	1
339	App\\Models\\Video	top-10	top 10	1
340	App\\Models\\Video	documentaries	documentaries	1
341	App\\Models\\Video	favorite	favorite	1
342	App\\Models\\Video	list	list	1
343	App\\Models\\Video	top-ten	top ten	1
344	App\\Models\\Video	best	best	1
345	App\\Models\\Video	films	films	1
346	App\\Models\\Video	vlogs	vlogs	1
347	App\\Models\\Video	lahwfextra	lahwfextra	1
348	App\\Models\\Video	my-favorite	my favorite	1
349	App\\Models\\Video	movies	movies	1
350	App\\Models\\Video	super-size-me	super size me	1
351	App\\Models\\Video	grizzly-man	grizzly man	1
352	App\\Models\\Video	werner-herzog	werner herzog	1
353	App\\Models\\Video	film-maker	film maker	1
354	App\\Models\\Video	man-on-wire	man on wire	1
355	App\\Models\\Video	montage-of-heck	montage of heck	1
356	App\\Models\\Video	amy	amy	1
357	App\\Models\\Video	going-clear	going clear	1
358	App\\Models\\Video	hbo	hbo	1
359	App\\Models\\Video	scientology	scientology	1
360	App\\Models\\Video	the-union	the union	1
361	App\\Models\\Video	black-fish	black fish	1
362	App\\Models\\Video	hulu	hulu	1
363	App\\Models\\Video	amazon-prime	amazon prime	1
364	App\\Models\\Video	jiro-dreams-of-sushi	jiro dreams of sushi	1
365	App\\Models\\Video	the-jinx	the jinx	1
366	App\\Models\\Video	robert-durst	robert durst	1
367	App\\Models\\Video	making-a-murderer	making a murderer	1
368	App\\Models\\Video	best-films-of-all-time	best films of all time	1
369	App\\Models\\Video	best-documentaries	best documentaries	1
370	App\\Models\\Video	oscars	oscars	1
371	App\\Models\\Video	awards	awards	1
372	App\\Models\\Video	cinema	cinema	1
373	App\\Models\\Video	cinematography	cinematography	1
374	App\\Models\\Video	feature-length	feature length	1
375	App\\Models\\Video	sixtysymbols	sixtysymbols	1
376	App\\Models\\Video	string-theory	string theory	1
377	App\\Models\\Video	cosmology	cosmology	1
378	App\\Models\\Video	arcade	Arcade	1
379	App\\Models\\Video	fire	Fire	1
380	App\\Models\\Video	rebellion	Rebellion	1
381	App\\Models\\Video	lies	(Lies)	1
382	App\\Models\\Video	eagle	Eagle	1
383	App\\Models\\Video	rock	Rock	1
384	App\\Models\\Video	alternative	Alternative	1
385	App\\Models\\Submission	placeat	placeat	1
386	App\\Models\\Submission	pariatur	pariatur	1
387	App\\Models\\Submission	culpa	culpa	1
390	App\\Models\\Submission	dolores	dolores	2
389	App\\Models\\Submission	vero	vero	1
388	App\\Models\\Submission	voluptatem	voluptatem	2
392	App\\Models\\Submission	eos	eos	1
455	App\\Models\\Submission	soluta	soluta	1
394	App\\Models\\Submission	ea	ea	1
395	App\\Models\\Submission	ab	ab	1
397	App\\Models\\Submission	ratione	ratione	1
398	App\\Models\\Submission	fugit	fugit	1
472	App\\Models\\Submission	unde	unde	1
407	App\\Models\\Submission	dicta	dicta	2
401	App\\Models\\Submission	explicabo	explicabo	1
437	App\\Models\\Submission	enim	enim	1
403	App\\Models\\Submission	autem	autem	1
418	App\\Models\\Submission	fugiat	fugiat	2
404	App\\Models\\Submission	similique	similique	1
405	App\\Models\\Submission	reiciendis	reiciendis	1
406	App\\Models\\Submission	aspernatur	aspernatur	1
408	App\\Models\\Submission	omnis	omnis	1
409	App\\Models\\Submission	impedit	impedit	1
402	App\\Models\\Submission	deleniti	deleniti	2
410	App\\Models\\Submission	dolorum	dolorum	1
456	App\\Models\\Submission	quasi	quasi	2
412	App\\Models\\Submission	repellendus	repellendus	1
391	App\\Models\\Submission	beatae	beatae	2
417	App\\Models\\Submission	magni	magni	1
457	App\\Models\\Submission	maxime	maxime	1
466	App\\Models\\Submission	itaque	itaque	1
422	App\\Models\\Submission	sit	sit	1
423	App\\Models\\Submission	sapiente	sapiente	1
424	App\\Models\\Submission	aperiam	aperiam	1
438	App\\Models\\Submission	amet	amet	1
425	App\\Models\\Submission	rem	rem	2
427	App\\Models\\Submission	necessitatibus	necessitatibus	1
428	App\\Models\\Submission	incidunt	incidunt	1
429	App\\Models\\Submission	nostrum	nostrum	1
393	App\\Models\\Submission	veritatis	veritatis	3
430	App\\Models\\Submission	hic	hic	1
431	App\\Models\\Submission	voluptate	voluptate	1
432	App\\Models\\Submission	quis	quis	1
421	App\\Models\\Submission	sint	sint	2
458	App\\Models\\Submission	voluptatum	voluptatum	1
433	App\\Models\\Submission	in	in	1
415	App\\Models\\Submission	quidem	quidem	2
434	App\\Models\\Submission	officiis	officiis	1
435	App\\Models\\Submission	numquam	numquam	1
396	App\\Models\\Submission	sed	sed	3
440	App\\Models\\Submission	dignissimos	dignissimos	1
441	App\\Models\\Submission	inventore	inventore	1
436	App\\Models\\Submission	possimus	possimus	2
442	App\\Models\\Submission	reprehenderit	reprehenderit	1
443	App\\Models\\Submission	delectus	delectus	1
444	App\\Models\\Submission	voluptatibus	voluptatibus	1
459	App\\Models\\Submission	qui	qui	1
446	App\\Models\\Submission	illo	illo	1
467	App\\Models\\Submission	voluptates	voluptates	1
448	App\\Models\\Submission	nihil	nihil	1
414	App\\Models\\Submission	et	et	5
449	App\\Models\\Submission	quaerat	quaerat	1
416	App\\Models\\Submission	ut	ut	2
450	App\\Models\\Submission	illum	illum	1
468	App\\Models\\Submission	repudiandae	repudiandae	1
445	App\\Models\\Submission	dolor	dolor	2
439	App\\Models\\Submission	aut	aut	2
452	App\\Models\\Submission	cumque	cumque	1
453	App\\Models\\Submission	atque	atque	1
454	App\\Models\\Submission	cupiditate	cupiditate	1
460	App\\Models\\Submission	nulla	nulla	1
426	App\\Models\\Submission	distinctio	distinctio	2
461	App\\Models\\Submission	error	error	1
400	App\\Models\\Submission	est	est	2
462	App\\Models\\Submission	eius	eius	1
447	App\\Models\\Submission	esse	esse	2
411	App\\Models\\Submission	quia	quia	2
463	App\\Models\\Submission	quo	quo	1
451	App\\Models\\Submission	consequuntur	consequuntur	2
465	App\\Models\\Submission	magnam	magnam	1
464	App\\Models\\Submission	vel	vel	2
469	App\\Models\\Submission	sunt	sunt	1
399	App\\Models\\Submission	dolorem	dolorem	2
470	App\\Models\\Submission	quod	quod	1
419	App\\Models\\Submission	non	non	3
420	App\\Models\\Submission	porro	porro	3
471	App\\Models\\Submission	neque	neque	1
413	App\\Models\\Submission	molestiae	molestiae	4
\.


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tags_id_seq', 472, true);


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY topics (id, google_id, slug, name, json, count, created_at, updated_at) FROM stdin;
1	/m/0478__m	\N	Lady Gaga	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0478__m","name":"Lady Gaga","@type":["Person","Thing"],"description":"Singer-songwriter","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcTotytMaY9gb94XgsQmQV0WqTZpxfyG_J7GjRl0-40Wp8wSc8ug","url":"https:\\/\\/simple.wikipedia.org\\/wiki\\/Lady_Gaga","license":"http:\\/\\/creativecommons.org\\/licenses\\/by\\/2.0"},"detailedDescription":{"articleBody":"Stefani Joanne Angelina Germanotta, known professionally as Lady Gaga, is an American singer, songwriter, and actress. She performed initially in theater, appearing in high school plays, and studied at CAP21 through NYU's Tisch School of the Arts before dropping out to pursue a musical career. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Lady_Gaga","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.ladygaga.com\\/"},"resultScore":29.558249}	0	2017-02-12 22:33:23	2017-02-12 22:33:23
2	/m/0ftryzw	\N	Bad Romance	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0ftryzw","name":"Bad Romance","@type":["MusicRecording","Thing"],"description":"Song by Lady Gaga"},"resultScore":6.303305}	0	2017-02-12 22:33:23	2017-02-12 22:33:23
3	/m/0807c3_	\N	\N	\N	0	2017-02-12 22:33:23	2017-02-12 22:33:23
4	/m/074ft	\N	\N	\N	0	2017-02-12 22:33:23	2017-02-12 22:33:23
5	/m/0mdxd	\N	\N	\N	0	2017-02-12 22:33:23	2017-02-12 22:33:23
6	/m/04rlf	\N	\N	\N	0	2017-02-12 22:33:23	2017-02-12 22:33:23
7	/m/064t9	\N	\N	\N	0	2017-02-12 22:33:23	2017-02-12 22:33:23
8	/m/09hkc	\N	\N	\N	0	2017-02-12 22:33:24	2017-02-12 22:33:24
9	/m/0199g	\N	\N	\N	0	2017-02-12 22:33:24	2017-02-12 22:33:24
10	/m/0g45k9	\N	Scotty Cranmer	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0g45k9","name":"Scotty Cranmer","@type":["Thing","Person"],"detailedDescription":{"articleBody":"Scotty Cranmer is an American BMX rider. He is tied with Dave Mirra for the most X Games BMX Park medals with nine, three each in gold, silver and bronze over fourteen appearances. He attended Jackson Memorial High School. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Scotty_Cranmer","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":15.090113}	0	2017-02-12 22:33:25	2017-02-12 22:33:25
11	/m/01gl72	\N	\N	\N	0	2017-02-12 22:33:25	2017-02-12 22:33:25
12	/m/06ntj	\N	\N	\N	0	2017-02-12 22:33:25	2017-02-12 22:33:25
13	/m/06zfw	\N	\N	\N	0	2017-02-12 22:33:25	2017-02-12 22:33:25
14	/m/01sgl	\N	\N	\N	0	2017-02-12 22:33:25	2017-02-12 22:33:25
15	/m/05b0n7k	\N	\N	\N	0	2017-02-12 22:33:25	2017-02-12 22:33:25
16	/m/08b6yt	\N	\N	\N	0	2017-02-12 22:33:25	2017-02-12 22:33:25
17	/m/08t0vy	\N	\N	\N	0	2017-02-12 22:33:25	2017-02-12 22:33:25
18	/m/09qkx	\N	\N	\N	0	2017-02-12 22:33:25	2017-02-12 22:33:25
19	/m/04rh6b	\N	\N	\N	0	2017-02-12 22:33:25	2017-02-12 22:33:25
20	/m/03hs7k	\N	\N	\N	0	2017-02-12 22:33:25	2017-02-12 22:33:25
21	/m/07yv9	\N	\N	\N	0	2017-02-12 22:33:25	2017-02-12 22:33:25
22	/m/01n33z	\N	Joe Rogan	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01n33z","name":"Joe Rogan","@type":["Person","Thing"],"description":"Comedian","image":{"contentUrl":"http:\\/\\/t0.gstatic.com\\/images?q=tbn:ANd9GcSyNVl1ABw3HIRxjrnKu2x5XU-I0v8oHo1zHc_TIO9clUfLPnhj","url":"https:\\/\\/simple.wikipedia.org\\/wiki\\/Joe_Rogan","license":"http:\\/\\/creativecommons.org\\/licenses\\/by\\/2.0"},"detailedDescription":{"articleBody":"Joseph James \\"Joe\\" Rogan is an American stand-up comedian, sports color commentator, television host, actor, and podcast host. Born in Newark, New Jersey, Rogan and his family moved several times before they settled in Newton Upper Falls, Massachusetts. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Joe_Rogan","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/joerogan.net\\/"},"resultScore":20.564383}	0	2017-02-12 22:33:26	2017-02-12 22:33:26
23	/m/01_6j_	\N	Alex Jones	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01_6j_","name":"Alex Jones","@type":["Person","Thing"],"description":"Radio host","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcRmIVNYmckayjYoT9IhW1vX928BhjX8nVDoAW7px7ByVsva0x23","url":"https:\\/\\/simple.wikipedia.org\\/wiki\\/Alex_Jones","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/2.0"},"detailedDescription":{"articleBody":"Alexander Emerick \\"Alex\\" Jones is an American right-wing radio show host, filmmaker, writer, and conspiracy theorist. He hosts The Alex Jones Show from Austin, Texas, which airs on the Genesis Communications Network and shortwave radio station WWCR across the United States and online. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Alex_Jones_(radio_host)","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.infowars.com\\/"},"resultScore":22.353977}	0	2017-02-12 22:33:27	2017-02-12 22:33:27
24	/m/08rm_x	\N	Eddie Bravo	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/08rm_x","name":"Eddie Bravo","@type":["Person","Thing"],"image":{"contentUrl":"http:\\/\\/t0.gstatic.com\\/images?q=tbn:ANd9GcTXZxRWA6CSPh-1JZzKfiZG2WlLQsTAu0LBSDUbbCkjIv4YOz7Y","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Eddie_Bravo"},"detailedDescription":{"articleBody":"Edgar \\"Eddie\\" Bravo is an American Jiu-Jitsu instructor and the founder of 10th Planet Jiu-Jitsu.","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Eddie_Bravo","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":15.273909}	0	2017-02-12 22:33:27	2017-02-12 22:33:27
25	/m/02jjt	\N	\N	\N	0	2017-02-12 22:33:27	2017-02-12 22:33:27
26	/m/01x2m_y	\N	Radical Face	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01x2m_y","name":"Radical Face","@type":["Thing"],"description":"Musical Artist","detailedDescription":{"articleBody":"Radical Face is a musical act whose main member is Ben Cooper.","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Radical_Face","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.radicalface.com\\/"},"resultScore":15.498034}	0	2017-02-12 22:33:27	2017-02-12 22:33:27
27	/m/01f4vzq	\N	Welcome Home	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01f4vzq","name":"Welcome Home","@type":["MusicRecording","Thing"],"description":"Song by Radical Face"},"resultScore":5.584968}	0	2017-02-12 22:33:27	2017-02-12 22:33:27
28	/m/0_kd_k5	\N	\N	\N	0	2017-02-12 22:33:27	2017-02-12 22:33:27
29	/m/0342h	\N	\N	\N	0	2017-02-12 22:33:28	2017-02-12 22:33:28
30	/m/01rlyjc	\N	Reggie Watts	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01rlyjc","name":"Reggie Watts","@type":["Thing","Person"],"description":"Musician","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcTWRxWITwRnOUWVBsuNvarcsc9mzoCa3pf2VPEXPA6PeRj6-0lR","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Reggie_Watts_at_PopTech_2011_(a).jpg","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/2.0"},"detailedDescription":{"articleBody":"Reginald Lucien Frank Roger \\"Reggie\\" Watts is an American musician, singer, beatboxer, actor, and comedian. His improvised musical sets are created using only his voice, a keyboard, and a looping machine. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Reggie_Watts","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.reggiewatts.com\\/"},"resultScore":18.374756}	0	2017-02-12 22:33:28	2017-02-12 22:33:28
100	/m/07kk5	\N	\N	\N	0	2017-02-12 22:33:43	2017-02-12 22:33:43
101	/m/094dsh	\N	\N	\N	0	2017-02-12 22:33:43	2017-02-12 22:33:43
102	/m/06nzl	\N	\N	\N	0	2017-02-12 22:33:43	2017-02-12 22:33:43
31	/m/017rf_	\N	Netflix	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/017rf_","name":"Netflix","@type":["Thing","Organization","Corporation"],"description":"Company","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcTvwi94qQVasbn-bIrq0zCSsiyWW0fDxhbEG66TYJoBub58vuwZ","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Netflix_logo.svg"},"detailedDescription":{"articleBody":"Netflix, Inc. is an American entertainment company founded on August 29, 1997, in Scotts Valley, California, by Reed Hastings and Marc Randolph. It specializes in and provides streaming media and video-on-demand online and DVD by mail. In 2013 Netflix expanded into film and television production, as well as online distribution. As of 2017 the company has its headquarters in Los Gatos, California.\\nIn 1998, about a year after Netflix's founding, the company grew by starting in the DVD by mail business. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Netflix","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":42.148872}	0	2017-02-12 22:33:29	2017-02-12 22:33:29
32	/m/018gz8	\N	\N	\N	0	2017-02-12 22:33:29	2017-02-12 22:33:29
33	/m/033lpr	\N	\N	\N	0	2017-02-12 22:33:29	2017-02-12 22:33:29
34	/m/015lz1	\N	\N	\N	0	2017-02-12 22:33:29	2017-02-12 22:33:29
35	/m/01gq53	\N	\N	\N	0	2017-02-12 22:33:29	2017-02-12 22:33:29
36	/m/09kqc	\N	\N	\N	0	2017-02-12 22:33:29	2017-02-12 22:33:29
37	/m/0k4j	\N	\N	\N	0	2017-02-12 22:33:29	2017-02-12 22:33:29
38	/m/0g94m	\N	\N	\N	0	2017-02-12 22:33:29	2017-02-12 22:33:29
39	/m/0hrh365	\N	\N	\N	0	2017-02-12 22:33:29	2017-02-12 22:33:29
40	/m/0bqb0z	\N	\N	\N	0	2017-02-12 22:33:29	2017-02-12 22:33:29
41	/m/016clk	\N	Pacific Crest Trail	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/016clk","name":"Pacific Crest Trail","@type":["Thing","Place"],"description":"Park","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcSTfSEl0_HcRQ2v1KRIdrpCq72P4mQyH3S379JlI125zC7IFmZl","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Pacific_crest_trail_route_overview.png"},"detailedDescription":{"articleBody":"The Pacific Crest Trail is a long-distance hiking and equestrian trail closely aligned with the highest portion of the Sierra Nevada and Cascade mountain ranges, which lie 100 to 150 miles east of the U.S. Pacific coast. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Pacific_Crest_Trail","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":19.312973}	0	2017-02-12 22:33:30	2017-02-12 22:33:30
42	/m/07j7r	\N	Tree	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/07j7r","name":"Tree","@type":["Thing"],"description":"Plant","image":{"contentUrl":"http:\\/\\/t1.gstatic.com\\/images?q=tbn:ANd9GcTK6gW1d8ZXaaMHStFqYUhb6VmrgrUZIerqgsKWGSleVVW1nVGb","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Tree","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/2.0"},"detailedDescription":{"articleBody":"In botany, a tree is a perennial plant with an elongated stem, or trunk, supporting branches and leaves in most species. In some usages, the definition of a tree may be narrower, including only woody plants with secondary growth, plants that are usable as lumber or plants above a specified height. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Tree","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":27.303528}	0	2017-02-12 22:33:30	2017-02-12 22:33:30
43	/m/05h0n	\N	\N	\N	0	2017-02-12 22:33:30	2017-02-12 22:33:30
44	/m/012v4j	\N	\N	\N	0	2017-02-12 22:33:31	2017-02-12 22:33:31
45	/m/0hm03	\N	\N	\N	0	2017-02-12 22:33:31	2017-02-12 22:33:31
46	/m/023bbt	\N	\N	\N	0	2017-02-12 22:33:31	2017-02-12 22:33:31
47	/m/02zr8	\N	\N	\N	0	2017-02-12 22:33:31	2017-02-12 22:33:31
48	/m/03hfn0	\N	\N	\N	0	2017-02-12 22:33:31	2017-02-12 22:33:31
49	/m/01h6d4	\N	\N	\N	0	2017-02-12 22:33:31	2017-02-12 22:33:31
50	/m/09d_r	\N	\N	\N	0	2017-02-12 22:33:31	2017-02-12 22:33:31
51	/m/098kym	\N	\N	\N	0	2017-02-12 22:33:31	2017-02-12 22:33:31
52	/m/019_rr	\N	\N	\N	0	2017-02-12 22:33:31	2017-02-12 22:33:31
53	/m/03glg	\N	\N	\N	0	2017-02-12 22:33:31	2017-02-12 22:33:31
54	/m/07bxq	\N	\N	\N	0	2017-02-12 22:33:31	2017-02-12 22:33:31
55	/m/014l4w	\N	National Film Board of Canada	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/014l4w","name":"National Film Board of Canada","@type":["GovernmentOrganization","Thing","Corporation","Organization"],"description":"Film distributor","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcQNzzUpRRcRRg9lao4L25JBUXmxnGEbkpq4-ClrC3SVz1hAerVm","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Office_national_du_film_montreal.jpg","license":"http:\\/\\/www.gnu.org\\/copyleft\\/fdl.html"},"detailedDescription":{"articleBody":"The National Film Board of Canada is Canada's twelve-time Academy Award-winning public film and digital media producer and distributor. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/National_Film_Board_of_Canada","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.NFB.ca"},"resultScore":20.777863}	0	2017-02-12 22:33:31	2017-02-12 22:33:31
56	/m/04byh1	\N	Universe	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/04byh1","name":"Universe","@type":["Thing","Movie"],"description":"1960 film","detailedDescription":{"articleBody":"Universe is a black-and-white short animated documentary made in 1960 by the National Film Board of Canada. It \\"creates on the screen a vast, awe-inspiring picture of the universe as it would appear to a voyager through space. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Universe_(1960_film)","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":9.422796}	0	2017-02-12 22:33:31	2017-02-12 22:33:31
57	/m/0d060g	\N	Canada	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0d060g","name":"Canada","@type":["Country","Place","Thing","AdministrativeArea"],"description":"Country","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcRhs5VpCA5iyxCPBZz6bEfI5C4H9uDrGBFnlbP4kBs70iRynyip","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Flag_of_Canada_(Pantone).svg"},"detailedDescription":{"articleBody":"Canada is a country in the northern half of North America. Its ten provinces and three territories extend from the Atlantic to the Pacific and northward into the Arctic Ocean, covering 9.98 million square kilometres, making it the world's second-largest country by total area and the fourth-largest country by land area. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Canada","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.gc.ca\\/"},"resultScore":40.565987}	0	2017-02-12 22:33:32	2017-02-12 22:33:32
58	/m/02wc06	\N	Roman Kroitor	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/02wc06","name":"Roman Kroitor","@type":["Person","Thing"],"description":"Filmmaker","detailedDescription":{"articleBody":"Roman Kroitor was a Canadian filmmaker who was known as an early practitioner of Cin\\u00e9ma v\\u00e9rit\\u00e9, as co-founder of IMAX, and as creator of the Sandde hand-drawn stereoscopic animation system. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Roman_Kroitor","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":11.433697}	0	2017-02-12 22:33:32	2017-02-12 22:33:32
59	/m/02vxn	\N	\N	\N	0	2017-02-12 22:33:32	2017-02-12 22:33:32
60	/m/01d9ll	\N	\N	\N	0	2017-02-12 22:33:32	2017-02-12 22:33:32
61	/m/0jtdp	\N	\N	\N	0	2017-02-12 22:33:32	2017-02-12 22:33:32
62	/m/0lyj0	\N	Appalachian National Scenic Trail	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0lyj0","name":"Appalachian National Scenic Trail","@type":["Thing","TouristAttraction","Place"],"description":"National Park","image":{"contentUrl":"http:\\/\\/t0.gstatic.com\\/images?q=tbn:ANd9GcSBjbfJ19NbtMbpTI43JeI7ERohCE47K0DvDfmBj4n8r1pz-CO7","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Appalachian_Trail_sign_in_Pennsylvania.JPG","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/3.0"},"detailedDescription":{"articleBody":"The Appalachian National Scenic Trail, generally known as the Appalachian Trail or simply the A.T., is a marked hiking trail in the eastern United States extending between Springer Mountain in Georgia and Mount Katahdin in Maine. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Appalachian_Trail","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":22.681515}	0	2017-02-12 22:33:32	2017-02-12 22:33:32
63	/m/0lm0n	\N	Appalachian Mountains	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0lm0n","name":"Appalachian Mountains","@type":["Mountain","Thing","Place"],"description":"Mountain system","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcSNaRAZgGHHaV3_kNDemYsEBx_T4Lmm6A8ts3k_STXem6gmOaub","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:MonNatForest.jpg","license":"http:\\/\\/www.gnu.org\\/copyleft\\/fdl.html"},"detailedDescription":{"articleBody":"The Appalachian Mountains, often called the Appalachians, are a system of mountains in eastern North America. The Appalachians first formed roughly 480 million years ago during the Ordovician Period. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Appalachian_Mountains","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":23.68317}	0	2017-02-12 22:33:33	2017-02-12 22:33:33
64	/m/0148v7	\N	\N	\N	0	2017-02-12 22:33:33	2017-02-12 22:33:33
65	/m/016bnh	\N	\N	\N	0	2017-02-12 22:33:33	2017-02-12 22:33:33
66	/m/01mf0	\N	\N	\N	0	2017-02-12 22:33:33	2017-02-12 22:33:33
67	/m/07c1v	\N	\N	\N	0	2017-02-12 22:33:33	2017-02-12 22:33:33
68	/m/0z_7x56	\N	Dear White People	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0z_7x56","name":"Dear White People","@type":["Movie","Thing"],"description":"2014 film","detailedDescription":{"articleBody":"Dear White People is a 2014 American satirical comedy-drama film, written, directed, and co-produced by Justin Simien. The film focuses on escalating racial tensions at a prestigious Ivy League college from the perspective of several African American students. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Dear_White_People","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.dearwhitepeoplemovie.com\\/"},"resultScore":16.10474}	0	2017-02-12 22:33:34	2017-02-12 22:33:34
69	/m/051x4df	\N	Philip DeFranco	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/051x4df","name":"Philip DeFranco","@type":["Thing","Person"],"description":"Video blogger","image":{"contentUrl":"http:\\/\\/t0.gstatic.com\\/images?q=tbn:ANd9GcQxYEK-spxxDrx5dGrXi277fxeJiYi0XrONP7sT0G_SOdC98geX","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Philip_DeFranco","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/3.0"},"detailedDescription":{"articleBody":"Philip James DeFranco Jr, is an American video blogger and YouTube personality. He is most notable for The Philip DeFranco Show, usually abbreviated as PDS, a news show centered on current events, politics, pop culture, and celebrity gossip in which he voices his opinion, often presented in a satirical manner and with frequent jump cuts to create a fast-paced feel. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Philip_DeFranco","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/phillyd.tv\\/"},"resultScore":17.549507}	0	2017-02-12 22:33:34	2017-02-12 22:33:34
70	/m/06d4h	\N	\N	\N	0	2017-02-12 22:33:34	2017-02-12 22:33:34
71	/m/010n_ch8	\N	Anna Akana	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/010n_ch8","name":"Anna Akana","@type":["Thing","Person"],"description":"Filmmaker","detailedDescription":{"articleBody":"Anna Kay Akana is an American filmmaker, producer, actress, comedienne, and model. She is known for her YouTube channel, which has over 1.5 million subscribers and over 100 million video views.","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Anna_Akana","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.annaakana.com\\/"},"resultScore":15.759341}	0	2017-02-12 22:33:35	2017-02-12 22:33:35
72	/m/0jbk	\N	Animal	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0jbk","name":"Animal","@type":["Thing"],"image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcQ9tdhmB3iQe9zysaKtGyaQmus2XVDAHs5jjf5zkH4dzXZgHykz","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Animal_diversity_October_2007_for_thumbnail.jpg","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/3.0"},"detailedDescription":{"articleBody":"Animals are multicellular, eukaryotic organisms of the kingdom Animalia. The animal kingdom emerged as a basal clade within Apoikozoa as a sister of the choanoflagellates. Sponges are the most basal clade of animals. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Animal","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":39.50462}	0	2017-02-12 22:33:36	2017-02-12 22:33:36
73	/m/01yrx	\N	cat	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01yrx","name":"cat","@type":["Thing"],"description":"Animal","image":{"contentUrl":"http:\\/\\/t1.gstatic.com\\/images?q=tbn:ANd9GcShZghyt2L03zlqdj_6F7EPbCCsWWnAcVsvJ3_xv7cc-IraZc-o","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Cat_March_2010-1.jpg","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/3.0"},"detailedDescription":{"articleBody":"The domestic cat is a small, typically furry, carnivorous mammal. They are often called house cats when kept as indoor pets or simply cats when there is no need to distinguish them from other felids and felines. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Cat","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":29.050875}	0	2017-02-12 22:33:36	2017-02-12 22:33:36
74	/m/0lbxg	\N	\N	\N	0	2017-02-12 22:33:36	2017-02-12 22:33:36
75	/m/0k8zdxn	\N	PewDiePie	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0k8zdxn","name":"PewDiePie","@type":["Thing","Person"],"description":"Comedian","image":{"contentUrl":"http:\\/\\/t0.gstatic.com\\/images?q=tbn:ANd9GcRPnHg34RH_KudIgj76pp3nYCrq9rTivaKDcFTpajjUaDpu9lOE","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:PewDiePie_at_PAX_2015_crop.jpg","license":"http:\\/\\/creativecommons.org\\/publicdomain\\/zero\\/1.0\\/deed.en"},"detailedDescription":{"articleBody":"Felix Arvid Ulf Kjellberg, better known by his online alias PewDiePie, is a Swedish web-based comedian and video producer, best known for his Let's Play commentaries and vlogs on YouTube.\\n","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/PewDiePie","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.pewdiepie.com\\/"},"resultScore":22.620884}	0	2017-02-12 22:33:36	2017-02-12 22:33:36
76	/m/0r4_lfb	\N	\N	\N	0	2017-02-12 22:33:36	2017-02-12 22:33:36
77	/m/04wv_	\N	Moon	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/04wv_","name":"Moon","@type":["Thing"],"description":"Natural Satellite","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcRWRAcLt2z8Rz--ZzApqQ2XprbuCiowBs6oOdtQcmKN2c92x3tM","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Moon","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/3.0"},"detailedDescription":{"articleBody":"The Moon is an astronomical body that orbits planet Earth, being Earth's only permanent natural satellite. It is the fifth-largest natural satellite in the Solar System, and the largest among planetary satellites relative to the size of the planet that it orbits. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Moon","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":29.167957}	0	2017-02-12 22:33:37	2017-02-12 22:33:37
78	/m/05d1bj	\N	\N	\N	0	2017-02-12 22:33:37	2017-02-12 22:33:37
79	/m/06mq7	\N	\N	\N	0	2017-02-12 22:33:37	2017-02-12 22:33:37
80	/m/01k8wb	\N	\N	\N	0	2017-02-12 22:33:37	2017-02-12 22:33:37
81	/m/084dw	\N	\N	\N	0	2017-02-12 22:33:38	2017-02-12 22:33:38
82	/m/0bt9lr	\N	Dog	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0bt9lr","name":"Dog","@type":["Thing"],"description":"Animal","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcTtX76fJgSOyauWqsuLK15i9cgthxwi-L9zBWiWWfUYfhZxGIXW","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Too-cute-doggone-it-video-playlist.jpg","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/4.0"},"detailedDescription":{"articleBody":"The domestic dog is a member of genus Canis that forms part of the wolf-like canids, and is the most widely abundant carnivore. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Dog","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":30.541529}	0	2017-02-12 22:33:39	2017-02-12 22:33:39
83	/m/017y8_	\N	Terrier	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/017y8_","name":"Terrier","@type":["Thing"],"description":"Animal","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcS5sYl_uVjIbsjFxgnPJZhiBnQDx3p7i_TiYvdfgYScHXubZWuN","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Terrier","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/4.0"},"detailedDescription":{"articleBody":"A terrier is a dog of any one of many breeds or landraces of terrier type, which are typically small, wiry, very active and fearless dogs. Terrier breeds vary greatly in size from just 1 kg to over 32 kg and are usually categorized by size or function. There are five different groups with each group having several different breeds.","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Terrier","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":20.581709}	0	2017-02-12 22:33:39	2017-02-12 22:33:39
84	/m/02x9dk	\N	Boston Terrier	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/02x9dk","name":"Boston Terrier","@type":["Thing"],"description":"Dog Breed","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcQDpcp8xndNIF5M0Fmw4NBdwBULheeO0PYeLofhqrivF5l1j_ff","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:BostonTerrier001.JPG","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/3.0"},"detailedDescription":{"articleBody":"The Boston Terrier is a breed of dog originating in the United States. This \\"American Gentleman\\" was accepted in 1893 by the American Kennel Club as a non-sporting breed. Color and markings are important when distinguishing this breed to the AKC standard. They should be either black, brindle or seal with white markings. Bostons are small and compact with a short tail and erect ears. The AKC says they are highly intelligent and very easily trained. They are friendly and can be stubborn at times. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Boston_Terrier","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":20.558798}	0	2017-02-12 22:33:39	2017-02-12 22:33:39
85	/m/068hy	\N	\N	\N	0	2017-02-12 22:33:39	2017-02-12 22:33:39
86	/m/0d7s3w	\N	\N	\N	0	2017-02-12 22:33:39	2017-02-12 22:33:39
87	/m/0l4h_	\N	\N	\N	0	2017-02-12 22:33:39	2017-02-12 22:33:39
88	/m/05mqq3	\N	\N	\N	0	2017-02-12 22:33:39	2017-02-12 22:33:39
89	/m/0p57p	\N	\N	\N	0	2017-02-12 22:33:40	2017-02-12 22:33:40
90	/m/01mtb	\N	\N	\N	0	2017-02-12 22:33:40	2017-02-12 22:33:40
91	/m/052sf	\N	Mushroom	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/052sf","name":"Mushroom","@type":["Thing"],"description":"Food","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcRTElRA0zZBZeWI1peCmg1-CdkVSHvvUG4g6smH8mv_rm7ktuj5","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Mushroom","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/2.5"},"detailedDescription":{"articleBody":"A mushroom is the fleshy, spore-bearing fruiting body of a fungus, typically produced above ground on soil or on its food source.\\n","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Mushroom","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":23.629423}	0	2017-02-12 22:33:40	2017-02-12 22:33:40
92	/m/020t4k	\N	Stuffing	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/020t4k","name":"Stuffing","@type":["Thing"],"description":"Food","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcSuOfILP59ebdFdMcSDpHFwAdKFzcc9DuMVPCXA4o2onCwl8CUz","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Stuffing_a_turkey.jpg","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/2.0"},"detailedDescription":{"articleBody":"Stuffing, filling, or dressing is an edible substance or mixture, often a starch, used to fill a cavity in another food item while cooking. Many foods may be stuffed, including eggs, poultry, seafood, mammals, and vegetables.\\n","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Stuffing","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":19.934374}	0	2017-02-12 22:33:40	2017-02-12 22:33:40
93	/m/02q08p0	\N	\N	\N	0	2017-02-12 22:33:40	2017-02-12 22:33:40
94	/m/02wbm	\N	\N	\N	0	2017-02-12 22:33:40	2017-02-12 22:33:40
95	/m/0bqtd	\N	\N	\N	0	2017-02-12 22:33:40	2017-02-12 22:33:40
96	/m/0dv34	\N	\N	\N	0	2017-02-12 22:33:41	2017-02-12 22:33:41
97	/m/02j71	\N	Earth	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/02j71","name":"Earth","@type":["Place","Thing"],"description":"Planet","image":{"contentUrl":"http:\\/\\/t0.gstatic.com\\/images?q=tbn:ANd9GcT1mh46qaRg5na3pNLs9iakbicwHMDGgUuYN7jDdkyhgIeJky9y","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Earth_Eastern_Hemisphere.jpg"},"detailedDescription":{"articleBody":"Earth, otherwise known as the world, is the third planet from the Sun and the only object in the Universe known to harbor life. It is the densest planet in the Solar System and the largest of the four terrestrial planets.\\nAccording to radiometric dating and other sources of evidence, Earth formed about 4.54 billion years ago. Earth's gravity interacts with other objects in space, especially the Sun and the Moon, Earth's only natural satellite. During one orbit around the Sun, Earth rotates about its axis over 365 times, thus an Earth year is about 365.26 days long. Earth's axis of rotation is tilted, producing seasonal variations on the planet's surface. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Earth","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":35.737965}	0	2017-02-12 22:33:41	2017-02-12 22:33:41
98	/m/0d1w9	\N	\N	\N	0	2017-02-12 22:33:41	2017-02-12 22:33:41
99	/m/07094	\N	\N	\N	0	2017-02-12 22:33:42	2017-02-12 22:33:42
103	/m/0gvt53w	\N	The Master	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0gvt53w","name":"The Master","@type":["Movie","Thing"],"description":"2012 film","detailedDescription":{"articleBody":"The Master is a 2012 American psychological drama film written, directed, and co-produced by Paul Thomas Anderson and starring Joaquin Phoenix, Philip Seymour Hoffman, and Amy Adams. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/The_Master_(2012_film)","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.themasterfilm.com\\/"},"resultScore":20.193451}	0	2017-02-12 22:33:44	2017-02-12 22:33:44
104	/m/03hdbf	\N	\N	\N	0	2017-02-12 22:33:44	2017-02-12 22:33:44
105	/m/045wvq	\N	Arcade Fire	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/045wvq","name":"Arcade Fire","@type":["MusicGroup","Thing"],"description":"Rock band","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcRtb9OlB1HcKIUKw4Qp5uhu13lQzcKnpGGCYzfbfDLmxZnT45gj","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Arcade_fire_mg_7287.jpg","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/2.0\\/fr\\/deed.en"},"detailedDescription":{"articleBody":"Arcade Fire is a Canadian indie rock band based in Montreal, Quebec,consisting of husband and wife Win Butler and R\\u00e9gine Chassagne, along with Win's younger brother William Butler, Richard Reed Parry, Tim Kingsbury and Jeremy Gara. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Arcade_Fire","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.arcadefire.com\\/"},"resultScore":21.822828}	0	2017-02-12 22:33:44	2017-02-12 22:33:44
106	/m/025tqfq	\N	\N	\N	0	2017-02-12 22:33:44	2017-02-12 22:33:44
107	/m/01jj9zk	\N	Live at Earls Court	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01jj9zk","name":"Live at Earls Court","@type":["MusicAlbum","Thing"],"description":"Live album by Morrissey","detailedDescription":{"articleBody":"Live at Earls Court is a live album by Morrissey. Its sleeve notes state that it was \\"recorded live at Earls Court in London on the 18 December 2004 in front of 17,183 people.\\"","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Live_at_Earls_Court","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":10.61483}	0	2017-02-12 22:33:45	2017-02-12 22:33:45
108	/m/01jddz	\N	\N	\N	0	2017-02-12 22:33:45	2017-02-12 22:33:45
109	/m/04_5hy	\N	\N	\N	0	2017-02-12 22:33:45	2017-02-12 22:33:45
110	/m/039v1	\N	\N	\N	0	2017-02-12 22:33:45	2017-02-12 22:33:45
111	/m/03qtwd	\N	\N	\N	0	2017-02-12 22:33:45	2017-02-12 22:33:45
112	/m/09jwl	\N	\N	\N	0	2017-02-12 22:33:45	2017-02-12 22:33:45
\.


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('topics_id_seq', 112, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, email, username, first_name, last_name, password, has_avatar, last_sign_in, created_at, updated_at, remember_token) FROM stdin;
1	user@test.com	Anonymous-x0qj5lom	\N	\N	$2y$10$Ea2wyDbD5ytDWnB2JWY9kOU/VToTqaExocNSJkS5nb2WyPsYPecLq	f	\N	2017-02-12 22:33:22	2017-02-12 22:33:22	\N
2	user2@test.com	Anonymous-zky59q97	\N	\N	$2y$10$MWaFjDltHUo6to/HDcyUi.8zQAtb1VEK8FRc3Kmdb6ZiCPe4nkMH.	f	\N	2017-02-12 22:33:22	2017-02-12 22:33:22	\N
3	social@test.com	Anonymous-k6lx7yx2	\N	\N	\N	f	\N	2017-02-12 22:33:22	2017-02-12 22:33:22	\N
4	unverified@test.com	Anonymous-j0yrxy9z	\N	\N	$2y$10$/mHx.q3ts4TpMDhvQg.EY.4YsmHl.680/yclWjKyVWEC5SlaKZIfC	f	\N	2017-02-12 22:33:22	2017-02-12 22:33:22	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 4, true);


--
-- Data for Name: verifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY verifications (user_id, token, created_at) FROM stdin;
4	acd8637730ffbe5df1785a0a1dbf99cccbcc5ed413595a591e442d7074391d7d	2017-02-12 22:33:22
\.


--
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY videos (id, youtube_id, title, description, embeddable, privacy_status, published_at, created_at, updated_at) FROM stdin;
1	qrO4YZeyl0I	Lady Gaga - Bad Romance	LADY GAGA / JOANNE \nNEW ALBUM / OUT NOW\niTunes: http://smarturl.it/Joanne \nGoogle Play: http://smarturl.it/Joanne.gp \nAmazon: http://smarturl.it/Joanne.amz\nLadyGaga.com: http://smarturl.it/GagaStore\n\nFOLLOW LADY GAGA:\nhttp://www.facebook.com/ladygaga\nhttp://www.twitter.com/ladygaga\nhttp://www.instagram.com/ladygaga\nhttp://www.snapchat.com/add/ladygaga\nhttp://smarturl.it/LG.sp \n\nEMAIL LIST: \nhttp://smarturl.it/LadyGaga.News\n\nMusic video by Lady Gaga performing Bad Romance. (C) 2009 Interscope Records\n#VEVOCertified on January 31, 2010. http://www.vevo.com/certified http://www.youtube.com/vevocertified	t	public	2009-11-24 07:45:26	2017-02-12 22:33:22	2017-02-12 22:33:22
2	eQZEQQMWiVs	UH OH BIG BOY TAIL WHIPS AGAIN!	Finally a somewhat nice day has come in what has been a very cold February winter. Matty, BIG BOY and I went to a random skatepark by my cousins work for an awesome session. We rolled up there and it was a skatepark full of skateboarders, but they were absoultluy awesome and they had no issue with us getting a session in with them. Matty and BIG BOY did a lot on some ramps that they thought were going to be to small to ride Matty made BIG BOY learn how to do a bunch of new tricks like a whip over the bank to bank box. I called BIG BOY out on a bunch of tricks and as usual he gets completely broke off in some way and takes a crazy crash. I can't tell you how awesome it is to be back and going around to skatepark to skatepark with these boys. Thanks for watching, remember to subscribe and peace!	t	public	2017-02-11 21:03:37	2017-02-12 22:33:23	2017-02-12 22:33:23
3	uuIlvSNU67o	NEED ADVICE	A brief update on the backyard ramp before Spencer and I get some riding in. Got some cool announcements and some good footage in this one :)\nMERCH - http://LZBMX.COM\n\nSpencer's Channel - https://www.youtube.com/channel/UCQsNNWoGmf0tN2mi04c7hnA\n\nSong #1 by David Cutter\nhttps://www.davidcuttermusic.co.uk\nSong #2 by Ryan Little\nhttps://soundcloud.com/iamryanlittle	t	public	2017-02-11 16:42:16	2017-02-12 22:33:25	2017-02-12 22:33:25
4	UZPCp8SPfOM	Joe Rogan Experience #911 - Alex Jones & Eddie Bravo	Alex Jones is a radio show host, filmmaker, writer, and conspiracy theorist. Eddie Bravo is a jiujitsu black belt, music producer, and author.	t	public	2017-02-02 02:15:04	2017-02-12 22:33:25	2017-02-12 22:33:25
5	P8a4iiOnzsc	Radical Face 'Welcome Home'	http://www.radicalface.com\nhttp://youtube.com/radicalface\nhttp://facebook.com/radicalface\nhttp://twitter.com/radicalface\nhttps://www.instagram.com/radicalfaceofficial/\n\nWebstore: http://radicalface.shop.musictoday.com/store/\nPurchase/Steam: https://Nettwerk.lnk.to/radicalfaceYA\nApple Music: http://apple.co/1Vo1Vti\nTour: http://home.radicalface.com/shows\n\nDiscography\nThe Family Tree: The Leaves\nThe Bastards\nThe Family Tree: The Branches\nAlways Gold EP\nThe Family Tree: The Roots\nWelcome Home EP\nGhost\n\nDIRECTOR's web site:   http://www.justinmitchell.com	t	public	2009-06-02 22:32:19	2017-02-12 22:33:27	2017-02-12 22:33:27
6	QVQK_Yp0KuI	Reggie Watts - Spatial 2016 (Full New Comedy Special)	Reggie Watts - Spatial 2016 FULL Stand-Up Comedy Special \nSpatial, his new Netflix special, is signature Watts, meaning it’s alternately exhilarating, silly, exhausting, and transcendent. Coming onstage as a Darth Vader-esque cloaked figure, Watts sonorously tells his audience of a vast, confusing interstellar conflict before reassuring them, “The vestibule has been opened and all of us continue to exist as if nothing will occur.” He then loses his train of thought while trying to come up with the name of their mortal enemies.	t	public	2016-12-18 05:13:35	2017-02-12 22:33:28	2017-02-12 22:33:28
7	mulGqCjMzCs	Running in Front of Cars	Instagram @Cherdleys https://www.instagram.com/cherdleys/\nSnapchat  @Cherdleys\nTwitter      @Cherdleys https://twitter.com/cherdleys\n\nCreated by Chad LeBaron AKA Cherdleys AKA One Of Those Kids That Hurts Cats\n\nWatch last video: https://www.youtube.com/watch?v=1uDu-...\n\nFollow Saxon:\nInstagram @OldManSaxon - https://www.instagram.com/oldmansaxon/	t	public	2016-02-23 15:31:46	2017-02-12 22:33:29	2017-02-12 22:33:29
8	-X_aCfVhWYI	EP35 - ONE WEEK LEFT - Pacific Crest Trail 2016	October 1, 2016 - PCT trail miles 2507.5 to 2522.1\nFollow me on https://www.instagram.com/zachrotondo/\n\nEnd screen music - soundcloud.com/lakeyinspired	t	public	2016-12-16 17:21:56	2017-02-12 22:33:29	2017-02-12 22:33:29
9	Hu64xbgprWY	Universe - National Film Board of Canada (1960)	Universe is a black-and-white short documentary made in 1960 by the National Film Board of Canada. It dramatizes the nightly work of an astronomer at the David Dunlap Observatory in Richmond Hill, Ontario, a facility that is owned and operated by the University of Toronto, Canada. The film was a nominee at the 33rd Academy Awards in the category of Best Documentary Short Subject in 1961.	t	public	2013-06-18 15:03:22	2017-02-12 22:33:31	2017-02-12 22:33:31
10	7xTOj6VwaVc	The World's Worst Backpacker on the Pacific Crest Trail...	It's time for me to share the story of my first night on the Pacific Crest Trail. Don't try this at home! (... not that you could...)\nIf you've never hiked on the PCT, this video may be for you. You might also like it if you've had a trail chew you up and spit you out.\nThis video also serves as a preview to my new monologue, The World's Worst Backpacker - coming to Audible and iTunes this summer!\nFind out more at www.kenlasalle.com.	t	public	2016-05-16 23:16:20	2017-02-12 22:33:32	2017-02-12 22:33:32
11	UYG7FoneZZU	2016 Thru Hikers Part 4	https://www.gofundme.com/hikertrashvideo	t	public	2016-11-08 02:46:02	2017-02-12 22:33:32	2017-02-12 22:33:32
12	UNsIVfGptqM	Do You Need A College Degree For a System Administration Career?	It's one of the most popular questions I get: Is a college degree required for a System Administration Career?\n\n-Do I need a university degree for a tech career, in general?\n-How can I get my first Linux sysadmin job without a degree?\n\nIn this video I talk about the value of Degrees vs. the value of Education, and some career/learning strategies for people who don't have a college degree.\n\n3:18 - Education vs Experience\n4:09 - What to Study (High-Level overview in terms of University classes to emulate)\n6:10 - Theory vs. Practical Skill\n7:52 - How to Become a System Administrator (recommended learning path)\n10:02 - Practice + Theory work together to make you better\n\n\nBook Mentioned: Andrew Tanenbaum's Modern Operating Systems (4th ed) - http://amzn.to/2kcBc6a\n\nFull Linux Sysadmin Basics Playlist: https://www.youtube.com/playlist?list=PLtK75qxsQaMLZSo7KL-PmiRarU7hrpnwK\n\nCheck out my project-based Linux System Administration course (free sample videos): https://www.udemy.com/hands-on-linux-self-hosted-wordpress-for-linux-beginners/?couponCode=tl35\n\nOfficial Site: https://tutorialinux.com/\nTwitter: https://twitter.com/tutorialinux\nFacebook: https://www.facebook.com/tutorialinux\nPatreon: https://www.patreon.com/tutorialinux	t	public	2017-02-10 15:35:31	2017-02-12 22:33:33	2017-02-12 22:33:33
23	kE1mKj8awyY	My Top 10 Essential Documentaries	Previous Video ▶ http://bit.ly/2kkfZeI\n\nSubscribe For Daily Vids ▶ http://bit.ly/1KOilIP\nFollow My Snapchat ▶ http://snpcht.me/Mrhales100\nFollow My Twitter ▶ http://www.twitter.com/lahwf\nFollow My Instagram ▶ http://www.instagram.com/mrhales109\nLike the Facebook page ▶ http://www.facebook.com/lahwf\n\nSHIRTS ▶ http://shrsl.com/?e6xk\n\nSend Fan Mail to:\n5419 Hollywood Blvd, Ste. C825\nHollywood, CA 90027	t	public	2017-01-30 20:43:26	2017-02-12 22:33:41	2017-02-12 22:33:41
13	Gt_tUnf6T2E	The Truth About Dear White People: Racist Propaganda or Marketing Fail?	THURSDAY! These videos are my fave to make. Here goes nothing…\nWatch the Brand New Docuvlog!: https://youtu.be/SB3Se3dKBfo\nTheDeFrancoFam Vlog: https://youtu.be/_7K_Byz7Ah8\n————————————\nSTORIES:\n‘Dear White People’ Outrage:\nhttp://www.huffingtonpost.com/entry/netflix-boycott-dear-white-people_us_589cbb85e4b04061313c33eb\nhttp://www.revelist.com/tv/racists-boycott-netflix/6811\nhttp://www.telegraph.co.uk/tv/2017/02/09/dear-white-people-trailer-sparks-backlash-netflix-faces-claims/\nWatch The Movie: https://www.hulu.com/watch/850296\nhttps://www.amazon.com/White-People-Tyler-James-Williams/dp/B00OSQAP6G\n\nYouTube Sub Glitch:\nhttps://thenextweb.com/apps/2017/02/09/youtube-glitch-counter-channels/\nhttp://www.ibtimes.co.uk/youtube-finally-fixes-bug-causing-channels-lose-hundreds-subscribers-per-minute-1605713\n\nNBA 2K ELEAGUE:\nhttp://www.digitaltrends.com/gaming/nba-official-esports-league/\nhttp://www.espn.com/nba/story/_/id/18647863/nba-take-two-interactive-software-partnering-nba-2k-esports-league\nhttp://www.nba.com/article/2017/02/09/nba-video-game-company-launch-new-gaming-league-2018\n\nBaylor Sexual Assault Scandal:\nhttp://sportsday.dallasnews.com/college-sports/collegesports/2017/02/06/5-biggest-recent-revelations-baylors-sexual-assault-scandal\nhttp://www.tmz.com/2017/02/02/art-briles-alleged-text-messages/\nhttp://www.npr.org/2017/02/08/514172776/baylor-sanctioned-by-big-12-after-new-revelations-about-football-team-controvers\nhttp://www.dallasnews.com/news/baylor/2017/01/27/new-baylor-lawsuit-describes-show-em-good-time-culture-cites-52-rapes-football-players-4-years\nhttp://www.dallasnews.com/news/higher-education/2016/11/03/baylor-examining-sex-assault-claims-2011-2015\nhttp://www.foxnews.com/sports/2017/02/07/baylor-university-assistant-coach-fired-charged-with-soliciting-prostitute.html\n\n————————————\nFollow Me On Social:\nFACEBOOK: http://on.fb.me/mqpRW7\nTWITTER: http://Twitter.com/PhillyD\nINSTAGRAM: https://instagram.com/phillydefranco/\nSNAPCHAT: TheDeFrancoFam\nREDDIT: https://www.reddit.com/r/DeFranco\nITUNES: http://DeFrancoMistakes.com\nSOUNDCLOUD: http://letsmakemistakestogether.com\nGOOGLE PLAY: http://mistakeswithdefranco.com\n\nEdited by:\nJames Girardier - https://twitter.com/jamesgirardier\n\nProduced by:\nAmanda Morones - https://twitter.com/MandaOhDang\n\nMotion Graphics Artist\nBrian Borst - https://twitter.com/GrandpaHyde\n\nMailing Address:\nAttn: Philip DeFranco\n6433 Topanga Canyon Blvd #805\nCanoga Park, CA 91303	t	public	2017-02-09 22:30:03	2017-02-12 22:33:33	2017-02-12 22:33:33
14	KJC71dY13L8	I Need A Cat Dad	Happy Valentine's day!\nGHOST & STARS ▶ http://GhostAndStars\nHELP ME MAKE VIDEOS ▶ https://www.patreon.com/annaakana\n\nI need a cat dad - This super serious music video was created for Valentine's day so that whenever a potential cat dad (or mom!) pops up, you can send them this video with a "You, yes? ;)" and be as creepy as possible. \n\nbusiness\nAkanaActing@gmail.com\nTom Spriggs at The Coronel Group\n\nThanks Brad!\nhttp://youtube.com/BradGageComedy\n\nAudio mix by Jesse Cale\nhttps://www.youtube.com/user/TheOfficialMcSwagger\n\nshot and edited by Eric Lombart\nhttp://youtube.com/EricLombart\n\nmake up & hair by Melissa Tabares\nhttp://instagram.com/melissatabareshair\n\ngfx by Bethany Radloff\nhttp://youtube.com/BethBeRad	t	public	2017-02-09 21:06:12	2017-02-12 22:33:34	2017-02-12 22:33:34
15	qjYxXg4wZDg	My Epic Collab With Pewdiepie!!	I hope you enjoy my collab with Pewdiepie!\nHila is leaving me for this guy ► https://goo.gl/0yCVIX \n\nH3 Podcast is available at:\nITUNES ► https://goo.gl/desgTE\nGOOGLE PLAY MUSIC ►https://goo.gl/EnllKV\n\nTwitter......................►https://twitter.com/h3h3productions\nHila's Twitter............►https://twitter.com/hilakleinh3\nSpreadshirt..............►http://h3h3productions.spreadshirt.com\nInstagram................►http://instagram.com/h3h3productions\nHila's Instragram.....►https://www.instagram.com/kleinhila\nWebsite....................►http://h3h3productions.com\nSubreddit.................►http://reddit.com/r/h3h3productions\n\nTheme Song by MajorLeagueWobs:\nhttps://www.youtube.com/user/strangeholder	t	public	2017-02-08 20:03:44	2017-02-12 22:33:36	2017-02-12 22:33:36
16	hbXDLKFkjm0	Water on the Moon?	NEW CHANNEL! http://youtube.com/sciencium\n\nFor a long time we thought the Moon was completely dry, but it turns out there are actually three sources of lunar water.\nThanks to Google Making and Science for supporting the new channel! http://youtube.com/makingscience\n\nThanks to Patreon supporters:\nNathan Hansen, Donal Botkin, Tony Fadell, Zach Mueller, Ron Neal\n\nSupport Veritasium on Patreon: http://bit.ly/VePatreon\n\nReferences:\nGreat history of water on the moon: https://arxiv.org/pdf/1205.5597.pdf\n\nFilmed by Raquel Nuno\n\nMusic from http://epidemicsound.com "Serene Story 2"	t	public	2017-02-08 14:30:01	2017-02-12 22:33:36	2017-02-12 22:33:36
17	j26ax_NDeek	idubbbz visits tana mongeau	Thank you for viewing\n\nFor the full video visit: https://youtu.be/N8vaJaFCFYA\n__\n\nSUBSCRIBE ► https://www.youtube.com/channel/UC-tsNNJ3yIW98MtPH6PWFAQ?sub_confirmation=1\n\nMain Channel ► https://www.youtube.com/user/iDubbbzTV\nSecond Channel ► https://www.youtube.com/channel/UC-tsNNJ3yIW98MtPH6PWFAQ\nGaming Channel ► https://www.youtube.com/channel/UCVhfFXNY0z3-mbrTh1OYRXA\n\nWebsite ► http://www.idubbbz.com/\n\nInstagram ► https://instagram.com/idubbbz/\nTwitter ► https://twitter.com/Idubbbz\nFacebook ► http://www.facebook.com/IDubbbz\nTwitch ► http://www.twitch.tv/idubbbz\n_	t	public	2017-02-06 23:11:44	2017-02-12 22:33:37	2017-02-12 22:33:37
18	7jjTnvFAG0w	Weird Frat Guy Taking Shots	Wait for it...\n\n\nConnect with Cherdleys:\n► https://www.facebook.com/cherdleys\n► https://www.instagram.com/cherdleys\n\nSupport Cherdleys ► https://www.patreon.com/cherdleys\nMerchandise► https://www.cherdleys.com\nSecond Channel ► http://bit.ly/2i6SuRX	t	public	2017-02-06 20:13:17	2017-02-12 22:33:37	2017-02-12 22:33:37
19	uqWUfTsEEOE	MY GIRL IS LEAVING ME FOR THIS GUY	Connor Murphy will steal your girl in seconds\nMaking Music with Post Malone ► https://goo.gl/gnpe3H\n\nH3 Podcast is available at:\n\nITUNES ► https://goo.gl/desgTE\nGOOGLE PLAY MUSIC ►https://goo.gl/EnllKV\n\nTwitter......................►https://twitter.com/h3h3productions\nHila's Twitter............►https://twitter.com/hilakleinh3\nSpreadshirt..............►http://h3h3productions.spreadshirt.com\nInstagram................►http://instagram.com/h3h3productions\nHila's Instragram.....►https://www.instagram.com/kleinhila\nWebsite....................►http://h3h3productions.com\nSubreddit.................►http://reddit.com/r/h3h3productions\n\nSource video:\nhttps://www.youtube.com/channel/UCwNPPl_oX8oUtKVMLxL13jg\n\nMusic:\n\n"Sweet as Honey" by Topher Mohr and Alex Elena\n\nBig Car Theft by Audionautix is licensed under a Creative Commons Attribution license (https://creativecommons.org/licenses/by/4.0/)\nArtist: http://audionautix.com/	t	public	2017-02-04 23:06:33	2017-02-12 22:33:38	2017-02-12 22:33:38
20	IjpvhYpLVMo	Cutest Dog in the World | Mockumentary	Please Subscribe ▶ http://bit.ly/1FmhXhC \nExtras & Vlogs ▶ https://www.youtube.com/user/LAHWFextra\nFollow My Twitter ▶ http://www.twitter.com/lahwf\nFollow My Instagram ▶ http://www.instagram.com/mrhales109\nLike the Facebook page! ▶ http://www.facebook.com/lahwf\nCreep on my snaps! ▶ http://snpcht.me/Mrhales100\n\nBonnie's Instagram ▶ https://www.instagram.com/bonnie_babies/\n\nLuke's Channel ▶ https://www.youtube.com/user/fLUKEy1989\nAryia's Channel ▶ https://www.youtube.com/user/SimpleSexyStupid\n\nSong:\nGymnopedie No 1 by Kevin MacLeod is licensed under a Creative Commons Attribution license (https://creativecommons.org/licenses/by/4.0/)\nSource: http://incompetech.com/music/royalty-free/index.html?isrc=USUAN1100787\nArtist: http://incompetech.com/\n\nSend Fan Mail to:\n5419 Hollywood Blvd, Ste. C825\nHollywood, CA 90027	t	public	2017-02-04 02:47:20	2017-02-12 22:33:38	2017-02-12 22:33:38
21	wDc2aDH3zMM	Best Stuffed Mushrooms Recipe	This stuffed mushrooms recipe makes a great appetizer and party dish --and it's pretty easy to make a bunch of these stuffed mushrooms at one time. Stuffed mushrooms are often filled with freshly grated Parmesan, garlic, and herbs, but it's a super versatile recipe...so experiment with your favorite flavors; I personally like a blue cheese and hot sauce combo thrown into the filling, and chopped nuts and toasted breadcrumbs can add a much needed crunchiness.\nA printable copy of this stuffed mushrooms recipe and more tips on how to prepare it can be found at  \nhttp://www.myfoodchannel.com/stuffed-mushrooms-recipe/\nGive this stuffed mushroom recipe a try and let me know what you think, and for more recipes check out the Chef Buck playlist:  \nhttp://www.youtube.com/playlist?list=PL2EFBD7E8FE2BB552 \nand to print all recipes visit my website at http://www.myfoodchannel.com/\n\nConnect with this media to catch all of my videos...thanks:\nMY OTHER YOUTUBE CHANNEL:  http://www.youtube.com/user/buckredbuck\nFACEBOOK \nhttp://www.facebook.com/buckredbuck\nTWITTER \nhttps://twitter.com/buckredbuck\nINSTAGRAM\nhttps://www.instagram.com/buckredbuck/\nGOOGLE+  \nhttp://plus.google.com/u/0/109193261972985167770/posts\nPRINT RECIPES AT MY WEBSITE:  \nhttp://www.myfoodchannel.com/\nRECIPE PLAYLISTS:  http://www.youtube.com/user/FromUnderTheRock\n\nWhat You Need for This Stuffed Mushrooms Recipe \n \n12-15 MUSHROOMS\n½ cup PANKO BREADCRUMBs\n1 TBSP BUTTER\nsome OLIVE OIL\nfilling mixture like...\n½ cup PARMESAN CHEESE\n½ cup BLUE CHEESE\n4-6 cloves GARLIC (finely chopped)\n½ cup PARSLEY (chopped)\n½ cup CASHEWS (chopped)\nsome HOT SAUCE\nSALT and PEPPER (to taste)\n...but fillings are optional\n\nHow To Make Stuffed Mushrooms\n\nBuy whole mushrooms that are uniform in size; I buy mushrooms that are not already pre-packaged, so I can select the best.\nChoose mushrooms that are firm and dry and store in the fridge in a paper sack until you are ready to use them.\nBefore using, clean mushrooms with a damp towel. \nremove the stems and use a knife or spoon to open the mushroom center and create more room for the stuffing.\nTake your time preparing the mushroom caps to avoid splitting them. \nI often set aside some of the stems to use in other recipes, while reserving some to chop and mix with the stuffing.\nCoat the mushroom caps lightly with olive oil and set aside.\nIn a bowl, combine some of the chopped stems and whatever fillings you desire.\nI often use an egg, minced garlic, freshly grated parmesan, and fresh chopped parsley with my filling, but\nthe variations are endless.\nBlue cheese is fantastic in stuffed mushrooms.\nFor added crunchiness, nuts are a great idea. I find that chopped cashews work very well.\nI'll often add ingredients to the stuffing mix as I stuff the mushrooms, which makes for a nice variety of flavors.\nSpoon the filling into the mushroom cap.\nIn a skillet, melt butter and add panko breadcrumbs. The breadcrumbs will soak up the butter and flavor.\nTop stuffed mushrooms with panko breadcrumbs and place on a rack over a baking sheet.\nPlace stuffed mushrooms in an oven pre-heated to 375 degrees F. and bake for approximately 30 minutes or until\nthe breadcrumb topping is nicely toasted.\nServe warm.\n\nGive this stuffed mushrooms recipe a try, and let me know what you think, and bon appétit!	t	public	2017-02-03 15:32:26	2017-02-12 22:33:40	2017-02-12 22:33:40
22	RVMZxH1TIIQ	Why Earth Is A Prison and How To Escape It	We are trapped on earth. Controlled by an ancient debt to the universe...\n\nLearn more about Ariane 6: http://www.airbusafran-launchers.com/en/universe/ariane-6-en/\n\nSupport us on Patreon so we can make more videos (and get cool stuff in return): https://www.patreon.com/Kurzgesagt?ty=h\n\nKurzgesagt merch here:  http://bit.ly/1P1hQIH\n\nGet the music of the video here: \n\nSoundcloud: http://bit.ly/2kqsiGb\nBandcamp: http://bit.ly/2kryP3c\nFacebook: https://www.facebook.com/epic-mountain-music\n \nTHANKS A LOT TO OUR LOVELY PATRONS FOR SUPPORTING US:\n\nJohn Wendeborn, Haan, Doktor Andy, Josh Gabbatiss, Peter Egger, Rick Lawrence, Eric Gao, 주영정, Jeff Threatt, Lars v., BurmansHealthShop, Ian White, Coty Rosenblath, SoraHavok, Andrew Berscheid, Jakub Zych, Eddie Han, Bubble Our Travel, Anton Ukhanev, Jan Pac, Mike, Martin Harding, Louis, Thomas G. Digranes, Todd, Mishal Alsuwyan, Liam Swann, Timothee Groleau, John Cido, Nicholas Bethencourt, Jeremy B Costella, Matthew Clarkson, Anna Chiara Brunetti, ValCab33, Neno Ganchev, Matt Saville, Klaas Pieter Annema, Peter Spalthoff, Andrew Campbell, Mads Bertheussen, Josué Barbosa dos Santos, Corey Hinds, Julian Fiander, BillDoor, Garrett Blackmon, Leeann Toland, Marshall Dow, Horia Constantin, Austin Hooper, Thomas E. Lee, Sylvain Milan, Jake Lee Kennedy, teddy zhang, Albinomaur, Casey Schad, Pearce Bergh, Dan Werdnly, Richard Patenaude, Moch Faisal Rasid, Antoine Dymond, James Hyde, Jonathan Verlohren, H.L.Hammons, Mikael Hannikainen, Kevin Douglass, Erik Onnen, Thiago Torres, Bryan Benninghoff, Frank Tuffner, Kevan Rynning, Aschwin Berkhout, Daniel Neilson, Damon Weil, Wesley Byrd, Bryan Andrade, Sergei Gaponov, Torodes, Ori Haski, Adam, Pavel Ševčík, Will Schmid, Alan Tran, Raoul Verhaegen, Fabercastel, Max, Youlia Hadzhidimova, Tristan Waddington, Bror Ronning, Santiago Campellone, Harjeet Taggar, James Horrocks, Brandon Bizzarro, Michel Vaillancourt, RHall, Brian David Henderson, Vikas Dhiman, Jack, Tomáš Miškov, Derral Gerken, Anthony, Vadim Golub, Fervidus, Justin Ritchie, Nicolas Dolgin, Harry, Andrew Miner, Rohan Dowd, Jesse Versluys, Juraj Trizna, André Léger, Peter Reynolds, Tom Handcock, Shaquille D. Johnson, HUISHI ZHANG, Robert S Peschel, Chris Bowley, Thomasz Kolosowski, Hogtree Octovish, Donovan Shickley, Bruce Hill, William Johnson, Ángel Garcia Casado, Riikka S, Daniel Moul, Daniel John, Anirudh Joshi, Robert, Iman, Jannis Kaiser, Andrew Bennett, Mariann Nagy, Daniel Kömpf, Philip Zapfel, Vince Gabor\n\nHelp us caption & translate this video!\n\nhttp://www.youtube.com/timedtext_cs_panel?c=UCsXVk37bltHxD1rDPwtNM8Q&tab=2\n\nOverpopulation – The Human Explosion Explained	t	public	2017-02-01 13:22:31	2017-02-12 22:33:41	2017-02-12 22:33:41
24	Q8ccXzM3x8A	The Case for String Theory - Sixty Symbols	Dr Tony Padilla  on why he thinks there's a compelling case for String Theory... This is one of our occasional longer-form interviews.\nLonger interviews with Ed Copeland: http://bit.ly/CopelandGoesLong\nOur visit to CERN: http://bit.ly/LHCvideos\nObjectivity: http://bit.ly/Objectivity\n\nDr Padilla is a cosmologist at the University of Nottingham - https://www.nottingham.ac.uk/physics/people/antonio.padilla\n\nVisit our website at http://www.sixtysymbols.com/\nWe're on Facebook at http://www.facebook.com/sixtysymbols\nAnd Twitter at http://twitter.com/sixtysymbols\nThis project features scientists from The University of Nottingham\nhttp://bit.ly/NottsPhysics\n\nPatreon: https://www.patreon.com/sixtysymbols\n\nSixty Symbols videos by Brady Haran\nhttp://www.bradyharanblog.com\n\nEmail list: http://eepurl.com/YdjL9\n\nExtra videos and images via CERN and ESO.\nMusic via Harri at freesound.org	t	public	2017-01-30 14:30:33	2017-02-12 22:33:42	2017-02-12 22:33:42
25	keYYiuOJdrE	The Master: How Scientology Works	Get a free 30 day trial of Audible here: http://www.audible.com/nerdwriter\n\nI WAS NOMINATED FOR A SHORTY! VOTE FOR ME HERE: http://shortyawards.com/9th/theenerdwriter\nNERDWRITER T-SHIRTS: https://store.dftba.com/products/the-nerdwriter-shirt\n\n\nSOURCES AND FURTHER READING:\n\nhttps://luckyottershaven.com/2017/01/15/why-scientology-auditing-is-not-at-all-like-traditional-psychotherapy-part-2/\n\nhttps://luckyottershaven.com/2017/01/14/why-scientology-auditing-is-not-at-all-like-traditional-psychotherapy-part-1/\n\nhttps://www.youtube.com/watch?v=dbmPVq6e2aA\n\nhttps://www.ncbi.nlm.nih.gov/pmc/articles/PMC3856510/	t	public	2017-01-26 15:01:31	2017-02-12 22:33:43	2017-02-12 22:33:43
26	9-5TSxd0ep0	Arcade Fire - Rebellion (Lies): Live at Earls Court	Arcade Fire : The Reflektor Tapes / Live At Earls Court released on DVD & BluRay on 27 January 2017. \n\nDVD - http://smarturl.it/REFLEKTORTAPESDVD\nBlu Ray - http://smarturl.it/REFLEKTORTAPESBR\n\nMusic video by Arcade Fire performing Rebellion (Lies). (C) 2016 Arcade Fire Music, LLC, exclusively licensed to Eagle Rock Entertainment Ltd.\n\nhttp://vevo.ly/ZPzbTY	t	public	2017-01-26 11:00:02	2017-02-12 22:33:44	2017-02-12 22:33:44
\.


--
-- Name: videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('videos_id_seq', 26, true);


--
-- Data for Name: videos_topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY videos_topics (id, topic_id, video_id, type) FROM stdin;
1	1	1	topicId
2	2	1	topicId
3	3	1	topicId
4	4	1	relevantTopicId
5	5	1	relevantTopicId
6	6	1	relevantTopicId
7	7	1	relevantTopicId
8	8	2	topicId
9	9	2	topicId
10	8	2	relevantTopicId
11	9	2	relevantTopicId
12	10	2	relevantTopicId
13	11	2	relevantTopicId
14	12	2	relevantTopicId
15	13	2	relevantTopicId
16	14	2	relevantTopicId
17	15	2	relevantTopicId
18	16	2	relevantTopicId
19	17	2	relevantTopicId
20	18	2	relevantTopicId
21	8	3	topicId
22	8	3	relevantTopicId
23	9	3	relevantTopicId
24	12	3	relevantTopicId
25	14	3	relevantTopicId
26	17	3	relevantTopicId
27	19	3	relevantTopicId
28	20	3	relevantTopicId
29	21	3	relevantTopicId
30	22	4	topicId
31	23	4	relevantTopicId
32	24	4	relevantTopicId
33	25	4	relevantTopicId
34	26	5	topicId
35	27	5	topicId
36	28	5	topicId
37	5	5	relevantTopicId
38	6	5	relevantTopicId
39	29	5	relevantTopicId
40	30	6	topicId
41	4	6	relevantTopicId
42	6	6	relevantTopicId
43	25	6	relevantTopicId
44	31	6	relevantTopicId
45	32	6	relevantTopicId
46	33	6	relevantTopicId
47	34	6	relevantTopicId
48	35	6	relevantTopicId
49	36	6	relevantTopicId
50	21	7	relevantTopicId
51	25	7	relevantTopicId
52	37	7	relevantTopicId
53	38	7	relevantTopicId
54	39	7	relevantTopicId
55	40	7	relevantTopicId
56	41	8	topicId
57	15	8	relevantTopicId
58	42	8	relevantTopicId
59	43	8	relevantTopicId
60	44	8	relevantTopicId
61	45	8	relevantTopicId
62	46	8	relevantTopicId
63	47	8	relevantTopicId
64	48	8	relevantTopicId
65	49	8	relevantTopicId
66	50	8	relevantTopicId
67	51	8	relevantTopicId
68	52	8	relevantTopicId
69	53	8	relevantTopicId
70	54	8	relevantTopicId
71	55	9	topicId
72	56	9	topicId
73	6	9	relevantTopicId
74	57	9	relevantTopicId
75	58	9	relevantTopicId
76	59	9	relevantTopicId
77	60	9	relevantTopicId
78	61	9	relevantTopicId
79	41	10	topicId
80	44	10	relevantTopicId
81	48	10	relevantTopicId
82	52	10	relevantTopicId
83	53	10	relevantTopicId
84	44	11	topicId
85	51	11	topicId
86	62	11	topicId
87	19	11	relevantTopicId
88	44	11	relevantTopicId
89	45	11	relevantTopicId
90	52	11	relevantTopicId
91	53	11	relevantTopicId
92	63	11	relevantTopicId
93	64	12	relevantTopicId
94	65	12	relevantTopicId
95	66	12	relevantTopicId
96	67	12	relevantTopicId
97	68	13	topicId
98	19	13	relevantTopicId
99	69	13	relevantTopicId
100	70	13	relevantTopicId
101	71	14	topicId
102	4	14	relevantTopicId
103	5	14	relevantTopicId
104	6	14	relevantTopicId
105	72	14	relevantTopicId
106	73	14	relevantTopicId
107	74	14	relevantTopicId
108	75	15	topicId
109	25	15	relevantTopicId
110	76	16	topicId
111	77	16	relevantTopicId
112	78	16	relevantTopicId
113	79	16	relevantTopicId
114	80	16	relevantTopicId
115	6	17	relevantTopicId
116	19	17	relevantTopicId
117	19	18	relevantTopicId
118	52	18	relevantTopicId
119	81	18	relevantTopicId
120	19	19	relevantTopicId
121	52	19	relevantTopicId
122	81	19	relevantTopicId
123	82	20	topicId
124	25	20	relevantTopicId
125	40	20	relevantTopicId
126	72	20	relevantTopicId
127	82	20	relevantTopicId
128	83	20	relevantTopicId
129	84	20	relevantTopicId
130	85	20	relevantTopicId
131	86	20	relevantTopicId
132	87	20	relevantTopicId
133	88	20	relevantTopicId
134	89	21	topicId
135	90	21	topicId
136	52	21	relevantTopicId
137	90	21	relevantTopicId
138	91	21	relevantTopicId
139	92	21	relevantTopicId
140	93	21	relevantTopicId
141	94	21	relevantTopicId
142	95	21	relevantTopicId
143	96	21	relevantTopicId
144	97	22	relevantTopicId
145	98	22	relevantTopicId
146	61	23	topicId
147	59	23	relevantTopicId
148	61	23	relevantTopicId
149	99	24	topicId
150	6	24	relevantTopicId
151	100	24	relevantTopicId
152	101	24	relevantTopicId
153	102	25	topicId
154	59	25	relevantTopicId
155	103	25	relevantTopicId
156	104	25	relevantTopicId
157	105	26	topicId
158	106	26	topicId
159	4	26	relevantTopicId
160	6	26	relevantTopicId
161	34	26	relevantTopicId
162	35	26	relevantTopicId
163	107	26	relevantTopicId
164	108	26	relevantTopicId
165	109	26	relevantTopicId
166	110	26	relevantTopicId
167	111	26	relevantTopicId
168	112	26	relevantTopicId
\.


--
-- Name: videos_topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('videos_topics_id_seq', 168, true);


--
-- Name: migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: tagged_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tagged
    ADD CONSTRAINT tagged_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: topics_google_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_google_id_unique UNIQUE (google_id);


--
-- Name: topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- Name: videos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: videos_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY videos_topics
    ADD CONSTRAINT videos_topics_pkey PRIMARY KEY (id);


--
-- Name: videos_youtube_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY videos
    ADD CONSTRAINT videos_youtube_id_unique UNIQUE (youtube_id);


--
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX password_resets_email_index ON password_resets USING btree (email);


--
-- Name: password_resets_token_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX password_resets_token_index ON password_resets USING btree (token);


--
-- Name: tagged_taggable_type_taggable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tagged_taggable_type_taggable_id_index ON tagged USING btree (taggable_type, taggable_id);


--
-- Name: verifications_token_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX verifications_token_index ON verifications USING btree (token);


--
-- Name: verifications_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX verifications_user_id_index ON verifications USING btree (user_id);


--
-- Name: videos_topics_topic_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX videos_topics_topic_id_index ON videos_topics USING btree (topic_id);


--
-- Name: videos_topics_video_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX videos_topics_video_id_index ON videos_topics USING btree (video_id);


--
-- Name: submissions_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY submissions
    ADD CONSTRAINT submissions_user_id_foreign FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: submissions_video_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY submissions
    ADD CONSTRAINT submissions_video_id_foreign FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE;


--
-- Name: verifications_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY verifications
    ADD CONSTRAINT verifications_user_id_foreign FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: videos_topics_topic_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY videos_topics
    ADD CONSTRAINT videos_topics_topic_id_foreign FOREIGN KEY (topic_id) REFERENCES topics(id) ON DELETE CASCADE;


--
-- Name: videos_topics_video_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY videos_topics
    ADD CONSTRAINT videos_topics_video_id_foreign FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

