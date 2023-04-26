require_relative '../onfleet'

# Workers (also known as drivers in the dashboard) are the members of an organization 
# who perform actions via the Onfleet mobile applications.
class Workers
  def create(body)
    method = 'post'
    path = 'workers'

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  def get(id = nil, query_parameters = nil)
    method = 'get'

    # NOTE: parameters included here must be in the format of the URL query parameters for a raw API call
    if id
      path = "workers/#{id}?#{query_parameters}"
    else
      path = "workers?#{query_parameters}"
    end

    Onfleet.request(method.to_sym, path)
  end

  def update(id, body)
    method = 'put'
    path = "workers/#{id}"

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  def delete(id)
    method = 'delete'
    path = "workers/#{id}"

    Onfleet.request(method.to_sym, path)
  end

  def get_tasks(id)
    method = 'get'
    path = "workers/#{id}/tasks"

    Onfleet.request(method.to_sym, path)
  end

  # ACTION: still needs to be tested
  def get_by_location(longitude, latitude, radius = nil)
    method = 'get'
    path = "workers/location?longitude=#{longitude}&latitude=#{latitude}&radius=#{radius}"

    Onfleet.request(method.to_sym, path)
  end

  def get_worker_schedule(id)
    method = 'get'
    path = "workers/#{id}/schedule"

    Onfleet.request(method.to_sym, path)
  end

  def create_worker_schedule(id, body)
    method = 'post'
    path = "workers/#{id}/schedule"

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  # ACTION: still needs to be tested
  def insert_task(worker_id, body)
    method = 'put'
    path = "containers/workers/#{worker_id}"

    Onfleet.request(method.to_sym, path, body.to_json)
  end
end
