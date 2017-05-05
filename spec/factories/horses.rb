FactoryGirl.define do
  factory :horse do
    key { FFaker::String.from_regexp /\d{10}/ }
    name { %w(セントライト シンザン ミスターシービー シンボリルドルフ ナリタブライアン ディープインパクト オルフェーブル メジロラモーヌ スティルインラブ アパパネ ジェンティルドンナ).sample }
    birthday Date.today
  end
end
