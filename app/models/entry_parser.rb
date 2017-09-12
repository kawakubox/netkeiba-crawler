# frozen_string_literal: true

class EntryParser
  attr_reader :doc

  def initialize(html)
    @doc = Nokogiri::HTML(html)
  end

  def entries
    rows.map do |row|
      parser = EntryRowParser.new(row)
      HorseResult.new(
        horse:         parser.horse,
        jockey:        parser.jockey,
        trainer:       parser.trainer,
        jockey_weight: parser.jockey_weight,
        horse_weight:  parser.horse_weight[0],
        weight_diff:   parser.horse_weight[1],
        gate_number:   parser.gate_number,
        horse_number:  parser.horse_number,
        popularity:    parser.popularity
      )
    end
  end

  private

  def race_table
    @race_table ||= @doc.at('.race_table_old')
  end

  def rows
    race_table.search('tr.bml1')
  end
end
