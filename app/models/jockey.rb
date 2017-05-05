# frozen_string_literal: true

class Jockey < ApplicationRecord
  validates :key, presence: true, uniqueness: true, format: /\A\d{5}\Z/
end
