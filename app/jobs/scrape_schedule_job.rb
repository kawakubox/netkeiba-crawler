# frozen_string_literal: true

require 'faraday'

class ScrapeScheduleJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) { |e| Raven.capture_exception(e, extra: arguments.first) }

  def perform(year:, month:)
    url = "https://keiba.yahoo.co.jp/schedule/list/#{year}/?month=#{month}"
    scraper = Scraper::Schedule.new(Faraday.get(url).body)
    scraper.scrape!
  end
end
