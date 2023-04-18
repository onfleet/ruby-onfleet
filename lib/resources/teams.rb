require_relative '../onfleet.rb'

class Teams

    # Teams are named entities that bring together administrators and workers belonging to the same organization. 
    # Teams have hubs from where its workers may start and end their shifts.

    def create(body)
        method = "post"
        path = "teams"
        
        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def list
        method = "get"
        path = "teams"

        return Onfleet.request(method.to_sym, path)
    end

    def get(id)
        method = "get"
        path = "teams/#{id}"

        return Onfleet.request(method.to_sym, path)
    end

    def delete(id)
        method = "delete"
        path = "teams/#{id}"

        return Onfleet.request(method.to_sym, path)
    end

    def auto_dispatch(id, body)
        method = "post"
        path = "teams/#{id}/dispatch"
        headers = {
            "content-type": "application/json"
        }

        return Onfleet.request(method.to_sym, path, body.to_json, headers.to_json)
    end

    def driver_time_estimate(id, query_parameters)
        method = "get"

        # NOTE: parameters included here must be in the format of the URL query parameters for a raw API call
        path = "teams/#{id}/estimate?#{query_parameters}"

        return Onfleet.request(method.to_sym, path)
    end

    def get_unassigned_tasks(id)
        method = "get"
        path = "teams/#{id}/tasks"

        return Onfleet.request(method.to_sym, path)
    end
end