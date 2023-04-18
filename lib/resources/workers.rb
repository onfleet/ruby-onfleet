require_relative '../onfleet.rb'

class Workers

    # Workers (also known as drivers in the dashboard) are the members of an organization 
    # who perform actions via the Onfleet mobile applications.

    def create(body)
        method = "post"
        path = "workers"
        
        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def list(query_parameters)
        method = "get"

        # NOTE: parameters included here must be in the format of the URL query parameters for a raw API call
        path = "workers?#{query_parameters}"

        return Onfleet.request(method.to_sym, path)
    end

    def list_worker_tasks(id)
        method = "get"
        path = "workers/#{id}/tasks"

        return Onfleet.request(method.to_sym, path)
    end

    def get_workers_near_location(longitude, latitude, radius=nil)
        method = "get"
        path = "workers/location?longitude=#{longitude}&latitude=#{latitude}&radius=#{radius}"

        return Onfleet.request(method.to_sym, path)
    end

    def get(id)
        method = "get"
        path = "workers/#{id}?analytics=true"

        return Onfleet.request(method.to_sym, path)
    end

    def update(id, body)
        method = "put"
        path = "workers/#{id}"

        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def delete(id)
        method = "delete"
        path = "workers/#{id}"

        return Onfleet.request(method.to_sym, path)
    end

    def get_worker_schedule(body)
        # ACTION: is this supposed to be a post or a get?
        method = "post"
        path = "workers/#{id}/schedule"
        
        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def set_worker_schedule(body)
        method = "post"
        path = "workers/#{id}/schedule"
        
        return Onfleet.request(method.to_sym, path, body.to_json)
    end
end