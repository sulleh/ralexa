require_relative "spec_helper"

module Ralexa
  describe Session do

    describe ".top_sites" do
      it "returns a Ralexa::TopSites instance" do
        Session.new("id", "secret").top_sites.must_be_kind_of ::Ralexa::TopSites
      end
    end

    describe ".url_info" do
      it "returns a Ralexa::UrlInfo instance" do
        Session.new("id", "secret").url_info.must_be_kind_of ::Ralexa::UrlInfo
      end
    end

  end
end
