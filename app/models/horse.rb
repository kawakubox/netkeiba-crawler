# frozen_string_literal: true

class Horse < ApplicationRecord
  validates :key, presence: true, uniqueness: true, format: /\A\d{10}\Z/

  has_many :horse_results

  def latest_results(date, limit = 5)
    horse_results.joins(race: [:event])
                 .where('events.held_on < ?', date)
                 .order('events.held_on desc')
                 .limit(limit)
  end
end
