class Race
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  YAHOO_KEIBA_DOMAIN = 'https://keiba.yahoo.co.jp'

  property :key, type: String
  property :ordinal, type: Integer
  property :name, type: String
  enum grade: { g1: 1, g2: 2, g3: 3 }
  property :distance, type: Integer
  enum weather: %i(sunny cloudy rainny snowy)
  enum course_condition: %i(good good_to_soft soft heavy)

  validates :key, presence: true, format: /\A\d{10}\Z/
  validates :ordinal, allow_nil: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true
  validates :grade, allow_nil: true, inclusion: { in: Race.grades.keys }
  validates :distance, numericality: { only_integer: true, greater_than_or_equal_to: 1000 }
  validates :weather, allow_nil: true, inclusion: { in: Race.weathers.keys }
  validates :course_condition, allow_nil: true, inclusion: { in: Race.course_conditions.keys }

  def yahoo_race_entry_url
    URI.join(YAHOO_KEIBA_DOMAIN, "/race/denma/#{key}/?page=2").to_s
  end
end
