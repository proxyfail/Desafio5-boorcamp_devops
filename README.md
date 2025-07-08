# Desafío DevOps: NestJS con Docker y Docker Compose

Este repositorio contiene la solución al desafío de levantar un entorno de desarrollo local para una aplicación NestJS junto con una base de datos MongoDB utilizando Docker y Docker Compose.

---

## 🚀 Inicio Rápido

Sigue estos pasos para levantar el entorno de desarrollo en tu máquina local:

1.  **Clonar el Repositorio:**
    Asegúrate de haber hecho un `fork` de este repositorio a tu cuenta de GitHub y luego clónalo localmente:

    ```bash
    git clone https://[https://github.com/TU_USUARIO/app-template-nestjs.git](https://github.com/TU_USUARIO/app-template-nestjs.git) # Asegúrate de usar la URL de tu fork
    cd app-template-nestjs
    ```

2.  **Construir y Levantar los Contenedores:**
    Desde la raíz del proyecto (donde se encuentran `Dockerfile` y `docker-compose.yaml`), ejecuta el siguiente comando:

    ```bash
    docker-compose up --build -d
    ```
    * `--build`: Fuerza la reconstrucción de la imagen de la aplicación, útil si hiciste cambios en el `Dockerfile` o en las dependencias.
    * `-d`: Ejecuta los contenedores en modo "detached" (segundo plano), liberando tu terminal.

3.  **Verificar el Estado de los Contenedores:**
    Puedes verificar que los contenedores estén corriendo con:

    ```bash
    docker-compose ps
    ```
    Deberías ver `app` y `mongodb` en estado `Up`.

4.  **Acceder a la Aplicación:**
    La aplicación NestJS debería estar accesible en tu navegador o a través de herramientas como Postman en:

    [http://localhost:3000](http://localhost:3000)

    Por ejemplo, puedes probar el endpoint `/` o `/users` si existen en la aplicación base.

5.  **Detener los Contenedores:**
    Cuando hayas terminado de trabajar, puedes detener los contenedores con:

    ```bash
    docker-compose down
    ```
    Esto detendrá y eliminará los contenedores, pero **mantendrá el volumen de datos de MongoDB**, así tus datos persisten.

---

## 🛠️ Estructura del Proyecto

* **`Dockerfile`**: Contiene las instrucciones para construir la imagen Docker de la aplicación NestJS.
* **`docker-compose.yaml`**: Define los servicios (`app` y `mongodb`), sus configuraciones, la red y la persistencia de datos para levantar el entorno local.
* **`src/`**, **`package.json`**, etc.: Los archivos originales de la aplicación NestJS.

---

## 💡 Consideraciones de Diseño y Buenas Prácticas

* **Imágenes Ligeras**: Se utiliza `node:18-alpine` como imagen base en el `Dockerfile` para reducir el tamaño de la imagen final y el tiempo de descarga.
* **Cache de Docker**: Las instrucciones de `COPY` de `package.json` y `yarn.lock` se realizan antes de `yarn install` para aprovechar el cache de Docker y acelerar las reconstrucciones si las dependencias no cambian.
* **Persistencia de Datos**: Se utiliza un volumen nombrado (`mongodb_data`) en `docker-compose.yaml` para asegurar que los datos de MongoDB no se pierdan cuando los contenedores se detienen o se eliminan.
* **Desarrollo Local con Volumenes**: El código fuente local se monta en el contenedor (`.:/usr/src/app`) para permitir el desarrollo en tiempo real sin necesidad de reconstruir la imagen constantemente. Se excluyen los `node_modules` para evitar conflictos entre los del host y los del contenedor.
* **Variables de Entorno**: La conexión a la base de datos se maneja a través de variables de entorno (`MONGODB_URI`), lo que es una buena práctica para la configurabilidad.
* **Redes Internas de Docker Compose**: Los servicios (`app` y `mongodb`) se comunican entre sí utilizando los nombres de los servicios como hostnames, lo que simplifica la configuración de red.

---

## 📊 Diagrama de Alto Nivel

```mermaid
graph TD
    A[Desarrollador] --> B(Terminal)
    B -- docker-compose up --> C(Docker Engine)

    subgraph Docker Engine
        D[Contenedor App NestJS]
        E[Contenedor MongoDB]
        F[Volumen mongodb_data]
    end

    C -- Crea y Ejecuta --> D
    C -- Crea y Ejecuta --> E
    D -- Conecta a --> E
    E -- Persiste Datos en --> F

    D -- Expone Puerto 3000 --> G[Host Local]
    G -- Acceso a App NestJS --> H[Navegador/Postman en localhost:3000]

    E -- Expone Puerto 27017 --> I[Host Local]
    I -- Acceso a MongoDB --> J[Mongo Compass/Robo 3T en localhost:27017]
=======
# Desafio5-boorcamp_devops
>>>>>>> 1cacc3ef5cea6295d6edd4cdab1e6fb7e2112a08
