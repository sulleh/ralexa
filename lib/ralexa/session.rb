module Ralexa
  class Session

    def initialize(api_key)
      @client = Client.new(api_key)
    end

    # Provides a TopSites instance with an authenticated client.
    # See: http://docs.amazonwebservices.com/AlexaTopSites/latest/index.html
    def top_sites
      TopSites.new(@client)
    end

    # Provides a UrlInfo instance with an authenticated client.
    # See: http://docs.amazonwebservices.com/AlexaWebInfoService/latest
    def url_info
      UrlInfo.new(@client)
    end

  end
end
