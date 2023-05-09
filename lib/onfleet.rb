require 'faraday'
require 'json'

require_relative 'utils'

# Errors
require_relative './errors/http_error'
require_relative './errors/permission_error'
require_relative './errors/rate_limit_error'
require_relative './errors/service_error'
require_relative './errors/validation_error'

# This class allows you to configure and make direct API calls to the Onfleet platform using our Ruby API wrapper package
class Onfleet
  attr_reader :default_timeout, :api_key, :base_url, :version, :name

  def initialize(api_key, base_url = nil)
    file = File.read('/Users/danmenza/onfleet/code/api_wrappers/ruby-onfleet/package.json')
    package_data = JSON.parse(file)

    @default_url = 'https://onfleet.com/api/v2'
    # ACTION: need to figure out how to include API timeout parameter
    @default_timeout = 70000
    @api_key = api_key
    @base_url = base_url ? base_url : @default_url
    @version = package_data['version']
    @name = package_data['name']

    @auth_validated = Onfleet.validate_authentication(@base_url, @api_key)
  end

  def self.request(config, method, path, body = nil, headers = {})
    response = nil
    headers['Content-Type'] = 'application/json'
    headers['User-Agent'] = "#{self.name}-#{self.version}"
    request = Faraday.new
    url = "#{self.base_url}/#{path}"

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
