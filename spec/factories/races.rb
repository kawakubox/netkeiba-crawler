# frozen_string_literal: true

FactoryGirl.define do
  factory :race do
    event
    id { FFaker::String.from_regexp /\d{12}/ }
    ordinal Random.rand(1..100)
    name { %w[皐月賞 東京優駿 菊花賞 桜花賞 優駿牝馬 天皇賞(春) 天皇賞(秋) 有馬記念].sample }
    grade { [nil, :g1, :g2, :g3].sample }
    kind { %i[flat steeplechase].sample }
    direction { %i[right left straight].sample }
    circumference { [nil, :outer, :outer_to_inner].sample }
    course_type { %i[turf dirt turf_to_dirt].sample }
    distance { [1000, 1200, 1600, 1800, 2000, 2400, 3000, 3200].sample }
    weather { %i[sunny cloudy rainy snowy].sample }
    course_condition { %i[good good_to_soft soft heavy].sample }
  end
end
