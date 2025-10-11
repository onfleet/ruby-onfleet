require 'uri'

require_relative '../onfleet'

module Onfleet
  # Tasks represent units of work, defined by one destination and one recipient,
  # that administrators create and assign to workers for completion.
  # Task assignment, state and dependencies are important concepts that
  # you should understand well prior to using the task endpoints.
  class Tasks
    def create(config, body)
      method = 'post'
      path = 'tasks'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def batch_create(config, body)
      method = 'post'
      path = 'tasks/batch'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def batch_create_async(config, body)
      method = 'post'
      path = 'tasks/batch-async'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def list(config, query_parameters_hash)
      method = 'get'
      # NOTE: parameters included here must be a hash object that is translated to URL query parameters
      # The from parameter is the only required query parameter for this API call - must be formatted in Unix time.
      query_parameters = URI.encode_www_form(query_parameters_hash)
      path = "tasks/all?#{query_parameters}"

      Onfleet.request(config, method.to_sym, path)
    end

    def get(config, id)
      method = 'get'
      path = "tasks/#{id}"

      Onfleet.request(config, method.to_sym, path)
    end

    def get_by_short_id(config, short_id)
      method = 'get'
      path = "tasks/shortId/#{short_id}"

      Onfleet.request(config, method.to_sym, path)
    end

    def update(config, id, body)
      method = 'put'
      path = "tasks/#{id}"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def complete(config, id, body)
      method = 'post'
      path = "tasks/#{id}/complete"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def clone(config, id)
      method = 'post'
      path = "tasks/#{id}/clone"

      Onfleet.request(config, method.to_sym, path)
    end

    def delete(config, id)
      method = 'delete'
      path = "tasks/#{id}"

      Onfleet.request(config, method.to_sym, path)
    end

    def auto_assign(config, body)
      method = 'post'
      path = 'tasks/autoAssign'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def match_metadata(config, body)
      method = 'post'
      path = 'tasks/metadata'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end
  end
end
