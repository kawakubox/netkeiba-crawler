require 'rails_helper'

RSpec.describe Horse, type: :model do
  subject { Horse.new(key: '2012104511') }

  it { is_expected.to be_valid }
  it { is_expected.to be_invalid_on(:key).with(nil) }
  it { is_expected.to be_invalid_on(:key).with('201210451') }
  it { is_expected.to be_invalid_on(:key).with('20121045111') }
end
