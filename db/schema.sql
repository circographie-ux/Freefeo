CREATE EXTENSION IF NOT EXISTS postgis; 
CREATE TABLE IF NOT EXISTS users(
 id SERIAL PRIMARY KEY, name TEXT NOT NULL, email TEXT UNIQUE NOT NULL,
 password_hash TEXT NOT NULL, role TEXT NOT NULL DEFAULT 'diffusion', created_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE IF NOT EXISTS mailboxes(
 id SERIAL PRIMARY KEY, user_id INT REFERENCES users(id) ON DELETE CASCADE,
 email TEXT NOT NULL, provider TEXT NOT NULL, access_token TEXT, refresh_token TEXT, created_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE IF NOT EXISTS structures(
 id SERIAL PRIMARY KEY, name TEXT NOT NULL, type TEXT, street TEXT, postal_code TEXT, city TEXT,
 region TEXT, country TEXT, website TEXT, programming_url TEXT, programming_summary TEXT,
 programming_period TEXT, latitude DOUBLE PRECISION, longitude DOUBLE PRECISION,
 geom GEOGRAPHY(POINT,4326), status TEXT, notes TEXT, updated_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE IF NOT EXISTS keywords(id SERIAL PRIMARY KEY,name TEXT UNIQUE NOT NULL);
CREATE TABLE IF NOT EXISTS structure_keywords(structure_id INT REFERENCES structures(id) ON DELETE CASCADE,keyword_id INT REFERENCES keywords(id) ON DELETE CASCADE,PRIMARY KEY(structure_id,keyword_id));
CREATE TABLE IF NOT EXISTS contacts(
 id SERIAL PRIMARY KEY, structure_id INT REFERENCES structures(id) ON DELETE CASCADE,
 name TEXT NOT NULL, role TEXT, email TEXT, phone TEXT, notes TEXT, updated_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE IF NOT EXISTS mailing_lists(id SERIAL PRIMARY KEY,name TEXT NOT NULL,created_at TIMESTAMPTZ DEFAULT now());
CREATE TABLE IF NOT EXISTS list_members(list_id INT REFERENCES mailing_lists(id) ON DELETE CASCADE,structure_id INT REFERENCES structures(id) ON DELETE CASCADE,contact_id INT REFERENCES contacts(id) ON DELETE CASCADE,notes TEXT,last_modified TIMESTAMPTZ DEFAULT now(),PRIMARY KEY(list_id,contact_id));
CREATE TABLE IF NOT EXISTS templates(id SERIAL PRIMARY KEY,name TEXT NOT NULL,subject TEXT,body TEXT,created_at TIMESTAMPTZ DEFAULT now());
CREATE TABLE IF NOT EXISTS emails(
 id SERIAL PRIMARY KEY,user_id INT REFERENCES users(id),mailbox_id INT REFERENCES mailboxes(id),
 structure_id INT REFERENCES structures(id),contact_id INT REFERENCES contacts(id),
 to_email TEXT,subject TEXT,body TEXT,attachments JSONB DEFAULT '[]',status TEXT,created_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE IF NOT EXISTS program_stats(
 id SERIAL PRIMARY KEY,structure_id INT REFERENCES structures(id) ON DELETE CASCADE,
 season TEXT, cirque INT DEFAULT 0, danse INT DEFAULT 0, rue INT DEFAULT 0, theatre INT DEFAULT 0, musique INT DEFAULT 0,
 updated_at TIMESTAMPTZ DEFAULT now()
);
