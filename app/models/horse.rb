# frozen_string_literal: true

class Horse < ApplicationRecord
  validates :key, presence: true, uniqueness: true, format: /\A[a-z0-9]{10}\Z/

  belongs_to :sire,    foreign_key: :sire_id, class_name: :Horse
  belongs_to :mare,    foreign_key: :mare_id, class_name: :Horse
  belongs_to :trainer
  has_many :horse_results

  def latest_results(date, limit = 5)
    horse_results.joins(race: [:event])
                 .where('events.held_on < ?', date)
                 .order('events.held_on desc')
                 .limit(limit)
  end
end
