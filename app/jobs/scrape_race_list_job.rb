# frozen_string_literal: true

class ScrapeRaceListJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) { |e| Raven.capture_exception(e, extra: arguments.first) }

  def perform(event: event)
    Scraper::RaceList.new(event).scrape!
  end
end
