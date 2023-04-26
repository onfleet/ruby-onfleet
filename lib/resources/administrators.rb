require_relative '../onfleet'
require_relative '../configuration'

# Administrators are users who perform actions via the dashboard.
class Administrators
  def create(body)
    method = 'post'
    path = 'admins'

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  def list
    method = 'get'
    path = 'admins'

    Onfleet.request(method.to_sym, path)
  end

  def update(id, body)
    method = 'put'
    path = "admins/#{id}"

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  def delete(id)
    method = 'delete'
    path = "admins/#{id}"

    Onfleet.request(method.to_sym, path)
  end
end
