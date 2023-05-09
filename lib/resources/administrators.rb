require_relative '../onfleet'

# Administrators are users who perform actions via the dashboard.
class Administrators
  def create(config, body)
    method = 'post'
    path = 'admins'

    Onfleet.request(config, method.to_sym, path, body.to_json)
  end

  def list(config)
    method = 'get'
    path = 'admins'

    Onfleet.request(config, method.to_sym, path)
  end

  def update(config, id, body)
    method = 'put'
    path = "admins/#{id}"

    Onfleet.request(config, method.to_sym, path, body.to_json)
  end

  def delete(config, id)
    method = 'delete'
    path = "admins/#{id}"

    Onfleet.request(config, method.to_sym, path)
  end
end
