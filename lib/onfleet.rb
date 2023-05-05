require 'faraday'
require 'json'

require_relative 'utils'

# Errors
require_relative './errors/http_error'
require_relative './errors/permission_error'
require_relative './errors/rate_limit_error'
require_relative './errors/service_error'
require_relative './errors/validation_error'

# This class will allow you to configure the Onfleet Ruby API wrapper package
class Configuration
  attr_reader :default_timeout, :api_key, :base_url, :version, :name

  def initialize(api_key, base_url = nil)
    file = File.read('/Users/danmenza/onfleet/code/api_wrappers/ruby-onfleet/package.json')
    package_data = JSON.parse(file)

    @default_url = 'https://onfleet.com/api/v2'
    @default_timeout = 70000
    @api_key = api_key
    @base_url = base_url ? base_url : @default_url
    @version = package_data['version']
    @name = package_data['name']
  end
end

# This module will allow you to make direct API calls to the Onfleet platform using our Ruby API wrapper package
module Onfleet
  def self.request(config, method, path, body = nil, headers = {})
    response = nil
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = "#{config.name}-#{config.version}"
    request = Faraday.new
    url = "#{config.base_url}/#{path}"

    # validate_authentication(config.base_url, config.api_key)

    begin
      request.set_basic_auth(config.api_key, config.api_key)
      response = request.run_request(method, url, body, headers)
      handle_api_error(response)
    rescue Faraday::Response::RaiseError => e
      raise HttpError, "Received the following error when making HTTP request: #{e}"
    end
    response
  end
end
