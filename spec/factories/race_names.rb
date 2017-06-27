FactoryGirl.define do
  factory :race_name do
    long_name { %w[サラ系3歳未勝利 サラ系4歳上500万円以下 青嵐賞 むらさき賞 東京優駿 目黒記念].sample }
  end
end
