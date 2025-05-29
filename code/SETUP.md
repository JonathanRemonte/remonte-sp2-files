# Development Set-up
## Prerequisites
### Server Requirements (Running versions in the system as of 05/06/2025):
* Web server (Apache2)
* PHP (8.1.2)
* Database Server (PostgreSQL 14.12)
### Software Requirements (Running versions in the system as of 05/06/2025):
* Drupal 10.3.x
* Tripal 4
* Composer 2.2.6
* Docker Desktop 4.33.1

## Instructions
1. Clone the project from GitHub
2. Create a .env file and copy the contents from this link (https://docs.google.com/document/d/1eV3rg8T5-ETM6vUKekzcQ77l6YL-fh4_O9mEX5tFsn0/edit?usp=sharing)
3. Move the `/code/bioinfoPortal-sp-code` folder to `/home/admin/bioinformatics` or simply change the PROJECT_ROOT variable in .env file
4. From this link (https://drive.google.com/drive/folders/1CmUoVRUQWRyWF17Wdwv75Jl7T1TBVpE0?usp=sharing), download and copy the following files:
- /home/admin/bioinformatics/mapman/usadellab.github.io/MapManJS/Experiments/
- /home/admin/bioinformatics/secrets/
- /home/admin/drupaldb_backup.sql
- /home/admin/drupal7db_backup.sql
5. Change ownership of the project directory using this command `sudo chown -R $USER:$USER /home/admin/bioinformatics`
6. Run `docker compose build` and `docker compose up -d` in /home/admin/bioinformatics
7. Enter php-apache container by `docker exec -it php-apache bash` then run `composer install`
8. Copy both backup sql files into the postgres container using these commands:
`docker cp /home/admin/drupaldb_backup.sql postgres:/drupaldb_backup.sql`
`docker cp /home/admin/drupal7db_backup.sql postgres:/drupal7db_backup.sql`
9. Import the backup for drupaldb first inside the postgres container by running 
`docker exec -it postgres bash`
`psql -U drupal -d drupaldb -f /drupaldb_backup.sql`
`exit`
10. Create another database for drupal7db (synteny instance) by running
`docker exec -it postgres bash`
`psql -U drupal -d postgres`
`CREATE DATABASE drupal7db;`
`\q`
`psql -U drupal -d drupal7db -f /drupal7db_backup.sql`
11. Install theme dependencies by running
`docker exec -it php-apache bash`
`cd web/themes/custom/ww_radix`
`npm install`
`npm run dev`
`cd ../../../../`
`vendor/bin/drush cr`
12. Ensure proper file permissions to synteny7 settings.php (for database access)
`docker exec -it synteny bash`
`cd /sites/default/`
`cp default.settings.php settings.php`
`chmod 644 sites/default/settings.php`
`chmod 755 sites/default`
13. Ensure proper file ownership and permissions to private.key (for jwt generation and sending)
`docker exec -it php-apache bash`
`cd /var/www/private_keys`
`chown www-data:www-data /var/www/private_keys/private.key`
`chmod 400 /var/www/private_keys/private.key`