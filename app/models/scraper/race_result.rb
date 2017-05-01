# frozen_string_literal: true

module Scraper
  class RaceResult
    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def race
      Race.find_or_create_by!(key: race_key)
    end

    def race_key
      @doc.at('div a').attr('href').match(%r{/race/result/(\d+)/})[1]
    end

    def course_condition
      @doc.at('div:nth(1)').attr('class').match(/i(\d{2})(\d{2})/)[1]
    end

    def order
      @doc.at('div:nth(1)').attr('class').match(/i(\d{2})(\d{2})/)[2].to_i
    end

    def race_time
      md = @doc.at('td > strong').text.match(/(\d+)?.(\d+).(\d+)/)
      md[1].to_i * 60 + md[2].to_i + md[3].to_i * 0.1
    end
  end
end
