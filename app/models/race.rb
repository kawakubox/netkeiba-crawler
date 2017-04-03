class Race
  include Neo4j::ActiveNode

  property :key, type: String

  validates :key, presence: true, format: /\A\d{10}\Z/
end
