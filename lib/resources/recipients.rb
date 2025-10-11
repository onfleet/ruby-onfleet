require_relative '../onfleet'

module Onfleet
  # A recipient is an organization’s customer and a target for a task, that is, whom the task is being delivered to.
  class Recipients
    def create(config, body)
      method = 'post'
      path = 'recipients'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def update(config, id, body)
      method = 'put'
      path = "recipients/#{id}"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def get(config, id)
      method = 'get'
      path = "recipients/#{id}"

      Onfleet.request(config, method.to_sym, path)
    end

    def get_by_name(config, recipient_name)
      method = 'get'
      recipient_name.gsub!(/\s+/, '%20')
      path = "recipients/name/#{recipient_name}"

      Onfleet.request(config, method.to_sym, path)
    end

    def get_by_phone(config, recipient_phone)
      method = 'get'
      path = "recipients/phone/#{recipient_phone}"

      Onfleet.request(config, method.to_sym, path)
    end

    def match_metadata(config, body)
      method = 'post'
      path = 'recipients/metadata'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end
  end
end
