# frozen_string_literal: true

class EntryCrawler
  # @param [String] url
  def initialize(url)
    @url = url
  end

  # @return [Array<HorseResult>]
  def crawl
    response = Faraday.get(@url)
    raise StandardError unless response.success?
    parser = EntryParser.new(response.body.force_encoding('euc-jp'))
    parser.entries
  end
end
