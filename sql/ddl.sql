CREATE TABLE IF NOT EXISTS anime (
    anime_id        INTEGER PRIMARY KEY, 
    title           TEXT NOT NULL, 
    title_english   TEXT, 
    title_japanese  TEXT, 
    anime_type      VARCHAR(40), 
    source          VARCHAR(40),
    release_status  VARCHAR(40),
    episodes        INTEGER,
    duration        TEXT,
    duration_min    INTEGER, 
    rating          varchar(40), 
    score           NUMERIC(4,2), 
    scored_by       INTEGER, 
    score_rank      INTEGER, 
    popularity_rank INTEGER, 
    members         INTEGER, 
    favorites       INTEGER, 
    aired_year      SMALLINT, 
    season          VARCHAR(20), 
    aired_from      DATE, 
    synopsis        TEXT, 
    background      TEXT, 
    image_url       TEXT, 
    mal_url         TEXT, 
    is_top          BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS genre (
    genre_id        INTEGER PRIMARY KEY, 
    name            TEXT NOT NULL, 
    is_explicit     BOOLEAN NOT NULL DEFAULT FALSE 
);

CREATE TABLE IF NOT EXISTS demographic (
    demographic_id  INTEGER PRIMARY KEY, 
    name            TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS theme (
    theme_id        INTEGER PRIMARY KEY, 
    name            TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS producer (
    producer_id     INTEGER PRIMARY KEY, 
    name            TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS person (
    person_id       INTEGER PRIMARY KEY, 
    name            TEXT NOT NULL
);

-- Tablas de relación --
CREATE TABLE IF NOT EXISTS anime_genre (
    anime_id        INTEGER NOT NULL REFERENCES anime(anime_id) ON DELETE CASCADE,
    genre_id        INTEGER NOT NULL REFERENCES genre(genre_id) ON DELETE CASCADE,
    PRIMARY KEY (anime_id, genre_id)
);

CREATE TABLE IF NOT EXISTS anime_demographic (
    anime_id        INTEGER NOT NULL REFERENCES anime(anime_id) ON DELETE CASCADE,
    demographic_id  INTEGER NOT NULL REFERENCES demographic(demographic_id) ON DELETE CASCADE,
    PRIMARY KEY (anime_id, demographic_id)
);

CREATE TABLE IF NOT EXISTS anime_theme (
    anime_id        INTEGER NOT NULL REFERENCES anime(anime_id) ON DELETE CASCADE,
    theme_id        INTEGER NOT NULL REFERENCES theme(theme_id) ON DELETE CASCADE,
    PRIMARY KEY (anime_id, theme_id)
);

CREATE TABLE IF NOT EXISTS anime_producer (
    anime_id        INTEGER NOT NULL REFERENCES anime(anime_id) ON DELETE CASCADE,
    producer_id     INTEGER NOT NULL REFERENCES producer(producer_id) ON DELETE CASCADE,
    role            TEXT NOT NULL CHECK (role IN ('studio', 'producer', 'licensor')),
    PRIMARY KEY (anime_id, producer_id, role)
);

CREATE TABLE IF NOT EXISTS anime_staff (
    anime_id   INTEGER NOT NULL REFERENCES anime(anime_id) ON DELETE CASCADE,
    person_id  INTEGER NOT NULL REFERENCES person(person_id) ON DELETE CASCADE,
    position   TEXT NOT NULL,
    PRIMARY KEY (anime_id, person_id, position)
);

CREATE TABLE IF NOT EXISTS anime_relation (
    anime_id          INTEGER NOT NULL REFERENCES anime(anime_id) ON DELETE CASCADE,
    related_anime_id  INTEGER NOT NULL REFERENCES anime(anime_id) ON DELETE CASCADE,
    relation_type     TEXT NOT NULL,
    PRIMARY KEY (anime_id, related_anime_id, relation_type)
);

CREATE TABLE IF NOT EXISTS anime_recommendation (
    anime_id              INTEGER NOT NULL REFERENCES anime(anime_id) ON DELETE CASCADE,
    recommended_anime_id  INTEGER NOT NULL REFERENCES anime(anime_id) ON DELETE CASCADE,
    votes                 INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (anime_id, recommended_anime_id)
);

-- Indíces --
CREATE INDEX IF NOT EXISTS idx_anime_members        ON anime (members DESC);
CREATE INDEX IF NOT EXISTS idx_anime_score          ON anime (score DESC);
CREATE INDEX IF NOT EXISTS idx_anime_year           ON anime (aired_year);
CREATE INDEX IF NOT EXISTS idx_anime_genre          ON anime_genre (genre_id);
CREATE INDEX IF NOT EXISTS idx_anime_demo           ON anime_demographic (demographic_id);
CREATE INDEX IF NOT EXISTS idx_anime_theme          ON anime_theme (theme_id);
CREATE INDEX IF NOT EXISTS idx_anime_producer       ON anime_producer (producer_id);
CREATE INDEX IF NOT EXISTS idx_anime_staff          ON anime_staff (person_id);
CREATE INDEX IF NOT EXISTS idx_anime_relation       ON anime_relation (related_anime_id);
CREATE INDEX IF NOT EXISTS idx_anime_rec            ON anime_recommendation (recommended_anime_id);