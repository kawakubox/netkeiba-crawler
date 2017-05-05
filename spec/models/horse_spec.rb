# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Horse, type: :model do
  subject { FG.build :horse }

  it { is_expected.to be_valid }
  it { is_expected.to be_invalid_on(:key).with(nil) }
  it { is_expected.to be_invalid_on(:key).with(FFaker::String.from_regexp(/\d{9}/)) }
  it { is_expected.to be_invalid_on(:key).with(FFaker::String.from_regexp(/\d{11}/)) }
  context 'when horse key already stored' do
    let(:horse) { FG.create :horse }
    it { is_expected.to be_invalid_on(:key).with(horse.key) }
  end
end
