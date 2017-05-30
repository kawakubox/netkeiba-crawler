# frozen_string_literal: true

module Scraper
  class RaceList
    def initialize(event)
      @event = event
      @doc = Nokogiri::HTML(Faraday.get(event.url).body)
    end

    def scrape
      @doc.search('table.scheLs tr[has(td:nth(2))]')[1..-1].map do |tr|
        e = tr.at('td a')
        Race.find_or_initialize_by(key: e.attr('href').match(%r{/race/result/(\d{10})/})[1]) do |race|
          race.name = e.text.strip
        end
      end
    end

    def scrape!
      scrape.each(&:save!)
    end
  end
end