module Ralexa
  class UrlInfo < AbstractService

    # The site's Alexa rank
    def rank(url, params = {})
      result({"ResponseGroup" => "Rank", "Url" => url}, params) do |document|
        document.at("//UrlInfoResult/Alexa/TrafficData/Rank").text.to_i
      end 
    end


    private

    def host; "awis.amazonaws.com" end
    def path; "/" end
    def default_params; {"Action" => "UrlInfo"}; end

  end
end
