# frozen_string_literal: true
class Event < ApplicationRecord
  validates :key,  presence: true
  validates :date, presence: true
  validates :name, presence: true
end
