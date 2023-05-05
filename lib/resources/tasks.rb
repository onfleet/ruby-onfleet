require_relative '../onfleet'

# Tasks represent units of work, defined by one destination and one recipient,
# that administrators create and assign to workers for completion.
# Task assignment, state and dependencies are important concepts that
# you should understand well prior to using the task endpoints.
class Tasks
  def create(config, body)
    method = 'post'
    path = 'tasks'

    Onfleet.request(config, method.to_sym, path, body.to_json)
  end

  # ACTION: still needs to be tested
  def batch_create(config, body)
    method = 'post'
    path = 'tasks/batch'

    Onfleet.request(config, method.to_sym, path, body.to_json)
  end

  # ACTION: still needs to be tested
  def batch_create_async(config, body)
    method = 'post'
    path = 'tasks/batch-async'

    Onfleet.request(config, method.to_sym, path, body.to_json)
  end

  def list(config, query_parameters)
    method = 'get'
    path = "tasks/all?#{query_parameters}"

    Onfleet.request(config, method.to_sym, path)
  end

  def get(config, id)
    method = 'get'
    path = "tasks/#{id}"

    Onfleet.request(config, method.to_sym, path)
  end

  def get_by_short_id(config, short_id)
    method = 'get'
    path = "tasks/shortId/#{short_id}"

    Onfleet.request(config, method.to_sym, path)
  end

  def update(config, id, body)
    method = 'put'
    path = "tasks/#{id}"

    Onfleet.request(config, method.to_sym, path, body.to_json)
  end

  # ACTION: still needs to be tested
  def complete(config, id, body)
    method = 'post'
    path = "tasks/#{id}/complete"

    Onfleet.request(config, method.to_sym, path, body.to_json)
  end

  def clone(config, id)
    method = 'post'
    path = "tasks/#{id}/clone"

    Onfleet.request(config, method.to_sym, path)
  end

  def delete(config, id)
    method = 'delete'
    path = "tasks/#{id}"

    Onfleet.request(config, method.to_sym, path)
  end

  # ACTION: still needs to be tested
  def auto_assign(config, body)
    method = 'post'
    path = 'tasks/autoAssign'

    Onfleet.request(config, method.to_sym, path, body.to_json)
  end
end
