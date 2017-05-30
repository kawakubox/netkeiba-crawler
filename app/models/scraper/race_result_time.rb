# frozen_string_literal: true

module Scraper
  class RaceResultTime
    def initialize(html)
      @doc = Nokogiri::HTML(html)
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

    def last_3f
      @doc.text.match(/\([0-9.]{4} - [0-9.]{4}\) ([0-9.]{4})/)[1].to_f
    end

    def corner_position
      @doc.text.match(/(\d{2}(-\d{2})*)? \[\d{1,}人-\d{1,2}\]/)[1]
    end

    def valid?
      @doc.at('div a').present?
    end
  end
end
