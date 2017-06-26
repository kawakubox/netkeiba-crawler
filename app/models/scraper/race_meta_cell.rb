# frozen_string_literal: true

module Scraper
  class RaceMetaCell
    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def ordinal
      md = race_tit_name.text.match(/第(\d+)回/)
      md[1].to_i if md
    end

    def name
      md = race_tit_name.text.match(/(第\d+回)?(.+)/)
      md[2].gsub(/（.+）/, '') if md
    end

    def grade
      md = race_tit_name.text.match(/（(.+)）/)
      return unless md
      case md[1]
        when 'GI' then :g1
        when 'GII' then :g2
        when 'GIII' then :g3
      end
    end

    def kind
      race_tit_meta.text.include?('障害') ? :steeplechase : :flat
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

    def direction
      md = race_tit_meta.text.match(/(左|右|直線)/)
      return unless md
      case md[1]
      when '右' then :right
      when '左' then :left
      when '直線' then :straight
      end
    end

    def circumference
      md = race_tit_meta.text.match(/(外->内|内|外)/)
      return unless md
      case md[1]
      when '外->内' then :outer_to_inner
      when '内' then :inner
      when '外' then :outer
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

    def race_tit_name
      @race_tit_name ||= @doc.at('#raceTitName h1')
    end

    def race_tit_meta
      @race_tit_meta ||= @doc.at('#raceTitMeta')
    end
  end
end
