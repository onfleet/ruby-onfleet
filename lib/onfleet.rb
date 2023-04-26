require 'faraday'

# Errors
require_relative './errors/http_error'
require_relative './errors/permission_error'
require_relative './errors/rate_limit_error'
require_relative './errors/service_error'
require_relative './errors/validation_error'

# This class will allow you to configure the Onfleet Ruby API wrapper package
class Configuration
  attr_accessor :api_key, :base_url, :api_version

  @default_url = 'https://onfleet.com/api/v2'
  @default_timeout = 70000

  def initialize(api_key, base_url = nil)
    @api_key = api_key
    @base_url = base_url ? base_url : @default_url
  end
end

# This module will allow you to make direct API calls to the Onfleet platform using our Ruby API wrapper package
module Onfleet
  def self.request(config, method, path, body = nil, headers = nil)
    request = Faraday.new
    response = nil
    url = "#{config.base_url}/#{path}"

    begin
      request.set_basic_auth(config.api_key, config.api_key)
      response = request.run_request(method, url, body, headers)
    rescue Error.service_error => e
      raise "Received the following error when making HTTP request: #{e}"
    end
    response
  end
end
