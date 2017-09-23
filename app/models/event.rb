# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :races

  validates :held_on, presence: true, allow_nil: true
  validates :name,    presence: true, allow_nil: true

  def url
    "https://keiba.yahoo.co.jp/race/list/#{id}/"
  end
end
