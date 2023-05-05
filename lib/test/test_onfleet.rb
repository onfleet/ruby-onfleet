require 'rspec'
require 'webmock/rspec'
require 'json'

# resources and data required for testing
require_relative '../onfleet'
require_relative '../resources/administrators'
require_relative '../resources/containers'
require_relative '../resources/destinations'
require_relative '../resources/hubs'
require_relative '../resources/organizations'
require_relative '../resources/recipients'
require_relative '../resources/tasks'
require_relative '../resources/teams'
require_relative '../resources/webhooks'
require_relative '../resources/workers'

# RSpec configuration setup for unit tests
RSpec.configure do |config|
  file = File.read('./test_data.json')
  config.add_setting :test_data
  config.test_data = JSON.parse(file)

  config.add_setting :api_variables
  config.api_variables = Configuration.new("API_KEY","BASE_URL")
end

# Administrator entity tests
describe Administrators do
  it 'can create an administrator by calling POST /admins endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['administrators']['create']['request']
    path = 'admins'
    method = 'post'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['administrators']['create']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], body: request_data.to_json, headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    administrator = Administrators.new
    response = administrator.create(config, request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('timeCreated')
  end

  it 'can get a list of administrators by calling GET /admins endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    path = 'admins'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['administrators']['list']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    administrator = Administrators.new
    response = administrator.list(config)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
  end

  it 'can update an administrator by calling PUT /admins endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['administrators']['update']['request']
    path = 'admins'
    method = 'put'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['administrators']['update']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], body: request_data.to_json, headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    administrator = Administrators.new
    response = administrator.update(config, request_data['id'], request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('timeLastModified')
  end

  it 'can delete an administrator by calling DELETE /admins endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['administrators']['delete']['request']
    path = 'admins'
    method = 'delete'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200)

    administrator = Administrators.new
    response = administrator.delete(config, request_data['id'])

    expect(response.status).to eq 200
  end
end

# Entity(organizations, teams or workers) container tests
describe Containers do
  it 'can get an entities container by calling get /containers endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['containers']['get']['request']
    path = "containers/#{request_data['entity']}"
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['containers']['get']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    container = Containers.new
    response = container.get(config, request_data['entity'], request_data['id'])

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('type')
  end
end

