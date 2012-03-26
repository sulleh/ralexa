require_relative "spec_helper"

module Ralexa
  describe TopSites do

    let(:top_sites) { TopSites.new(client) }
    let(:client) { MiniTest::Mock.new }

    describe "#global" do
      def expected_params(start, count)
        {
          "Action" => "TopSites",
          "ResponseGroup" => "Country",
          "Start" => start,
          "Count" => count,
        }
      end
      describe "requesting ten sites" do
        before do
          client.expect :get, fixture("global-top10.xml"),
            ["ats.amazonaws.com", "/", expected_params(1, 10)]
        end
        it "fetches, parses and returns top ten sites" do
          sites = top_sites.global(10).to_a
          sites.size.must_equal 10
          [ sites.first.rank, sites.last.rank ].must_equal [ 1, 10 ]

          g = sites.first
          g.url.must_equal "google.com"
          g.rank.must_equal 1
          g.reach.must_equal 501_800_000_000
          g.page_views.must_equal 54_926_000_000
          g.page_views_per_user.must_equal 11.63
        end
      end
      describe "requesting 150 sites" do
        before do
          client.expect :get, fixture("global-page1.xml"),
            ["ats.amazonaws.com", "/", expected_params(1, 100)]
          client.expect :get, fixture("global-page2.xml"),
            ["ats.amazonaws.com", "/", expected_params(101, 50)]
        end
        it "fetches, parses and returns top ten sites" do
          sites = top_sites.global(150).to_a
          sites.size.must_equal 150
          [ sites.first.rank, sites.last.rank ].must_equal [ 1, 150 ]
        end
      end
      it "raises error if Count (or Start) are specified" do
        ->{
          top_sites.global(10, "Count" => 2)
        }.must_raise PaginatingCollection::Error
      end
    end

    describe "#country" do
      def expected_params(start, count)
        {
          "Action" => "TopSites",
          "ResponseGroup" => "Country",
          "CountryCode" => "AU",
          "Start" => start,
          "Count" => count,
        }
      end
      before do
        client.expect :get, fixture("global-top10.xml"),
          ["ats.amazonaws.com", "/", expected_params(1, 10)]
      end
      it "fetches, parses and returns top sites for specified country" do
        sites = top_sites.country("AU", 10).to_a
        sites.size.must_equal 10
        sites.last.url.must_equal "twitter.com"
      end
      it "raises error if Start (or Count) are specified" do
        ->{
          top_sites.country("AU", 10, start: 2)
        }.must_raise PaginatingCollection::Error
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

  end
end
