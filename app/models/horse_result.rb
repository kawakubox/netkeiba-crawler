# frozen_string_literal: true

class HorseResult < ApplicationRecord
  belongs_to :horse
  belongs_to :race
  belongs_to :jockey,  optional: true
  belongs_to :trainer, optional: true

  counter_culture :race, column_name: :horses_count

  validates :horse_id, presence: true, uniqueness: { scope: :race_id }
  validates :race_id,  presence: true

  delegate :short_name, :distance, to: :race

  def held_on
    race.event.held_on
  end
end
