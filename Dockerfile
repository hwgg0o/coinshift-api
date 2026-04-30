# Usamos una versión ligera de PHP con Apache optimizada para ARM64 (M1)
FROM php:8.4-apache

# Instalamos extensiones de PHP necesarias para Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Limpiamos caché para mantener la imagen ligera
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalamos extensiones de PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Habilitamos el módulo de reescritura de Apache para Laravel
RUN a2enmod rewrite

# Definimos el directorio de trabajo
WORKDIR /var/www/html

# Copiamos los archivos del proyecto al contenedor
COPY . .

# Ajustamos permisos para storage, cache y específicamente para la DB SQLite
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database

# Opcional: Asegurar que el archivo de base de datos exista y tenga permisos
RUN touch /var/www/html/database/database.sqlite && chown www-data:www-data /var/www/html/database/database.sqlite

# Cambiamos el DocumentRoot de Apache a la carpeta /public de Laravel
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Exponemos el puerto 80
EXPOSE 80