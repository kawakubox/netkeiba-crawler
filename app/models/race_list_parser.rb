# frozen_string_literal: true

class RaceListParser
  def initialize(html)
    @doc = Nokogiri::HTML(html)
  end

  def races
    rows.map do |tr|
      e = tr.at('td a')
      key = e.attr('href').match(%r{/race/result/(\d{10})/})[1]
      Race.find_or_initialize_by(id: key) do |race|
        race.event = @event
        race.name = e.text.strip
        race.race_name = RaceName.find_or_create_by!(long_name: e.text.strip)
      end
    end
  end

  private

  def rows
    @doc.search('table.scheLs tr[has(td:nth(2))]')
  end
end
