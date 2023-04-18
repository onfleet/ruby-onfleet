require_relative '../onfleet.rb'

class Recipients
    # A recipient is an organization’s customer and a target for a task, that is, whom the task is being delivered to.

    def create(body)
        method = "post"
        path = "recipients"

        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def update(id, body)
        method = "put"
        path = "recipients/#{id}"

        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def get(id)
        method = "get"
        path = "recipients/#{id}"

        return Onfleet.request(method.to_sym, path)
    end

    def get_by_name(recipient_name)
        method = "get"
        path = "recipients/name/#{recipient_name}"

        return Onfleet.request(method.to_sym, path)
    end
end