require_relative '../onfleet'

module Onfleet
  # Webhooks make it possible for your application to be notified of important system events,
  # as soon as these take place within Onfleet.
  # Onfleet uses HMAC (hash-based message authentication code) with the SHA-512 hash function for additional authentication.
  # By using the webhook secret obtained on the Onfleet dashboard,
  # your webhook server should verify that the source of webhook requests
  # are indeed coming from Onfleet and is associated with your organization.
  # Any failed requests will be retried in 30-minute cycles, up to one full day.
  # A failed request is any non-200 response that a webhook request gets from your application.
  class Webhooks
    
    def create(config, body)
      method = 'post'
      path = 'webhooks'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def list(config)
      method = 'get'
      path = 'webhooks'

      Onfleet.request(config, method.to_sym, path)
    end

    def delete(config, id)
      method = 'delete'
      path = "webhooks/#{id}"

      Onfleet.request(config, method.to_sym, path)
    end
  end
end
