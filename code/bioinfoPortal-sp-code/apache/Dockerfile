# Use the PHP-Apache image
ARG PHP_VERSION="8.1"
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

# Expose Apache port
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]