# Usar Node 20 basado en Debian
FROM node:20

# Carpeta de trabajo dentro del contenedor
WORKDIR /app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto del proyecto
COPY . .

# Comando para correr Vite
CMD ["npm", "run", "dev"]

