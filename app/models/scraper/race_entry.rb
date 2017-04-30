# frozen_string_literal: true

module Scraper
  class RaceEntry
    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    def scrape
      entry_table.search('tr')[1..-1].map do |tr|
        horse(tr)
      end
    end

    private

    def entry_table
      @doc.at('table.denmaLs')
    end

    def horse(tr)
      element = tr.at('td:nth(3) > a')
      key = element.attr('href').match(%r{/directory/horse/(\d+)/})[1]
      name = element.text.strip
      Horse.find_or_create_by!(key: key) do |h|
        h.name = name
      end
    end

    def race_key
      @doc.at('#raceNoNaviC a').attr('href').split('/').last 
    end

    def race
      race = Race.find_or_initialize_by(key: race_key)
      race.update(
        ordinal: ordinal,
        name: name,
        grade: grade,
        distance: distance,
        weather: weather,
      )
      race
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
      when 'GI' then :g1
      when 'GII' then :g2
      when 'GIII' then :g3
      else nil
      end
    end

    def distance
      md = @doc.at('#raceTitMeta').text.match(/(\d+)m/)
      md[1].to_i if md
    end

    def weather
      return :sunny if @doc.at('img.hare')
      return :cloudy if @doc.at('img.kumori')
      return :rainy if @doc.at('img.ame')
      return :snowy if @doc.at('img.yuki')
    end
  end
end
