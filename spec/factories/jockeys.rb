# frozen_string_literal: true

FactoryGirl.define do
  factory :jockey do
    key { FFaker::String.from_regexp /\d{5}/ }
    name { %w[岡部幸雄 南井克巳 武豊 池添謙一 幸英明 岩田康誠].sample }
  end
end
