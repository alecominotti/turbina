# Turbo Rails

Aplicación de ejemplo para aprender Turbo Rails utilizando `Turbo Frames` y `Turbo Streams`.

Es una versión simplificada de la app que se construye en el [tutorial oficial de Turbo en Rails](https://www.hotrails.dev/turbo-rails).

#### Instalación:

- `git clone https://github.com/alecominotti/turbina.git`
- `cd turbina`
- `bundle install`
- `docker run --rm --detach --name postgres --env POSTGRES_PASSWORD=root --publish 5432:5432 -v pgdata:/var/lib/postgresql/data postgres:13.3`
- `rails db:create db:migrate`
- `bin/dev`

### Actualizaciones en tiempo real:

En la rama `real-time` se utilizan actualizaciones asincrónicas en tiempo real usando `Turbo` + `Action Cable`.

#### Instalación:

- [Instalar Redis desde el sitio oficial](https://redis.io/docs/getting-started/installation/)
- `git checkout real-time`
- `bundle install`
- `bin/dev`