# ruby-onfleet

> *Consulta este documento en otro idioma*:  
> [Español](https://github.com/onfleet/ruby-onfleet/blob/main/README.es.md)  

Visit our blog post on the [API wrapper project](https://onfleet.com/blog/api-wrappers-explained/) to learn more about our initiatives. If you have any questions, please reach us by submitting an issue [here](https://github.com/onfleet/ruby-onfleet/issues) or contact support@onfleet.com.

## Table of Contents

* [Table of contents](#table-of-contents)
* [Synopsis](#synopsis)
* [Installation](#installation)
* [Requirements](#requirements)
* [Usage](#usage)
  * [Authentication](#authentication)
  * [Throttling](#throttling)
  * [Supported CRUD operations](#supported-crud-operations)
* [Errors](#errors)

## Synopsis
The Onfleet Ruby library provides convenient access to the Onfleet API.

## Installation
```
gem install ruby-onfleet
```

## Requirements
A list of the required package gems to install can be found in the [Gemfile](#https://github.com/onfleet/ruby-onfleet/blob/main/gemfile).

## Usage
Before using the API wrapper, you will need to obtain an API key from one of your organization's admins.

Creation and integration of API keys are performed through the [Onfleet dashboard](https://onfleet.com/dashboard#/manage).

To start utilizing the library, you simply need to create an `Onfleet` object and set your `Configuration` with your API key:
```
config = Onfleet::Configuration.new("API_KEY")
```

Two optional parameters can be included when initializing the Onfleet module - `base_url` and `headers`. 
If you are running testing in the sandbox environment, the following `base_url` should be defined - "https://staging.onfleet.com/api/v2". Otherwise, production will be the default.

The required default headers are set on your configuration initialization. We also recommend including the following custom header to help us identify source traffic:

```
headers = {
  "X-Onfleet-Organization": "ORGANIZATION_NAME-onfleet"
}

config = Onfleet::Configuration.new("API_KEY", "https://staging.onfleet.com/api/v2", headers)
```

An `Onfleet config` instance will need to be passed as an argument to any subsequent API calls that will contain your configurations.

## Authentication
Every API request to the Onfleet platform is authenticated using Basic Auth. On initialization of the `Onfleet` object, a test will be run to validate your API credentials from the following method:

```
Onfleet.validate_authentication(@base_url, @api_key)
```

If successful, this variable will be set with your `Onfleet` instance:

```
onfleet.auth_validated = true
```

Otherwise, an error will be raised or this value would equal `false` if unsuccessful.

## Throttling
Rate limiting is enforced by the API with a threshold of 20 requests per second across all your organization's API keys. Learn more about it [here](https://docs.onfleet.com/reference#throttling).

We have also implemented a limiter on this library to avoid you from unintentionally exceeding your rate limitations and eventually be banned for.

## Supported CRUD Operations
Here are the operations available for each entity:

| Entity | GET | POST | PUT | DELETE |
| :-: | :-: | :-: | :-: | :-: |
|[administrators](https://docs.onfleet.com/reference/administrators)|list()|create()|update(id, body={})|delete(id)|
|[containers](https://docs.onfleet.com/reference/containers)|get('workers', id)<br />get('teams', id)<br />get('organizations', id)|x|update_tasks(workerId, body={})|x|
|[destinations](https://docs.onfleet.com/reference/destinations)|get(id)|create(body={})<br />match_metadata(body={})|x|x|
|[hubs](https://docs.onfleet.com/reference/hubs)|list()|create(body={})|update(id, body={})|x|
|[organizations](https://docs.onfleet.com/reference/organizations)|get(delegateeId=nil)|x|insert_task(orgId, body={})|x|
|[recipients](https://docs.onfleet.com/reference/recipients)|get(id)<br />get_by_name(name)<br />get_by_phone(phone)|create(body={})<br />match_metadata(body={})|update(id, body={})|x|
|[routeplans](https://docs.onfleet.com/reference/routeplan#/) | get(id)<br />get(body={}) | create(body={}) | update(id, body={})<br />add_tasks_to_routeplan(id, body={}) | delete_one(id) |
|[tasks](https://docs.onfleet.com/reference/tasks)|get(id)<br />list(queryParameters={})<br />get_by_short_id(shortId)|create(body={})<br />batch_create(body={})<br />batch_create_async(body={})<br />complete(id, body={})<br />clone(id)<br />auto_assign(body={})<br />match_metadata(body={})|update(id, body={})|delete(id)|
|[teams](https://docs.onfleet.com/reference/teams)|get(id)<br />list()<br />driver_time_estimate(workerId, queryParameters={})<br />get_unassigned_tasks(id)|create(body={})<br />auto_dispatch(id, body={})|update(id, body={})<br />insert_task(teamId, body={})|delete(id)|
|[webhooks](https://docs.onfleet.com/reference/webhooks)|list()|create(body={})|X|delete(id)|
|[workers](https://docs.onfleet.com/reference/workers)|get(id=nil, queryParameters={})<br />get_tasks(id)<br />get_by_location(longitude, latitude, radius)<br />get_schedule(id)|create(body={})<br />set_schedule(id, body={})<br />match_metadata(body={})<br />get_delivery_manifest(body={}, googleApiKey, queryParameters={})|update(id, body={})<br />insert_task(id, body={})|delete(id)|

### **GET Requests**
To get all the entity objects within an endpoint use `list`:

```
list()
```

Examples of `list()`:

```
tasks = Onfleet::Tasks.new
tasks.list(config)
tasks.list(config, queryParameters{})
```

Optionally you can send a hash of query parameters for certain endpoints. The Ruby hash will be encoded to url query parameters using the `uri` gem. Refer back to [API documentation](https://docs.onfleet.com/) for endpoints that support query parameters.

```
tasks = Onfleet::Tasks.new
tasks.list(config, queryParameters={'from': '1455072025000', 'state': '1, 2, 3'})
```

To get one entity object within an endpoint, specify the an `entity id`:

```
# get examples with entityId lookup
tasks = Onfleet::Tasks.new
tasks.get(config, 'taskId')

recipients = Onfleet::Recipients.new
recipients.get(config, 'workerId')
```

Along with searching for an entity object with an associated `id`, the following query parameters are also available across a select group of endpoints:

* `queryParameters` (hash)
* `name`
* `entity`
* `phone`
* `shortId`

```
# get examples with additional arguments
workers = Onfleet::Workers.new
workers.get(config, 'workerId', queryParameters={'analytics': 'true'})

containers = Onfleet::Containers.new
containers.get(config, 'workers', 'workerId')
containers.get(config, 'teams', 'teamId')
containers.get(config, 'organizations', 'organizationId')
```

To get a driver by location, use the `get_by_location` method:
```
workers = Onfleet::Workers.new
worker.get_by_location(config, 'longitude_value', 'latitude_value', 'radius_value')
```
The `radius` value defaults to 1000 meters if not provided as an argument.

### **POST Requests**
To create an entity object within an endpoint:
```
.create(config, body={})
```

Examples of `create()`:
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

Examples of `get_delivery_manifest()`:
```
body = {
  "path": "providers/manifest/generate?hubId=<workerId>&workerId=<workerId>",
  "method": "GET"
}

workers = Onfleet::Workers.new
workers.create(config, body, 'google_api_key', queryParameters={'startDate': '1455072025000', 'endDate': '1455072025000'})
```

Extended POST requests include clone, batch_create, auto_assign on the tasks endpoint; set_schedule on the workers endpoint; and auto_dispatch on the teams endpoint. Examples of these endpoints are below:

```
tasks = Onfleet::Tasks.new
tasks.clone(config, 'id')
tasks.batch_create(config, body)
tasks.auto_assign(config, body)

workers = Onfleet::Workers.new
workers.set_schedule(config, 'id', body)
workers.get_delivery_manfiest(config, body, 'google_api_key', queryParameters={})

teams = Onfleet::Teams.new
teams.auto_dispatch(config, 'id', body)
```

For more details, check our documentation on [clone](https://docs.onfleet.com/reference#clone-task), [batch_create](https://docs.onfleet.com/reference#create-tasks-in-batch), [auto_assign](https://docs.onfleet.com/reference#automatically-assign-list-of-tasks), [set_schedule](https://docs.onfleet.com/reference#set-workers-schedule), [get_delivery_manifest](https://docs.onfleet.com/reference/delivery-manifest) and [auto_dispatch](https://docs.onfleet.com/reference#team-auto-dispatch).

### **PUT Requests**
To update an entity object within an endpoint:
```
.update(config, entityId, 'body')
```
Examples of `update()`:
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

Examples of `insert_task()`:
```
workers = Onfleet::Workers.new
workers.insert_task(config, 'taskId', body)
```

### **DELETE Requests**
To delete an entity object within an endpoint:
```
.delete(config, id)
```

Examples of `delete()`:
```
workers = Onfleet::Workers.new
workers.delete(config, id)
```

## Errors
The following types of errors can be thrown:
1. HTTP errors
2. permission errors
3. rate limit errors
4. service errors
5. validation errors

Currently only the `PermissionError`, `HttpError`, and `ServiceError` classes are in use depending on the API `status` returned from the Onfleet API. This package handles the API errors returned in the `handle_api_error` method in the `utils.rb` file.

Go to [_top_](#ruby-onfleet).