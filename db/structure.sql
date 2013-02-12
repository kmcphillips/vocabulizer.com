--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: term_details; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE term_details (
    id integer NOT NULL,
    term_id integer,
    source character varying(255),
    definition text,
    example text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: term_details_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE term_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: term_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE term_details_id_seq OWNED BY term_details.id;


--
-- Name: terms; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE terms (
    id integer NOT NULL,
    value character varying(255),
    base_value character varying(255),
    type character varying(255),
    creator_id character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    top boolean DEFAULT false,
    urban boolean DEFAULT false
);


--
-- Name: terms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE terms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE terms_id_seq OWNED BY terms.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    username character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY term_details ALTER COLUMN id SET DEFAULT nextval('term_details_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY terms ALTER COLUMN id SET DEFAULT nextval('terms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: term_details_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY term_details
    ADD CONSTRAINT term_details_pkey PRIMARY KEY (id);


--
-- Name: terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY terms
    ADD CONSTRAINT terms_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_term_details_on_term_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_term_details_on_term_id ON term_details USING btree (term_id);


--
-- Name: index_terms_on_base_value; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_terms_on_base_value ON terms USING btree (base_value);


--
-- Name: index_terms_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_terms_on_creator_id ON terms USING btree (creator_id);


--
-- Name: index_terms_on_top; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_terms_on_top ON terms USING btree (top);


--
-- Name: index_terms_on_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_terms_on_type ON terms USING btree (type);


--
-- Name: index_terms_on_urban; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_terms_on_urban ON terms USING btree (urban);


--
-- Name: index_terms_on_value; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_terms_on_value ON terms USING btree (value);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_username ON users USING btree (username);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20121021192205');

INSERT INTO schema_migrations (version) VALUES ('20121021195055');

INSERT INTO schema_migrations (version) VALUES ('20121022014348');

INSERT INTO schema_migrations (version) VALUES ('20130212135414');