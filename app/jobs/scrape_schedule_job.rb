# frozen_string_literal: true

class ScrapeScheduleJob < ApplicationJob
  queue_as :default

  rescue_from(StandardError) { |e| Raven.capture_exception(e, extra: arguments.first) }

  # @param [String] date 対象年月 Ex:201709
  def perform(date)
    url = "https://keiba.yahoo.co.jp/schedule/list/#{date[0, 4]}/?month=#{date[4, 2]}"
    parser = ScheduleParser.new(Faraday.get(url).body)
    parser.events.each(&:save!)
  end
end
