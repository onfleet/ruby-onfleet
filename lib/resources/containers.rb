require_relative '../onfleet'

# Containers are an abstraction which describes task assignment.
# A container is an ordered list of tasks. Tasks belong to exactly one container once created and when reassigned.
# When a task is started by a worker, it is no longer part of that container's tasks.
# Organizations, teams and workers all correspond to containers as they can all be assigned tasks.
class Containers
  def get(config, entity, id)
    method = 'get'
    path = "containers/#{entity}/#{id}"

    Onfleet.request(config, method.to_sym, path)
  end

  # This replacement method is only supported on the worker container type.
  def update_task(config, worker_id, body)
    method = 'put'
    path = "containers/workers/#{worker_id}"

    Onfleet.request(config, method.to_sym, path, body.to_json)
  end
end
