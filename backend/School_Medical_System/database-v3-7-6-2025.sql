--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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
-- Name: class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.class (
    grade integer NOT NULL,
    totalstudent integer DEFAULT 0,
    class_id bigint NOT NULL,
    class_name character varying(100) NOT NULL
);


ALTER TABLE public.class OWNER TO postgres;

--
-- Name: class_class_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.class ALTER COLUMN class_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.class_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: health_check_campaign; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.health_check_campaign (
    check_date date NOT NULL,
    target_grade integer,
    created_at timestamp(6) with time zone DEFAULT now(),
    created_by bigint,
    health_check_campaign_id bigint NOT NULL,
    status character varying(20) NOT NULL,
    location character varying(100),
    name character varying(255) NOT NULL,
    description text,
    required_equipment text
);


ALTER TABLE public.health_check_campaign OWNER TO postgres;

--
-- Name: health_check_campaign_health_check_campaign_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.health_check_campaign ALTER COLUMN health_check_campaign_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.health_check_campaign_health_check_campaign_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: health_check_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.health_check_consent (
    consent_id bigint NOT NULL,
    health_check_campaign_id bigint NOT NULL,
    parent_id bigint NOT NULL,
    response_date timestamp(6) with time zone,
    student_id bigint NOT NULL,
    academic_year character varying(9) NOT NULL,
    consent_status character varying(20) NOT NULL,
    status character varying(255),
    notes text,
    special_requests text
);


ALTER TABLE public.health_check_consent OWNER TO postgres;

--
-- Name: health_check_consent_consent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.health_check_consent ALTER COLUMN consent_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.health_check_consent_consent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: health_check_result; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.health_check_result (
    bmi numeric(5,2),
    follow_up_required boolean DEFAULT false,
    height_cm numeric(5,2),
    pulse integer,
    temperature numeric(4,1),
    weight_kg numeric(5,2),
    check_date timestamp(6) with time zone NOT NULL,
    checked_by bigint NOT NULL,
    health_check_campaign_id bigint NOT NULL,
    result_id bigint NOT NULL,
    student_id bigint NOT NULL,
    academic_year character varying(9) NOT NULL,
    vision_left character varying(10),
    vision_right character varying(10),
    blood_pressure character varying(20),
    overall_health_rating character varying(20),
    dental_health text,
    follow_up_notes text,
    hearing text,
    other_notes text,
    recommendation text
);


ALTER TABLE public.health_check_result OWNER TO postgres;

--
-- Name: health_check_result_result_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.health_check_result ALTER COLUMN result_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.health_check_result_result_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: health_declaration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.health_declaration (
    declaration_date timestamp(6) with time zone DEFAULT now(),
    declaration_id bigint NOT NULL,
    declared_by bigint NOT NULL,
    reviewed_by bigint,
    reviewed_date timestamp(6) with time zone,
    student_id bigint NOT NULL,
    academic_year character varying(9) NOT NULL,
    status character varying(20) NOT NULL
);


ALTER TABLE public.health_declaration OWNER TO postgres;

ALTER TABLE public.health_declaration ALTER COLUMN declaration_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.health_declaration_declaration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE public.health_declaration_detail (
    created_at timestamp(6) with time zone DEFAULT now(),
    declaration_id bigint NOT NULL,
    detail_id bigint NOT NULL,
    severity character varying(20),
    category character varying(50) NOT NULL,
    additional_info jsonb,
    description text NOT NULL
);


ALTER TABLE public.health_declaration_detail OWNER TO postgres;

--
-- Name: health_declaration_detail_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.health_declaration_detail ALTER COLUMN detail_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.health_declaration_detail_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: medication; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medication (
    prescription_required boolean DEFAULT true NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now(),
    medication_id bigint NOT NULL,
    updated_at timestamp(6) with time zone,
    country_of_origin character varying(100),
    dosage_form character varying(100) NOT NULL,
    active_ingredient character varying(255),
    category character varying(255) NOT NULL,
    description character varying(255),
    manufacturer character varying(255),
    medication_name character varying(255) NOT NULL,
    medication_img text,
    medication_information text
);


ALTER TABLE public.medication OWNER TO postgres;

--
-- Name: medication_medication_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.medication ALTER COLUMN medication_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.medication_medication_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: medication_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medication_request (
    request_date timestamp(6) with time zone DEFAULT now(),
    request_id bigint NOT NULL,
    requested_by bigint NOT NULL,
    review_date timestamp(6) with time zone,
    reviewed_by bigint,
    student_id bigint NOT NULL,
    academic_year character varying(9) NOT NULL,
    priority character varying(20),
    status character varying(20) NOT NULL,
    notes text
);


