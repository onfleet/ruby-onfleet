require_relative '../onfleet.rb'

class Administrators

    # Administrators are users who perform actions via the dashboard.

    def create(body)
        method = "post"
        path = "admins"
        
        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def list
        method = "get"
        path = "admins"

        return Onfleet.request(method.to_sym, path)
    end

    def update(id, body)
        method = "put"
        path = "admins/#{id}"

        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def delete(id)
        method = "delete"
        path = "admins/#{id}"

        return Onfleet.request(method.to_sym, path)
    end
end