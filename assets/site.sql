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
390	2014_10_12_000000_create_users_table	1
391	2014_10_12_100000_create_password_resets_table	1
392	2014_10_29_202547_migration_cartalyst_tags_create_tables	1
393	2017_01_18_221958_create_verifications_table	1
394	2017_01_26_235059_create_videos_table	1
395	2017_01_31_224924_create_submissions_table	1
396	2017_02_01_214835_create_topics_tables	1
\.


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('migrations_id_seq', 396, true);


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY password_resets (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY submissions (id, video_id, user_id, title, slug, description, created_at, updated_at) FROM stdin;
1	1	2	Et deserunt ratione temporibus ea numquam aspernatur neque qui.	et-deserunt-ratione-temporibus-ea-numquam-aspernatur-neque-qui	Harum pariatur quam eum beatae ipsa. Sunt reprehenderit quia et et dolor quibusdam quod. Nesciunt minima qui ut perferendis consectetur eius.\n\nAperiam et totam ut accusamus quia ullam. Illo eaque vel molestiae sapiente cum at atque. Quo rem molestiae velit quia nulla esse.	2017-02-12 00:43:47	2017-02-12 00:43:47
2	2	1	Quia nesciunt nihil nisi.	quia-nesciunt-nihil-nisi	Dolores sit voluptatem voluptas et est eaque odit. Numquam quae iusto fuga. Expedita omnis doloribus modi pariatur optio iste. Et atque fugit facere reprehenderit. Repudiandae reiciendis assumenda quas optio alias beatae numquam.\n\nDolores eos itaque doloribus reprehenderit eaque voluptatem. Unde et et quia ipsa eveniet. Nihil eius nesciunt ad omnis quia veritatis.	2017-02-12 00:43:47	2017-02-12 00:43:47
3	3	2	Vitae pariatur rerum voluptates rerum quas illum.	vitae-pariatur-rerum-voluptates-rerum-quas-illum	Autem tempore nisi sit corporis sint blanditiis asperiores. Dolor doloremque est doloremque. Assumenda sit earum earum est omnis dicta. Reiciendis et reprehenderit omnis id.\n\nQuis rerum dolores saepe expedita accusamus quis molestias. Et dicta qui quis exercitationem. Consequatur reprehenderit quibusdam assumenda dolores asperiores illum. Voluptas maiores voluptates non minima voluptate.	2017-02-12 00:43:47	2017-02-12 00:43:47
4	4	1	Quo magni modi ipsum eaque a ut qui.	quo-magni-modi-ipsum-eaque-a-ut-qui	Earum error aut voluptas. Voluptates ipsa dignissimos officiis ipsam. Exercitationem ea doloremque ducimus omnis accusantium dolores quia consequatur.\n\nDoloremque officiis accusamus aut aut suscipit debitis quaerat. Consequatur dicta et beatae voluptatem. Nobis sed ut tempore nihil qui eaque.	2017-02-12 00:43:47	2017-02-12 00:43:47
5	5	2	Quasi perspiciatis qui quibusdam et blanditiis.	quasi-perspiciatis-qui-quibusdam-et-blanditiis	Ullam dolore enim optio sed et et. Facilis sapiente unde repudiandae. Adipisci nemo velit quia qui qui qui quia. Nisi ut consequatur nisi ea libero corporis quidem amet.\n\nEarum modi asperiores sit occaecati suscipit. Sed quo ut voluptatem et distinctio et eaque. Est nesciunt enim libero sint.	2017-02-12 00:43:47	2017-02-12 00:43:47
6	6	1	Ex quis dolorem culpa quia suscipit.	ex-quis-dolorem-culpa-quia-suscipit	Ea nam consequatur quae labore consequatur nulla laudantium consequatur. Sed cumque aliquam repudiandae minima quia. Quia voluptas aut eveniet ea aut et. Quam voluptatem alias aliquid fuga.\n\nConsequuntur quibusdam dolorum sed commodi laboriosam. Aut repellendus sunt vitae dolor. Explicabo ex ex consequuntur nesciunt voluptas dolorum. Quia deserunt dolores vero adipisci itaque.	2017-02-12 00:43:47	2017-02-12 00:43:47
7	7	2	Velit et corrupti quia dolorem ut rerum dolorum.	velit-et-corrupti-quia-dolorem-ut-rerum-dolorum	Quia a aut aliquam natus sit vitae harum. Placeat nihil laudantium est. Qui laboriosam et amet cumque.\n\nQuis et possimus impedit praesentium minima qui. Inventore reiciendis nam cupiditate facere totam.	2017-02-12 00:43:47	2017-02-12 00:43:47
8	8	1	Et sint sed aliquid perferendis deleniti dolor.	et-sint-sed-aliquid-perferendis-deleniti-dolor	Facere est velit blanditiis debitis. Quo ea sit laudantium quo ut sint. Inventore est delectus debitis error repellat.\n\nFuga culpa eum quaerat nam. Enim deserunt quae ullam debitis in sed id. Autem repellat omnis ut et. Perferendis inventore natus repellendus ipsam.	2017-02-12 00:43:47	2017-02-12 00:43:47
9	9	2	Repellat voluptas maxime ab rerum.	repellat-voluptas-maxime-ab-rerum	Vel sit enim assumenda facere doloremque fugiat quod. Ut assumenda dolores quo minus doloremque et nobis.\n\nQuia eaque at repudiandae consequatur. Aut in nihil facilis ipsa. Quisquam et hic nobis quis ducimus ut explicabo. Dolor explicabo veritatis doloremque cumque ab.	2017-02-12 00:43:47	2017-02-12 00:43:47
10	10	1	Et nihil repellendus deserunt et.	et-nihil-repellendus-deserunt-et	Aperiam incidunt id dignissimos dignissimos ipsa hic. Officiis quo debitis repellat repellendus. Natus deleniti quas facere velit culpa. Nihil voluptatem velit iste a exercitationem eius velit. Nostrum commodi aut at nostrum voluptas suscipit rem consectetur.\n\nConsequatur quibusdam eum voluptatem dolorem ut odio itaque. Reiciendis vel excepturi temporibus omnis. Delectus eum et et doloremque. Reprehenderit non aperiam quam id blanditiis.	2017-02-12 00:43:47	2017-02-12 00:43:47
11	11	2	Aut distinctio accusantium cupiditate dolores enim.	aut-distinctio-accusantium-cupiditate-dolores-enim	Accusamus alias est est voluptatem temporibus. Velit dignissimos aut dolor dolorem voluptatem nihil. Eum voluptate quia accusantium in voluptatem debitis est adipisci.\n\nUt eveniet molestiae est explicabo et. Qui impedit quas quia enim. Impedit esse quaerat reiciendis dignissimos non.	2017-02-12 00:43:47	2017-02-12 00:43:47
12	12	1	Velit quis sunt ea quis adipisci.	velit-quis-sunt-ea-quis-adipisci	Omnis iure voluptas unde perspiciatis ab autem. Repellendus placeat voluptatibus voluptas aut pariatur aut laboriosam sunt. Earum quo in sed deleniti est. Est exercitationem quasi exercitationem tenetur maxime.\n\nNobis non quam officiis nobis harum nisi eaque. Et eveniet iste dolores et aut ipsam magnam. Maxime doloribus velit inventore modi impedit labore in. Sit blanditiis nostrum non vel ut consequatur.	2017-02-12 00:43:47	2017-02-12 00:43:47
13	23	2	Repellendus nihil vero amet asperiores.	repellendus-nihil-vero-amet-asperiores	Et omnis consequatur autem ut vero voluptate aut. Sapiente iure nihil et blanditiis dicta. Adipisci et molestiae sit et ut animi.\n\nAut deserunt dolor maiores. Quod pariatur distinctio ut a eum officia. Aperiam atque quia et voluptatem.	2017-02-12 00:43:47	2017-02-12 00:43:47
14	13	1	Modi debitis iusto incidunt iusto magnam suscipit quis.	modi-debitis-iusto-incidunt-iusto-magnam-suscipit-quis	Eum quos et vel aut. Voluptatum atque et et non adipisci eum. Inventore rerum voluptas aliquam nobis officiis a.\n\nPorro aut occaecati nam autem molestiae reprehenderit aut. Commodi facere nemo eos dolorem natus exercitationem. Exercitationem possimus repellat eius laboriosam nobis officiis ut. Hic deleniti rerum fuga voluptatem aliquid assumenda odio.	2017-02-12 00:43:47	2017-02-12 00:43:47
15	14	2	Occaecati dignissimos officia id laborum quidem.	occaecati-dignissimos-officia-id-laborum-quidem	Ea voluptas velit quae quasi nihil autem. Non excepturi eaque odio et est qui. Velit reprehenderit officia sapiente dicta in. Magnam ut quas cum eos cumque minima quia.\n\nEos harum quia nam qui sit sed ullam. Quisquam magnam quisquam facilis amet autem et consequuntur. Et quam aspernatur accusamus et iure. Repellat eius molestias labore ea est.	2017-02-12 00:43:47	2017-02-12 00:43:47
16	15	1	Occaecati autem debitis inventore soluta non.	occaecati-autem-debitis-inventore-soluta-non	Fugit aut pariatur accusamus quis aut provident. Consectetur nostrum quisquam et recusandae minima. Sunt voluptates consectetur magnam.\n\nError ipsum occaecati ut recusandae accusamus eius esse. Dolorem debitis eum eos fugit. Facilis fuga assumenda ullam voluptas consequuntur. Vero pariatur porro nemo nihil eligendi voluptatem.	2017-02-12 00:43:47	2017-02-12 00:43:47
17	16	2	Rerum laborum aut amet aut odit.	rerum-laborum-aut-amet-aut-odit	In sit ducimus earum assumenda rerum adipisci laborum. Blanditiis dolores commodi dolore ut libero perspiciatis cum velit. Aspernatur at qui qui ea veritatis qui.\n\nFacilis labore error fugiat ut. Iste eos sed et atque. Vitae in sed voluptatem. Quam ullam nihil voluptas qui. Expedita dolor facere fuga veritatis sunt repellendus quia autem.	2017-02-12 00:43:47	2017-02-12 00:43:47
18	17	1	Quia sed distinctio natus temporibus ipsum aut rerum.	quia-sed-distinctio-natus-temporibus-ipsum-aut-rerum	At adipisci fuga in voluptatem quo aliquam. Distinctio modi voluptatibus consequatur. Praesentium dicta voluptas modi cupiditate odit rerum. Dicta aliquam at repellat. Est repellat odio aut quo corporis.\n\nAutem voluptas necessitatibus perspiciatis corrupti et ea laboriosam doloribus. Et voluptatum dicta nam quia qui ea. Cumque voluptates mollitia dicta iusto a quas enim suscipit.	2017-02-12 00:43:47	2017-02-12 00:43:47
19	18	2	Porro ex omnis qui.	porro-ex-omnis-qui	Consequatur quis ab cumque ut sed non sit. Non perspiciatis quidem aut dolor sunt voluptate earum deserunt. Ducimus voluptatem necessitatibus eius quas. Sapiente repudiandae quis illo cupiditate eveniet ducimus.\n\nQuia pariatur possimus totam. Id ut iste cumque velit. Vel nesciunt ipsum quas aliquam aliquid aut eligendi.	2017-02-12 00:43:47	2017-02-12 00:43:47
20	19	1	Excepturi cupiditate corrupti omnis delectus illo.	excepturi-cupiditate-corrupti-omnis-delectus-illo	Aut laudantium autem magni et itaque. Consequatur vel dicta aliquam corrupti. Ex aspernatur corrupti delectus tenetur facilis laboriosam voluptas.\n\nConsequuntur aut et nesciunt earum. Molestias ut perferendis ut nemo exercitationem exercitationem odio maiores. Et facere explicabo ducimus non expedita quasi. Nihil sed eius ea suscipit.	2017-02-12 00:43:47	2017-02-12 00:43:47
21	20	2	Incidunt molestiae necessitatibus et est porro natus aperiam.	incidunt-molestiae-necessitatibus-et-est-porro-natus-aperiam	Rerum fugiat non accusantium quasi voluptatem quo error. Perspiciatis quam ipsa sed quaerat. Qui fugit tempora itaque ab quo omnis doloribus soluta.\n\nEarum facilis incidunt magni ut illo. Nesciunt iste consequatur qui qui voluptatem eligendi porro. Harum rerum consequatur ut excepturi. Blanditiis sit sapiente quam illum dolor et.	2017-02-12 00:43:47	2017-02-12 00:43:47
22	21	1	Quis ullam provident numquam qui error occaecati.	quis-ullam-provident-numquam-qui-error-occaecati	Qui voluptas eligendi provident minus quidem cum commodi. Voluptatibus explicabo modi sed distinctio exercitationem sint ipsam. Quia accusantium eaque reiciendis voluptatem laboriosam.\n\nDolores minima magni molestiae nemo. Quaerat sunt modi sapiente ut deleniti dolorum repellendus. Iste soluta non ab omnis aut. Voluptatibus quibusdam dolor qui ullam fuga nulla dignissimos.	2017-02-12 00:43:47	2017-02-12 00:43:47
23	22	2	Magnam minus et qui et.	magnam-minus-et-qui-et	Deserunt illo enim provident ut. Ut aperiam aperiam omnis veniam sint at perspiciatis sunt. Consequatur aut vitae omnis numquam. Unde placeat excepturi fuga quam.\n\nExpedita ut nesciunt vitae facere earum atque. Aperiam iusto eos accusantium sed eligendi ut sed minima. Minus nostrum nihil temporibus dolore.	2017-02-12 00:43:48	2017-02-12 00:43:48
24	24	1	Autem eos accusantium et sed et dolorem.	autem-eos-accusantium-et-sed-et-dolorem	Autem voluptatibus aliquid molestias ut sit. Ut vitae vero perferendis rerum omnis in a quod. Id aspernatur est repudiandae id ducimus nulla.\n\nUt minima omnis nesciunt necessitatibus dolores soluta. Voluptate eveniet nam animi omnis aliquid iure officia praesentium. Et alias voluptatem rerum sed dicta neque.	2017-02-12 00:43:48	2017-02-12 00:43:48
25	25	2	Temporibus sed excepturi rerum totam et et.	temporibus-sed-excepturi-rerum-totam-et-et	Reprehenderit adipisci velit soluta omnis corporis unde. Qui pariatur porro rerum voluptas a esse. Porro consectetur et cupiditate eos aut cumque eos in.\n\nEsse minima fuga excepturi nesciunt eum et iusto. Itaque ullam ullam necessitatibus facilis rerum ducimus. Facilis laudantium doloribus repellat quia officia aut architecto.	2017-02-12 00:43:48	2017-02-12 00:43:48
26	26	1	Corrupti in temporibus inventore neque aut.	corrupti-in-temporibus-inventore-neque-aut	Error error et et et. Soluta possimus voluptatem accusamus dolor ipsam necessitatibus neque. Enim corporis expedita rem vero. Non quo voluptas sunt.\n\nIste necessitatibus quod voluptate non. Qui possimus quod vel necessitatibus. Sed delectus consectetur maiores aperiam.	2017-02-12 00:43:48	2017-02-12 00:43:48
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
419	App\\Models\\Submission	2	388
420	App\\Models\\Submission	2	389
421	App\\Models\\Submission	2	390
422	App\\Models\\Submission	2	391
423	App\\Models\\Submission	2	392
424	App\\Models\\Submission	3	393
425	App\\Models\\Submission	3	394
426	App\\Models\\Submission	3	395
427	App\\Models\\Submission	3	396
428	App\\Models\\Submission	3	397
429	App\\Models\\Submission	3	398
430	App\\Models\\Submission	3	390
431	App\\Models\\Submission	4	388
432	App\\Models\\Submission	4	399
433	App\\Models\\Submission	4	400
434	App\\Models\\Submission	5	401
435	App\\Models\\Submission	5	402
436	App\\Models\\Submission	5	403
437	App\\Models\\Submission	5	404
438	App\\Models\\Submission	5	393
439	App\\Models\\Submission	5	405
440	App\\Models\\Submission	5	406
441	App\\Models\\Submission	6	407
442	App\\Models\\Submission	6	408
443	App\\Models\\Submission	6	409
444	App\\Models\\Submission	6	410
445	App\\Models\\Submission	6	411
446	App\\Models\\Submission	6	412
447	App\\Models\\Submission	6	390
448	App\\Models\\Submission	7	389
449	App\\Models\\Submission	7	413
450	App\\Models\\Submission	7	414
451	App\\Models\\Submission	8	415
452	App\\Models\\Submission	8	416
453	App\\Models\\Submission	8	417
454	App\\Models\\Submission	8	418
455	App\\Models\\Submission	9	419
456	App\\Models\\Submission	9	420
457	App\\Models\\Submission	9	421
458	App\\Models\\Submission	9	422
459	App\\Models\\Submission	9	423
460	App\\Models\\Submission	9	418
461	App\\Models\\Submission	10	424
462	App\\Models\\Submission	10	425
463	App\\Models\\Submission	10	426
464	App\\Models\\Submission	10	427
465	App\\Models\\Submission	10	415
466	App\\Models\\Submission	10	420
467	App\\Models\\Submission	11	412
468	App\\Models\\Submission	11	428
469	App\\Models\\Submission	11	416
470	App\\Models\\Submission	11	420
471	App\\Models\\Submission	11	429
472	App\\Models\\Submission	11	430
473	App\\Models\\Submission	12	393
474	App\\Models\\Submission	12	385
475	App\\Models\\Submission	12	431
476	App\\Models\\Submission	12	425
477	App\\Models\\Submission	12	432
478	App\\Models\\Submission	12	402
479	App\\Models\\Submission	13	433
480	App\\Models\\Submission	13	434
481	App\\Models\\Submission	13	421
482	App\\Models\\Submission	14	385
483	App\\Models\\Submission	14	435
484	App\\Models\\Submission	14	436
485	App\\Models\\Submission	14	425
486	App\\Models\\Submission	14	437
487	App\\Models\\Submission	15	438
488	App\\Models\\Submission	15	439
489	App\\Models\\Submission	15	436
490	App\\Models\\Submission	15	440
491	App\\Models\\Submission	15	425
492	App\\Models\\Submission	16	441
493	App\\Models\\Submission	16	442
494	App\\Models\\Submission	16	443
495	App\\Models\\Submission	17	429
496	App\\Models\\Submission	17	415
497	App\\Models\\Submission	17	388
498	App\\Models\\Submission	18	444
499	App\\Models\\Submission	18	445
500	App\\Models\\Submission	18	446
501	App\\Models\\Submission	18	447
502	App\\Models\\Submission	18	388
503	App\\Models\\Submission	18	403
504	App\\Models\\Submission	18	448
505	App\\Models\\Submission	19	402
506	App\\Models\\Submission	19	449
507	App\\Models\\Submission	19	450
508	App\\Models\\Submission	19	451
509	App\\Models\\Submission	19	388
510	App\\Models\\Submission	20	452
511	App\\Models\\Submission	20	406
512	App\\Models\\Submission	20	438
513	App\\Models\\Submission	20	453
514	App\\Models\\Submission	20	439
515	App\\Models\\Submission	20	440
516	App\\Models\\Submission	20	388
517	App\\Models\\Submission	21	454
518	App\\Models\\Submission	21	455
519	App\\Models\\Submission	21	456
520	App\\Models\\Submission	22	432
521	App\\Models\\Submission	22	457
522	App\\Models\\Submission	22	458
523	App\\Models\\Submission	22	411
524	App\\Models\\Submission	22	459
525	App\\Models\\Submission	23	404
526	App\\Models\\Submission	23	402
527	App\\Models\\Submission	23	460
528	App\\Models\\Submission	23	461
529	App\\Models\\Submission	23	406
530	App\\Models\\Submission	23	462
531	App\\Models\\Submission	24	463
532	App\\Models\\Submission	24	464
533	App\\Models\\Submission	24	460
534	App\\Models\\Submission	24	465
535	App\\Models\\Submission	24	388
536	App\\Models\\Submission	24	432
537	App\\Models\\Submission	25	466
538	App\\Models\\Submission	25	393
539	App\\Models\\Submission	25	404
540	App\\Models\\Submission	26	467
541	App\\Models\\Submission	26	401
542	App\\Models\\Submission	26	389
543	App\\Models\\Submission	26	468
544	App\\Models\\Submission	26	469
\.


--
-- Name: tagged_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tagged_id_seq', 544, true);


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
388	App\\Models\\Submission	ut	ut	7
386	App\\Models\\Submission	perferendis	perferendis	1
387	App\\Models\\Submission	laborum	laborum	1
390	App\\Models\\Submission	enim	enim	3
389	App\\Models\\Submission	et	et	3
391	App\\Models\\Submission	ipsam	ipsam	1
392	App\\Models\\Submission	mollitia	mollitia	1
394	App\\Models\\Submission	qui	qui	1
395	App\\Models\\Submission	accusantium	accusantium	1
396	App\\Models\\Submission	assumenda	assumenda	1
397	App\\Models\\Submission	sapiente	sapiente	1
398	App\\Models\\Submission	necessitatibus	necessitatibus	1
399	App\\Models\\Submission	excepturi	excepturi	1
400	App\\Models\\Submission	quis	quis	1
435	App\\Models\\Submission	nam	nam	1
455	App\\Models\\Submission	repellendus	repellendus	1
466	App\\Models\\Submission	officiis	officiis	1
405	App\\Models\\Submission	provident	provident	1
407	App\\Models\\Submission	aliquid	aliquid	1
408	App\\Models\\Submission	quae	quae	1
409	App\\Models\\Submission	facere	facere	1
410	App\\Models\\Submission	impedit	impedit	1
393	App\\Models\\Submission	sed	sed	4
456	App\\Models\\Submission	voluptatum	voluptatum	1
413	App\\Models\\Submission	magnam	magnam	1
414	App\\Models\\Submission	unde	unde	1
404	App\\Models\\Submission	aut	aut	3
417	App\\Models\\Submission	hic	hic	1
437	App\\Models\\Submission	nisi	nisi	1
419	App\\Models\\Submission	commodi	commodi	1
422	App\\Models\\Submission	voluptas	voluptas	1
423	App\\Models\\Submission	ducimus	ducimus	1
418	App\\Models\\Submission	libero	libero	2
424	App\\Models\\Submission	similique	similique	1
426	App\\Models\\Submission	quo	quo	1
427	App\\Models\\Submission	ex	ex	1
457	App\\Models\\Submission	deserunt	deserunt	1
412	App\\Models\\Submission	sint	sint	2
428	App\\Models\\Submission	voluptatibus	voluptatibus	1
416	App\\Models\\Submission	dolores	dolores	2
420	App\\Models\\Submission	sunt	sunt	3
458	App\\Models\\Submission	quos	quos	1
430	App\\Models\\Submission	quaerat	quaerat	1
431	App\\Models\\Submission	totam	totam	1
411	App\\Models\\Submission	placeat	placeat	2
433	App\\Models\\Submission	adipisci	adipisci	1
434	App\\Models\\Submission	laudantium	laudantium	1
421	App\\Models\\Submission	ad	ad	2
385	App\\Models\\Submission	perspiciatis	perspiciatis	3
436	App\\Models\\Submission	eveniet	eveniet	2
459	App\\Models\\Submission	velit	velit	1
425	App\\Models\\Submission	omnis	omnis	4
441	App\\Models\\Submission	a	a	1
442	App\\Models\\Submission	voluptatem	voluptatem	1
443	App\\Models\\Submission	illo	illo	1
429	App\\Models\\Submission	blanditiis	blanditiis	2
415	App\\Models\\Submission	distinctio	distinctio	3
444	App\\Models\\Submission	cum	cum	1
445	App\\Models\\Submission	animi	animi	1
446	App\\Models\\Submission	architecto	architecto	1
447	App\\Models\\Submission	eum	eum	1
403	App\\Models\\Submission	id	id	2
448	App\\Models\\Submission	atque	atque	1
467	App\\Models\\Submission	cumque	cumque	1
449	App\\Models\\Submission	saepe	saepe	1
450	App\\Models\\Submission	nulla	nulla	1
451	App\\Models\\Submission	rerum	rerum	1
452	App\\Models\\Submission	nihil	nihil	1
401	App\\Models\\Submission	optio	optio	2
438	App\\Models\\Submission	quasi	quasi	2
453	App\\Models\\Submission	corporis	corporis	1
439	App\\Models\\Submission	neque	neque	2
440	App\\Models\\Submission	at	at	2
454	App\\Models\\Submission	est	est	1
402	App\\Models\\Submission	sit	sit	4
461	App\\Models\\Submission	non	non	1
406	App\\Models\\Submission	earum	earum	3
462	App\\Models\\Submission	iste	iste	1
463	App\\Models\\Submission	ipsum	ipsum	1
464	App\\Models\\Submission	cupiditate	cupiditate	1
460	App\\Models\\Submission	dignissimos	dignissimos	2
465	App\\Models\\Submission	consequatur	consequatur	1
432	App\\Models\\Submission	tempora	tempora	3
468	App\\Models\\Submission	doloremque	doloremque	1
469	App\\Models\\Submission	dolore	dolore	1
\.


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tags_id_seq', 469, true);


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY topics (id, google_id, slug, name, json, count, created_at, updated_at) FROM stdin;
1	/m/0478__m	\N	Lady Gaga	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0478__m","name":"Lady Gaga","@type":["Person","Thing"],"description":"Singer-songwriter","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcTotytMaY9gb94XgsQmQV0WqTZpxfyG_J7GjRl0-40Wp8wSc8ug","url":"https:\\/\\/simple.wikipedia.org\\/wiki\\/Lady_Gaga","license":"http:\\/\\/creativecommons.org\\/licenses\\/by\\/2.0"},"detailedDescription":{"articleBody":"Stefani Joanne Angelina Germanotta, known professionally as Lady Gaga, is an American singer, songwriter, and actress. She performed initially in theater, appearing in high school plays, and studied at CAP21 through NYU's Tisch School of the Arts before dropping out to pursue a musical career. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Lady_Gaga","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.ladygaga.com\\/"},"resultScore":29.558586}	0	2017-02-12 00:43:31	2017-02-12 00:43:31
2	/m/0ftryzw	\N	Bad Romance	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0ftryzw","name":"Bad Romance","@type":["MusicRecording","Thing"],"description":"Song by Lady Gaga"},"resultScore":6.303305}	0	2017-02-12 00:43:31	2017-02-12 00:43:31
3	/m/0807c3_	\N	\N	\N	0	2017-02-12 00:43:31	2017-02-12 00:43:31
4	/m/064t9	\N	\N	\N	0	2017-02-12 00:43:31	2017-02-12 00:43:31
5	/m/08b6yt	\N	\N	\N	0	2017-02-12 00:43:32	2017-02-12 00:43:32
6	/m/01gl72	\N	\N	\N	0	2017-02-12 00:43:32	2017-02-12 00:43:32
7	/m/01n33z	\N	Joe Rogan	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01n33z","name":"Joe Rogan","@type":["Person","Thing"],"description":"Comedian","image":{"contentUrl":"http:\\/\\/t0.gstatic.com\\/images?q=tbn:ANd9GcSyNVl1ABw3HIRxjrnKu2x5XU-I0v8oHo1zHc_TIO9clUfLPnhj","url":"https:\\/\\/simple.wikipedia.org\\/wiki\\/Joe_Rogan","license":"http:\\/\\/creativecommons.org\\/licenses\\/by\\/2.0"},"detailedDescription":{"articleBody":"Joseph James \\"Joe\\" Rogan is an American stand-up comedian, sports color commentator, television host, actor, and podcast host. Born in Newark, New Jersey, Rogan and his family moved several times before they settled in Newton Upper Falls, Massachusetts. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Joe_Rogan","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/joerogan.net\\/"},"resultScore":20.564383}	0	2017-02-12 00:43:33	2017-02-12 00:43:33
8	/m/01_6j_	\N	Alex Jones	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01_6j_","name":"Alex Jones","@type":["Person","Thing"],"description":"Radio host","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcRmIVNYmckayjYoT9IhW1vX928BhjX8nVDoAW7px7ByVsva0x23","url":"https:\\/\\/simple.wikipedia.org\\/wiki\\/Alex_Jones","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/2.0"},"detailedDescription":{"articleBody":"Alexander Emerick \\"Alex\\" Jones is an American right-wing radio show host, filmmaker, writer, and conspiracy theorist. He hosts The Alex Jones Show from Austin, Texas, which airs on the Genesis Communications Network and shortwave radio station WWCR across the United States and online. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Alex_Jones_(radio_host)","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.infowars.com\\/"},"resultScore":22.356672}	0	2017-02-12 00:43:33	2017-02-12 00:43:33
9	/m/08rm_x	\N	Eddie Bravo	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/08rm_x","name":"Eddie Bravo","@type":["Thing","Person"],"image":{"contentUrl":"http:\\/\\/t0.gstatic.com\\/images?q=tbn:ANd9GcTXZxRWA6CSPh-1JZzKfiZG2WlLQsTAu0LBSDUbbCkjIv4YOz7Y","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Eddie_Bravo"},"detailedDescription":{"articleBody":"Edgar \\"Eddie\\" Bravo is an American Jiu-Jitsu instructor and the founder of 10th Planet Jiu-Jitsu.","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Eddie_Bravo","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":15.273909}	0	2017-02-12 00:43:33	2017-02-12 00:43:33
10	/m/01x2m_y	\N	Radical Face	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01x2m_y","name":"Radical Face","@type":["Thing"],"description":"Musical Artist","detailedDescription":{"articleBody":"Radical Face is a musical act whose main member is Ben Cooper.","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Radical_Face","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.radicalface.com\\/"},"resultScore":15.498034}	0	2017-02-12 00:43:34	2017-02-12 00:43:34
11	/m/01f4vzq	\N	Welcome Home	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01f4vzq","name":"Welcome Home","@type":["MusicRecording","Thing"],"description":"Song by Radical Face"},"resultScore":5.584968}	0	2017-02-12 00:43:34	2017-02-12 00:43:34
12	/m/0_kd_k5	\N	\N	\N	0	2017-02-12 00:43:34	2017-02-12 00:43:34
13	/m/0342h	\N	\N	\N	0	2017-02-12 00:43:34	2017-02-12 00:43:34
14	/m/01rlyjc	\N	Reggie Watts	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01rlyjc","name":"Reggie Watts","@type":["Person","Thing"],"description":"Musician","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcTWRxWITwRnOUWVBsuNvarcsc9mzoCa3pf2VPEXPA6PeRj6-0lR","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Reggie_Watts_at_PopTech_2011_(a).jpg","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/2.0"},"detailedDescription":{"articleBody":"Reginald Lucien Frank Roger \\"Reggie\\" Watts is an American musician, singer, beatboxer, actor, and comedian. His improvised musical sets are created using only his voice, a keyboard, and a looping machine. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Reggie_Watts","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.reggiewatts.com\\/"},"resultScore":18.374756}	0	2017-02-12 00:43:34	2017-02-12 00:43:34
15	/m/017rf_	\N	Netflix	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/017rf_","name":"Netflix","@type":["Thing","Corporation","Organization"],"description":"Company","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcTvwi94qQVasbn-bIrq0zCSsiyWW0fDxhbEG66TYJoBub58vuwZ","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Netflix_logo.svg"},"detailedDescription":{"articleBody":"Netflix, Inc. is an American entertainment company founded on August 29, 1997, in Scotts Valley, California, by Reed Hastings and Marc Randolph. It specializes in and provides streaming media and video-on-demand online and DVD by mail. In 2013 Netflix expanded into film and television production, as well as online distribution. As of 2017 the company has its headquarters in Los Gatos, California.\\nIn 1998, about a year after Netflix's founding, the company grew by starting in the DVD by mail business. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Netflix","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":42.148647}	0	2017-02-12 00:43:34	2017-02-12 00:43:34
16	/m/018gz8	\N	\N	\N	0	2017-02-12 00:43:34	2017-02-12 00:43:34
17	/m/033lpr	\N	\N	\N	0	2017-02-12 00:43:34	2017-02-12 00:43:34
18	/m/015lz1	\N	\N	\N	0	2017-02-12 00:43:34	2017-02-12 00:43:34
19	/m/01gq53	\N	\N	\N	0	2017-02-12 00:43:34	2017-02-12 00:43:34
20	/m/09kqc	\N	\N	\N	0	2017-02-12 00:43:34	2017-02-12 00:43:34
21	/m/0k4j	\N	\N	\N	0	2017-02-12 00:43:35	2017-02-12 00:43:35
22	/m/0g94m	\N	\N	\N	0	2017-02-12 00:43:35	2017-02-12 00:43:35
23	/m/0hrh365	\N	\N	\N	0	2017-02-12 00:43:35	2017-02-12 00:43:35
24	/m/0bqb0z	\N	\N	\N	0	2017-02-12 00:43:35	2017-02-12 00:43:35
25	/m/07yv9	\N	\N	\N	0	2017-02-12 00:43:35	2017-02-12 00:43:35
26	/m/07j7r	\N	Tree	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/07j7r","name":"Tree","@type":["Thing"],"description":"Plant","image":{"contentUrl":"http:\\/\\/t1.gstatic.com\\/images?q=tbn:ANd9GcTK6gW1d8ZXaaMHStFqYUhb6VmrgrUZIerqgsKWGSleVVW1nVGb","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Tree","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/2.0"},"detailedDescription":{"articleBody":"In botany, a tree is a perennial plant with an elongated stem, or trunk, supporting branches and leaves in most species. In some usages, the definition of a tree may be narrower, including only woody plants with secondary growth, plants that are usable as lumber or plants above a specified height. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Tree","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":27.303528}	0	2017-02-12 00:43:36	2017-02-12 00:43:36
27	/m/05h0n	\N	\N	\N	0	2017-02-12 00:43:36	2017-02-12 00:43:36
28	/m/05b0n7k	\N	\N	\N	0	2017-02-12 00:43:36	2017-02-12 00:43:36
29	/m/023bbt	\N	\N	\N	0	2017-02-12 00:43:36	2017-02-12 00:43:36
30	/m/02zr8	\N	\N	\N	0	2017-02-12 00:43:36	2017-02-12 00:43:36
31	/m/01h6d4	\N	\N	\N	0	2017-02-12 00:43:36	2017-02-12 00:43:36
32	/m/09d_r	\N	\N	\N	0	2017-02-12 00:43:36	2017-02-12 00:43:36
33	/m/07bxq	\N	\N	\N	0	2017-02-12 00:43:36	2017-02-12 00:43:36
34	/m/014l4w	\N	National Film Board of Canada	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/014l4w","name":"National Film Board of Canada","@type":["Corporation","Organization","GovernmentOrganization","Thing"],"description":"Film distributor","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcQNzzUpRRcRRg9lao4L25JBUXmxnGEbkpq4-ClrC3SVz1hAerVm","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Office_national_du_film_montreal.jpg","license":"http:\\/\\/www.gnu.org\\/copyleft\\/fdl.html"},"detailedDescription":{"articleBody":"The National Film Board of Canada is Canada's twelve-time Academy Award-winning public film and digital media producer and distributor. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/National_Film_Board_of_Canada","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.NFB.ca"},"resultScore":20.777863}	0	2017-02-12 00:43:36	2017-02-12 00:43:36
35	/m/04byh1	\N	Universe	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/04byh1","name":"Universe","@type":["Movie","Thing"],"description":"1960 film","detailedDescription":{"articleBody":"Universe is a black-and-white short animated documentary made in 1960 by the National Film Board of Canada. It \\"creates on the screen a vast, awe-inspiring picture of the universe as it would appear to a voyager through space. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Universe_(1960_film)","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":9.404593}	0	2017-02-12 00:43:36	2017-02-12 00:43:36
36	/m/0d060g	\N	Canada	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0d060g","name":"Canada","@type":["Country","Thing","AdministrativeArea","Place"],"description":"Country","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcRhs5VpCA5iyxCPBZz6bEfI5C4H9uDrGBFnlbP4kBs70iRynyip","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Flag_of_Canada_(Pantone).svg"},"detailedDescription":{"articleBody":"Canada is a country in the northern half of North America. Its ten provinces and three territories extend from the Atlantic to the Pacific and northward into the Arctic Ocean, covering 9.98 million square kilometres, making it the world's second-largest country by total area and the fourth-largest country by land area. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Canada","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.gc.ca\\/"},"resultScore":40.565517}	0	2017-02-12 00:43:37	2017-02-12 00:43:37
37	/m/02wc06	\N	Roman Kroitor	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/02wc06","name":"Roman Kroitor","@type":["Thing","Person"],"description":"Filmmaker","detailedDescription":{"articleBody":"Roman Kroitor was a Canadian filmmaker who was known as an early practitioner of Cin\\u00e9ma v\\u00e9rit\\u00e9, as co-founder of IMAX, and as creator of the Sandde hand-drawn stereoscopic animation system. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Roman_Kroitor","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":11.433697}	0	2017-02-12 00:43:37	2017-02-12 00:43:37
38	/m/02vxn	\N	\N	\N	0	2017-02-12 00:43:37	2017-02-12 00:43:37
39	/m/01d9ll	\N	\N	\N	0	2017-02-12 00:43:37	2017-02-12 00:43:37
40	/m/0jtdp	\N	\N	\N	0	2017-02-12 00:43:37	2017-02-12 00:43:37
41	/m/0lyj0	\N	Appalachian National Scenic Trail	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0lyj0","name":"Appalachian National Scenic Trail","@type":["Place","TouristAttraction","Thing"],"description":"National Park","image":{"contentUrl":"http:\\/\\/t0.gstatic.com\\/images?q=tbn:ANd9GcSBjbfJ19NbtMbpTI43JeI7ERohCE47K0DvDfmBj4n8r1pz-CO7","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Appalachian_Trail_sign_in_Pennsylvania.JPG","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/3.0"},"detailedDescription":{"articleBody":"The Appalachian National Scenic Trail, generally known as the Appalachian Trail or simply the A.T., is a marked hiking trail in the eastern United States extending between Springer Mountain in Georgia and Mount Katahdin in Maine. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Appalachian_Trail","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":22.665983}	0	2017-02-12 00:43:37	2017-02-12 00:43:37
42	/m/0lm0n	\N	Appalachian Mountains	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0lm0n","name":"Appalachian Mountains","@type":["Thing","Mountain","Place"],"description":"Mountain system","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcSNaRAZgGHHaV3_kNDemYsEBx_T4Lmm6A8ts3k_STXem6gmOaub","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:MonNatForest.jpg","license":"http:\\/\\/www.gnu.org\\/copyleft\\/fdl.html"},"detailedDescription":{"articleBody":"The Appalachian Mountains, often called the Appalachians, are a system of mountains in eastern North America. The Appalachians first formed roughly 480 million years ago during the Ordovician Period. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Appalachian_Mountains","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":23.682806}	0	2017-02-12 00:43:37	2017-02-12 00:43:37
43	/m/04rh6b	\N	\N	\N	0	2017-02-12 00:43:37	2017-02-12 00:43:37
44	/m/0148v7	\N	\N	\N	0	2017-02-12 00:43:38	2017-02-12 00:43:38
45	/m/016bnh	\N	\N	\N	0	2017-02-12 00:43:38	2017-02-12 00:43:38
46	/m/02p0qmm	\N	\N	\N	0	2017-02-12 00:43:38	2017-02-12 00:43:38
47	/m/01mf0	\N	\N	\N	0	2017-02-12 00:43:38	2017-02-12 00:43:38
48	/m/07c1v	\N	\N	\N	0	2017-02-12 00:43:38	2017-02-12 00:43:38
49	/m/051x4df	\N	Philip DeFranco	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/051x4df","name":"Philip DeFranco","@type":["Person","Thing"],"description":"Video blogger","image":{"contentUrl":"http:\\/\\/t0.gstatic.com\\/images?q=tbn:ANd9GcQxYEK-spxxDrx5dGrXi277fxeJiYi0XrONP7sT0G_SOdC98geX","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Philip_DeFranco","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/3.0"},"detailedDescription":{"articleBody":"Philip James DeFranco Jr, is an American video blogger and YouTube personality. He is most notable for The Philip DeFranco Show, usually abbreviated as PDS, a news show centered on current events, politics, pop culture, and celebrity gossip in which he voices his opinion, often presented in a satirical manner and with frequent jump cuts to create a fast-paced feel. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Philip_DeFranco","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/phillyd.tv\\/"},"resultScore":17.557213}	0	2017-02-12 00:43:39	2017-02-12 00:43:39
50	/m/0z_7x56	\N	Dear White People	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0z_7x56","name":"Dear White People","@type":["Movie","Thing"],"description":"2014 film","detailedDescription":{"articleBody":"Dear White People is a 2014 American satirical comedy-drama film, written, directed, and co-produced by Justin Simien. The film focuses on escalating racial tensions at a prestigious Ivy League college from the perspective of several African American students. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Dear_White_People","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.dearwhitepeoplemovie.com\\/"},"resultScore":16.10474}	0	2017-02-12 00:43:39	2017-02-12 00:43:39
51	/m/06d4h	\N	\N	\N	0	2017-02-12 00:43:39	2017-02-12 00:43:39
52	/m/07cb8	\N	\N	\N	0	2017-02-12 00:43:39	2017-02-12 00:43:39
53	/m/0jbk	\N	Animal	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0jbk","name":"Animal","@type":["Thing"],"image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcQ9tdhmB3iQe9zysaKtGyaQmus2XVDAHs5jjf5zkH4dzXZgHykz","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Animal_diversity_October_2007_for_thumbnail.jpg","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/3.0"},"detailedDescription":{"articleBody":"Animals are multicellular, eukaryotic organisms of the kingdom Animalia. The animal kingdom emerged as a basal clade within Apoikozoa as a sister of the choanoflagellates. Sponges are the most basal clade of animals. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Animal","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":39.504063}	0	2017-02-12 00:43:39	2017-02-12 00:43:39
54	/m/01yrx	\N	cat	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01yrx","name":"cat","@type":["Thing"],"description":"Animal","image":{"contentUrl":"http:\\/\\/t1.gstatic.com\\/images?q=tbn:ANd9GcShZghyt2L03zlqdj_6F7EPbCCsWWnAcVsvJ3_xv7cc-IraZc-o","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Cat_March_2010-1.jpg","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/3.0"},"detailedDescription":{"articleBody":"The domestic cat is a small, typically furry, carnivorous mammal. They are often called house cats when kept as indoor pets or simply cats when there is no need to distinguish them from other felids and felines. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Cat","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":29.050875}	0	2017-02-12 00:43:39	2017-02-12 00:43:39
55	/m/0lbxg	\N	\N	\N	0	2017-02-12 00:43:39	2017-02-12 00:43:39
56	/m/0k8zdxn	\N	PewDiePie	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0k8zdxn","name":"PewDiePie","@type":["Thing","Person"],"description":"Comedian","image":{"contentUrl":"http:\\/\\/t0.gstatic.com\\/images?q=tbn:ANd9GcRPnHg34RH_KudIgj76pp3nYCrq9rTivaKDcFTpajjUaDpu9lOE","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:PewDiePie_at_PAX_2015_crop.jpg","license":"http:\\/\\/creativecommons.org\\/publicdomain\\/zero\\/1.0\\/deed.en"},"detailedDescription":{"articleBody":"Felix Arvid Ulf Kjellberg, better known by his online alias PewDiePie, is a Swedish web-based comedian and video producer, best known for his Let's Play commentaries and vlogs on YouTube.\\n","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/PewDiePie","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.pewdiepie.com\\/"},"resultScore":22.611353}	0	2017-02-12 00:43:40	2017-02-12 00:43:40
57	/m/04wv_	\N	Moon	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/04wv_","name":"Moon","@type":["Thing"],"description":"Natural Satellite","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcRWRAcLt2z8Rz--ZzApqQ2XprbuCiowBs6oOdtQcmKN2c92x3tM","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Moon","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/3.0"},"detailedDescription":{"articleBody":"The Moon is an astronomical body that orbits planet Earth, being Earth's only permanent natural satellite. It is the fifth-largest natural satellite in the Solar System, and the largest among planetary satellites relative to the size of the planet that it orbits. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Moon","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":29.167313}	0	2017-02-12 00:43:41	2017-02-12 00:43:41
58	/m/05d1bj	\N	\N	\N	0	2017-02-12 00:43:41	2017-02-12 00:43:41
59	/m/06mq7	\N	\N	\N	0	2017-02-12 00:43:41	2017-02-12 00:43:41
60	/m/01k8wb	\N	\N	\N	0	2017-02-12 00:43:41	2017-02-12 00:43:41
61	/m/084dw	\N	\N	\N	0	2017-02-12 00:43:42	2017-02-12 00:43:42
62	/m/0bt9lr	\N	Dog	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0bt9lr","name":"Dog","@type":["Thing"],"description":"Animal","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcTtX76fJgSOyauWqsuLK15i9cgthxwi-L9zBWiWWfUYfhZxGIXW","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Too-cute-doggone-it-video-playlist.jpg","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/4.0"},"detailedDescription":{"articleBody":"The domestic dog is a member of genus Canis that forms part of the wolf-like canids, and is the most widely abundant carnivore. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Dog","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":30.540926}	0	2017-02-12 00:43:42	2017-02-12 00:43:42
63	/m/017y8_	\N	Terrier	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/017y8_","name":"Terrier","@type":["Thing"],"description":"Animal","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcS5sYl_uVjIbsjFxgnPJZhiBnQDx3p7i_TiYvdfgYScHXubZWuN","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Terrier","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/4.0"},"detailedDescription":{"articleBody":"A terrier is a dog of any one of many breeds or landraces of terrier type, which are typically small, wiry, very active and fearless dogs. Terrier breeds vary greatly in size from just 1 kg to over 32 kg and are usually categorized by size or function. There are five different groups with each group having several different breeds.","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Terrier","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":20.581709}	0	2017-02-12 00:43:43	2017-02-12 00:43:43
64	/m/02x9dk	\N	Boston Terrier	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/02x9dk","name":"Boston Terrier","@type":["Thing"],"description":"Dog Breed","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcQDpcp8xndNIF5M0Fmw4NBdwBULheeO0PYeLofhqrivF5l1j_ff","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:BostonTerrier001.JPG","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/3.0"},"detailedDescription":{"articleBody":"The Boston Terrier is a breed of dog originating in the United States. This \\"American Gentleman\\" was accepted in 1893 by the American Kennel Club as a non-sporting breed. Color and markings are important when distinguishing this breed to the AKC standard. They should be either black, brindle or seal with white markings. Bostons are small and compact with a short tail and erect ears. The AKC says they are highly intelligent and very easily trained. They are friendly and can be stubborn at times. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Boston_Terrier","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":20.561565}	0	2017-02-12 00:43:43	2017-02-12 00:43:43
65	/m/068hy	\N	\N	\N	0	2017-02-12 00:43:43	2017-02-12 00:43:43
66	/m/0d7s3w	\N	\N	\N	0	2017-02-12 00:43:43	2017-02-12 00:43:43
67	/m/0l4h_	\N	\N	\N	0	2017-02-12 00:43:43	2017-02-12 00:43:43
68	/m/05mqq3	\N	\N	\N	0	2017-02-12 00:43:43	2017-02-12 00:43:43
69	/m/0p57p	\N	\N	\N	0	2017-02-12 00:43:44	2017-02-12 00:43:44
70	/m/01mtb	\N	\N	\N	0	2017-02-12 00:43:44	2017-02-12 00:43:44
71	/m/052sf	\N	Mushroom	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/052sf","name":"Mushroom","@type":["Thing"],"description":"Food","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcRTElRA0zZBZeWI1peCmg1-CdkVSHvvUG4g6smH8mv_rm7ktuj5","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Mushroom","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/2.5"},"detailedDescription":{"articleBody":"A mushroom is the fleshy, spore-bearing fruiting body of a fungus, typically produced above ground on soil or on its food source.\\n","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Mushroom","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":23.629423}	0	2017-02-12 00:43:44	2017-02-12 00:43:44
72	/m/020t4k	\N	Stuffing	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/020t4k","name":"Stuffing","@type":["Thing"],"description":"Food","image":{"contentUrl":"http:\\/\\/t3.gstatic.com\\/images?q=tbn:ANd9GcSuOfILP59ebdFdMcSDpHFwAdKFzcc9DuMVPCXA4o2onCwl8CUz","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Stuffing_a_turkey.jpg","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/2.0"},"detailedDescription":{"articleBody":"Stuffing, filling, or dressing is an edible substance or mixture, often a starch, used to fill a cavity in another food item while cooking. Many foods may be stuffed, including eggs, poultry, seafood, mammals, and vegetables.\\n","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Stuffing","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":19.934374}	0	2017-02-12 00:43:44	2017-02-12 00:43:44
73	/m/02q08p0	\N	\N	\N	0	2017-02-12 00:43:44	2017-02-12 00:43:44
74	/m/02wbm	\N	\N	\N	0	2017-02-12 00:43:44	2017-02-12 00:43:44
75	/m/0bqtd	\N	\N	\N	0	2017-02-12 00:43:44	2017-02-12 00:43:44
76	/m/0dv34	\N	\N	\N	0	2017-02-12 00:43:44	2017-02-12 00:43:44
77	/m/02j71	\N	Earth	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/02j71","name":"Earth","@type":["Thing","Place"],"description":"Planet","image":{"contentUrl":"http:\\/\\/t0.gstatic.com\\/images?q=tbn:ANd9GcT1mh46qaRg5na3pNLs9iakbicwHMDGgUuYN7jDdkyhgIeJky9y","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Earth_Eastern_Hemisphere.jpg"},"detailedDescription":{"articleBody":"Earth, otherwise known as the world, is the third planet from the Sun and the only object in the Universe known to harbor life. It is the densest planet in the Solar System and the largest of the four terrestrial planets.\\nAccording to radiometric dating and other sources of evidence, Earth formed about 4.54 billion years ago. Earth's gravity interacts with other objects in space, especially the Sun and the Moon, Earth's only natural satellite. During one orbit around the Sun, Earth rotates about its axis over 365 times, thus an Earth year is about 365.26 days long. Earth's axis of rotation is tilted, producing seasonal variations on the planet's surface. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Earth","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":35.737907}	0	2017-02-12 00:43:44	2017-02-12 00:43:44
78	/m/0d1w9	\N	\N	\N	0	2017-02-12 00:43:44	2017-02-12 00:43:44
79	/m/07094	\N	\N	\N	0	2017-02-12 00:43:45	2017-02-12 00:43:45
80	/m/07kk5	\N	\N	\N	0	2017-02-12 00:43:45	2017-02-12 00:43:45
81	/m/094dsh	\N	\N	\N	0	2017-02-12 00:43:45	2017-02-12 00:43:45
82	/m/06nzl	\N	\N	\N	0	2017-02-12 00:43:45	2017-02-12 00:43:45
83	/m/0gvt53w	\N	The Master	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/0gvt53w","name":"The Master","@type":["Movie","Thing"],"description":"2012 film","detailedDescription":{"articleBody":"The Master is a 2012 American psychological drama film written, directed, and co-produced by Paul Thomas Anderson and starring Joaquin Phoenix, Philip Seymour Hoffman, and Amy Adams. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/The_Master_(2012_film)","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/www.themasterfilm.com\\/"},"resultScore":20.193451}	0	2017-02-12 00:43:46	2017-02-12 00:43:46
84	/m/03hdbf	\N	\N	\N	0	2017-02-12 00:43:46	2017-02-12 00:43:46
85	/m/045wvq	\N	Arcade Fire	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/045wvq","name":"Arcade Fire","@type":["Thing","MusicGroup"],"description":"Rock band","image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcRtb9OlB1HcKIUKw4Qp5uhu13lQzcKnpGGCYzfbfDLmxZnT45gj","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Arcade_fire_mg_7287.jpg","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/2.0\\/fr\\/deed.en"},"detailedDescription":{"articleBody":"Arcade Fire is a Canadian indie rock band based in Montreal, Quebec,consisting of husband and wife Win Butler and R\\u00e9gine Chassagne, along with Win's younger brother William Butler, Richard Reed Parry, Tim Kingsbury and Jeremy Gara. ","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Arcade_Fire","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"},"url":"http:\\/\\/arcadefire.com\\/"},"resultScore":21.822828}	0	2017-02-12 00:43:46	2017-02-12 00:43:46
86	/m/025tqfq	\N	\N	\N	0	2017-02-12 00:43:46	2017-02-12 00:43:46
87	/m/01jj9zk	\N	Live at Earls Court	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01jj9zk","name":"Live at Earls Court","@type":["MusicAlbum","Thing"],"description":"Live album by Morrissey","detailedDescription":{"articleBody":"Live at Earls Court is a live album by Morrissey. Its sleeve notes state that it was \\"recorded live at Earls Court in London on the 18 December 2004 in front of 17,183 people.\\"","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Live_at_Earls_Court","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":10.61483}	0	2017-02-12 00:43:47	2017-02-12 00:43:47
88	/m/01jddz	\N	\N	\N	0	2017-02-12 00:43:47	2017-02-12 00:43:47
89	/m/04_5hy	\N	\N	\N	0	2017-02-12 00:43:47	2017-02-12 00:43:47
90	/m/039v1	\N	\N	\N	0	2017-02-12 00:43:47	2017-02-12 00:43:47
91	/m/03qtwd	\N	\N	\N	0	2017-02-12 00:43:47	2017-02-12 00:43:47
92	/m/09jwl	\N	\N	\N	0	2017-02-12 00:43:47	2017-02-12 00:43:47
\.


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('topics_id_seq', 92, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, email, username, first_name, last_name, password, last_sign_in, created_at, updated_at, remember_token) FROM stdin;
1	user@test.com	Anonymous-x0qj5lom	\N	\N	$2y$10$mg8TGt//OdppXQ901tbDpOAbeRCDZTbiEgob/bgpr0SoX.cIdgneC	\N	2017-02-12 00:43:30	2017-02-12 00:43:30	\N
2	user2@test.com	Anonymous-zky59q97	\N	\N	$2y$10$7tdQVNd0Sajx1dohguHZxOr53r355d1IC81u1UNaeZGyAxxdbTwiC	\N	2017-02-12 00:43:30	2017-02-12 00:43:30	\N
3	social@test.com	Anonymous-k6lx7yx2	\N	\N	\N	\N	2017-02-12 00:43:30	2017-02-12 00:43:30	\N
4	unverified@test.com	Anonymous-j0yrxy9z	\N	\N	$2y$10$IWcq9gYByMqPsLiD0YsgL.3Zz4QBUFC/xMARsd2jrflV4s9kLy4y2	\N	2017-02-12 00:43:30	2017-02-12 00:43:30	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 4, true);


