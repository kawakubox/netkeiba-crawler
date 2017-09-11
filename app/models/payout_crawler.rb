# frozen_string_literal: true

class PayoutCrawler

  # @param [String] url
  def initialize(url)
    @url = url
  end

  # @return [Array<Payout>]
  def crawl
    response = Faraday.get(@url)
    raise StandardError unless response.success?
    parser = PayoutParser.new(response.body.force_encoding('euc-jp'))
    payouts = []
    payouts += parser.payout_win.map { |p| Payout.new(p) }
    payouts += parser.payout_place.map { |p| Payout.new(p) }
    payouts += parser.payout_bracket_quinella.map { |p| Payout.new(p) }
    payouts += parser.payout_quinella.map { |p| Payout.new(p) }
    payouts += parser.payout_quinella_place.map { |p| Payout.new(p) }
    payouts += parser.payout_exacta.map { |p| Payout.new(p) }
    payouts += parser.payout_trio.map { |p| Payout.new(p) }
    payouts += parser.payout_trifecta.map { |p| Payout.new(p) }
    payouts
  end
end
