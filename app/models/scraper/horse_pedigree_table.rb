# frozen_string_literal: true

module Scraper
  class HorsePedigreeTable
    def initialize(key)
      @horse = ::Horse.find_or_initialize_by(key: key)
      response = Faraday.get(@horse.netkeiba_ped_url)
      raise StandardError unless response.success?
      body = response.body
      @html = body.force_encoding('euc-jp')
      @doc = Nokogiri::HTML(@html)
    end

    def scrape!
      @horse.update!(sire: sire, mare: mare)
    end

    private

    def blood_table
      @blood_table ||= @doc.at('table.blood_table')
    end

    def one_generation_ago
      @one_generation_ago ||= blood_table.search('td[rowspan="16"]')
    end

    def sire
      md = one_generation_ago[0].at('a').attr('href').match(%r{horse/([a-z0-9]{10})/})
      return unless md
      ::Horse.find_or_create_by!(key: md[1]) do |h|
        h.name = one_generation_ago[0].at('a').text
      end
    end

    def mare
      md = one_generation_ago[1].at('a').attr('href').match(%r{horse/([a-z0-9]{10})/})
      return unless md
      ::Horse.find_or_create_by!(key: md[1]) do |h|
        h.name = one_generation_ago[1].at('a').text
      end
    end
  end
end
