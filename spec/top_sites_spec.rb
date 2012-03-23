require_relative "spec_helper"

require "ralexa/top_sites"

module Ralexa
  describe TopSites do

    let(:top_sites) { TopSites.new(client) }
    let(:client) { MiniTest::Mock.new }

    describe "#list_countries" do

      before do
        expect_parameters = {
          "Action" => "TopSites",
          "ResponseGroup" => "ListCountries",
        }
        client.expect :get, fixture("list_countries.xml"),
          ["ats.amazonaws.com", "/", expect_parameters]
      end

      it "fetches, parses and returns countries" do
        countries = top_sites.list_countries
        countries.size.must_equal 2
        a, u = countries

        u.name.must_equal "United States"
        u.code.must_equal "US"
        u.total_sites.must_equal 484842
        u.page_views.must_equal 18_023_000
        u.users.must_equal 18_998_000

        a.name.must_equal "Australia"
        a.code.must_equal "AU"
        a.total_sites.must_equal 42920
        a.page_views.must_equal 1_074_000
        a.users.must_equal 1_148_000
      end
    end

  end
end
