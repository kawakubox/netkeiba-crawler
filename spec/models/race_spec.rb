require 'rails_helper'

RSpec.describe Race, type: :model do
  subject { Race.new(key: '1505021210') }

  it { is_expected.to be_valid }
  it { is_expected.to be_invalid_on(:key).with(nil) }
  it { is_expected.to be_invalid_on(:key).with('150502121') }
  it { is_expected.to be_invalid_on(:key).with('15050212101') }

  its(:yahoo_race_entry_url) { is_expected.to eq 'https://keiba.yahoo.co.jp/race/denma/1505021210/?page=2' }
end
