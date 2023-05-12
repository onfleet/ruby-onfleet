require 'json'

module Onfleet
  class Configuration
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
  end
end
