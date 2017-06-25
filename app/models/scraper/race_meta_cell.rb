# frozen_string_literal: true

module Scraper
  class RaceMetaCell
    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def course_type
      md = race_tit_meta.text.match(/(芝→ダート|芝|ダート)/)
      return unless md
      case md[1]
        when '芝→ダート' then :turf_to_dirt
        when '芝' then :turf
        when 'ダート' then :dirt
      end
    end

    def distance
      md = race_tit_meta.text.match(/(\d+)m/)
      md[1].to_i if md
    end

    def weather
      return :sunny if race_tit_meta.at('img.hare')
      return :cloudy if race_tit_meta.at('img.kumori')
      return :rainy if race_tit_meta.at('img.ame')
      return :snowy if race_tit_meta.at('img.yuki')
    end

    def course_condition
      return :good if race_tit_meta.at('img.ryou')
      return :good_to_soft if race_tit_meta.at('img.yayaomo')
      return :soft if race_tit_meta.at('img.omo')
      return :heavy if race_tit_meta.at('img.furyou')
    end

    private

    def race_tit_meta
      @race_tit_meta ||= @doc.at('#raceTitMeta')
    end
  end
end
