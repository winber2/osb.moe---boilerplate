CREATE DATABASE osb;
CREATE USER hifumi WITH PASSWORD 'hentai';
ALTER ROLE hifumi SET client_encoding TO 'utf8';
ALTER ROLE hifumi SET timezone TO 'America/Los_Angeles';
ALTER ROLE hifumi WITH SUPERUSER;
GRANT ALL PRIVILEGES ON DATABASE osb TO hifumi;
