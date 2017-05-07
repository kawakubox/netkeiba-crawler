# frozen_string_literal: true

module Scraper
  class RaceEntry
    def initialize(race_key)
      @race = Race.find_or_create_by!(key: race_key)
      @doc = Nokogiri::HTML(Faraday.get(@race.yahoo_race_entry_url).body)
    end

    def scrape!
      @race.update(
        ordinal:        ordinal,
        name:           name,
        grade:          grade,
        distance:       distance,
        weather:        weather,
        course_condition: course_condition
      )

      entry_table.search('tr')[1..-1].each do |tr|
        horse = horse(tr)
        horse.save!
        jockey = jockey(tr)
        jockey.save!

        tr.search('td')[4..-1].each do |td|
          parser = Scraper::RaceResult.new(td.to_html)
          next unless parser.valid?
          r = Race.find_or_create_by!(key: parser.race_key)
          j = Jockey.find_or_create_by!(key: parser.jockey_key)
          hr = HorseResult.find_or_create_by!(
            horse: horse,
            race: r,
            order: parser.order
          )

          hr.update!(
            jockey: j,
            race_time: parser.race_time,
            course_condition: parser.course_condition,
            jockey_weight: parser.jockey_weight,
            horse_weight: parser.horse_weight,
            weight_diff: parser.weight_diff,
            gate_number: parser.gate_number,
            horse_number: parser.horse_number,
            popularity: parser.popularity
          )
        end
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
      Horse.find_or_initialize_by(key: key) do |h|
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
        weather: weather
      )
      race
    end

    def jockey(tr)
      element = tr.at('td:nth(4) > a')
      key = element.attr('href').match(%r{/directory/jocky/(\d+)/})[1]
      name = element.text.strip
      Jockey.find_or_initialize_by(key: key) do |j|
        j.name = name
      end
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

    def course_condition
      return :good if @doc.at('img.ryou')
      return :good_to_soft if @doc.at('img.yayaomo')
      return :soft if @doc.at('img.omo')
      return :heavy if @doc.at('img.furyou')
    end
  end
end
