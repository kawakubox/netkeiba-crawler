# frozen_string_literal: true

class RaceEntry < ApplicationRecord
  belongs_to :race
  belongs_to :horse
  belongs_to :result_1, class_name: :HorseResult, foreign_key: :result_1_id
  belongs_to :result_2, class_name: :HorseResult, foreign_key: :result_2_id
  belongs_to :result_3, class_name: :HorseResult, foreign_key: :result_3_id
  belongs_to :result_4, class_name: :HorseResult, foreign_key: :result_4_id
  belongs_to :result_5, class_name: :HorseResult, foreign_key: :result_5_id
end
