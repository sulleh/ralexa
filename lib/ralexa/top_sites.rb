require "ralexa/abstract_xml_service"

module Ralexa
  class TopSites < AbstractXmlService

    def global(params = {})
      top_sites_from_document(dispatch(
        {"ResponseGroup" => "Country"},
        params
      ))
    end

    def country(code, params = {})
      top_sites_from_document(dispatch(
        {"ResponseGroup" => "Country", "CountryCode" => code.to_s.upcase},
        params
      ))
    end

    def list_countries(params = {})
      dispatch(
        {"ResponseGroup" => "ListCountries"},
        params
      ).at("//TopSitesResult/Alexa/TopSites/Countries").elements.map do |node|
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

    def host; "ats.amazonaws.com" end
    def path; "/" end
    def default_params; {"Action" => "TopSites"} end

    def top_sites_from_document(document)
      document.at("//TopSites/Country/Sites").elements.map do |node|
        Site.new(
          node.at("DataUrl").text,
          node.at("Country/Rank").text.to_i,
          node.at("Country/Reach/PerMillion").text.to_i * 1_000_000,
          (node.at("Country/PageViews/PerMillion").text.to_f * 1_000_000).to_i,
          node.at("Country/PageViews/PerUser").text.to_f
        )
      end
    end

    Country = Struct.new(:name, :code, :total_sites, :page_views, :users)
    Site = Struct.new(:url, :rank, :reach, :page_views, :page_views_per_user)
  end
end
