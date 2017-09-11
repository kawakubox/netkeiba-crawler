# frozen_string_literal: true

class Payout < ApplicationRecord
  belongs_to :race

  enum bet_type: %i[win place bracket_quinella quinella quinella_place exacta trio trifecta]
end
