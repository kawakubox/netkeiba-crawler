# frozen_string_literal: true

class Race < ApplicationRecord
  YAHOO_KEIBA_DOMAIN = 'https://keiba.yahoo.co.jp'

  belongs_to :event
  belongs_to :race_name
  has_many :horse_results

  enum grade: { g1: 1, g2: 2, g3: 3 }
  enum weather: %i[sunny cloudy rainy snowy]
  enum course_condition: %i[good good_to_soft soft heavy]
  enum course_type: %i[turf dirt turf_to_dirt]
  enum kind: %i[flat steeplechase]
  enum direction: %i[right left straight]
  enum circumference: %i[inner outer outer_to_inner]

  validates :key, presence: true, uniqueness: true, format: /\A\d{10}\Z/
  validates :ordinal, allow_nil: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, allow_nil: true, length: { minimum: 1 }
  validates :grade, allow_nil: true, inclusion: { in: Race.grades.keys }
  validates :distance, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 1000 }
  validates :weather, allow_nil: true, inclusion: { in: Race.weathers.keys }
  validates :course_condition, allow_nil: true, inclusion: { in: Race.course_conditions.keys }

  before_validation :create_event

  def number
    key.slice(-2, 2).to_i
  end

  def yahoo_race_entry_url
    URI.join(YAHOO_KEIBA_DOMAIN, "/race/denma/#{key}/?page=2").to_s
  end

  def yahoo_race_result_time_url
    URI.join(YAHOO_KEIBA_DOMAIN, "/race/denma/#{key}/?page=3").to_s
  end

  private

  def create_event
    self.event = Event.find_or_create_by!(key: key[0...8]) unless event_id
  end
end
