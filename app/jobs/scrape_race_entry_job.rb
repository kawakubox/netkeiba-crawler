# frozen_string_literal: true

class ScrapeRaceEntryJob < ApplicationJob
  queue_as :default

  def perform(race_id)
    Scraper::RaceEntry.new(race_id).scrape!
  end
end
