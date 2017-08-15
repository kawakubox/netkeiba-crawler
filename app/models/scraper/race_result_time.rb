# frozen_string_literal: true

module Scraper
  class RaceResultTime
    def initialize(race_key)
      @race = Race.find_or_create_by!(key: race_key)
      response = Faraday.get(@race.yahoo_race_result_time_url)
      raise StandardError unless response.success?
      @doc = Nokogiri::HTML(response.body)
    end

    def scrape!
      @doc.at('table.denmaLs').search('tr')[1..-1].each do |tr|
        horse = horse(tr)
        horse.save!

        tr.search('td')[4..-1].each do |td|
          parser = Scraper::RaceResultTimeCell.new(td.to_html)
          next unless parser.valid?

          r = Race.find_or_create_by!(key: parser.race_key)
          hr = HorseResult.find_or_create_by!(horse: horse, race: r)

          hr.update!(
            order_of_finish: parser.order_of_finish,
            last_3f: parser.last_3f,
            corner_position: parser.corner_position
          )
        end
      end
    end

    private

    def horse(tr)
      element = tr.at('td:nth(3) > a')
      key = element.attr('href').match(%r{/directory/horse/(\d+)/})[1]
      name = element.text.strip
      Horse.find_or_initialize_by(key: key) do |h|
        h.name = name
      end
    end
  end
end
