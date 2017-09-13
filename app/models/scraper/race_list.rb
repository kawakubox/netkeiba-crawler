# frozen_string_literal: true

module Scraper
  class RaceList
    def initialize(event)
      @event = event
      @doc = Nokogiri::HTML(Faraday.get(event.url).body)
    end

    def scrape
      @doc.search('table.scheLs tr[has(td:nth(2))]').map do |tr|
        e = tr.at('td a')
        key = e.attr('href').match(%r{/race/result/(\d{10})/})[1]
        Race.find_or_initialize_by(id: key) do |race|
          race.event = @event
          race.key = key
          race.name = e.text.strip
          race.race_name = RaceName.find_or_create_by!(long_name: e.text.strip)
        end
      end
    end

    def scrape!
      scrape.each(&:save!)
    end
  end
end
