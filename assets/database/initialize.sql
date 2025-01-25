CREATE TABLE IF NOT EXISTS 'devices' (
    id text,
    device_name text,
    device_type_id integer,
    device_type_name text,
    last_replacement_km integer,
    next_replacement_km integer,
    last_replacement_date text,
    note text,
    create_at text,
    PRIMARY KEY('id')
);