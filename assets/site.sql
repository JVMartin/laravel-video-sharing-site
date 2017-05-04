--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.5.6

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
ALTER TABLE ONLY public.comments_votes DROP CONSTRAINT comments_votes_user_id_foreign;
ALTER TABLE ONLY public.comments_votes DROP CONSTRAINT comments_votes_comment_id_foreign;
ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_user_id_foreign;
ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_submission_id_foreign;
ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_parent_id_foreign;
DROP INDEX public.videos_topics_video_id_index;
DROP INDEX public.videos_topics_topic_id_index;
DROP INDEX public.verifications_user_id_index;
DROP INDEX public.verifications_token_index;
DROP INDEX public.tagged_taggable_type_taggable_id_index;
DROP INDEX public.password_resets_token_index;
DROP INDEX public.password_resets_email_index;
DROP INDEX public.comments_votes_user_id_index;
DROP INDEX public.comments_votes_comment_id_index;
DROP INDEX public.comments_user_id_index;
DROP INDEX public.comments_submission_id_index;
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
ALTER TABLE ONLY public.comments_votes DROP CONSTRAINT comments_votes_pkey;
ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_pkey;
ALTER TABLE public.videos_topics ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.videos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.topics ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.tags ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.tagged ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.submissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.comments_votes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.comments ALTER COLUMN id DROP DEFAULT;
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
DROP SEQUENCE public.comments_votes_id_seq;
DROP TABLE public.comments_votes;
DROP SEQUENCE public.comments_id_seq;
DROP TABLE public.comments;
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
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE comments (
    id integer NOT NULL,
    submission_id integer NOT NULL,
    parent_id integer,
    user_id integer,
    score integer DEFAULT 1 NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    contents text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE comments OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comments_id_seq OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: comments_votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE comments_votes (
    id integer NOT NULL,
    comment_id integer NOT NULL,
    user_id integer,
    up boolean DEFAULT false NOT NULL,
    down boolean DEFAULT false NOT NULL
);


ALTER TABLE comments_votes OWNER TO postgres;

--
-- Name: comments_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE comments_votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comments_votes_id_seq OWNER TO postgres;

--
-- Name: comments_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE comments_votes_id_seq OWNED BY comments_votes.id;


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
    avatar character varying(255),
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

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comments_votes ALTER COLUMN id SET DEFAULT nextval('comments_votes_id_seq'::regclass);


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
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comments (id, submission_id, parent_id, user_id, score, deleted, contents, created_at, updated_at) FROM stdin;
\.


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comments_id_seq', 1, false);


--
-- Data for Name: comments_votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comments_votes (id, comment_id, user_id, up, down) FROM stdin;
\.


--
-- Name: comments_votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('comments_votes_id_seq', 1, false);


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
8	2017_02_14_035746_create_comments_table	1
\.


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('migrations_id_seq', 8, true);


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY password_resets (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY submissions (id, video_id, user_id, title, slug, description, created_at, updated_at) FROM stdin;
1	1	2	Fuga porro qui molestiae veritatis inventore ducimus repellat.	fuga-porro-qui-molestiae-veritatis-inventore-ducimus-repellat	Cumque explicabo facere omnis soluta sunt. Voluptates et maiores velit sed non. Et fugit laboriosam adipisci qui soluta nobis laborum ut. At qui enim unde exercitationem hic numquam. Repudiandae deserunt in rerum labore mollitia laborum inventore.\n\nIpsa numquam quaerat placeat iusto quia vero. Neque saepe perspiciatis dignissimos placeat. Est unde temporibus ad fuga tempora consequatur. A qui sed doloremque minima et dolor impedit.	2017-05-04 20:54:46	2017-05-04 20:54:46
2	2	1	Magni sit neque ut nihil nisi.	magni-sit-neque-ut-nihil-nisi	Tempora eligendi asperiores at eius. Rerum sit quisquam ut sed maiores. At velit enim ipsam rem et. Voluptas repellendus facere voluptates doloremque vitae.\n\nDicta doloremque necessitatibus quo esse qui quam. Error non dolores omnis. Beatae mollitia aliquam recusandae molestias. Qui exercitationem rerum et qui possimus omnis.	2017-05-04 20:54:46	2017-05-04 20:54:46
3	3	2	Maxime dolores et commodi nostrum.	maxime-dolores-et-commodi-nostrum	Natus magnam hic officiis exercitationem. Eius id esse voluptatem eos. Nam facilis repellat sequi voluptatum. Voluptatem vel veniam molestias consequatur.\n\nQuaerat veniam reiciendis molestiae eos dolor. Excepturi dolorem et et minima. Aut et distinctio ratione qui. Omnis consequatur explicabo dolorem temporibus.	2017-05-04 20:54:46	2017-05-04 20:54:46
4	4	1	Enim occaecati fugit et sed aut in voluptas.	enim-occaecati-fugit-et-sed-aut-in-voluptas	Reprehenderit aut beatae unde dolorem odio libero sit. Saepe sed vel explicabo inventore voluptas vero consequuntur ratione. Pariatur ipsa porro quisquam sed animi blanditiis fugiat beatae. Facere dolore omnis quam. Dolore rerum nobis quas dolorem natus.\n\nQuas ullam et aut nisi voluptatem. Facilis necessitatibus magnam culpa pariatur.	2017-05-04 20:54:46	2017-05-04 20:54:46
5	5	2	Enim velit quasi dolores et sequi.	enim-velit-quasi-dolores-et-sequi	Ad velit ad perferendis similique nihil esse. Sunt qui velit unde distinctio nesciunt voluptas deleniti dolorem. Delectus fugiat qui blanditiis voluptas. Molestiae et dicta est excepturi qui nemo.\n\nAt eos iusto dicta eaque perspiciatis rerum necessitatibus. Voluptatem possimus hic doloribus rerum. Facere dolore ducimus aut eos quia iusto dolores. Et veritatis officia voluptatibus consectetur aut.	2017-05-04 20:54:46	2017-05-04 20:54:46
6	6	1	Ut tempore ex repellendus voluptatum.	ut-tempore-ex-repellendus-voluptatum	Temporibus ea aliquam qui delectus inventore qui. Magni dolore enim corporis eos ullam.\n\nDoloremque ut esse harum ea excepturi. Ut exercitationem expedita earum tempora non recusandae. Voluptatibus fuga est distinctio deserunt quo odit. Totam esse dolor pariatur molestias voluptates ut eum.	2017-05-04 20:54:46	2017-05-04 20:54:46
7	7	2	Est minima eveniet molestiae.	est-minima-eveniet-molestiae	Laboriosam aut tempora ipsam ratione quidem sapiente. Dolores aliquid tenetur delectus. Cumque aspernatur sint dignissimos beatae animi.\n\nSint laboriosam beatae molestias repellendus provident est. Voluptatem sit non tempora sed.	2017-05-04 20:54:46	2017-05-04 20:54:46
8	8	1	Aut in tempore qui autem corporis sit.	aut-in-tempore-qui-autem-corporis-sit	Nulla temporibus libero non ut sequi et ipsa doloremque. Velit cumque nemo quia accusamus perferendis ipsa. Soluta rerum dicta porro maxime rerum. Repellat ut autem eum nobis.\n\nSunt quia consequatur et sed quis sed sunt. Rerum autem ipsum minus est. Itaque maxime dolorem qui dignissimos debitis porro. Molestiae modi culpa dolor sint facere dignissimos ipsam. Facere eius labore sit culpa et.	2017-05-04 20:54:46	2017-05-04 20:54:46
9	9	2	Accusantium consequatur itaque omnis.	accusantium-consequatur-itaque-omnis	Sint quia facilis impedit. Voluptatibus sapiente ea nihil est aut provident. Est maiores est quia. Laborum aut accusantium et et quia a.\n\nPariatur odio necessitatibus necessitatibus officia et illo accusamus mollitia. Qui sequi reprehenderit laudantium.	2017-05-04 20:54:46	2017-05-04 20:54:46
10	10	1	Voluptatem dolorem et a harum.	voluptatem-dolorem-et-a-harum	Odit sed non perferendis in voluptas perspiciatis cumque. Atque qui quaerat eum quaerat autem eius architecto. Soluta ipsum omnis qui itaque. Eos iure deleniti et ipsum impedit asperiores.\n\nIpsam asperiores laborum aut perferendis. Totam expedita quis quia omnis consequuntur neque blanditiis. Magni ipsa consequatur iste assumenda voluptatibus.	2017-05-04 20:54:47	2017-05-04 20:54:47
11	11	2	Rerum qui quisquam autem.	rerum-qui-quisquam-autem	Doloremque adipisci numquam inventore nemo. Quibusdam quia inventore labore aliquam minima. Reiciendis expedita perferendis tempora rerum. Incidunt velit voluptatibus voluptas aut maiores possimus.\n\nReprehenderit suscipit error qui magnam quaerat cumque. Quo voluptate aut sit est veritatis aliquam quia. Dolorem consequatur odio voluptatem ut beatae in occaecati.	2017-05-04 20:54:47	2017-05-04 20:54:47
12	12	1	Fugiat a architecto ut ut enim dolor ex facilis.	fugiat-a-architecto-ut-ut-enim-dolor-ex-facilis	Molestiae vitae ab nihil temporibus. In hic est qui atque beatae non minima. Facilis quas debitis dolor laudantium. Consequuntur vel facilis ab non iusto ipsa.\n\nAccusamus vero sit ipsum voluptatem nobis et. Quae rem ut voluptatibus praesentium. Eum temporibus asperiores non et nobis. Dolores sit expedita omnis.	2017-05-04 20:54:47	2017-05-04 20:54:47
13	23	2	Est molestias odit et.	est-molestias-odit-et	Odit quia minima omnis. Incidunt non est temporibus voluptatibus. Quia qui eligendi ut et error aut unde.\n\nEt dolorem tenetur ut autem sunt earum et. Quasi dignissimos sit rem eaque.	2017-05-04 20:54:47	2017-05-04 20:54:47
14	13	1	Neque expedita distinctio optio modi dolorem pariatur.	neque-expedita-distinctio-optio-modi-dolorem-pariatur	Voluptates repellat ipsam tempore veritatis deserunt perferendis qui eum. Voluptatum molestiae qui eligendi voluptatem laborum aspernatur voluptas dolores. Earum amet eum possimus culpa ut similique. Voluptatem voluptas deserunt nobis sint sunt sed quam.\n\nCulpa eos rerum et nihil saepe distinctio modi non. Ut commodi in praesentium est distinctio et optio. Odio sequi blanditiis et quod eligendi eum officia blanditiis. Aut ipsam commodi voluptas ipsum.	2017-05-04 20:54:47	2017-05-04 20:54:47
15	14	2	Exercitationem sed pariatur temporibus nihil.	exercitationem-sed-pariatur-temporibus-nihil	Earum consectetur et rerum. Est voluptas esse qui iure.\n\nQui itaque impedit inventore et voluptas eos itaque eos. Quis nihil reprehenderit suscipit. Rerum et perferendis deleniti autem doloribus expedita recusandae enim.	2017-05-04 20:54:47	2017-05-04 20:54:47
16	15	1	Placeat et mollitia tempora illum repudiandae numquam illo.	placeat-et-mollitia-tempora-illum-repudiandae-numquam-illo	Omnis adipisci at dolorem repellendus. Ipsam eos maiores facere ratione qui architecto labore. Reprehenderit fuga iste fugiat ut nemo ut.\n\nAtque nisi amet aliquam aut voluptatem et sint. Doloremque asperiores nam alias exercitationem minus autem et. Pariatur nostrum distinctio quia animi.	2017-05-04 20:54:47	2017-05-04 20:54:47
17	16	2	Provident corporis rerum aliquid repudiandae qui molestias.	provident-corporis-rerum-aliquid-repudiandae-qui-molestias	Omnis excepturi sed sit eos. Nemo repellat rem reprehenderit quos voluptatem.\n\nExpedita et illo aut velit est labore consequatur possimus. Repellendus et voluptas deleniti et et laborum. Impedit qui suscipit voluptate. Sunt ut voluptatum iusto autem ea ipsa consectetur. Cum illum deleniti quisquam ea.	2017-05-04 20:54:47	2017-05-04 20:54:47
18	17	1	Veniam repellendus totam enim minus.	veniam-repellendus-totam-enim-minus	Facere laudantium aliquam minima ipsam est vero nostrum. Recusandae voluptas alias error aut dignissimos. Minus et eum reiciendis repellendus. Alias quo quidem nesciunt nobis.\n\nA quae voluptatem aspernatur consequatur provident vel laboriosam. Repellendus officia rerum non officiis. Id est vero suscipit cum libero veniam fugit.	2017-05-04 20:54:47	2017-05-04 20:54:47
19	18	2	Tempora et ut repudiandae voluptatem laborum eos.	tempora-et-ut-repudiandae-voluptatem-laborum-eos	Dolorem repellat ut unde odio. Ab aperiam sequi modi ea. Numquam non sit aliquid magnam veniam vel. Voluptatem voluptates dolorem et ad.\n\nIllum voluptatem porro voluptas quis quo. Et ut maiores quisquam et aut aut doloremque. Voluptas et dolorem iusto veniam est.	2017-05-04 20:54:47	2017-05-04 20:54:47
20	19	1	Consequatur sapiente vel fuga.	consequatur-sapiente-vel-fuga	Consequatur aut ad ducimus aut voluptas. Aut et impedit fuga totam id dolorem. Rerum voluptatem molestiae et perferendis libero labore tempore voluptatem.\n\nCommodi placeat facilis aliquam sed iusto quas doloribus. Hic veniam rerum voluptatem et at ut reprehenderit. Quo ipsa est magnam sunt. Rerum quia deleniti tempora sed ad amet.	2017-05-04 20:54:47	2017-05-04 20:54:47
21	20	2	Quibusdam et ut deleniti id.	quibusdam-et-ut-deleniti-id	Dolores molestiae quod voluptatibus itaque cumque quia illo aut. Cum quidem ullam enim quod id qui veniam.\n\nAliquam perspiciatis voluptas voluptates aut hic quos praesentium. Voluptatem voluptates est quae. Vel possimus quidem et quod. Vero iste molestiae omnis animi in nam quia.	2017-05-04 20:54:48	2017-05-04 20:54:48
22	21	1	Accusantium maxime dicta perspiciatis et ut sequi.	accusantium-maxime-dicta-perspiciatis-et-ut-sequi	Nobis molestias soluta dolorem quaerat. Maxime error eos blanditiis nisi a. Eos non tempore consequatur eum quae soluta quos. Corrupti autem explicabo in architecto totam eum velit corrupti.\n\nMaiores ab alias nulla eveniet. Voluptas ipsam recusandae est. Repudiandae consequatur recusandae voluptatum eum et. Qui sed quia sed tenetur aliquam.	2017-05-04 20:54:48	2017-05-04 20:54:48
23	22	2	Sunt placeat tenetur tempora debitis voluptatem.	sunt-placeat-tenetur-tempora-debitis-voluptatem	Accusantium voluptatem consequatur explicabo ex animi. Optio voluptatum facilis reiciendis ea autem debitis ut. Similique perferendis est voluptatum soluta in quo ipsum quibusdam. Magnam aperiam et nesciunt occaecati.\n\nSit sint ipsa et amet qui porro quo. Quibusdam voluptatem ea eligendi tempora optio. Id reiciendis eaque delectus.	2017-05-04 20:54:48	2017-05-04 20:54:48
24	24	1	Odio laborum expedita sequi quidem ut possimus unde sit.	odio-laborum-expedita-sequi-quidem-ut-possimus-unde-sit	Facilis totam mollitia enim minus aut harum praesentium omnis. Et non nostrum veniam eos. Fuga ipsa nobis quaerat velit eius quia qui.\n\nRerum accusamus et ullam doloremque consequatur repellat quidem. Dicta sint et quasi rerum libero et. Quia atque pariatur quae voluptatibus placeat occaecati earum.	2017-05-04 20:54:48	2017-05-04 20:54:48
25	25	2	Accusantium corporis aut eaque ratione qui accusamus expedita praesentium.	accusantium-corporis-aut-eaque-ratione-qui-accusamus-expedita-praesentium	Quam sunt neque consequatur dolorem. Officiis dolor corrupti aliquam saepe suscipit. Iure reprehenderit facere doloribus sed est quod asperiores.\n\nDistinctio iste illo inventore laboriosam rem veritatis tenetur. Quo et voluptatem nostrum voluptates possimus amet dolore est. Blanditiis repellendus consequatur similique impedit. Laboriosam ducimus non ducimus omnis aut.	2017-05-04 20:54:48	2017-05-04 20:54:48
26	26	1	Fuga rerum deserunt ut voluptas nisi at aliquid.	fuga-rerum-deserunt-ut-voluptas-nisi-at-aliquid	Quis quis sit reprehenderit deserunt quia aut quibusdam. Vitae molestias eum dolor eius quae fugit. Facere ea voluptatem rerum et et impedit voluptatem.\n\nOfficia amet vel doloribus a ex. Omnis molestias quia veritatis omnis consequatur impedit vel. Deserunt qui autem labore quaerat aut eum nobis. Aperiam in ea rem in sunt sint omnis laborum.	2017-05-04 20:54:48	2017-05-04 20:54:48
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
82	App\\Models\\Video	6	79
83	App\\Models\\Video	6	80
84	App\\Models\\Video	6	81
85	App\\Models\\Video	6	82
86	App\\Models\\Video	6	83
87	App\\Models\\Video	6	84
88	App\\Models\\Video	6	85
89	App\\Models\\Video	6	86
90	App\\Models\\Video	6	87
91	App\\Models\\Video	6	88
92	App\\Models\\Video	6	89
93	App\\Models\\Video	6	90
94	App\\Models\\Video	6	91
95	App\\Models\\Video	6	92
96	App\\Models\\Video	6	93
97	App\\Models\\Video	6	94
98	App\\Models\\Video	6	95
99	App\\Models\\Video	6	96
100	App\\Models\\Video	6	97
101	App\\Models\\Video	7	98
102	App\\Models\\Video	7	99
103	App\\Models\\Video	7	100
104	App\\Models\\Video	7	101
105	App\\Models\\Video	7	102
106	App\\Models\\Video	7	103
107	App\\Models\\Video	7	104
108	App\\Models\\Video	7	105
109	App\\Models\\Video	7	106
110	App\\Models\\Video	7	107
111	App\\Models\\Video	7	108
112	App\\Models\\Video	7	109
113	App\\Models\\Video	7	110
114	App\\Models\\Video	7	111
115	App\\Models\\Video	7	112
116	App\\Models\\Video	8	113
117	App\\Models\\Video	8	114
118	App\\Models\\Video	8	115
119	App\\Models\\Video	8	116
120	App\\Models\\Video	8	117
121	App\\Models\\Video	8	118
122	App\\Models\\Video	8	119
123	App\\Models\\Video	8	120
124	App\\Models\\Video	8	121
125	App\\Models\\Video	8	122
126	App\\Models\\Video	8	123
127	App\\Models\\Video	8	124
128	App\\Models\\Video	8	125
129	App\\Models\\Video	8	126
130	App\\Models\\Video	8	127
131	App\\Models\\Video	8	128
132	App\\Models\\Video	8	129
133	App\\Models\\Video	9	130
134	App\\Models\\Video	9	131
135	App\\Models\\Video	9	132
136	App\\Models\\Video	9	133
137	App\\Models\\Video	9	134
138	App\\Models\\Video	9	135
139	App\\Models\\Video	9	136
140	App\\Models\\Video	9	137
141	App\\Models\\Video	9	138
142	App\\Models\\Video	9	139
143	App\\Models\\Video	9	140
144	App\\Models\\Video	9	141
145	App\\Models\\Video	9	142
146	App\\Models\\Video	9	143
147	App\\Models\\Video	9	144
148	App\\Models\\Video	9	145
149	App\\Models\\Video	10	98
150	App\\Models\\Video	10	100
151	App\\Models\\Video	10	146
152	App\\Models\\Video	10	147
153	App\\Models\\Video	10	148
154	App\\Models\\Video	10	101
155	App\\Models\\Video	10	105
156	App\\Models\\Video	10	149
157	App\\Models\\Video	10	150
158	App\\Models\\Video	10	151
159	App\\Models\\Video	11	152
160	App\\Models\\Video	11	102
161	App\\Models\\Video	11	101
162	App\\Models\\Video	11	153
163	App\\Models\\Video	12	154
164	App\\Models\\Video	12	155
165	App\\Models\\Video	12	156
166	App\\Models\\Video	12	157
167	App\\Models\\Video	12	158
168	App\\Models\\Video	12	159
169	App\\Models\\Video	12	160
170	App\\Models\\Video	12	161
171	App\\Models\\Video	12	162
172	App\\Models\\Video	12	163
173	App\\Models\\Video	12	164
174	App\\Models\\Video	13	165
175	App\\Models\\Video	13	166
176	App\\Models\\Video	13	167
177	App\\Models\\Video	13	168
178	App\\Models\\Video	13	169
179	App\\Models\\Video	13	170
180	App\\Models\\Video	13	171
181	App\\Models\\Video	13	172
182	App\\Models\\Video	13	173
183	App\\Models\\Video	13	174
184	App\\Models\\Video	13	175
185	App\\Models\\Video	13	176
186	App\\Models\\Video	13	177
187	App\\Models\\Video	13	178
188	App\\Models\\Video	13	179
189	App\\Models\\Video	13	180
190	App\\Models\\Video	13	181
191	App\\Models\\Video	13	182
192	App\\Models\\Video	13	183
193	App\\Models\\Video	13	184
194	App\\Models\\Video	13	185
195	App\\Models\\Video	13	26
196	App\\Models\\Video	13	186
197	App\\Models\\Video	13	187
198	App\\Models\\Video	13	188
199	App\\Models\\Video	13	189
200	App\\Models\\Video	13	190
201	App\\Models\\Video	13	191
202	App\\Models\\Video	13	192
203	App\\Models\\Video	13	193
204	App\\Models\\Video	13	194
205	App\\Models\\Video	14	195
206	App\\Models\\Video	14	196
207	App\\Models\\Video	14	197
208	App\\Models\\Video	14	198
209	App\\Models\\Video	14	199
210	App\\Models\\Video	14	200
211	App\\Models\\Video	14	201
212	App\\Models\\Video	14	202
213	App\\Models\\Video	14	203
214	App\\Models\\Video	14	204
215	App\\Models\\Video	14	205
216	App\\Models\\Video	14	206
217	App\\Models\\Video	14	207
218	App\\Models\\Video	14	208
219	App\\Models\\Video	14	209
220	App\\Models\\Video	14	50
221	App\\Models\\Video	14	210
222	App\\Models\\Video	14	75
223	App\\Models\\Video	14	211
224	App\\Models\\Video	14	212
225	App\\Models\\Video	14	213
226	App\\Models\\Video	15	214
227	App\\Models\\Video	15	215
228	App\\Models\\Video	15	216
229	App\\Models\\Video	15	217
230	App\\Models\\Video	15	218
231	App\\Models\\Video	15	219
232	App\\Models\\Video	15	220
233	App\\Models\\Video	15	221
234	App\\Models\\Video	15	222
235	App\\Models\\Video	15	175
236	App\\Models\\Video	15	223
237	App\\Models\\Video	16	224
238	App\\Models\\Video	16	225
239	App\\Models\\Video	16	226
240	App\\Models\\Video	16	227
241	App\\Models\\Video	16	228
242	App\\Models\\Video	16	229
243	App\\Models\\Video	16	230
244	App\\Models\\Video	17	231
245	App\\Models\\Video	17	232
246	App\\Models\\Video	17	233
247	App\\Models\\Video	17	234
248	App\\Models\\Video	17	235
249	App\\Models\\Video	17	236
250	App\\Models\\Video	17	237
251	App\\Models\\Video	17	238
252	App\\Models\\Video	17	239
253	App\\Models\\Video	17	240
254	App\\Models\\Video	17	241
255	App\\Models\\Video	17	242
256	App\\Models\\Video	17	243
257	App\\Models\\Video	17	244
258	App\\Models\\Video	17	245
259	App\\Models\\Video	17	246
260	App\\Models\\Video	17	247
261	App\\Models\\Video	18	84
262	App\\Models\\Video	18	248
263	App\\Models\\Video	18	88
264	App\\Models\\Video	18	249
265	App\\Models\\Video	18	250
266	App\\Models\\Video	18	79
267	App\\Models\\Video	18	251
268	App\\Models\\Video	18	252
269	App\\Models\\Video	18	253
270	App\\Models\\Video	18	254
271	App\\Models\\Video	18	255
272	App\\Models\\Video	18	256
273	App\\Models\\Video	18	257
274	App\\Models\\Video	18	258
275	App\\Models\\Video	18	259
276	App\\Models\\Video	18	260
277	App\\Models\\Video	18	261
278	App\\Models\\Video	18	262
279	App\\Models\\Video	18	263
280	App\\Models\\Video	18	264
281	App\\Models\\Video	18	265
282	App\\Models\\Video	18	266
283	App\\Models\\Video	18	267
284	App\\Models\\Video	18	268
285	App\\Models\\Video	18	269
286	App\\Models\\Video	18	201
287	App\\Models\\Video	18	270
288	App\\Models\\Video	18	271
289	App\\Models\\Video	18	272
290	App\\Models\\Video	18	33
291	App\\Models\\Video	18	273
292	App\\Models\\Video	18	274
293	App\\Models\\Video	18	275
294	App\\Models\\Video	18	276
295	App\\Models\\Video	18	277
296	App\\Models\\Video	18	278
297	App\\Models\\Video	18	26
298	App\\Models\\Video	18	279
299	App\\Models\\Video	18	280
300	App\\Models\\Video	19	281
301	App\\Models\\Video	19	282
302	App\\Models\\Video	19	283
303	App\\Models\\Video	19	284
304	App\\Models\\Video	19	285
305	App\\Models\\Video	19	175
306	App\\Models\\Video	19	223
307	App\\Models\\Video	20	286
308	App\\Models\\Video	20	287
309	App\\Models\\Video	20	288
310	App\\Models\\Video	20	289
311	App\\Models\\Video	20	290
312	App\\Models\\Video	20	291
313	App\\Models\\Video	20	292
314	App\\Models\\Video	20	142
315	App\\Models\\Video	20	293
316	App\\Models\\Video	20	294
317	App\\Models\\Video	20	26
318	App\\Models\\Video	20	59
319	App\\Models\\Video	20	295
320	App\\Models\\Video	20	296
321	App\\Models\\Video	20	297
322	App\\Models\\Video	20	298
323	App\\Models\\Video	20	299
324	App\\Models\\Video	20	300
325	App\\Models\\Video	20	301
326	App\\Models\\Video	20	302
327	App\\Models\\Video	20	303
328	App\\Models\\Video	20	78
329	App\\Models\\Video	20	304
330	App\\Models\\Video	20	305
331	App\\Models\\Video	20	306
332	App\\Models\\Video	20	307
333	App\\Models\\Video	20	308
334	App\\Models\\Video	21	309
335	App\\Models\\Video	21	310
336	App\\Models\\Video	21	311
337	App\\Models\\Video	21	312
338	App\\Models\\Video	21	313
339	App\\Models\\Video	21	314
340	App\\Models\\Video	21	315
341	App\\Models\\Video	21	316
342	App\\Models\\Video	21	317
343	App\\Models\\Video	21	318
344	App\\Models\\Video	21	319
345	App\\Models\\Video	21	320
346	App\\Models\\Video	21	321
347	App\\Models\\Video	21	322
348	App\\Models\\Video	21	323
349	App\\Models\\Video	21	324
350	App\\Models\\Video	21	325
351	App\\Models\\Video	21	326
352	App\\Models\\Video	21	327
353	App\\Models\\Video	21	328
354	App\\Models\\Video	21	329
355	App\\Models\\Video	21	330
356	App\\Models\\Video	21	331
357	App\\Models\\Video	21	332
358	App\\Models\\Video	21	333
359	App\\Models\\Video	21	334
360	App\\Models\\Video	21	114
361	App\\Models\\Video	21	335
362	App\\Models\\Video	21	336
363	App\\Models\\Video	21	337
364	App\\Models\\Video	21	338
365	App\\Models\\Video	21	339
366	App\\Models\\Video	22	340
367	App\\Models\\Video	22	341
368	App\\Models\\Video	22	342
369	App\\Models\\Video	22	343
370	App\\Models\\Video	22	344
371	App\\Models\\Video	22	345
372	App\\Models\\Video	22	346
373	App\\Models\\Video	22	347
374	App\\Models\\Video	22	348
375	App\\Models\\Video	22	130
376	App\\Models\\Video	22	349
377	App\\Models\\Video	22	350
378	App\\Models\\Video	22	351
379	App\\Models\\Video	22	352
380	App\\Models\\Video	23	353
381	App\\Models\\Video	23	354
382	App\\Models\\Video	23	355
383	App\\Models\\Video	23	356
384	App\\Models\\Video	23	357
385	App\\Models\\Video	23	358
386	App\\Models\\Video	23	142
387	App\\Models\\Video	23	359
388	App\\Models\\Video	23	297
389	App\\Models\\Video	23	360
390	App\\Models\\Video	23	361
391	App\\Models\\Video	23	362
392	App\\Models\\Video	23	363
393	App\\Models\\Video	23	364
394	App\\Models\\Video	23	365
395	App\\Models\\Video	23	366
396	App\\Models\\Video	23	367
397	App\\Models\\Video	23	368
398	App\\Models\\Video	23	369
399	App\\Models\\Video	23	370
400	App\\Models\\Video	23	371
401	App\\Models\\Video	23	372
402	App\\Models\\Video	23	373
403	App\\Models\\Video	23	374
404	App\\Models\\Video	23	375
405	App\\Models\\Video	23	167
406	App\\Models\\Video	23	376
407	App\\Models\\Video	23	377
408	App\\Models\\Video	23	378
409	App\\Models\\Video	23	379
410	App\\Models\\Video	23	380
411	App\\Models\\Video	23	381
412	App\\Models\\Video	23	382
413	App\\Models\\Video	23	383
414	App\\Models\\Video	23	384
415	App\\Models\\Video	23	385
416	App\\Models\\Video	23	386
417	App\\Models\\Video	23	387
418	App\\Models\\Video	23	388
419	App\\Models\\Video	24	389
420	App\\Models\\Video	24	390
421	App\\Models\\Video	24	391
422	App\\Models\\Video	25	392
423	App\\Models\\Video	26	393
424	App\\Models\\Video	26	394
425	App\\Models\\Video	26	395
426	App\\Models\\Video	26	396
427	App\\Models\\Video	26	397
428	App\\Models\\Video	26	398
429	App\\Models\\Video	26	399
430	App\\Models\\Submission	1	400
431	App\\Models\\Submission	1	401
432	App\\Models\\Submission	1	402
433	App\\Models\\Submission	1	403
434	App\\Models\\Submission	2	404
435	App\\Models\\Submission	2	405
436	App\\Models\\Submission	2	406
437	App\\Models\\Submission	2	407
438	App\\Models\\Submission	2	408
439	App\\Models\\Submission	3	409
440	App\\Models\\Submission	3	405
441	App\\Models\\Submission	3	410
442	App\\Models\\Submission	4	411
443	App\\Models\\Submission	4	412
444	App\\Models\\Submission	4	413
445	App\\Models\\Submission	4	414
446	App\\Models\\Submission	4	415
447	App\\Models\\Submission	4	416
448	App\\Models\\Submission	5	409
449	App\\Models\\Submission	5	405
450	App\\Models\\Submission	5	417
451	App\\Models\\Submission	6	418
452	App\\Models\\Submission	6	419
453	App\\Models\\Submission	6	409
454	App\\Models\\Submission	6	420
455	App\\Models\\Submission	7	421
456	App\\Models\\Submission	7	422
457	App\\Models\\Submission	7	423
458	App\\Models\\Submission	7	407
459	App\\Models\\Submission	7	424
460	App\\Models\\Submission	8	425
461	App\\Models\\Submission	8	426
462	App\\Models\\Submission	8	427
463	App\\Models\\Submission	9	424
464	App\\Models\\Submission	9	428
465	App\\Models\\Submission	9	405
466	App\\Models\\Submission	9	408
467	App\\Models\\Submission	9	429
468	App\\Models\\Submission	10	420
469	App\\Models\\Submission	10	430
470	App\\Models\\Submission	10	431
471	App\\Models\\Submission	10	409
472	App\\Models\\Submission	10	432
473	App\\Models\\Submission	10	433
474	App\\Models\\Submission	10	434
475	App\\Models\\Submission	11	435
476	App\\Models\\Submission	11	420
477	App\\Models\\Submission	11	436
478	App\\Models\\Submission	11	437
479	App\\Models\\Submission	11	419
480	App\\Models\\Submission	12	438
481	App\\Models\\Submission	12	439
482	App\\Models\\Submission	12	440
483	App\\Models\\Submission	12	441
484	App\\Models\\Submission	12	442
485	App\\Models\\Submission	12	443
486	App\\Models\\Submission	12	444
487	App\\Models\\Submission	13	445
488	App\\Models\\Submission	13	446
489	App\\Models\\Submission	13	447
490	App\\Models\\Submission	13	448
491	App\\Models\\Submission	13	449
492	App\\Models\\Submission	14	409
493	App\\Models\\Submission	14	450
494	App\\Models\\Submission	14	451
495	App\\Models\\Submission	15	404
496	App\\Models\\Submission	15	448
497	App\\Models\\Submission	15	419
498	App\\Models\\Submission	15	452
499	App\\Models\\Submission	16	412
500	App\\Models\\Submission	16	453
501	App\\Models\\Submission	16	454
502	App\\Models\\Submission	16	455
503	App\\Models\\Submission	16	429
504	App\\Models\\Submission	17	431
505	App\\Models\\Submission	17	440
506	App\\Models\\Submission	17	456
507	App\\Models\\Submission	17	457
508	App\\Models\\Submission	17	458
509	App\\Models\\Submission	18	459
510	App\\Models\\Submission	18	425
511	App\\Models\\Submission	18	460
512	App\\Models\\Submission	18	461
513	App\\Models\\Submission	18	462
514	App\\Models\\Submission	18	463
515	App\\Models\\Submission	18	447
516	App\\Models\\Submission	19	464
517	App\\Models\\Submission	19	465
518	App\\Models\\Submission	19	466
519	App\\Models\\Submission	20	467
520	App\\Models\\Submission	20	468
521	App\\Models\\Submission	20	462
522	App\\Models\\Submission	20	469
523	App\\Models\\Submission	21	455
524	App\\Models\\Submission	21	413
525	App\\Models\\Submission	21	454
526	App\\Models\\Submission	21	461
527	App\\Models\\Submission	22	470
528	App\\Models\\Submission	22	471
529	App\\Models\\Submission	22	472
530	App\\Models\\Submission	22	473
531	App\\Models\\Submission	22	474
532	App\\Models\\Submission	22	400
533	App\\Models\\Submission	23	425
534	App\\Models\\Submission	23	475
535	App\\Models\\Submission	23	405
536	App\\Models\\Submission	23	476
537	App\\Models\\Submission	23	477
538	App\\Models\\Submission	24	420
539	App\\Models\\Submission	24	419
540	App\\Models\\Submission	24	438
541	App\\Models\\Submission	25	478
542	App\\Models\\Submission	25	479
543	App\\Models\\Submission	25	480
544	App\\Models\\Submission	26	481
545	App\\Models\\Submission	26	441
546	App\\Models\\Submission	26	407
547	App\\Models\\Submission	26	453
\.


--
-- Name: tagged_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tagged_id_seq', 547, true);


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
78	App\\Models\\Video	social-experiment	social experiment	2
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
84	App\\Models\\Video	chad	chad	2
76	App\\Models\\Video	nikon	Nikon	1
77	App\\Models\\Video	chad-lebaron	chad lebaron	1
33	App\\Models\\Video	box	box	2
80	App\\Models\\Video	shocking-social-experiment	shocking social experiment	1
81	App\\Models\\Video	these-results-are-shocking	these results are shocking	1
82	App\\Models\\Video	are-shocking	are shocking	1
83	App\\Models\\Video	these-results	these results	1
88	App\\Models\\Video	cherd	cherd	2
85	App\\Models\\Video	cherdleys	cherdleys	1
86	App\\Models\\Video	cherdlys	cherdlys	1
87	App\\Models\\Video	churd	churd	1
79	App\\Models\\Video	shocking	shocking	2
89	App\\Models\\Video	cherdley	cherdley	1
90	App\\Models\\Video	cherdly	cherdly	1
91	App\\Models\\Video	cars	cars	1
92	App\\Models\\Video	running	running	1
93	App\\Models\\Video	in-front-of	in front of	1
94	App\\Models\\Video	in-front-of-cars	in front of cars	1
95	App\\Models\\Video	black-vs-white	black vs white	1
96	App\\Models\\Video	hit-by-car	hit by car	1
97	App\\Models\\Video	speeding-car	speeding car	1
26	App\\Models\\Video	funny	funny	5
99	App\\Models\\Video	pacific-crest-trail-2016	pacific crest trail 2016	1
98	App\\Models\\Video	pacific-crest-trail	pacific crest trail	2
163	App\\Models\\Video	platform-engineering	platform engineering	1
103	App\\Models\\Video	wild-movie	wild movie	1
104	App\\Models\\Video	trails	trails	1
164	App\\Models\\Video	it-infrastructure	IT infrastructure	1
106	App\\Models\\Video	long-distance-hiking	long distance hiking	1
107	App\\Models\\Video	trekking	trekking	1
108	App\\Models\\Video	pacific-crest-trail-california	pacific crest trail California	1
109	App\\Models\\Video	pacific-crest-trail-oregon	pacific crest trail Oregon	1
110	App\\Models\\Video	pacific-crest-trail-washington	pacific crest trail Washington	1
111	App\\Models\\Video	pacific-crest-trail-gear	pacific crest trail gear	1
112	App\\Models\\Video	pct-gear	pct gear	1
113	App\\Models\\Video	shop-tour	shop tour	1
130	App\\Models\\Video	universe	Universe	2
115	App\\Models\\Video	diresta	diresta	1
116	App\\Models\\Video	mike-dubno	mike dubno	1
117	App\\Models\\Video	maker	maker	1
118	App\\Models\\Video	diy	diy	1
119	App\\Models\\Video	workshop	workshop	1
120	App\\Models\\Video	woodworking	woodworking	1
121	App\\Models\\Video	building	building	1
122	App\\Models\\Video	powercon	powercon	1
123	App\\Models\\Video	jimmy-diresta	jimmy diresta	1
124	App\\Models\\Video	imake	imake	1
125	App\\Models\\Video	i-make	i make	1
126	App\\Models\\Video	woodshop-tour	woodshop tour	1
127	App\\Models\\Video	woodworking-shop	woodworking shop	1
128	App\\Models\\Video	shop-organization	shop organization	1
129	App\\Models\\Video	woodshop	woodshop	1
167	App\\Models\\Video	netflix	Netflix	2
131	App\\Models\\Video	canada	Canada	1
132	App\\Models\\Video	national-film-board-of-canada	National Film Board of Canada	1
133	App\\Models\\Video	2001-a-space-odyssey	2001 A Space Odyssey	1
134	App\\Models\\Video	nfb	NFB	1
135	App\\Models\\Video	educational-film	Educational Film	1
136	App\\Models\\Video	classic	Classic	1
137	App\\Models\\Video	short-film	Short Film	1
138	App\\Models\\Video	universe-film	Universe (Film)	1
139	App\\Models\\Video	roman-kroitor-colin-low	Roman Kroitor & Colin Low	1
140	App\\Models\\Video	stanley-kubrick	Stanley Kubrick	1
141	App\\Models\\Video	nasa	NASA	1
114	App\\Models\\Video	make	make	2
143	App\\Models\\Video	film-film	Film (Film)	1
144	App\\Models\\Video	film-media-genre	Film (Media Genre)	1
145	App\\Models\\Video	toronto	Toronto	1
100	App\\Models\\Video	pct	pct	2
146	App\\Models\\Video	monologue	monologue	1
147	App\\Models\\Video	preview	preview	1
148	App\\Models\\Video	sneak-peak	sneak peak	1
105	App\\Models\\Video	backpacking	backpacking	2
149	App\\Models\\Video	backpack	backpack	1
150	App\\Models\\Video	campo	campo	1
151	App\\Models\\Video	hauser-creek	hauser creek	1
152	App\\Models\\Video	appalachian-trail	Appalachian Trail	1
102	App\\Models\\Video	thru-hike	thru hike	2
101	App\\Models\\Video	hiking	hiking	3
153	App\\Models\\Video	hiker-trash	hiker trash	1
154	App\\Models\\Video	linux	Linux	1
155	App\\Models\\Video	system-administration	system administration	1
156	App\\Models\\Video	sysadmin	sysadmin	1
157	App\\Models\\Video	how-to-become-a-system-administrator	how to become a system administrator	1
158	App\\Models\\Video	computer-science	computer science	1
159	App\\Models\\Video	college-degree	college degree	1
160	App\\Models\\Video	university-degree	university degree	1
161	App\\Models\\Video	education	education	1
162	App\\Models\\Video	system-engineering	system engineering	1
165	App\\Models\\Video	dear-white-people	Dear White People	1
166	App\\Models\\Video	dear-white-people-movie	dear white people movie	1
168	App\\Models\\Video	dear-white-people-trailer	dear white people trailer	1
169	App\\Models\\Video	dear-white-people-netflix	dear white people Netflix	1
170	App\\Models\\Video	maga	maga	1
171	App\\Models\\Video	delete-netflix	delete Netflix	1
172	App\\Models\\Video	boycott-netflix	boycott Netflix	1
173	App\\Models\\Video	youtube-glitch	youtube glitch	1
174	App\\Models\\Video	youtube-sub-glitch	youtube sub glitch	1
175	App\\Models\\Video	h3h3	h3h3	3
176	App\\Models\\Video	baylor-football	baylor football	1
177	App\\Models\\Video	baylor-scandal	baylor scandal	1
178	App\\Models\\Video	baylor-big-12	baylor big 12	1
179	App\\Models\\Video	nba-2k	nba 2k	1
180	App\\Models\\Video	esports	esports	1
181	App\\Models\\Video	nba-2k-eleague	nba 2k eleague	1
182	App\\Models\\Video	celebrity	celebrity	1
183	App\\Models\\Video	current-events	current events	1
184	App\\Models\\Video	daily	daily	1
185	App\\Models\\Video	news	News	1
186	App\\Models\\Video	opinion	opinion	1
187	App\\Models\\Video	politics	Politics	1
188	App\\Models\\Video	sxephil	sxephil	1
189	App\\Models\\Video	the-philip-defranco-show	the philip defranco show	1
190	App\\Models\\Video	philip-defranco-show	philip defranco show	1
191	App\\Models\\Video	youtube-news	youtube news	1
192	App\\Models\\Video	defranco	DeFranco	1
193	App\\Models\\Video	response-video	response video	1
194	App\\Models\\Video	racism	racism	1
195	App\\Models\\Video	anna	anna	1
196	App\\Models\\Video	akana	akana	1
197	App\\Models\\Video	ana	ana	1
198	App\\Models\\Video	annaakana	annaakana	1
199	App\\Models\\Video	i-need-a-cat-dad	i need a cat dad	1
200	App\\Models\\Video	cat	cat	1
277	App\\Models\\Video	rage	rage	1
202	App\\Models\\Video	i-need-a	i need a	1
203	App\\Models\\Video	valentines-day	valentine's day	1
204	App\\Models\\Video	kitten	kitten	1
205	App\\Models\\Video	kitty	kitty	1
206	App\\Models\\Video	cats	cats	1
207	App\\Models\\Video	father	father	1
208	App\\Models\\Video	rap	rap	1
209	App\\Models\\Video	song	song	1
210	App\\Models\\Video	video	video	1
211	App\\Models\\Video	anna-akana	anna akana	1
212	App\\Models\\Video	kittyes	kittyes	1
213	App\\Models\\Video	kitties	kitties	1
214	App\\Models\\Video	pewdiepie	pewdiepie	1
215	App\\Models\\Video	pdp	pdp	1
216	App\\Models\\Video	collab	collab	1
217	App\\Models\\Video	collaboration	collaboration	1
218	App\\Models\\Video	felix	felix	1
219	App\\Models\\Video	felix-kjellberg	felix kjellberg	1
220	App\\Models\\Video	kjellberg	Kjellberg	1
221	App\\Models\\Video	pewd	pewd	1
222	App\\Models\\Video	pewds	pewds	1
224	App\\Models\\Video	veritasium	veritasium	1
225	App\\Models\\Video	moon	moon	1
226	App\\Models\\Video	water	water	1
227	App\\Models\\Video	water-on-the-moon	water on the moon	1
228	App\\Models\\Video	moon-water	moon water	1
229	App\\Models\\Video	apollo	apollo	1
230	App\\Models\\Video	h2o	h2o	1
231	App\\Models\\Video	idubbbz	idubbbz	1
232	App\\Models\\Video	vlog	vlog	1
233	App\\Models\\Video	nword	nword	1
234	App\\Models\\Video	tana-mongeau	tana mongeau	1
235	App\\Models\\Video	idubbbz-tana	idubbbz tana	1
236	App\\Models\\Video	meet-n-greet	meet n greet	1
237	App\\Models\\Video	show	show	1
238	App\\Models\\Video	fullscreen-live	fullscreen live	1
239	App\\Models\\Video	event	event	1
240	App\\Models\\Video	roadtrip	roadtrip	1
241	App\\Models\\Video	lifestyle	lifestyle	1
242	App\\Models\\Video	idubbbztv	idubbbztv	1
243	App\\Models\\Video	san-francisco	san francisco	1
244	App\\Models\\Video	storytime	storytime	1
245	App\\Models\\Video	youtuber	youtuber	1
246	App\\Models\\Video	drama	drama	1
247	App\\Models\\Video	idubbbz-visits-tana-mongeau	idubbbz visits tana mongeau	1
248	App\\Models\\Video	lebaron	lebaron	1
249	App\\Models\\Video	social	social	1
250	App\\Models\\Video	experiment	experiment	1
251	App\\Models\\Video	result	result	1
252	App\\Models\\Video	may	may	1
253	App\\Models\\Video	be	be	1
254	App\\Models\\Video	cheb	cheb	1
255	App\\Models\\Video	here	here	1
256	App\\Models\\Video	what	what	1
257	App\\Models\\Video	shame	shame	1
258	App\\Models\\Video	beautiful	beautiful	1
259	App\\Models\\Video	today	today	1
260	App\\Models\\Video	im	i'm	1
261	App\\Models\\Video	going	going	1
262	App\\Models\\Video	to	to	1
263	App\\Models\\Video	teaching	teaching	1
264	App\\Models\\Video	you	you	1
265	App\\Models\\Video	how	how	1
266	App\\Models\\Video	ball	ball	1
267	App\\Models\\Video	it	it	1
268	App\\Models\\Video	up	up	1
269	App\\Models\\Video	board	board	1
201	App\\Models\\Video	dad	dad	2
270	App\\Models\\Video	at	at	1
271	App\\Models\\Video	coachella	coachella	1
272	App\\Models\\Video	beer	beer	1
273	App\\Models\\Video	inspirational	inspirational	1
274	App\\Models\\Video	frat	frat	1
275	App\\Models\\Video	jeff	jeff	1
276	App\\Models\\Video	aka	aka	1
278	App\\Models\\Video	guy	guy	1
279	App\\Models\\Video	hilarious	hilarious	1
280	App\\Models\\Video	videos	videos	1
281	App\\Models\\Video	fitness	fitness	1
282	App\\Models\\Video	excercise	excercise	1
283	App\\Models\\Video	gym	gym	1
284	App\\Models\\Video	workout	workout	1
285	App\\Models\\Video	connor-murphy	connor murphy	1
223	App\\Models\\Video	h3h3productions	h3h3productions	2
286	App\\Models\\Video	boston-terrier	boston terrier	1
287	App\\Models\\Video	cute	cute	1
288	App\\Models\\Video	dog	dog	1
289	App\\Models\\Video	puppy	puppy	1
290	App\\Models\\Video	puppies	puppies	1
291	App\\Models\\Video	cutest-dog-in-the-world	cutest dog in the world	1
292	App\\Models\\Video	cutest-puppy-ever	cutest puppy ever	1
293	App\\Models\\Video	mockumentary	mockumentary	1
294	App\\Models\\Video	interview	interview	1
142	App\\Models\\Video	documentary	Documentary	3
295	App\\Models\\Video	sketch	sketch	1
296	App\\Models\\Video	lahwf	lahwf	1
298	App\\Models\\Video	luke-donohue	luke donohue	1
299	App\\Models\\Video	aryia	aryia	1
300	App\\Models\\Video	bonnie	Bonnie	1
301	App\\Models\\Video	dont-touch-her	don't touch her	1
302	App\\Models\\Video	you-cant-touch-her	you can't touch her	1
303	App\\Models\\Video	prank	prank	1
304	App\\Models\\Video	tinder	tinder	1
305	App\\Models\\Video	dating	dating	1
306	App\\Models\\Video	app	app	1
307	App\\Models\\Video	chick-magnet	chick magnet	1
308	App\\Models\\Video	picking-up-girls	picking up girls	1
309	App\\Models\\Video	stuffed-mushrooms-recipe	stuffed mushrooms recipe	1
310	App\\Models\\Video	stuffed-mushrooms	stuffed mushrooms	1
311	App\\Models\\Video	stuffed-mushroom	stuffed mushroom	1
312	App\\Models\\Video	how-to-make-stuffed-mushrooms	how to make stuffed mushrooms	1
313	App\\Models\\Video	baked-mushrooms	baked mushrooms	1
314	App\\Models\\Video	best-stuffed-mushrooms	best stuffed mushrooms	1
315	App\\Models\\Video	appetizers	appetizers	1
316	App\\Models\\Video	party-foods	party foods	1
317	App\\Models\\Video	mushroom-recipe	mushroom recipe	1
318	App\\Models\\Video	recipe	recipe	1
319	App\\Models\\Video	button-mushrooms	button mushrooms	1
320	App\\Models\\Video	crimini-mushrooms	crimini mushrooms	1
321	App\\Models\\Video	mushroom-caps	mushroom caps	1
322	App\\Models\\Video	mushroom-tops	mushroom tops	1
323	App\\Models\\Video	appetizer-recipes	appetizer recipes	1
324	App\\Models\\Video	party	party	1
325	App\\Models\\Video	appetizer	appetizer	1
326	App\\Models\\Video	healthy	healthy	1
327	App\\Models\\Video	recipes	recipes	1
328	App\\Models\\Video	cook	cook	1
329	App\\Models\\Video	cooking	cooking	1
330	App\\Models\\Video	food	food	1
331	App\\Models\\Video	easy	easy	1
332	App\\Models\\Video	how-to-cook	how to cook	1
333	App\\Models\\Video	how-to	how-to	1
334	App\\Models\\Video	howto	howto	1
335	App\\Models\\Video	how-to-make	how to make	1
336	App\\Models\\Video	chef-buck	chef buck	1
337	App\\Models\\Video	vegetarian	vegetarian	1
338	App\\Models\\Video	mushroom	mushroom	1
339	App\\Models\\Video	mushrooms	mushrooms	1
340	App\\Models\\Video	space	space	1
341	App\\Models\\Video	gravity	gravity	1
342	App\\Models\\Video	ariane-6	ariane 6	1
343	App\\Models\\Video	rocket	rocket	1
344	App\\Models\\Video	spacetravel	spacetravel	1
345	App\\Models\\Video	human	human	1
346	App\\Models\\Video	earth	earth	1
347	App\\Models\\Video	solar-system	solar system	1
348	App\\Models\\Video	galaxy	galaxy	1
349	App\\Models\\Video	gravity-well	gravity well	1
350	App\\Models\\Video	gravity-prison	gravity prison	1
351	App\\Models\\Video	kurzgesagt	kurzgesagt	1
352	App\\Models\\Video	in-a-nutshell	in a nutshell	1
353	App\\Models\\Video	top-10	top 10	1
354	App\\Models\\Video	documentaries	documentaries	1
355	App\\Models\\Video	favorite	favorite	1
356	App\\Models\\Video	list	list	1
357	App\\Models\\Video	top-ten	top ten	1
358	App\\Models\\Video	best	best	1
359	App\\Models\\Video	films	films	1
297	App\\Models\\Video	andrew-hales	andrew hales	2
360	App\\Models\\Video	vlogs	vlogs	1
361	App\\Models\\Video	lahwfextra	lahwfextra	1
362	App\\Models\\Video	my-favorite	my favorite	1
363	App\\Models\\Video	movies	movies	1
364	App\\Models\\Video	super-size-me	super size me	1
365	App\\Models\\Video	grizzly-man	grizzly man	1
366	App\\Models\\Video	werner-herzog	werner herzog	1
367	App\\Models\\Video	film-maker	film maker	1
368	App\\Models\\Video	man-on-wire	man on wire	1
369	App\\Models\\Video	montage-of-heck	montage of heck	1
370	App\\Models\\Video	amy	amy	1
371	App\\Models\\Video	going-clear	going clear	1
372	App\\Models\\Video	hbo	hbo	1
373	App\\Models\\Video	scientology	scientology	1
374	App\\Models\\Video	the-union	the union	1
375	App\\Models\\Video	black-fish	black fish	1
376	App\\Models\\Video	hulu	hulu	1
377	App\\Models\\Video	amazon-prime	amazon prime	1
378	App\\Models\\Video	jiro-dreams-of-sushi	jiro dreams of sushi	1
379	App\\Models\\Video	the-jinx	the jinx	1
380	App\\Models\\Video	robert-durst	robert durst	1
381	App\\Models\\Video	making-a-murderer	making a murderer	1
382	App\\Models\\Video	best-films-of-all-time	best films of all time	1
383	App\\Models\\Video	best-documentaries	best documentaries	1
384	App\\Models\\Video	oscars	oscars	1
385	App\\Models\\Video	awards	awards	1
386	App\\Models\\Video	cinema	cinema	1
387	App\\Models\\Video	cinematography	cinematography	1
388	App\\Models\\Video	feature-length	feature length	1
389	App\\Models\\Video	sixtysymbols	sixtysymbols	1
390	App\\Models\\Video	string-theory	string theory	1
391	App\\Models\\Video	cosmology	cosmology	1
392	App\\Models\\Video	null	null	1
393	App\\Models\\Video	arcade	Arcade	1
394	App\\Models\\Video	fire	Fire	1
395	App\\Models\\Video	rebellion	Rebellion	1
396	App\\Models\\Video	lies	(Lies)	1
397	App\\Models\\Video	eagle	Eagle	1
398	App\\Models\\Video	rock	Rock	1
399	App\\Models\\Video	alternative	Alternative	1
476	App\\Models\\Submission	autem	autem	1
401	App\\Models\\Submission	nihil	nihil	1
402	App\\Models\\Submission	eaque	eaque	1
403	App\\Models\\Submission	illum	illum	1
459	App\\Models\\Submission	minima	minima	1
406	App\\Models\\Submission	sapiente	sapiente	1
439	App\\Models\\Submission	illo	illo	1
410	App\\Models\\Submission	pariatur	pariatur	1
411	App\\Models\\Submission	molestiae	molestiae	1
461	App\\Models\\Submission	non	non	2
414	App\\Models\\Submission	impedit	impedit	1
415	App\\Models\\Submission	nemo	nemo	1
416	App\\Models\\Submission	dolorum	dolorum	1
417	App\\Models\\Submission	delectus	delectus	1
418	App\\Models\\Submission	dolorem	dolorem	1
460	App\\Models\\Submission	earum	earum	1
421	App\\Models\\Submission	maxime	maxime	1
422	App\\Models\\Submission	rerum	rerum	1
423	App\\Models\\Submission	amet	amet	1
426	App\\Models\\Submission	ad	ad	1
427	App\\Models\\Submission	consequuntur	consequuntur	1
424	App\\Models\\Submission	sint	sint	2
428	App\\Models\\Submission	quis	quis	1
477	App\\Models\\Submission	nobis	nobis	1
408	App\\Models\\Submission	aut	aut	2
442	App\\Models\\Submission	perspiciatis	perspiciatis	1
430	App\\Models\\Submission	provident	provident	1
420	App\\Models\\Submission	sit	sit	4
432	App\\Models\\Submission	iure	iure	1
433	App\\Models\\Submission	optio	optio	1
434	App\\Models\\Submission	repellat	repellat	1
435	App\\Models\\Submission	quidem	quidem	1
480	App\\Models\\Submission	at	at	1
436	App\\Models\\Submission	nisi	nisi	1
437	App\\Models\\Submission	ipsa	ipsa	1
443	App\\Models\\Submission	molestias	molestias	1
444	App\\Models\\Submission	harum	harum	1
445	App\\Models\\Submission	quam	quam	1
446	App\\Models\\Submission	fugit	fugit	1
470	App\\Models\\Submission	voluptas	voluptas	1
449	App\\Models\\Submission	quasi	quasi	1
409	App\\Models\\Submission	quia	quia	5
450	App\\Models\\Submission	deserunt	deserunt	1
451	App\\Models\\Submission	rem	rem	1
404	App\\Models\\Submission	eum	eum	2
448	App\\Models\\Submission	blanditiis	blanditiis	2
452	App\\Models\\Submission	deleniti	deleniti	1
412	App\\Models\\Submission	asperiores	asperiores	2
471	App\\Models\\Submission	error	error	1
429	App\\Models\\Submission	est	est	2
431	App\\Models\\Submission	id	id	2
440	App\\Models\\Submission	ut	ut	2
456	App\\Models\\Submission	fugiat	fugiat	1
457	App\\Models\\Submission	eos	eos	1
458	App\\Models\\Submission	voluptate	voluptate	1
463	App\\Models\\Submission	cum	cum	1
447	App\\Models\\Submission	consequatur	consequatur	2
464	App\\Models\\Submission	veritatis	veritatis	1
465	App\\Models\\Submission	a	a	1
466	App\\Models\\Submission	minus	minus	1
467	App\\Models\\Submission	exercitationem	exercitationem	1
468	App\\Models\\Submission	facilis	facilis	1
462	App\\Models\\Submission	nulla	nulla	2
469	App\\Models\\Submission	quas	quas	1
455	App\\Models\\Submission	voluptatem	voluptatem	2
413	App\\Models\\Submission	animi	animi	2
454	App\\Models\\Submission	alias	alias	2
472	App\\Models\\Submission	nostrum	nostrum	1
473	App\\Models\\Submission	voluptatibus	voluptatibus	1
474	App\\Models\\Submission	esse	esse	1
400	App\\Models\\Submission	sunt	sunt	2
425	App\\Models\\Submission	repellendus	repellendus	3
475	App\\Models\\Submission	reiciendis	reiciendis	1
405	App\\Models\\Submission	qui	qui	5
419	App\\Models\\Submission	et	et	4
438	App\\Models\\Submission	porro	porro	2
478	App\\Models\\Submission	totam	totam	1
479	App\\Models\\Submission	suscipit	suscipit	1
481	App\\Models\\Submission	vitae	vitae	1
441	App\\Models\\Submission	quod	quod	2
407	App\\Models\\Submission	labore	labore	3
453	App\\Models\\Submission	sequi	sequi	2
\.


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tags_id_seq', 481, true);


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY topics (id, google_id, slug, name, json, count, created_at, updated_at) FROM stdin;
1	/m/04rlf	\N	\N	\N	0	2017-05-04 20:54:30	2017-05-04 20:54:30
2	/m/064t9	\N	\N	\N	0	2017-05-04 20:54:30	2017-05-04 20:54:30
3	/m/019_rr	\N	\N	\N	0	2017-05-04 20:54:31	2017-05-04 20:54:31
4	/m/07yv9	\N	\N	\N	0	2017-05-04 20:54:32	2017-05-04 20:54:32
5	/m/02jjt	\N	\N	\N	0	2017-05-04 20:54:33	2017-05-04 20:54:33
6	/m/03glg	\N	\N	\N	0	2017-05-04 20:54:35	2017-05-04 20:54:35
7	/m/07bxq	\N	\N	\N	0	2017-05-04 20:54:35	2017-05-04 20:54:35
8	/m/02vxn	\N	\N	\N	0	2017-05-04 20:54:36	2017-05-04 20:54:36
9	/m/01k8wb	\N	Knowledge	{"@type":"EntitySearchResult","result":{"@id":"kg:\\/m\\/01k8wb","name":"Knowledge","@type":["Thing","Place"],"image":{"contentUrl":"http:\\/\\/t2.gstatic.com\\/images?q=tbn:ANd9GcQ3TTbCIURSO1JzzKorsbadr4N51BD1P4IPtGA9lXUDEfA3Qdcg","url":"https:\\/\\/commons.wikimedia.org\\/wiki\\/File:Knowledge-sharing.jpg","license":"http:\\/\\/creativecommons.org\\/licenses\\/by-sa\\/4.0"},"detailedDescription":{"articleBody":"Knowledge is a familiarity, awareness, or understanding of someone or something, such as facts, information, descriptions, or skills, which is acquired through experience or education by perceiving, discovering, or learning.\\n","url":"https:\\/\\/en.wikipedia.org\\/wiki\\/Knowledge","license":"https:\\/\\/en.wikipedia.org\\/wiki\\/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"}},"resultScore":23.775833}	0	2017-05-04 20:54:40	2017-05-04 20:54:40
10	/m/068hy	\N	\N	\N	0	2017-05-04 20:54:42	2017-05-04 20:54:42
11	/m/02wbm	\N	\N	\N	0	2017-05-04 20:54:43	2017-05-04 20:54:43
\.


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('topics_id_seq', 11, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, email, username, first_name, last_name, password, avatar, last_sign_in, created_at, updated_at, remember_token) FROM stdin;
1	user@test.com	Anonymous-x0qj5lom	\N	\N	$2y$10$.T0fRtVCp5MvfI39gUasmuaOeD6R201p3HN2jeaAJcHEdKEFNZ7f6	\N	\N	2017-05-04 20:54:29	2017-05-04 20:54:29	\N
2	user2@test.com	Anonymous-zky59q97	\N	\N	$2y$10$/pj64My.DMxPDkDUqvxKv.2zQFDpEXx.l7IUA2JPjShf7CRyryzIS	\N	\N	2017-05-04 20:54:29	2017-05-04 20:54:29	\N
3	social@test.com	Anonymous-k6lx7yx2	\N	\N	\N	\N	\N	2017-05-04 20:54:29	2017-05-04 20:54:29	\N
4	unverified@test.com	Anonymous-j0yrxy9z	\N	\N	$2y$10$FxicvGQouGPft8A2.C/AquVraAIPjY3qaS.nQmv0Dp9jrZ8ClTZ0q	\N	\N	2017-05-04 20:54:29	2017-05-04 20:54:29	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 4, true);


--
-- Data for Name: verifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY verifications (user_id, token, created_at) FROM stdin;
4	ed50a4fed68944eb096420e43e449563a5f7769c2280e1898bdedcf44d4fcc1b	2017-05-04 20:54:29
\.


--
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY videos (id, youtube_id, title, description, embeddable, privacy_status, published_at, created_at, updated_at) FROM stdin;
1	qrO4YZeyl0I	Lady Gaga - Bad Romance	LADY GAGA / JOANNE \nNEW ALBUM / OUT NOW\niTunes: http://smarturl.it/Joanne \nGoogle Play: http://smarturl.it/Joanne.gp \nAmazon: http://smarturl.it/Joanne.amz\nLadyGaga.com: http://smarturl.it/GagaStore\n\nFOLLOW LADY GAGA:\nhttp://www.facebook.com/ladygaga\nhttp://www.twitter.com/ladygaga\nhttp://www.instagram.com/ladygaga\nhttp://www.snapchat.com/add/ladygaga\nhttp://smarturl.it/LG.sp \n\nEMAIL LIST: \nhttp://smarturl.it/LadyGaga.News\n\nMusic video by Lady Gaga performing Bad Romance. (C) 2009 Interscope Records\n#VEVOCertified on January 31, 2010. http://www.vevo.com/certified http://www.youtube.com/vevocertified	t	public	2009-11-24 07:45:26	2017-05-04 20:54:29	2017-05-04 20:54:29
2	eQZEQQMWiVs	UH OH BIG BOY TAIL WHIPS AGAIN!	Finally a somewhat nice day has come in what has been a very cold February winter. Matty, BIG BOY and I went to a random skatepark by my cousins work for an awesome session. We rolled up there and it was a skatepark full of skateboarders, but they were absoultluy awesome and they had no issue with us getting a session in with them. Matty and BIG BOY did a lot on some ramps that they thought were going to be to small to ride Matty made BIG BOY learn how to do a bunch of new tricks like a whip over the bank to bank box. I called BIG BOY out on a bunch of tricks and as usual he gets completely broke off in some way and takes a crazy crash. I can't tell you how awesome it is to be back and going around to skatepark to skatepark with these boys. Thanks for watching, remember to subscribe and peace!	t	public	2017-02-11 21:03:37	2017-05-04 20:54:30	2017-05-04 20:54:30
3	uuIlvSNU67o	NEED ADVICE	A brief update on the backyard ramp before Spencer and I get some riding in. Got some cool announcements and some good footage in this one :)\nMERCH - http://LZBMX.COM\n\nSpencer's Channel - https://www.youtube.com/channel/UCQsNNWoGmf0tN2mi04c7hnA\n\nSong #1 by David Cutter\nhttps://www.davidcuttermusic.co.uk\nSong #2 by Ryan Little\nhttps://soundcloud.com/iamryanlittle	t	public	2017-02-11 16:42:16	2017-05-04 20:54:31	2017-05-04 20:54:31
4	UZPCp8SPfOM	Joe Rogan Experience #911 - Alex Jones & Eddie Bravo	Alex Jones is a radio show host, filmmaker, writer, and conspiracy theorist. Eddie Bravo is a jiujitsu black belt, music producer, and author.	t	public	2017-02-02 02:15:04	2017-05-04 20:54:32	2017-05-04 20:54:32
5	P8a4iiOnzsc	Radical Face 'Welcome Home'	http://www.radicalface.com\nhttp://youtube.com/radicalface\nhttp://facebook.com/radicalface\nhttp://twitter.com/radicalface\nhttps://www.instagram.com/radicalfaceofficial/\n\nWebstore: http://radicalface.shop.musictoday.com/store/\nPurchase/Steam: https://Nettwerk.lnk.to/radicalfaceYA\nApple Music: http://apple.co/1Vo1Vti\nTour: http://home.radicalface.com/shows\n\nDiscography\nThe Family Tree: The Leaves\nThe Bastards\nThe Family Tree: The Branches\nAlways Gold EP\nThe Family Tree: The Roots\nWelcome Home EP\nGhost\n\nDIRECTOR's web site:   http://www.justinmitchell.com	t	public	2009-06-02 22:32:19	2017-05-04 20:54:33	2017-05-04 20:54:33
6	mulGqCjMzCs	Running in Front of Cars	Instagram @Cherdleys https://www.instagram.com/cherdleys/\nSnapchat  @Cherdleys\nTwitter      @Cherdleys https://twitter.com/cherdleys\n\nCreated by Chad LeBaron AKA Cherdleys AKA One Of Those Kids That Hurts Cats\n\nWatch last video: https://www.youtube.com/watch?v=1uDu-...\n\nFollow Saxon:\nInstagram @OldManSaxon - https://www.instagram.com/oldmansaxon/	t	public	2016-02-23 15:31:46	2017-05-04 20:54:33	2017-05-04 20:54:33
7	-X_aCfVhWYI	EP35 - ONE WEEK LEFT - Pacific Crest Trail 2016	October 1, 2016 - PCT trail miles 2507.5 to 2522.1\nFollow me on https://www.instagram.com/zachrotondo/\n\nEnd screen music - soundcloud.com/lakeyinspired	t	public	2016-12-16 17:21:56	2017-05-04 20:54:34	2017-05-04 20:54:34
8	trteo6m23oA	Millionaire's Shop Tour // Mike Dubno	Me, Bill Livolsi, Jimmy Diresta, Daniel Switch and Lever, Laura Kampf and April Wilkerson went to have dinner at Mike Dubno house in Manhattan. One minute from Central Park where he has this awesome shop in his basement with all you can think of.\nThis visit has been really inspiring for me and since I had a camera I decided to release this experience to all of you.\nI hope this will be inspiring you too... :)\n\nHave a great one.	t	public	2017-01-22 13:02:36	2017-05-04 20:54:35	2017-05-04 20:54:35
9	Hu64xbgprWY	Universe - National Film Board of Canada (1960)	Universe is a black-and-white short documentary made in 1960 by the National Film Board of Canada. It dramatizes the nightly work of an astronomer at the David Dunlap Observatory in Richmond Hill, Ontario, a facility that is owned and operated by the University of Toronto, Canada. The film was a nominee at the 33rd Academy Awards in the category of Best Documentary Short Subject in 1961.	t	public	2013-06-18 15:03:22	2017-05-04 20:54:35	2017-05-04 20:54:35
10	7xTOj6VwaVc	The World's Worst Backpacker on the Pacific Crest Trail...	It's time for me to share the story of my first night on the Pacific Crest Trail. Don't try this at home! (... not that you could...)\nIf you've never hiked on the PCT, this video may be for you. You might also like it if you've had a trail chew you up and spit you out.\nThis video also serves as a preview to my new monologue, The World's Worst Backpacker - coming to Audible and iTunes this summer!\nFind out more at www.kenlasalle.com.	t	public	2016-05-16 23:16:20	2017-05-04 20:54:36	2017-05-04 20:54:36
11	UYG7FoneZZU	2016 Thru Hikers Part 4	https://www.gofundme.com/hikertrashvideo	t	public	2016-11-08 02:46:02	2017-05-04 20:54:36	2017-05-04 20:54:36
12	UNsIVfGptqM	Do You Need A College Degree For a System Administration Career?	It's one of the most popular questions I get: Is a college degree required for a System Administration Career?\n\n-Do I need a university degree for a tech career, in general?\n-How can I get my first Linux sysadmin job without a degree?\n\nIn this video I talk about the value of Degrees vs. the value of Education, and some career/learning strategies for people who don't have a college degree.\n\n3:18 - Education vs Experience\n4:09 - What to Study (High-Level overview in terms of University classes to emulate)\n6:10 - Theory vs. Practical Skill\n7:52 - How to Become a System Administrator (recommended learning path)\n10:02 - Practice + Theory work together to make you better\n\n\nBook Mentioned: Andrew Tanenbaum's Modern Operating Systems (4th ed) - http://amzn.to/2kcBc6a\n\nFull Linux Sysadmin Basics Playlist: https://www.youtube.com/playlist?list=PLtK75qxsQaMLZSo7KL-PmiRarU7hrpnwK\n\nCheck out my project-based Linux System Administration course (free sample videos): https://www.udemy.com/hands-on-linux-self-hosted-wordpress-for-linux-beginners/?couponCode=tl35\n\nOfficial Site: https://tutorialinux.com/\nTwitter: https://twitter.com/tutorialinux\nFacebook: https://www.facebook.com/tutorialinux\nPatreon: https://www.patreon.com/tutorialinux	t	public	2017-02-10 15:35:31	2017-05-04 20:54:37	2017-05-04 20:54:37
23	kE1mKj8awyY	My Top 10 Essential Documentaries	Previous Video ▶ http://bit.ly/2kkfZeI\n\nSubscribe For Daily Vids ▶ http://bit.ly/1KOilIP\nFollow My Snapchat ▶ http://snpcht.me/Mrhales100\nFollow My Twitter ▶ http://www.twitter.com/lahwf\nFollow My Instagram ▶ http://www.instagram.com/mrhales109\nLike the Facebook page ▶ http://www.facebook.com/lahwf\n\nSHIRTS ▶ http://shrsl.com/?e6xk\n\nSend Fan Mail to:\n5419 Hollywood Blvd, Ste. C825\nHollywood, CA 90027	t	public	2017-01-30 20:43:26	2017-05-04 20:54:44	2017-05-04 20:54:44
13	Gt_tUnf6T2E	The Truth About Dear White People: Racist Propaganda or Marketing Fail?	THURSDAY! These videos are my fave to make. Here goes nothing…\nWatch the Brand New Docuvlog!: https://youtu.be/SB3Se3dKBfo\nTheDeFrancoFam Vlog: https://youtu.be/_7K_Byz7Ah8\n————————————\nSTORIES:\n‘Dear White People’ Outrage:\nhttp://www.huffingtonpost.com/entry/netflix-boycott-dear-white-people_us_589cbb85e4b04061313c33eb\nhttp://www.revelist.com/tv/racists-boycott-netflix/6811\nhttp://www.telegraph.co.uk/tv/2017/02/09/dear-white-people-trailer-sparks-backlash-netflix-faces-claims/\nWatch The Movie: https://www.hulu.com/watch/850296\nhttps://www.amazon.com/White-People-Tyler-James-Williams/dp/B00OSQAP6G\n\nYouTube Sub Glitch:\nhttps://thenextweb.com/apps/2017/02/09/youtube-glitch-counter-channels/\nhttp://www.ibtimes.co.uk/youtube-finally-fixes-bug-causing-channels-lose-hundreds-subscribers-per-minute-1605713\n\nNBA 2K ELEAGUE:\nhttp://www.digitaltrends.com/gaming/nba-official-esports-league/\nhttp://www.espn.com/nba/story/_/id/18647863/nba-take-two-interactive-software-partnering-nba-2k-esports-league\nhttp://www.nba.com/article/2017/02/09/nba-video-game-company-launch-new-gaming-league-2018\n\nBaylor Sexual Assault Scandal:\nhttp://sportsday.dallasnews.com/college-sports/collegesports/2017/02/06/5-biggest-recent-revelations-baylors-sexual-assault-scandal\nhttp://www.tmz.com/2017/02/02/art-briles-alleged-text-messages/\nhttp://www.npr.org/2017/02/08/514172776/baylor-sanctioned-by-big-12-after-new-revelations-about-football-team-controvers\nhttp://www.dallasnews.com/news/baylor/2017/01/27/new-baylor-lawsuit-describes-show-em-good-time-culture-cites-52-rapes-football-players-4-years\nhttp://www.dallasnews.com/news/higher-education/2016/11/03/baylor-examining-sex-assault-claims-2011-2015\nhttp://www.foxnews.com/sports/2017/02/07/baylor-university-assistant-coach-fired-charged-with-soliciting-prostitute.html\n\n————————————\nFollow Me On Social:\nFACEBOOK: http://on.fb.me/mqpRW7\nTWITTER: http://Twitter.com/PhillyD\nINSTAGRAM: https://instagram.com/phillydefranco/\nSNAPCHAT: TheDeFrancoFam\nREDDIT: https://www.reddit.com/r/DeFranco\nITUNES: http://DeFrancoMistakes.com\nSOUNDCLOUD: http://letsmakemistakestogether.com\nGOOGLE PLAY: http://mistakeswithdefranco.com\n\nEdited by:\nJames Girardier - https://twitter.com/jamesgirardier\n\nProduced by:\nAmanda Morones - https://twitter.com/MandaOhDang\n\nMotion Graphics Artist\nBrian Borst - https://twitter.com/GrandpaHyde\n\nMailing Address:\nAttn: Philip DeFranco\n6433 Topanga Canyon Blvd #805\nCanoga Park, CA 91303	t	public	2017-02-09 22:30:03	2017-05-04 20:54:37	2017-05-04 20:54:37
14	KJC71dY13L8	I Need A Cat Dad	Happy Valentine's day!\nGHOST & STARS ▶ http://GhostAndStars\nHELP ME MAKE VIDEOS ▶ https://www.patreon.com/annaakana\n\nI need a cat dad - This super serious music video was created for Valentine's day so that whenever a potential cat dad (or mom!) pops up, you can send them this video with a "You, yes? ;)" and be as creepy as possible. \n\nbusiness\nAkanaActing@gmail.com\nTom Spriggs at The Coronel Group\n\nThanks Brad!\nhttp://youtube.com/BradGageComedy\n\nAudio mix by Jesse Cale\nhttps://www.youtube.com/user/TheOfficialMcSwagger\n\nshot and edited by Eric Lombart\nhttp://youtube.com/EricLombart\n\nmake up & hair by Melissa Tabares\nhttp://instagram.com/melissatabareshair\n\ngfx by Bethany Radloff\nhttp://youtube.com/BethBeRad	t	public	2017-02-09 21:06:12	2017-05-04 20:54:38	2017-05-04 20:54:38
15	qjYxXg4wZDg	My Epic Collab With Pewdiepie!!	I hope you enjoy my collab with Pewdiepie!\nHila is leaving me for this guy -- https://goo.gl/0yCVIX \n \nH3 Podcast is available at:\nITUNES -- https://goo.gl/desgTE\nGOOGLE PLAY MUSIC -- https://goo.gl/EnllKV\n \nTwitter...................... https://twitter.com/h3h3productions\nHila's Twitter............ https://twitter.com/hilakleinh3\nSpreadshirt.............. http://h3h3productions.spreadshirt.com\nInstagram................ http://instagram.com/h3h3productions\nHila's Instragram..... https://www.instagram.com/kleinhila\nWebsite.................... http://h3h3productions.com\nSubreddit................. http://reddit.com/r/h3h3productions\n \nTheme Song by MajorLeagueWobs:\nhttps://www.youtube.com/user/strangeholder\n \nPee on Yourself Challenge:\nhttps://www.youtube.com/watch?v=Zpdl_R90DVQ	t	public	2017-02-08 20:03:44	2017-05-04 20:54:39	2017-05-04 20:54:39
16	hbXDLKFkjm0	Water on the Moon?	NEW CHANNEL! http://youtube.com/sciencium\n\nFor a long time we thought the Moon was completely dry, but it turns out there are actually three sources of lunar water.\nThanks to Google Making and Science for supporting the new channel! http://youtube.com/makingscience\n\nThanks to Patreon supporters:\nNathan Hansen, Donal Botkin, Tony Fadell, Zach Mueller, Ron Neal\n\nSupport Veritasium on Patreon: http://bit.ly/VePatreon\n\nReferences:\nGreat history of water on the moon: https://arxiv.org/pdf/1205.5597.pdf\n\nFilmed by Raquel Nuno\n\nMusic from http://epidemicsound.com "Serene Story 2"	t	public	2017-02-08 14:30:01	2017-05-04 20:54:39	2017-05-04 20:54:39
17	j26ax_NDeek	idubbbz visits tana mongeau	Thank you for viewing\n \n For the full video visit: https://youtu.be/N8vaJaFCFYA\n __\n \n SUBSCRIBE â–º https://www.youtube.com/channel/UC-tsNNJ3yIW98MtPH6PWFAQ?sub_confirmation=1\n \n Main Channel â–º https://www.youtube.com/user/iDubbbzTV\n Second Channel â–º https://www.youtube.com/channel/UC-tsNNJ3yIW98MtPH6PWFAQ\n Gaming Channel â–º https://www.youtube.com/channel/UCVhfFXNY0z3-mbrTh1OYRXA\n \n Website â–º http://www.idubbbz.com/\n \n Instagram â–º https://instagram.com/idubbbz/\n Twitter â–º https://twitter.com/Idubbbz\n Facebook â–º http://www.facebook.com/IDubbbz\n Twitch â–º http://www.twitch.tv/idubbbz\n _	t	public	2017-02-06 23:11:44	2017-05-04 20:54:40	2017-05-04 20:54:40
18	7jjTnvFAG0w	Weird Frat Guy Taking Shots	Wait for it...\n\n\nConnect with Cherdleys:\n► https://www.facebook.com/cherdleys\n► https://www.instagram.com/cherdleys\n\nSupport Cherdleys ► https://www.patreon.com/cherdleys\nMerchandise► https://www.cherdleys.com\nSecond Channel ► http://bit.ly/2i6SuRX	t	public	2017-02-06 20:13:17	2017-05-04 20:54:40	2017-05-04 20:54:40
19	uqWUfTsEEOE	MY GIRL IS LEAVING ME FOR THIS GUY	Connor Murphy will steal your girl in seconds\nMaking Music with Post Malone -- https://goo.gl/gnpe3H\n \nH3 Podcast is available at:\n \nITUNES -- https://goo.gl/desgTE\nGOOGLE PLAY MUSIC -- https://goo.gl/EnllKV\n \nTwitter...................... https://twitter.com/h3h3productions\nHila's Twitter............ https://twitter.com/hilakleinh3\nSpreadshirt.............. http://h3h3productions.spreadshirt.com\nInstagram................ http://instagram.com/h3h3productions\nHila's Instragram..... https://www.instagram.com/kleinhila\nWebsite.................... http://h3h3productions.com\nSubreddit................. http://reddit.com/r/h3h3productions\n \nSource video:\nhttps://www.youtube.com/channel/UCwNPPl_oX8oUtKVMLxL13jg\n \nMusic:\n \n"Sweet as Honey" by Topher Mohr and Alex Elena\n \nBig Car Theft by Audionautix is licensed under a Creative Commons Attribution license (https://creativecommons.org/licenses/by/4.0/)\nArtist: http://audionautix.com/	t	public	2017-02-04 23:06:33	2017-05-04 20:54:41	2017-05-04 20:54:41
20	IjpvhYpLVMo	World's Cutest Dog	Please Subscribe ▶ http://bit.ly/1FmhXhC \nExtras & Vlogs ▶ https://www.youtube.com/user/LAHWFextra\nFollow My Twitter ▶ http://www.twitter.com/lahwf\nFollow My Instagram ▶ http://www.instagram.com/mrhales109\nLike the Facebook page! ▶ http://www.facebook.com/lahwf\nCreep on my snaps! ▶ http://snpcht.me/Mrhales100\n\nBonnie's Instagram ▶ https://www.instagram.com/bonnie_babies/\n\nLuke's Channel ▶ https://www.youtube.com/user/fLUKEy1989\nAryia's Channel ▶ https://www.youtube.com/user/SimpleSexyStupid\n\nSong:\nGymnopedie No 1 by Kevin MacLeod is licensed under a Creative Commons Attribution license (https://creativecommons.org/licenses/by/4.0/)\nSource: http://incompetech.com/music/royalty-free/index.html?isrc=USUAN1100787\nArtist: http://incompetech.com/\n\nSend Fan Mail to:\n5419 Hollywood Blvd, Ste. C825\nHollywood, CA 90027	t	public	2017-02-04 02:47:20	2017-05-04 20:54:41	2017-05-04 20:54:41
21	wDc2aDH3zMM	Best Stuffed Mushrooms Recipe	This stuffed mushrooms recipe makes a great appetizer and party dish --and it's pretty easy to make a bunch of these stuffed mushrooms at one time. Stuffed mushrooms are often filled with freshly grated Parmesan, garlic, and herbs, but it's a super versatile recipe...so experiment with your favorite flavors; I personally like a blue cheese and hot sauce combo thrown into the filling, and chopped nuts and toasted breadcrumbs can add a much needed crunchiness.\nA printable copy of this stuffed mushrooms recipe and more tips on how to prepare it can be found at  \nhttp://www.myfoodchannel.com/stuffed-mushrooms-recipe/\nGive this stuffed mushroom recipe a try and let me know what you think, and for more recipes check out the Chef Buck playlist:  \nhttp://www.youtube.com/playlist?list=PL2EFBD7E8FE2BB552 \nand to print all recipes visit my website at http://www.myfoodchannel.com/\n\nConnect with this media to catch all of my videos...thanks:\nMY OTHER YOUTUBE CHANNEL:  http://www.youtube.com/user/buckredbuck\nFACEBOOK \nhttp://www.facebook.com/buckredbuck\nTWITTER \nhttps://twitter.com/buckredbuck\nINSTAGRAM\nhttps://www.instagram.com/buckredbuck/\nGOOGLE+  \nhttp://plus.google.com/u/0/109193261972985167770/posts\nPRINT RECIPES AT MY WEBSITE:  \nhttp://www.myfoodchannel.com/\nRECIPE PLAYLISTS:  http://www.youtube.com/user/FromUnderTheRock\n\nWhat You Need for This Stuffed Mushrooms Recipe \n \n12-15 MUSHROOMS\n½ cup PANKO BREADCRUMBs\n1 TBSP BUTTER\nsome OLIVE OIL\nfilling mixture like...\n½ cup PARMESAN CHEESE\n½ cup BLUE CHEESE\n4-6 cloves GARLIC (finely chopped)\n½ cup PARSLEY (chopped)\n½ cup CASHEWS (chopped)\nsome HOT SAUCE\nSALT and PEPPER (to taste)\n...but fillings are optional\n\nHow To Make Stuffed Mushrooms\n\nBuy whole mushrooms that are uniform in size; I buy mushrooms that are not already pre-packaged, so I can select the best.\nChoose mushrooms that are firm and dry and store in the fridge in a paper sack until you are ready to use them.\nBefore using, clean mushrooms with a damp towel. \nremove the stems and use a knife or spoon to open the mushroom center and create more room for the stuffing.\nTake your time preparing the mushroom caps to avoid splitting them. \nI often set aside some of the stems to use in other recipes, while reserving some to chop and mix with the stuffing.\nCoat the mushroom caps lightly with olive oil and set aside.\nIn a bowl, combine some of the chopped stems and whatever fillings you desire.\nI often use an egg, minced garlic, freshly grated parmesan, and fresh chopped parsley with my filling, but\nthe variations are endless.\nBlue cheese is fantastic in stuffed mushrooms.\nFor added crunchiness, nuts are a great idea. I find that chopped cashews work very well.\nI'll often add ingredients to the stuffing mix as I stuff the mushrooms, which makes for a nice variety of flavors.\nSpoon the filling into the mushroom cap.\nIn a skillet, melt butter and add panko breadcrumbs. The breadcrumbs will soak up the butter and flavor.\nTop stuffed mushrooms with panko breadcrumbs and place on a rack over a baking sheet.\nPlace stuffed mushrooms in an oven pre-heated to 375 degrees F. and bake for approximately 30 minutes or until\nthe breadcrumb topping is nicely toasted.\nServe warm.\n\nGive this stuffed mushrooms recipe a try, and let me know what you think, and bon appétit!	t	public	2017-02-03 15:32:26	2017-05-04 20:54:42	2017-05-04 20:54:42
22	RVMZxH1TIIQ	Why Earth Is A Prison and How To Escape It	We are trapped on earth. Controlled by an ancient debt to the universe...\n\nLearn more about Ariane 6: http://www.airbusafran-launchers.com/en/universe/ariane-6-en/\n\nSupport us on Patreon so we can make more videos (and get cool stuff in return): https://www.patreon.com/Kurzgesagt?ty=h\n\nKurzgesagt merch here:  http://bit.ly/1P1hQIH\n\nGet the music of the video here: \n\nSoundcloud: http://bit.ly/2kqsiGb\nBandcamp: http://bit.ly/2kryP3c\nFacebook: https://www.facebook.com/epic-mountain-music\n \nTHANKS A LOT TO OUR LOVELY PATRONS FOR SUPPORTING US:\n\nJohn Wendeborn, Haan, Doktor Andy, Josh Gabbatiss, Peter Egger, Rick Lawrence, Eric Gao, 주영정, Jeff Threatt, Lars v., BurmansHealthShop, Ian White, Coty Rosenblath, SoraHavok, Andrew Berscheid, Jakub Zych, Eddie Han, Bubble Our Travel, Anton Ukhanev, Jan Pac, Mike, Martin Harding, Louis, Thomas G. Digranes, Todd, Mishal Alsuwyan, Liam Swann, Timothee Groleau, John Cido, Nicholas Bethencourt, Jeremy B Costella, Matthew Clarkson, Anna Chiara Brunetti, ValCab33, Neno Ganchev, Matt Saville, Klaas Pieter Annema, Peter Spalthoff, Andrew Campbell, Mads Bertheussen, Josué Barbosa dos Santos, Corey Hinds, Julian Fiander, BillDoor, Garrett Blackmon, Leeann Toland, Marshall Dow, Horia Constantin, Austin Hooper, Thomas E. Lee, Sylvain Milan, Jake Lee Kennedy, teddy zhang, Albinomaur, Casey Schad, Pearce Bergh, Dan Werdnly, Richard Patenaude, Moch Faisal Rasid, Antoine Dymond, James Hyde, Jonathan Verlohren, H.L.Hammons, Mikael Hannikainen, Kevin Douglass, Erik Onnen, Thiago Torres, Bryan Benninghoff, Frank Tuffner, Kevan Rynning, Aschwin Berkhout, Daniel Neilson, Damon Weil, Wesley Byrd, Bryan Andrade, Sergei Gaponov, Torodes, Ori Haski, Adam, Pavel Ševčík, Will Schmid, Alan Tran, Raoul Verhaegen, Fabercastel, Max, Youlia Hadzhidimova, Tristan Waddington, Bror Ronning, Santiago Campellone, Harjeet Taggar, James Horrocks, Brandon Bizzarro, Michel Vaillancourt, RHall, Brian David Henderson, Vikas Dhiman, Jack, Tomáš Miškov, Derral Gerken, Anthony, Vadim Golub, Fervidus, Justin Ritchie, Nicolas Dolgin, Harry, Andrew Miner, Rohan Dowd, Jesse Versluys, Juraj Trizna, André Léger, Peter Reynolds, Tom Handcock, Shaquille D. Johnson, HUISHI ZHANG, Robert S Peschel, Chris Bowley, Thomasz Kolosowski, Hogtree Octovish, Donovan Shickley, Bruce Hill, William Johnson, Ángel Garcia Casado, Riikka S, Daniel Moul, Daniel John, Anirudh Joshi, Robert, Iman, Jannis Kaiser, Andrew Bennett, Mariann Nagy, Daniel Kömpf, Philip Zapfel, Vince Gabor\n\nHelp us caption & translate this video!\n\nhttp://www.youtube.com/timedtext_cs_panel?c=UCsXVk37bltHxD1rDPwtNM8Q&tab=2\n\nOverpopulation – The Human Explosion Explained	t	public	2017-02-01 13:22:31	2017-05-04 20:54:43	2017-05-04 20:54:43
24	Q8ccXzM3x8A	The Case for String Theory - Sixty Symbols	Dr Tony Padilla  on why he thinks there's a compelling case for String Theory... This is one of our occasional longer-form interviews.\nLonger interviews with Ed Copeland: http://bit.ly/CopelandGoesLong\nOur visit to CERN: http://bit.ly/LHCvideos\nObjectivity: http://bit.ly/Objectivity\n\nDr Padilla is a cosmologist at the University of Nottingham - https://www.nottingham.ac.uk/physics/people/antonio.padilla\n\nVisit our website at http://www.sixtysymbols.com/\nWe're on Facebook at http://www.facebook.com/sixtysymbols\nAnd Twitter at http://twitter.com/sixtysymbols\nThis project features scientists from The University of Nottingham\nhttp://bit.ly/NottsPhysics\n\nPatreon: https://www.patreon.com/sixtysymbols\n\nSixty Symbols videos by Brady Haran\nhttp://www.bradyharanblog.com\n\nEmail list: http://eepurl.com/YdjL9\n\nExtra videos and images via CERN and ESO.\nMusic via Harri at freesound.org	t	public	2017-01-30 14:30:33	2017-05-04 20:54:45	2017-05-04 20:54:45
25	keYYiuOJdrE	The Master: How Scientology Works	Get a free 30 day trial of Audible here: http://www.audible.com/nerdwriter\n\nI WAS NOMINATED FOR A SHORTY! VOTE FOR ME HERE: http://shortyawards.com/9th/theenerdwriter\nNERDWRITER T-SHIRTS: https://store.dftba.com/products/the-nerdwriter-shirt\n\n\nSOURCES AND FURTHER READING:\n\nhttps://luckyottershaven.com/2017/01/15/why-scientology-auditing-is-not-at-all-like-traditional-psychotherapy-part-2/\n\nhttps://luckyottershaven.com/2017/01/14/why-scientology-auditing-is-not-at-all-like-traditional-psychotherapy-part-1/\n\nhttps://www.youtube.com/watch?v=dbmPVq6e2aA\n\nhttps://www.ncbi.nlm.nih.gov/pmc/articles/PMC3856510/\n\nMY RULES FOR SPONSORSHIPS:\n1) Sponsor cannot choose video topic.\n2) Sponsor cannot give notes or ask for changes.\n3) Sponsor cannot see video before it airs.\n4) Sponsorship will not be integrated into the video proper in any way, but only appear on the end-screen after a few seconds of black. \n5) I have to be sympathetic with the brand/client.	t	public	2017-01-26 15:01:31	2017-05-04 20:54:46	2017-05-04 20:54:46
26	9-5TSxd0ep0	Arcade Fire - Rebellion (Lies): Live at Earls Court	Arcade Fire : The Reflektor Tapes / Live At Earls Court released on DVD & BluRay on 27 January 2017. \n\nDVD - http://smarturl.it/REFLEKTORTAPESDVD\nBlu Ray - http://smarturl.it/REFLEKTORTAPESBR\n\nMusic video by Arcade Fire performing Rebellion (Lies). (C) 2016 Arcade Fire Music, LLC, exclusively licensed to Eagle Rock Entertainment Ltd.\n\nhttp://vevo.ly/ZPzbTY	t	public	2017-01-26 11:00:02	2017-05-04 20:54:46	2017-05-04 20:54:46
\.


