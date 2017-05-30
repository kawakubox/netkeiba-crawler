# frozen_string_literal: true

class Race < ApplicationRecord
  YAHOO_KEIBA_DOMAIN = 'https://keiba.yahoo.co.jp'

  enum grade: { g1: 1, g2: 2, g3: 3 }
  enum weather: %i[sunny cloudy rainy snowy]
  enum course_condition: %i[good good_to_soft soft heavy]

  validates :key, presence: true, uniqueness: true, format: /\A\d{10}\Z/
  validates :ordinal, allow_nil: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, allow_nil: true, length: { minimum: 1 }
  validates :grade, allow_nil: true, inclusion: { in: Race.grades.keys }
  validates :distance, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 1000 }
  validates :weather, allow_nil: true, inclusion: { in: Race.weathers.keys }
  validates :course_condition, allow_nil: true, inclusion: { in: Race.course_conditions.keys }

  def yahoo_race_entry_url
    URI.join(YAHOO_KEIBA_DOMAIN, "/race/denma/#{key}/?page=2").to_s
  end

  def yahoo_race_result_time_url
    URI.join(YAHOO_KEIBA_DOMAIN, "/race/denma/#{key}/?page=3").to_s
  end
end
