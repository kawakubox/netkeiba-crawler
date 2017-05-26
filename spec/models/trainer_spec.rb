require 'rails_helper'

RSpec.describe Trainer, type: :model do
  subject { FG.build :trainer }

  it { is_expected.to be_invalid_on(:key).with(nil) }
  it { is_expected.to be_invalid_on(:key).with('1234') }
  it { is_expected.to be_invalid_on(:key).with('123456') }
  context 'when trainer key already stored' do
    let(:trainer) { FG.create :trainer }
    it { is_expected.to be_invalid_on(:key).with(trainer.key) }
  end
end
