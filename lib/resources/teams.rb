require_relative '../onfleet'

# Teams are named entities that bring together administrators and workers belonging to the same organization.
# Teams have hubs from where its workers may start and end their shifts.
class Teams
  def create(body)
    method = 'post'
    path = 'teams'

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  def list
    method = 'get'
    path = 'teams'

    Onfleet.request(method.to_sym, path)
  end

  def get(id)
    method = 'get'
    path = "teams/#{id}"

    Onfleet.request(method.to_sym, path)
  end

  def delete(id)
    method = 'delete'
    path = "teams/#{id}"

    Onfleet.request(method.to_sym, path)
  end

  # ACTION: still needs to be tested
  def auto_dispatch(id, body)
    method = 'post'
    path = "teams/#{id}/dispatch"
    headers = {
      'content-type': 'application/json'
    }

    Onfleet.request(method.to_sym, path, body.to_json, headers.to_json)
  end

  # ACTION: still needs to be tested
  def driver_time_estimate(id, query_parameters)
    method = 'get'

    # NOTE: parameters included here must be in the format of the URL query parameters for a raw API call
    path = "teams/#{id}/estimate?#{query_parameters}"

    Onfleet.request(method.to_sym, path)
  end

  # ACTION: still needs to be tested
  def get_unassigned_tasks(id)
    method = 'get'
    path = "teams/#{id}/tasks"

    Onfleet.request(method.to_sym, path)
  end

  # ACTION: still needs to be tested
  def insert_task(team_id, body)
    method = 'put'
    path = "containers/teams/#{team_id}"

    Onfleet.request(method.to_sym, path, body.to_json)
  end
end