--
-- Data for Name: verifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY verifications (user_id, token, created_at) FROM stdin;
4	ea6c0c44eff227904fbeff60ce50c198a3acf0ec8cf9294c6d18debe6c881ade	2017-02-12 00:43:30
\.


--
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY videos (id, youtube_id, title, description, embeddable, privacy_status, published_at, created_at, updated_at) FROM stdin;
1	qrO4YZeyl0I	Lady Gaga - Bad Romance	LADY GAGA / JOANNE \nNEW ALBUM / OUT NOW\niTunes: http://smarturl.it/Joanne \nGoogle Play: http://smarturl.it/Joanne.gp \nAmazon: http://smarturl.it/Joanne.amz\nLadyGaga.com: http://smarturl.it/GagaStore\n\nFOLLOW LADY GAGA:\nhttp://www.facebook.com/ladygaga\nhttp://www.twitter.com/ladygaga\nhttp://www.instagram.com/ladygaga\nhttp://www.snapchat.com/add/ladygaga\nhttp://smarturl.it/LG.sp \n\nEMAIL LIST: \nhttp://smarturl.it/LadyGaga.News\n\nMusic video by Lady Gaga performing Bad Romance. (C) 2009 Interscope Records\n#VEVOCertified on January 31, 2010. http://www.vevo.com/certified http://www.youtube.com/vevocertified	t	public	2009-11-24 07:45:26	2017-02-12 00:43:31	2017-02-12 00:43:31
2	eQZEQQMWiVs	UH OH BIG BOY TAIL WHIPS AGAIN!	Finally a somewhat nice day has come in what has been a very cold February winter. Matty, BIG BOY and I went to a random skatepark by my cousins work for an awesome session. We rolled up there and it was a skatepark full of skateboarders, but they were absoultluy awesome and they had no issue with us getting a session in with them. Matty and BIG BOY did a lot on some ramps that they thought were going to be to small to ride Matty made BIG BOY learn how to do a bunch of new tricks like a whip over the bank to bank box. I called BIG BOY out on a bunch of tricks and as usual he gets completely broke off in some way and takes a crazy crash. I can't tell you how awesome it is to be back and going around to skatepark to skatepark with these boys. Thanks for watching, remember to subscribe and peace!	t	public	2017-02-11 21:03:37	2017-02-12 00:43:31	2017-02-12 00:43:31
3	uuIlvSNU67o	NEED ADVICE	A brief update on the backyard ramp before Spencer and I get some riding in. Got some cool announcements and some good footage in this one :)\nMERCH - http://LZBMX.COM\n\nSpencer's Channel - https://www.youtube.com/channel/UCQsNNWoGmf0tN2mi04c7hnA\n\nSong #1 by David Cutter\nhttps://www.davidcuttermusic.co.uk\nSong #2 by Ryan Little\nhttps://soundcloud.com/iamryanlittle	t	public	2017-02-11 16:42:16	2017-02-12 00:43:32	2017-02-12 00:43:32
4	UZPCp8SPfOM	Joe Rogan Experience #911 - Alex Jones & Eddie Bravo	Alex Jones is a radio show host, filmmaker, writer, and conspiracy theorist. Eddie Bravo is a jiujitsu black belt, music producer, and author.	t	public	2017-02-02 02:15:04	2017-02-12 00:43:32	2017-02-12 00:43:32
5	P8a4iiOnzsc	Radical Face 'Welcome Home'	http://www.radicalface.com\nhttp://youtube.com/radicalface\nhttp://facebook.com/radicalface\nhttp://twitter.com/radicalface\nhttps://www.instagram.com/radicalfaceofficial/\n\nWebstore: http://radicalface.shop.musictoday.com/store/\nPurchase/Steam: https://Nettwerk.lnk.to/radicalfaceYA\nApple Music: http://apple.co/1Vo1Vti\nTour: http://home.radicalface.com/shows\n\nDiscography\nThe Family Tree: The Leaves\nThe Bastards\nThe Family Tree: The Branches\nAlways Gold EP\nThe Family Tree: The Roots\nWelcome Home EP\nGhost\n\nDIRECTOR's web site:   http://www.justinmitchell.com	t	public	2009-06-02 22:32:19	2017-02-12 00:43:33	2017-02-12 00:43:33
6	QVQK_Yp0KuI	Reggie Watts - Spatial 2016 (Full New Comedy Special)	Reggie Watts - Spatial 2016 FULL Stand-Up Comedy Special \nSpatial, his new Netflix special, is signature Watts, meaning it’s alternately exhilarating, silly, exhausting, and transcendent. Coming onstage as a Darth Vader-esque cloaked figure, Watts sonorously tells his audience of a vast, confusing interstellar conflict before reassuring them, “The vestibule has been opened and all of us continue to exist as if nothing will occur.” He then loses his train of thought while trying to come up with the name of their mortal enemies.	t	public	2016-12-18 05:13:35	2017-02-12 00:43:34	2017-02-12 00:43:34
7	mulGqCjMzCs	Running in Front of Cars	Instagram @Cherdleys https://www.instagram.com/cherdleys/\nSnapchat  @Cherdleys\nTwitter      @Cherdleys https://twitter.com/cherdleys\n\nCreated by Chad LeBaron AKA Cherdleys AKA One Of Those Kids That Hurts Cats\n\nWatch last video: https://www.youtube.com/watch?v=1uDu-...\n\nFollow Saxon:\nInstagram @OldManSaxon - https://www.instagram.com/oldmansaxon/	t	public	2016-02-23 15:31:46	2017-02-12 00:43:35	2017-02-12 00:43:35
8	-X_aCfVhWYI	EP35 - ONE WEEK LEFT - Pacific Crest Trail 2016	October 1, 2016 - PCT trail miles 2507.5 to 2522.1\nFollow me on https://www.instagram.com/zachrotondo/\n\nEnd screen music - soundcloud.com/lakeyinspired	t	public	2016-12-16 17:21:56	2017-02-12 00:43:35	2017-02-12 00:43:35
9	Hu64xbgprWY	Universe - National Film Board of Canada (1960)	Universe is a black-and-white short documentary made in 1960 by the National Film Board of Canada. It dramatizes the nightly work of an astronomer at the David Dunlap Observatory in Richmond Hill, Ontario, a facility that is owned and operated by the University of Toronto, Canada. The film was a nominee at the 33rd Academy Awards in the category of Best Documentary Short Subject in 1961.	t	public	2013-06-18 15:03:22	2017-02-12 00:43:36	2017-02-12 00:43:36
10	7xTOj6VwaVc	The World's Worst Backpacker on the Pacific Crest Trail...	It's time for me to share the story of my first night on the Pacific Crest Trail. Don't try this at home! (... not that you could...)\nIf you've never hiked on the PCT, this video may be for you. You might also like it if you've had a trail chew you up and spit you out.\nThis video also serves as a preview to my new monologue, The World's Worst Backpacker - coming to Audible and iTunes this summer!\nFind out more at www.kenlasalle.com.	t	public	2016-05-16 23:16:20	2017-02-12 00:43:37	2017-02-12 00:43:37
11	UYG7FoneZZU	2016 Thru Hikers Part 4	https://www.gofundme.com/hikertrashvideo	t	public	2016-11-08 02:46:02	2017-02-12 00:43:37	2017-02-12 00:43:37
12	UNsIVfGptqM	Do You Need A College Degree For a System Administration Career?	It's one of the most popular questions I get: Is a college degree required for a System Administration Career?\n\n-Do I need a university degree for a tech career, in general?\n-How can I get my first Linux sysadmin job without a degree?\n\nIn this video I talk about the value of Degrees vs. the value of Education, and some career/learning strategies for people who don't have a college degree.\n\n3:18 - Education vs Experience\n4:09 - What to Study (High-Level overview in terms of University classes to emulate)\n6:10 - Theory vs. Practical Skill\n7:52 - How to Become a System Administrator (recommended learning path)\n10:02 - Practice + Theory work together to make you better\n\n\nBook Mentioned: Andrew Tanenbaum's Modern Operating Systems (4th ed) - http://amzn.to/2kcBc6a\n\nFull Linux Sysadmin Basics Playlist: https://www.youtube.com/playlist?list=PLtK75qxsQaMLZSo7KL-PmiRarU7hrpnwK\n\nCheck out my project-based Linux System Administration course (free sample videos): https://www.udemy.com/hands-on-linux-self-hosted-wordpress-for-linux-beginners/?couponCode=tl35\n\nOfficial Site: https://tutorialinux.com/\nTwitter: https://twitter.com/tutorialinux\nFacebook: https://www.facebook.com/tutorialinux\nPatreon: https://www.patreon.com/tutorialinux	t	public	2017-02-10 15:35:31	2017-02-12 00:43:37	2017-02-12 00:43:37
23	kE1mKj8awyY	My Top 10 Essential Documentaries	Previous Video ▶ http://bit.ly/2kkfZeI\n\nSubscribe For Daily Vids ▶ http://bit.ly/1KOilIP\nFollow My Snapchat ▶ http://snpcht.me/Mrhales100\nFollow My Twitter ▶ http://www.twitter.com/lahwf\nFollow My Instagram ▶ http://www.instagram.com/mrhales109\nLike the Facebook page ▶ http://www.facebook.com/lahwf\n\nSHIRTS ▶ http://shrsl.com/?e6xk\n\nSend Fan Mail to:\n5419 Hollywood Blvd, Ste. C825\nHollywood, CA 90027	t	public	2017-01-30 20:43:26	2017-02-12 00:43:44	2017-02-12 00:43:44
13	Gt_tUnf6T2E	The Truth About Dear White People: Racist Propaganda or Marketing Fail?	THURSDAY! These videos are my fave to make. Here goes nothing…\nWatch the Brand New Docuvlog!: https://youtu.be/SB3Se3dKBfo\nTheDeFrancoFam Vlog: https://youtu.be/_7K_Byz7Ah8\n————————————\nSTORIES:\n‘Dear White People’ Outrage:\nhttp://www.huffingtonpost.com/entry/netflix-boycott-dear-white-people_us_589cbb85e4b04061313c33eb\nhttp://www.revelist.com/tv/racists-boycott-netflix/6811\nhttp://www.telegraph.co.uk/tv/2017/02/09/dear-white-people-trailer-sparks-backlash-netflix-faces-claims/\nWatch The Movie: https://www.hulu.com/watch/850296\nhttps://www.amazon.com/White-People-Tyler-James-Williams/dp/B00OSQAP6G\n\nYouTube Sub Glitch:\nhttps://thenextweb.com/apps/2017/02/09/youtube-glitch-counter-channels/\nhttp://www.ibtimes.co.uk/youtube-finally-fixes-bug-causing-channels-lose-hundreds-subscribers-per-minute-1605713\n\nNBA 2K ELEAGUE:\nhttp://www.digitaltrends.com/gaming/nba-official-esports-league/\nhttp://www.espn.com/nba/story/_/id/18647863/nba-take-two-interactive-software-partnering-nba-2k-esports-league\nhttp://www.nba.com/article/2017/02/09/nba-video-game-company-launch-new-gaming-league-2018\n\nBaylor Sexual Assault Scandal:\nhttp://sportsday.dallasnews.com/college-sports/collegesports/2017/02/06/5-biggest-recent-revelations-baylors-sexual-assault-scandal\nhttp://www.tmz.com/2017/02/02/art-briles-alleged-text-messages/\nhttp://www.npr.org/2017/02/08/514172776/baylor-sanctioned-by-big-12-after-new-revelations-about-football-team-controvers\nhttp://www.dallasnews.com/news/baylor/2017/01/27/new-baylor-lawsuit-describes-show-em-good-time-culture-cites-52-rapes-football-players-4-years\nhttp://www.dallasnews.com/news/higher-education/2016/11/03/baylor-examining-sex-assault-claims-2011-2015\nhttp://www.foxnews.com/sports/2017/02/07/baylor-university-assistant-coach-fired-charged-with-soliciting-prostitute.html\n\n————————————\nFollow Me On Social:\nFACEBOOK: http://on.fb.me/mqpRW7\nTWITTER: http://Twitter.com/PhillyD\nINSTAGRAM: https://instagram.com/phillydefranco/\nSNAPCHAT: TheDeFrancoFam\nREDDIT: https://www.reddit.com/r/DeFranco\nITUNES: http://DeFrancoMistakes.com\nSOUNDCLOUD: http://letsmakemistakestogether.com\nGOOGLE PLAY: http://mistakeswithdefranco.com\n\nEdited by:\nJames Girardier - https://twitter.com/jamesgirardier\n\nProduced by:\nAmanda Morones - https://twitter.com/MandaOhDang\n\nMotion Graphics Artist\nBrian Borst - https://twitter.com/GrandpaHyde\n\nMailing Address:\nAttn: Philip DeFranco\n6433 Topanga Canyon Blvd #805\nCanoga Park, CA 91303	t	public	2017-02-09 22:30:03	2017-02-12 00:43:38	2017-02-12 00:43:38
14	KJC71dY13L8	I Need A Cat Dad	Happy Valentine's day!\nGHOST & STARS ▶ http://GhostAndStars\nHELP ME MAKE VIDEOS ▶ https://www.patreon.com/annaakana\n\nI need a cat dad - This super serious music video was created for Valentine's day so that whenever a potential cat dad (or mom!) pops up, you can send them this video with a "You, yes? ;)" and be as creepy as possible. \n\nbusiness\nAkanaActing@gmail.com\nTom Spriggs at The Coronel Group\n\nThanks Brad!\nhttp://youtube.com/BradGageComedy\n\nAudio mix by Jesse Cale\nhttps://www.youtube.com/user/TheOfficialMcSwagger\n\nshot and edited by Eric Lombart\nhttp://youtube.com/EricLombart\n\nmake up & hair by Melissa Tabares\nhttp://instagram.com/melissatabareshair\n\ngfx by Bethany Radloff\nhttp://youtube.com/BethBeRad	t	public	2017-02-09 21:06:12	2017-02-12 00:43:39	2017-02-12 00:43:39
15	qjYxXg4wZDg	My Epic Collab With Pewdiepie!!	I hope you enjoy my collab with Pewdiepie!\nHila is leaving me for this guy ► https://goo.gl/0yCVIX \n\nH3 Podcast is available at:\nITUNES ► https://goo.gl/desgTE\nGOOGLE PLAY MUSIC ►https://goo.gl/EnllKV\n\nTwitter......................►https://twitter.com/h3h3productions\nHila's Twitter............►https://twitter.com/hilakleinh3\nSpreadshirt..............►http://h3h3productions.spreadshirt.com\nInstagram................►http://instagram.com/h3h3productions\nHila's Instragram.....►https://www.instagram.com/kleinhila\nWebsite....................►http://h3h3productions.com\nSubreddit.................►http://reddit.com/r/h3h3productions\n\nTheme Song by MajorLeagueWobs:\nhttps://www.youtube.com/user/strangeholder	t	public	2017-02-08 20:03:44	2017-02-12 00:43:40	2017-02-12 00:43:40
16	hbXDLKFkjm0	Water on the Moon?	NEW CHANNEL! http://youtube.com/sciencium\n\nFor a long time we thought the Moon was completely dry, but it turns out there are actually three sources of lunar water.\nThanks to Google Making and Science for supporting the new channel! http://youtube.com/makingscience\n\nThanks to Patreon supporters:\nNathan Hansen, Donal Botkin, Tony Fadell, Zach Mueller, Ron Neal\n\nSupport Veritasium on Patreon: http://bit.ly/VePatreon\n\nReferences:\nGreat history of water on the moon: https://arxiv.org/pdf/1205.5597.pdf\n\nFilmed by Raquel Nuno\n\nMusic from http://epidemicsound.com "Serene Story 2"	t	public	2017-02-08 14:30:01	2017-02-12 00:43:40	2017-02-12 00:43:40
17	j26ax_NDeek	idubbbz visits tana mongeau	Thank you for viewing\n\nFor the full video visit: https://youtu.be/N8vaJaFCFYA\n__\n\nSUBSCRIBE ► https://www.youtube.com/channel/UC-tsNNJ3yIW98MtPH6PWFAQ?sub_confirmation=1\n\nMain Channel ► https://www.youtube.com/user/iDubbbzTV\nSecond Channel ► https://www.youtube.com/channel/UC-tsNNJ3yIW98MtPH6PWFAQ\nGaming Channel ► https://www.youtube.com/channel/UCVhfFXNY0z3-mbrTh1OYRXA\n\nWebsite ► http://www.idubbbz.com/\n\nInstagram ► https://instagram.com/idubbbz/\nTwitter ► https://twitter.com/Idubbbz\nFacebook ► http://www.facebook.com/IDubbbz\nTwitch ► http://www.twitch.tv/idubbbz\n_	t	public	2017-02-06 23:11:44	2017-02-12 00:43:41	2017-02-12 00:43:41
18	7jjTnvFAG0w	Weird Frat Guy Taking Shots	Wait for it...\n\n\nConnect with Cherdleys:\n► https://www.facebook.com/cherdleys\n► https://www.instagram.com/cherdleys\n\nSupport Cherdleys ► https://www.patreon.com/cherdleys\nMerchandise► https://www.cherdleys.com\nSecond Channel ► http://bit.ly/2i6SuRX	t	public	2017-02-06 20:13:17	2017-02-12 00:43:41	2017-02-12 00:43:41
19	uqWUfTsEEOE	MY GIRL IS LEAVING ME FOR THIS GUY	Connor Murphy will steal your girl in seconds\nMaking Music with Post Malone ► https://goo.gl/gnpe3H\n\nH3 Podcast is available at:\n\nITUNES ► https://goo.gl/desgTE\nGOOGLE PLAY MUSIC ►https://goo.gl/EnllKV\n\nTwitter......................►https://twitter.com/h3h3productions\nHila's Twitter............►https://twitter.com/hilakleinh3\nSpreadshirt..............►http://h3h3productions.spreadshirt.com\nInstagram................►http://instagram.com/h3h3productions\nHila's Instragram.....►https://www.instagram.com/kleinhila\nWebsite....................►http://h3h3productions.com\nSubreddit.................►http://reddit.com/r/h3h3productions\n\nSource video:\nhttps://www.youtube.com/channel/UCwNPPl_oX8oUtKVMLxL13jg\n\nMusic:\n\n"Sweet as Honey" by Topher Mohr and Alex Elena\n\nBig Car Theft by Audionautix is licensed under a Creative Commons Attribution license (https://creativecommons.org/licenses/by/4.0/)\nArtist: http://audionautix.com/	t	public	2017-02-04 23:06:33	2017-02-12 00:43:42	2017-02-12 00:43:42
20	IjpvhYpLVMo	Cutest Dog in the World | Mockumentary	Please Subscribe ▶ http://bit.ly/1FmhXhC \nExtras & Vlogs ▶ https://www.youtube.com/user/LAHWFextra\nFollow My Twitter ▶ http://www.twitter.com/lahwf\nFollow My Instagram ▶ http://www.instagram.com/mrhales109\nLike the Facebook page! ▶ http://www.facebook.com/lahwf\nCreep on my snaps! ▶ http://snpcht.me/Mrhales100\n\nBonnie's Instagram ▶ https://www.instagram.com/bonnie_babies/\n\nLuke's Channel ▶ https://www.youtube.com/user/fLUKEy1989\nAryia's Channel ▶ https://www.youtube.com/user/SimpleSexyStupid\n\nSong:\nGymnopedie No 1 by Kevin MacLeod is licensed under a Creative Commons Attribution license (https://creativecommons.org/licenses/by/4.0/)\nSource: http://incompetech.com/music/royalty-free/index.html?isrc=USUAN1100787\nArtist: http://incompetech.com/\n\nSend Fan Mail to:\n5419 Hollywood Blvd, Ste. C825\nHollywood, CA 90027	t	public	2017-02-04 02:47:20	2017-02-12 00:43:42	2017-02-12 00:43:42
21	wDc2aDH3zMM	Best Stuffed Mushrooms Recipe	This stuffed mushrooms recipe makes a great appetizer and party dish --and it's pretty easy to make a bunch of these stuffed mushrooms at one time. Stuffed mushrooms are often filled with freshly grated Parmesan, garlic, and herbs, but it's a super versatile recipe...so experiment with your favorite flavors; I personally like a blue cheese and hot sauce combo thrown into the filling, and chopped nuts and toasted breadcrumbs can add a much needed crunchiness.\nA printable copy of this stuffed mushrooms recipe and more tips on how to prepare it can be found at  \nhttp://www.myfoodchannel.com/stuffed-mushrooms-recipe/\nGive this stuffed mushroom recipe a try and let me know what you think, and for more recipes check out the Chef Buck playlist:  \nhttp://www.youtube.com/playlist?list=PL2EFBD7E8FE2BB552 \nand to print all recipes visit my website at http://www.myfoodchannel.com/\n\nConnect with this media to catch all of my videos...thanks:\nMY OTHER YOUTUBE CHANNEL:  http://www.youtube.com/user/buckredbuck\nFACEBOOK \nhttp://www.facebook.com/buckredbuck\nTWITTER \nhttps://twitter.com/buckredbuck\nINSTAGRAM\nhttps://www.instagram.com/buckredbuck/\nGOOGLE+  \nhttp://plus.google.com/u/0/109193261972985167770/posts\nPRINT RECIPES AT MY WEBSITE:  \nhttp://www.myfoodchannel.com/\nRECIPE PLAYLISTS:  http://www.youtube.com/user/FromUnderTheRock\n\nWhat You Need for This Stuffed Mushrooms Recipe \n \n12-15 MUSHROOMS\n½ cup PANKO BREADCRUMBs\n1 TBSP BUTTER\nsome OLIVE OIL\nfilling mixture like...\n½ cup PARMESAN CHEESE\n½ cup BLUE CHEESE\n4-6 cloves GARLIC (finely chopped)\n½ cup PARSLEY (chopped)\n½ cup CASHEWS (chopped)\nsome HOT SAUCE\nSALT and PEPPER (to taste)\n...but fillings are optional\n\nHow To Make Stuffed Mushrooms\n\nBuy whole mushrooms that are uniform in size; I buy mushrooms that are not already pre-packaged, so I can select the best.\nChoose mushrooms that are firm and dry and store in the fridge in a paper sack until you are ready to use them.\nBefore using, clean mushrooms with a damp towel. \nremove the stems and use a knife or spoon to open the mushroom center and create more room for the stuffing.\nTake your time preparing the mushroom caps to avoid splitting them. \nI often set aside some of the stems to use in other recipes, while reserving some to chop and mix with the stuffing.\nCoat the mushroom caps lightly with olive oil and set aside.\nIn a bowl, combine some of the chopped stems and whatever fillings you desire.\nI often use an egg, minced garlic, freshly grated parmesan, and fresh chopped parsley with my filling, but\nthe variations are endless.\nBlue cheese is fantastic in stuffed mushrooms.\nFor added crunchiness, nuts are a great idea. I find that chopped cashews work very well.\nI'll often add ingredients to the stuffing mix as I stuff the mushrooms, which makes for a nice variety of flavors.\nSpoon the filling into the mushroom cap.\nIn a skillet, melt butter and add panko breadcrumbs. The breadcrumbs will soak up the butter and flavor.\nTop stuffed mushrooms with panko breadcrumbs and place on a rack over a baking sheet.\nPlace stuffed mushrooms in an oven pre-heated to 375 degrees F. and bake for approximately 30 minutes or until\nthe breadcrumb topping is nicely toasted.\nServe warm.\n\nGive this stuffed mushrooms recipe a try, and let me know what you think, and bon appétit!	t	public	2017-02-03 15:32:26	2017-02-12 00:43:43	2017-02-12 00:43:43
22	RVMZxH1TIIQ	Why Earth Is A Prison and How To Escape It	We are trapped on earth. Controlled by an ancient debt to the universe...\n\nLearn more about Ariane 6: http://www.airbusafran-launchers.com/en/universe/ariane-6-en/\n\nSupport us on Patreon so we can make more videos (and get cool stuff in return): https://www.patreon.com/Kurzgesagt?ty=h\n\nKurzgesagt merch here:  http://bit.ly/1P1hQIH\n\nGet the music of the video here: \n\nSoundcloud: http://bit.ly/2kqsiGb\nBandcamp: http://bit.ly/2kryP3c\nFacebook: https://www.facebook.com/epic-mountain-music\n \nTHANKS A LOT TO OUR LOVELY PATRONS FOR SUPPORTING US:\n\nJohn Wendeborn, Haan, Doktor Andy, Josh Gabbatiss, Peter Egger, Rick Lawrence, Eric Gao, 주영정, Jeff Threatt, Lars v., BurmansHealthShop, Ian White, Coty Rosenblath, SoraHavok, Andrew Berscheid, Jakub Zych, Eddie Han, Bubble Our Travel, Anton Ukhanev, Jan Pac, Mike, Martin Harding, Louis, Thomas G. Digranes, Todd, Mishal Alsuwyan, Liam Swann, Timothee Groleau, John Cido, Nicholas Bethencourt, Jeremy B Costella, Matthew Clarkson, Anna Chiara Brunetti, ValCab33, Neno Ganchev, Matt Saville, Klaas Pieter Annema, Peter Spalthoff, Andrew Campbell, Mads Bertheussen, Josué Barbosa dos Santos, Corey Hinds, Julian Fiander, BillDoor, Garrett Blackmon, Leeann Toland, Marshall Dow, Horia Constantin, Austin Hooper, Thomas E. Lee, Sylvain Milan, Jake Lee Kennedy, teddy zhang, Albinomaur, Casey Schad, Pearce Bergh, Dan Werdnly, Richard Patenaude, Moch Faisal Rasid, Antoine Dymond, James Hyde, Jonathan Verlohren, H.L.Hammons, Mikael Hannikainen, Kevin Douglass, Erik Onnen, Thiago Torres, Bryan Benninghoff, Frank Tuffner, Kevan Rynning, Aschwin Berkhout, Daniel Neilson, Damon Weil, Wesley Byrd, Bryan Andrade, Sergei Gaponov, Torodes, Ori Haski, Adam, Pavel Ševčík, Will Schmid, Alan Tran, Raoul Verhaegen, Fabercastel, Max, Youlia Hadzhidimova, Tristan Waddington, Bror Ronning, Santiago Campellone, Harjeet Taggar, James Horrocks, Brandon Bizzarro, Michel Vaillancourt, RHall, Brian David Henderson, Vikas Dhiman, Jack, Tomáš Miškov, Derral Gerken, Anthony, Vadim Golub, Fervidus, Justin Ritchie, Nicolas Dolgin, Harry, Andrew Miner, Rohan Dowd, Jesse Versluys, Juraj Trizna, André Léger, Peter Reynolds, Tom Handcock, Shaquille D. Johnson, HUISHI ZHANG, Robert S Peschel, Chris Bowley, Thomasz Kolosowski, Hogtree Octovish, Donovan Shickley, Bruce Hill, William Johnson, Ángel Garcia Casado, Riikka S, Daniel Moul, Daniel John, Anirudh Joshi, Robert, Iman, Jannis Kaiser, Andrew Bennett, Mariann Nagy, Daniel Kömpf, Philip Zapfel, Vince Gabor\n\nHelp us caption & translate this video!\n\nhttp://www.youtube.com/timedtext_cs_panel?c=UCsXVk37bltHxD1rDPwtNM8Q&tab=2\n\nOverpopulation – The Human Explosion Explained	t	public	2017-02-01 13:22:31	2017-02-12 00:43:44	2017-02-12 00:43:44
24	Q8ccXzM3x8A	The Case for String Theory - Sixty Symbols	Dr Tony Padilla  on why he thinks there's a compelling case for String Theory... This is one of our occasional longer-form interviews.\nLonger interviews with Ed Copeland: http://bit.ly/CopelandGoesLong\nOur visit to CERN: http://bit.ly/LHCvideos\nObjectivity: http://bit.ly/Objectivity\n\nDr Padilla is a cosmologist at the University of Nottingham - https://www.nottingham.ac.uk/physics/people/antonio.padilla\n\nVisit our website at http://www.sixtysymbols.com/\nWe're on Facebook at http://www.facebook.com/sixtysymbols\nAnd Twitter at http://twitter.com/sixtysymbols\nThis project features scientists from The University of Nottingham\nhttp://bit.ly/NottsPhysics\n\nPatreon: https://www.patreon.com/sixtysymbols\n\nSixty Symbols videos by Brady Haran\nhttp://www.bradyharanblog.com\n\nEmail list: http://eepurl.com/YdjL9\n\nExtra videos and images via CERN and ESO.\nMusic via Harri at freesound.org	t	public	2017-01-30 14:30:33	2017-02-12 00:43:45	2017-02-12 00:43:45
25	keYYiuOJdrE	The Master: How Scientology Works	Get a free 30 day trial of Audible here: http://www.audible.com/nerdwriter\n\nI WAS NOMINATED FOR A SHORTY! VOTE FOR ME HERE: http://shortyawards.com/9th/theenerdwriter\nNERDWRITER T-SHIRTS: https://store.dftba.com/products/the-nerdwriter-shirt\n\n\nSOURCES AND FURTHER READING:\n\nhttps://luckyottershaven.com/2017/01/15/why-scientology-auditing-is-not-at-all-like-traditional-psychotherapy-part-2/\n\nhttps://luckyottershaven.com/2017/01/14/why-scientology-auditing-is-not-at-all-like-traditional-psychotherapy-part-1/\n\nhttps://www.youtube.com/watch?v=dbmPVq6e2aA\n\nhttps://www.ncbi.nlm.nih.gov/pmc/articles/PMC3856510/	t	public	2017-01-26 15:01:31	2017-02-12 00:43:45	2017-02-12 00:43:45
26	9-5TSxd0ep0	Arcade Fire - Rebellion (Lies): Live at Earls Court	Arcade Fire : The Reflektor Tapes / Live At Earls Court released on DVD & BluRay on 27 January 2017. \n\nDVD - http://smarturl.it/REFLEKTORTAPESDVD\nBlu Ray - http://smarturl.it/REFLEKTORTAPESBR\n\nMusic video by Arcade Fire performing Rebellion (Lies). (C) 2016 Arcade Fire Music, LLC, exclusively licensed to Eagle Rock Entertainment Ltd.\n\nhttp://vevo.ly/ZPzbTY	t	public	2017-01-26 11:00:02	2017-02-12 00:43:46	2017-02-12 00:43:46
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
5	5	2	relevantTopicId
6	6	2	relevantTopicId
7	7	4	topicId
8	8	4	relevantTopicId
9	9	4	relevantTopicId
10	10	5	topicId
11	11	5	topicId
12	12	5	topicId
13	13	5	relevantTopicId
14	14	6	topicId
15	15	6	relevantTopicId
16	16	6	relevantTopicId
17	17	6	relevantTopicId
18	18	6	relevantTopicId
19	19	6	relevantTopicId
20	20	6	relevantTopicId
21	21	7	relevantTopicId
22	22	7	relevantTopicId
23	23	7	relevantTopicId
24	24	7	relevantTopicId
25	25	7	relevantTopicId
26	26	8	relevantTopicId
27	27	8	relevantTopicId
28	28	8	relevantTopicId
29	29	8	relevantTopicId
30	30	8	relevantTopicId
31	31	8	relevantTopicId
32	32	8	relevantTopicId
33	33	8	relevantTopicId
34	34	9	topicId
35	35	9	topicId
36	36	9	relevantTopicId
37	37	9	relevantTopicId
38	38	9	relevantTopicId
39	39	9	relevantTopicId
40	40	9	relevantTopicId
41	41	11	topicId
42	42	11	relevantTopicId
43	43	11	relevantTopicId
44	44	12	topicId
45	45	12	relevantTopicId
46	46	12	relevantTopicId
47	47	12	relevantTopicId
48	48	12	relevantTopicId
49	49	13	topicId
50	50	13	topicId
51	43	13	relevantTopicId
52	51	13	relevantTopicId
53	52	13	relevantTopicId
54	53	14	relevantTopicId
55	54	14	relevantTopicId
56	55	14	relevantTopicId
57	56	15	topicId
58	57	16	relevantTopicId
59	58	16	relevantTopicId
60	59	16	relevantTopicId
61	60	16	relevantTopicId
62	43	17	relevantTopicId
63	43	18	relevantTopicId
64	61	18	relevantTopicId
65	43	19	relevantTopicId
66	61	19	relevantTopicId
67	62	20	topicId
68	24	20	relevantTopicId
69	53	20	relevantTopicId
70	62	20	relevantTopicId
71	63	20	relevantTopicId
72	64	20	relevantTopicId
73	65	20	relevantTopicId
74	66	20	relevantTopicId
75	67	20	relevantTopicId
76	68	20	relevantTopicId
77	69	21	topicId
78	70	21	topicId
79	70	21	relevantTopicId
80	71	21	relevantTopicId
81	72	21	relevantTopicId
82	73	21	relevantTopicId
83	74	21	relevantTopicId
84	75	21	relevantTopicId
85	76	21	relevantTopicId
86	77	22	relevantTopicId
87	78	22	relevantTopicId
88	40	23	topicId
89	38	23	relevantTopicId
90	40	23	relevantTopicId
91	79	24	topicId
92	80	24	relevantTopicId
93	81	24	relevantTopicId
94	82	25	topicId
95	38	25	relevantTopicId
96	83	25	relevantTopicId
97	84	25	relevantTopicId
98	85	26	topicId
99	86	26	topicId
100	18	26	relevantTopicId
101	19	26	relevantTopicId
102	87	26	relevantTopicId
103	88	26	relevantTopicId
104	89	26	relevantTopicId
105	90	26	relevantTopicId
106	91	26	relevantTopicId
107	92	26	relevantTopicId
\.


--
-- Name: videos_topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('videos_topics_id_seq', 107, true);


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

