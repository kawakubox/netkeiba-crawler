# frozen_string_literal: true
class Event
  include Neo4j::ActiveNode
  property :key,  type: String, constraint: :unique
  property :date, type: Date
  property :name, type: String

  validates :key,  presence: true
  validates :date, presence: true
  validates :name, presence: true
end
