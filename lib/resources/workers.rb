require 'uri'

require_relative '../onfleet'

module Onfleet
  # Workers (also known as drivers in the dashboard) are the members of an organization
  # who perform actions via the Onfleet mobile applications.
  class Workers
    def create(config, body)
      method = 'post'
      path = 'workers'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def get(config, id = nil, query_parameters_hash = nil)
      method = 'get'

      query_parameters = nil
      if query_parameters_hash
        query_parameters = URI.encode_www_form(query_parameters_hash)
      end

      if id
        path = "workers/#{id}?#{query_parameters}"
      else
        path = "workers?#{query_parameters}"
      end

      Onfleet.request(config, method.to_sym, path)
    end

    def update(config, id, body)
      method = 'put'
      path = "workers/#{id}"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def delete(config, id)
      method = 'delete'
      path = "workers/#{id}"

      Onfleet.request(config, method.to_sym, path)
    end

    def get_tasks(config, id)
      method = 'get'
      path = "workers/#{id}/tasks"

      Onfleet.request(config, method.to_sym, path)
    end

    def get_by_location(config, longitude, latitude, radius = 1000)
      method = 'get'
      path = "workers/location?longitude=#{longitude}&latitude=#{latitude}&radius=#{radius}"

      Onfleet.request(config, method.to_sym, path)
    end

    def get_schedule(config, id)
      method = 'get'
      path = "workers/#{id}/schedule"

      Onfleet.request(config, method.to_sym, path)
    end

    def set_schedule(config, id, body)
      method = 'post'
      path = "workers/#{id}/schedule"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def get_delivery_manifest(config, body, google_api_key = nil, query_parameters_hash = nil)
      method = 'post'
      query_parameters = nil
      
      if google_api_key
        config.headers['X-Api-Key'] = "Google #{google_api_key}"
      end
      
      if query_parameters_hash
        query_parameters = URI.encode_www_form(query_parameters_hash)
      end
      path = "integrations/marketplace?#{query_parameters}"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def insert_task(config, worker_id, body)
      method = 'put'
      path = "containers/workers/#{worker_id}"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end

    def match_metadata(config, body)
      method = 'post'
      path = 'workers/metadata'

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end
  end
end
