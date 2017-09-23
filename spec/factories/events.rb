# frozen_string_literal: true

FactoryGirl.define do
  factory :event do
    id { FFaker::String.from_regexp /\d{8}/ }
    held_on { Time.zone.today }
    name do
      n = Random.rand(1..5)
      m = Random.rand(1..12)
      p = %w[東京 中山 京都 阪神].sample
      "#{n}回#{p}#{m}日"
    end
  end
end
