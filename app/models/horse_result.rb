# frozen_string_literal: true

class HorseResult < ApplicationRecord
  belongs_to :horse
  belongs_to :race
  belongs_to :jockey
  belongs_to :trainer

  validates :horse_id, presence: true, uniqueness: { scope: :race_id }
  validates :race_id,  presence: true
end
