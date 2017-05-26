FactoryGirl.define do
  factory :trainer do
    key { FFaker::String.from_regexp /\d{5}/ }
    name { %w(野平祐二 大久保正 池江泰郎 池江泰寿 松本省一 石坂正).sample }
  end
end
