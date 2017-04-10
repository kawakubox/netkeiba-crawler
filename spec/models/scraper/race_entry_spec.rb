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
    )
  end

  describe '#ordinal' do
    its(:ordinal) { is_expected.to eq 82 }
    context 'when non-ordinal' do
      let(:html) { '<div id="raceTitName"><h1>富嶽賞</h1></div>' }
      its(:ordinal) { is_expected.to be_nil }
    end
  end

  describe '#name' do
    its(:name) { is_expected.to eq '東京優駿' }
    context 'when non-ordinal' do
      let(:html) { '<div id="raceTitName"><h1>富嶽賞</h1></div>' }
      its(:name) { is_expected.to eq '富嶽賞'}
    end
  end

  describe '#grade' do
    its(:grade) { is_expected.to eq Race.grades[:g1] }
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
end
