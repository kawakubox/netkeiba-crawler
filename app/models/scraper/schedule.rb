module Scraper
  class Schedule
    YAHOO_KEIBA = 'https://keiba.yahoo.jp'.freeze

    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def scrape
      @doc.search('table.scheLs tr:has(td[rowspan])').map do |e|
        ec = EventComponent.new(e, year: year, month: month)
        Event.new(key: ec.key, date: ec.date, name: ec.name)
      end
    end

    class EventComponent
      attr_reader :year, :month

      def initialize(tr, year:, month:)
        @tr = tr
        @year = year
        @month = month
      end

      def key
        @tr.at('td:nth-of-type(1) a').attr('href').split('/').last
      end

      def date
        day = @tr.at('td:nth-of-type(1)').child.text.match(/(\d+)日/)[1].to_i
        Date.new(year, month, day)
      end

      def name
        @tr.at('td:nth-of-type(1) a').text.strip
      end
    end

    private

    def schedule_header
      @doc.at('.scheHead h3')
    end

    def year
      @year ||= schedule_header.text.match(/(\d+)年(\d+)月/)[1].to_i
    end

    def month
      @month ||= schedule_header.text.match(/(\d+)年(\d+)月/)[2].to_i
    end
  end
end
