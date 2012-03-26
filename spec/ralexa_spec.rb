require_relative "spec_helper"

describe Ralexa do

  describe ".session" do
    it "returns a Ralexa::Session" do
      Ralexa.session("id", "secret").must_be_kind_of ::Ralexa::Session
    end
  end

end
