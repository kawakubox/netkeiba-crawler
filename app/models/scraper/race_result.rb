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

    def jockey_key
      @doc.at('td > a').attr('href').match(%r{/directory/jocky/(\d+)/})[1]
    end

    def jockey_weight
      @doc.at('td > a').next_sibling.text.match(/\((\d+)\)/)[1].to_i
    end

    # 馬体重を抜き出す
    #
    # (ex) 484(-2) の 456
    # @return 馬体重[Integer]
    def horse_weight
      @doc.text.match(/(\d{3})\((.+)\)/)[1].to_i
    end

    # 馬体重の増減を抜き出す
    #
    # (ex) 484(-2) の -4
    # @return 馬体重の増減[Integer]
    def weight_diff
      @doc.text.match(/(\d{3})\((.+)\)/)[2].to_i
    end

    def gate_number
      @doc.text.match(/\[(\d+)\](\d+)\((\d+)人\)/)[1].to_i
    end

    def horse_number
      @doc.text.match(/\[(\d+)\](\d+)\((\d+)人\)/)[2].to_i
    end

    def popularity
      @doc.text.match(/\[(\d+)\](\d+)\((\d+)人\)/)[3].to_i
    end

    def valid?
      @doc.at('div a').present?
    end
  end
end
