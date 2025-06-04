# Use the PHP-Apache image
ARG PHP_VERSION="8.2"
FROM php:${PHP_VERSION}-apache

ARG SMTP_USER
ARG SMTP_PASS

# Update system packages
RUN apt-get update && apt-get upgrade -y

# Install necessary dependencies
RUN apt-get install -y --no-install-recommends \
    libpng-dev \
    libjpeg-dev \
    libwebp-dev \
    zlib1g-dev \
    libfreetype6-dev \
    libpq-dev \
    bash \
    openssl \
    ca-certificates \
    openssh-client \
    rsync \
    git \
    jq \
    curl \
    wget \
    gzip \
    zip \
    unzip \
    p7zip-full \
    tar \
    patch \
    perl \
    libpcre3-dev \
    imagemagick \
    libmagickwand-dev \
    build-essential \
    autoconf \
    libtool \
    libpcre3 \
    libjpeg62-turbo-dev \
    libfreetype6 \
    vim-tiny \
    msmtp && ln -s /usr/bin/msmtp /usr/sbin/sendmail

# Install Node.js (LTS) and npm using NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# Configure msmtp with SMTP credentials
RUN echo "defaults" > /etc/msmtprc && \
    echo "auth on" >> /etc/msmtprc && \
    echo "tls on" >> /etc/msmtprc && \
    echo "tls_trust_file /etc/ssl/certs/ca-certificates.crt" >> /etc/msmtprc && \
    echo "logfile /var/log/msmtp.log" >> /etc/msmtprc && \
    echo "account default" >> /etc/msmtprc && \
    echo "host smtp.gmail.com" >> /etc/msmtprc && \
    echo "port 587" >> /etc/msmtprc && \
    echo "from ${SMTP_USER}" >> /etc/msmtprc && \
    echo "user ${SMTP_USER}" >> /etc/msmtprc && \
    echo "password ${SMTP_PASS}" >> /etc/msmtprc && \
    chmod 644 /etc/msmtprc

# Create log file for msmtp
RUN touch /var/log/msmtp.log && chmod 666 /var/log/msmtp.log

# Configure msmtp to send mail to MailHog
# RUN echo "defaults" > /etc/msmtprc && \
#     echo "account default" >> /etc/msmtprc && \
#     echo "host mailhog" >> /etc/msmtprc && \
#     echo "port 1025" >> /etc/msmtprc && \
#     echo "from noreply@example.com" >> /etc/msmtprc && \
#     echo "logfile /var/log/msmtp.log" >> /etc/msmtprc && \
#     chmod 644 /etc/msmtprc

# # Create log file for msmtp
# RUN touch /var/log/msmtp.log && chmod 666 /var/log/msmtp.log

# # Tell PHP to use msmtp for mail
# RUN echo "sendmail_path = /usr/bin/msmtp -t" >> /usr/local/etc/php/conf.d/mail.ini

# Install PHP extensions
RUN docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype && \
    docker-php-ext-install gd pdo pdo_pgsql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Install PHP OPcache
RUN docker-php-ext-install opcache

# Add OPcache configuration
RUN echo "opcache.enable=1" > /usr/local/etc/php/conf.d/opcache.ini && \
    echo "opcache.memory_consumption=128" >> /usr/local/etc/php/conf.d/opcache.ini && \
    echo "opcache.interned_strings_buffer=8" >> /usr/local/etc/php/conf.d/opcache.ini && \
    echo "opcache.max_accelerated_files=4000" >> /usr/local/etc/php/conf.d/opcache.ini && \
    echo "opcache.revalidate_freq=2" >> /usr/local/etc/php/conf.d/opcache.ini && \
    echo "opcache.save_comments=1" >> /usr/local/etc/php/conf.d/opcache.ini 

# Increase PHP memory limit and upload settings
RUN echo "memory_limit=2G" > /usr/local/etc/php/conf.d/memory-limit.ini && \
    echo "upload_max_filesize=2G" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "max_input_time=300" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "max_execution_time=300" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "post_max_size=2G" >> /usr/local/etc/php/conf.d/uploads.ini

# Update DocumentRoot in Apache config
RUN sed -i 's|/var/www/html|/var/www/docroot/web|g' /etc/apache2/apache2.conf && \
    sed -i 's|/var/www/html|/var/www/docroot/web|g' /etc/apache2/sites-enabled/000-default.conf

# Set working directory
WORKDIR /var/www/docroot

# Add ServerName directive
RUN echo "ServerName 13.250.212.83" >> /etc/apache2/apache2.conf

# Copy application code
# This assumes your project root (where docker-compose.yml is) is the context.
# We copy the contents of host's ./docroot/tripal4/ into image's /var/www/docroot/
# This makes /var/www/docroot/ the Drupal root, containing composer.json, web/, etc.
COPY ./docroot/tripal4/ /var/www/docroot/

# Install theme dependencies and build assets
# This path should still be correct as web/ is inside the Drupal root.
WORKDIR /var/www/docroot/web/themes/custom/ww_radix
RUN npm install
RUN npm run dev

# Return to the main application directory
WORKDIR /var/www/docroot

# Set up Drupal settings file and directories if they don't exist
# Path adjusted to web/sites/default
RUN if [ ! -f /var/www/docroot/web/sites/default/settings.php ] && [ -f /var/www/docroot/web/sites/default/default.settings.php ]; then \
      cp /var/www/docroot/web/sites/default/default.settings.php /var/www/docroot/web/sites/default/settings.php; \
    fi
# Ensure correct ownership and permissions for Drupal's sites directory
RUN mkdir -p /var/www/docroot/web/sites/default/files && \
    chown -R www-data:www-data /var/www/docroot/web/sites/default && \
    chmod 644 /var/www/docroot/web/sites/default/settings.php && \
    chmod -R 755 /var/www/docroot/web/sites/default/files

# Ensure private keys are present and set permissions 
# This relies on the volume mount in docker-compose.yml for /var/www/private_keys.
# The keys directory should be created if it doesn't exist to avoid chown errors.
RUN mkdir -p /var/www/private_keys && \
    if [ -f /var/www/private_keys/private.key ]; then \
    chown www-data:www-data /var/www/private_keys/private.key && \
    chmod 400 /var/www/private_keys/private.key; \
    fi

# Enable full PHP error reporting for debugging
RUN echo "error_reporting = E_ALL" > /usr/local/etc/php/conf.d/zzz-php-errors.ini && \
    echo "display_errors = On" >> /usr/local/etc/php/conf.d/zzz-php-errors.ini && \
    echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/zzz-php-errors.ini && \
    echo "log_errors = On" >> /usr/local/etc/php/conf.d/zzz-php-errors.ini && \
    echo "error_log = /dev/stderr" >> /usr/local/etc/php/conf.d/zzz-php-errors.ini

# Expose Apache port
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