# Destination entity tests
describe Destinations do
  it 'can create a destinations by calling POST /destinations endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['destinations']['create']['request']
    path = 'destinations'
    method = 'post'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['destinations']['create']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    destination = Destinations.new
    response = destination.create(config, request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('address')
  end

  it 'can get a destination by calling GET /destinations endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['destinations']['get']['request']
    path = 'destinations'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['destinations']['get']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    destination = Destinations.new
    response = destination.get(config, request_data['id'])

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('address')
  end

  it 'can match a destination by calling POST /destinations/metadata endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['destinations']['match_metadata']['request']
    path = 'destinations/metadata'
    method = 'post'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['destinations']['match_metadata']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], body: request_data, headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    destination = Destinations.new
    response = destination.match_metadata(config, request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('hasDog')
  end
end

# Hub entity tests
describe Hubs do
  it 'can create a hub by calling POST /hubs endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['hubs']['create']['request']
    path = 'hubs'
    method = 'post'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['hubs']['create']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], body: request_data, headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    hub = Hubs.new
    response = hub.create(config, request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('address')
  end

  it 'can list hubs by calling GET /hubs endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    path = 'hubs'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['hubs']['list']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    hub = Hubs.new
    response = hub.list(config)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('address')
  end

  it 'can update a hub by calling PUT /hubs endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['hubs']['update']['request']
    path = 'hubs'
    method = 'put'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['hubs']['update']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], body: request_data, headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    hub = Hubs.new
    response = hub.update(config, request_data['id'], request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('address')
  end
end

# Organization entity tests
describe Organizations do
  it 'can get an organization by calling GET /organizations endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['organizations']['get']['request']
    path = 'organizations'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['organizations']['get']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    organization = Organizations.new
    response = organization.get(config, request_data['id'])

    expect(response.status).to eq 200
    expect(response.body).to include('id')
  end
end

# Recipients entity tests
describe Recipients do
  it 'can create a recipient by calling POST /recipients endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['recipients']['create']['request']
    path = 'recipients'
    method = 'post'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['recipients']['create']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], body: request_data, headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    recipient = Recipients.new
    response = recipient.create(config, request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('timeCreated')
  end

  it 'can update a recipient by calling PUT /recipients endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['recipients']['update']['request']
    path = 'recipients'
    method = 'put'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['recipients']['update']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], body: request_data, headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    recipient = Recipients.new
    response = recipient.update(config, request_data['id'], request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('timeLastModified')
  end

  it 'can get a recipient by calling GET /recipients endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['recipients']['get']['request']
    path = 'recipients'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['recipients']['get']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    recipient = Recipients.new
    response = recipient.get(config, request_data['id'])

    expect(response.status).to eq 200
    expect(response.body).to include('id')
  end

  it 'can get a recipient by name calling GET /recipients/name endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['recipients']['get_by_name']['request']
    path = 'recipients/name'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['recipients']['get_by_name']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['name']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    recipient = Recipients.new
    response = recipient.get_by_name(config, request_data['name'])

    expect(response.status).to eq 200
    expect(response.body).to include('id')
  end

  it 'can get a recipient by phone calling GET /recipients/phone endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['recipients']['get_by_phone']['request']
    path = 'recipients/phone'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['recipients']['get_by_phone']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['phone']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    recipient = Recipients.new
    response = recipient.get_by_phone(config, request_data['phone'])

    expect(response.status).to eq 200
    expect(response.body).to include('id')
  end
end

# Tasks entity tests
describe Tasks do
  it 'can create a task by calling POST /tasks endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['tasks']['create']['request']
    path = 'tasks'
    method = 'post'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['tasks']['create']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], body: request_data, headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    task = Tasks.new
    response = task.create(config, request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('shortId')
  end

  it 'can list tasks by calling GET /tasks endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['tasks']['list']['request']
    path = 'tasks'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['tasks']['list']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/all?#{request_data['from']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    task = Tasks.new
    response = task.list(config, request_data['from'])

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('tasks')
  end

  it 'can get a task by calling GET /tasks endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['tasks']['get']['request']
    path = 'tasks'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['tasks']['get']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    task = Tasks.new
    response = task.get(config, request_data['id'])

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('shortId')
  end

  it 'can get a task by short_id when calling GET /tasks/shortId endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['tasks']['get_by_short_id']['request']
    path = 'tasks/shortId'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['tasks']['get_by_short_id']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['shortId']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    task = Tasks.new
    response = task.get_by_short_id(config, request_data['shortId'])

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('shortId')
  end

  it 'can get clone a task when calling post /tasks/taskId/clone endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['tasks']['clone']['request']
    path = "tasks/#{request_data['id']}/clone"
    method = 'post'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['tasks']['clone']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    task = Tasks.new
    response = task.clone(config, request_data['id'])

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('timeCreated')
  end

  it 'can delete a task when calling DELETE /tasks endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['tasks']['delete']['request']
    path = 'tasks'
    method = 'delete'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['tasks']['delete']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    task = Tasks.new
    response = task.delete(config, request_data['id'])

    expect(response.status).to eq 200
  end
end

# Teams entity tests
describe Teams do
  it 'can create a team by calling POST /teams endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['teams']['create']['request']
    path = 'teams'
    method = 'post'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['teams']['create']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], body: request_data, headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    team = Teams.new
    response = team.create(config, request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('managers')
  end

  it 'can list teams by calling GET /teams endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    path = 'teams'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['teams']['list']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    team = Teams.new
    response = team.list(config)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('managers')
  end

  it 'can get a team by calling GET /teams endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['teams']['get']['request']
    path = 'teams'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['teams']['get']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    team = Teams.new
    response = team.get(config, request_data['id'])

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('managers')
  end

  it 'can delete a team when calling DELETE /teams endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['teams']['delete']['request']
    path = 'teams'
    method = 'delete'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['teams']['delete']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    team = Teams.new
    response = team.delete(config, request_data['id'])

    expect(response.status).to eq 200
  end
end

# Webhook tests
describe Webhooks do
  it 'can create a webhook by calling POST /webhooks endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['webhooks']['create']['request']
    path = 'webhooks'
    method = 'post'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['webhooks']['create']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], body: request_data, headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    webhook = Webhooks.new
    response = webhook.create(config, request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('url')
  end

  it 'can list webhooks by calling GET /webhooks endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    path = 'webhooks'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['webhooks']['list']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    webhook = Webhooks.new
    response = webhook.list(config)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('url')
  end

  it 'can delete a webhook when calling DELETE /webhooks endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['webhooks']['delete']['request']
    path = 'webhooks'
    method = 'delete'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['webhooks']['delete']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    webhook = Webhooks.new
    response = webhook.delete(config, request_data['id'])

    expect(response.status).to eq 200
  end
end

# Workers entity tests
describe Workers do
  it 'can create a worker by calling POST /workers endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['workers']['create']['request']
    path = 'workers'
    method = 'post'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['workers']['create']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], body: request_data, headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    worker = Workers.new
    response = worker.create(config, request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('timeCreated')
  end

  it 'can get a worker by calling GET /workers endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['workers']['get']['request']
    path = 'workers'
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['workers']['get']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    worker = Workers.new
    response = worker.get(config, request_data['id'])

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('onDuty')
  end

  it 'can update a worker by calling PUT /workers endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['workers']['update']['request']
    path = 'workers'
    method = 'put'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['workers']['update']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], body: request_data, headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    worker = Workers.new
    response = worker.update(config, request_data['id'], request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('id')
    expect(response.body).to include('timeLastModified')
  end

  it 'can delete a worker when calling DELETE /workers endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['workers']['delete']['request']
    path = 'workers'
    method = 'delete'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['workers']['delete']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}/#{request_data['id']}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    worker = Workers.new
    response = worker.delete(config, request_data['id'])

    expect(response.status).to eq 200
  end

  it 'can get a worker\'s tasks by calling GET /workers/workerId/tasks endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['workers']['get_tasks']['request']
    path = "workers/#{request_data['id']}/tasks"
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['workers']['get_tasks']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    worker = Workers.new
    response = worker.get_tasks(config, request_data['id'])

    expect(response.status).to eq 200
    expect(response.body).to include('tasks')
  end

  it 'can get a worker\'s schedule by calling GET /workers/workerId/schedule endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['workers']['get_worker_schedule']['request']
    path = "workers/#{request_data['id']}/schedule"
    method = 'get'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['workers']['get_worker_schedule']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    worker = Workers.new
    response = worker.get_worker_schedule(config, request_data['id'])

    expect(response.status).to eq 200
    expect(response.body).to include('entries')
  end

  it 'can set a worker\'s schedule by calling POST /workers/workerId/schedule endpoint' do
    # request data
    config = RSpec.configuration.api_variables
    request_data = RSpec.configuration.test_data['workers']['set_worker_schedule']['request']
    path = "workers/#{request_data['id']}/schedule"
    method = 'post'
    headers = {}
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = '@onfleet/ruby-onfleet-1.0'

    # response data
    response_data = RSpec.configuration.test_data['workers']['set_worker_schedule']['response']

    stub_request(method.to_sym, "#{config.base_url}/#{path}")
      .with(basic_auth: [config.api_key, config.api_key], body: request_data, headers: headers)
      .to_return(status: 200, body: response_data.to_json)

    worker = Workers.new
    response = worker.set_worker_schedule(config, request_data['id'], request_data)

    expect(response.status).to eq 200
    expect(response.body).to include('entries')
  end
end
