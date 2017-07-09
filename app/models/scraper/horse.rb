# frozen_string_literal: true

module Scraper
  class Horse
    def initialize(key)
      @horse = ::Horse.find_or_initialize_by(key: key)
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
      horse_title.at('h1').text.gsub(/[[:space:]]/, '').gsub(/(○外|□外|○地|□地)/, '').strip
    end

    def sex
      sex = horse_title.at('.txt_01').text.split(/[[:space:]]/)[1]
      case sex.first
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
      Date.new(year, month, day)
    end

    def trainer
      key = prof_table.at('tr:nth(2) td a').attr('href').split('/').last
      name = prof_table.at('tr:nth(2) td a').text.strip
      Trainer.find_or_create_by!(key: key) do |t|
        t.name = name
      end
    end

    def owner
      prof_table.at('tr:nth(3) td a').text.strip
    end

    def breeder
      prof_table.at('tr:nth(4) td').text.strip
    end

    def birthplace
      prof_table.at('tr:nth(5) td').text.strip
    end
  end
end
