/* Prepare users */
/* Prepare databases */
/* Create database stories */
DO
$$
BEGIN
  IF EXISTS (SELECT FROM pg_database WHERE datname = 'stories') THEN
    RAISE NOTICE 'Database stories already exists, skipping';
  END IF;
END
$$;

SELECT 'CREATE DATABASE stories OWNER hasura' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'stories'); \gexec
/* Create database users */
DO
$$
BEGIN
  IF EXISTS (SELECT FROM pg_database WHERE datname = 'users') THEN
    RAISE NOTICE 'Database users already exists, skipping';
  END IF;
END
$$;

SELECT 'CREATE DATABASE users OWNER hasura' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'users'); \gexec
/* Create roles for stories and grant privileges */

\c stories
DO $$
BEGIN
  /* Create stories_readonly role */
  CREATE ROLE stories_readonly NOLOGIN;

  /* Grant access to all tables */
  GRANT CONNECT ON DATABASE stories TO stories_readonly;
  GRANT USAGE ON SCHEMA public TO stories_readonly;
  GRANT SELECT ON ALL TABLES IN SCHEMA public TO stories_readonly;
  GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO stories_readonly;
  GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO stories_readonly;

  /* Grant access to future tables created by hasura (owner) */
  ALTER DEFAULT PRIVILEGES FOR ROLE hasura IN SCHEMA public GRANT SELECT ON TABLES TO stories_readonly;
  ALTER DEFAULT PRIVILEGES FOR ROLE hasura IN SCHEMA public GRANT SELECT ON SEQUENCES TO stories_readonly;
  ALTER DEFAULT PRIVILEGES FOR ROLE hasura IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO stories_readonly;
EXCEPTION WHEN DUPLICATE_OBJECT THEN
  RAISE NOTICE 'Role stories_readonly already exists, skipping';
END
$$;

DO $$
BEGIN
  /* Create stories_readwrite role */
  CREATE ROLE stories_readwrite NOLOGIN;

  /* Grant write privileges */
  GRANT stories_readonly TO stories_readwrite;
  GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO stories_readwrite;

  /* Grant write privileges to future tables created by hasura (owner) */
  ALTER DEFAULT PRIVILEGES FOR ROLE hasura IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO stories_readwrite;
EXCEPTION WHEN DUPLICATE_OBJECT THEN
  RAISE NOTICE 'Role stories_readwrite already exists, skipping';
END
$$;

\c hasura
/* Create roles for users and grant privileges */

\c users
DO $$
BEGIN
  /* Create users_readonly role */
  CREATE ROLE users_readonly NOLOGIN;

  /* Grant access to all tables */
  GRANT CONNECT ON DATABASE users TO users_readonly;
  GRANT USAGE ON SCHEMA public TO users_readonly;
  GRANT SELECT ON ALL TABLES IN SCHEMA public TO users_readonly;
  GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO users_readonly;
  GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO users_readonly;

  /* Grant access to future tables created by hasura (owner) */
  ALTER DEFAULT PRIVILEGES FOR ROLE hasura IN SCHEMA public GRANT SELECT ON TABLES TO users_readonly;
  ALTER DEFAULT PRIVILEGES FOR ROLE hasura IN SCHEMA public GRANT SELECT ON SEQUENCES TO users_readonly;
  ALTER DEFAULT PRIVILEGES FOR ROLE hasura IN SCHEMA public GRANT EXECUTE ON FUNCTIONS TO users_readonly;
EXCEPTION WHEN DUPLICATE_OBJECT THEN
  RAISE NOTICE 'Role users_readonly already exists, skipping';
END
$$;

DO $$
BEGIN
  /* Create users_readwrite role */
  CREATE ROLE users_readwrite NOLOGIN;

  /* Grant write privileges */
  GRANT users_readonly TO users_readwrite;
  GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO users_readwrite;

  /* Grant write privileges to future tables created by hasura (owner) */
  ALTER DEFAULT PRIVILEGES FOR ROLE hasura IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO users_readwrite;
EXCEPTION WHEN DUPLICATE_OBJECT THEN
  RAISE NOTICE 'Role users_readwrite already exists, skipping';
END
$$;

\c hasura
