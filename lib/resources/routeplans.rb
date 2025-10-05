require 'uri'

require_relative '../onfleet'

module Onfleet
  # Tasks represent units of work, defined by one destination and one recipient,
  # that administrators create and assign to workers for completion.
  # Task assignment, state and dependencies are important concepts that
  # you should understand well prior to using the task endpoints.
  class Routeplans
    def create(config, body)
      method = 'post'
      path = 'tasks'

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
      path = "routeplans/#{id}"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def addTasksToRoutePlan(config, id, body) 
        method = 'put'
        path = "/routePlans/#{id}/tasks"
       
        Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def delete(config, id)
      method = 'delete'
      path = "routePlans/#{id}"

      Onfleet.request(config, method.to_sym, path)
    end

  end
end