ALTER TABLE public.medication_request OWNER TO postgres;

--
-- Name: medication_request_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medication_request_detail (
    end_date date NOT NULL,
    quantity integer NOT NULL,
    start_date date NOT NULL,
    detail_id bigint NOT NULL,
    medication_id bigint NOT NULL,
    request_id bigint NOT NULL,
    status character varying(20),
    actual_administration jsonb,
    administration_time time(6) without time zone[],
    attachment_url text,
    dosage text NOT NULL,
    frequency text NOT NULL
);


ALTER TABLE public.medication_request_detail OWNER TO postgres;

--
-- Name: medication_request_detail_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.medication_request_detail ALTER COLUMN detail_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.medication_request_detail_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: medication_request_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.medication_request ALTER COLUMN request_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.medication_request_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    date_create date NOT NULL,
    notification_id bigint NOT NULL,
    user_id bigint NOT NULL,
    content character varying(255) NOT NULL,
    status character varying(255),
    title character varying(255) NOT NULL,
    CONSTRAINT notifications_status_check CHECK (((status)::text = ANY ((ARRAY['ACTIVE'::character varying, 'VERIFY'::character varying, 'BAN'::character varying, 'DELETED'::character varying])::text[])))
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.notifications ALTER COLUMN notification_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.notifications_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    class_id bigint,
    created_at timestamp(6) with time zone,
    parent_id bigint,
    student_id bigint NOT NULL,
    updated_at timestamp(6) with time zone,
    user_id bigint,
    blood_type character varying(10),
    student_code character varying(50) NOT NULL,
    genetic_diseases text,
    other_medical_notes text,
    emergency_contact jsonb
);


ALTER TABLE public.student OWNER TO postgres;

--
-- Name: student_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.student ALTER COLUMN student_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.student_student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    dob date,
    user_id bigint NOT NULL,
    gender character varying(10),
    phone character varying(20) NOT NULL,
    address character varying(255),
    email character varying(255),
    fullname character varying(255),
    role_name character varying(255),
    status character varying(255),
    username character varying(255),
    avatarurl text,
    password text,
    CONSTRAINT user_role_name_check CHECK (((role_name)::text = ANY ((ARRAY['STUDENT'::character varying, 'PARENT'::character varying, 'ADMIN'::character varying, 'SCHOOL_NURSE'::character varying])::text[]))),
    CONSTRAINT user_status_check CHECK (((status)::text = ANY ((ARRAY['ACTIVE'::character varying, 'VERIFY'::character varying, 'BAN'::character varying, 'DELETED'::character varying])::text[])))
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."user" ALTER COLUMN user_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.user_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: vaccination_campaign; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vaccination_campaign (
    end_date date NOT NULL,
    start_date date NOT NULL,
    target_grade integer,
    created_at timestamp(6) with time zone DEFAULT now(),
    created_by bigint,
    vaccination_campaign_id bigint NOT NULL,
    status character varying(20) NOT NULL,
    vaccine_type character varying(100) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    notes text
);


ALTER TABLE public.vaccination_campaign OWNER TO postgres;

--
-- Name: vaccination_campaign_vaccination_campaign_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.vaccination_campaign ALTER COLUMN vaccination_campaign_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.vaccination_campaign_vaccination_campaign_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: vaccination_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vaccination_consent (
    consent_id bigint NOT NULL,
    parent_id bigint NOT NULL,
    response_date timestamp(6) with time zone,
    student_id bigint NOT NULL,
    vaccination_campaign_id bigint NOT NULL,
    academic_year character varying(9) NOT NULL,
    consent_status character varying(20) NOT NULL,
    consent_form_url text,
    notes text
);


ALTER TABLE public.vaccination_consent OWNER TO postgres;

--
-- Name: vaccination_consent_consent_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.vaccination_consent ALTER COLUMN consent_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.vaccination_consent_consent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: vaccination_record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vaccination_record (
    expiration_date date,
    follow_up_required boolean DEFAULT false,
    next_dose_date date,
    administered_by bigint NOT NULL,
    administration_date timestamp(6) with time zone NOT NULL,
    record_id bigint NOT NULL,
    student_id bigint NOT NULL,
    vaccination_campaign_id bigint NOT NULL,
    academic_year character varying(9) NOT NULL,
    injection_site character varying(50),
    lot_number character varying(100),
    vaccine_batch character varying(100) NOT NULL,
    vaccine_name character varying(255) NOT NULL,
    follow_up_notes text,
    reaction_notes text
);


ALTER TABLE public.vaccination_record OWNER TO postgres;

