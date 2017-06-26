# frozen_string_literal: true

module Scraper
  class RaceEntry
    def initialize(race_key)
      @race = Race.find_or_create_by!(key: race_key)
      response = Faraday.get(@race.yahoo_race_entry_url)
      raise StandardError unless response.success?
      @html = response.body
      @doc = Nokogiri::HTML(response.body)
    end

    def scrape!
      race_meta = Scraper::RaceMetaCell.new(@html)

      @race.update!(
        ordinal:          race_meta.ordinal,
        name:             race_meta.name,
        grade:            race_meta.grade,
        kind:             race_meta.kind,
        course_type:      race_meta.course_type,
        direction:        race_meta.direction,
        circumference:    race_meta.circumference,
        distance:         race_meta.distance,
        weather:          race_meta.weather,
        course_condition: race_meta.course_condition
      )

      entry_table.search('tr')[1..-1].each do |tr|
        horse = horse(tr)
        horse.save!
        jockey = jockey(tr)
        jockey.save!

        hr = HorseResult.find_or_create_by!(horse: horse, race: @race)
        hr.gate_number = gate_number(tr)
        hr.horse_number = horse_number(tr)
        hr.jockey = jockey
        hr.save!

        tr.search('td')[4..-1].each do |td|
          parser = Scraper::RaceResultCell.new(td.to_html)
          next unless parser.valid?
          r = Race.find_or_create_by!(key: parser.race_key)
          j = Jockey.find_or_create_by!(key: parser.jockey_key)
          hr = HorseResult.find_or_create_by!(horse: horse, race: r)

          hr.update!(parser.params)
        end
      end
    end

    private

    def entry_table
      @doc.at('table.denmaLs')
    end

    def gate_number(tr)
      tr.at('td:nth(1)').text.to_i
    end

    def horse_number(tr)
      tr.at('td:nth(2)').text.to_i
    end

    def horse(tr)
      element = tr.at('td:nth(3) > a')
      key = element.attr('href').match(%r{/directory/horse/(\d+)/})[1]
      name = element.text.strip
      Horse.find_or_initialize_by(key: key) do |h|
        h.name = name
      end
    end

    def jockey(tr)
      element = tr.at('td:nth(4) > a')
      key = element.attr('href').match(%r{/directory/jocky/(\d+)/})[1]
      name = element.text.strip
      Jockey.find_or_initialize_by(key: key) do |j|
        j.name = name
      end
    end
  end
end
