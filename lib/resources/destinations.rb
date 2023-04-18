require_relative '../onfleet.rb'

class Destinations

    # Destinations represent the location details for tasks, including exact coordinate and address information.

    def create(body)
        method = "post"
        path = "destinations"
        
        return Onfleet.request(method.to_sym, path, body.to_json)
    end

    def get(id)
        method = "get"
        path = "destinations/#{id}"

        return Onfleet.request(method.to_sym, path)
    end
end