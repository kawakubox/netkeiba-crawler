# frozen_string_literal: true

class ScrapeHorseJob < ApplicationJob
  def perform(horse: horse)
    Scraper::Horse.new(horse.key).scrape!
    Scraper::HorsePedigreeTable.new(horse.key).scrape!
  end
end
