# frozen_string_literal: true

module Scraper
  class RaceResultTimeCell
    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def race_key
      @doc.at('div a').attr('href').match(%r{/race/result/(\d+)/})[1]
    end

    def course_condition
      md = @doc.at('div:nth(1)').attr('class').match(/i(\d{2})(\d{2})/)
      md[1] if md
    end

    def order_of_finish
      md = @doc.at('div:nth(1)').attr('class').match(/i(\d{2})(\d{2})/)
      md[2].to_i if md
    end

    def last_3f
      md = @doc.text.match(/\([0-9.]{4} - [0-9.]{4}\) ([0-9.]{4})/)
      md[1].to_f if md
    end

    def corner_position
      md = @doc.text.match(/(\d{2}(-\d{2})*)? \[\d{1,}人-\d{1,2}\]/)
      md[1] if md
    end

    def valid?
      @doc.at('div a').present?
    end
  end
end
