require_relative "spec_helper"

module Ralexa
  describe Paginator do

    describe "at 10 per page" do

      def paginate(items)
        Paginator.new(10, items).pages
      end

      it "paginates 0 items to 0 pages" do
        paginate(0).size.must_equal 0
      end

      it "paginates 1 item to 1 page" do
        pages = paginate(1)
        pages.size.must_equal 1
        pages.first.tap do |p|
          p.number.must_equal 1
          p.start.must_equal 1
          p.finish.must_equal 1
          p.count.must_equal 1
        end
      end

      it "paginates 10 items to 1 page" do
        pages = paginate(10)
        pages.size.must_equal 1
        pages.first.count.must_equal 10
      end

      it "paginages 25 items to 3 pages" do
        pages = paginate(25)
        pages.size.must_equal 3

        pages.first.tap do |p|
          p.number.must_equal 1
          p.start.must_equal 1
          p.finish.must_equal 10
          p.count.must_equal 10
        end

        pages.last.tap do |p|
          p.number.must_equal 3
          p.start.must_equal 21
          p.finish.must_equal 25
          p.count.must_equal 5
        end
      end

    end

  end
end
