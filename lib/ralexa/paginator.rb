module Ralexa
  class Paginator

    def initialize(per_page, items)
      @per_page = per_page
      @items = items
    end

    def pages
      page_count.times.map do |i|
        Page.new(page_count, @per_page, @items, i)
      end
    end

    private

    def page_count
      Rational(@items, @per_page).ceil
    end

    class Page

      def initialize(page_count, per_page, items, index)
        @page_count = page_count
        @per_page = per_page
        @items = items
        @index = index
      end

      def number
        @index + 1
      end

      def start
        (@index * @per_page) + 1
      end

      def finish
        start + count - 1
      end

      def count
        if full? then @per_page else @items % @per_page end
      end

      def full?
        number < @page_count || @items % @per_page == 0
      end

      def partial?
        !full?
      end

    end

  end
end
