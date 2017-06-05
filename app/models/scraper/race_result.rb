# frozen_string_literal: true

module Scraper
  class RaceResult
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

    def order
      md = @doc.at('div:nth(1)').attr('class').match(/i(\d{2})(\d{2})/)
      md[2].to_i if md
    end

    def race_time
      md = @doc.at('td > strong').text.match(/(\d+)?.(\d+).(\d+)/)
      md[1].to_i * 60 + md[2].to_i + md[3].to_i * 0.1 if md
    end

    def jockey_key
      @doc.at('td > a').attr('href').match(%r{/directory/jocky/(\d+)/})[1]
    end

    def jockey_weight
      @doc.at('td > a').next_sibling.text.match(/\(([0-9.]+)\)/)[1].to_i
    end

    # 馬体重を抜き出す
    #
    # (ex) 484(-2) の 456
    # @return 馬体重[Integer]
    def horse_weight
      md = @doc.text.match(/(\d{3})\((.+)\)/)
      md[1].to_i if md
    end

    # 馬体重の増減を抜き出す
    #
    # (ex) 484(-2) の -4
    # @return 馬体重の増減[Integer]
    def weight_diff
      md = @doc.text.match(/(\d{3})\((.+)\)/)
      md[2].to_i if md
    end

    def gate_number
      md = @doc.text.match(/\[(\d+)\](\d+)\((\d+)人\)/)
      md[1].to_i if md
    end

    def horse_number
      md = @doc.text.match(/\[(\d+)\](\d+)\((\d+)人\)/)
      md[2].to_i if md
    end

    def popularity
      md = @doc.text.match(/\[(\d+)\](\d+)\((\d+)人\)/)
      md[3].to_i if md
    end

    def valid?
      @doc.at('div a').present?
    end
  end
end
