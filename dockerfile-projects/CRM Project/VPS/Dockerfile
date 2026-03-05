# Dockerfile - SuiteCRM con PHP 8.1-Apache
FROM php:8.1-apache

# Configurar zona horaria de Brasil (Santa Catarina)
RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Instalar dependencias de compilación y utilidades
RUN apt-get update && apt-get install -y --no-install-recommends \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zlib1g-dev \
    libicu-dev \
    unzip \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Instalar extensiones PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) \
    zip \
    mysqli \
    pdo \
    pdo_mysql \
    gd \
    intl \
    mbstring \
    opcache

# Habilitar módulos Apache
RUN a2enmod rewrite && \
    a2enmod headers && \
    a2enmod ssl

# Copiar configuración PHP
COPY php.ini ${PHP_INI_DIR}/conf.d/suitecrm.ini

# Crear estructura de directorios
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Configurar Apache DocumentRoot para SuiteCRM (público debe ser la raíz)
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf && \
    sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/default-ssl.conf

# Configurar permisos y directorios
RUN echo '<Directory /var/www/html>' >> /etc/apache2/apache2.conf && \
    echo '    AllowOverride All' >> /etc/apache2/apache2.conf && \
    echo '    Require all granted' >> /etc/apache2/apache2.conf && \
    echo '</Directory>' >> /etc/apache2/apache2.conf && \
    echo '<Directory /var/www/html/public>' >> /etc/apache2/apache2.conf && \
    echo '    AllowOverride All' >> /etc/apache2/apache2.conf && \
    echo '    Require all granted' >> /etc/apache2/apache2.conf && \
    echo '    RewriteEngine On' >> /etc/apache2/apache2.conf && \
    echo '    RewriteBase /' >> /etc/apache2/apache2.conf && \
    echo '    RewriteCond %{REQUEST_FILENAME} !-f' >> /etc/apache2/apache2.conf && \
    echo '    RewriteCond %{REQUEST_FILENAME} !-d' >> /etc/apache2/apache2.conf && \
    echo '    RewriteRule ^(.*)$ /index.php [QSA,L]' >> /etc/apache2/apache2.conf && \
    echo '</Directory>' >> /etc/apache2/apache2.conf

WORKDIR /var/www/html
EXPOSE 80

CMD ["apache2-foreground"]
