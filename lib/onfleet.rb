require 'faraday'

require_relative 'utils'
require_relative 'configuration'

# resources
require_relative './resources/administrators'
require_relative './resources/containers'
require_relative './resources/destinations'
require_relative './resources/hubs'
require_relative './resources/organizations'
require_relative './resources/recipients'
require_relative './resources/routeplans'
require_relative './resources/tasks'
require_relative './resources/teams'
require_relative './resources/webhooks'
require_relative './resources/workers' 

module Onfleet
end
