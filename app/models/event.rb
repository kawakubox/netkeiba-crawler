# frozen_string_literal: true
class Event < ApplicationRecord
  validates :key,     presence: true, uniqueness: true
  validates :held_on, presence: true
  validates :name,    presence: true
end
