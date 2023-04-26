require_relative '../onfleet'

# A recipient is an organization’s customer and a target for a task, that is, whom the task is being delivered to.
class Recipients
  def create(body)
    method = 'post'
    path = 'recipients'

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  def update(id, body)
    method = 'put'
    path = "recipients/#{id}"

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  def get(id)
    method = 'get'
    path = "recipients/#{id}"

    Onfleet.request(method.to_sym, path)
  end

  def get_by_name(recipient_name)
    method = 'get'
    path = "recipients/name/#{recipient_name}"

    Onfleet.request(method.to_sym, path)
  end

  def get_by_phone(recipient_phone)
    method = 'get'
    path = "recipients/phone/#{recipient_phone}"

    Onfleet.request(method.to_sym, path)
  end
end
