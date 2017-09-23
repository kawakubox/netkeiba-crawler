# frozen_string_literal: true

class ScrapeRaceListJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) { |e| Raven.capture_exception(e, extra: arguments.first) }

  # @param [String] event_id
  def perform(event_id)
    event = Event.find(event_id)
    res = Faraday.get(event.url)
    raise "#{res.status} : #{res.reason_phrase}" unless res.success?
    RaceListParser.new(res.body).races.map(&:save!)
  end
end
