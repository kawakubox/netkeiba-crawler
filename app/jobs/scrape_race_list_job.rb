# frozen_string_literal: true

class ScrapeRaceListJob < ApplicationJob
  queue_as :default

  def perform(event: event)
    Scraper::RaceList.new(event).scrape!
  end
end
