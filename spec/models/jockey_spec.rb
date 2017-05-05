# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Jockey, type: :model do
  subject { FG.build :jockey }

  it { is_expected.to be_invalid_on(:key).with(nil) }
  it { is_expected.to be_invalid_on(:key).with('1234') }
  it { is_expected.to be_invalid_on(:key).with('123456') }
  context 'when jockey\'s key already stored' do
    let(:jockey) { FG.create :jockey }
    it { is_expected.to be_invalid_on(:key).with(jockey.key) }
  end
end
