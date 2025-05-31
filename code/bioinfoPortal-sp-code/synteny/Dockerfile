# Use the PHP-Apache image
ARG PHP_VERSION="8.1"
FROM php:${PHP_VERSION}-apache

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extension
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo_pgsql

# Increase PHP memory limit and upload settings
RUN echo "memory_limit=2G" > /usr/local/etc/php/conf.d/memory-limit.ini && \
    echo "upload_max_filesize=2G" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "max_input_time=300" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "max_execution_time=300" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "post_max_size=2G" >> /usr/local/etc/php/conf.d/uploads.ini

# Enable Apache modules
RUN a2enmod rewrite headers

# Allow embedding in an iframe from localhost:8080
RUN echo 'Header always set X-Frame-Options "ALLOW-FROM http://localhost:8080"' >> /etc/apache2/apache2.conf && \
    echo 'Header always set Content-Security-Policy "frame-ancestors \"self\" http://localhost:8080"' >> /etc/apache2/apache2.conf

# Set working directory
WORKDIR /var/www/html

# Copy Synteny application code
COPY synteny7/ /var/www/html/

RUN if [ -f /var/www/html/sites/default/default.settings.php ] && [ ! -f /var/www/html/sites/default/settings.php ]; then \
    cp /var/www/html/sites/default/default.settings.php /var/www/html/sites/default/settings.php && \
    chown www-data:www-data /var/www/html/sites/default/settings.php && \
    chmod 644 /var/www/html/sites/default/settings.php && \
    echo "Created settings.php from default.settings.php"; \
    else \
        if [ -f /var/www/html/sites/default/settings.php ]; then \
            echo "settings.php already exists."; \
        else \
            echo "default.settings.php not found. Cannot create settings.php." && exit 1; \
        fi; \
    fi

# Expose Apache port
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
