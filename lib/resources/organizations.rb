require_relative '../onfleet.rb'

class Organizations

    # Organizations represent the top-most entity on Onfleet. 
    # Administrators, teams, workers and tasks all belong to an organization.

    def get
        method = "get"
        path = "organization"

        return Onfleet.request(method.to_sym, path)
    end

    def get_delegatee_organization(delegatee_id)
        method = "get"
        path = "organizations/#{delegatee_id}"

        return Onfleet.request(method.to_sym, path)
    end
end