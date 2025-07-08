# Usa una imagen base oficial de Node.js. Elegimos la versión LTS para estabilidad.
FROM node:18-alpine AS development

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /usr/src/app

# Copia los archivos de definición de paquetes para instalar dependencias
# Esto aprovecha el cache de Docker. Si package.json/package-lock.json no cambian, Docker no reinstala.
# Esto copiará tanto package.json como package-lock.json
COPY package*.json ./
# QUITAMOS: COPY yarn.lock ./  <-- Esta línea ya no va

# Instala las dependencias de la aplicación usando npm
RUN npm install

# Copia el resto del código fuente al directorio de trabajo
COPY . .

# Expone el puerto en el que la aplicación NestJS va a escuchar.
# Por defecto, NestJS corre en el puerto 3000.
EXPOSE 3000

# Comando para iniciar la aplicación en modo desarrollo.
# 'yarn start:dev' normalmente habilita hot-reloading y watchers, ideal para desarrollo.
CMD ["yarn", "start:dev"]