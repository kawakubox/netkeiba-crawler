class Horse 
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  property :key, type: String
  property :name, type: String
  property :birthday, type: Date

  validates :key, presence: true, format: /\A\d{10}\Z/

end
