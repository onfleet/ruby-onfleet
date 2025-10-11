require 'uri'

require_relative '../onfleet'

module Onfleet
  # Teams are named entities that bring together administrators and workers belonging to the same organization.
  # Teams have hubs from where its workers may start and end their shifts.
  class Teams
    def create(config, body)
      method = 'post'
      path = 'teams'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def list(config)
      method = 'get'
      path = 'teams'

      Onfleet.request(config, method.to_sym, path)
    end

    def get(config, id)
      method = 'get'
      path = "teams/#{id}"

      Onfleet.request(config, method.to_sym, path)
    end

    def update(config, id, body)
      method = 'put'
      path = "teams/#{id}"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def delete(config, id)
      method = 'delete'
      path = "teams/#{id}"

      Onfleet.request(config, method.to_sym, path)
    end


    def auto_dispatch(config, id, body)
      method = 'post'
      path = "teams/#{id}/dispatch"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def driver_time_estimate(config, worker_id, query_parameters_hash = nil)
      method = 'get'

      # NOTE: parameters included here must be a hash object that is translated to URL query parameters
      query_parameters = nil
      if query_parameters_hash
        query_parameters = URI.encode_www_form(query_parameters_hash)
      end
      path = "teams/#{worker_id}/estimate?#{query_parameters}"

      Onfleet.request(config, method.to_sym, path)
    end

    # ACTION: still needs to be tested - need to include query_parameters
    def get_unassigned_tasks(config, id, query_parameters_hash = nil)
      method = 'get'

      # NOTE: parameters included here must be a hash object that is translated to URL query parameters
      query_parameters = nil
      if query_parameters_hash
        query_parameters = URI.encode_www_form(query_parameters_hash)
      end
      path = "teams/#{id}/tasks?#{query_parameters}"

      Onfleet.request(config, method.to_sym, path)
    end

    def insert_task(config, team_id, body)
      method = 'put'
      path = "containers/teams/#{team_id}"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end
  end
end
