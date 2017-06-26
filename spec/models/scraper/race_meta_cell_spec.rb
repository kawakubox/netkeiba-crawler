# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scraper::RaceMetaCell do
  let(:html) do
    <<~HTML
      <div id="raceTitName">
      <p id="raceTitDay" class="fntSS">2015年5月31日（日） <span>|</span> 2回東京12日 <span>|</span> 15:40発走</p>
      <h1 class="fntB">
      第82回東京優駿（GI）</h1>
      <p id="raceTitMeta" class="fntSS gryB">芝・左 2400m <span>|</span> 天気：<img src="https://s.yimg.jp/images/clear.gif" class="spBg hare" width="15" height="15" border="0" alt="晴"> <span>|</span> 馬場：<img src="https://s.yimg.jp/images/clear.gif" class="spBg ryou" width="25" height="15" border="0" alt="良"> <span>|</span> サラ系3歳 <span>|</span> オープン （国際） 牡・牝 （指定） 定量 <span>|</span> 本賞金：20000、8000、5000、3000、2000万円 <span>|</span> 
      </p></div>
    HTML
  end

  subject { Scraper::RaceMetaCell.new(html) }

  describe '#ordinal' do
    its(:ordinal) { is_expected.to eq 82 }
    context 'when non-ordinal' do
      let(:html) { '<div id="raceTitName"><h1>富嶽賞</h1></div>' }
      its(:ordinal) { is_expected.to be_nil }
    end
  end

  describe '#name' do
    its(:name) { is_expected.to eq '東京優駿' }
  end

  describe '#grade' do
    its(:grade) { is_expected.to eq :g1 }
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

  describe '#course_type' do
    context 'when 芝→ダート' do
      let(:html) { '<p id="raceTitMeta">障害・芝→ダート 2910m <span>|</span></p>' }
      its(:course_type) { is_expected.to eq :turf_to_dirt }
    end
    context 'when 芝' do
      let(:html) { '<p id="raceTitMeta">芝・右・外 1600m <span>|</span></p>' }
      its(:course_type) { is_expected.to eq :turf }
    end
    context 'when ダート' do
      let(:html) { '<p id="raceTitMeta">ダート・左 1600m <span>|</span></p>' }
      its(:course_type) { is_expected.to eq :dirt }
    end
  end

  describe '#distance' do
    its(:distance) { is_expected.to eq 2400 }
  end

  describe '#weather' do
    its(:weather) { is_expected.to eq :sunny }
    context 'when kumori' do
      let(:html) { '<p id="raceTitMeta"><img src="https://s.yimg.jp/images/clear.gif" class="spBg kumori" alt="曇" /></p>' }
      its(:weather) { is_expected.to eq :cloudy }
    end
    context 'when ame' do
      let(:html) { '<p id="raceTitMeta"><img src="https://s.yimg.jp/images/clear.gif" class="spBg ame" alt="雨" /></p>' }
      its(:weather) { is_expected.to eq :rainy }
    end
    context 'when yuki' do
      let(:html) { '<p id="raceTitMeta"><img src="https://s.yimg.jp/images/clear.gif" class="spBg yuki" "雪" /></p>' }
      its(:weather) { is_expected.to eq :snowy }
    end
  end

  describe '#course_condition' do
    its(:course_condition) { is_expected.to eq :good }
  end
end
