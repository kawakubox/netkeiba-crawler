# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scraper::RaceEntry do
  subject { Scraper::RaceEntry.new(html) }

  let(:html) { File.read(File.join(Rails.root, 'spec/fixtures/html/race_entry.html')) }

  its(:race_key) { is_expected.to eq '1505021210' }
  its(:race) do
    is_expected.to be_instance_of Race
    is_expected.to have_attributes(
      key: '1505021210',
      ordinal: 82,
      name: '東京優駿',
      grade: :g1,
      distance: 2400,
      weather: :sunny,
    )
  end

  describe '#ordinal' do
    context 'when non-ordinal' do
      let(:html) { '<div id="raceTitName"><h1>富嶽賞</h1></div>' }
      its(:ordinal) { is_expected.to be_nil }
    end
  end

  describe '#name' do
    context 'when non-ordinal' do
      let(:html) { '<div id="raceTitName"><h1>富嶽賞</h1></div>' }
      its(:name) { is_expected.to eq '富嶽賞'}
    end
  end

  describe '#grade' do
    context 'when G2' do
      let(:html) { '<div id="raceTitName"><h1>第129回目黒記念（GII）</h1><div>' }
      its(:grade) { is_expected.to eq :g2 }
    end
    context 'when G3' do
      let(:html) { '<div id="raceTitName"><h1>第1回ラジオNIKKEI杯京都2歳ステークス（GIII）</h1></div>' }
      its(:grade) { is_expected.to eq :g3 }
    end
    context 'when non-grade' do
      let(:html) { '<div id="raceTitName"><h1>富嶽賞</h1></div>' }
      its(:grade) { is_expected.to be_nil }
    end
  end
  
  describe '#weather' do
    context 'when kumori' do
      let(:html) { '<img src="https://s.yimg.jp/images/clear.gif" class="spBg kumori" alt="曇" />' }
      its(:weather) { is_expected.to eq :cloudy }
    end
    context 'when ame' do
      let(:html) { '<img src="https://s.yimg.jp/images/clear.gif" class="spBg ame" alt="雨" />' }
      its(:weather) { is_expected.to eq :rainy }
    end
    context 'when yuki' do
      let(:html) { '<img src="https://s.yimg.jp/images/clear.gif" class="spBg yuki" "雪" />' }
      its(:weather) { is_expected.to eq :snowy }
    end
  end
end
