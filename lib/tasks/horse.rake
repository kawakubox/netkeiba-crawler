# frozen_string_literal: true

namespace :horse do
  desc '馬成績の出走順カラムを並び替えて埋める'
  task :rearrange_order => :environment do
    Horse.all.find_each do |h|
      HorseResult.joins(race: :event).where(horse: h).order('events.held_on ASC').each.with_index(1) do |hr, i|
        hr.update!(order_of_race: i) 
      end
    end
  end
end
