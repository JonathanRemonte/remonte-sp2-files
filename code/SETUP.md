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
3. From this link (https://drive.google.com/drive/folders/1CmUoVRUQWRyWF17Wdwv75Jl7T1TBVpE0?usp=sharing), download and copy the following files:
- code/bioinfoPortal-sp-code/mapman/usadellab.github.io/MapManJS/Experiments/
- code/bioinfoPortal-sp-code/secrets/keys/
- code/bioinfoPortal-sp-code/bioinformatics_data.tar.gz
4. Restore the volume data to volumes
    `docker run --rm -v data:/restore-target -v $(pwd):/backup ubuntu \
  bash -c "cd /restore-target && tar xzf /backup/bioinformatics_data.tar.gz`
5. Locate the project root (/code/bioinfoPortal-sp-code/docroot/tripal4) 
6. Reinstall Composer Dependencies (`composer install`)
7. Restore Frontend node modules (cd web/themes/custom/radix then run `npm install`) 
8. Return to project root and run docker commands `docker compose build` and `docker compose up -d`