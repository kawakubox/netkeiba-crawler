class Race
  include Neo4j::ActiveNode
  include Neo4j::Timestamps

  YAHOO_KEIBA_DOMAIN = 'https://keiba.yahoo.co.jp'

  property :key, type: String

  validates :key, presence: true, format: /\A\d{10}\Z/

  def yahoo_race_entry_url
    URI.join(YAHOO_KEIBA_DOMAIN, "/race/denma/#{key}/?page=2").to_s
  end
end
