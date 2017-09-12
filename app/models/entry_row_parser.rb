# frozen_string_literal: true

class EntryRowParser
  attr_reader :doc

  def initialize(html)
    @doc = case html
           when Nokogiri::XML::Element
             html
           when String
             Nokogiri::HTML(html)
           else
             raise '想定外の型'
           end
  end

  def gate_number
    @doc.at('td:nth(1)').text.to_i
  end

  def horse_number
    @doc.at('td:nth(2)').text.to_i
  end

  def horse
    url   = @doc.at('td.horsename a').attr('href')
    title = @doc.at('td.horsename a').attr('title')
    key   = url.split('/').last
    Horse.find_or_create_by!(id: key) do |h|
      h.name = title
      h.key = key
    end
  end

  # <diary_snap_cut> が悪さをしていて1ずれる
  def sex
    case @doc.at('td:nth(4)').text[0]
    when '牡' then :male
    when '牝' then :female
    when 'セ' then :other
    else raise '想定外な性別'
    end
  end

  def age
    @doc.at('td:nth(4)').text.slice(1..-1).to_i
  end

  def jockey_weight
    @doc.at('td:nth(5)').text.to_f
  end

  def jockey
    url  = @doc.at('td:nth(6) a').attr('href')
    name = @doc.at('td:nth(6) a').attr('title')
    key  = url.split('/').last
    Jockey.find_or_create_by!(id: key) do |j|
      j.key = key
      j.name = name
    end
  end

  def trainer
    url  = @doc.at('td:nth(7) a').attr('href')
    name = @doc.at('td:nth(7) a').attr('title')
    key  = url.split('/').last
    Trainer.find_or_create_by!(id: key) do |t|
      t.key = key
      t.name = name
    end
  end

  # @return [Array<Integer>] [馬体重, 馬体重増減]
  def horse_weight
    @doc.at('td:nth(8)').text.scan(/(\d+{3})\((.+)\)/).first.map { |v| v.presence&.to_i }
  end

  def popularity
    @doc.at('td:nth(10)').text.to_i
  end
end
