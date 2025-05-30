#!/bin/bash
set -e

# Create drupal7db database
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE drupal7db;
EOSQL

# Import drupaldb_backup.sql
# The main 'drupaldb' should already exist (as POSTGRES_DB) or be created by the entrypoint
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "drupaldb" -f /tmp/backups/drupaldb_backup.sql

# Import drupal7db_backup.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "drupal7db" -f /tmp/backups/drupal7db_backup.sql 