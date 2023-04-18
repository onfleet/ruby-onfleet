require_relative '../onfleet.rb'

class Containers

    # Containers are an abstraction which describes task assignment. 
    # A container is an ordered list of tasks. Tasks always belong to exactly one container -- once created and when reassigned. 
    # When a task is started by a worker, it is no longer part of that container's tasks. 
    # Organizations, teams and workers all correspond to containers as they can all be assigned tasks.

    def get(worker_id)
        method = "get"
        path = "containers/workers/#{worker_id}"
        
        return Onfleet.request(method.to_sym, path)
    end

    def insert_task(worker_id, body)
        method = "put"
        path = "containers/workers/#{worker_id}"

        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def update_task(worker_id, body)
        method = "put"
        path = "containers/workers/#{worker_id}"

        return Onfleet.request(method.to_sym, path, body.to_json)
    end
end