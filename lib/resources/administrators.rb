require '../onfleet'

class Administrators
    class Administrators
        def create(body)
            method = "POST"
            path = "admins"
            
            return onfleet.request(method, path, body)
        end

        def list
            method = "GET"
            path = "admins"

            return onfleet.request(method, path)
        end

        def update(id, body)
            method = "PUT"
            path = "/admins/#{id}"

            return onfleet.request(method, path, body)
        end

        def delete(id)
            method = "DELETE"
            path = "/admins#{id}"

            return onfleet.request(method, path)
        end
    end
end