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
    # algunas máquinas (especialmente con GCC 14 en Debian) fallan
    # durante compilaciones paralelas de extensiones; usar un solo hilo
    # evita errores internos del compilador.
    docker-php-ext-install -j1 \
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

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    chmod +x /usr/local/bin/composer && \
    # Temporalmente habilitar allow_url_fopen para Composer
    echo 'allow_url_fopen = On' > ${PHP_INI_DIR}/conf.d/01-composer.ini

# Copiar configuración PHP
COPY php.ini ${PHP_INI_DIR}/conf.d/suitecrm.ini

# Crear estructura de directorios
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Configurar Apache DocumentRoot para SuiteCRM (público debe ser la raíz)
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf && \
    sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/default-ssl.conf

# Configurar Apache para usar www-data y no root
RUN sed -i 's/^User .*/User www-data/' /etc/apache2/apache2.conf && \
    sed -i 's/^Group .*/Group www-data/' /etc/apache2/apache2.conf

# Configurar PHP para mayor seguridad (allow_url_fopen necesario para Composer)
RUN echo 'disable_functions = exec,passthru,shell_exec,system,proc_open,popen,curl_exec,curl_multi_exec,parse_ini_file,show_source' >> ${PHP_INI_DIR}/conf.d/security.ini && \
    echo 'expose_php = Off' >> ${PHP_INI_DIR}/conf.d/security.ini && \
    echo 'allow_url_fopen = On' >> ${PHP_INI_DIR}/conf.d/security.ini && \
    echo 'allow_url_include = Off' >> ${PHP_INI_DIR}/conf.d/security.ini

WORKDIR /var/www/html
EXPOSE 80

CMD ["apache2-foreground"]
