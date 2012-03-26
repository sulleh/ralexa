require "ralexa/client"
require "ralexa/top_sites"

module Ralexa
  class Session

    def initialize(access_key_id, secret_access_key)
      @client = Client.new(access_key_id, secret_access_key)
    end

    # Provides a TopSites instance with an authenticated client.
    # See: http://docs.amazonwebservices.com/AlexaTopSites/latest/index.html
    def top_sites
      TopSites.new(@client)
    end

  end
end
