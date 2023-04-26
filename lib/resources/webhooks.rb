require_relative '../onfleet'

# Webhooks make it possible for your application to be notified of important system events,
# as soon as these take place within Onfleet.
# Onfleet uses HMAC (hash-based message authentication code) with the SHA-512 hash function for additional authentication. 
# By using the webhook secret obtained on the Onfleet dashboard, 
# your webhook server should verify that the source of webhook requests
# are indeed coming from Onfleet and is associated with your organization.
# Any failed requests will be retried in 30-minute cycles, up to one full day. 
# A failed request is any non-200 response that a webhook request gets from your application.
class Webhooks
  # ACTION: still needs to be tested
  def create(body)
    method = 'post'
    path = 'webhooks'

    Onfleet.request(method.to_sym, path, body.to_json)
  end

  # ACTION: still needs to be tested
  def list
    method = 'get'
    path = 'webhooks'

    Onfleet.request(method.to_sym, path)
  end

  # ACTION: still needs to be tested
  def delete(id)
    method = 'delete'
    path = "webhooks/#{id}"

    Onfleet.request(method.to_sym, path)
  end
end
