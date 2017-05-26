# frozen_string_literal: true

class Horse < ApplicationRecord
  validates :key, presence: true, format: /\A\d{10}\Z/
end
