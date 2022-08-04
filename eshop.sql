-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------

-- Table: public.tokens

-- DROP TABLE IF EXISTS public.tokens;

CREATE TABLE IF NOT EXISTS public.tokens
(
    id integer NOT NULL DEFAULT nextval('tokens_id_seq'::regclass),
    created_date timestamp without time zone,
    token character varying(255) COLLATE pg_catalog."default",
    user_id bigint NOT NULL,
    CONSTRAINT tokens_pkey PRIMARY KEY (id),
    CONSTRAINT fk2dylsfo39lgjyqml2tbe0b0ss FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tokens
    OWNER to postgres;
	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------

--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'Lamps', 0, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'Carpets', 1, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'Sofas', 2, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'Curtains', 3, '2022-06-23 23:03:26', '2022-06-23 23:03:26');


--Product


INSERT INTO "public"."product_info" VALUES ('IF001', 0, '2022-06-23 23:03:26', 'Beige Shade Table Lamp Withn Antique Terracotta Base', 'https://ii2.pepperfry.com/media/catalog/product/b/e/494x544/beige-shade-table-lamp-withn-antique-terracotta-base-beige-shade-table-lamp-withn-antique-terracotta-my5xrk.jpg', 'Foziq', 50.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF002', 0, '2022-06-23 23:03:26', 'Wooden Dome Table Lamp Animal Printed Shade', 'https://ii3.pepperfry.com/media/catalog/product/w/o/494x544/wooden-dome-table-lamp-animal-printed-shade-wooden-dome-table-lamp-animal-printed-shade-fqpohu.jpg', 'Green Girgit', 65.00, 0, 60, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF003', 0, '2022-06-23 23:03:26', 'Brown Natural Fiber Designer Table Lamp', 'https://ii1.pepperfry.com/media/catalog/product/b/r/494x544/brown-natural-fiber-designer-table-lamp-by-foziq-brown-natural-fiber-designer-table-lamp-by-foziq-ctlv5o.jpg', 'Disoo Fashions', 45.00, 0, 40, '2022-06-23 23:03:26');

INSERT INTO "public"."product_info" VALUES ('WS001', 1, '2022-06-23 23:03:26', 'Blue Nylon Abstract 5 X 7 Feet Machine Made Carpet', 'https://ii2.pepperfry.com/media/catalog/product/b/l/494x544/blue-nylon-5x7-ft-abstract-pattern-carpet-by-status-blue-nylon-5x7-ft-abstract-pattern-carpet-by-sta-jpahpm.jpg', 'Status', 53.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS002', 1, '2022-06-23 23:03:26', 'Grey Cotton Shag 3 X 5 Feet Machine Made Carpet', 'https://ii3.pepperfry.com/media/catalog/product/s/a/494x544/saral-home-soft-cotton-tufted-saggy-floor-carpet--90x150-cm-saral-home-soft-cotton-tufted-saggy-floo-o4psuu.jpg', 'Saral Home', 85.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS003', 1, '2022-06-23 23:03:26', 'Blue Nylon Abstract 5 X 7 Feet Machine Made Carpet', 'https://ii1.pepperfry.com/media/catalog/product/b/l/494x544/blue-nylon-5x7-ft-abstract-pattern-carpet-by-status-blue-nylon-5x7-ft-abstract-pattern-carpet-by-sta-rdug4n.jpg', 'ETurf', 45.00, 0, 50, '2022-06-23 23:03:26');


INSERT INTO "public"."product_info" VALUES ('PA001', 2, '2022-06-23 23:03:26', 'Bali 3 Seater Sofa In Blue Colour', 'https://ii2.pepperfry.com/media/catalog/product/b/a/494x544/bali-3-seater-sofa-in-blue-colour-by-trevi-furniture-bali-3-seater-sofa-in-blue-colour-by-trevi-furn-tqyjeg.jpg', 'Febonic', 73.00, 0, 45, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA002', 2, '2022-06-23 23:03:26', 'Jordan RHS Sectional Sofa In Blue Colour', 'https://ii1.pepperfry.com/media/catalog/product/j/o/494x544/jordan-rhs-sectional-sofa-in-blue-colour-jordan-rhs-sectional-sofa-in-blue-colour-lacgro.jpg', 'Muebles Casa', 57.00, 0, 53, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA003', 2, '2022-06-23 23:03:26', 'Bliss 6 Seater RHS Sectional Sofa In Black & Grey Colour', 'https://ii2.pepperfry.com/media/catalog/product/b/l/494x544/bliss-6-seater-rhs-sectional-sofa-in-black---grey-colour-by-trevi-furniture-bliss-6-seater-rhs-secti-xtu3dy.jpg', 'Trevi Furniture', 95.00, 0, 70, '2022-06-23 23:03:26');


INSERT INTO "public"."product_info" VALUES ('AF001', 3, '2022-06-23 23:03:26', 'Beige Jute Solid 5 Ft Light Filtering Eyelet 1 Window Curtain', 'https://ii2.pepperfry.com/media/catalog/product/b/e/494x544/beige-blackout-jute-5-feet-eyelet-window-curtain-by-skyloom-beige-blackout-jute-5-feet-eyelet-window-wn6gsv.jpg', 'Skyloom', 90.00, 0, 39, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF002', 3, '2022-06-23 23:03:26', 'Off White Cotton Floral 7 Ft Sheer Eyelet 2 Door Curtains', 'https://ii3.pepperfry.com/media/catalog/product/w/h/494x544/white-sheer-cotton-7-feet-eyelet-door-curtains-set-of-2-by-curtain-label-white-sheer-cotton-7-feet-e-lekpmf.jpg', 'Curtain Label', 76.00, 0, 75, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF003', 3, '2022-06-23 23:03:26', 'Ivory Polyester Solid 8 Ft Sheer Eyelet 2 Curtains', 'https://ii1.pepperfry.com/media/catalog/product/i/v/494x544/ivory-polyester-solid-7-5ft-sheer-eyelet-2-pc-door-curtains-by-deco-window-ivory-polyester-solid-7-5-wdkocs.jpg', 'Deco Window', 82.00, 0, 20, '2022-06-23 23:03:26');






------------------------------------------------------------------------------------------------------------------------

--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'FD/A1, Narayan Vihar, Gwalior', 'admin@shopforhome.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');

CREATE SEQUENCE IF NOT EXISTS public.hibernate_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.hibernate_sequence
    OWNER TO postgres