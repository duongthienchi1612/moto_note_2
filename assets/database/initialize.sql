CREATE TABLE IF NOT EXISTS 'devices' (
    id text,
    user_id text,
    device_name text,
    device_type_id integer,
    device_type_name text,
    last_replacement_km integer,
    next_replacement_km integer,
    last_replacement_date text,
    note text,
    create_date text,
    PRIMARY KEY('id')
);
CREATE TABLE IF NOT EXISTS 'users' (
    id text,
    user_name text,
    avatar text,
    create_date text,
    PRIMARY KEY('id')
);