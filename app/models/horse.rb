class Horse 
  include Neo4j::ActiveNode
  property :key, type: String
  property :name, type: String
end
