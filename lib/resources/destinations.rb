require_relative '../onfleet'

# Destinations represent the location details for tasks, including exact coordinate and address information.
class Destinations
  def create(body)
    method = 'post'
    path = 'destinations'

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  def get(id)
    method = 'get'
    path = "destinations/#{id}"

    Onfleet.request(method.to_sym, path)
  end

  def match_metadata(body)
    method = 'post'
    path = 'destinations/metadata'

    Onfleet.request(method.to_sym, path, body.to_json)
  end
end
