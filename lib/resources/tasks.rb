require_relative '../onfleet'

# Tasks represent units of work, defined by one destination and one recipient,
# that administrators create and assign to workers for completion.
# Task assignment, state and dependencies are important concepts that
# you should understand well prior to using the task endpoints.
class Tasks
  def create(body)
    method = 'post'
    path = 'tasks'

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  # ACTION: still needs to be tested
  def batch_create(body)
    method = 'post'
    path = 'tasks/batch'

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  # ACTION: still needs to be tested
  def batch_create_async(body)
    method = 'post'
    path = 'tasks/batch-async'

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  def list(query_parameters)
    method = 'get'
    path = "tasks/all?#{query_parameters}"

    Onfleet.request(method.to_sym, path)
  end

  def get(id)
    method = 'get'
    path = "tasks/#{id}"

    Onfleet.request(method.to_sym, path)
  end

  def get_by_short_id(short_id)
    method = 'get'
    path = "tasks/shortId/#{short_id}"

    Onfleet.request(method.to_sym, path)
  end

  def update(id, body)
    method = 'put'
    path = "tasks/#{id}"

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  # ACTION: still needs to be tested
  def complete(id, body)
    method = 'post'
    path = "tasks/#{id}/complete"

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  def clone(id, body)
    method = 'post'
    path = "tasks/#{id}/clone"

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  def delete(id)
    method = 'delete'
    path = "tasks/#{id}"

    Onfleet.request(method.to_sym, path)
  end

  # ACTION: still needs to be tested
  def auto_assign(body)
    method = 'post'
    path = 'tasks/autoAssign'

    Onfleet.request(method.to_sym, path, body.to_json)
  end
end
