# Onfleet Ruby Wrapper

> *Consulta este documento en otro idioma*:  
> [English](https://github.com/onfleet/ruby-onfleet/blob/master/README.md)  

Los invitamos a visitar nuestra publicación sobre el [proyecto de librerías para la API](https://onfleet.com/blog/api-wrappers-explained/) para conocer más sobre nuestras iniciativas.  
En caso de preguntas, pueden contactarnos a través de un issue [aquí](https://github.com/onfleet/pyonfleet/issues) o escribirnos a support@onfleet.com.

## Tabla de contenidos
- [Onfleet Ruby Wrapper](#onfleet-ruby-wrapper)
  - [Tabla de contenidos](#tabla-de-contenidos)
  - [Sinopsis](#sinopsis)
  - [Instalación](#instalación)
  - [Requirements](#requirements)
  - [Uso](#uso)
    - [Autenticación](#autenticación)
    - [Límites](#límites)
    - [Operaciones CRUD soportadas](#operaciones-crud-soportadas)
    - [Ejemplos de cómo utilizar las operaciones CRUD](#ejemplos-de-cómo-utilizar-las-operaciones-crud)
  - [Errors](#errors)

## Sinopsis
La librería en Ruby de Onfleet nos permite un acceso fácil y cómodo a la API de Onfleet.

## Instalación
```
gem install ruby-onfleet
```

# Requirements
Puede encontrar una lista de las gemas de paquetes necesarias para instalar en el [Gemfile](#https://github.com/onfleet/ruby-onfleet/blob/main/gemfile).

## Uso
Antes de usar la librería, es indispensable obtener una llave para la API a través de alguno de los administradores de la organización a la que pertenecemos.

La creación e integración de llaves se realiza a través del [panel principal de Onfleet](https://onfleet.com/dashboard#/manage).

Para utilizar la librería sólo tenemos que crear uns instancia de `Onfleet` usando la llave:
```
config = Onfleet::Configuration.new("API_KEY")
```

Se pueden incluir dos parámetros opcionales al inicializar el módulo Onfleet - `base_url` y `headers`. 
Si está ejecutando pruebas en el entorno sandbox, lo siguiente `base_url` debe ser definido - "https://staging.onfleet.com/api/v2". De lo contrario, la producción será la predeterminada.

Los encabezados predeterminados requeridos se establecen en la inicialización de su configuración. También recomendamos incluir el siguiente encabezado personalizado para ayudarnos a identificar el tráfico de origen:

```
headers = {
  "X-Onfleet-Organization": "ORGANIZATION_NAME-onfleet"
}

config = Onfleet::Configuration.new("API_KEY", "https://staging.onfleet.com/api/v2", headers)
```

Será necesario pasar una instancia de `Onfleet config` como argumento a cualquier llamada API posterior que contenga sus configuraciones.

### Autenticación
Cada solicitud de API a la plataforma Onfleet se autentica mediante autenticación básica. Al inicializar el objeto `Onfleet`, se ejecutará una prueba para validar sus credenciales de API con el siguiente método:

```
Onfleet.validate_authentication(@base_url, @api_key)
```

Si tiene éxito, esta variable se establecerá con su instancia `Onfleet`:

```
onfleet.auth_validated = true
```

De lo contrario, se generará un error o este valor será igual a `falso` si no se realiza correctamente.

### Límites
La API impone un límite de 20 peticiones por segundo entre todas las peticiones de todas las llaves de la organización. Más detalles [aquí](https://docs.onfleet.com/reference/throttling).

La librería también implementa un limitador para prevenir excesos accidentales de los límites y, eventualmente, posibles sanciones.

### Operaciones CRUD soportadas
Estas son las operaciones disponibles para cada endpoint:

| Entity | GET | POST | PUT | DELETE |
| :-: | :-: | :-: | :-: | :-: |
|[administrators](https://docs.onfleet.com/reference/administrators)|list()|create()|update(id, body={})|delete(id)|
|[containers](https://docs.onfleet.com/reference/containers)|get('workers', id)<br />get('teams', id)<br />get('organizations', id)|x|update_tasks(workerId, body={})|x|
|[destinations](https://docs.onfleet.com/reference/destinations)|get(id)|create(body={})<br />match_metadata(body={})|x|x|
|[hubs](https://docs.onfleet.com/reference/hubs)|list()|create(body={})|update(id, body={})|x|
|[organizations](https://docs.onfleet.com/reference/organizations)|get(delegateeId=nil)|x|insert_task(orgId, body={})|x|
|[recipients](https://docs.onfleet.com/reference/recipients)|get(id)<br />get_by_name(name)<br />get_by_phone(phone)|create(body={})<br />match_metadata(body={})|update(id, body={})|x|
|[tasks](https://docs.onfleet.com/reference/tasks)|get(id)<br />list(queryParameters={})<br />get_by_short_id(shortId)|create(body={})<br />batch_create(body={})<br />batch_create_async(body={})<br />complete(id, body={})<br />clone(id)<br />auto_assign(body={})<br />match_metadata(body={})|update(id, body={})|delete(id)|
|[teams](https://docs.onfleet.com/reference/teams)|get(id)<br />list()<br />driver_time_estimate(workerId, queryParameters={})<br />get_unassigned_tasks(id)|create(body={})<br />auto_dispatch(id, body={})|update(id, body={})<br />insert_task(teamId, body={})|delete(id)|
|[webhooks](https://docs.onfleet.com/reference/webhooks)|list()|create(body={})|X|delete(id)|
|[workers](https://docs.onfleet.com/reference/workers)|get(id=nil, queryParameters={})<br />get_tasks(id)<br />get_by_location(longitude, latitude, radius)<br />get_schedule(id)|create(body={})<br />set_schedule(id, body={})<br />match_metadata(body={})|update(id, body={})<br />insert_task(id, body={})|delete(id)|

### **Peticiones GET**
Para obtener todos los objetos de entidad dentro de un punto final, use `list`:

```
list()
```

Examples of `list()`:

```
tasks = Onfleet::Tasks.new
tasks.list(config)
tasks.list(config, queryParameters{})
```

Opcionalmente, puede enviar un hash de parámetros de consulta para ciertos puntos finales. El hash de Ruby se codificará en parámetros de consulta de URL utilizando la gema `uri`. Referirse de nuevo a [API documentation](https://docs.onfleet.com/) para puntos finales que admiten parámetros de consulta.

```
tasks = Onfleet::Tasks.new
tasks.list(config, queryParameters={'from': '1455072025000', 'state': '1, 2, 3'})
```

Para obtener un objeto de entidad dentro de un punto final, especifique un `entity id`:

```
# obtener ejemplos con la búsqueda de entityId
tasks = Onfleet::Tasks.new
tasks.get(config, 'taskId')

recipients = Onfleet::Recipients.new
recipients.get(config, 'workerId')
```

Junto con la búsqueda de un objeto de entidad con un `id` asociado, los siguientes parámetros de consulta también están disponibles en un grupo selecto de puntos finales:

* `queryParameters` (hash)
* `name`
* `entity`
* `phone`
* `shortId`

```
# obtener ejemplos con argumentos adicionales
workers = Onfleet::Workers.new
workers.get(config, 'workerId', queryParameters={'analytics': 'true'})

containers = Onfleet::Containers.new
containers.get(config, 'workers', 'workerId')
containers.get(config, 'teams', 'teamId')
containers.get(config, 'organizations', 'organizationId')
```

Para obtener un controlador por ubicación, use el método `get_by_location`:
```
workers = Onfleet::Workers.new
worker.get_by_location(config, 'longitude_value', 'latitude_value', 'radius_value')
```
El valor predeterminado del `radius` es 1000 metros si no se proporciona como argumento.

### **Peticiones POST**
Para crear un objeto de entidad dentro de un punto final:
```
.create(config, body={})
```

Ejemplos de `create()`:
```
body = {
  "name": "A Swartz",
  "phone": "617-342-8853",
  "teams": [
    "nz1nG1Hpx9EHjQCJsT2VAs~o"
  ],
  "vehicle": {
    "type": "CAR",
    "description": "Tesla Model 3",
    "licensePlate": "FKNS9A",
    "color": "purple"
  }
}

workers = Onfleet::Workers.new
workers.create(config, body)
```

Las solicitudes POST extendidas incluyen clon, batch_create, auto_assign en el punto final de las tareas; set_schedule en el punto final de los trabajadores; y auto_dispatch en el punto final de los equipos. A continuación, se muestran ejemplos de estos puntos finales:

```
tasks = Onfleet::Tasks.new
tasks.clone(config, 'id')
tasks.batch_create(config, body)
tasks.auto_assign(config, body)

workers = Onfleet::Workers.new
workers.set_schedule(config, 'id', body)

teams = Onfleet::Teams.new
teams.auto_dispatch(config, 'id', body)
```

Para más detalles, consulte nuestra documentación en [clone](https://docs.onfleet.com/reference#clone-task), [batch_create](https://docs.onfleet.com/reference#create-tasks-in-batch), [auto_assign](https://docs.onfleet.com/reference#automatically-assign-list-of-tasks), [set_schedule](https://docs.onfleet.com/reference#set-workers-schedule), y [auto_dispatch](https://docs.onfleet.com/reference#team-auto-dispatch).

### **Peticiones PUT**
Para actualizar un objeto de entidad dentro de un punto final:
```
.update(config, entityId, 'body')
```
Ejemplos de `update()`:
```
body = {
  "name": "Laura P",
  "teams": [
    "lHCUJFvh6v0YDURKjokZbvau"
  ]
}

workers = Onfleet::Workers.new
workers.update(config, 'workerId', body)
```

Ejemplos de `insert_task()`:
```
workers = Onfleet::Workers.new
workers.insert_task(config, 'taskId', body)
```

### **Peticiones DELETE**
Para eliminar un objeto de entidad dentro de un punto final:
```
.delete(config, id)
```

Ejemplos de `delete()`:
```
workers = Onfleet::Workers.new
workers.delete(config, id)
```

## Errors
Se pueden producir los siguientes tipos de errores:
1. errores HTTP
2. errores de permisos
3. errores de límite de velocidad
4. errores de servicio
5. errores de validación

Actualmente, solo las clases `PermissionError`, `HttpError` y `ServiceError` están en uso según `status` de la API devuelto por la API de Onfleet. Este paquete maneja los errores de API devueltos en el método `handle_api_error` en el archivo `utils.rb`.

*Ir al [inicio](#onfleet-ruby-wrapper)*.