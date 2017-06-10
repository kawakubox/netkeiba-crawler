# frozen_string_literal: true

class ScrapeRaceEntryJob < ApplicationJob
  queue_as :default

  def perform(race: race)
    Scraper::RaceEntry.new(race.key).scrape!
  end
end
