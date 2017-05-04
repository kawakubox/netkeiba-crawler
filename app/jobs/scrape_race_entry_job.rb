# frozen_string_literal: true

class ScrapeRaceEntryJob < ApplicationJob
  queue_as :default

  def perform(race_id)
    race = Race.find_or_create_by!(key: race_id)
    html = Faraday.get(race.yahoo_race_entry_url).body
    scraper = Scraper::RaceEntry.new(html)
    scraper.scrape.each(&:save)
  end
end
