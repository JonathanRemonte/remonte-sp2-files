# # Use the PHP-Apache image
# ARG PHP_VERSION="8.1"
# FROM php:${PHP_VERSION}-apache

# # # Install required system dependencies
# RUN apt-get update && apt-get install -y \
#     libpq-dev \
#     libpng-dev \
#     libjpeg-dev \
#     libfreetype6-dev \
#     zlib1g-dev \
#     postgresql-client \
#     && rm -rf /var/lib/apt/lists/*

# # # Install PHP extension
# RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
#     docker-php-ext-install gd pdo_pgsql

# # # Install Composer
# # RUN curl -sS https://getcomposer.org/installer | php && \
# #     mv composer.phar /usr/local/bin/composer && \
# #     ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush

# # # Increase PHP memory limit and upload settings
# # RUN echo "memory_limit=2G" > /usr/local/etc/php/conf.d/memory-limit.ini && \
# #     echo "upload_max_filesize=2G" >> /usr/local/etc/php/conf.d/uploads.ini && \
# #     echo "max_input_time=300" >> /usr/local/etc/php/conf.d/uploads.ini && \
# #     echo "max_execution_time=300" >> /usr/local/etc/php/conf.d/uploads.ini && \
# #     echo "post_max_size=2G" >> /usr/local/etc/php/conf.d/uploads.ini

# # # Enable Apache mod_rewrite
# # RUN a2enmod rewrite

# # # Set working directory
# # WORKDIR /var/www/html

# # # Restart Apache to apply changes
# # RUN service apache2 restart

# # Copy the Synteny files to the Apache html directory
# # COPY /var/www/bioinformatics/synteny7 /synteny

# # Expose Apache port
# EXPOSE 80

# # Start Apache server
# CMD ["apache2-foreground"]

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

# Expose Apache port
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]