require_relative '../onfleet'

module Onfleet
  # A hub is a home base for a team. It may be the location from where all deliveries originate for that team.
  # A hub could be distribution center or a restaurant, or it may be a centralized location for drivers.
  # Teams may have zero or one hub, and several teams may share a hub.
  class Hubs
    def create(config, body)
      method = 'post'
      path = 'hubs'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def list(config)
      method = 'get'
      path = 'hubs'

      Onfleet.request(config, method.to_sym, path)
    end

    def update(config, id, body)
      method = 'put'
      path = "hubs/#{id}"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end
  end
end
