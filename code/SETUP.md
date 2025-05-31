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
5. Navigate to tripal4/ folder and install composer files by running `cd /home/admin/bioinformatics/docroot/tripal` and run `composer install`
6. Navigate back to `cd /home/admin/bioinformatics` and run docker compose up --build.
7. Open a browser and test the website on address  http://13.250.212.83:8080
