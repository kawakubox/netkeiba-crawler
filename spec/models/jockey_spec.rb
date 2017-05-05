# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Jockey, type: :model do
  subject { Jockey.new(key: '12345') }

  it { is_expected.to be_invalid_on(:key).with(nil) }
  it { is_expected.to be_invalid_on(:key).with('1234') }
  it { is_expected.to be_invalid_on(:key).with('123456') }
end