--
-- Name: videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('videos_id_seq', 26, true);


--
-- Data for Name: videos_topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY videos_topics (id, topic_id, video_id, type) FROM stdin;
1	1	1	relevantTopicId
2	2	1	relevantTopicId
3	3	2	relevantTopicId
4	3	3	relevantTopicId
5	4	3	relevantTopicId
6	5	4	relevantTopicId
7	1	5	relevantTopicId
8	3	7	relevantTopicId
9	6	7	relevantTopicId
10	7	7	relevantTopicId
11	3	8	relevantTopicId
12	5	9	relevantTopicId
13	8	9	relevantTopicId
14	3	10	relevantTopicId
15	6	10	relevantTopicId
16	7	10	relevantTopicId
17	3	11	relevantTopicId
18	6	11	relevantTopicId
19	1	14	relevantTopicId
20	5	15	relevantTopicId
21	9	16	relevantTopicId
22	5	17	relevantTopicId
23	3	18	relevantTopicId
24	5	19	relevantTopicId
25	3	20	relevantTopicId
26	10	20	relevantTopicId
27	3	21	relevantTopicId
28	11	21	relevantTopicId
29	9	24	relevantTopicId
30	5	25	relevantTopicId
31	8	25	relevantTopicId
32	1	26	relevantTopicId
\.


--
-- Name: videos_topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('videos_topics_id_seq', 32, true);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: comments_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comments_votes
    ADD CONSTRAINT comments_votes_pkey PRIMARY KEY (id);


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
-- Name: comments_submission_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comments_submission_id_index ON comments USING btree (submission_id);


--
-- Name: comments_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comments_user_id_index ON comments USING btree (user_id);


--
-- Name: comments_votes_comment_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comments_votes_comment_id_index ON comments_votes USING btree (comment_id);


--
-- Name: comments_votes_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comments_votes_user_id_index ON comments_votes USING btree (user_id);


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
-- Name: comments_parent_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_parent_id_foreign FOREIGN KEY (parent_id) REFERENCES comments(id);


--
-- Name: comments_submission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_submission_id_foreign FOREIGN KEY (submission_id) REFERENCES submissions(id) ON DELETE CASCADE;


--
-- Name: comments_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_user_id_foreign FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: comments_votes_comment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comments_votes
    ADD CONSTRAINT comments_votes_comment_id_foreign FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE;


--
-- Name: comments_votes_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comments_votes
    ADD CONSTRAINT comments_votes_user_id_foreign FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


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

