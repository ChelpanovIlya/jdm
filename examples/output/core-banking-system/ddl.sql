CREATE SEQUENCE IF NOT EXISTS seq_id INCREMENT BY 1 NO MAXVALUE START WITH 1000000 CACHE 10 NO CYCLE;

-- Статическое перечисление (is_flex = false)
CREATE TYPE enum_address_type AS ENUM ('REGISTRATION', 'RESIDENCE', 'LEGAL');

-- Таблица для гибких перечислений (is_flex = true)
CREATE TABLE SYS_ENUM_ITEM
(
    code varchar(63) NULL,
    name varchar(160) NULL,
    order_num integer NULL,
    sys_class varchar(63) NULL,
    id bigint NOT NULL DEFAULT nextval('seq_id')
);

CREATE TABLE CURRENCY
(
    id bigint NOT NULL DEFAULT nextval('seq_id'),
    code varchar(10) NOT NULL,
    name varchar(100) NOT NULL,
    symbol varchar(5) NOT NULL,
    decimal_places integer NOT NULL
);

CREATE TABLE CLIENT
(
    id bigint NOT NULL DEFAULT nextval('seq_id'),
    code varchar(50) NOT NULL,
    name varchar(255) NOT NULL,
    created_dttm timestamp without time zone NOT NULL,
    -- Атрибут-коллекция (логический тип Collection -> физический BIGINT)
    addresses bigint NOT NULL DEFAULT nextval('seq_id')
);

CREATE TABLE ADDRESS
(
    id bigint NOT NULL DEFAULT nextval('seq_id'),
    code varchar(100) NOT NULL,
    name varchar(500) NOT NULL,
    -- Обратная ссылка на коллекцию (без FK, так как может указывать на разные родительские сущности)
    collection_id bigint NOT NULL DEFAULT nextval('seq_id'),
    type enum_address_type NOT NULL,
    city varchar(100) NULL,
    postal_code varchar(20) NULL,
    created_dttm timestamp without time zone NOT NULL
);

CREATE TABLE BANK_ACCOUNT
(
    id bigint NOT NULL DEFAULT nextval('seq_id'),
    code varchar(30) NOT NULL,
    name varchar(200) NOT NULL,
    -- Reference (keyType=id) -> BIGINT
    client_id bigint NOT NULL,
    -- Reference (keyType=code) -> тип refAttribute в CURRENCY (VARCHAR)
    currency varchar(10) NOT NULL,
    balance numeric(18,2) NOT NULL,
    balance_national numeric(18,2) NOT NULL,
    -- Flex Enum (is_flex=true) -> BIGINT (ссылка на SYS_ENUM_ITEM.id)
    status bigint NOT NULL,
    open_dt date NOT NULL,
    created_dttm timestamp without time zone NOT NULL
);
