require_relative "spec_helper"

require "ralexa/top_sites"

module Ralexa
  describe TopSites do

    let(:top_sites) { TopSites.new(client) }
    let(:client) { MiniTest::Mock.new }

    describe "#global" do
      before do
        expect_parameters = {
          "Action" => "TopSites",
          "ResponseGroup" => "Country",
        }
        client.expect :get, fixture("global.xml"),
          ["ats.amazonaws.com", "/", expect_parameters]
      end
      it "fetches, parses and returns top sites" do
        top_sites_match_fixture(top_sites.global)
      end
    end

    describe "#country" do
      before do
        expect_parameters = {
          "Action" => "TopSites",
          "ResponseGroup" => "Country",
          "CountryCode" => "AU",
        }
        client.expect :get, fixture("global.xml"),
          ["ats.amazonaws.com", "/", expect_parameters]
      end
      it "fetches, parses and returns top sites for specified country" do
        top_sites_match_fixture(top_sites.country("AU"))
      end
    end

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
        countries.to_a.size.must_equal 2
        a, u = countries.to_a

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

    def top_sites_match_fixture(sites)
      sites.to_a.size.must_equal 2
      w, b = sites.to_a

      w.url.must_equal "wikipedia.org"
      w.rank.must_equal 6
      w.reach.must_equal 143_000_000_000
      w.page_views.must_equal 5_219_000_000
      w.page_views_per_user.must_equal 3.88

      b.url.must_equal "bbc.co.uk"
      b.rank.must_equal 52
      b.reach.must_equal 20_540_000_000
      b.page_views.must_equal 898_500_000
      b.page_views_per_user.must_equal 4.65
    end

  end
end
