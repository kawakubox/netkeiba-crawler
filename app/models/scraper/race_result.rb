# frozen_string_literal: true

module Scraper
  class RaceResult
    def initialize(race_key)
      @race = Race.find_or_create_by!(key: race_key)
      response = Faraday.get(@race.netkeiba_race_result_url)
      raise StandardError unless response.success?
      @doc = Nokogiri::HTML(response.body.force_encoding('euc-jp'))
    end

    def scrape!
      result_table.search('tr')[1..-1].each_with_index do |tr, i|
        horse = horse(tr)
        horse.save!

        hr = HorseResult.find_or_create_by!(horse: horse, race: @race)

        hr.update!(
          order_of_finish: order_of_finish(tr),
          race_time:       race_time(tr),
          popularity:      popularity(tr),
          last_3f:         last_3f(tr),
          horse_weight:    horse_weight(tr),
          weight_diff:     weight_diff(tr),
          corner_position: corner_position(tr)
        )
      end
    end

    private

    def result_table
      @result_table ||= @doc.at('table.race_table_01')
    end

    def horse(tr)
      element = tr.at('td:nth(4) > a')
      key = element.attr('href').match(%r{http://db.netkeiba.com/horse/(\d+)/})[1]
      name = element.text.strip
      ::Horse.find_or_initialize_by(key: key) do |h|
        h.name = name
      end
    end

    def order_of_finish(tr)
      tr.at('td:nth(1)').text.to_i
    end

    def race_time(tr)
      md = tr.search('td')[7].text.match(/(\d):(\d{2}.\d)/)
      return unless md
      md[1].to_i * 60 + md[2].to_f
    end

    def popularity(tr)
      tr.at('td:nth(10)').text.to_i
    end

    def last_3f(tr)
      tr.search('td')[11].text
    end

    def corner_position(tr)
      tr.search('td')[12].text.presence
    end

    def horse_weight(tr)
      md = tr.search('td')[14].text.match(/(\d+)\((.+)\)/)
      return unless md
      md[1].to_i
    end

    def weight_diff(tr)
      md = tr.search('td')[14].text.match(/(\d+)\((.+)\)/)
      return unless md
      md[2].to_i
    end
  end
end
