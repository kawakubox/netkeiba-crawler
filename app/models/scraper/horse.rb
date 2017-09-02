# frozen_string_literal: true

module Scraper
  class Horse
    def initialize(id)
      @horse = ::Horse.find_or_initialize_by(id)
      response = Faraday.get(@horse.netkeiba_url)
      raise StandardError unless response.success?
      body = response.body
      @html = body.force_encoding('euc-jp')
      @doc = Nokogiri::HTML(@html)
    end

    def scrape!
      @horse.update!(
        name:       name,
        sex:        sex,
        body_color: body_color,
        birthday:   birthday,
        trainer:    trainer,
        owner:      owner,
        breeder:    breeder,
        birthplace: birthplace
      )
    end

    private

    def main_box
      @main_box ||= @doc.at('#db_main_box')
    end

    def horse_title
      @horse_title ||= main_box.at('.horse_title')
    end

    def name
      @doc.at('title').text.split('|').first.strip
    end

    def sex
      element = horse_title.at('.txt_01')
      return unless element
      md = element.text.match(/[[:space:]](牡|牝|騙|セ)[[:space:]]/)
      return unless md
      case md[1]
      when '牡' then :male
      when '牝' then :female
      when 'セ' || '騙' then :other
      end
    end

    def body_color
      horse_title.at('.txt_01').text.split(/[[:space:]]/)[2]
    end

    def main_data
      @main_data ||= main_box.at('.db_main_deta')
    end

    def prof_table
      @prof_table ||= main_data.at('.db_prof_table')
    end

    def birthday
      year, month, day = prof_table.at('tr:nth(1) td').text.split(/[年月日]/).map(&:to_i)
      return unless year && month && day
      Date.new(year, month, day)
    end

    def trainer
      element = prof_table.at('tr:nth(2) td a')
      return unless element
      key = element.attr('href').split('/').last
      Trainer.find_or_create_by!(key: key) do |t|
        t.name = prof_table.at('tr:nth(2) td a').text.strip
      end
    end

    def owner
      prof_table.at('tr:nth(3) td').text.strip.presence
    end

    def breeder
      prof_table.at('tr:nth(4) td').text.strip.presence
    end

    def birthplace
      prof_table.at('tr:nth(5) td').text.strip.presence
    end
  end
end
