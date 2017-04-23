require 'faraday'

class ScrapeScheduleJob < ApplicationJob
  queue_as :default

  def perform(year:, month:)
    url = "https://keiba.yahoo.co.jp/schedule/list/#{year}?month=#{month}"
    scraper = Scraper::Schedule.new(Faraday.get(url).body)
    scraper.scrape(&:save)
  end
end
