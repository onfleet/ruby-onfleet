require 'uri'

require_relative '../onfleet'

module Onfleet
  class Routeplans
    def create(config, body)
      method = 'post'
      path = 'routePlans'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def get(config, query_parameters_hash)
      method = 'get'
      # NOTE: parameters included here must be a hash object that is translated to URL query parameters
      # The from parameter is the only required query parameter for this API call - must be formatted in Unix time.
      query_parameters = URI.encode_www_form(query_parameters_hash)
      path = "routePlans?#{query_parameters}"

      Onfleet.request(config, method.to_sym, path)
    end

    def get_by_id(config, id)
      method = 'get'
      path = "routePlans/#{id}"

      Onfleet.request(config, method.to_sym, path)
    end

    def update(config, id, body)
      method = 'put'
      path = "routePlans/#{id}"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def add_tasks_to_routeplan(config, id, body) 
        method = 'put'
        path = "/routePlans/#{id}/tasks"
       
        Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def delete_one(config, id)
      method = 'delete'
      path = "routePlans/#{id}"

      Onfleet.request(config, method.to_sym, path)
    end

  end
end
