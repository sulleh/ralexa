require "nokogiri"

module Ralexa
  class TopSites

    def initialize(client)
      @client = client
    end

    def host; "ats.amazonaws.com" end
    def path; "/" end

    def list_countries(parameters = {})
      defaults = {"ResponseGroup" => "ListCountries"}
      doc = dispatch(defaults.merge(parameters))
      xpath = "//TopSitesResult/Alexa/TopSites/Countries"
      doc.at(xpath).element_children.map do |node|
        Country.new(
          node.at("Name").text,
          node.at("Code").text,
          node.at("TotalSites").text.to_i,
          node.at("PageViews").text.to_f * 1_000_000,
          node.at("Users").text.to_f * 1_000_000,
        )
      end
    end

    private

    attr_reader :client

    def dispatch(options = {})
      defaults = {"Action" => "TopSites"}
      response = @client.get(host, path, defaults.merge(options))
      Nokogiri::XML.parse(response).remove_namespaces!
    end

    Country = Struct.new(:name, :code, :total_sites, :page_views, :users)

  end
end
