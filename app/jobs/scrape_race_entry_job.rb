# frozen_string_literal: true

class ScrapeRaceEntryJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) { |e| Raven.capture_exception(e, extra: arguments.first) }

  def perform(race: race)
    Scraper::RaceEntry.new(race.key).scrape!
    sleep(5)
    Scraper::RaceResultTime.new(race.key).scrape!
  end
end
