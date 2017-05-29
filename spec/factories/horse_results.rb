# frozen_string_literal: true

FactoryGirl.define do
  factory :horse_result do
    horse
    race
    jockey
    trainer
  end
end 
