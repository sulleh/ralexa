module Ralexa
  class TopSites < AbstractService

    PER_PAGE = 100

    # A global list of top sites.
    def global(limit, params = {})
      paginating_collection(
        limit,
        PER_PAGE,
        {"ResponseGroup" => "Country"},
        params,
        &top_sites_parser
      )
    end

    # Top sites for the specified two letter country code.
    def country(code, limit, params = {})
      paginating_collection(
        limit,
        PER_PAGE,
        {"ResponseGroup" => "Country", "CountryCode" => code.to_s.upcase},
        params,
        &top_sites_parser
      )
    end

    # All countries that have Alexa top sites.
    def list_countries(params = {})
      collection({"ResponseGroup" => "ListCountries"}, params) do |document|
        path = "//TopSitesResult/Alexa/TopSites/Countries"
        document.at(path).elements.map do |node|
          Country.new(
            node.at("Name").text,
            node.at("Code").text,
            node.at("TotalSites").text.to_i,
            node.at("PageViews").text.to_f * 1_000_000,
            node.at("Users").text.to_f * 1_000_000,
          )
        end
      end
    end

    private

    def host; "ats.amazonaws.com" end
    def path; "/" end
    def default_params; {"Action" => "TopSites"} end

    def top_sites_parser
      ->(document){
        document.at("//TopSites/Country/Sites").elements.map do |node|
          Site.new(
            node.at("DataUrl").text,
            node.at("Country/Rank").text.to_i,
            node.at("Country/Reach/PerMillion").text.to_i * 1_000_000,
            node.at("Country/PageViews/PerMillion").text.to_i,
            node.at("Country/PageViews/PerUser").text.to_f
          )
        end
      }
    end

    Country = Struct.new(:name, :code, :total_sites, :page_views, :users)
    Site = Struct.new(:url, :rank, :reach, :page_views_per_million, :page_views_per_user)
  end
end
