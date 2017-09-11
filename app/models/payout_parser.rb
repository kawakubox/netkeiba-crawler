# frozen_string_literal: true

class PayoutParser
  def initialize(html)
    @doc = Nokogiri::HTML(html)
  end

  def payout_win
    build_hash(:win, *payout_cells(pay_block.at('tr:has(th.tan)')))
  end

  def payout_place
    build_hash(:place, *payout_cells(pay_block.at('tr:has(th.fuku)')))
  end

  def payout_bracket_quinella
    build_hash(:bracket_quinella, *payout_cells(pay_block.at('tr:has(th.waku)')))
  end

  def payout_quinella
    build_hash(:quinella, *payout_cells(pay_block.at('tr:has(th.uren)')))
  end

  def payout_quinella_place
    build_hash(:quinella_place, *payout_cells(pay_block.at('tr:has(th.wide)')))
  end

  def payout_exacta
    build_hash(:exacta, *payout_cells(pay_block.at('tr:has(th.utan)')))
  end

  def payout_trio
    build_hash(:trio, *payout_cells(pay_block.at('tr:has(th.sanfuku)')))
  end

  def payout_trifecta
    build_hash(:trifecta, *payout_cells(pay_block.at('tr:has(th.santan)')))
  end

  private

  def pay_block
    @doc.at('.pay_block')
  end

  def payout_cells(element)
    (1..3).map do |i|
      next [] if element.nil?
      element.search("td:nth(#{i})").children.map do |e|
        if i == 1
          e.text.split(/[-→]/).map(&:strip).presence
        else
          e.text.delete(',').presence
        end
      end.compact
    end
  end

  def build_hash(bet_type, horse_numbers, payouts, popularities)
    (0...horse_numbers.size).map do |i|
      h = {}
      h[:bet_type] = bet_type
      horse_numbers[i].each.with_index(1) do |num, j|
        key = "number_#{j}"
        h[key.to_sym] = num.to_i
      end
      h[:payout] = payouts[i].to_i
      h[:popularity] = popularities[i].to_i
      h
    end
  end
end
