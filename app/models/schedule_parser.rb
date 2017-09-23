# frozen_string_literal: true

class ScheduleParser
  def initialize(html)
    @doc = Nokogiri::HTML(html)
    @year, @month = schedule_header.text.scan(/(\d+)年(\d+)月/).first.map(&:to_i)
  end

  def events
    rows.map do |e|
      ec = EventRowParser.new(e, year: @year, month: @month)
      Event.find_or_initialize_by(id: ec.key).tap do |ev|
        ev.id = ec.key
        ev.held_on = ec.date
        ev.name = ec.name
      end
    end
  end

  class EventRowParser
    attr_accessor :key, :date, :name
    def initialize(tr, year:, month:)
      @key = tr.at('td:nth(1) a').attr('href').split('/').last
      @year = year
      @month = month
      @day = tr.at('td:nth(1)').child.text.match(/(\d+)日/)[1].to_i
      @date = Date.new(@year, @month, @day)
      @name = tr.at('td:nth(1) a').text.strip
    end
  end

  private

  def schedule_header
    @doc.at('.scheHead h3')
  end

  def rows
    @doc.search('table.scheLs tr:has(td[rowspan] a)')
  end
end
