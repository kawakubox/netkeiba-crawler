# frozen_string_literal: true

module Scraper
  class RaceEntry
    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def scrape
      
    end

    private

    def race_key
      @doc.at('#raceNoNaviC a').attr('href').split('/').last 
    end

    def race
      Race.find_or_initialize_by(key: race_key)
    end

    def ordinal
      md = @doc.at('#raceTitName h1').text.match(/第(\d+)回/)
      md[1].to_i if md
    end

    def name
      md = @doc.at('#raceTitName h1').text.match(/(第\d+回)?(.+)/)
      md[2].gsub(/（.+）/, '') if md
    end

    def grade
      md = @doc.at('#raceTitName h1').text.match(/（(.+)）/)
      return unless md
      case md[1]
      when 'GI' then Race.grades[:g1]
      when 'GII' then Race.grades[:g2]
      when 'GIII' then Race.grades[:g3]
      else nil
      end
    end
  end
end
