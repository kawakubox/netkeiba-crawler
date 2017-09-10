# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PayoutParser do
  let(:html) { html = Rails.root.join('spec/fixtures/html/201005030211_result.html').read; html.force_encoding('euc-jp') }
  subject { PayoutParser.new(html) }

  its(:payout_win) { is_expected.to eq [
    { bet_type: :win, number_1: 17, payout: 210, popularity: 1 },
    { bet_type: :win, number_1: 18, payout: 380, popularity: 5 }
  ] }

  its(:payout_place) { is_expected.to eq [
    { bet_type: :place, number_1: 17, payout: 180, popularity: 1 },
    { bet_type: :place, number_1: 18, payout: 270, popularity: 4 },
    { bet_type: :place, number_1: 2,  payout: 450, popularity: 8 }
  ] }

  its(:payout_bracket_quinella) { is_expected.to eq [
    { bet_type: :bracket_quinella, number_1: 8, number_2: 8, payout: 1750, popularity: 9 }
  ] }

  its(:payout_quinella) { is_expected.to eq [
    { bet_type: :quinella, number_1: 17, number_2: 18, payout: 1870, popularity: 7 }
  ] }

  its(:payout_quinella_place) { is_expected.to eq [
    { bet_type: :quinella_place, number_1: 17, number_2: 18, payout:  900, popularity:  5 },
    { bet_type: :quinella_place, number_1:  2, number_2: 17, payout: 2020, popularity: 24 },
    { bet_type: :quinella_place, number_1:  2, number_2: 18, payout: 2020, popularity: 25 }
  ] }

  its(:payout_exacta) { is_expected.to eq [
    { bet_type: :exacta, number_1: 17, number_2: 18, payout: 1520, popularity:  5 },
    { bet_type: :exacta, number_1: 18, number_2: 17, payout: 2020, popularity: 14 }
  ] }

  its(:payout_trio) { is_expected.to eq [
    { bet_type: :trio, number_1: 2, number_2: 17, number_3: 18, payout: 10180, popularity: 28 }
  ] }

  its(:payout_trifecta) { is_expected.to eq [
    { bet_type: :trifecta, number_1: 17, number_2: 18, number_3: 2, payout: 20460, popularity: 101 },
    { bet_type: :trifecta, number_1: 18, number_2: 17, number_3: 2, payout: 24290, popularity: 127 }
  ] }
end
