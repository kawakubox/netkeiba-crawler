# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HorseResult do
  subject { FG.build :horse_result }

  it { is_expected.to be_invalid_on(:horse).with(nil) }
  context 'when same horse and race are stored' do
    before do
      obj = FG.create :horse_result
      subject.attributes = { horse: obj.horse, race: obj.race }
    end
    its(:valid?) { is_expected.to be_falsy }
  end

  it { is_expected.to be_invalid_on(:race).with(nil) }
end