--
-- Name: vaccination_record_record_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.vaccination_record ALTER COLUMN record_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.vaccination_record_record_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: class class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_pkey PRIMARY KEY (class_id);


--
-- Name: health_check_campaign health_check_campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_check_campaign
    ADD CONSTRAINT health_check_campaign_pkey PRIMARY KEY (health_check_campaign_id);


--
-- Name: health_check_consent health_check_consent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_check_consent
    ADD CONSTRAINT health_check_consent_pkey PRIMARY KEY (consent_id);


--
-- Name: health_check_result health_check_result_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_check_result
    ADD CONSTRAINT health_check_result_pkey PRIMARY KEY (result_id);


--
-- Name: health_declaration_detail health_declaration_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_declaration_detail
    ADD CONSTRAINT health_declaration_detail_pkey PRIMARY KEY (detail_id);


--
-- Name: health_declaration health_declaration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_declaration
    ADD CONSTRAINT health_declaration_pkey PRIMARY KEY (declaration_id);


--
-- Name: medication medication_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication
    ADD CONSTRAINT medication_pkey PRIMARY KEY (medication_id);


--
-- Name: medication_request_detail medication_request_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication_request_detail
    ADD CONSTRAINT medication_request_detail_pkey PRIMARY KEY (detail_id);


--
-- Name: medication_request medication_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication_request
    ADD CONSTRAINT medication_request_pkey PRIMARY KEY (request_id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- Name: student student_student_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_student_code_key UNIQUE (student_code);


--
-- Name: student student_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_user_id_key UNIQUE (user_id);


--
-- Name: user user_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_phone_key UNIQUE (phone);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);


--
-- Name: vaccination_campaign vaccination_campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccination_campaign
    ADD CONSTRAINT vaccination_campaign_pkey PRIMARY KEY (vaccination_campaign_id);


--
-- Name: vaccination_consent vaccination_consent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccination_consent
    ADD CONSTRAINT vaccination_consent_pkey PRIMARY KEY (consent_id);


--
-- Name: vaccination_record vaccination_record_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccination_record
    ADD CONSTRAINT vaccination_record_pkey PRIMARY KEY (record_id);


--
-- Name: vaccination_consent fk1ctwr4hjwksqtgra324sgt84d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccination_consent
    ADD CONSTRAINT fk1ctwr4hjwksqtgra324sgt84d FOREIGN KEY (vaccination_campaign_id) REFERENCES public.vaccination_campaign(vaccination_campaign_id) ON DELETE CASCADE;


--
-- Name: health_check_campaign fk1mokci7gjpflbx1pj8l8jpvrj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_check_campaign
    ADD CONSTRAINT fk1mokci7gjpflbx1pj8l8jpvrj FOREIGN KEY (created_by) REFERENCES public."user"(user_id);


--
-- Name: vaccination_campaign fk1tg1kvhdjs312f7ecpitf16x0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccination_campaign
    ADD CONSTRAINT fk1tg1kvhdjs312f7ecpitf16x0 FOREIGN KEY (created_by) REFERENCES public."user"(user_id);


--
-- Name: vaccination_consent fk2gcywhvcs2scdi711bdpvnwpr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccination_consent
    ADD CONSTRAINT fk2gcywhvcs2scdi711bdpvnwpr FOREIGN KEY (parent_id) REFERENCES public."user"(user_id);


--
-- Name: notifications fk3dt2b80521eynbjg4nehtjnhy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk3dt2b80521eynbjg4nehtjnhy FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: health_declaration fk606lo0fgh8vlpd2068hdrro1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_declaration
    ADD CONSTRAINT fk606lo0fgh8vlpd2068hdrro1 FOREIGN KEY (declared_by) REFERENCES public."user"(user_id);


--
-- Name: health_declaration_detail fk749i9t9lvv5bhqy3xvsouxvoo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_declaration_detail
    ADD CONSTRAINT fk749i9t9lvv5bhqy3xvsouxvoo FOREIGN KEY (declaration_id) REFERENCES public.health_declaration(declaration_id) ON DELETE CASCADE;


--
-- Name: health_check_consent fk7kr6tqlnai89h1aw3o29bid7v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_check_consent
    ADD CONSTRAINT fk7kr6tqlnai89h1aw3o29bid7v FOREIGN KEY (parent_id) REFERENCES public."user"(user_id);


