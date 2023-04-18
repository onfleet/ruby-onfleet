require 'faraday'

module Onfleet
    # ACTION: commenting out for now, will see if we want to pass api_key and base_url as parameters after running testing
    # if base_url.nil?
    #     @base_url = "https://onfleet.com/api/v2"
    # else
    #     @base_url = base_url
    # end
    
    # if api_key?
    #     @api_key = api_key
    # else
    #     raise "Please provide your api credentials to authenticate your requests."
    # end

    @@api_key = ""
    @@base_url = "https://staging.onfleet.com/api/v2"

    def self.request(method, path, body=nil, headers=nil)
        request = Faraday.new()
        response = nil
        url = "#{@@base_url}/#{path}"

        begin
            request.set_basic_auth(@@api_key, @@api_key)
            response = request.run_request(method, url, body, headers)
            
        rescue => exception
            raise "Received the following error when making HTTP request: #{exception}"
        end

        return response
    end
  end