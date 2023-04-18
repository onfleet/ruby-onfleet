require_relative '../onfleet.rb'

class Tasks

    # Tasks represent units of work, defined by one destination and one recipient, 
    # that administrators create and assign to workers for completion.
    # Task assignment, state and dependencies are important concepts that you should understand well prior to using the task endpoints.

    def create(body)
        method = "post"
        path = "tasks"

        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def list(from_time, to_time=nil, state=nil, last_id=nil)
        method = "get"
        path = "tasks/all?from=#{from_time}"

        # includes 3 optional query parameters to_time, state, and last_id
        if to_time
            path = "#{path}&to=#{to_time}"
        end

        if state
            path = "#{path}&state=#{state}"
        end

        if last_id
            path = "#{path}&lastId=#{last_id}"
        end

        return Onfleet.request(method.to_sym, path)
    end

    def get(id)
        method = "get"
        path = "tasks/#{id}"

        return Onfleet.request(method.to_sym, path)
    end

    def get_by_short_id(short_id)
        method = "get"
        path = "tasks/shortId/#{short_id}"

        return Onfleet.request(method.to_sym, path)
    end

    def update(id, body)
        method = "put"
        path = "tasks/#{id}"

        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def complete(id, body)
        method = "post"
        path = "tasks/#{id}/complete"

        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def clone(id, body)
        method = "post"
        path = "tasks/#{id}/clone"

        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def delete(id)
        method = "delete"
        path = "tasks/#{id}"

        return Onfleet.request(method.to_sym, path)
    end

    def auto_assign(id, body)
        method = "post"
        path = "tasks/autoAssign"

        return Onfleet.request(method.to_sym, path, body.to_json)
    end    
end