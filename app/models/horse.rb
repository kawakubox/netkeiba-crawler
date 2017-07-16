# frozen_string_literal: true

class Horse < ApplicationRecord
  validates :key, presence: true, uniqueness: true, format: /\A[a-z0-9]{10}\Z/

  belongs_to :sire,        optional: true, foreign_key: :sire_id, class_name: :Horse
  belongs_to :mare,        optional: true, foreign_key: :mare_id, class_name: :Horse
  belongs_to :trainer,     optional: true
  has_many :horse_results

  enum sex: %i[male female other]

  def latest_results(date, limit = 5)
    horse_results.includes(:jockey, race: %i[race_name event])
                 .joins(race: [:event])
                 .where('events.held_on < ?', date)
                 .order('events.held_on desc')
                 .limit(limit)
  end

  def netkeiba_url
    "http://db.netkeiba.com/horse/#{key}/"
  end

  def netkeiba_ped_url
    "http://db.netkeiba.com/horse/ped/#{key}/"
  end
end
