require 'rails_helper'

RSpec.describe Race, type: :model do
  subject { Race.new(key: '1505021210') }

  it { is_expected.to be_valid }
  it { is_expected.to be_invalid_on(:key).with(nil) }
  it { is_expected.to be_invalid_on(:key).with('150502121') }
  it { is_expected.to be_invalid_on(:key).with('15050212101') }
end
