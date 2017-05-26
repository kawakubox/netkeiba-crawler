# frozen_string_literal: true

class Trainer < ApplicationRecord
  validates :key, presence: true, uniqueness: true, format: /\A[0-9]{5}\Z/
end
