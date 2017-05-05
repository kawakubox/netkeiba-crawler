# frozen_string_literal: true

class Jockey < ApplicationRecord
  validates :key, presence: true, format: /[0-9]{5}/
end
