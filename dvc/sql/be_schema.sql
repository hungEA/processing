--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1 (Debian 13.1-1.pgdg100+1)
-- Dumped by pg_dump version 13.1 (Debian 13.1-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: app_config_appvalueconfig; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.app_config_appvalueconfig (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(32) NOT NULL,
    value character varying(64) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.app_config_appvalueconfig OWNER TO ipno;

--
-- Name: app_config_appconfig_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.app_config_appconfig_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_config_appconfig_id_seq OWNER TO ipno;

--
-- Name: app_config_appconfig_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.app_config_appconfig_id_seq OWNED BY public.app_config_appvalueconfig.id;


--
-- Name: app_config_apptextcontent; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.app_config_apptextcontent (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(32) NOT NULL,
    value text,
    description text NOT NULL
);


ALTER TABLE public.app_config_apptextcontent OWNER TO ipno;

--
-- Name: app_config_apptextcontent_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.app_config_apptextcontent_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_config_apptextcontent_id_seq OWNER TO ipno;

--
-- Name: app_config_apptextcontent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.app_config_apptextcontent_id_seq OWNED BY public.app_config_apptextcontent.id;


--
-- Name: app_config_frontpagecard; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.app_config_frontpagecard (
    id integer NOT NULL,
    "order" integer NOT NULL,
    content text NOT NULL,
    CONSTRAINT app_config_frontpagecard_order_check CHECK (("order" >= 0))
);


ALTER TABLE public.app_config_frontpagecard OWNER TO ipno;

--
-- Name: app_config_frontpagecard_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.app_config_frontpagecard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_config_frontpagecard_id_seq OWNER TO ipno;

--
-- Name: app_config_frontpagecard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.app_config_frontpagecard_id_seq OWNED BY public.app_config_frontpagecard.id;


--
-- Name: app_config_frontpageorder; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.app_config_frontpageorder (
    id integer NOT NULL,
    section character varying(50) NOT NULL,
    "order" integer NOT NULL,
    CONSTRAINT app_config_frontpageorder_order_check CHECK (("order" >= 0))
);


ALTER TABLE public.app_config_frontpageorder OWNER TO ipno;

--
-- Name: app_config_frontpageorder_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.app_config_frontpageorder_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_config_frontpageorder_id_seq OWNER TO ipno;

--
-- Name: app_config_frontpageorder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.app_config_frontpageorder_id_seq OWNED BY public.app_config_frontpageorder.id;


--
-- Name: appeals_appeal; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.appeals_appeal (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    appeal_uid character varying(255) NOT NULL,
    charging_supervisor character varying(255),
    appeal_disposition character varying(255),
    action_appealed character varying(255),
    motions character varying(255),
    department_id integer,
    officer_id integer,
    agency character varying(255),
    uid character varying(255)
);


ALTER TABLE public.appeals_appeal OWNER TO ipno;

--
-- Name: appeals_appeal_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.appeals_appeal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appeals_appeal_id_seq OWNER TO ipno;

--
-- Name: appeals_appeal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.appeals_appeal_id_seq OWNED BY public.appeals_appeal.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO ipno;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO ipno;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO ipno;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO ipno;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO ipno;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO ipno;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authentication_user; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.authentication_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    email character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    is_admin boolean NOT NULL,
    recent_items jsonb,
    recent_queries character varying(255)[]
);


ALTER TABLE public.authentication_user OWNER TO ipno;

--
-- Name: authentication_user_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.authentication_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authentication_user_id_seq OWNER TO ipno;

--
-- Name: authentication_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.authentication_user_id_seq OWNED BY public.authentication_user.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO ipno;

--
-- Name: citizens_citizen; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.citizens_citizen (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    citizen_uid character varying(255) NOT NULL,
    allegation_uid character varying(255),
    uof_uid character varying(255),
    citizen_influencing_factors character varying(255),
    citizen_arrested character varying(255),
    citizen_hospitalized character varying(255),
    citizen_injured character varying(255),
    citizen_age integer,
    citizen_race character varying(255),
    citizen_sex character varying(255),
    agency character varying(255),
    complaint_id integer,
    department_id integer,
    use_of_force_id integer
);


ALTER TABLE public.citizens_citizen OWNER TO ipno;

--
-- Name: citizens_citizen_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.citizens_citizen_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.citizens_citizen_id_seq OWNER TO ipno;

--
-- Name: citizens_citizen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.citizens_citizen_id_seq OWNED BY public.citizens_citizen.id;


--
-- Name: complaints_complaint; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.complaints_complaint (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    action character varying(255),
    disposition character varying(255),
    allegation text,
    allegation_uid character varying(255),
    allegation_desc text,
    tracking_id character varying(255),
    uid character varying(255),
    agency character varying(255)
);


ALTER TABLE public.complaints_complaint OWNER TO ipno;

--
-- Name: complaints_complaint_departments; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.complaints_complaint_departments (
    id integer NOT NULL,
    complaint_id integer NOT NULL,
    department_id integer NOT NULL
);


ALTER TABLE public.complaints_complaint_departments OWNER TO ipno;

--
-- Name: complaints_complaint_departments_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.complaints_complaint_departments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.complaints_complaint_departments_id_seq OWNER TO ipno;

--
-- Name: complaints_complaint_departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.complaints_complaint_departments_id_seq OWNED BY public.complaints_complaint_departments.id;


--
-- Name: complaints_complaint_events; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.complaints_complaint_events (
    id integer NOT NULL,
    complaint_id integer NOT NULL,
    event_id integer NOT NULL
);


ALTER TABLE public.complaints_complaint_events OWNER TO ipno;

--
-- Name: complaints_complaint_events_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.complaints_complaint_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.complaints_complaint_events_id_seq OWNER TO ipno;

--
-- Name: complaints_complaint_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.complaints_complaint_events_id_seq OWNED BY public.complaints_complaint_events.id;


--
-- Name: complaints_complaint_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.complaints_complaint_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.complaints_complaint_id_seq OWNER TO ipno;

--
-- Name: complaints_complaint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.complaints_complaint_id_seq OWNED BY public.complaints_complaint.id;


--
-- Name: complaints_complaint_officers; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.complaints_complaint_officers (
    id integer NOT NULL,
    complaint_id integer NOT NULL,
    officer_id integer NOT NULL
);


ALTER TABLE public.complaints_complaint_officers OWNER TO ipno;

--
-- Name: complaints_complaint_officers_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.complaints_complaint_officers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.complaints_complaint_officers_id_seq OWNER TO ipno;

--
-- Name: complaints_complaint_officers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.complaints_complaint_officers_id_seq OWNED BY public.complaints_complaint_officers.id;


--
-- Name: data_importlog; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.data_importlog (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    data_model character varying(255) NOT NULL,
    repo_name character varying(255),
    commit_hash character varying(255),
    status character varying(32) NOT NULL,
    created_rows integer,
    updated_rows integer,
    deleted_rows integer,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    error_message text
);


ALTER TABLE public.data_importlog OWNER TO ipno;

--
-- Name: data_importlog_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.data_importlog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_importlog_id_seq OWNER TO ipno;

--
-- Name: data_importlog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.data_importlog_id_seq OWNED BY public.data_importlog.id;


--
-- Name: data_wrglrepo; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.data_wrglrepo (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    data_model character varying(255) NOT NULL,
    repo_name character varying(255) NOT NULL,
    commit_hash character varying(255),
    latest_commit_hash character varying(255)
);


ALTER TABLE public.data_wrglrepo OWNER TO ipno;

--
-- Name: data_wrglrepo_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.data_wrglrepo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.data_wrglrepo_id_seq OWNER TO ipno;

--
-- Name: data_wrglrepo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.data_wrglrepo_id_seq OWNED BY public.data_wrglrepo.id;


--
-- Name: departments_department; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.departments_department (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    agency_name character varying(255) NOT NULL,
    city character varying(255),
    parish character varying(255),
    location_map_url character varying(255),
    agency_slug character varying(255) NOT NULL,
    data_period integer[],
    address character varying(255),
    phone character varying(255),
    location character varying(63),
    aliases character varying(255)[],
    officer_fraction double precision
);


ALTER TABLE public.departments_department OWNER TO ipno;

--
-- Name: departments_department_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.departments_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departments_department_id_seq OWNER TO ipno;

--
-- Name: departments_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.departments_department_id_seq OWNED BY public.departments_department.id;


--
-- Name: departments_department_starred_documents; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.departments_department_starred_documents (
    id integer NOT NULL,
    department_id integer NOT NULL,
    document_id integer NOT NULL
);


ALTER TABLE public.departments_department_starred_documents OWNER TO ipno;

--
-- Name: departments_department_starred_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.departments_department_starred_documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departments_department_starred_documents_id_seq OWNER TO ipno;

--
-- Name: departments_department_starred_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.departments_department_starred_documents_id_seq OWNED BY public.departments_department_starred_documents.id;


--
-- Name: departments_department_starred_news_articles; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.departments_department_starred_news_articles (
    id integer NOT NULL,
    department_id integer NOT NULL,
    newsarticle_id integer NOT NULL
);


ALTER TABLE public.departments_department_starred_news_articles OWNER TO ipno;

--
-- Name: departments_department_starred_news_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.departments_department_starred_news_articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departments_department_starred_news_articles_id_seq OWNER TO ipno;

--
-- Name: departments_department_starred_news_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.departments_department_starred_news_articles_id_seq OWNED BY public.departments_department_starred_news_articles.id;


--
-- Name: departments_department_starred_officers; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.departments_department_starred_officers (
    id integer NOT NULL,
    department_id integer NOT NULL,
    officer_id integer NOT NULL
);


ALTER TABLE public.departments_department_starred_officers OWNER TO ipno;

--
-- Name: departments_department_starred_officers_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.departments_department_starred_officers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departments_department_starred_officers_id_seq OWNER TO ipno;

--
-- Name: departments_department_starred_officers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.departments_department_starred_officers_id_seq OWNED BY public.departments_department_starred_officers.id;


--
-- Name: departments_officermovement; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.departments_officermovement (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    date date NOT NULL,
    left_reason character varying(255),
    end_department_id integer NOT NULL,
    officer_id integer NOT NULL,
    start_department_id integer NOT NULL
);


ALTER TABLE public.departments_officermovement OWNER TO ipno;

--
-- Name: departments_officermovement_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.departments_officermovement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departments_officermovement_id_seq OWNER TO ipno;

--
-- Name: departments_officermovement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.departments_officermovement_id_seq OWNED BY public.departments_officermovement.id;


--
-- Name: departments_wrglfile; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.departments_wrglfile (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    slug character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    download_url character varying(255) NOT NULL,
    "position" integer NOT NULL,
    default_expanded boolean NOT NULL,
    department_id integer
);


ALTER TABLE public.departments_wrglfile OWNER TO ipno;

--
-- Name: departments_wrglfile_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.departments_wrglfile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.departments_wrglfile_id_seq OWNER TO ipno;

--
-- Name: departments_wrglfile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.departments_wrglfile_id_seq OWNED BY public.departments_wrglfile.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.django_admin_log (
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


ALTER TABLE public.django_admin_log OWNER TO ipno;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO ipno;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_celery_results_chordcounter; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.django_celery_results_chordcounter (
    id integer NOT NULL,
    group_id character varying(255) NOT NULL,
    sub_tasks text NOT NULL,
    count integer NOT NULL,
    CONSTRAINT django_celery_results_chordcounter_count_check CHECK ((count >= 0))
);


ALTER TABLE public.django_celery_results_chordcounter OWNER TO ipno;

--
-- Name: django_celery_results_chordcounter_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.django_celery_results_chordcounter_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_results_chordcounter_id_seq OWNER TO ipno;

--
-- Name: django_celery_results_chordcounter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.django_celery_results_chordcounter_id_seq OWNED BY public.django_celery_results_chordcounter.id;


--
-- Name: django_celery_results_groupresult; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.django_celery_results_groupresult (
    id integer NOT NULL,
    group_id character varying(255) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_done timestamp with time zone NOT NULL,
    content_type character varying(128) NOT NULL,
    content_encoding character varying(64) NOT NULL,
    result text
);


ALTER TABLE public.django_celery_results_groupresult OWNER TO ipno;

--
-- Name: django_celery_results_groupresult_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.django_celery_results_groupresult_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_results_groupresult_id_seq OWNER TO ipno;

--
-- Name: django_celery_results_groupresult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.django_celery_results_groupresult_id_seq OWNED BY public.django_celery_results_groupresult.id;


--
-- Name: django_celery_results_taskresult; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.django_celery_results_taskresult (
    id integer NOT NULL,
    task_id character varying(255) NOT NULL,
    status character varying(50) NOT NULL,
    content_type character varying(128) NOT NULL,
    content_encoding character varying(64) NOT NULL,
    result text,
    date_done timestamp with time zone NOT NULL,
    traceback text,
    meta text,
    task_args text,
    task_kwargs text,
    task_name character varying(255),
    worker character varying(100),
    date_created timestamp with time zone NOT NULL,
    periodic_task_name character varying(255)
);


ALTER TABLE public.django_celery_results_taskresult OWNER TO ipno;

--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.django_celery_results_taskresult_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_results_taskresult_id_seq OWNER TO ipno;

--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.django_celery_results_taskresult_id_seq OWNED BY public.django_celery_results_taskresult.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO ipno;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO ipno;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO ipno;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO ipno;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_rest_passwordreset_resetpasswordtoken; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.django_rest_passwordreset_resetpasswordtoken (
    created_at timestamp with time zone NOT NULL,
    key character varying(64) NOT NULL,
    ip_address inet,
    user_agent character varying(256) NOT NULL,
    user_id integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.django_rest_passwordreset_resetpasswordtoken OWNER TO ipno;

--
-- Name: django_rest_passwordreset_resetpasswordtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.django_rest_passwordreset_resetpasswordtoken_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_rest_passwordreset_resetpasswordtoken_id_seq OWNER TO ipno;

--
-- Name: django_rest_passwordreset_resetpasswordtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.django_rest_passwordreset_resetpasswordtoken_id_seq OWNED BY public.django_rest_passwordreset_resetpasswordtoken.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO ipno;

--
-- Name: documents_document; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.documents_document (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    title character varying(255),
    document_type character varying(255),
    preview_image_url character varying(255),
    url character varying(255),
    incident_date date,
    pages_count integer,
    text_content text,
    accused character varying(255),
    day integer,
    docid character varying(255),
    pdf_db_path character varying(255),
    month integer,
    year integer,
    pdf_db_content_hash character varying(255),
    hrg_no character varying(255),
    matched_uid character varying(255),
    txt_db_content_hash character varying(255),
    txt_db_id character varying(255),
    hrg_type character varying(255),
    agency character varying(255),
    dt_source character varying(255),
    hrg_text text,
    pdf_db_id character varying(255),
    txt_db_path character varying(255)
);


ALTER TABLE public.documents_document OWNER TO ipno;

--
-- Name: documents_document_departments; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.documents_document_departments (
    id integer NOT NULL,
    document_id integer NOT NULL,
    department_id integer NOT NULL
);


ALTER TABLE public.documents_document_departments OWNER TO ipno;

--
-- Name: documents_document_departments_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.documents_document_departments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_document_departments_id_seq OWNER TO ipno;

--
-- Name: documents_document_departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.documents_document_departments_id_seq OWNED BY public.documents_document_departments.id;


--
-- Name: documents_document_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.documents_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_document_id_seq OWNER TO ipno;

--
-- Name: documents_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.documents_document_id_seq OWNED BY public.documents_document.id;


--
-- Name: documents_document_officers; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.documents_document_officers (
    id integer NOT NULL,
    document_id integer NOT NULL,
    officer_id integer NOT NULL
);


ALTER TABLE public.documents_document_officers OWNER TO ipno;

--
-- Name: documents_document_officers_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.documents_document_officers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documents_document_officers_id_seq OWNER TO ipno;

--
-- Name: documents_document_officers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.documents_document_officers_id_seq OWNED BY public.documents_document_officers.id;


--
-- Name: feedbacks_feedback; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.feedbacks_feedback (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    email character varying(255),
    message text
);


ALTER TABLE public.feedbacks_feedback OWNER TO ipno;

--
-- Name: feedbacks_feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.feedbacks_feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedbacks_feedback_id_seq OWNER TO ipno;

--
-- Name: feedbacks_feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.feedbacks_feedback_id_seq OWNED BY public.feedbacks_feedback.id;


--
-- Name: historical_data_anonymousitem; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.historical_data_anonymousitem (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    item_id character varying(255) NOT NULL,
    item_type character varying(255) NOT NULL,
    last_visited timestamp with time zone NOT NULL
);


ALTER TABLE public.historical_data_anonymousitem OWNER TO ipno;

--
-- Name: historical_data_anonymousitem_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.historical_data_anonymousitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.historical_data_anonymousitem_id_seq OWNER TO ipno;

--
-- Name: historical_data_anonymousitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.historical_data_anonymousitem_id_seq OWNED BY public.historical_data_anonymousitem.id;


--
-- Name: historical_data_anonymousquery; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.historical_data_anonymousquery (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    query character varying(255) NOT NULL,
    last_visited timestamp with time zone NOT NULL
);


ALTER TABLE public.historical_data_anonymousquery OWNER TO ipno;

--
-- Name: historical_data_anonymousquery_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.historical_data_anonymousquery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.historical_data_anonymousquery_id_seq OWNER TO ipno;

--
-- Name: historical_data_anonymousquery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.historical_data_anonymousquery_id_seq OWNED BY public.historical_data_anonymousquery.id;


--
-- Name: ipno_cache_table; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.ipno_cache_table (
    cache_key character varying(255) NOT NULL,
    value text NOT NULL,
    expires timestamp with time zone NOT NULL
);


ALTER TABLE public.ipno_cache_table OWNER TO ipno;

--
-- Name: news_articles_crawledpost; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.news_articles_crawledpost (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    post_guid character varying(255) NOT NULL,
    source_id integer
);


ALTER TABLE public.news_articles_crawledpost OWNER TO ipno;

--
-- Name: news_articles_crawledpost_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.news_articles_crawledpost_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_articles_crawledpost_id_seq OWNER TO ipno;

--
-- Name: news_articles_crawledpost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.news_articles_crawledpost_id_seq OWNED BY public.news_articles_crawledpost.id;


--
-- Name: news_articles_crawlererror; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.news_articles_crawlererror (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    response_url character varying(10000) NOT NULL,
    response_status_code character varying(32) NOT NULL,
    error_message text,
    log_id integer NOT NULL
);


ALTER TABLE public.news_articles_crawlererror OWNER TO ipno;

--
-- Name: news_articles_crawlererror_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.news_articles_crawlererror_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_articles_crawlererror_id_seq OWNER TO ipno;

--
-- Name: news_articles_crawlererror_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.news_articles_crawlererror_id_seq OWNED BY public.news_articles_crawlererror.id;


--
-- Name: news_articles_crawlerlog; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.news_articles_crawlerlog (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    status character varying(32) NOT NULL,
    created_rows integer,
    error_rows integer,
    source_id integer
);


ALTER TABLE public.news_articles_crawlerlog OWNER TO ipno;

--
-- Name: news_articles_crawlerlog_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.news_articles_crawlerlog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_articles_crawlerlog_id_seq OWNER TO ipno;

--
-- Name: news_articles_crawlerlog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.news_articles_crawlerlog_id_seq OWNED BY public.news_articles_crawlerlog.id;


--
-- Name: news_articles_excludeofficer; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.news_articles_excludeofficer (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    ran_at timestamp with time zone
);


ALTER TABLE public.news_articles_excludeofficer OWNER TO ipno;

--
-- Name: news_articles_excludeofficer_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.news_articles_excludeofficer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_articles_excludeofficer_id_seq OWNER TO ipno;

--
-- Name: news_articles_excludeofficer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.news_articles_excludeofficer_id_seq OWNED BY public.news_articles_excludeofficer.id;


--
-- Name: news_articles_excludeofficer_officers; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.news_articles_excludeofficer_officers (
    id integer NOT NULL,
    excludeofficer_id integer NOT NULL,
    officer_id integer NOT NULL
);


ALTER TABLE public.news_articles_excludeofficer_officers OWNER TO ipno;

--
-- Name: news_articles_excludeofficer_officers_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.news_articles_excludeofficer_officers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_articles_excludeofficer_officers_id_seq OWNER TO ipno;

--
-- Name: news_articles_excludeofficer_officers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.news_articles_excludeofficer_officers_id_seq OWNED BY public.news_articles_excludeofficer_officers.id;


--
-- Name: news_articles_matchedsentence; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.news_articles_matchedsentence (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    text text NOT NULL,
    extracted_keywords character varying(50)[],
    article_id integer NOT NULL
);


ALTER TABLE public.news_articles_matchedsentence OWNER TO ipno;

--
-- Name: news_articles_matchedsentence_excluded_officers; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.news_articles_matchedsentence_excluded_officers (
    id integer NOT NULL,
    matchedsentence_id integer NOT NULL,
    officer_id integer NOT NULL
);


ALTER TABLE public.news_articles_matchedsentence_excluded_officers OWNER TO ipno;

--
-- Name: news_articles_matchedsentence_excluded_officers_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.news_articles_matchedsentence_excluded_officers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_articles_matchedsentence_excluded_officers_id_seq OWNER TO ipno;

--
-- Name: news_articles_matchedsentence_excluded_officers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.news_articles_matchedsentence_excluded_officers_id_seq OWNED BY public.news_articles_matchedsentence_excluded_officers.id;


--
-- Name: news_articles_matchedsentence_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.news_articles_matchedsentence_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_articles_matchedsentence_id_seq OWNER TO ipno;

--
-- Name: news_articles_matchedsentence_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.news_articles_matchedsentence_id_seq OWNED BY public.news_articles_matchedsentence.id;


--
-- Name: news_articles_matchedsentence_officers; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.news_articles_matchedsentence_officers (
    id integer NOT NULL,
    matchedsentence_id integer NOT NULL,
    officer_id integer NOT NULL
);


ALTER TABLE public.news_articles_matchedsentence_officers OWNER TO ipno;

--
-- Name: news_articles_matchedsentence_officers_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.news_articles_matchedsentence_officers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_articles_matchedsentence_officers_id_seq OWNER TO ipno;

--
-- Name: news_articles_matchedsentence_officers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.news_articles_matchedsentence_officers_id_seq OWNED BY public.news_articles_matchedsentence_officers.id;


--
-- Name: news_articles_matchingkeyword; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.news_articles_matchingkeyword (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    ran_at timestamp with time zone,
    keywords character varying(50)[]
);


ALTER TABLE public.news_articles_matchingkeyword OWNER TO ipno;

--
-- Name: news_articles_matchingkeyword_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.news_articles_matchingkeyword_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_articles_matchingkeyword_id_seq OWNER TO ipno;

--
-- Name: news_articles_matchingkeyword_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.news_articles_matchingkeyword_id_seq OWNED BY public.news_articles_matchingkeyword.id;


--
-- Name: news_articles_newsarticle; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.news_articles_newsarticle (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    guid character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    link text NOT NULL,
    content text NOT NULL,
    published_date date NOT NULL,
    author character varying(255),
    url character varying(255),
    source_id integer,
    is_processed boolean NOT NULL,
    is_hidden boolean NOT NULL
);


ALTER TABLE public.news_articles_newsarticle OWNER TO ipno;

--
-- Name: news_articles_newsarticle_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.news_articles_newsarticle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_articles_newsarticle_id_seq OWNER TO ipno;

--
-- Name: news_articles_newsarticle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.news_articles_newsarticle_id_seq OWNED BY public.news_articles_newsarticle.id;


--
-- Name: news_articles_newsarticlesource; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.news_articles_newsarticlesource (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    source_name character varying(255) NOT NULL,
    source_display_name character varying(255) NOT NULL
);


ALTER TABLE public.news_articles_newsarticlesource OWNER TO ipno;

--
-- Name: news_articles_newsarticlesource_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.news_articles_newsarticlesource_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.news_articles_newsarticlesource_id_seq OWNER TO ipno;

--
-- Name: news_articles_newsarticlesource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.news_articles_newsarticlesource_id_seq OWNED BY public.news_articles_newsarticlesource.id;


--
-- Name: officers_event; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.officers_event (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    event_uid character varying(255) NOT NULL,
    kind character varying(255),
    year integer,
    month integer,
    day integer,
    "time" character varying(255),
    raw_date character varying(255),
    allegation_uid character varying(255),
    appeal_uid character varying(255),
    badge_no character varying(255),
    department_code character varying(255),
    department_desc character varying(255),
    rank_code character varying(255),
    rank_desc character varying(255),
    department_id integer,
    officer_id integer,
    use_of_force_id integer,
    salary numeric(8,2),
    salary_freq character varying(255),
    appeal_id integer,
    left_reason character varying(255),
    agency character varying(255),
    uid character varying(255),
    uof_uid character varying(255),
    division_desc character varying(255),
    overtime_annual_total numeric(8,2)
);


ALTER TABLE public.officers_event OWNER TO ipno;

--
-- Name: officers_event_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.officers_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.officers_event_id_seq OWNER TO ipno;

--
-- Name: officers_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.officers_event_id_seq OWNED BY public.officers_event.id;


--
-- Name: officers_officer; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.officers_officer (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    uid character varying(255) NOT NULL,
    last_name character varying(255),
    middle_name character varying(255),
    first_name character varying(255),
    birth_year integer,
    birth_month integer,
    birth_day integer,
    race character varying(255),
    person_id integer,
    -- is_name_changed boolean NOT NULL,
    sex character varying(255),
    agency character varying(255),
    department_id integer,
    -- aliases character varying(255)[],
    complaint_fraction double precision
);


ALTER TABLE public.officers_officer OWNER TO ipno;

--
-- Name: officers_officer_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.officers_officer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.officers_officer_id_seq OWNER TO ipno;

--
-- Name: officers_officer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.officers_officer_id_seq OWNED BY public.officers_officer.id;


--
-- Name: people_person; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.people_person (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    person_id character varying(255),
    canonical_officer_id integer NOT NULL,
    all_complaints_count integer,
    canonical_uid character varying(255),
    uid character varying(255)
);


ALTER TABLE public.people_person OWNER TO ipno;

--
-- Name: people_person_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.people_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.people_person_id_seq OWNER TO ipno;

--
-- Name: people_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.people_person_id_seq OWNED BY public.people_person.id;


--
-- Name: q_and_a_question; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.q_and_a_question (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    question text NOT NULL,
    answer text,
    section_id integer NOT NULL
);


ALTER TABLE public.q_and_a_question OWNER TO ipno;

--
-- Name: q_and_a_question_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.q_and_a_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.q_and_a_question_id_seq OWNER TO ipno;

--
-- Name: q_and_a_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.q_and_a_question_id_seq OWNED BY public.q_and_a_question.id;


--
-- Name: q_and_a_section; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.q_and_a_section (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    "order" integer NOT NULL,
    name character varying(32) NOT NULL,
    CONSTRAINT q_and_a_section_order_check CHECK (("order" >= 0))
);


ALTER TABLE public.q_and_a_section OWNER TO ipno;

--
-- Name: q_and_a_section_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.q_and_a_section_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.q_and_a_section_id_seq OWNER TO ipno;

--
-- Name: q_and_a_section_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.q_and_a_section_id_seq OWNED BY public.q_and_a_section.id;


--
-- Name: tasks_task; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.tasks_task (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    task_name character varying(255) NOT NULL,
    command character varying(255) NOT NULL,
    task_type character varying(32) NOT NULL,
    should_run boolean NOT NULL
);


ALTER TABLE public.tasks_task OWNER TO ipno;

--
-- Name: tasks_task_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.tasks_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_task_id_seq OWNER TO ipno;

--
-- Name: tasks_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.tasks_task_id_seq OWNED BY public.tasks_task.id;


--
-- Name: tasks_tasklog; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.tasks_tasklog (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    finished_at timestamp with time zone,
    task_id integer NOT NULL,
    error_message text
);


ALTER TABLE public.tasks_tasklog OWNER TO ipno;

--
-- Name: tasks_tasklog_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.tasks_tasklog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_tasklog_id_seq OWNER TO ipno;

--
-- Name: tasks_tasklog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.tasks_tasklog_id_seq OWNED BY public.tasks_tasklog.id;


--
-- Name: token_blacklist_blacklistedtoken; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.token_blacklist_blacklistedtoken (
    id integer NOT NULL,
    blacklisted_at timestamp with time zone NOT NULL,
    token_id integer NOT NULL
);


ALTER TABLE public.token_blacklist_blacklistedtoken OWNER TO ipno;

--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.token_blacklist_blacklistedtoken_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.token_blacklist_blacklistedtoken_id_seq OWNER TO ipno;

--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.token_blacklist_blacklistedtoken_id_seq OWNED BY public.token_blacklist_blacklistedtoken.id;


--
-- Name: token_blacklist_outstandingtoken; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.token_blacklist_outstandingtoken (
    id integer NOT NULL,
    token text NOT NULL,
    created_at timestamp with time zone,
    expires_at timestamp with time zone NOT NULL,
    user_id integer,
    jti character varying(255) NOT NULL
);


ALTER TABLE public.token_blacklist_outstandingtoken OWNER TO ipno;

--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.token_blacklist_outstandingtoken_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.token_blacklist_outstandingtoken_id_seq OWNER TO ipno;

--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.token_blacklist_outstandingtoken_id_seq OWNED BY public.token_blacklist_outstandingtoken.id;


--
-- Name: use_of_forces_useofforce; Type: TABLE; Schema: public; Owner: ipno
--

CREATE TABLE public.use_of_forces_useofforce (
    id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    uof_uid character varying(255) NOT NULL,
    service_type character varying(255),
    disposition character varying(255),
    department_id integer,
    agency character varying(255),
    tracking_id character varying(255),
    use_of_force_reason character varying(255),
    officer_injured character varying(255),
    uid character varying(255),
    use_of_force_description character varying(255),
    officer_id integer
);


ALTER TABLE public.use_of_forces_useofforce OWNER TO ipno;

--
-- Name: use_of_forces_useofforce_id_seq; Type: SEQUENCE; Schema: public; Owner: ipno
--

CREATE SEQUENCE public.use_of_forces_useofforce_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.use_of_forces_useofforce_id_seq OWNER TO ipno;

--
-- Name: use_of_forces_useofforce_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ipno
--

ALTER SEQUENCE public.use_of_forces_useofforce_id_seq OWNED BY public.use_of_forces_useofforce.id;


--
-- Name: app_config_apptextcontent id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.app_config_apptextcontent ALTER COLUMN id SET DEFAULT nextval('public.app_config_apptextcontent_id_seq'::regclass);


--
-- Name: app_config_appvalueconfig id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.app_config_appvalueconfig ALTER COLUMN id SET DEFAULT nextval('public.app_config_appconfig_id_seq'::regclass);


--
-- Name: app_config_frontpagecard id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.app_config_frontpagecard ALTER COLUMN id SET DEFAULT nextval('public.app_config_frontpagecard_id_seq'::regclass);


--
-- Name: app_config_frontpageorder id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.app_config_frontpageorder ALTER COLUMN id SET DEFAULT nextval('public.app_config_frontpageorder_id_seq'::regclass);


--
-- Name: appeals_appeal id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.appeals_appeal ALTER COLUMN id SET DEFAULT nextval('public.appeals_appeal_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: authentication_user id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.authentication_user ALTER COLUMN id SET DEFAULT nextval('public.authentication_user_id_seq'::regclass);


--
-- Name: citizens_citizen id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.citizens_citizen ALTER COLUMN id SET DEFAULT nextval('public.citizens_citizen_id_seq'::regclass);


--
-- Name: complaints_complaint id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint ALTER COLUMN id SET DEFAULT nextval('public.complaints_complaint_id_seq'::regclass);


--
-- Name: complaints_complaint_departments id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_departments ALTER COLUMN id SET DEFAULT nextval('public.complaints_complaint_departments_id_seq'::regclass);


--
-- Name: complaints_complaint_events id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_events ALTER COLUMN id SET DEFAULT nextval('public.complaints_complaint_events_id_seq'::regclass);


--
-- Name: complaints_complaint_officers id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_officers ALTER COLUMN id SET DEFAULT nextval('public.complaints_complaint_officers_id_seq'::regclass);


--
-- Name: data_importlog id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.data_importlog ALTER COLUMN id SET DEFAULT nextval('public.data_importlog_id_seq'::regclass);


--
-- Name: data_wrglrepo id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.data_wrglrepo ALTER COLUMN id SET DEFAULT nextval('public.data_wrglrepo_id_seq'::regclass);


--
-- Name: departments_department id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department ALTER COLUMN id SET DEFAULT nextval('public.departments_department_id_seq'::regclass);


--
-- Name: departments_department_starred_documents id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_documents ALTER COLUMN id SET DEFAULT nextval('public.departments_department_starred_documents_id_seq'::regclass);


--
-- Name: departments_department_starred_news_articles id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_news_articles ALTER COLUMN id SET DEFAULT nextval('public.departments_department_starred_news_articles_id_seq'::regclass);


--
-- Name: departments_department_starred_officers id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_officers ALTER COLUMN id SET DEFAULT nextval('public.departments_department_starred_officers_id_seq'::regclass);


--
-- Name: departments_officermovement id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_officermovement ALTER COLUMN id SET DEFAULT nextval('public.departments_officermovement_id_seq'::regclass);


--
-- Name: departments_wrglfile id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_wrglfile ALTER COLUMN id SET DEFAULT nextval('public.departments_wrglfile_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_celery_results_chordcounter id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_celery_results_chordcounter ALTER COLUMN id SET DEFAULT nextval('public.django_celery_results_chordcounter_id_seq'::regclass);


--
-- Name: django_celery_results_groupresult id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_celery_results_groupresult ALTER COLUMN id SET DEFAULT nextval('public.django_celery_results_groupresult_id_seq'::regclass);


--
-- Name: django_celery_results_taskresult id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_celery_results_taskresult ALTER COLUMN id SET DEFAULT nextval('public.django_celery_results_taskresult_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_rest_passwordreset_resetpasswordtoken id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_rest_passwordreset_resetpasswordtoken ALTER COLUMN id SET DEFAULT nextval('public.django_rest_passwordreset_resetpasswordtoken_id_seq'::regclass);


--
-- Name: documents_document id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.documents_document ALTER COLUMN id SET DEFAULT nextval('public.documents_document_id_seq'::regclass);


--
-- Name: documents_document_departments id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.documents_document_departments ALTER COLUMN id SET DEFAULT nextval('public.documents_document_departments_id_seq'::regclass);


--
-- Name: documents_document_officers id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.documents_document_officers ALTER COLUMN id SET DEFAULT nextval('public.documents_document_officers_id_seq'::regclass);


--
-- Name: feedbacks_feedback id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.feedbacks_feedback ALTER COLUMN id SET DEFAULT nextval('public.feedbacks_feedback_id_seq'::regclass);


--
-- Name: historical_data_anonymousitem id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.historical_data_anonymousitem ALTER COLUMN id SET DEFAULT nextval('public.historical_data_anonymousitem_id_seq'::regclass);


--
-- Name: historical_data_anonymousquery id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.historical_data_anonymousquery ALTER COLUMN id SET DEFAULT nextval('public.historical_data_anonymousquery_id_seq'::regclass);


--
-- Name: news_articles_crawledpost id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_crawledpost ALTER COLUMN id SET DEFAULT nextval('public.news_articles_crawledpost_id_seq'::regclass);


--
-- Name: news_articles_crawlererror id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_crawlererror ALTER COLUMN id SET DEFAULT nextval('public.news_articles_crawlererror_id_seq'::regclass);


--
-- Name: news_articles_crawlerlog id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_crawlerlog ALTER COLUMN id SET DEFAULT nextval('public.news_articles_crawlerlog_id_seq'::regclass);


--
-- Name: news_articles_excludeofficer id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_excludeofficer ALTER COLUMN id SET DEFAULT nextval('public.news_articles_excludeofficer_id_seq'::regclass);


--
-- Name: news_articles_excludeofficer_officers id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_excludeofficer_officers ALTER COLUMN id SET DEFAULT nextval('public.news_articles_excludeofficer_officers_id_seq'::regclass);


--
-- Name: news_articles_matchedsentence id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchedsentence ALTER COLUMN id SET DEFAULT nextval('public.news_articles_matchedsentence_id_seq'::regclass);


--
-- Name: news_articles_matchedsentence_excluded_officers id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchedsentence_excluded_officers ALTER COLUMN id SET DEFAULT nextval('public.news_articles_matchedsentence_excluded_officers_id_seq'::regclass);


--
-- Name: news_articles_matchedsentence_officers id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchedsentence_officers ALTER COLUMN id SET DEFAULT nextval('public.news_articles_matchedsentence_officers_id_seq'::regclass);


--
-- Name: news_articles_matchingkeyword id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchingkeyword ALTER COLUMN id SET DEFAULT nextval('public.news_articles_matchingkeyword_id_seq'::regclass);


--
-- Name: news_articles_newsarticle id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_newsarticle ALTER COLUMN id SET DEFAULT nextval('public.news_articles_newsarticle_id_seq'::regclass);


--
-- Name: news_articles_newsarticlesource id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_newsarticlesource ALTER COLUMN id SET DEFAULT nextval('public.news_articles_newsarticlesource_id_seq'::regclass);


--
-- Name: officers_event id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.officers_event ALTER COLUMN id SET DEFAULT nextval('public.officers_event_id_seq'::regclass);


--
-- Name: officers_officer id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.officers_officer ALTER COLUMN id SET DEFAULT nextval('public.officers_officer_id_seq'::regclass);


--
-- Name: people_person id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.people_person ALTER COLUMN id SET DEFAULT nextval('public.people_person_id_seq'::regclass);


--
-- Name: q_and_a_question id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.q_and_a_question ALTER COLUMN id SET DEFAULT nextval('public.q_and_a_question_id_seq'::regclass);


--
-- Name: q_and_a_section id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.q_and_a_section ALTER COLUMN id SET DEFAULT nextval('public.q_and_a_section_id_seq'::regclass);


--
-- Name: tasks_task id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.tasks_task ALTER COLUMN id SET DEFAULT nextval('public.tasks_task_id_seq'::regclass);


--
-- Name: tasks_tasklog id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.tasks_tasklog ALTER COLUMN id SET DEFAULT nextval('public.tasks_tasklog_id_seq'::regclass);


--
-- Name: token_blacklist_blacklistedtoken id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken ALTER COLUMN id SET DEFAULT nextval('public.token_blacklist_blacklistedtoken_id_seq'::regclass);


--
-- Name: token_blacklist_outstandingtoken id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken ALTER COLUMN id SET DEFAULT nextval('public.token_blacklist_outstandingtoken_id_seq'::regclass);


--
-- Name: use_of_forces_useofforce id; Type: DEFAULT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.use_of_forces_useofforce ALTER COLUMN id SET DEFAULT nextval('public.use_of_forces_useofforce_id_seq'::regclass);


--
-- Name: app_config_appvalueconfig app_config_appconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.app_config_appvalueconfig
    ADD CONSTRAINT app_config_appconfig_pkey PRIMARY KEY (id);


--
-- Name: app_config_apptextcontent app_config_apptextcontent_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.app_config_apptextcontent
    ADD CONSTRAINT app_config_apptextcontent_pkey PRIMARY KEY (id);


--
-- Name: app_config_frontpagecard app_config_frontpagecard_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.app_config_frontpagecard
    ADD CONSTRAINT app_config_frontpagecard_pkey PRIMARY KEY (id);


--
-- Name: app_config_frontpageorder app_config_frontpageorder_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.app_config_frontpageorder
    ADD CONSTRAINT app_config_frontpageorder_pkey PRIMARY KEY (id);


--
-- Name: appeals_appeal appeals_appeal_appeal_uid_key; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.appeals_appeal
    ADD CONSTRAINT appeals_appeal_appeal_uid_key UNIQUE (appeal_uid);


--
-- Name: appeals_appeal appeals_appeal_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.appeals_appeal
    ADD CONSTRAINT appeals_appeal_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authentication_user authentication_user_email_key; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.authentication_user
    ADD CONSTRAINT authentication_user_email_key UNIQUE (email);


--
-- Name: authentication_user authentication_user_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.authentication_user
    ADD CONSTRAINT authentication_user_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: citizens_citizen citizens_citizen_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.citizens_citizen
    ADD CONSTRAINT citizens_citizen_pkey PRIMARY KEY (id);


--
-- Name: complaints_complaint complaints_complaint_complaint_uid_0c58dfe9_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint
    ADD CONSTRAINT complaints_complaint_complaint_uid_0c58dfe9_uniq UNIQUE (allegation_uid);


--
-- Name: complaints_complaint_departments complaints_complaint_dep_complaint_id_department__51dd36dc_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_departments
    ADD CONSTRAINT complaints_complaint_dep_complaint_id_department__51dd36dc_uniq UNIQUE (complaint_id, department_id);


--
-- Name: complaints_complaint_departments complaints_complaint_departments_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_departments
    ADD CONSTRAINT complaints_complaint_departments_pkey PRIMARY KEY (id);


--
-- Name: complaints_complaint_events complaints_complaint_events_complaint_id_event_id_be817209_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_events
    ADD CONSTRAINT complaints_complaint_events_complaint_id_event_id_be817209_uniq UNIQUE (complaint_id, event_id);


--
-- Name: complaints_complaint_events complaints_complaint_events_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_events
    ADD CONSTRAINT complaints_complaint_events_pkey PRIMARY KEY (id);


--
-- Name: complaints_complaint_officers complaints_complaint_off_complaint_id_officer_id_e659ef05_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_officers
    ADD CONSTRAINT complaints_complaint_off_complaint_id_officer_id_e659ef05_uniq UNIQUE (complaint_id, officer_id);


--
-- Name: complaints_complaint_officers complaints_complaint_officers_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_officers
    ADD CONSTRAINT complaints_complaint_officers_pkey PRIMARY KEY (id);


--
-- Name: complaints_complaint complaints_complaint_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint
    ADD CONSTRAINT complaints_complaint_pkey PRIMARY KEY (id);


--
-- Name: data_importlog data_importlog_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.data_importlog
    ADD CONSTRAINT data_importlog_pkey PRIMARY KEY (id);


--
-- Name: data_wrglrepo data_wrglrepo_data_model_key; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.data_wrglrepo
    ADD CONSTRAINT data_wrglrepo_data_model_key UNIQUE (data_model);


--
-- Name: data_wrglrepo data_wrglrepo_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.data_wrglrepo
    ADD CONSTRAINT data_wrglrepo_pkey PRIMARY KEY (id);


--
-- Name: departments_department departments_department_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department
    ADD CONSTRAINT departments_department_pkey PRIMARY KEY (id);


--
-- Name: departments_department_starred_documents departments_department_s_department_id_document_i_2af39152_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_documents
    ADD CONSTRAINT departments_department_s_department_id_document_i_2af39152_uniq UNIQUE (department_id, document_id);


--
-- Name: departments_department_starred_news_articles departments_department_s_department_id_newsarticl_f4d9a2df_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_news_articles
    ADD CONSTRAINT departments_department_s_department_id_newsarticl_f4d9a2df_uniq UNIQUE (department_id, newsarticle_id);


--
-- Name: departments_department_starred_officers departments_department_s_department_id_officer_id_b1b350cd_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_officers
    ADD CONSTRAINT departments_department_s_department_id_officer_id_b1b350cd_uniq UNIQUE (department_id, officer_id);


--
-- Name: departments_department departments_department_slug_7e7a4aae_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department
    ADD CONSTRAINT departments_department_slug_7e7a4aae_uniq UNIQUE (agency_slug);


--
-- Name: departments_department_starred_documents departments_department_starred_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_documents
    ADD CONSTRAINT departments_department_starred_documents_pkey PRIMARY KEY (id);


--
-- Name: departments_department_starred_news_articles departments_department_starred_news_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_news_articles
    ADD CONSTRAINT departments_department_starred_news_articles_pkey PRIMARY KEY (id);


--
-- Name: departments_department_starred_officers departments_department_starred_officers_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_officers
    ADD CONSTRAINT departments_department_starred_officers_pkey PRIMARY KEY (id);


--
-- Name: departments_officermovement departments_officermovement_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_officermovement
    ADD CONSTRAINT departments_officermovement_pkey PRIMARY KEY (id);


--
-- Name: departments_wrglfile departments_wrglfile_department_id_position_02321f2d_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_wrglfile
    ADD CONSTRAINT departments_wrglfile_department_id_position_02321f2d_uniq UNIQUE (department_id, "position");


--
-- Name: departments_wrglfile departments_wrglfile_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_wrglfile
    ADD CONSTRAINT departments_wrglfile_pkey PRIMARY KEY (id);


--
-- Name: departments_wrglfile departments_wrglfile_slug_key; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_wrglfile
    ADD CONSTRAINT departments_wrglfile_slug_key UNIQUE (slug);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_chordcounter django_celery_results_chordcounter_group_id_key; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_celery_results_chordcounter
    ADD CONSTRAINT django_celery_results_chordcounter_group_id_key UNIQUE (group_id);


--
-- Name: django_celery_results_chordcounter django_celery_results_chordcounter_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_celery_results_chordcounter
    ADD CONSTRAINT django_celery_results_chordcounter_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_groupresult django_celery_results_groupresult_group_id_key; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_celery_results_groupresult
    ADD CONSTRAINT django_celery_results_groupresult_group_id_key UNIQUE (group_id);


--
-- Name: django_celery_results_groupresult django_celery_results_groupresult_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_celery_results_groupresult
    ADD CONSTRAINT django_celery_results_groupresult_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_taskresult django_celery_results_taskresult_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_celery_results_taskresult
    ADD CONSTRAINT django_celery_results_taskresult_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_taskresult django_celery_results_taskresult_task_id_key; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_celery_results_taskresult
    ADD CONSTRAINT django_celery_results_taskresult_task_id_key UNIQUE (task_id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_rest_passwordreset_resetpasswordtoken django_rest_passwordreset_resetpasswordtoken_key_f1b65873_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_rest_passwordreset_resetpasswordtoken
    ADD CONSTRAINT django_rest_passwordreset_resetpasswordtoken_key_f1b65873_uniq UNIQUE (key);


--
-- Name: django_rest_passwordreset_resetpasswordtoken django_rest_passwordreset_resetpasswordtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_rest_passwordreset_resetpasswordtoken
    ADD CONSTRAINT django_rest_passwordreset_resetpasswordtoken_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: documents_document_departments documents_document_depar_document_id_department_i_5bce3004_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.documents_document_departments
    ADD CONSTRAINT documents_document_depar_document_id_department_i_5bce3004_uniq UNIQUE (document_id, department_id);


--
-- Name: documents_document_departments documents_document_departments_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.documents_document_departments
    ADD CONSTRAINT documents_document_departments_pkey PRIMARY KEY (id);


--
-- Name: documents_document documents_document_docid_hrg_no_matched_uid_12d870fa_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.documents_document
    ADD CONSTRAINT documents_document_docid_hrg_no_matched_uid_12d870fa_uniq UNIQUE (docid, hrg_no, matched_uid, agency);


--
-- Name: documents_document_officers documents_document_offic_document_id_officer_id_42b9dbfc_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.documents_document_officers
    ADD CONSTRAINT documents_document_offic_document_id_officer_id_42b9dbfc_uniq UNIQUE (document_id, officer_id);


--
-- Name: documents_document_officers documents_document_officers_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.documents_document_officers
    ADD CONSTRAINT documents_document_officers_pkey PRIMARY KEY (id);


--
-- Name: documents_document documents_document_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.documents_document
    ADD CONSTRAINT documents_document_pkey PRIMARY KEY (id);


--
-- Name: feedbacks_feedback feedbacks_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.feedbacks_feedback
    ADD CONSTRAINT feedbacks_feedback_pkey PRIMARY KEY (id);


--
-- Name: historical_data_anonymousitem historical_data_anonymousitem_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.historical_data_anonymousitem
    ADD CONSTRAINT historical_data_anonymousitem_pkey PRIMARY KEY (id);


--
-- Name: historical_data_anonymousquery historical_data_anonymousquery_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.historical_data_anonymousquery
    ADD CONSTRAINT historical_data_anonymousquery_pkey PRIMARY KEY (id);


--
-- Name: ipno_cache_table ipno_cache_table_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.ipno_cache_table
    ADD CONSTRAINT ipno_cache_table_pkey PRIMARY KEY (cache_key);


--
-- Name: news_articles_crawledpost news_articles_crawledpost_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_crawledpost
    ADD CONSTRAINT news_articles_crawledpost_pkey PRIMARY KEY (id);


--
-- Name: news_articles_crawlererror news_articles_crawlererror_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_crawlererror
    ADD CONSTRAINT news_articles_crawlererror_pkey PRIMARY KEY (id);


--
-- Name: news_articles_crawlerlog news_articles_crawlerlog_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_crawlerlog
    ADD CONSTRAINT news_articles_crawlerlog_pkey PRIMARY KEY (id);


--
-- Name: news_articles_excludeofficer_officers news_articles_excludeoff_excludeofficer_id_office_f0a02768_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_excludeofficer_officers
    ADD CONSTRAINT news_articles_excludeoff_excludeofficer_id_office_f0a02768_uniq UNIQUE (excludeofficer_id, officer_id);


--
-- Name: news_articles_excludeofficer_officers news_articles_excludeofficer_officers_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_excludeofficer_officers
    ADD CONSTRAINT news_articles_excludeofficer_officers_pkey PRIMARY KEY (id);


--
-- Name: news_articles_excludeofficer news_articles_excludeofficer_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_excludeofficer
    ADD CONSTRAINT news_articles_excludeofficer_pkey PRIMARY KEY (id);


--
-- Name: news_articles_matchedsentence_excluded_officers news_articles_matchedsen_matchedsentence_id_offic_112b5595_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchedsentence_excluded_officers
    ADD CONSTRAINT news_articles_matchedsen_matchedsentence_id_offic_112b5595_uniq UNIQUE (matchedsentence_id, officer_id);


--
-- Name: news_articles_matchedsentence_officers news_articles_matchedsen_matchedsentence_id_offic_1fedf876_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchedsentence_officers
    ADD CONSTRAINT news_articles_matchedsen_matchedsentence_id_offic_1fedf876_uniq UNIQUE (matchedsentence_id, officer_id);


--
-- Name: news_articles_matchedsentence_excluded_officers news_articles_matchedsentence_excluded_officers_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchedsentence_excluded_officers
    ADD CONSTRAINT news_articles_matchedsentence_excluded_officers_pkey PRIMARY KEY (id);


--
-- Name: news_articles_matchedsentence_officers news_articles_matchedsentence_officers_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchedsentence_officers
    ADD CONSTRAINT news_articles_matchedsentence_officers_pkey PRIMARY KEY (id);


--
-- Name: news_articles_matchedsentence news_articles_matchedsentence_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchedsentence
    ADD CONSTRAINT news_articles_matchedsentence_pkey PRIMARY KEY (id);


--
-- Name: news_articles_matchingkeyword news_articles_matchingkeyword_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchingkeyword
    ADD CONSTRAINT news_articles_matchingkeyword_pkey PRIMARY KEY (id);


--
-- Name: news_articles_newsarticle news_articles_newsarticle_link_dd2e1bcc_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_newsarticle
    ADD CONSTRAINT news_articles_newsarticle_link_dd2e1bcc_uniq UNIQUE (link);


--
-- Name: news_articles_newsarticle news_articles_newsarticle_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_newsarticle
    ADD CONSTRAINT news_articles_newsarticle_pkey PRIMARY KEY (id);


--
-- Name: news_articles_newsarticlesource news_articles_newsarticlesource_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_newsarticlesource
    ADD CONSTRAINT news_articles_newsarticlesource_pkey PRIMARY KEY (id);


--
-- Name: officers_event officers_event_event_uid_acf5b8ca_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.officers_event
    ADD CONSTRAINT officers_event_event_uid_acf5b8ca_uniq UNIQUE (event_uid);


--
-- Name: officers_event officers_event_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.officers_event
    ADD CONSTRAINT officers_event_pkey PRIMARY KEY (id);


--
-- Name: officers_officer officers_officer_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.officers_officer
    ADD CONSTRAINT officers_officer_pkey PRIMARY KEY (id);


--
-- Name: officers_officer officers_officer_uid_3925bd1f_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.officers_officer
    ADD CONSTRAINT officers_officer_uid_3925bd1f_uniq UNIQUE (uid);


--
-- Name: people_person people_person_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.people_person
    ADD CONSTRAINT people_person_pkey PRIMARY KEY (id);


--
-- Name: q_and_a_question q_and_a_question_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.q_and_a_question
    ADD CONSTRAINT q_and_a_question_pkey PRIMARY KEY (id);


--
-- Name: q_and_a_section q_and_a_section_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.q_and_a_section
    ADD CONSTRAINT q_and_a_section_pkey PRIMARY KEY (id);


--
-- Name: tasks_task tasks_task_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.tasks_task
    ADD CONSTRAINT tasks_task_pkey PRIMARY KEY (id);


--
-- Name: tasks_tasklog tasks_tasklog_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.tasks_tasklog
    ADD CONSTRAINT tasks_tasklog_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_token_id_key; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_token_id_key UNIQUE (token_id);


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq UNIQUE (jti);


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_pkey PRIMARY KEY (id);


--
-- Name: use_of_forces_useofforce use_of_forces_useofforce_pkey; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.use_of_forces_useofforce
    ADD CONSTRAINT use_of_forces_useofforce_pkey PRIMARY KEY (id);


--
-- Name: use_of_forces_useofforce use_of_forces_useofforce_uof_uid_key; Type: CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.use_of_forces_useofforce
    ADD CONSTRAINT use_of_forces_useofforce_uof_uid_key UNIQUE (uof_uid);


--
-- Name: app_config_frontpagecard_order_c20203e5; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX app_config_frontpagecard_order_c20203e5 ON public.app_config_frontpagecard USING btree ("order");


--
-- Name: app_config_frontpageorder_order_382ee4ba; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX app_config_frontpageorder_order_382ee4ba ON public.app_config_frontpageorder USING btree ("order");


--
-- Name: appeals_appeal_appeal_uid_a375853f_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX appeals_appeal_appeal_uid_a375853f_like ON public.appeals_appeal USING btree (appeal_uid varchar_pattern_ops);


--
-- Name: appeals_appeal_department_id_daee9711; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX appeals_appeal_department_id_daee9711 ON public.appeals_appeal USING btree (department_id);


--
-- Name: appeals_appeal_officer_id_eb2819c9; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX appeals_appeal_officer_id_eb2819c9 ON public.appeals_appeal USING btree (officer_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authentication_user_email_2220eff5_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX authentication_user_email_2220eff5_like ON public.authentication_user USING btree (email varchar_pattern_ops);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: citizens_citizen_complaint_id_5b6cf4fc; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX citizens_citizen_complaint_id_5b6cf4fc ON public.citizens_citizen USING btree (complaint_id);


--
-- Name: citizens_citizen_department_id_940a0495; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX citizens_citizen_department_id_940a0495 ON public.citizens_citizen USING btree (department_id);


--
-- Name: citizens_citizen_use_of_force_id_4c8603ac; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX citizens_citizen_use_of_force_id_4c8603ac ON public.citizens_citizen USING btree (use_of_force_id);


--
-- Name: complaints_complaint_complaint_uid_0c58dfe9; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX complaints_complaint_complaint_uid_0c58dfe9 ON public.complaints_complaint USING btree (allegation_uid);


--
-- Name: complaints_complaint_complaint_uid_0c58dfe9_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX complaints_complaint_complaint_uid_0c58dfe9_like ON public.complaints_complaint USING btree (allegation_uid varchar_pattern_ops);


--
-- Name: complaints_complaint_departments_complaint_id_c5ad2744; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX complaints_complaint_departments_complaint_id_c5ad2744 ON public.complaints_complaint_departments USING btree (complaint_id);


--
-- Name: complaints_complaint_departments_department_id_4149580d; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX complaints_complaint_departments_department_id_4149580d ON public.complaints_complaint_departments USING btree (department_id);


--
-- Name: complaints_complaint_events_complaint_id_8366f606; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX complaints_complaint_events_complaint_id_8366f606 ON public.complaints_complaint_events USING btree (complaint_id);


--
-- Name: complaints_complaint_events_event_id_cd83605b; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX complaints_complaint_events_event_id_cd83605b ON public.complaints_complaint_events USING btree (event_id);


--
-- Name: complaints_complaint_officers_complaint_id_dc5c4796; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX complaints_complaint_officers_complaint_id_dc5c4796 ON public.complaints_complaint_officers USING btree (complaint_id);


--
-- Name: complaints_complaint_officers_officer_id_64f00d7e; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX complaints_complaint_officers_officer_id_64f00d7e ON public.complaints_complaint_officers USING btree (officer_id);


--
-- Name: data_wrglrepo_data_model_dce24f4f_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX data_wrglrepo_data_model_dce24f4f_like ON public.data_wrglrepo USING btree (data_model varchar_pattern_ops);


--
-- Name: departments_department_slug_7e7a4aae_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX departments_department_slug_7e7a4aae_like ON public.departments_department USING btree (agency_slug varchar_pattern_ops);


--
-- Name: departments_department_sta_department_id_bb54f055; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX departments_department_sta_department_id_bb54f055 ON public.departments_department_starred_news_articles USING btree (department_id);


--
-- Name: departments_department_sta_newsarticle_id_412972c2; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX departments_department_sta_newsarticle_id_412972c2 ON public.departments_department_starred_news_articles USING btree (newsarticle_id);


--
-- Name: departments_department_starred_documents_department_id_f55161d4; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX departments_department_starred_documents_department_id_f55161d4 ON public.departments_department_starred_documents USING btree (department_id);


--
-- Name: departments_department_starred_documents_document_id_3fd2195c; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX departments_department_starred_documents_document_id_3fd2195c ON public.departments_department_starred_documents USING btree (document_id);


--
-- Name: departments_department_starred_officers_department_id_6c6b5b8d; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX departments_department_starred_officers_department_id_6c6b5b8d ON public.departments_department_starred_officers USING btree (department_id);


--
-- Name: departments_department_starred_officers_officer_id_e7acb761; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX departments_department_starred_officers_officer_id_e7acb761 ON public.departments_department_starred_officers USING btree (officer_id);


--
-- Name: departments_officermovement_end_department_id_f6b2304a; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX departments_officermovement_end_department_id_f6b2304a ON public.departments_officermovement USING btree (end_department_id);


--
-- Name: departments_officermovement_officer_id_216f7023; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX departments_officermovement_officer_id_216f7023 ON public.departments_officermovement USING btree (officer_id);


--
-- Name: departments_officermovement_start_department_id_5a6a6f61; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX departments_officermovement_start_department_id_5a6a6f61 ON public.departments_officermovement USING btree (start_department_id);


--
-- Name: departments_wrglfile_department_id_4ff4d4c3; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX departments_wrglfile_department_id_4ff4d4c3 ON public.departments_wrglfile USING btree (department_id);


--
-- Name: departments_wrglfile_slug_516e9eb4_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX departments_wrglfile_slug_516e9eb4_like ON public.departments_wrglfile USING btree (slug varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_cele_date_cr_bd6c1d_idx; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_cele_date_cr_bd6c1d_idx ON public.django_celery_results_groupresult USING btree (date_created);


--
-- Name: django_cele_date_cr_f04a50_idx; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_cele_date_cr_f04a50_idx ON public.django_celery_results_taskresult USING btree (date_created);


--
-- Name: django_cele_date_do_caae0e_idx; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_cele_date_do_caae0e_idx ON public.django_celery_results_groupresult USING btree (date_done);


--
-- Name: django_cele_date_do_f59aad_idx; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_cele_date_do_f59aad_idx ON public.django_celery_results_taskresult USING btree (date_done);


--
-- Name: django_cele_status_9b6201_idx; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_cele_status_9b6201_idx ON public.django_celery_results_taskresult USING btree (status);


--
-- Name: django_cele_task_na_08aec9_idx; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_cele_task_na_08aec9_idx ON public.django_celery_results_taskresult USING btree (task_name);


--
-- Name: django_cele_worker_d54dd8_idx; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_cele_worker_d54dd8_idx ON public.django_celery_results_taskresult USING btree (worker);


--
-- Name: django_celery_results_chordcounter_group_id_1f70858c_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_celery_results_chordcounter_group_id_1f70858c_like ON public.django_celery_results_chordcounter USING btree (group_id varchar_pattern_ops);


--
-- Name: django_celery_results_groupresult_group_id_a085f1a9_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_celery_results_groupresult_group_id_a085f1a9_like ON public.django_celery_results_groupresult USING btree (group_id varchar_pattern_ops);


--
-- Name: django_celery_results_taskresult_task_id_de0d95bf_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_celery_results_taskresult_task_id_de0d95bf_like ON public.django_celery_results_taskresult USING btree (task_id varchar_pattern_ops);


--
-- Name: django_rest_passwordreset_resetpasswordtoken_key_f1b65873_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_rest_passwordreset_resetpasswordtoken_key_f1b65873_like ON public.django_rest_passwordreset_resetpasswordtoken USING btree (key varchar_pattern_ops);


--
-- Name: django_rest_passwordreset_resetpasswordtoken_user_id_e8015b11; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_rest_passwordreset_resetpasswordtoken_user_id_e8015b11 ON public.django_rest_passwordreset_resetpasswordtoken USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: documents_document_departments_department_id_886b6821; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX documents_document_departments_department_id_886b6821 ON public.documents_document_departments USING btree (department_id);


--
-- Name: documents_document_departments_document_id_52142d27; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX documents_document_departments_document_id_52142d27 ON public.documents_document_departments USING btree (document_id);


--
-- Name: documents_document_officers_document_id_27aa473e; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX documents_document_officers_document_id_27aa473e ON public.documents_document_officers USING btree (document_id);


--
-- Name: documents_document_officers_officer_id_54738ee2; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX documents_document_officers_officer_id_54738ee2 ON public.documents_document_officers USING btree (officer_id);


--
-- Name: historical_data_anonymousitem_item_id_826bce3b; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX historical_data_anonymousitem_item_id_826bce3b ON public.historical_data_anonymousitem USING btree (item_id);


--
-- Name: historical_data_anonymousitem_item_id_826bce3b_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX historical_data_anonymousitem_item_id_826bce3b_like ON public.historical_data_anonymousitem USING btree (item_id varchar_pattern_ops);


--
-- Name: historical_data_anonymousitem_item_type_5bbf7fe6; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX historical_data_anonymousitem_item_type_5bbf7fe6 ON public.historical_data_anonymousitem USING btree (item_type);


--
-- Name: historical_data_anonymousitem_item_type_5bbf7fe6_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX historical_data_anonymousitem_item_type_5bbf7fe6_like ON public.historical_data_anonymousitem USING btree (item_type varchar_pattern_ops);


--
-- Name: historical_data_anonymousitem_last_visited_2fefdb31; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX historical_data_anonymousitem_last_visited_2fefdb31 ON public.historical_data_anonymousitem USING btree (last_visited);


--
-- Name: historical_data_anonymousquery_last_visited_74cea401; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX historical_data_anonymousquery_last_visited_74cea401 ON public.historical_data_anonymousquery USING btree (last_visited);


--
-- Name: historical_data_anonymousquery_query_4f6f13f5; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX historical_data_anonymousquery_query_4f6f13f5 ON public.historical_data_anonymousquery USING btree (query);


--
-- Name: historical_data_anonymousquery_query_4f6f13f5_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX historical_data_anonymousquery_query_4f6f13f5_like ON public.historical_data_anonymousquery USING btree (query varchar_pattern_ops);


--
-- Name: ipno_cache_table_expires; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX ipno_cache_table_expires ON public.ipno_cache_table USING btree (expires);


--
-- Name: news_articles_crawledpost_source_id_f767f5b6; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX news_articles_crawledpost_source_id_f767f5b6 ON public.news_articles_crawledpost USING btree (source_id);


--
-- Name: news_articles_crawlererror_log_id_6e5f0534; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX news_articles_crawlererror_log_id_6e5f0534 ON public.news_articles_crawlererror USING btree (log_id);


--
-- Name: news_articles_crawlerlog_source_id_a286419a; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX news_articles_crawlerlog_source_id_a286419a ON public.news_articles_crawlerlog USING btree (source_id);


--
-- Name: news_articles_excludeoffic_excludeofficer_id_3cce5005; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX news_articles_excludeoffic_excludeofficer_id_3cce5005 ON public.news_articles_excludeofficer_officers USING btree (excludeofficer_id);


--
-- Name: news_articles_excludeofficer_officers_officer_id_7ac12191; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX news_articles_excludeofficer_officers_officer_id_7ac12191 ON public.news_articles_excludeofficer_officers USING btree (officer_id);


--
-- Name: news_articles_matchedsente_matchedsentence_id_b27c132d; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX news_articles_matchedsente_matchedsentence_id_b27c132d ON public.news_articles_matchedsentence_officers USING btree (matchedsentence_id);


--
-- Name: news_articles_matchedsente_matchedsentence_id_cfe2421b; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX news_articles_matchedsente_matchedsentence_id_cfe2421b ON public.news_articles_matchedsentence_excluded_officers USING btree (matchedsentence_id);


--
-- Name: news_articles_matchedsente_officer_id_c810088a; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX news_articles_matchedsente_officer_id_c810088a ON public.news_articles_matchedsentence_excluded_officers USING btree (officer_id);


--
-- Name: news_articles_matchedsentence_article_id_605ffda2; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX news_articles_matchedsentence_article_id_605ffda2 ON public.news_articles_matchedsentence USING btree (article_id);


--
-- Name: news_articles_matchedsentence_officers_officer_id_75a25783; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX news_articles_matchedsentence_officers_officer_id_75a25783 ON public.news_articles_matchedsentence_officers USING btree (officer_id);


--
-- Name: news_articles_newsarticle_source_id_7de5bf12; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX news_articles_newsarticle_source_id_7de5bf12 ON public.news_articles_newsarticle USING btree (source_id);


--
-- Name: officers_event_appeal_id_d462b0e0; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX officers_event_appeal_id_d462b0e0 ON public.officers_event USING btree (appeal_id);


--
-- Name: officers_event_day_4b7d5b58; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX officers_event_day_4b7d5b58 ON public.officers_event USING btree (day);


--
-- Name: officers_event_department_id_f6f5c7c6; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX officers_event_department_id_f6f5c7c6 ON public.officers_event USING btree (department_id);


--
-- Name: officers_event_event_uid_acf5b8ca_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX officers_event_event_uid_acf5b8ca_like ON public.officers_event USING btree (event_uid varchar_pattern_ops);


--
-- Name: officers_event_kind_ec177b0c; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX officers_event_kind_ec177b0c ON public.officers_event USING btree (kind);


--
-- Name: officers_event_kind_ec177b0c_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX officers_event_kind_ec177b0c_like ON public.officers_event USING btree (kind varchar_pattern_ops);


--
-- Name: officers_event_month_2e62ab37; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX officers_event_month_2e62ab37 ON public.officers_event USING btree (month);


--
-- Name: officers_event_officer_id_d02a1689; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX officers_event_officer_id_d02a1689 ON public.officers_event USING btree (officer_id);


--
-- Name: officers_event_use_of_force_id_9e46d260; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX officers_event_use_of_force_id_9e46d260 ON public.officers_event USING btree (use_of_force_id);


--
-- Name: officers_event_year_62c512e4; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX officers_event_year_62c512e4 ON public.officers_event USING btree (year);


--
-- Name: officers_officer_department_id_d99cd7d4; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX officers_officer_department_id_d99cd7d4 ON public.officers_officer USING btree (department_id);


--
-- Name: officers_officer_person_id_d8cf49dc; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX officers_officer_person_id_d8cf49dc ON public.officers_officer USING btree (person_id);


--
-- Name: officers_officer_uid_3925bd1f_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX officers_officer_uid_3925bd1f_like ON public.officers_officer USING btree (uid varchar_pattern_ops);


--
-- Name: people_person_canonical_officer_id_31540e72; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX people_person_canonical_officer_id_31540e72 ON public.people_person USING btree (canonical_officer_id);


--
-- Name: q_and_a_question_section_id_cad9f694; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX q_and_a_question_section_id_cad9f694 ON public.q_and_a_question USING btree (section_id);


--
-- Name: q_and_a_section_order_2e8210f8; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX q_and_a_section_order_2e8210f8 ON public.q_and_a_section USING btree ("order");


--
-- Name: tasks_tasklog_task_id_94d5b7eb; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX tasks_tasklog_task_id_94d5b7eb ON public.tasks_tasklog USING btree (task_id);


--
-- Name: token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_like ON public.token_blacklist_outstandingtoken USING btree (jti varchar_pattern_ops);


--
-- Name: token_blacklist_outstandingtoken_user_id_83bc629a; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX token_blacklist_outstandingtoken_user_id_83bc629a ON public.token_blacklist_outstandingtoken USING btree (user_id);


--
-- Name: use_of_forces_useofforce_department_id_8766c958; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX use_of_forces_useofforce_department_id_8766c958 ON public.use_of_forces_useofforce USING btree (department_id);


--
-- Name: use_of_forces_useofforce_officer_id_edff0582; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX use_of_forces_useofforce_officer_id_edff0582 ON public.use_of_forces_useofforce USING btree (officer_id);


--
-- Name: use_of_forces_useofforce_uof_uid_e81a7839_like; Type: INDEX; Schema: public; Owner: ipno
--

CREATE INDEX use_of_forces_useofforce_uof_uid_e81a7839_like ON public.use_of_forces_useofforce USING btree (uof_uid varchar_pattern_ops);


--
-- Name: appeals_appeal appeals_appeal_department_id_daee9711_fk_departmen; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.appeals_appeal
    ADD CONSTRAINT appeals_appeal_department_id_daee9711_fk_departmen FOREIGN KEY (department_id) REFERENCES public.departments_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: appeals_appeal appeals_appeal_officer_id_eb2819c9_fk_officers_officer_id; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.appeals_appeal
    ADD CONSTRAINT appeals_appeal_officer_id_eb2819c9_fk_officers_officer_id FOREIGN KEY (officer_id) REFERENCES public.officers_officer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_authentication_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_authentication_user_id FOREIGN KEY (user_id) REFERENCES public.authentication_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: citizens_citizen citizens_citizen_complaint_id_5b6cf4fc_fk_complaint; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.citizens_citizen
    ADD CONSTRAINT citizens_citizen_complaint_id_5b6cf4fc_fk_complaint FOREIGN KEY (complaint_id) REFERENCES public.complaints_complaint(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: citizens_citizen citizens_citizen_department_id_940a0495_fk_departmen; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.citizens_citizen
    ADD CONSTRAINT citizens_citizen_department_id_940a0495_fk_departmen FOREIGN KEY (department_id) REFERENCES public.departments_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: citizens_citizen citizens_citizen_use_of_force_id_4c8603ac_fk_use_of_fo; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.citizens_citizen
    ADD CONSTRAINT citizens_citizen_use_of_force_id_4c8603ac_fk_use_of_fo FOREIGN KEY (use_of_force_id) REFERENCES public.use_of_forces_useofforce(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: complaints_complaint_events complaints_complaint_complaint_id_8366f606_fk_complaint; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_events
    ADD CONSTRAINT complaints_complaint_complaint_id_8366f606_fk_complaint FOREIGN KEY (complaint_id) REFERENCES public.complaints_complaint(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: complaints_complaint_departments complaints_complaint_complaint_id_c5ad2744_fk_complaint; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_departments
    ADD CONSTRAINT complaints_complaint_complaint_id_c5ad2744_fk_complaint FOREIGN KEY (complaint_id) REFERENCES public.complaints_complaint(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: complaints_complaint_officers complaints_complaint_complaint_id_dc5c4796_fk_complaint; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_officers
    ADD CONSTRAINT complaints_complaint_complaint_id_dc5c4796_fk_complaint FOREIGN KEY (complaint_id) REFERENCES public.complaints_complaint(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: complaints_complaint_departments complaints_complaint_department_id_4149580d_fk_departmen; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_departments
    ADD CONSTRAINT complaints_complaint_department_id_4149580d_fk_departmen FOREIGN KEY (department_id) REFERENCES public.departments_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: complaints_complaint_events complaints_complaint_event_id_cd83605b_fk_officers_; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_events
    ADD CONSTRAINT complaints_complaint_event_id_cd83605b_fk_officers_ FOREIGN KEY (event_id) REFERENCES public.officers_event(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: complaints_complaint_officers complaints_complaint_officer_id_64f00d7e_fk_officers_; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.complaints_complaint_officers
    ADD CONSTRAINT complaints_complaint_officer_id_64f00d7e_fk_officers_ FOREIGN KEY (officer_id) REFERENCES public.officers_officer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departments_department_starred_officers departments_departme_department_id_6c6b5b8d_fk_departmen; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_officers
    ADD CONSTRAINT departments_departme_department_id_6c6b5b8d_fk_departmen FOREIGN KEY (department_id) REFERENCES public.departments_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departments_department_starred_news_articles departments_departme_department_id_bb54f055_fk_departmen; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_news_articles
    ADD CONSTRAINT departments_departme_department_id_bb54f055_fk_departmen FOREIGN KEY (department_id) REFERENCES public.departments_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departments_department_starred_documents departments_departme_department_id_f55161d4_fk_departmen; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_documents
    ADD CONSTRAINT departments_departme_department_id_f55161d4_fk_departmen FOREIGN KEY (department_id) REFERENCES public.departments_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departments_department_starred_documents departments_departme_document_id_3fd2195c_fk_documents; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_documents
    ADD CONSTRAINT departments_departme_document_id_3fd2195c_fk_documents FOREIGN KEY (document_id) REFERENCES public.documents_document(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departments_department_starred_news_articles departments_departme_newsarticle_id_412972c2_fk_news_arti; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_news_articles
    ADD CONSTRAINT departments_departme_newsarticle_id_412972c2_fk_news_arti FOREIGN KEY (newsarticle_id) REFERENCES public.news_articles_newsarticle(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departments_department_starred_officers departments_departme_officer_id_e7acb761_fk_officers_; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_department_starred_officers
    ADD CONSTRAINT departments_departme_officer_id_e7acb761_fk_officers_ FOREIGN KEY (officer_id) REFERENCES public.officers_officer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departments_officermovement departments_officerm_end_department_id_f6b2304a_fk_departmen; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_officermovement
    ADD CONSTRAINT departments_officerm_end_department_id_f6b2304a_fk_departmen FOREIGN KEY (end_department_id) REFERENCES public.departments_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departments_officermovement departments_officerm_officer_id_216f7023_fk_officers_; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_officermovement
    ADD CONSTRAINT departments_officerm_officer_id_216f7023_fk_officers_ FOREIGN KEY (officer_id) REFERENCES public.officers_officer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departments_officermovement departments_officerm_start_department_id_5a6a6f61_fk_departmen; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_officermovement
    ADD CONSTRAINT departments_officerm_start_department_id_5a6a6f61_fk_departmen FOREIGN KEY (start_department_id) REFERENCES public.departments_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: departments_wrglfile departments_wrglfile_department_id_4ff4d4c3_fk_departmen; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.departments_wrglfile
    ADD CONSTRAINT departments_wrglfile_department_id_4ff4d4c3_fk_departmen FOREIGN KEY (department_id) REFERENCES public.departments_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_authentication_user_id; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_authentication_user_id FOREIGN KEY (user_id) REFERENCES public.authentication_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_rest_passwordreset_resetpasswordtoken django_rest_password_user_id_e8015b11_fk_authentic; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.django_rest_passwordreset_resetpasswordtoken
    ADD CONSTRAINT django_rest_password_user_id_e8015b11_fk_authentic FOREIGN KEY (user_id) REFERENCES public.authentication_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_document_departments documents_document_d_department_id_886b6821_fk_departmen; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.documents_document_departments
    ADD CONSTRAINT documents_document_d_department_id_886b6821_fk_departmen FOREIGN KEY (department_id) REFERENCES public.departments_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_document_departments documents_document_d_document_id_52142d27_fk_documents; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.documents_document_departments
    ADD CONSTRAINT documents_document_d_document_id_52142d27_fk_documents FOREIGN KEY (document_id) REFERENCES public.documents_document(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_document_officers documents_document_o_document_id_27aa473e_fk_documents; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.documents_document_officers
    ADD CONSTRAINT documents_document_o_document_id_27aa473e_fk_documents FOREIGN KEY (document_id) REFERENCES public.documents_document(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: documents_document_officers documents_document_o_officer_id_54738ee2_fk_officers_; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.documents_document_officers
    ADD CONSTRAINT documents_document_o_officer_id_54738ee2_fk_officers_ FOREIGN KEY (officer_id) REFERENCES public.officers_officer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: news_articles_crawlererror news_articles_crawle_log_id_6e5f0534_fk_news_arti; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_crawlererror
    ADD CONSTRAINT news_articles_crawle_log_id_6e5f0534_fk_news_arti FOREIGN KEY (log_id) REFERENCES public.news_articles_crawlerlog(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: news_articles_crawlerlog news_articles_crawle_source_id_a286419a_fk_news_arti; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_crawlerlog
    ADD CONSTRAINT news_articles_crawle_source_id_a286419a_fk_news_arti FOREIGN KEY (source_id) REFERENCES public.news_articles_newsarticlesource(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: news_articles_crawledpost news_articles_crawle_source_id_f767f5b6_fk_news_arti; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_crawledpost
    ADD CONSTRAINT news_articles_crawle_source_id_f767f5b6_fk_news_arti FOREIGN KEY (source_id) REFERENCES public.news_articles_newsarticlesource(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: news_articles_excludeofficer_officers news_articles_exclud_excludeofficer_id_3cce5005_fk_news_arti; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_excludeofficer_officers
    ADD CONSTRAINT news_articles_exclud_excludeofficer_id_3cce5005_fk_news_arti FOREIGN KEY (excludeofficer_id) REFERENCES public.news_articles_excludeofficer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: news_articles_excludeofficer_officers news_articles_exclud_officer_id_7ac12191_fk_officers_; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_excludeofficer_officers
    ADD CONSTRAINT news_articles_exclud_officer_id_7ac12191_fk_officers_ FOREIGN KEY (officer_id) REFERENCES public.officers_officer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: news_articles_matchedsentence news_articles_matche_article_id_605ffda2_fk_news_arti; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchedsentence
    ADD CONSTRAINT news_articles_matche_article_id_605ffda2_fk_news_arti FOREIGN KEY (article_id) REFERENCES public.news_articles_newsarticle(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: news_articles_matchedsentence_officers news_articles_matche_matchedsentence_id_b27c132d_fk_news_arti; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchedsentence_officers
    ADD CONSTRAINT news_articles_matche_matchedsentence_id_b27c132d_fk_news_arti FOREIGN KEY (matchedsentence_id) REFERENCES public.news_articles_matchedsentence(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: news_articles_matchedsentence_excluded_officers news_articles_matche_matchedsentence_id_cfe2421b_fk_news_arti; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchedsentence_excluded_officers
    ADD CONSTRAINT news_articles_matche_matchedsentence_id_cfe2421b_fk_news_arti FOREIGN KEY (matchedsentence_id) REFERENCES public.news_articles_matchedsentence(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: news_articles_matchedsentence_officers news_articles_matche_officer_id_75a25783_fk_officers_; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchedsentence_officers
    ADD CONSTRAINT news_articles_matche_officer_id_75a25783_fk_officers_ FOREIGN KEY (officer_id) REFERENCES public.officers_officer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: news_articles_matchedsentence_excluded_officers news_articles_matche_officer_id_c810088a_fk_officers_; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_matchedsentence_excluded_officers
    ADD CONSTRAINT news_articles_matche_officer_id_c810088a_fk_officers_ FOREIGN KEY (officer_id) REFERENCES public.officers_officer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: news_articles_newsarticle news_articles_newsar_source_id_7de5bf12_fk_news_arti; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.news_articles_newsarticle
    ADD CONSTRAINT news_articles_newsar_source_id_7de5bf12_fk_news_arti FOREIGN KEY (source_id) REFERENCES public.news_articles_newsarticlesource(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: officers_event officers_event_appeal_id_d462b0e0_fk_appeals_appeal_id; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.officers_event
    ADD CONSTRAINT officers_event_appeal_id_d462b0e0_fk_appeals_appeal_id FOREIGN KEY (appeal_id) REFERENCES public.appeals_appeal(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: officers_event officers_event_department_id_f6f5c7c6_fk_departmen; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.officers_event
    ADD CONSTRAINT officers_event_department_id_f6f5c7c6_fk_departmen FOREIGN KEY (department_id) REFERENCES public.departments_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: officers_event officers_event_officer_id_d02a1689_fk_officers_officer_id; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.officers_event
    ADD CONSTRAINT officers_event_officer_id_d02a1689_fk_officers_officer_id FOREIGN KEY (officer_id) REFERENCES public.officers_officer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: officers_event officers_event_use_of_force_id_9e46d260_fk_use_of_fo; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.officers_event
    ADD CONSTRAINT officers_event_use_of_force_id_9e46d260_fk_use_of_fo FOREIGN KEY (use_of_force_id) REFERENCES public.use_of_forces_useofforce(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: officers_officer officers_officer_department_id_d99cd7d4_fk_departmen; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.officers_officer
    ADD CONSTRAINT officers_officer_department_id_d99cd7d4_fk_departmen FOREIGN KEY (department_id) REFERENCES public.departments_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: officers_officer officers_officer_person_id_d8cf49dc_fk_people_person_id; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.officers_officer
    ADD CONSTRAINT officers_officer_person_id_d8cf49dc_fk_people_person_id FOREIGN KEY (person_id) REFERENCES public.people_person(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: people_person people_person_canonical_officer_id_31540e72_fk_officers_; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.people_person
    ADD CONSTRAINT people_person_canonical_officer_id_31540e72_fk_officers_ FOREIGN KEY (canonical_officer_id) REFERENCES public.officers_officer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: q_and_a_question q_and_a_question_section_id_cad9f694_fk_q_and_a_section_id; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.q_and_a_question
    ADD CONSTRAINT q_and_a_question_section_id_cad9f694_fk_q_and_a_section_id FOREIGN KEY (section_id) REFERENCES public.q_and_a_section(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tasks_tasklog tasks_tasklog_task_id_94d5b7eb_fk_tasks_task_id; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.tasks_tasklog
    ADD CONSTRAINT tasks_tasklog_task_id_94d5b7eb_fk_tasks_task_id FOREIGN KEY (task_id) REFERENCES public.tasks_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blac_token_id_3cc7fe56_fk_token_bla; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blac_token_id_3cc7fe56_fk_token_bla FOREIGN KEY (token_id) REFERENCES public.token_blacklist_outstandingtoken(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outs_user_id_83bc629a_fk_authentic; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outs_user_id_83bc629a_fk_authentic FOREIGN KEY (user_id) REFERENCES public.authentication_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: use_of_forces_useofforce use_of_forces_useoff_department_id_8766c958_fk_departmen; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.use_of_forces_useofforce
    ADD CONSTRAINT use_of_forces_useoff_department_id_8766c958_fk_departmen FOREIGN KEY (department_id) REFERENCES public.departments_department(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: use_of_forces_useofforce use_of_forces_useoff_officer_id_edff0582_fk_officers_; Type: FK CONSTRAINT; Schema: public; Owner: ipno
--

ALTER TABLE ONLY public.use_of_forces_useofforce
    ADD CONSTRAINT use_of_forces_useoff_officer_id_edff0582_fk_officers_ FOREIGN KEY (officer_id) REFERENCES public.officers_officer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--
