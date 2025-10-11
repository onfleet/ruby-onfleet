require_relative '../onfleet'

module Onfleet
  # Organizations represent the top-most entity on Onfleet.
  # All entities belong to an organization.
  class Organizations
    def get(config, delegatee_id = nil)
      method = 'get'

      # change url path if a delegatee is provided
      if delegatee_id
        path = "organizations/#{delegatee_id}"
      else
        path = 'organization'
      end

      Onfleet.request(config, method.to_sym, path)
    end

    def insert_task(config, org_id, body)
      method = 'put'
      path = "containers/organizations/#{org_id}"

      Onfleet.request(config, method.to_sym, path, body.to_json)
    end
  end
end
