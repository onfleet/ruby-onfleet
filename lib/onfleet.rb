require 'faraday'

class Onfleet(base_url=nil,api_key=nil)
    if base_url.nil?
        @base_url = 'https://onfleet.com/api/v2'
    else
        @base_url = base_url
    end
    
    if api_key?
        @api_key = api_key
    else
        raise "Please provide your api credentials to authenticate your requests."
    end

    def request(method, path, body=nil, headers=nil)
        request = Faraday.new()
        response = nil
        url = "#{@base_url}/#{path}"

        begin
            request.set_basic_auth(@api_key, @api_key)
            response = request.run_request(method: method, url: url, body: body, headers: headers)
        rescue => exception
            raise "Received the following error when making HTTP request: #{exception}"
        end

        return response
    end
  end