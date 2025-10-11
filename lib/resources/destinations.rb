require_relative '../onfleet'

module Onfleet
  # Destinations represent the location details for tasks, including exact coordinate and address information.
  class Destinations
    def create(config, body)
      method = 'post'
      path = 'destinations'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def get(config, id)
      method = 'get'
      path = "destinations/#{id}"

      Onfleet.request(config, method.to_sym, path)
    end

    def match_metadata(config, body)
      method = 'post'
      path = 'destinations/metadata'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end
  end
end