--
-- Name: health_declaration fk8u0p1oht4a0v6jw27i1wcqp3j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_declaration
    ADD CONSTRAINT fk8u0p1oht4a0v6jw27i1wcqp3j FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- Name: medication_request_detail fk9au8st0bletqukf4nt0h38o8m; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication_request_detail
    ADD CONSTRAINT fk9au8st0bletqukf4nt0h38o8m FOREIGN KEY (medication_id) REFERENCES public.medication(medication_id);


--
-- Name: medication_request fka125sku41h21gy5ylw8i0p4bh; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication_request
    ADD CONSTRAINT fka125sku41h21gy5ylw8i0p4bh FOREIGN KEY (reviewed_by) REFERENCES public."user"(user_id);


--
-- Name: vaccination_record fkabp3v5ooen11d7bukiylsdqr4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccination_record
    ADD CONSTRAINT fkabp3v5ooen11d7bukiylsdqr4 FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- Name: medication_request fkaxk1uvlagpxk9ljnlohav4q1x; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication_request
    ADD CONSTRAINT fkaxk1uvlagpxk9ljnlohav4q1x FOREIGN KEY (requested_by) REFERENCES public."user"(user_id);


--
-- Name: student fkbwwkmjlr4xg4te7f70fl0w49g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT fkbwwkmjlr4xg4te7f70fl0w49g FOREIGN KEY (parent_id) REFERENCES public."user"(user_id);


--
-- Name: vaccination_consent fkby2v46a94cvmsom5nhf0qbp65; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccination_consent
    ADD CONSTRAINT fkby2v46a94cvmsom5nhf0qbp65 FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- Name: student fkdwhkib64u47wc4yo4hk0cub90; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT fkdwhkib64u47wc4yo4hk0cub90 FOREIGN KEY (class_id) REFERENCES public.class(class_id);


--
-- Name: health_check_result fkemf5j8jnmk1u7j92o6ndrajut; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_check_result
    ADD CONSTRAINT fkemf5j8jnmk1u7j92o6ndrajut FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- Name: health_check_result fkgecn8i1903wnuaeroi8uu16w9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_check_result
    ADD CONSTRAINT fkgecn8i1903wnuaeroi8uu16w9 FOREIGN KEY (checked_by) REFERENCES public."user"(user_id);


--
-- Name: vaccination_record fkgo6tiu9nyl9lrl33jjt0xgudo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccination_record
    ADD CONSTRAINT fkgo6tiu9nyl9lrl33jjt0xgudo FOREIGN KEY (administered_by) REFERENCES public."user"(user_id);


--
-- Name: medication_request fkifv1p7nhign1019smy94rsghm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication_request
    ADD CONSTRAINT fkifv1p7nhign1019smy94rsghm FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- Name: health_declaration fkj7cqfs0fcs8nye0gchpjtg9cq; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_declaration
    ADD CONSTRAINT fkj7cqfs0fcs8nye0gchpjtg9cq FOREIGN KEY (reviewed_by) REFERENCES public."user"(user_id);


--
-- Name: medication_request_detail fkjfi0hvq8t9bm8iw5th5oiomm0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medication_request_detail
    ADD CONSTRAINT fkjfi0hvq8t9bm8iw5th5oiomm0 FOREIGN KEY (request_id) REFERENCES public.medication_request(request_id) ON DELETE CASCADE;


--
-- Name: student fkk5m148xqefonqw7bgnpm0snwj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT fkk5m148xqefonqw7bgnpm0snwj FOREIGN KEY (user_id) REFERENCES public."user"(user_id);


--
-- Name: vaccination_record fkkonesuvcehtwnnn5muwgj1jgk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vaccination_record
    ADD CONSTRAINT fkkonesuvcehtwnnn5muwgj1jgk FOREIGN KEY (vaccination_campaign_id) REFERENCES public.vaccination_campaign(vaccination_campaign_id);


--
-- Name: health_check_result fkl5g8n29nkh84csbtwn8hfnxki; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_check_result
    ADD CONSTRAINT fkl5g8n29nkh84csbtwn8hfnxki FOREIGN KEY (health_check_campaign_id) REFERENCES public.health_check_campaign(health_check_campaign_id);


--
-- Name: health_check_consent fklarl0xyqg136j3bwpfmdsjnr1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_check_consent
    ADD CONSTRAINT fklarl0xyqg136j3bwpfmdsjnr1 FOREIGN KEY (health_check_campaign_id) REFERENCES public.health_check_campaign(health_check_campaign_id) ON DELETE CASCADE;


--
-- Name: health_check_consent fkle0q8ouxhy716oe7b7wgfutas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_check_consent
    ADD CONSTRAINT fkle0q8ouxhy716oe7b7wgfutas FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- PostgreSQL database dump complete
--

