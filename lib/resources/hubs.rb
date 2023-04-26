require_relative '../onfleet'

# A hub is a home base for a team. It may be the location from where all deliveries originate for that team.
# If the hub is a distribution center or a restaurant,
# or it may be a centralized location at which drivers begin and end their shifts.
# Teams may have zero or one hub, and several teams may share a hub.
class Hubs
  def create(body)
    method = 'post'
    path = 'hubs'

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  def list
    method = 'get'
    path = 'hubs'

    Onfleet.request(method.to_sym, path)
  end

  def update(id, body)
    method = 'put'
    path = "hubs/#{id}"

    Onfleet.request(method.to_sym, path, body.to_json)
  end
end
